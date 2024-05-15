package org.example.fashion_api.Services.CategoryService;

import com.fasterxml.jackson.core.JsonProcessingException;
import jakarta.transaction.Transactional;
import org.example.fashion_api.Exception.AlreadyExistException;
import org.example.fashion_api.Exception.NotFoundException;
import org.example.fashion_api.Models.Categories.Category;
import org.example.fashion_api.Models.Categories.CategoryDto;
import org.example.fashion_api.Mapper.CategoryMapper;
import org.example.fashion_api.Models.Categories.CategoryRes;
import org.example.fashion_api.Repositories.CategoryRepo;
import org.example.fashion_api.Services.CloudinaryService;
import org.example.fashion_api.Services.RedisService.RedisService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.util.List;
import java.util.Map;
import java.util.Objects;

@Service
public class CategoryServiceImpl implements CategoryService {
    @Autowired
    private CategoryRepo categoryRepo;
    @Autowired
    private CategoryMapper categoryMapper;
    @Autowired
    private CloudinaryService cloudinaryService;
    @Autowired
    private RedisService redisService;


    @Override
    public List<CategoryRes> findAll() throws JsonProcessingException {
        String redisKey = "categoryRepo.findAll() - categories";
        List<Category> categories = redisService.getListRedis(redisKey, Category.class);

        if (categories == null) {
            categories = categoryRepo.findAll();
            redisService.saveRedis(redisKey, categories);
        }

        return categoryMapper.toDtoList(categories);
    }

    @Override
    @Transactional
    public CategoryRes save(Long catId, CategoryDto categoryDto) {

        Category currentCategory = categoryRepo.findById(catId).orElseThrow(() -> new NotFoundException(catId.toString()));

        if (!Objects.equals(categoryDto.getCategoryCode(), currentCategory.getCategoryCode())
                && categoryRepo.existsByCategoryCode(categoryDto.getCategoryCode())) {
            throw new AlreadyExistException(categoryDto.getCategoryCode());
        } else if (!Objects.equals(categoryDto.getCatName(), currentCategory.getCatName()) && categoryRepo.existsByCatName(categoryDto.getCatName())) {
            throw new AlreadyExistException(categoryDto.getCatName());
        }

        Category category = categoryMapper.categoryDtoToCategory(categoryDto, new Category());

        categoryRepo.save(category);

        return categoryMapper.categoryToCategoryRes(currentCategory);
    }

    @Override
    public void delete(Long catId) throws IOException {
        Category category = categoryRepo.findById(catId).orElseThrow(() -> new NotFoundException(catId.toString()));
        categoryRepo.delete(category);
        cloudinaryService.deleteImageByUrl(category.getCatBackground());
    }

    @Override
    public CategoryRes findById(Long catId) {
        return categoryMapper.categoryToCategoryRes(categoryRepo.findById(catId).orElseThrow(() -> new NotFoundException(
                "Category")));
    }

    @Override
    public CategoryRes addCategory(CategoryDto categoryDto) {
        if (categoryRepo.existsByCategoryCode(categoryDto.getCategoryCode())) {
            throw new AlreadyExistException(categoryDto.getCategoryCode());
        } else if (categoryRepo.existsByCatName(categoryDto.getCatName())) {
            throw new AlreadyExistException(categoryDto.getCatName());
        }

        Category category= categoryRepo.save(categoryMapper.categoryDtoToCategory(categoryDto, new Category()));

        return categoryMapper.categoryToCategoryRes(category);

    }

    @Override
    @Transactional
    public String updateCatBackground(MultipartFile file, Long catId) throws IOException {
        Category category = categoryRepo.findById(catId).orElseThrow(() -> new NotFoundException(catId.toString()));

        cloudinaryService.deleteImageByUrl(category.getCatBackground());

        Map<String, Object> uploadResult = cloudinaryService.upload(file);

        String imageUrl = uploadResult.get("secure_url").toString();
        categoryRepo.updateCatBackground(imageUrl, catId);
        return imageUrl;
    }

    @Override
    public List<CategoryRes> childCategories(Long catParentId) throws JsonProcessingException {
        String redisKey = "childCategories("+catParentId+") - category";
        List<Category> categories = redisService.getListRedis(redisKey, Category.class);
        if (categories == null){

            List<Category> childCategories;

            if (catParentId != null) {
                childCategories = categoryRepo.findAllByCatParentId(catParentId);

            } else {
                childCategories = categoryRepo.findAllByCatParentId(null);
            }
            redisService.saveRedis(redisKey, childCategories);
            return categoryMapper.toDtoList(childCategories);
        }

        return categoryMapper.toDtoList(categories);


    }

    @Override
    public List<Category> CatDescendants(Long id, List<Category> allCategory) {
        List<Category> categories = categoryRepo.findAllByCatParentId(id);
        for (Category child : categories) {
            allCategory.add(child);
            CatDescendants(child.getId(), allCategory);
        }
        return allCategory;
    }


}

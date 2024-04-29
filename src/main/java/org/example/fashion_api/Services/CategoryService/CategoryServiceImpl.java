package org.example.fashion_api.Services.CategoryService;

import com.fasterxml.jackson.core.JsonProcessingException;
import jakarta.transaction.Transactional;
import org.example.fashion_api.Exception.AlreadyExistException;
import org.example.fashion_api.Exception.NotFoundException;
import org.example.fashion_api.Models.Category.Category;
import org.example.fashion_api.Models.Category.CategoryDto;
import org.example.fashion_api.Models.Category.CategoryMapper;
import org.example.fashion_api.Repositories.CategoryRepo;
import org.example.fashion_api.Services.CloudinaryService;
import org.example.fashion_api.Services.RedisService.RedisService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
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
    public List<CategoryDto> findAll() throws JsonProcessingException {

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
    public CategoryDto save(String catId, CategoryDto categoryDto) {

        Category currentCategory = categoryRepo.findById(catId).orElseThrow(() -> new NotFoundException(catId));

        if (!Objects.equals(categoryDto.getCatId(), catId) && categoryRepo.existsById(categoryDto.getCatId())) {
            throw new AlreadyExistException(categoryDto.getCatId());
        } else if (!Objects.equals(categoryDto.getCatName(), currentCategory.getCatName()) && categoryRepo.existsByCatName(categoryDto.getCatName())) {
            throw new AlreadyExistException(categoryDto.getCatName());
        }


        Category category = categoryMapper.categoryDtoToCategory(categoryDto, currentCategory);
        if (categoryDto.getCatParent() == null) {
            category.setCatParent(null);
        }

        categoryRepo.save(category);

        return categoryMapper.categoryToCategoryDto(currentCategory);
    }

    @Override
    public void delete(String catId) throws IOException {
        Category category = categoryRepo.findById(catId).orElseThrow(() -> new NotFoundException(catId));
        categoryRepo.delete(category);
        cloudinaryService.deleteImageByUrl(category.getCatBackground());
    }

    @Override
    public CategoryDto findById(String catId) {
        return categoryMapper.categoryToCategoryDto(categoryRepo.findById(catId).orElseThrow(() -> new NotFoundException("Category")));
    }

    @Override
    public CategoryDto addCategory(CategoryDto categoryDto) {
        if (categoryRepo.existsById(categoryDto.getCatId())) {
            throw new AlreadyExistException(categoryDto.getCatId());
        } else if (categoryRepo.existsByCatName(categoryDto.getCatName())) {
            throw new AlreadyExistException(categoryDto.getCatName());
        }

        Category category = categoryMapper.categoryDtoToCategory(categoryDto, new Category());
        if (categoryDto.getCatParent() == null) {
            category.setCatParent(null);
        }
        categoryRepo.save(category);
        return categoryDto;

    }

    @Override
    @Transactional
    public ResponseEntity<String> updateCatBackground(MultipartFile file, String catId) throws IOException {
        Category category = categoryRepo.findById(catId).orElseThrow(() -> new NotFoundException(catId));

        cloudinaryService.deleteImageByUrl(category.getCatBackground());

        Map<String, Object> uploadResult = cloudinaryService.upload(file);

        String imageUrl = uploadResult.get("secure_url").toString();
        categoryRepo.updateCatBackground(imageUrl, catId);
        return ResponseEntity.ok(imageUrl);
    }

    @Override
    public List<CategoryDto> childCategories(String catParentId) throws JsonProcessingException {
        String redisKey = "childCategories("+catParentId+") - category";
        List<Category> categories = redisService.getListRedis(redisKey, Category.class);
        if (categories == null){

            List<Category> childCategories;

            if (!catParentId.isEmpty()) {
                childCategories = categoryRepo.findAllByCatParentCatId(catParentId);

            } else {
                childCategories = categoryRepo.findAllByCatParentCatId(null);
            }
            redisService.saveRedis(redisKey, childCategories);
            return categoryMapper.toDtoList(childCategories);
        }

        return categoryMapper.toDtoList(categories);


    }

    @Override
    public void CatDescendants(String catId, List<Category> allCategory) {
        List<Category> categories = categoryRepo.findAllByCatParentCatId(catId);
        for (Category child : categories) {
            allCategory.add(child);
            CatDescendants(child.getCatId(), allCategory);
        }
    }
}

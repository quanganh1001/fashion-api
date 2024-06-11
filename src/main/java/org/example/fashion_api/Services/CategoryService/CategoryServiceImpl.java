package org.example.fashion_api.Services.CategoryService;

import com.fasterxml.jackson.core.JsonProcessingException;
import jakarta.transaction.Transactional;
import org.example.fashion_api.Exception.AlreadyExistException;
import org.example.fashion_api.Exception.BadRequestException;
import org.example.fashion_api.Exception.NotFoundException;
import org.example.fashion_api.Models.Categories.Category;
import org.example.fashion_api.Models.Categories.CreateCategoryDto;
import org.example.fashion_api.Mapper.CategoryMapper;
import org.example.fashion_api.Models.Categories.CategoryRes;
import org.example.fashion_api.Models.Categories.UpdateCategoryDto;
import org.example.fashion_api.Repositories.CategoryRepo;
import org.example.fashion_api.Services.CloudinaryService;
import org.example.fashion_api.Services.RedisService.RedisService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.util.*;

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

        //get redis
        List<CategoryRes> categories = redisService.getListRedis(redisKey, CategoryRes.class);

        // if redis with redis key = null -> create redis
        if (categories == null) {
            categories = categoryMapper.toDtoList(categoryRepo.findAll());
            redisService.saveRedis(redisKey, categories);
        }

        return categories;
    }

    @Override
    @Transactional
    public CategoryRes save(Long catId, UpdateCategoryDto updateCategoryDto) throws IOException {

        Category currentCategory = categoryRepo.findById(catId).orElseThrow(() -> new NotFoundException(catId.toString()));

        //check exist by category code and category name
        if (!Objects.equals(updateCategoryDto.getCategoryCode(), currentCategory.getCategoryCode())
                && categoryRepo.existsByCategoryCode(updateCategoryDto.getCategoryCode())) {
            throw new AlreadyExistException(updateCategoryDto.getCategoryCode());
        }

        currentCategory = categoryMapper.updateCategoryDtoToCategory(updateCategoryDto, currentCategory);

        Category category = categoryRepo.save(currentCategory);

        return categoryMapper.categoryToCategoryRes(category);
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
    public CategoryRes addCategory(CreateCategoryDto createCategoryDto) {

        //check exist by category code and category name
        if (categoryRepo.existsByCategoryCode(createCategoryDto.getCategoryCode())) {

            throw new AlreadyExistException(createCategoryDto.getCategoryCode());

        }

        Category category = categoryMapper.createCategoryDtoToCategory(createCategoryDto, new Category());
        if (createCategoryDto.getCatParent() == null) {
            category.setCatParent(null);
        }

        Category newCategory = categoryRepo.save(category);

        return categoryMapper.categoryToCategoryRes(newCategory);

    }

    @Override
    @Transactional
    public String updateCatBackground(MultipartFile file, Long catId) throws IOException {
        Category category = categoryRepo.findById(catId).orElseThrow(() -> new NotFoundException(catId.toString()));

        cloudinaryService.deleteImageByUrl(category.getCatBackground());

        Map<String, Object> uploadResult = cloudinaryService.upload(file);

        String imageUrl = uploadResult.get("secure_url").toString();

        categoryRepo.updateCatBackground(imageUrl, catId);

        // delete cache redis
        redisService.clear();

        return imageUrl;
    }

    @Override
    public List<CategoryRes> childCategories(Long catParentId) throws JsonProcessingException {

        String redisKey = "childCategories("+catParentId+") - category";

        //get redis
        List<CategoryRes> categoriesRes = redisService.getListRedis(redisKey, CategoryRes.class);

        // if redis with redis key = null -> create redis
        if (categoriesRes == null){

            List<Category> childCategories;

            if (catParentId != null) {
                childCategories = categoryRepo.findAllByCatParentId(catParentId);

            } else {
                childCategories = categoryRepo.findAllByCatParentId(null);
            }

            categoriesRes = categoryMapper.toDtoList(childCategories);

            redisService.saveRedis(redisKey, categoriesRes);

            return categoriesRes;
        }

        return categoriesRes;


    }

    @Override
    public List<CategoryRes> CatDescendants(Long id, List<CategoryRes> allCategory) throws JsonProcessingException {

        List<CategoryRes> categories = childCategories(id);
        // get all child category of child category
        for (CategoryRes child : categories) {
            allCategory.add(child);
            CatDescendants(child.getId(), allCategory);
        }
        return allCategory;
    }


}

package org.example.fashion_api.Services.CategoryService;

import jakarta.transaction.Transactional;
import org.example.fashion_api.Exception.NotFoundException;
import org.example.fashion_api.Models.Category.Category;
import org.example.fashion_api.Models.Category.CategoryDto;
import org.example.fashion_api.Models.Category.CategoryMapper;
import org.example.fashion_api.Models.Category.CategoryRes;
import org.example.fashion_api.Repositories.CategoryRepo;
import org.hibernate.service.spi.ServiceException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class CategoryServiceImpl implements CategoryService {
    @Autowired
    private CategoryRepo categoryRepo;
    @Autowired
    private CategoryMapper categoryMapper;

    @Override
    public List<CategoryDto> findAll() {
        return categoryMapper.toDtoList(categoryRepo.findAll());
    }

    @Override
    @Transactional
    public CategoryRes save(String catId, CategoryDto categoryDto) {
        // Chuyển đổi CategoryDto thành Category và lưu vào cơ sở dữ liệu
        Category currentCategory = categoryRepo.findById(catId).orElseThrow(() -> new NotFoundException(catId));

        Category savedCategory = categoryRepo.save(categoryMapper.categoryDtoToCategory(categoryDto,currentCategory));

        // Chuyển đổi lại Category đã lưu thành CategoryDto và trả về
        return categoryMapper.categoryToCategoryRes(savedCategory);
    }

    @Override
    public void delete(String catId) {
        try {
            categoryRepo.deleteById(catId);
        }catch (NotFoundException e){
            throw new NotFoundException("Category");
        }catch (Exception e){
            throw new ServiceException(e.getMessage());
        }

    }

    @Override
    public Category findById(String catId){
        return categoryRepo.findById(catId).orElseThrow(() -> new NotFoundException("Category"));
    }
}

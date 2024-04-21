package org.example.fashion_api.Services.CategoryService;

import jakarta.persistence.Cacheable;
import org.example.fashion_api.Exception.NotFoundException;
import org.example.fashion_api.Models.Category.Category;
import org.example.fashion_api.Models.Category.CategoryDTO;
import org.example.fashion_api.Repositories.CategoryRepo;
import org.hibernate.service.spi.ServiceException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class CategoryServiceImpl implements CategoryService {
    @Autowired
    private CategoryRepo categoryRepo;


    @Override
    public List<Category> findAll() {
        return categoryRepo.findAll();
    }

    @Override
    public List<Category> save(CategoryDTO category) {
        return List.of();
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

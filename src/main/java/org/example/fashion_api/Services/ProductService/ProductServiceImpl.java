package org.example.fashion_api.Services.ProductService;


import com.fasterxml.jackson.core.JsonProcessingException;
import jakarta.transaction.Transactional;
import org.example.fashion_api.Exception.AlreadyExistException;
import org.example.fashion_api.Exception.NotFoundException;
import org.example.fashion_api.Mapper.ProductMapper;
import org.example.fashion_api.Models.Categories.Category;
import org.example.fashion_api.Models.Products.*;
import org.example.fashion_api.Repositories.CategoryRepo;
import org.example.fashion_api.Repositories.ProductRepo;
import org.example.fashion_api.Services.CategoryService.CategoryService;
import org.example.fashion_api.Services.CloudinaryService;
import org.example.fashion_api.Services.RedisService.RedisService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

@Service
public class ProductServiceImpl implements ProductService {
    @Autowired
    private ProductMapper productMapper;
    @Autowired
    private ProductRepo productRepo;
    @Autowired
    private CloudinaryService cloudinaryService;
    @Autowired
    private CategoryRepo categoryRepo;
    @Autowired
    private CategoryService categoryService;
    @Autowired
    private RedisService redisService;


    @Override
    public PageProductRes getAllProducts(String keyword, int page, int limit) throws JsonProcessingException {
        if(page < 0){
            page = 0;
        }

        // create redis key
        String redisKey = "getAllProducts("+keyword+","+page+","+limit+") - product";

        // get redis
        PageProductRes pageProductRes = redisService.getRedis(redisKey, PageProductRes.class);

        // if redis with redis key = null -> create redis
        if (pageProductRes == null){
            PageRequest pageRequest = PageRequest.of(page,limit, Sort.by("id").ascending());

            Page<Product> productsPage = productRepo.findAllProductByKey(keyword,pageRequest);

            List<ProductRes> productResList = productMapper.productsToProductRes(productsPage.getContent());

            var totalProduct = Integer.parseInt(String.valueOf(productsPage.getTotalElements()));
            pageProductRes = PageProductRes.builder()
                    .productsRes(productResList)
                    .totalProduct(totalProduct)
                    .currentPage(page+1)
                    .totalPages(productsPage.getTotalPages())
                    .build();
            redisService.saveRedis(redisKey,pageProductRes);
        }

        return pageProductRes;
    }

    @Override
    public ProductRes getProduct(Long productId) {
        return productMapper.productToProductRes(productRepo.findById(productId).orElseThrow(() -> new NotFoundException("product")));
    }

    @Override
    @Transactional
    public ProductRes updateProduct(Long productId, UpdateProductDto updateProductDto) {
        Product currentProduct = productRepo.findById(productId).orElseThrow(() -> new NotFoundException("product"));

        // check code and name exist
        if (!currentProduct.getProductCode().equals(updateProductDto.getProductCode()) && productRepo.existsByProductCode(updateProductDto.getProductCode())) {
            throw new AlreadyExistException(updateProductDto.getProductCode());
        } else if (!currentProduct.getProductName().equals(updateProductDto.getProductName()) && productRepo.existsByProductName(updateProductDto.getProductName())) {
            throw new AlreadyExistException(updateProductDto.getProductName());
        }


        Product product = productRepo.save(productMapper.updateProductDtoToProduct(updateProductDto, currentProduct));



        return productMapper.productToProductRes(product);
    }

    @Override
    public void deleteProduct(Long productId) {
        Product currentProduct = productRepo.findById(productId).orElseThrow(() -> new NotFoundException("Product"));
        productRepo.delete(currentProduct);
    }

    @Override
    @Transactional
    public ProductRes addProduct(CreateProductDto createProductDTO) {

        // check code and name exist
        if (productRepo.existsByProductCode(createProductDTO.getProductCode())) {
            throw new AlreadyExistException("Product code");
        } else if (productRepo.existsByProductName("Product name")) {
            throw new AlreadyExistException(createProductDTO.getProductName());
        }

        // save product
        Product product = productRepo.save(productMapper.createProductDtoToProduct(createProductDTO, new Product()));

        return productMapper.productToProductRes(product);
    }


    @Override
    @Transactional
    public ResponseEntity<String> updateProductBackground(String imageUrl, Long productId) throws IOException {


        productRepo.updateProductBackground(imageUrl, productId);

        return ResponseEntity.ok(imageUrl);
    }

    @Override
    public PageProductRes getAllProductsByCategory(String keyword, int page, int limit, Long catId) throws JsonProcessingException {

        String redisKey = "productService.getAllProductsByCategory("+keyword+","+page+","+limit+","+catId+") - product";

        // get redis
        PageProductRes pageProductRes = redisService.getRedis(redisKey, PageProductRes.class);

        // if redis with key = null -> create redis
        if (pageProductRes == null){
            List<Product> productList = new ArrayList<>();
            List<Category> categories = categoryService.CatDescendants(catId, new ArrayList<>());


            categories.add(categoryRepo.findById(catId).orElseThrow(() -> new NotFoundException(catId.toString())));

            PageRequest pageRequest = PageRequest.of(page,limit, Sort.by("id").ascending());

            for (Category cat : categories) {
                Page<Product> productPage = productRepo.findAllByCategoryCatId(cat.getId(),keyword,pageRequest);

                productList.addAll(productPage.getContent());
            }

            // convert to PageDto
            List<ProductRes> productsRes = productMapper.productsToProductRes(productList);
            var totalProduct = productList.size();
            int totalPage = (int) Math.ceil((double) productsRes.size() / limit);

            pageProductRes = PageProductRes.builder()
                    .productsRes(productsRes)
                    .totalProduct(totalProduct)
                    .currentPage(page+1)
                    .totalPages(totalPage)
                    .build();
            redisService.saveRedis(redisKey, pageProductRes);

            return pageProductRes;
        }


        return pageProductRes;
    }


}

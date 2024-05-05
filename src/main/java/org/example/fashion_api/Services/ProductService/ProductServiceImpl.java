package org.example.fashion_api.Services.ProductService;


import com.fasterxml.jackson.core.JsonProcessingException;
import jakarta.transaction.Transactional;
import org.example.fashion_api.Exception.AlreadyExistException;
import org.example.fashion_api.Exception.NotFoundException;
import org.example.fashion_api.Models.Category.Category;
import org.example.fashion_api.Models.Product.*;
import org.example.fashion_api.Repositories.CategoryRepo;
import org.example.fashion_api.Repositories.ProductRepo;
import org.example.fashion_api.Services.CategoryService.CategoryService;
import org.example.fashion_api.Services.CategoryService.CategoryServiceImpl;
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
    public ProductPageRes getAllProducts(String keyword,int page, int limit) throws JsonProcessingException {
        String redisKey = "getAllProducts("+keyword+","+page+","+limit+") - product";

        ProductPageRes productPageRes = redisService.getRedis(redisKey,ProductPageRes.class);

        if (productPageRes == null){
            PageRequest pageRequest = PageRequest.of(page,limit, Sort.by("product_id").ascending());

            Page<Product> productsPage = productRepo.findAllProductByKey(keyword,pageRequest);

            List<ProductRes> productResList = productMapper.productsToProductRes(productsPage.getContent());

            productPageRes = ProductPageRes.builder()
                    .productsRes(productResList)
                    .totalPages(productsPage.getTotalPages())
                    .build();
            redisService.saveRedis(redisKey,productPageRes);
        }

        return productPageRes;
    }

    @Override
    public ProductRes getProduct(String productId) {
        return productMapper.productToProductRes(productRepo.findById(productId).orElseThrow(() -> new NotFoundException(productId)));
    }

    @Override
    @Transactional
    public ProductRes updateProduct(String productId, UpdateProductDto updateProductDto) {
        Product currentProduct = productRepo.findById(productId).orElseThrow(() -> new NotFoundException(productId));

        if (!productId.equals(updateProductDto.getProductId()) && productRepo.existsByProductId(updateProductDto.getProductId())) {
            throw new AlreadyExistException(updateProductDto.getProductId());
        } else if (!currentProduct.getProductName().equals(updateProductDto.getProductName()) && productRepo.existsByProductName(updateProductDto.getProductName())) {
            throw new AlreadyExistException(updateProductDto.getProductName());
        }

        Product product = productMapper.updateProductDtoToProduct(updateProductDto, currentProduct);

        productRepo.save(product);

        return productMapper.productToProductRes(currentProduct);
    }

    @Override
    public void deleteProduct(String productId) {
        Product currentProduct = productRepo.findById(productId).orElseThrow(() -> new NotFoundException(productId));
        productRepo.delete(currentProduct);
    }

    @Override
    @Transactional
    public ProductRes addProduct(CreateProductDto createProductDTO) {
        if (productRepo.existsByProductId(createProductDTO.getProductId())) {
            throw new AlreadyExistException(createProductDTO.getProductId());
        } else if (productRepo.existsByProductId(createProductDTO.getProductId())) {
            throw new AlreadyExistException(createProductDTO.getProductName());
        }

        Product product = productRepo.save(productMapper.createProductDtoToProduct(createProductDTO, new Product()));
        return productMapper.productToProductRes(product);
    }


    @Override
    @Transactional
    public ResponseEntity<String> updateProductBackground(MultipartFile file, String productId) throws IOException {
        Product product = productRepo.findById(productId).orElseThrow(() -> new NotFoundException(productId));

        cloudinaryService.deleteImageByUrl(product.getImageBackground());

        Map<String, Object> uploadResult = cloudinaryService.upload(file);

        String imageUrl = uploadResult.get("secure_url").toString();
        productRepo.updateCatBackground(imageUrl, productId);
        return ResponseEntity.ok(imageUrl);
    }

    @Override
    public ProductPageRes getAllProductsByCategory(String keyword,int page,int limit,String catId) throws JsonProcessingException {
        String redisKey = "productService.getAllProductsByCategory("+keyword+","+page+","+limit+","+catId+") - product";

        ProductPageRes productPageRes = redisService.getRedis(redisKey,ProductPageRes.class);

        if (productPageRes == null){
            List<Product> productList = new ArrayList<>();
            List<Category> categories = categoryService.CatDescendants(catId, new ArrayList<>());


            categories.add(categoryRepo.findById(catId).orElseThrow(() -> new NotFoundException(catId)));

            PageRequest pageRequest = PageRequest.of(page,limit, Sort.by("product_id").ascending());

            for (Category cat : categories) {
                Page<Product> productPage = productRepo.findAllByCategoryCatId(cat.getCatId(),keyword,pageRequest);

                productList.addAll(productPage.getContent());
            }

            int totalPage = (int) Math.ceil((double) productList.size() / limit);
            List<ProductRes> productsRes = productMapper.productsToProductRes(productList);

            productPageRes = ProductPageRes.builder()
                    .productsRes(productsRes)
                    .totalPages(totalPage)
                    .build();
            redisService.saveRedis(redisKey,productPageRes);

            return productPageRes;
        }


        return productPageRes;
    }

}
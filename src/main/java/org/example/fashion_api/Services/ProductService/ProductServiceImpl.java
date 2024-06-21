package org.example.fashion_api.Services.ProductService;


import com.fasterxml.jackson.core.JsonProcessingException;
import jakarta.transaction.Transactional;
import org.example.fashion_api.Exception.AlreadyExistException;
import org.example.fashion_api.Exception.NotFoundException;
import org.example.fashion_api.Mapper.CategoryMapper;
import org.example.fashion_api.Mapper.ProductMapper;
import org.example.fashion_api.Models.Categories.Category;
import org.example.fashion_api.Models.Categories.CategoryRes;
import org.example.fashion_api.Models.Products.*;
import org.example.fashion_api.Models.ProductsDetails.ProductDetail;
import org.example.fashion_api.Repositories.CategoryRepo;
import org.example.fashion_api.Repositories.ProductDetailRepo;
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
import java.util.Objects;

@Service
public class ProductServiceImpl implements ProductService {
    @Autowired
    private ProductMapper productMapper;
    @Autowired
    private ProductRepo productRepo;
    @Autowired
    private CategoryMapper categoryMapper;
    @Autowired
    private CategoryRepo categoryRepo;
    @Autowired
    private CategoryService categoryService;
    @Autowired
    private RedisService redisService;
    @Autowired
    private ProductDetailRepo productDetailRepo;


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
                    .totalProducts(totalProduct)
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
        }

        if (updateProductDto.getIsActivated() != currentProduct.getIsActivated() && !updateProductDto.getIsActivated()){
            List<ProductDetail> productDetails = productDetailRepo.findAllByProductId(productId);
            for (ProductDetail productDetail : productDetails) {
                productDetailRepo.setIsActivated(productDetail.getId(),updateProductDto.getIsActivated());
            }


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
            throw new AlreadyExistException(createProductDTO.getProductCode());
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
    public List<ProductRes> getAllProductsByCategory(String keyword, Long catId) throws JsonProcessingException {
        String redisKey = "productService.getAllProductsByCategory("+ keyword + "," + catId + ") - product";

        // get redis
        List<ProductRes> products = redisService.getListRedis(redisKey, ProductRes.class);

        if (products == null) {
            List<Long> categoryIds = new ArrayList<>();


            if(!Objects.equals(keyword, "")){

                products = productMapper.productsToProductRes(productRepo.findAllProductByKey(keyword)) ;

            }else {

                if (catId == 0) {
                    products = productMapper.productsToProductRes(productRepo.findAllSale());

                } else {
                    List<CategoryRes> categories = categoryService.CatDescendants(catId, new ArrayList<>());
                    categories.add(categoryMapper.categoryToCategoryRes(categoryRepo.findById(catId).orElseThrow(() -> new NotFoundException(catId.toString()))));
                    for (CategoryRes cat : categories) {
                        categoryIds.add(cat.getId());
                    }

                    products = productMapper.productsToProductRes(productRepo.findAllByCategoryIds(categoryIds));

                }
            }

            redisService.saveRedis(redisKey, products);
        }

        return products;
    }
}

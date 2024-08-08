package org.example.fashion_api.Services.ProductService;


import com.fasterxml.jackson.core.JsonProcessingException;
import jakarta.transaction.Transactional;
import lombok.RequiredArgsConstructor;
import org.example.fashion_api.Exception.AlreadyExistException;
import org.example.fashion_api.Exception.NotFoundException;
import org.example.fashion_api.Mapper.CategoryMapper;
import org.example.fashion_api.Mapper.ProductMapper;
import org.example.fashion_api.Models.Categories.CategoryRes;
import org.example.fashion_api.Models.Products.*;
import org.example.fashion_api.Models.ProductsDetails.ProductDetail;
import org.example.fashion_api.Models.Stored.SellingProductsView;
import org.example.fashion_api.Repositories.CategoryRepo;
import org.example.fashion_api.Repositories.ProductDetailRepo;
import org.example.fashion_api.Repositories.ProductRepo;
import org.example.fashion_api.Repositories.SellingProductsViewRepo;
import org.example.fashion_api.Services.CategoryService.CategoryService;
import org.example.fashion_api.Services.RedisService.RedisService;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Objects;

@Service
@RequiredArgsConstructor
public class ProductServiceImpl implements ProductService {
    private final ProductMapper productMapper;
    private final ProductRepo productRepo;
    private final CategoryMapper categoryMapper;
    private final CategoryRepo categoryRepo;
    private final CategoryService categoryService;
    private final RedisService redisService;
    private final ProductDetailRepo productDetailRepo;
    private final SellingProductsViewRepo sellingProductsViewRepo;

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
                    .totalItems(totalProduct)
                    .currentPage(page+1)
                    .totalPages(productsPage.getTotalPages())
                    .build();
            redisService.saveRedis(redisKey,pageProductRes);
        }

        return pageProductRes;
    }

    @Override
    public ProductRes getProductForAdminPage(Long productId) {
        return productMapper.productToProductRes(productRepo.findById(productId).orElseThrow(() -> new NotFoundException("product")));
    }



    @Override
    public ProductRes getProductForClientPage(Long productId) {
        return productMapper.productToProductRes(productRepo.findByIdAndIsActivatedTrue(productId));
    }

    @Override
    @Transactional
    public ProductRes updateProduct(Long productId, UpdateProductDto updateProductDto) {
        Product currentProduct = productRepo.findById(productId).orElseThrow(() -> new NotFoundException("product"));

        // check code and name exist
        if (!currentProduct.getProductCode().equals(updateProductDto.getProductCode()) && productRepo.existsByProductCode(updateProductDto.getProductCode())) {
            throw new AlreadyExistException(updateProductDto.getProductCode());
        }

        if (updateProductDto.getIsActivated() != currentProduct.getIsActivated()){
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
    public List<ProductRes> getAllProductsByCategory(String keyword, String catId) throws JsonProcessingException {
        String redisKey = "productService.getAllProductsByCategory("+ keyword + "," + catId + ") - product";

        // get redis
        List<ProductRes> products = redisService.getListRedis(redisKey, ProductRes.class);

        if (products == null) {
            List<Long> categoryIds = new ArrayList<>();


            if(!Objects.equals(keyword, "") && Objects.equals(catId, "search")){

                products = productMapper.productsToProductRes(productRepo.findAllProductByKey(keyword)) ;

            }else {

                if (Objects.equals(catId, "0")) {
                    products = productMapper.productsToProductRes(productRepo.findAllSale());

                } else {
                    List<CategoryRes> categories = categoryService.CatDescendants( Long.parseLong(catId) , new ArrayList<>());
                    categories.add(categoryMapper.categoryToCategoryRes(categoryRepo.findById(Long.parseLong(catId)).orElseThrow(() -> new NotFoundException(catId.toString()))));
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

    @Override
    public List<ProductRes> selectListProducts(String selected) throws JsonProcessingException {
        List<ProductRes> productResList = new ArrayList<>();

        if (Objects.equals(selected, "best")){
            List<org.example.fashion_api.Models.Stored.SellingProductsView> sellingProductsView = this.sellingProductsViewRepo.findTop10ByOrderByTotalSalesDesc();
            for (org.example.fashion_api.Models.Stored.SellingProductsView sellingProducts : sellingProductsView){
                productResList.add(ProductRes.builder()
                        .productName(sellingProducts.getProductName())
                        .price(sellingProducts.getPrice())
                        .discountPrice(sellingProducts.getDiscountPrice())
                        .discountPercent(sellingProducts.getDiscountPercent())
                        .imageBackground(sellingProducts.getImageBackground())
                        .totalColor(sellingProducts.getTotalColor())
                        .totalSize(sellingProducts.getTotalSize())
                        .id(sellingProducts.getId())
                        .build());
            }


        } else if (Objects.equals(selected, "shirt")) {
            List<CategoryRes> categoryList = categoryService.CatDescendants(118L,new ArrayList<>());

            List<Product> products = new ArrayList<>();

            for (CategoryRes categoryRes: categoryList){
                products.addAll(productRepo.findAllByCategoryIdAndIsActivatedTrue(categoryRes.getId()));
            }


            productResList = productMapper.productsToProductRes(products.stream().limit(10).toList());

        } else if (Objects.equals(selected, "pants")) {
            List<CategoryRes> categoryList = categoryService.CatDescendants(113L,new ArrayList<>());

            List<Product> products = new ArrayList<>();

            for (CategoryRes categoryRes: categoryList){
                products.addAll(productRepo.findAllByCategoryIdAndIsActivatedTrue(categoryRes.getId()));
            }

            productResList = productMapper.productsToProductRes(products.stream().limit(10).toList());

        }else {
            List<CategoryRes> categoryList = categoryService.CatDescendants(103L,new ArrayList<>());

            List<Product> products = new ArrayList<>();

            for (CategoryRes categoryRes: categoryList){
                products.addAll(productRepo.findAllByCategoryIdAndIsActivatedTrue(categoryRes.getId()));
            }

            productResList = productMapper.productsToProductRes(products.stream().limit(10).toList());
        }

        return productResList;
    }
}

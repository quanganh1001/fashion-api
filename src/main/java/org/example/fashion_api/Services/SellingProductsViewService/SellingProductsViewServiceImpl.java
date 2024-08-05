package org.example.fashion_api.Services.SellingProductsViewService;

import com.fasterxml.jackson.core.JsonProcessingException;
import lombok.RequiredArgsConstructor;
import org.example.fashion_api.Mapper.ProductMapper;
import org.example.fashion_api.Models.Categories.CategoryRes;
import org.example.fashion_api.Models.Products.Product;
import org.example.fashion_api.Models.Products.ProductRes;
import org.example.fashion_api.Models.SellingProductsView.SellingProductsView;
import org.example.fashion_api.Repositories.ProductRepo;
import org.example.fashion_api.Repositories.SellingProductsViewRepo;
import org.example.fashion_api.Services.CategoryService.CategoryService;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;
import java.util.Objects;

@Service
@RequiredArgsConstructor
public class SellingProductsViewServiceImpl implements SellingProductsViewService {

    private final SellingProductsViewRepo sellingProductsViewRepo;
    private final ProductRepo productRepo;
    private final CategoryService categoryService;
    private final ProductMapper productMapper;


    @Override
    public List<ProductRes> selectListProducts(String selected) throws JsonProcessingException {
        List<ProductRes> productResList = new ArrayList<>();

        if (Objects.equals(selected, "best")){
            List<SellingProductsView> sellingProductsView = sellingProductsViewRepo.findTop10ByOrderByTotalSalesDesc();
            for (SellingProductsView sellingProducts : sellingProductsView){
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
                products.addAll(productRepo.findAllByCategoryId(categoryRes.getId()));
            }


            productResList = productMapper.productsToProductRes(products.stream().limit(10).toList());

        } else if (Objects.equals(selected, "pants")) {
            List<CategoryRes> categoryList = categoryService.CatDescendants(113L,new ArrayList<>());

            List<Product> products = new ArrayList<>();

            for (CategoryRes categoryRes: categoryList){
                products.addAll(productRepo.findAllByCategoryId(categoryRes.getId()));
            }

            productResList = productMapper.productsToProductRes(products.stream().limit(10).toList());

        }else {
            List<CategoryRes> categoryList = categoryService.CatDescendants(103L,new ArrayList<>());

            List<Product> products = new ArrayList<>();

            for (CategoryRes categoryRes: categoryList){
                products.addAll(productRepo.findAllByCategoryId(categoryRes.getId()));
            }

            productResList = productMapper.productsToProductRes(products.stream().limit(10).toList());
        }

        return productResList;
    }
}

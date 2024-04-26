package org.example.fashion_api.Services.ProductService;


import org.example.fashion_api.Enum.ImgSizeEnumDTO;
import org.example.fashion_api.Exception.AlreadyExistException;
import org.example.fashion_api.Exception.NotFoundException;
import org.example.fashion_api.Models.Product.*;
import org.example.fashion_api.Repositories.ProductRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ProductServiceImpl implements ProductService {
    @Autowired
    private ProductMapper productMapper;
    @Autowired
    private ProductRepo productRepo;

    @Override
    public List<ProductRes> getAllProducts(){
        return productMapper.productsToProductRes(productRepo.findAll());
    }

    @Override
    public ProductRes getProduct(String productId){
        return productMapper.productToProductRes(productRepo.findById(productId).orElseThrow(() -> new NotFoundException(productId)));
    }

    @Override
    public ProductRes updateProduct(String productId, UpdateProductDto updateProductDto)  {
        Product currentProduct = productRepo.findById(productId).orElseThrow(()->new NotFoundException(productId));

        if (!productId.equals(updateProductDto.getProductId()) && productRepo.existsByProductId(updateProductDto.getProductId())){
            throw new AlreadyExistException(updateProductDto.getProductId());
        } else if (!currentProduct.getProductName().equals(updateProductDto.getProductName()) && productRepo.existsByProductName(updateProductDto.getProductName())){
            throw new AlreadyExistException(updateProductDto.getProductName());
        }

        Product product = productMapper.updateProductDtoToProduct(updateProductDto,currentProduct);

        productRepo.save(product);

        return productMapper.productToProductRes(currentProduct);
    }

    @Override
    public void deleteProduct(String productId){
        Product currentProduct = productRepo.findById(productId).orElseThrow(()->new NotFoundException(productId));
        productRepo.delete(currentProduct);
    }

    @Override
    public ProductRes addProduct(CreateProductDto createProductDTO){
        if(productRepo.existsByProductId(createProductDTO.getProductId())){
            throw new AlreadyExistException(createProductDTO.getProductId());
        }else if(productRepo.existsByProductId(createProductDTO.getProductId())){
            throw new AlreadyExistException(createProductDTO.getProductName());
        }else if(!findByImgSizeEnumUrl(createProductDTO.getImageChooseSize())){
            throw new AlreadyExistException("Url of image size");
        }

        Product product = productRepo.save(productMapper.createProductDtoToProduct(createProductDTO,new Product()));
        return productMapper.productToProductRes(product);
    }

    @Override
    public Boolean findByImgSizeEnumUrl(String url){
        for (ImgSizeEnumDTO size : ImgSizeEnumDTO.values()) {
            if (size.getUrl().equals(url)) {
                return true;
            }
        }
        return false;
    }
}

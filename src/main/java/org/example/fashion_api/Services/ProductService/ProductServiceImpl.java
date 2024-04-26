package org.example.fashion_api.Services.ProductService;


import org.example.fashion_api.Exception.AlreadyExistException;
import org.example.fashion_api.Exception.NotFoundException;
import org.example.fashion_api.Models.Product.Product;
import org.example.fashion_api.Models.Product.ProductDTO;
import org.example.fashion_api.Models.Product.ProductMapper;
import org.example.fashion_api.Repositories.ProductRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.rmi.AlreadyBoundException;
import java.util.List;

@Service
public class ProductServiceImpl implements ProductService {
    @Autowired
    private ProductMapper productMapper;
    @Autowired
    private ProductRepo productRepo;

    @Override
    public List<Product> getAllProducts(){
        return productRepo.findAll();
    }

    @Override
    public ProductDTO getProduct(String productId){
        return productMapper.productToProductDto(productRepo.findById(productId).orElseThrow(() -> new NotFoundException(productId)));
    }

    @Override
    public ProductDTO updateProduct(String productId, ProductDTO productDTO)  {
        Product currentProduct = productRepo.findById(productId).orElseThrow(()->new NotFoundException(productId));

        if (!productId.equals(productDTO.getProductId()) && productRepo.existsByProductId(productDTO.getProductId())){
            throw new AlreadyExistException(productDTO.getProductId());
        } else if (!currentProduct.getProductName().equals(productDTO.getProductName()) && productRepo.existsByProductName(productDTO.getProductName())){
            throw new AlreadyExistException(productDTO.getProductName());
        }

        productMapper.productDtoToProduct(productDTO,currentProduct);
        productRepo.save(currentProduct);
        return productDTO;
    }

    @Override
    public void deleteProduct(String productId){
        Product currentProduct = productRepo.findById(productId).orElseThrow(()->new NotFoundException(productId));
        productRepo.delete(currentProduct);
    }

    @Override
    public ProductDTO addProduct(ProductDTO productDTO){
        if(productRepo.existsByProductId(productDTO.getProductId())){
            throw new AlreadyExistException(productDTO.getProductId());
        }else if(productRepo.existsByProductId(productDTO.getProductId())){
            throw new AlreadyExistException(productDTO.getProductName());
        }

        productRepo.save(productMapper.productDtoToProduct(productDTO,new Product()));
        return productDTO;
    }
}

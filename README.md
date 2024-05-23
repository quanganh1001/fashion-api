# Công Nghệ:
 Spring Boot Framework, MySQL, Redis, JWT, Rabbitmq, Cloudinary, Spring Mail, VNpay, Docker, Swagger

# Hướng dẫn sử dụng:
  - Clone dự án từ github về: git clone https://github.com/quanganh1001/fashion-api.git
  - Chạy dự án trên Docker: docker-compose -f DockerCompose.yaml up -d
  - Test api bằng Swagger: http://localhost:8080/swagger-ui/index.html
    
# Tài khoản đăng nhập:
  - Admin:
    + username: quanly
    + pass: 123456
  - Nhân viên:
    + username: nhanvien1
    + pass: 123456
  - Khách hàng:
    + username: khachhang
    + pass: 123456
      
# Các entity
  - products
  - products_detail
  - accounts
  - categories
  - colors
  - imgs_product
  - invoices
  - invoices_detail


# Các tính năng:

+ Login, logout, tạo tài khoản, đổi mật khẩu, cấp lại mật khẩu qua mail

+ CRUD account, product, category, invoice,...

+ Checkout qua Vnpay
  

# Công Nghệ:
 Spring Boot Framework, Spring Cloud, MySQL, Redis, JWT, Rabbitmq, Cloudinary, Spring Mail, VNpay, Docker

# Hướng dẫn sử dụng:
  1. Clone dự án fashion-api từ github về: git clone https://github.com/quanganh1001/fashion-api.git
  2. Clone dự án fashion-frontend từ github về: git clone https://github.com/quanganh1001/fashion-fronend.git
  3. Chạy dự án fashion-api trên Docker: 
     docker-compose -f DockerCompose.yaml up -d
  4. Chạy dự án fashion-frontend trên Docker:  
     docker build -t fashion-frontend:1.0.0 .
     docker run --name fashion-frontend -d -p 80:3000 --rm fashion-frontend:1.0.0

# Router:
- Admin: http://localhost:3000/admin
- Home: http://localhost:3000/
- Login:
  http://localhost:3000/login
  http://localhost:3000/login-admin

# Tài khoản đăng nhập:
  - Admin:
    + username: 0364100196 / quanganhnguyen100196@gmail.com
    + pass: 123456
  - Nhân viên:
    + username: 0365151822 / nhanvien1@gmail.com
    + pass: 123456
  - Khách hàng:
    + username: 0364431132 / khachhang@gmail.com
    + pass: 123456



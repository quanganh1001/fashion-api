-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Máy chủ: 127.0.0.1
-- Thời gian đã tạo: Th8 08, 2024 lúc 07:14 PM
-- Phiên bản máy phục vụ: 10.4.32-MariaDB
-- Phiên bản PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Cơ sở dữ liệu: `fashion_api_project`
--
CREATE DATABASE IF NOT EXISTS `fashion_api_project` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `fashion_api_project`;

DELIMITER $$
--
-- Thủ tục
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetTopProduct` (IN `startDate` DATE, IN `endDate` DATE)   BEGIN
SELECT
    FLOOR(RAND() * 1000000000) AS `id`,
    `p`.`image_background` AS `image_background`,
    `p`.`product_name` AS `product_name`,
    `pd`.`id` AS `product_detail_id`,
    `pd`.`size` AS `size`,
    `c`.`name` AS `color_name`,
    `i`.`confirmation_date` AS `confirmation_date`,
    `i`.`created_at` AS `created_at`,
    `i`.`updated_at` AS `updated_at`,
    SUM(`id`.`total_price`) AS `total_sales`,
    SUM(`id`.`quantity`) AS `total_quantity_sold`
FROM
    (
        (
            (
                (
                    `fashion_api_project`.`invoices_detail` `id`
                JOIN `fashion_api_project`.`invoices` `i`
                ON
                    (`id`.`invoice_id` = `i`.`id`)
                )
            JOIN `fashion_api_project`.`products_detail` `pd`
            ON
                (`id`.`product_detail_id` = `pd`.`id`)
            )
        JOIN `fashion_api_project`.`products` `p`
        ON
            (`pd`.`product_id` = `p`.`id`)
        )
    JOIN `fashion_api_project`.`colors` `c`
    ON
        (`pd`.`color_id` = `c`.`id`)
    )
WHERE
    `i`.`confirmation_date` IS NOT NULL
     AND i.confirmation_date BETWEEN startDate AND endDate
GROUP BY
    `p`.`image_background`,
    `p`.`product_name`,
    `pd`.`id`,
    `pd`.`size`,
    `c`.`name`
ORDER BY
    SUM(`id`.`total_price`) DESC
LIMIT 10;

END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `accounts`
--

CREATE TABLE `accounts` (
  `id` int(11) NOT NULL,
  `password` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `email` varchar(55) NOT NULL,
  `phone` varchar(55) NOT NULL,
  `address` varchar(255) NOT NULL,
  `role` varchar(15) NOT NULL,
  `is_activated` bit(1) NOT NULL DEFAULT b'1',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `accounts`
--

INSERT INTO `accounts` (`id`, `password`, `name`, `email`, `phone`, `address`, `role`, `is_activated`, `created_at`, `updated_at`) VALUES
(1, '$2a$10$5C32JYodwPS87Qo2ZqTRBOb3NpDJyls3DEWLoEdb4i1oV5jjmNzNe', 'quang anh', 'quanganhnguyen100196@gmail.com', '0364100196', 'dsva', 'ROLE_MANAGER', b'1', '2024-05-14 10:45:53', '2024-06-25 17:59:48'),
(2, '$2a$10$cIsfc/R8PIsJWzbgolJRheAfJ7hK9hxwxxpqplMP4CSlTBJhcoMk.', 'nhanvien1', 'nhanvien1@gmail.com', '0365151822', 'hanoi', 'ROLE_EMPLOYEE', b'1', '2024-05-14 10:45:53', '2024-08-06 12:30:47'),
(4, '$2a$10$5D2B5O4CmS5RN4VxaTwJXOi9B83aa0lGwWy.sICls9O3LKRgNXyDm', 'nhavien2', 'nhanvien2@gmail.com', '0364421123', 'hanoi', 'ROLE_EMPLOYEE', b'1', '2024-05-14 10:45:53', '2024-08-04 12:36:30'),
(8, '$2a$10$Eh581hpIm67HRwTrHJDpi.iNlHtcbYIBOy313HikKSFJQ4BUPycNu', 'nhanvien3', 'nhanvien3@gmail.com', '0312646431', 'hanoi', 'ROLE_EMPLOYEE', b'1', '2024-05-14 10:45:53', '2024-05-14 10:45:53'),
(14, '$2a$10$txuPDKVLcA7VGk5x9L8NfuLd2GcUeNAxRzZGl/pWgQl.LpFdcA8QK', 'khách hàng', 'khachhang@gmail.com', '0364431132', 'hanoi', 'ROLE_CUSTOMER', b'1', '2024-05-14 10:45:53', '2024-05-14 10:45:53'),
(35, '$2a$10$DhbyS4lDOQ2H2uwcVRXELem3yR2MKPYSu8T6QwMj4a1kJXKDHzkAG', 'test', 'anh.nguyen43@iholding.org', '0364664322', '4dvsdsf', 'ROLE_EMPLOYEE', b'1', '2024-06-29 16:40:37', '2024-06-30 08:25:54'),
(36, '$2a$10$EC0Uu6.c07tL5DJ/dIpVBeg.bmpyKZCpN17lJOCpvDK/eMs9IBhdC', 'khách', 'anhnqth2211019@fpt.edu.vn', '0346444332', 'sdfsd', 'ROLE_CUSTOMER', b'1', '2024-06-30 09:46:38', '2024-06-30 09:46:38');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `categories`
--

CREATE TABLE `categories` (
  `id` int(11) NOT NULL,
  `category_code` varchar(10) NOT NULL,
  `cat_name` varchar(30) DEFAULT NULL,
  `parent_id` int(11) DEFAULT NULL,
  `cat_background` varchar(255) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `categories`
--

INSERT INTO `categories` (`id`, `category_code`, `cat_name`, `parent_id`, `cat_background`, `created_at`, `updated_at`) VALUES
(86, 'AK', 'Áo khoác', 96, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1718859021/cadgpxtbfduvwwaxmlal.jpg', '2024-05-14 10:46:05', '2024-07-01 05:14:14'),
(87, 'AKBB', 'Áo khoác Bomber', 86, NULL, '2024-05-14 10:46:05', '2024-06-11 05:12:45'),
(88, 'AKCC', 'Áo khoác cổ cao', 86, NULL, '2024-05-14 10:46:05', '2024-06-11 05:12:45'),
(89, 'AKG', 'Áo khoác gió', 86, NULL, '2024-05-14 10:46:05', '2024-06-11 05:12:45'),
(90, 'AKP', 'Áo khoác phao', 86, NULL, '2024-05-14 10:46:05', '2024-06-11 05:12:45'),
(91, 'ALK', 'Áo len kẻ', 94, NULL, '2024-05-14 10:46:05', '2024-06-11 05:12:18'),
(92, 'ALT', 'Áo len trơn', 94, NULL, '2024-05-14 10:46:05', '2024-06-11 05:12:18'),
(93, 'ANK', 'Áo nỉ kẻ', 94, NULL, '2024-05-14 10:46:05', '2024-06-11 05:12:18'),
(94, 'ANL', 'Áo nỉ - len', 96, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711887116/qasfi8lttpdvyvgmolah.webp', '2024-05-14 10:46:05', '2024-06-11 05:12:18'),
(95, 'ANT', 'Áo nỉ trơn', 94, NULL, '2024-05-14 10:46:05', '2024-06-11 05:12:18'),
(96, 'AO', 'Áo nam', NULL, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1718101638/pzmpkmgsfbnt2im2dxcl.jpg', '2024-05-14 10:46:05', '2024-06-11 10:27:19'),
(97, 'BN', 'Bộ nỉ', 115, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711887418/zisn6ikfcajpyoqvwits.webp', '2024-05-14 10:46:05', '2024-05-14 10:46:05'),
(98, 'PLBK', 'Polo Bo Kẻ', 103, 'no_image.jpg', '2024-05-14 10:46:05', '2024-06-11 05:12:18'),
(99, 'PLCP', 'Polo can phối', 103, 'no_image.jpg', '2024-05-14 10:46:05', '2024-06-11 05:12:18'),
(100, 'PLHT', 'Polo họa tiết', 103, '1707659794400_home_category_7_img.jpg', '2024-05-14 10:46:05', '2024-06-11 05:12:18'),
(101, 'PLK', 'Polo kẻ', 103, 'no_image.jpg', '2024-05-14 10:46:05', '2024-06-11 05:12:18'),
(102, 'PLT', 'Polo trơn', 103, 'no_image.jpg', '2024-05-14 10:46:05', '2024-06-11 05:12:18'),
(103, 'POLO', 'Áo polo', 96, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711887135/ikfhqgyc649ojjh98kwr.webp', '2024-05-14 10:46:05', '2024-06-11 05:12:18'),
(104, 'QA', 'Quần âu', 113, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711887256/ubsonyurdhhfwczmykoy.webp', '2024-05-14 10:46:05', '2024-05-14 10:46:05'),
(105, 'QAPTC', 'Quần âu phối thun cạp', 104, 'no_image.jpg', '2024-05-14 10:46:05', '2024-05-14 10:46:05'),
(106, 'QDK', 'Quần dài kaki', 113, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711887282/etuppqbnkbxufsqmy7el.jpg', '2024-05-14 10:46:05', '2024-05-14 10:46:05'),
(107, 'QJ', 'Quần jeans', 113, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711887311/d3eqcj37abqwnwv4dmvu.webp', '2024-05-14 10:46:05', '2024-05-14 10:46:05'),
(108, 'QJB', 'Quần jeans basic', 107, 'no_image.jpg', '2024-05-14 10:46:05', '2024-05-14 10:46:05'),
(109, 'QJR', 'Quần jeans rách', 107, 'no_image.jpg', '2024-05-14 10:46:05', '2024-05-14 10:46:05'),
(110, 'QKB', 'Quần kaki basic', 106, 'no_image.jpg', '2024-05-14 10:46:05', '2024-05-14 10:46:05'),
(111, 'QN', 'Quần nỉ', 113, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711887352/x23rz8v9cqdaadztvexs.webp', '2024-05-14 10:46:05', '2024-05-14 10:46:05'),
(112, 'QS', 'Quần short', 113, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711887380/x9muxebcf9z8xa4naqte.webp', '2024-05-14 10:46:05', '2024-05-14 10:46:05'),
(113, 'QUAN', 'Quần nam', NULL, 'no_image.jpg', '2024-05-14 10:46:05', '2024-05-14 10:46:05'),
(114, 'SD', 'Short đũi', 112, 'no_image.jpg', '2024-05-14 10:46:05', '2024-05-14 10:46:05'),
(115, 'SET', 'Set', NULL, '1707658980103_home_category_2_img.jpg', '2024-05-14 10:46:05', '2024-05-14 10:46:05'),
(116, 'SG', 'Short gió', 112, 'no_image.jpg', '2024-05-14 10:46:05', '2024-05-14 10:46:05'),
(117, 'SKK', 'Short kaki', 112, 'no_image.jpg', '2024-05-14 10:46:05', '2024-05-14 10:46:05'),
(118, 'SM', 'Sơ mi', 96, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711887158/qrazso5enu9rfz1zrwze.webp', '2024-05-14 10:46:05', '2024-06-11 05:12:18'),
(119, 'SMD', 'Sơ mi đũi', 118, NULL, '2024-05-14 10:46:05', '2024-06-11 05:12:18'),
(120, 'SMDM', 'Sơ mi Demin', 118, NULL, '2024-05-14 10:46:05', '2024-06-11 05:12:18'),
(121, 'SMHT', 'Sơ mi họa tiết', 119, NULL, '2024-05-14 10:46:05', '2024-06-11 05:12:18'),
(122, 'SMK', 'Sơ mi kẻ', 118, NULL, '2024-05-14 10:46:05', '2024-06-11 05:12:18'),
(123, 'SMT', 'Sơ mi trơn', 118, NULL, '2024-05-14 10:46:05', '2024-06-11 05:12:18'),
(124, 'THUN', 'Áo thun', 96, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711887206/weftgxxcytuuh11xtpj8.webp', '2024-05-14 10:46:05', '2024-06-11 05:12:18'),
(125, 'TIH', 'Thun in hình', 124, NULL, '2024-05-14 10:46:05', '2024-06-11 05:12:18'),
(126, 'TT', 'Tank top', 124, NULL, '2024-05-14 10:46:05', '2024-06-11 05:12:18'),
(131, 'test4', 'test4', 98, 'a', '2024-05-16 14:11:22', '2024-06-11 05:12:18');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `colors`
--

CREATE TABLE `colors` (
  `id` int(11) NOT NULL,
  `color_code` varchar(5) NOT NULL,
  `name` varchar(50) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `colors`
--

INSERT INTO `colors` (`id`, `color_code`, `name`, `created_at`, `updated_at`) VALUES
(1, 'BBR', 'Phối đen-nâu', '2024-05-14 10:46:22', '2024-05-14 10:46:22'),
(2, 'BCR', 'Phối xanh đá đậm - kem đậm', '2024-05-14 10:46:22', '2024-05-14 10:46:22'),
(3, 'BE', 'Màu be', '2024-05-14 10:46:22', '2024-05-14 10:46:22'),
(4, 'BL', 'Màu đen', '2024-05-14 10:46:22', '2024-05-14 10:46:22'),
(5, 'BLE', 'Phối đen-be', '2024-05-14 10:46:22', '2024-05-14 10:46:22'),
(6, 'BR', 'Nâu', '2024-05-14 10:46:22', '2024-05-14 10:46:22'),
(7, 'BU', 'Xanh da trời', '2024-05-14 10:46:22', '2024-05-14 10:46:22'),
(8, 'CN', 'Xanh cổ vịt', '2024-05-14 10:46:22', '2024-05-14 10:46:22'),
(9, 'CR', 'Trắng kem', '2024-05-14 10:46:22', '2024-05-14 10:46:22'),
(10, 'DBU', 'Xanh da trời đậm', '2024-05-14 10:46:22', '2024-05-14 10:46:22'),
(11, 'DCB', 'Xanh đã đậm', '2024-05-14 10:46:22', '2024-05-14 10:46:22'),
(12, 'DCR', 'Trắng - kem đậm', '2024-05-14 10:46:22', '2024-05-14 10:46:22'),
(13, 'DGN', 'Xanh lá cây đậm', '2024-05-14 10:46:22', '2024-05-14 10:46:22'),
(14, 'DGR', 'Xám đậm', '2024-05-14 10:46:22', '2024-05-14 10:46:22'),
(15, 'DNV', 'Dark Navy', '2024-05-14 10:46:22', '2024-05-14 10:46:22'),
(16, 'DTU', 'Xanh ngọc đậm', '2024-05-14 10:46:22', '2024-05-14 10:46:22'),
(17, 'ENV', 'Phối Be - Navy', '2024-05-14 10:46:22', '2024-05-14 10:46:22'),
(18, 'GN', 'Xanh lá cây', '2024-05-14 10:46:22', '2024-05-14 10:46:22'),
(19, 'GR', 'Xám', '2024-05-14 10:46:22', '2024-05-14 10:46:22'),
(20, 'HBR', 'Phối nâu trắng', '2024-05-14 10:46:22', '2024-05-14 10:46:22'),
(21, 'HCR', 'Phối kem đậm - trắng', '2024-05-14 10:46:22', '2024-05-14 10:46:22'),
(22, 'LB', 'Xanh da trời nhạt', '2024-05-14 10:46:22', '2024-05-14 10:46:22'),
(23, 'LBE', 'Be nhạt', '2024-05-14 10:46:22', '2024-05-14 10:46:22'),
(24, 'LBL', 'Đen nhạt', '2024-05-14 10:46:22', '2024-05-14 10:46:22'),
(25, 'LCB', 'Xanh đá nhạt', '2024-05-14 10:46:22', '2024-05-14 10:46:22'),
(26, 'LCR', 'Trắng kem nhạt', '2024-05-14 10:46:22', '2024-05-14 10:46:22'),
(27, 'LG', 'Xám Nhạt', '2024-05-14 10:46:22', '2024-05-14 10:46:22'),
(28, 'LI', 'Tím phớt', '2024-05-14 10:46:22', '2024-05-14 10:46:22'),
(29, 'LLB', 'Xanh da trời phai', '2024-05-14 10:46:22', '2024-05-14 10:46:22'),
(30, 'LLG', 'Phối đen - xám nhạt', '2024-05-14 10:46:22', '2024-05-14 10:46:22'),
(31, 'LYL', 'Vàng nhạt', '2024-05-14 10:46:22', '2024-05-14 10:46:22'),
(32, 'NBX', 'Phối navy - Đỏ đô', '2024-05-14 10:46:22', '2024-05-14 10:46:22'),
(33, 'NV', 'Xanh navy', '2024-05-14 10:46:22', '2024-05-14 10:46:22'),
(34, 'NVC', 'Phối kem navi', '2024-05-14 10:46:22', '2024-05-14 10:46:22'),
(35, 'NWH', 'Phối Navy-trắng', '2024-05-14 10:46:22', '2024-05-14 10:46:22'),
(36, 'TU', 'Xanh ngọc', '2024-05-14 10:46:22', '2024-05-14 10:46:22'),
(37, 'VCB', 'Phối xanh đá - navy', '2024-05-14 10:46:22', '2024-05-14 10:46:22'),
(38, 'WBL', 'Phối trắng-đen', '2024-05-14 10:46:22', '2024-05-14 10:46:22'),
(39, 'WCB', 'Phối Trắng - Xanh đá', '2024-05-14 10:46:22', '2024-05-14 10:46:22'),
(40, 'WH', 'Trắng', '2024-05-14 10:46:22', '2024-05-14 10:46:22'),
(41, 'WNV', 'Phối trắng-xanh navy', '2024-05-14 10:46:22', '2024-05-14 10:46:22');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `customer_emails`
--

CREATE TABLE `customer_emails` (
  `id` int(11) NOT NULL,
  `email` varchar(255) NOT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_at` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `customer_emails`
--

INSERT INTO `customer_emails` (`id`, `email`, `created_at`, `updated_at`) VALUES
(1, 'anhnqth2211019@fpt.edu.vn', '2024-06-30 00:00:00', '2024-06-30 00:00:00'),
(3, 'anhnguyen43@ihoding.org', '2024-06-30 00:00:00', '2024-06-30 00:00:00'),
(8, 'quanganhnguyen100196@gmail.com', '2024-06-30 00:00:00', '2024-06-30 00:00:00'),
(10, 'fs@gmail.com', '2024-08-01 12:25:03', '2024-08-01 12:25:03'),
(11, 'cx@gmail.com', '2024-08-04 17:46:12', '2024-08-04 17:46:12');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `feedback_customers`
--

CREATE TABLE `feedback_customers` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `feedback` varchar(500) NOT NULL,
  `is_readed` tinyint(1) NOT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_at` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `feedback_customers`
--

INSERT INTO `feedback_customers` (`id`, `name`, `email`, `feedback`, `is_readed`, `created_at`, `updated_at`) VALUES
(1, 'quang anh', 'anhnguyen.43@iholding.org', 'sdfvd', 1, '2024-06-30 00:00:00', '2024-06-30 00:00:00'),
(2, 'khách', 'anhnqth2211019@fpt.edu.vn', 'dsgsdcxvcxvcds', 0, '2024-06-30 00:00:00', '2024-06-30 00:00:00'),
(3, 'khách', 'anhnqth2211019@fpt.edu.vn', 'xxzxxczxczxzxzz', 0, '2024-06-30 00:00:00', '2024-06-30 00:00:00'),
(4, 'khách', 'anhnqth2211019@fpt.edu.vn', 'xzxvcxzcxrrrrrr', 0, '2024-06-30 22:30:08', '2024-06-30 22:30:08'),
(5, 'khách', 'anhnqth2211019@fpt.edu.vn', 'bvvvvvvv', 0, '2024-06-30 22:30:11', '2024-06-30 22:30:11'),
(6, 'khách', 'anhnqth2211019@fpt.edu.vn', 'qqqqq', 0, '2024-06-30 22:30:13', '2024-06-30 22:30:13'),
(7, 'tk2', 'anhnguyen.43@iholding.org', 'fdsfsd', 0, '2024-06-30 23:06:10', '2024-06-30 23:06:10'),
(8, 'tk2', 'anhnguyen.43@iholding.org', 'fdsfsd', 0, '2024-06-30 23:06:10', '2024-06-30 23:06:10'),
(9, 'tk2', 'anhnguyen.43@iholding.org', 'xzczzz', 1, '2024-06-30 23:06:12', '2024-06-30 23:06:12'),
(10, 'tk2', 'anhnguyen.43@iholding.org', ',jhjhgjg', 0, '2024-06-30 23:06:14', '2024-06-30 23:06:14'),
(11, 'tk2', 'anhnguyen.43@iholding.org', 'cccxcvxcvcx', 0, '2024-06-30 23:06:16', '2024-06-30 23:06:16'),
(12, 'tk2', 'anhnguyen.43@iholding.org', 'rtyrtyrttryr', 0, '2024-06-30 23:06:18', '2024-06-30 23:06:18'),
(13, 'tk2', 'anhnguyen.43@iholding.org', '453543sffsdfdsfs', 0, '2024-06-30 23:06:20', '2024-06-30 23:06:20'),
(14, 'tk2', 'anhnguyen.43@iholding.org', 'nbvnbvndgsdfsd', 0, '2024-06-30 23:06:22', '2024-06-30 23:06:22');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `imgs_product`
--

CREATE TABLE `imgs_product` (
  `id` int(11) NOT NULL,
  `product_id` int(11) DEFAULT NULL,
  `file_img` varchar(250) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `imgs_product`
--

INSERT INTO `imgs_product` (`id`, `product_id`, `file_img`, `created_at`, `updated_at`) VALUES
(3, 51, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811636/tp038-1.jpeg.webp', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(4, 51, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811639/tp038.jpeg.webp', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(5, 51, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811634/tp038-41.jpeg.webp', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(6, 51, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811631/tp038-42.jpeg.webp', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(7, 51, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811628/tp038-43.jpeg.webp', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(8, 51, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811625/tp038-44.jpeg.webp', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(9, 51, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811622/tp038-45.jpeg.webp', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(10, 56, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811574/tp067---bk004-_16__bc6a55b32ddb4d94bc5c0fa5a7997db4_master.jpg.webp', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(11, 56, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811577/tp067---bk004-_13__eb790ac8d5dd44618429783c9ed42844_master.jpg.webp', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(12, 56, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811602/52867073164_c93edc6a70_k_9447f869422f4aa793f65556da2f944c_master.jpg.jpg', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(13, 56, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811613/52866332867_b3e9385404_k_e7aa9db13469468e86586673d414a1f3_master.jpg.jpg', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(14, 56, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811582/52867351953_9e3e03f2b1_k_096de1bcfee34099969d0edd7b8e6f26_master.jpg.jpg', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(15, 56, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811616/52866332727_2f58586473_k_7ac15a1978a04a37a6713af0bab43b09_master.jpg.jpg', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(16, 56, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811599/52867351793_7fdd444ee2_k_4c9345e571394a009fa0e3e68e76a451_master.jpg.jpg', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(17, 56, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811596/52867351808_e5a4600839_k_f877288ddfab4de6b74713bccd8dc336_master.jpg.jpg', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(18, 56, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811620/52866332657_414108a7c6_k_b4b4ef2544e94d1c9e65de3dc7f57209_master.jpg.jpg', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(19, 56, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811592/52867351903_e8df6368ea_k_93703527ed854f82a3c46db0c674704c_master.jpg.jpg', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(20, 56, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811589/52867351913_203d16cda4_k_d6e60d7f209d4832b26a4e9044b8af9e_master.jpg.jpg', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(21, 56, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811586/52867351923_7cae731772_k_c20306b870404071b12dad2f38d0d093_master.jpg.jpg', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(22, 48, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811570/tp028---bk004-_11__9246a1d8b0184518abd852704bd4fa02_master.jpg.webp', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(28, 56, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811560/4_8fb2c95d0ce84becbb58fd9ed237ba08_master.jpg.jpg', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(29, 56, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811558/6_6839924c418d47e183d08e255b8c3c63_master.jpg.jpg', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(30, 56, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811557/52789526191_861fe9d52b_o_21ebcee1355d4c3dad77e7d3c1ff0d4c_master.jpg.jpg', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(31, 13, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811554/tp611_59ea616328234a9b969ce2d1c48c482f_master.jpg.webp', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(32, 13, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811551/tp611-1_e64e507a26034c7cab4000647d260ede_master.jpg.webp', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(33, 13, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811549/1_1e206b362a714f3d98754a060ce09454_master.jpg.jpg', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(34, 13, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811547/3_4dd89c6d76d54a4d96db9ec8d1ab1e93_master.jpg.jpg', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(41, 38, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811545/tp010---bk603-_8__b6487398009b4c6eaa1950ee0f26e718_master.jpg.webp', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(42, 38, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811543/tp010---bk603-_18__182eb99ee71a46a381827867ad2a96de_master.jpg.webp', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(43, 38, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811540/52769491109_e6fb49f9f0_o_32455b99bcaf4082aa9cd70b23af5f9e_master.jpg.webp', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(44, 38, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811537/52769491159_ba17744c21_o_9ef26ec3123b4c97aab4ab0e25cba4d5_master.jpg.webp', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(45, 38, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811533/52769491004_ecb5666549_o_219d2b308f9e43a6a1afbbb5fe2bd5b9_master.jpg.webp', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(46, 38, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811530/52769490734_e7c5ff8fef_o_e395740c9186424989fac889b1c7d4f7_master.jpg.webp', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(47, 49, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811526/estp032-3_f94042405af64ca581ca72c753b53b51_master.jpg.webp', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(48, 49, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811523/estp032-3_5833a48d93d041fab7b4a56668a78262_master.jpg.webp', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(49, 49, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811520/estp032-1_86750080b9b3454bb7b35f79c996f898_master.jpg.webp', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(50, 49, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811517/estp032-2_c5486330b45845dd9e4e9dd652d9fe51_master.jpg.webp', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(51, 49, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811514/estp032-3_52866931581_o_696a4be7241646908451a50a1ab3ec7c_master.jpg.webp', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(52, 49, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811510/estp032-4_52866931551_o_a66d94b2046f471d8bfb1bf8342400c9_master.jpg.jpg', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(53, 49, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811507/estp032-5_52867320575_o_3c67b3a8e6f74535aa323e0926391185_master.jpg.jpg', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(54, 49, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811503/estp032-11_52866355737_o_a52dd32e7b96416ab120276b6d4403e4_master.jpg.webp', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(55, 49, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811500/1_50f16dbd5df34aa3acc99865b4820084_master.jpg.webp', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(56, 49, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811498/2_5933a603e4074662bfe7cc6b5fe1e44b_master.jpg.webp', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(57, 49, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811496/3_e2f6d02236ac4e0397a15b372c85bfb2_master.jpg.webp', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(58, 49, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811494/4_aaa0fd53411a441e85605a458aab67f7_master.jpg.webp', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(62, 36, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811485/tp005_52e371ed726e4f2d8401d86c5e0b38fb_master.jpg.webp', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(63, 36, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811483/tp005-1_540fc6869412410498fde0786b1e4ae5_master.jpg.jpg', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(64, 36, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811480/52826115451_f0f0e4aba3_o_1e2aaae876504b3781a5bf9eaa3e8649_master.jpg.jpg', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(65, 36, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811477/estp005_52832929942_o_1fa1849607d14981bf7a289fa35bca7e_master.jpg.jpg', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(66, 36, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811468/estp005_52832930232_o_c2dc6fe645224bbdace38aee17ba4ebc_master.jpg.jpg', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(67, 36, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811464/estp005_52833497146_o_19f6e6d8b44947d4bcd7461012e1e40d_master.jpg.jpg', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(68, 52, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811461/estp041-16_4cb9d42d84e7436884bd3f4e648621ed_master.jpg.webp', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(69, 52, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811459/estp041-12_f4f5deac05fa47789c5897ba7a06818f_master.jpg.webp', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(70, 52, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811457/estp041-11_5cc08ee5a7f94d739d935b090e8657ce_master.jpg.jpg', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(71, 52, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811454/estp041-15_0af52441e90e49aebae6f5874f100c2d_master.jpg.webp', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(72, 52, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811452/estp041-13_052acb199d294321a1158807cea0d5b4_master.jpg.webp', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(73, 52, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811450/estp041-14_c216ec36194c4f7da5d099aff22b8316_master.jpg.webp', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(74, 52, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811447/estp041-6_3141cb9f439d4fb0b02a8d09f2d0e836_master.jpg.webp', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(75, 52, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811444/estp041-3_83014782b53841358a80703e3de20b49_master.jpg.webp', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(76, 52, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811441/estp041-7_38c774c7c3f74bfa852ec9fb4923a3de_master.jpg.jpg', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(77, 52, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811433/estp041-9_b544581a872a4d32bb9c8c4ed240c6dd_master.jpg.webp', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(78, 52, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811430/estp041-8_316b7cd7e97744ac925f985863972761_master.jpg.webp', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(79, 52, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811427/estp041-1_6a52d5fd1f594e2b9acee2d830b78b58_master.jpg.webp', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(80, 52, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811424/estp041-2_0fe28f88db44491aa3f4e7ce0daf884e_master.jpg.webp', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(81, 52, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811422/estp041-4_0f2a7f2b52d645dab95a9cdd5fdee0f3_master.jpg.webp', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(82, 52, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811420/estp041-5_2d4ac01b779044a4ba9e1e3343e328f9_master.jpg.webp', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(83, 53, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811418/tp042---bk004-_9__2efe604ac9324e06841cf8edc590e169_master.jpg.webp', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(84, 53, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811415/tp042---bk004-_12__0fc56a3426f74ac79d1f10f9ab0b2fde_master.jpg.jpg', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(85, 53, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811412/estp042-br-4_52866363897_o_4cea7101361d4aeda23916a73776bc89_master.jpg.jpg', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(86, 53, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811409/estp042-br-5_52866363922_o_3b22baf5d6c540749f0eae1b143090b6_master.jpg.jpg', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(87, 53, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811404/estp042-br-1_52867103974_o_cfe354dcf6f54ba0b8a85cd45a0948a7_master.jpg.jpg', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(88, 53, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811399/estp042-br-2_52867382413_o_baf78a07a1e84447a3f01c49f2a55146_master.jpg.jpg', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(89, 53, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811395/estp042-br-3_52867103924_o_82a3a7e6860f480e91b11f3a5e7e18ed_master.jpg.jpg', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(90, 53, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811387/estp042-1_52867104114_o_aff74874616b45889ded6a949e0a1eb9_master.jpg.jpg', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(91, 53, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811384/estp042-bl-2_52867328655_o_55af013d6db2478fb8002da234a249d3_master.jpg.jpg', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(92, 53, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811380/estp042-cr-2_52867383288_o_cfa01925fc274a748e611e45bc874487_master.jpg.jpg', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(93, 53, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811377/estp042-dtu-2_52867383188_o_19e01fc82fca404e9629f3eff9993e76_master.jpg.jpg', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(94, 53, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811374/estp042-li-4_52866364592_o_4a615385ee834290ba6df68a2ed69311_master.jpg.jpg', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(95, 53, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811370/estp042-lyl-2_52867329090_o_51fd4f8cbbbf49f7890af4a9829581fb_master.jpg.jpg', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(96, 53, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811360/estp042-nv-3_52867104354_o_0580916685074dcdafdd251732674e2a_master.jpg.jpg', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(97, 53, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811357/estp042-tu-2_52866939911_o_96bd77d6c720444f86e520f606c880be_master.jpg.jpg', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(98, 53, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811354/estp042-wh-2_52867104164_o_0190b878eb0240c7bdc957655d380cbf_master.jpg.jpg', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(99, 50, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811351/m1t1_9a04e0331596472281861b7f44cc3ca2_master.jpg.webp', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(100, 50, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811349/2_9f21c1bc2bb4483aa055ffb7356ecf2b_master.jpg.jpg', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(101, 50, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811346/3_13e212d45d7d4bf0969316de7ea60043_master.jpg.jpg', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(102, 50, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811344/4_f4b074268aae494a83ba8ae43ff8ab3d_master.jpg.jpg', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(103, 50, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811341/5_b213c588677e4d9bb736c832971db86b_master.jpg.jpg', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(114, 35, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811339/estp001-2_ca463de5f50243ff920007e6314ac0eb_master.jpg.webp', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(115, 35, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811337/estp001-3_af8e67d349a34ea2857b8f923538bfba_master.jpg.webp', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(116, 35, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811335/estp001-1_e79f5d2eed6b4d15be9136100b48c52e_master.jpg.webp', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(117, 35, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811333/2_03d7f4c5170c475ab303f4a1a35f7772_master.jpg.jpg', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(118, 35, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811331/3_d899896ff01a4adeb430b83c94dc2483_master.jpg.jpg', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(119, 35, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811329/4_fe228fc01afa43a082ef4bda0d636e20_master.jpg.jpg', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(120, 35, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811327/7_9bc29d0a14064c70aca802cc201f2750_master.jpg.webp', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(121, 55, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811325/3_a6cdb2c46dd543fd9507418aef06c558_master.jpg.webp', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(122, 55, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811322/2_d527cf7f226e40c9bdf647d7cfcdb73d_master.jpg.jpg', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(123, 55, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811320/52951329992_50ac43f695_o_0d0d415fa295462dbb496e1cda501bad_master.jpg.jpg', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(124, 55, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811317/estp060-1_eb469e85967d44e3a36e4dc8ca9ae0ea_master.jpg.jpg', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(125, 55, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811314/estp060-4_3fbb20aa4c1b4ff1b054225ad070a6f9_master.jpg.jpg', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(126, 55, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811310/estp060-2_322d5e5eab9a4de399752a3783025240_master.jpg.jpg', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(127, 55, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811307/estp060-3_326826ec287a49b58f66324c764a15fe_master.jpg.jpg', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(142, 37, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811304/estp007-1_9cd4cd6e34ac4041bb7e96da2d1eeb22_master.jpg.webp', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(143, 37, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811301/tp007---bj901-_19__77bda55d7cb8490981e89a43f2accbb2_master.jpg.webp', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(144, 37, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811299/52898691552_37ea5079d3_o_ebb2277a32594cc7b1e9e4a218be9e8b_master.jpg.jpg', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(145, 37, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811296/52898691577_03b1414605_o_b27a16af3124429d86bf5da8f0cf0a0c_master.jpg.webp', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(146, 37, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811293/52899265456_b212798cac_o_9aef58b065eb48c38e1c8ec115b234d9_master.jpg.webp', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(147, 37, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811289/52899713483_5b59788a82_o_46b4209167da44989fbc7a67d156289c_master.jpg.jpg', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(148, 37, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811285/52899660480_41c01903c4_o_5bd3da357e264f1891e47d54d5d3b4ef_master.jpg.webp', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(149, 37, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811282/52898691562_67c82c3ca7_o_9da334afa0244604bf21a0d59cf2a7f2_master.jpg.webp', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(150, 44, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811280/tp020---bk001-_10__b44a6900b6934440ad797f313b2cdd9a_master.jpg.webp', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(151, 44, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811277/tp020---bk001-_19__39c7901d719942a790b6cf8a9584383a_master.jpg.webp', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(152, 44, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811274/estp020-2_52826081331_o_54237fd9c1084a329c27f40c559396b5_master.jpg.webp', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(153, 44, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811271/estp020-3_52826521153_o_065f5c020fe441299ef865b526ad311d_master.jpg.jpg', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(154, 44, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811262/estp020-1_52825506602_o_a115b5ddf53148a08d97e01ff7b86d24_master.jpg.jpg', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(155, 44, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811258/estp020-4_52825506387_o_91c212f08243413dbd963193d05a30e4_master.jpg.webp', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(168, 47, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811255/1_4554a899fc974e40bc58638b060b31ee_master.jpg.webp', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(169, 47, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811253/2_01804471604b4ce29bbd620d5ac8f08f_master.jpg.webp', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(170, 47, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811251/estp023_f704d9ca4a9142c587f3d01d7bf20088_master.jpg.webp', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(171, 47, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811249/estp023-2_e8cc41d54ae748558cbb1fefc99ffa80_master.jpg.webp', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(172, 47, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811245/estp023-3_cbe5abc9a09543df8bcd296c5b941ccf_master.jpg.webp', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(173, 41, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811242/estp015_a0e07e027c614085b06c261c289544ab_master.jpg.webp', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(174, 41, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811240/estp015-1_4850d0b18f664531958be981c80b3849_master.jpg.webp', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(175, 41, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811238/52984839667_2b60bd0a5c_o_3c6abb663b134583890c1f84a05afa34_master.jpg.jpg', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(176, 41, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811230/52985585104_6b4d0aa540_o_5bfd3df1d8074e8b988393d17058d82e_master.jpg.jpg', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(177, 41, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811227/52985814890_0e0f66878b_o_cb9d7e43b07940179e8a0377ef9f4496_master.jpg.jpg', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(178, 15, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811223/dstp903_52866905251_o_735380510ed1481090a9d817d712432b_master.jpg.webp', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(179, 15, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811220/dstp903-5_52899252161_o_fbbfca6789984d79a05a30395baebf8d_master.jpg.webp', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(180, 15, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811217/dstp903_52866328857_o_dcb32e4dd65b4c0692aba155328ae3f1_master.jpg.jpg', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(181, 15, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811213/dstp903_52867348133_o_1a35eb97c32d48aba7cc60754f132f89_master.jpg.jpg', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(182, 15, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811210/dstp903_52867348138_o_89a8c909f5ec431c9f313c754ae9e042_master.jpg.jpg', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(183, 15, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811206/dstp903_52867348178_o_9eaaa6a1c432440b8bc3a8863c2d4699_master.jpg.jpg', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(184, 15, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811196/dstp903-1_52899647210_o_3e4bedccc26c4921bf2d0e26cbd987bd_master.jpg.jpg', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(185, 15, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811203/dstp903-2_52899647325_o_d2a330409f00496ea82d68f220729469_master.jpg.jpg', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(186, 15, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811199/dstp903-3_52899414579_o_48d0f7660d7648f18f998fa3f52cd042_master.jpg.jpg', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(187, 15, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811192/dstp903-4_52899252121_o_ae557b13c3e54659beab9355b85ac6e1_master.jpg.jpg', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(189, 42, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811185/52984841597_c4f0a17882_o_537cdc00b2124e288af5d94002fba114_master.jpg.webp', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(190, 42, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811178/52984841637_be878f2e96_o_b2155ec1c2c6425a94b240f852a798d4_master.jpg.webp', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(191, 42, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811181/52985816615_83d5e68a16_o_a38ee4423e9a4d9e9a719237c6aa6f52_master.jpg.webp', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(192, 42, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811175/52985905053_bdeffa314e_o_aa67bed06deb439399cc2046790f8c59_master.jpg.jpg', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(193, 46, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811171/52901478774_f103d7180e_o_6ec337721b6d4a8bae3c2626bca7d037_master.jpg.webp', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(194, 46, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811169/52900747392_3bd87b9424_o_ef4fd5e38ee643538ccbfa25af4daa72_master.jpg.webp', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(195, 46, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811166/52900747527_b5ba3ab3a3_o_c0e500d9ecf04e648a5b4eadafa8c56d_master.jpg.webp', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(196, 46, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811158/52901708515_30006cf211_o_f3e3d22e5e3e42078feb7d3d311ef24c_master.jpg.webp', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(197, 46, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811154/52901317611_a0acf4ef9f_o_615c31feb98a4e81a2ef903f914370b3_master.jpg.webp', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(198, 46, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811151/52901708410_5a8af79350_o_a64f83bc7f1140c4bcd2cb9dfdcb1882_master.jpg.webp', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(199, 46, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811148/52901708465_503bdb72bc_o_44f82d09c0c549f7b87f0a9fc128200d_master.jpg.webp', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(200, 46, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811144/52901317591_9d166f4fa0_o_15c83e519bbb4b08bc17abc027167bb1_master.jpg.jpg', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(201, 43, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811140/tp018_0691972d076d4071a4fee5291912df9e_master.jpg.webp', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(202, 43, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811137/tp018---bk001-_14__c88cf49e00c3437cbed27b9e9b7e6bbb_master.jpg.webp', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(203, 43, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811135/52826112561_28a33161d2_o_863d94fe95454b768bab5808fcb136fe_master.jpg.webp', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(204, 43, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811129/20230418_utjkznvmqy_2bb5168802fa45a3aa7687b49275558c_master.jpg.webp', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(205, 43, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811126/20230418_zdan7vokau_193adb5ef92d4ff0a9628a7e8087719a_master.jpg.jpg', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(206, 45, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811124/estp021-2_7b1e8ac1a10c4163bf199b7b89332d81_master.jpg.webp', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(207, 45, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811122/52761369041_9f0e67d125_o_9032748cb48b41bc872cef7ab7b26fce_master.jpg.jpg', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(208, 45, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811119/3_a205919edf4d4446a1522a2c10bc383f_master.jpg.jpg', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(209, 45, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811117/4_c8d69e314ed348e4bd9c456f2721a78d_master.jpg.jpg', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(210, 45, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811114/5_1137cf2bb12540fe8f3e15d4b6719363_master.jpg.jpg', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(221, 40, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811112/estp014_f4dabbabbe0346598163050a85b06f1a_master.jpg.webp', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(222, 40, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811110/52963145971_d831ed870e_o_0cb9f3d06fb2434f92c94c572d9f7820_master.jpg.jpg', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(223, 40, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811106/52962545147_25055ccc29_o_af189f39f582417bb4e7d78258ba2afb_master.jpg.jpg', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(224, 40, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811101/52963145991_ed718131ed_o_c94a43b3e7be4f2d955466fc9ad6cafa_master.jpg.jpg', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(225, 40, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811090/52963286319_9f96c02b76_o_777e3a250afb437a834bb46e13a3b849_master.jpg.jpg', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(226, 39, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811086/tp012_0d295f194e3f4f0eab7eede288c3a7c5_master.jpg.webp', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(227, 39, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811084/52962546502_67cf66a988_o_50eedd51b47d489c851da09e2dd4787e_master.jpg.webp', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(228, 39, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811081/52963148566_1522e0b1d5_o_f23c0e6864fc465f8ba86fb4e02f6eca_master.jpg.jpg', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(229, 39, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811077/52963148571_85db89bd29_o_6be3d4ece33747288a86005d9ace3990_master.jpg.jpg', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(230, 39, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811073/52963526080_043a99d427_o_361c1c8965ed4a379649be937138d1a4_master.jpg.jpg', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(237, 14, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811070/tp650---bi801-_7__abbb944d2018481c829e959580b99514_master.jpg.webp', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(238, 14, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811066/tp650---bi801-_17__b30c2c74b038490f890dfec689b60602_master.jpg.webp', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(239, 14, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811064/1_dafd00796d394cdbafeebc27a23aebbe_master.jpg.jpg', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(240, 14, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811062/3_6e830c4790f546dd91780c15c5c3d2df_master.jpg.jpg', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(241, 14, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811059/2_3cd9ac4ea4134a5cb2377036c8858bfd_master.jpg.jpg', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(242, 14, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811057/4_485c2d0480d84e4b983817d401d0c65d_master.jpg.jpg', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(243, 54, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811054/5_66590d1cba6041359e8a89a1c7e0feb5_master.jpg.webp', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(244, 54, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811052/1_eaabf57d435740af8ed20d6f40378045_master.jpg.webp', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(245, 54, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811050/2_25c38d6c27394c258025535e2bc9d5bd_master.jpg.webp', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(246, 54, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811048/6_e4d2cb26997d464985a485cc7f212599_master.jpg.webp', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(247, 54, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811045/4_a52dff1ab14f48e7b978ced85dfb6806_master.jpg.webp', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(248, 54, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811043/estp047-1_1f39491e95314848a3036b88e0bdcc90_master.jpg.webp', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(249, 54, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811040/estp047-2_7378910d66be4c0a8dcc152afcb330e0_master.jpg.webp', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(254, 71, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811025/tp004_45415f65d7bc4f4c8d52f4893d682a43_master.jpg.webp', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(255, 71, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811022/tp004-2_572851b755514fa7b302d5120a7d3b94_master.jpg.webp', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(256, 71, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811019/5_14e1329ad875426cbc7afb776056eeae_master.jpg.jpg', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(257, 71, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811017/4_4d48bde78a5148fab5623251d0da8e08_master.jpg.jpg', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(297, 57, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810989/1701361255341_10_ab507de1e88747f99527ac4852b40535_master.jpg.jpg', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(298, 57, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810992/1701361255426_9_ae65d9fd2f8f4cfcb114ee123fcffd63_master.jpg.jpg', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(299, 57, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810996/1701361255431_8_62f9c35e209b490fa0012a46b2faada3_master.jpg.jpg', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(300, 57, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810999/1701361255434_7_e37142ddf18d4daa898aac91aa82eb92_master.jpg.jpg', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(301, 57, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811002/1701361255437_6_9622c2cf1ffe49dd9d06ac5ca4d10119_master.jpg.jpg', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(302, 57, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811005/1701361255440_5_5bf4a94b5b19485199441c580dae0f6a_master.jpg.jpg', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(303, 57, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811006/1701361255443_4_aaa0fd53411a441e85605a458aab67f7_master.jpg.webp', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(304, 57, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811009/1701361255445_3_e2f6d02236ac4e0397a15b372c85bfb2_master.jpg.jpg', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(305, 57, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811011/1701361255449_2_5933a603e4074662bfe7cc6b5fe1e44b_master.jpg.webp', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(306, 57, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811013/1701361255452_1_50f16dbd5df34aa3acc99865b4820084_master.jpg.webp', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(308, 32, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810005/1702537484257_esta010-5_2ba1b356efe4495cab57f32d9d25091c_master.jpg.webp', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(309, 32, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810008/1702537484260_esta010-4_270b822eb48441a1a53f5546346ddd40_master.jpg.webp', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(310, 32, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810011/1702537484263_esta010-3_0ba6357a968c46e0affaf07666b9c01b_master.jpg.webp', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(311, 32, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810013/1702537484266_esta010-2_8a537af4aa4444c0aa99eeaca96547da_master.jpg.webp', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(312, 32, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810015/1702537484269_esta010-1_ad9f734ad81a4f339a557960d10dd7f5_master.jpg.webp', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(313, 31, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810978/1702700896436_esta006-4_c514e01db8474d70b33092f7cd99164c_master.jpg.webp', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(314, 31, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810980/1702700896469_esta006-3_4df5bd70d3eb4967ad32074a57d6ba39_master.jpg.webp', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(315, 31, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810983/1702700896473_esta006-2_1c9f30407e6b4054a8e1d8851dcecdab_master.jpg.webp', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(316, 31, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810985/1702700896477_esta006-1_2a8dce82b88d4fd798c0434cf9bed833_master.jpg.webp', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(317, 29, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810963/1702701667209_eata005-2_d7ce58698163437ba1db1dedb9eb6b11_master.jpg.webp', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(318, 29, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810966/1702701667249_eata003-4_3278e31069de4a949432bdb95d84b15a_master.jpg.webp', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(319, 29, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810968/1702701667255_eata003-3_fcd31b6aead047a49d37bd2f4f15e7aa_master.jpg.webp', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(320, 29, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810970/1702701667264_eata003-2_06740cf99ddb4d81a574ea48aa9a34b9_master.jpg.webp', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(321, 29, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810974/1702701667271_eata003-1_c8e90efa55944401946efba4f0ae02bf_master.jpg.webp', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(322, 30, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810950/1702702646779_eata005-6_6c157a33937a44b497592693b64d7feb_master.jpg.webp', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(323, 30, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810953/1702702646814_eata005-5_3cc9485ee40445818e4c67208dcdf9b2_master.jpg.webp', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(324, 30, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810956/1702702646819_eata005-4_4024f1e717604680ace040117d1f362f_master.jpg.webp', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(325, 30, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810958/1702702646824_eata005-3_a2bc7b29fc1b47b6a97348d13ea83f41_master.jpg.webp', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(326, 30, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810961/1702702646831_eata005-2_ef46f711d4734ba6a8be08d07f8f3567_master.jpg.webp', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(327, 61, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810920/1702703208763_ests040-5_52987217372_o_72ea4d648501425a806b5111c47b91b6_master.jpg.webp', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(328, 61, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810923/1702703208771_ests040-4_52987961469_o_c152e6e7afcd4facbd707fb5586bc689_master.jpg.webp', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(329, 61, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810927/1702703208775_ests040-1_52988193050_o_0e50794abc7045348461b2a44f2f7756_master.jpg.webp', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(330, 61, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810930/1702703208778_ests040-3_52988281533_o_ef60746768644df19e5c12428fb5ed6b_master.jpg.webp', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(331, 61, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810934/1702703208781_ests040-4_52985587859_o_bc41df09b2474dc483a02fd152f7d372_master.jpg.webp', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(332, 61, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810937/1702703208783_ests040-3_52985817640_o_8ae0d260d3e2495991ce73334cbc2adc_master.jpg.jpg', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(333, 61, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810944/1702703208788_ests040-2_52985443091_o_82ed730d0f54440a839469648c303994_master.jpg.jpg', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(334, 61, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810945/1702703208791_ests040-1_52985817645_o_da637e28e79a4c9a8f467bc9801869fc_compact.jpg.webp', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(335, 61, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810947/1702703208795_ests040-2_52988193045_o_8fd6a00033484ba78cd9122314ac7912_master.jpg.webp', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(336, 62, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810901/1702717326826_ests044-7_52952326015_o_0bac266322e846e0a8fdfbef6ad564ac_master.jpg.jpg', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(337, 62, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810904/1702717326846_ests044-5_52952083504_o_5fae14cac84f41df80684c063252f356_master.jpg.webp', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(338, 62, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810907/1702717326849_ests044-4_52952325920_o_db452e2aca604cc99f713286eecff353_master.jpg.jpg', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(339, 62, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810911/1702717326853_ests044-2_52951946131_o_7ae2b619a4d64636be4010f88b76f599_master.jpg.webp', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(340, 62, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810915/1702717326858_ests044-1_52951946161_o_5b02f5c9e0ad4e30ad598e66309be6f9_master.jpg.webp', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(341, 62, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810918/1702717326862_ests044-3_52952396788_o_5673812b89994da69cfc7ad22ca9677e_master.jpg.webp', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(342, 58, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810882/1702717756299_52952382618_a5bfb52264_o_1dd1d8bfd5964b5ba39fa794245413c2_master.jpg.webp', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(343, 58, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810885/1702717756307_52951331472_2666f11939_o_4df65f417d014c27a790ea7f10643760_master.jpg.webp', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(344, 58, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810888/1702717756310_52951331432_de924a7667_o_ee8f89781bd546bbb3a8491609d8508b_master.jpg.webp', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(345, 58, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810891/1702717756312_ests021-2_e1e40d9fbd9949b3a121eb0118255897_master.jpg.webp', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(346, 58, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810894/1702717756315_ests021-1_c15a97c09eef4e6eb14482be0b841e8a_master.jpg.webp', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(347, 58, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810897/1702717756318_ests021_64a34ff68d6d4857bae234b1364576fc_master.jpg.webp', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(357, 60, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810392/1702802210671_52932807699_675718ff74_o_c51332dcd11d4ceb82ee7fd5d74a508d_master.jpg.webp.webp', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(358, 60, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810394/1702802210675_52933043930_8da87d7a6c_o_1af3f2feba9545f8be8a0a196b8b2567_master.jpg.jpg.webp', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(359, 63, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810398/1702802457847_ests046-4_52823383866_o_03a8719562174bfea3d3c34e9f6ce77c_master.jpg.webp', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(360, 63, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810401/1702802457852_ests046-3_52823787455_o_e32a02c616c541dea1916e0846fd4542_master.jpg.webp', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(361, 63, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810405/1702802457857_ests046-2_52823821213_o_c93187331d7744c5a2f29f0e0c12667a_master.jpg.webp', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(362, 63, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810408/1702802457861_ests046-1_52823383756_o_d4754aac7afc4e239bf0051796f9a08c_master.jpg.webp', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(363, 63, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810411/1702802457864_52822810917_399b0c9e61_o_f8b7ca92c7494149998a032945fdab3a_master.jpg.webp', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(364, 63, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810414/1702802457870_52933042335_6073fd6fbf_o_26515b1de83944d38a9c619c21cc769a_master.jpg.webp', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(365, 63, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810418/1702802457873_52932806289_bc52c62c78_o_f52bd9c5a85245f994c7648225599922_master.jpg.webp', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(366, 59, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810422/1702802725811_img_8589_52910931139_o_11a1939717b94032aee2aac1048f8f2f_master.jpg.jpg', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(367, 59, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810426/1702802725819_img_8588_52910203567_o_79d74ee4870542d5bb9c0c7d423fac31_master.jpg.webp', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(368, 59, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810429/1702802725823_img_8585_52911231748_o_2e3cb6c9417b4c4a863f3a1a66658fca_master.jpg.webp', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(369, 59, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810432/1702802725828_img_8583_52910203677_o_fb46608541cd4d43bcbf847e80ba49be_master.jpg.webp', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(370, 59, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810435/1702802725832_img_8582_52911164715_o_5a36f5119e5f450a859036561f4460f4_master.jpg.webp', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(371, 59, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810438/1702802725835_img_8578_52910203457_o_1a52bd3eab9049858c9e04b24c2df325_master.jpg.webp', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(372, 59, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810441/1702802725838_52932808504_eb04cf31e5_o_524c41c783ae49759badacbe15c3d9d7_master.jpg.webp', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(373, 59, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810443/1702802725844_52932058522_9aba18e17a_o_e54f4d9597d9417c80ecba97a29c218c_master.jpg.webp', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(374, 33, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810447/1702803852463_estb026-6_52823399121_o_7260dac727ce4fee98c47e9e1cface96_master.jpg.webp', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(375, 33, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810451/1702803852471_estb026-5_52823802475_o_3ac07df0a46749f8962e2c55cfcd89ce_master.jpg.webp', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(376, 33, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810454/1702803852475_estb026-4_52823836403_o_311a77c2f8a44b8f880af86b30450200_master.jpg.webp', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(377, 33, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810457/1702803852478_estb026-3_52823836533_o_d186ef013d2f4c84bc2ca03d360d935e_master.jpg.webp', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(378, 33, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810461/1702803852482_estb026-2_52822826977_o_0a051c27711c4eda8825e1a294e527d7_master.jpg.webp', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(379, 33, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810464/1702803852487_estb026-16_52822828202_o_3756dfb1091b4d09895dce49845d4e0e_master.jpg.webp', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(380, 33, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810466/1702803852491_estp026-2_8be997547b86427abb4dfb61fc15a5bf_master.jpg.webp', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(381, 33, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810468/1702803942376_estb026-22_52823803520_o_718ac96b8e95469db8a8ef74a023c2dc_master.jpg.webp', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(382, 33, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810471/1702803942380_estb026-17_52823400941_o_28946e8fe13e4123ae9010a5d2004bcd_master.jpg.webp', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(383, 33, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810474/1702803942386_estb026-11_52822828632_o_fb5c8442ec4146618cca5021c9f98643_master.jpg.webp', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(384, 11, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810477/1702806015784_52659779297_47f3c457bc_o_a51ef16f093348b6b4f3cf870e85e08d_master.jpg.webp', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(385, 11, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810479/1702806015791_52660278521_2f6709e709_o_5d182bb3af21461d92187ab883f3e1db_master.jpg.webp', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(386, 11, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810482/1702806015796_52660277426_dc504ee577_o_21bd4f09db1d40e68e692253e8796e4b_master.jpg.webp', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(387, 11, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810485/1702806015800_52660278786_9ba122257e_o_929bf419522b4ae0ae7e2c6a6fb1b46d_master.jpg.webp', '2024-05-14 10:46:32', '2024-05-14 10:46:32');
INSERT INTO `imgs_product` (`id`, `product_id`, `file_img`, `created_at`, `updated_at`) VALUES
(388, 11, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810488/1702806015803_52659780022_276e6ffe8f_o_538cb00491c24f7c8b6f1a02b952220c_master.jpg.webp', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(389, 11, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810491/1702806015806_52660723970_bfd1c8d37d_o_1661ae6b3e4b44c281d809ceffd1fe58_master.jpg.webp', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(390, 11, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810494/1702806015812_52660558534_e1239eeb1b_o_786802e53d3843e19392b3f4e5199c71_master.jpg.webp', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(391, 12, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810497/1702806426600_52676411040_14a9edf7fb_k_274a9ee91f644bb497574ddf187a898a_master.jpg.webp', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(392, 12, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810499/1702806426607_52675982306_1de686897f_k_b3f1e82afd564d57939092ede2e8712d_master.jpg.webp', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(393, 12, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810501/1702806426610_52676267734_29ce1b8952_w_b5e73e512a94405184fa5e20ecf65fcc_master.jpg.webp', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(394, 12, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810503/1702806426613_52675471287_ce95e63b8d_c_27120fb7463643f8bfb96af8f03a4f1b_master.jpg.webp', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(395, 12, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810506/1702806426616_52676267774_9c7d4176e8_k_559ce960bc8b48a68d7aa9f1710f6cf7_master.jpg.webp', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(396, 12, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810508/1702806426620_52675981811_16343f35a9_o_47f611111bbb46b3a3499a88b25c1126_master.jpg.webp', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(397, 12, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810511/1702806426624_52676410670_9925195387_o_f81c51d94f4c452e8a98502af8e27a65_master.jpg.webp', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(398, 12, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810514/1702806426628_52675470897_244d30d8d3_o_153eb48e037a42f4b422012eeb8edfcd_master.jpg.webp', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(399, 12, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810517/1702806426631_52675470952_bac5dde46f_o_6e072690900e4c5bb133f84a697b0f1e_master.jpg.webp', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(400, 12, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810519/1702806426637_52695476781_bac6e21f9c_k_fec22b5dee744ea0b0d2b622f99451fc_master.jpg.webp', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(401, 12, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810527/1702806426640_untitled_design__5__5744f2809b2c4d3499ef8f70899e3c18_master.jpg.webp', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(402, 23, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810531/1702806927283_eatb006-7_c9e79db0114c4200a63cd60475d6a122_master.jpg.jpg', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(403, 23, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810534/1702806927289_eatb006-4_a248aa8e293a4fddbbdde47a4756d047_master.jpg.webp', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(404, 23, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810536/1702806927292_eatb006-3_ce2f16403e4b49bd990f26b44947fce5_master.jpg.webp', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(405, 23, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810538/1702806927296_eatb006-2_0511ad8acf754ee995e7c81347160cc6_master.jpg.webp', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(406, 23, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810540/1702806927300_eatb006-5_697cbbe50fd24f45b3b62366f5bf48e8_compact.jpg.webp', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(407, 23, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810542/1702806927304_eatb006-5_697cbbe50fd24f45b3b62366f5bf48e8_master.jpg.webp', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(408, 23, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810545/1702806927308_eatb006-9_b1e0eef7be8c449dbab0b49c24dd2e48_master.jpg.jpg', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(409, 23, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810548/1702806927311_eatb006-8_dc7583950c78485f9c62a509cccab61f_master.jpg.jpg', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(410, 23, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810551/1702806927317_eatb006-6_ed5bf9508fe94a6da12e90ebd637f5bb_master.jpg.webp', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(411, 23, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810553/1702806927321_eatb006-1_802efda9723841d59eb56fabb46d7b22_master.jpg.webp', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(416, 22, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810556/1702807767083_eatb003-8_084c26b6c7684eb8b046a72e61083bb7_master.jpg.webp', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(417, 22, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810559/1702807767088_eatb003-7_46d35176d4ad45afb53f50cb2bde044c_master.jpg.webp', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(418, 22, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810562/1702807767092_eatb003-6_8eced11e6d14459cbb181b09b51ae20a_master.jpg.webp', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(419, 22, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810565/1702807767097_eatb003-5_a9d10239ad594405819d73174c16f106_master.jpg.webp', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(420, 22, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810569/1702807767101_eatb003-4_438ed372ba5047269b3eabc8cee7d87f_master.jpg.webp', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(421, 22, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810572/1702807767105_eatb003-3_a934a4382e84499b9a267b113bd841e5_master.jpg.webp', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(422, 22, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810574/1702807767111_eatb003-2_67d23b0fe4d24d15af3c78bb21a49bf7_master.jpg.webp', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(423, 22, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810577/1702807767115_eatb003-1_4b6bae1705b84deabfa237c94373b36e_master.jpg.webp', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(424, 8, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810579/1702808414165_dabk906-6_927e60d4ebbb4678b0d68f10ab3a54a2_master.jpg.webp', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(425, 8, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810581/1702808414171_dabk906-5_98aa9c0da5cd4fb2a5cef7a73cefe36c_master.jpg.webp', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(426, 8, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810583/1702808414176_dabk906-4_94214472d2504fea9977e199bfbdbd60_master.jpg.webp', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(427, 8, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810585/1702808414180_dabk906-3_2e0eebbdc700441aa2c8455d175db942_master.jpg.webp', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(428, 8, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810587/1702808414184_dabk906-2_bac3936bf9d84867b4992915c17c55e4_master.jpg.webp', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(429, 8, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810589/1702808414188_dabk906-11_a2d5c942c2ff436c9f872d7393b79bff_master.jpg.webp', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(430, 8, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810591/1702808414194_dabk906-1_6be1255f7e6b427094e410388cb5f6a1_master.jpg.webp', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(431, 9, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810595/1702808850326_52709644909_ec78a5b681_o_2b532365a459475087eb1a60f1d7bf18_master.jpg.webp', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(432, 9, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810597/1702808850332_20230112_kkdpzqbmudplbn4v_2ad921ea8c3446c8b03eac34c60ea840_master.jpg.webp', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(433, 9, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810599/1702808850335_20230112_yemiyu2ietsvb00e_0133472491ac484380875734194b366e_master.jpg.webp', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(434, 9, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810601/1702808850338_20230112_aegxlx220r0cyabo_79e1cfa1e7994745ae2a63f075017a50_master.jpg.webp', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(435, 9, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810603/1702808850340_20230112_aswzjkmbtcswuecm_759b78b711fe4fccb346aafbb72afe3b_master.jpg.webp', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(436, 9, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810612/1702808850344_52572958209_7a8958f472_o_6a35eb314f4e4386ba252c4c13aa46b9_master.jpg.webp', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(437, 9, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810616/1702808850347_52572958079_bf18582296_o_b7b494c15e3d4e6eab215767950ac091_master.jpg.webp', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(438, 9, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810620/1702808850350_52573214058_ae17e2ec7d_o_ae0d8762ed534d7da5f489fea388fb4a_master.jpg.jpg', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(439, 9, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810623/1702808850353_52573133940_b5a8447253_o_cf8db422a9e04d11af61493907e9ebc8_master.jpg.webp', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(440, 9, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810625/1702808850356_tp038---bk908-_23__34e8865287bc432c881c61e4c3b1614b_master.jpg.webp', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(441, 9, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810628/1702808850360_tp038---bk908-_20__de063447c1d34cf0a62c34b18ed2ffe6_master.jpg.webp', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(442, 21, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810631/1702809314674_eabt021-7_52952129974_o_36dd5e232c944505837e328306ca06d5_master.jpg.webp', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(443, 21, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810636/1702809314794_eabt021-6_52951392377_o_06751b36a0b049c8a230d80e9b86d2e7_master.jpg.jpg', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(444, 21, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810639/1702809314990_eabt021-3_52952129939_o_165a74ba54fe4f90afd689129e088fdb_master.jpg.webp', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(445, 21, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810642/1702809315238_eabt021-2_52952443573_o_0c155321a61a4f33a482c51d6c0a1352_master.jpg.webp', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(446, 21, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810645/1702809315614_eabt021-1_52951392367_o_e8f1b01918b54bc1a2631568f5dd458b_master.jpg.webp', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(447, 21, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810647/1702809333060_eabt021-4_52951993446_o_0d23aa6812b3462cb69bdc6b19240434_master.jpg.webp', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(448, 20, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810650/1702809798197_52776871749_e2c0b1e895_o_b3a1b7a40a0d426e878457df4294018c_master.jpg.webp', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(449, 20, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810652/1702809798471_20230412_uq4kjvcmhj_70b56b5513de4d3ca66eac59642bef97_master.jpg.webp', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(450, 20, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810654/1702809798810_20230412_fmolgheqgq_ff309b08c2d4476e895a27df755bef47_master.jpg.webp', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(451, 20, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810655/1702809798874_20230412_i6l1zc67ts_d280fbc65e18401ba4be9fbf7a47c917_master.jpg.webp', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(452, 20, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810658/1702809799004_52777027695_4802662c62_o_9cf976a814c74d1299a1a4e437d368c9_master.jpg.jpg', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(453, 20, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810663/1702809799788_52776082972_d2e0349123_o_3b566765f10941fa8472b88063934868_master.jpg.jpg', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(454, 20, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810667/1702809799967_52776615421_ec4b245843_o_449061a74c534691b47fa009d785f46d_master.jpg.jpg', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(455, 20, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810670/1702809800088_52776615181_dcef200531_o_4e1c687fb840415a91c6320fe561c127_master.jpg.jpg', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(456, 20, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810672/1702809800238_tb041---bt019-_17__d4d6e2ec2dbf4dd897653f55781b4dcb_master.jpg.webp', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(457, 20, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810674/1702809800334_tb041---bt019-_14__13addb6f4b634d3bb1df83649ff1fdde_master.jpg.webp', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(458, 3, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810678/1702810004147_52706148983_5e4cb0e46b_o_71a63d69ea764111817caab180516083_master.jpg.webp', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(459, 3, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810681/1702810004151_52706072330_c3ea1c6f70_o_218112c649264444827f130a5899eabd_master.jpg.jpg', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(460, 3, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810691/1702810004154_52706072235_9bf8c4e344_o_3275d856899841e194d0a50d5351fb2a_master.jpg.jpg', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(461, 3, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810696/1702810004156_52705134232_5dabe57723_o_284ab3859ae841c599e3e216c35d43f3_master.jpg.webp', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(462, 3, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810699/1702810004160_52705134532_9641266ba5_o_b0cd484e75c9447580fa232f4eef872c_master.jpg.webp', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(463, 3, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810701/1702810004163_52706071935_8966d1e12f_o_a66489be76c949d791609a08ca73993f_master.jpg.webp', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(464, 4, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810705/1702810256788_52167839967_2127960c61_o_d192322094cd4d1dab1790f5a4995e51_master.jpg.webp', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(465, 4, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810709/1702810256792_52169109624_4b0fdfea3e_o_d9919592f8e043f782d44ce65902c365_master.jpg.webp', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(466, 4, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810712/1702810256794_52168871298_5574f48047_o_34c442454a2d44fab30dd83481d5db41_master.jpg.jpg', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(467, 4, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810718/1702810256797_52167839292_d0471b70ce_o_7501f2fc994447218a00785c60f6bba7_master.jpg.webp', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(468, 4, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810721/1702810256802_52168871363_a4f22ded3c_o_027ce5b100a048bab3770456a090fe81_master.jpg.webp', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(469, 4, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810725/1702810256805_52169342265_2c7137e4bf_o_fa2fa32197bc4613973a8ddd59e488c0_master.jpg.webp', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(470, 4, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810727/1702810256808_52169110354_87bd6ccaa0_o_abf9f4cabd204376b1d1cba50d2deec9_master.jpg.webp', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(471, 5, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810730/1702810455332_52417006300_6f7ea894a2_o_155f8f02ec1b4c1fb2614e54faa89714_master.jpg.webp', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(472, 5, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810734/1702810455336_52417006270_e73e119ab9_o_3be117debb524beb882cb2d799498554_master.jpg.jpg', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(473, 5, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810740/1702810455340_52416563431_3f20b3e7c6_o_c89fbf176f5a4ecf93ee976ac7f76ffe_master.jpg.jpg', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(474, 5, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810743/1702810455343_52416845114_1fcba8292b_o_4a1de055394249548a5c8916b47fb821_master.jpg.webp', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(475, 5, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810746/1702810455346_dabj903-1_c6addc33aefe4f808d540f501dce25d0_master.jpg.webp', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(476, 5, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810748/1702810455348_dabj903_bf925f25f2c244aeb43a9c4430f64ef8_master.jpg.webp', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(477, 7, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810752/1702810648495_bj908-9_53198470183_o_2e9f86b18a2f4a8aaf1618dd68a5f2ef_master.jpg.webp', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(478, 7, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810755/1702810648499_bj908-8_53198052049_o_6c073d7ec7154209ba1631016af4beb9_master.jpg.webp', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(479, 7, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810759/1702810648502_bj908-7_53198579615_o_e8f28cfb917c43ed8426007765cac1de_master.jpg.jpg', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(480, 7, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810762/1702810648505_bj908-1_53197785252_o_5ce6fb79a2c5406e9653f8d522cc482b_master.jpg.webp', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(481, 7, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810765/1702810648509_bj908-6_53198579650_o_262e43d6cbbc44308abb23db80c9eb69_master.jpg.webp', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(482, 7, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810768/1702810648513_bj908-2_53198051989_o_d8c0aeb3be18470c95b4e19e4481b38d_master.jpg.webp', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(483, 2, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810770/1702810774286_cabj003-1_4c7c6104568d47139ab4f9b9df4e6a87_masterkpg.jpg.webp', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(484, 2, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810773/1702810774291_cabj003_75aa0eb2e3ef4d7cb175dcef6ceae9cf_master.jpg.webp', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(485, 6, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810776/1702810960842_52419688925_095875bbed_o_cdd18641318f48cda52c00a2c30264b8_master.jpg.webp', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(486, 6, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810781/1702810960848_52419688890_5e23d5cff3_o_d70f528721b945d4a34ccd1b51fb1362_master.jpg.jpg', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(487, 6, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810785/1702810960851_52419529844_90ed9dba78_o_9eef75f8b7b84523936675cd9fb42063_master.jpg.jpg', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(488, 6, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810788/1702810960854_52419250611_0f82236c1f_o_83cb1b62f83d4f698f691b321e12cac5_master.jpg.webp', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(489, 6, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810791/1702810960857_52418739412_cc775bbaa6_o_01791bf8f88049af935fc784aeea69f1_master.jpg.jpg', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(490, 6, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810794/1702810960863_20230209_2nqi04eclesynryo_614790fe9b5a479095c6726ef90f2df7_master.jpg.jpg', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(507, 28, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810801/1702812011588_esbw005--9_52899674460_o_296b1f20ae9941f6b17a610ac00d49b7_master.jpg.webp', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(508, 28, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810804/1702812011592_esbw005--7_52898705557_o_20994a6240134dc18c19850099a85f72_master.jpg.webp', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(509, 28, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810807/1702812011596_esbw005--6_52899279301_o_a9b92cb1a220466fb40a137f6b1032fc_master.jpg.webp', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(510, 28, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810810/1702812011599_esbw005--5_52899727433_o_f2e8e5c559fd4fad91e417a4fef1bc23_master.jpg.webp', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(511, 28, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810813/1702812011601_esbw005--3_52899440664_o_07f1e33f83c044bab736e9a55753d6b1_master.jpg.webp', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(512, 28, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810816/1702812011637_esbw005--2_52899440654_o_9d430ebd4f3c4efca91917e765c00d48_master.jpg.webp', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(513, 28, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810819/1702812011640_esbw005--1_52899279126_o_d3ed642f59914badb1c93ea5d031d2e8_master.jpg.webp', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(514, 28, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810822/1702812011644_ff_15927ceaf8c342d68b92a6f8f4488382_master.jpg.webp', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(516, 28, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810827/1702812110775_4268bd5eeb3e637ed3b_master.jpg.webp', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(517, 27, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810829/1702812478065_esbw004-9_52898739082_o_c82e5ce820cf41528e0d7a18081780ab_master.jpg.webp', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(518, 27, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810832/1702812478069_esbw004-8_52899706940_o_c1d188c2dba54add95671fe3d6937d7a_master.jpg.webp', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(519, 27, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810836/1702812478072_esbw004-7_52899707115_o_32f0c7e0c35445a095a9ca8c75344f20_master.jpg.webp', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(520, 27, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810839/1702812478074_esbw004-6_52899707285_o_f85f1a38257140879eb69b09e6d63608_master.jpg.webp', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(521, 27, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810843/1702812478078_esbw004-5_52898738362_o_d0ac614afbf24774b6edfb647a42ed0f_master.jpg.webp', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(522, 27, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810846/1702812478081_esbw004-4_52899760808_o_d8a6e9f0f34844feaf0a265800eef988_master.jpg.webp', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(523, 27, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810848/1702812478084_gg2_76e1acff4af64c92824f810fd840d106_master.jpg.webp', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(524, 27, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810851/1702812478087_gg_9291a873c71b40fe81bd4a65e6e9e1cf_master.jpg.webp', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(525, 27, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810853/1702812478091_esbw004-12_52899473574_o_36fe3a92153a417b89b69bf2ce2d1490_master.jpg.webp', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(526, 26, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810254/1702812911809_esbk007-19_52988201020_o_3df16f49342548df98e932f189c1484a_master.jpg.jpg', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(527, 26, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810258/1702812911813_esbk007-6_52988289443_o_d2d6cd03c5d84efab4ae4506ebb269ed_master.jpg.webp', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(528, 26, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810262/1702812911816_esbk007-5_52988289468_o_5d54497d13494a938810a0d461885986_master.jpg.webp', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(529, 26, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810266/1702812911820_esbk007-4_52988289103_o_05529d8d255e47ab9f049e81f195f63a_master.jpg.jpg', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(530, 26, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810270/1702812911824_esbk007-3_52988289118_o_26a2149e64da47fb812bce27361703a6_master.jpg.jpg', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(531, 26, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810273/1702812911827_esbk007-2_52988200955_o_cb741fb89c754e52a289bac1b7dc4359_master.jpg.jpg', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(532, 26, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810277/1702812911829_c_266c13d20919488f8a43881fd3d86ca3_master.jpg.webp', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(533, 26, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810282/1702812911835_a_01ad865f36cf4eb9bd17ae50ff4d7a76_master.jpg.webp', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(534, 26, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810284/1702812911838_b_d29e6bdf78d04be1aa1575b44e69b2fb_master.jpg.webp', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(535, 25, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810287/1702813549110_esbk002-17_52813989875_o_d400362148e04736bda41b2b86844201_master.jpg.webp', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(536, 25, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810289/1702813549116_esbk002-18_52814032098_o_8804bbb1b3d74439abaee51731a82b2b_master.jpg.webp', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(537, 25, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810293/1702813549119_esbk002-14_52813577276_o_2caabc86a631431c94c8ad7d198b438d_master.jpg.jpg', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(538, 25, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810295/1702813549122_esbk002-11_52813020512_o_6c397ca1a0484b66af09d98258cae11c_master.jpg.webp', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(539, 25, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810299/1702813549126_esbk002-25_52813772009_o_7cbce75ae5e645bcaec61489c3f6d783_master.jpg.webp', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(540, 25, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810303/1702813549130_esbk002-2_52813988905_o_bd8d3514db464a4e840a78635c9a192b_master.jpg.jpg', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(541, 25, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810312/1702813549133_esbk002-22_52813989440_o_072320897e0244c2946de08e00e68df5_master.jpg.jpg', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(542, 25, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810315/1702813549136_esbk002-19_52813772554_o_f63f7a794f0a4f3f96b3b22d212f378a_master.jpg.webp', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(543, 25, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810318/1702813549140_esbk002-8_52813990600_o_bbba896fe3744d0584fdce524ff888b1_master.jpg.webp', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(544, 25, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810320/1702813549143_esbk002-5_52813988720_o_52117d456e3d48d89d4c0b1e9cb62f93_master.jpg.webp', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(545, 25, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810323/1702813549146_52933853146_59370d1582_o_4bf573d486474c43b806540d25a49b65_master.jpg.webp', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(546, 25, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810325/1702813549148_52933853176_7967f42e52_o_208bdabebdb14986a84a5ed6be961474_master.jpg.webp', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(547, 1, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810330/1702814188800_20220214_rqmdfbzelhqp14kvbyjdov8e_4adea06d26014521b26f886e16175c5d_master.jpg.jpg', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(548, 1, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810333/1702814188803_20220214_aa2dxth7npokvdt73rxflrsg_e686cb6ec1be4f309c5a8b1305f8769c_master.jpg.webp', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(549, 1, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810337/1702814188807_20220214_cmjadhbvnqgvj2dl8qxlmkst_18dfb5a80b834f6d826e7b7918365b27_master.jpg.jpg', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(550, 1, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810341/1702814188816_20220214_yzxa3v6zuawe6zcbvw47ty0t_a101bd2336ef4b7091c1a97ed5734b09_master.jpg.webp', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(551, 1, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810344/1702814188820_20220214_9sqxfrp87yzcgtfw5gnv103y_ec5fec57d7f44d14819f71329d391d4d_master.jpg.webp', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(552, 1, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810348/1702814188823_20220214_zquxm0k25vusrzskw8qojnex_d0321582dc3342f4bb38d89f5c134a84_master.jpg.webp', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(553, 1, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810350/1702814188826_51988114534_238cde3543_o_7883ded929414df59b56b76e9a22e117_master.jpg.webp', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(554, 1, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810353/1702814188828_51988381170_eacbdaf22c_o_0e57a352daa34f50b70e03e77ec62792_master.jpg.webp', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(555, 1, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810357/1702814188831_51988114499_06741b197e_o_0ee210085cda4f85bc007c830526c361_master.jpg.webp', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(556, 1, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810360/1702814188835_51987823711_a1e404ba0d_o_075443e0b38240cd9b55ff269537bc67_master.jpg.webp', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(557, 1, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810363/1702814188838_tp038---bi013-_19__8e5d8348310741e48649ae329ee3e014_master.jpg.webp', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(558, 1, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810365/1702814188840_tp038---bi013-_20__790f72cbd3d34a918920b73579e72ea5_master.jpg.webp', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(559, 24, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810369/1702815216156_esbi006-9_95f00d733aba478891e327cea219dafb_master.jpg.jpg', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(560, 24, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810372/1702815216161_esbi006-8_efa8504febac44bc85dd73720a522e65_master.jpg.webp', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(561, 24, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810377/1702815216164_esbi006-7_e98b77784d774dc686f70e02e792fa68_master.jpg.webp', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(562, 24, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810380/1702815216168_esbi006-5_cdcf55a55aed4974a2116be589cb2504_master.jpg.webp', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(563, 24, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810382/1702815216171_esbi006-4_a3a684a716104aed8998d0f3dfd393f5_master.jpg.webp', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(564, 24, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810385/1702815216174_esbi006-2_0080bf175388476fa2cb9a7e9f3d728c_master.jpg.webp', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(565, 24, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810389/1702815216177_esbi006-1_405724795b8f4f22867f345eaab26319_master.jpg.webp', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(601, 10, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810237/1703435106872_52695476436_cfce895223_o_32bf8a7c12f04f34963103b2b30b3dd0_master.jpg.webp', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(602, 10, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810243/1703435106878_untitled_design__1__8e8dab846c1c444385812026eb549eb8_master.jpg.webp', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(603, 10, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810245/1703435106881_datb416_e53618f106c54b85a436bd3e7f3025db_master.jpg.webp', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(604, 10, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810249/1703435106886_52695741049_ab53170a62_o_d4d8d423351a4330b41d0fc19ade0513_master.jpg.webp', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(609, 16, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810226/1703928526192_bs012-7_52616063791_o_b73fd2ba1d004e6e9b6e00056a74a633_master.jpg.jpg', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(610, 16, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810228/1703928526208_bs012-4_52616554758_o_2d13878e693346e18cfb465e5e5d92aa_master.jpg.webp', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(611, 16, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810230/1703928526215_bs012-3_52615554827_o_cdf36ab14e2948ab984bbfe0c18c72ed_master.jpg.webp', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(612, 16, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810232/1703928526222_bs012-2_52616064151_o_3574494468a940998f25c86d6f815504_master.jpg.webp', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(613, 16, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810234/1703928526228_bs012-1_52615553322_o_0d15a75065ed4bf59b9e03ecded5d334_master.jpg.webp', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(615, 67, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810203/1704189991759_ewcw007-5_53a856c3e86b422d975b1323eb87e578_master.jpg.webp', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(616, 67, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810205/1704189991824_ewcw007-4_73d717aacbbb49539e8941f53860fb81_master.jpg.webp', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(617, 67, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810208/1704189991831_ewcw007-3_309fb3d06ea84910af0060f7178ba85c_master.jpg.webp', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(618, 67, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810210/1704189991836_ewcw007-2_91d0cfce3d134bb4b72cc3086067df2f_master.jpg.webp', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(619, 67, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810212/1704189991841_ewcw007-1_c8b1f230ddb2408daa72728d0ecee531_master.jpg.webp', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(620, 17, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810190/1704190979892_ct001_51763349788_o_786e5178773a4a1fb56f1bfee2157e9b_master.jpg.jpg', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(621, 17, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810193/1704190979915_ct001_51763349443_o_c46a7b646c5741ca865598fe0249b69b_master.jpg.webp', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(622, 17, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810196/1704190979920_ct001_51762271912_o_1e27b353ce35445b98aa64a0c024c655_master.jpg.webp', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(623, 17, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810198/1704190979924_ct001_51762269147_o_09bc5494840e48feb5ad0b9b16c3d37b_master.jpg.webp', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(624, 17, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810200/1704190979928_ct001_51762266972_o_9bee17ad6de44acca391c7ad9847bf08_master.jpg.webp', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(625, 18, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810177/1704191300141_ct004-5_52410247588_o_e018274348ee4e508c3bcd3e45191163_master.jpg.webp', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(626, 18, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810179/1704191300155_ct004-4_52409234072_o_c1cc144681a64b2da46f4a881600383c_master.jpg.webp', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(627, 18, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810182/1704191300165_ct004-3_52409738056_o_03e4212ea4ec4b85a89193a2233e3f29_master.jpg.webp', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(628, 18, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810184/1704191300171_ct004-13_52409234777_o_e7c882ac09994daaa3ef8a4b92a5614b_master.jpg.webp', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(629, 18, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810186/1704191300176_ct004-2_52410023919_o_fe0e3f9c03f642cf9309596415dc2278_master.jpg.webp', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(630, 19, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810173/1704191606458_20220929_3dshbpb0pecj63dcrkmah5yc_85f0fa938a844dc2a433bc82c3147ad4_master.jpg.webp', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(631, 19, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810174/1704191606465_20220929_eflqusorg4g4ku3umeps5z9r_389f739d70b645d8a1d6a49d9b745c7b_compact.jpg.webp', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(632, 65, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810159/1704250844847_ewcl003-3_53375595102_o_0f63b002aa3c4f57bc06d9ac92da343d_master.jpg.jpg', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(633, 65, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810162/1704250844861_ewcl003-2_53376963630_o_d253bb8cf4404fd18f7fb241c31b57eb_master.jpg.webp', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(634, 65, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810166/1704250844866_ewcl003-1_53375595057_o_fbf3267675b14c9780e1db57c53ea93c_master.jpg.jpg', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(635, 65, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810169/1704250844871_ewcl003-4_53376696493_o_f4e0d55389724e0cbab7cc411b7e7c0c_master.jpg.webp', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(636, 65, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810171/1704250844877_ewcl003-7_53376839244_o_be698d6fa9ab4f78bf2132679fc67647_master.jpg.webp', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(637, 66, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810135/1704251255788_ewcp002-23_53376842769_o_b7a0db0f11ca48088531456f72fdf5d1_master.jpg.webp', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(638, 66, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810138/1704251255810_ewcp002-21_53376967225_o_c150908e08e04b278de0f946bbe0e0ef_master.jpg.jpg', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(639, 66, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810141/1704251255816_ewcp002-20_53376521336_o_8acdf223364e4793aaf2a88c807b1838_master.jpg.jpg', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(640, 66, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810144/1704251255819_ewcp002-19_53376967265_o_01a8b7e951684afe9a01377cf739adba_master.jpg.webp', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(641, 66, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810147/1704251255823_ewcp002-22_53376699893_o_cd07acb23daf4c36a173731d6b33d8d3_master.jpg.webp', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(642, 66, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810149/1704251255826_ewcp002-11_53376521661_o_7b2fbf44c1f142a3ba2bc974def12378_master.jpg.webp', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(643, 66, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810152/1704251255829_ewcp002-3_53376520886_o_84a65b23bbfb4c54952d7d289b6e1ea8_master.jpg.webp', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(644, 66, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810153/1704251255834_ewcp002_53375619402_o_d0011756fdc646f79c7a39698e026fb8_master.jpg.webp', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(645, 66, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810156/1704251255837_ewcp002-30_53376967025_o_d452a9fe67ca4f9b9803a72fa15b64fd_master.jpg.webp', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(646, 64, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810118/1704251897974_fds.jpg.webp', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(647, 64, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810120/1704251897979_tw003-bs001-16_53290120977_o_cb4dfe2b55f74902ac3f0f64b38f6938_master.jpg.webp', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(648, 64, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810124/1704251897983_tw003-bs001-15_53291378099_o_66f09820de5a4e4f831b38eea4352fd5_master.jpg.webp', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(649, 64, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810126/1704251897988_tw003-bs001-11_53290121042_o_3786274e4f1c4ab88f1f015c551df7db_master.jpg.webp', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(650, 64, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810128/1704251897992_tw003-bs001-1_53291249648_o_e56244e6c0dc497e81cf8ca94a772493_master.jpg.webp', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(651, 64, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810130/1704251897996_tw003-bs001-2_53291377864_o_a93a2eb880cc4107a3a360378ed056fb_master.jpg.webp', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(652, 64, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810132/1704251898000_tw003-bs001-3_53291377849_o_110158d740fc40de9fceb818bda1132b_master.jpg.webp', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(653, 34, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810097/1704715289463_eatb030-7_782d228809784ac3865f80fc627aca89_master.jpg.jpg', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(654, 34, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810100/1704715289509_eatb030-6_aafbbad5453d4849876c636b5e4eaafa_master.jpg.jpg', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(655, 34, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810103/1704715289513_eatb030-5_1cfb4bdeccc14e5e8a4bb2d2eb22b2ee_master.jpg.jpg', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(656, 34, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810105/1704715289516_eatb030-4_736d2c9b503b4c02abae3f66998470f2_master.jpg.jpg', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(657, 34, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810108/1704715289522_eatb030-2_035426c852274f5881fe4cdbe7b7b137_master.jpg.jpg', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(658, 34, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810110/1704715289525_eatb030-1_994ff9e272a742e5af8ec9612e29cc73_master.jpg.webp', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(659, 34, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810112/1704715289529_eatb030-8_a93e54fb6b5a467dbeaa6d051fedcab2_master.jpg.jpg', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(660, 34, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810115/1704715289535_eatb030-3_f4f3649109194318999a3e984bbd30f3_master.jpg.webp', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(668, 69, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810037/1707657567733_tw003-bs001-7_53291006361_o_23d925c5d5fa4a95a81b830c4d783545_master.jpg.jpg', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(669, 69, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810039/1707657567754_tw003-bs001-4_53291249503_o_ef651bccfb984910b8e975fc3ad7beb3_master.jpg.webp', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(670, 69, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810043/1707657567757_tw003-bs001-2_53291377864_o_46e46bd906e8427199e10879f20aeec4_master.jpg.jpg', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(671, 69, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810046/1707657567761_tw003-bs001-8_53291006896_o_3d92c51738cc4ce3a9aa8a2200de966c_master.jpg.jpg', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(672, 69, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810048/1707657567765_tw003-bs001-5_53291006421_o_4c146c1d885147f3a8b19ce1a8bffbc1_master.jpg.webp', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(673, 69, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810050/1707657567769_tw003-bs001-3_53291377849_o_b80f1bc8d383439fb26263361ce7d0b9_master.jpg.webp', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(674, 69, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810052/1707657567773_tw003-bs001-6_53291471625_o_1f620c3d758e41d696fb128d159744a2_master.jpg.webp', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(677, 68, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711809993/1708267758741_ewte003-11_53296667811_o_7264b0c3f1ef468b88b3ce5f020da6c1_master.jpg.webp', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(678, 68, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711809996/1708267758748_ewte003-3_53295791637_o_480ba53e2ac94b97a948a4eacabd56ac_master.jpg.webp', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(679, 68, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711809999/1708267758753_ewte003-2_53295791657_o_78ef8b9c0744454ebaa261ef2461d146_master.jpg.webp', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(680, 68, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810001/1708267758758_ewte003-4_53297045664_o_0700cdbe5f3342d5a10b2719f03c7ab1_master.jpg.webp', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(681, 68, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810003/1708267758762_ewte003-10_53297045794_o_af9bd1f2fa8246dab498a75b2a976f04_master.jpg.jpg', '2024-05-14 10:46:32', '2024-05-14 10:46:32'),
(721, 1, 'https://res.cloudinary.com/dmmvhjl0m/video/upload/v1719675386/ftvvtzvmfkefbxuhlrio.mp4', '2024-06-29 15:36:27', '2024-06-29 15:36:27');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `invoices`
--

CREATE TABLE `invoices` (
  `id` int(11) NOT NULL,
  `invoice_code` varchar(8) NOT NULL,
  `name` varchar(30) DEFAULT NULL,
  `phone` varchar(15) DEFAULT NULL,
  `address` text DEFAULT NULL,
  `note` varchar(255) DEFAULT NULL,
  `customer_note` varchar(255) DEFAULT NULL,
  `invoice_status` varchar(30) NOT NULL DEFAULT '1',
  `total_price` int(20) DEFAULT 0,
  `shipping_fee` int(11) DEFAULT 0,
  `total_bill` int(20) DEFAULT 0,
  `is_paid` bit(1) NOT NULL DEFAULT b'0',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `is_deleted` tinyint(1) DEFAULT 0,
  `account_id` int(11) DEFAULT NULL,
  `confirmation_date` date DEFAULT NULL,
  `successful_date` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `invoices`
--

INSERT INTO `invoices` (`id`, `invoice_code`, `name`, `phone`, `address`, `note`, `customer_note`, `invoice_status`, `total_price`, `shipping_fee`, `total_bill`, `is_paid`, `created_at`, `updated_at`, `is_deleted`, `account_id`, `confirmation_date`, `successful_date`) VALUES
(1, '41ZSPBHA', 'quang anh', '0365151822', '4dvsdsf', '', 'd', 'PROCESS', 3940000, 20000, 3960000, b'1', '2024-05-14 10:47:02', '2024-06-18 15:09:13', 0, 1, NULL, NULL),
(2, '4LFFMS9V', 'quang anh', '0365151822', '4dvsdsf', '', 'd', 'NEW', 100000, 30000, 130000, b'0', '2024-05-14 10:47:02', '2024-06-17 17:40:22', 0, 4, NULL, NULL),
(3, '56BKIMXY', 'quang anh', '0365151822', '4dvsdsf', '', 'f', 'NEW', 990000, 0, 990000, b'0', '2024-05-14 10:47:02', '2024-06-15 13:55:03', 0, 1, NULL, NULL),
(4, '5CKTNJXP', 'quang anh', '0365151822', '4dvsdsf', '', 'd', 'ORDER_CREATED', 990000, 0, 990000, b'1', '2024-05-14 10:47:02', '2024-08-08 13:46:21', 0, 1, '2024-05-14', NULL),
(5, '5FTZ8G2K', 'nguyễn quang anh', '0365151823', 'số 18 ngõ 222 tựu liệt,thanh trì, hà nội', '', 'fsd', 'DELIVERING', 1860000, 10000, 1870000, b'1', '2024-05-14 10:47:02', '2024-08-08 13:46:21', 0, 2, '2024-05-14', NULL),
(6, '5J8RUFRZ', 'quang anh', '0365151822', '4dvsdsf', '', 'fs', 'NEW', 890000, 0, 890000, b'0', '2024-05-14 10:47:02', '2024-06-15 13:55:03', 0, 1, NULL, NULL),
(7, '5RH2CLWH', 'quang anh', '0365151822', '4dvsdsf', '', 'sa', 'NEW', 1540000, 0, 1540000, b'0', '2024-05-14 10:47:02', '2024-06-15 13:55:03', 0, 2, NULL, NULL),
(8, '6LU8CYHS', 'nguyễn quang anh', '3651518221', 'số 18 ngõ 222 tựu liệt,thanh trì, hà nội', '', 'ss', 'NEW', 990000, 0, 990000, b'0', '2024-05-14 10:47:02', '2024-06-15 13:55:03', 0, NULL, NULL, NULL),
(9, '7GBOGE9T', 'string', '1362370307', 'string', 'string', 'string', 'NEW', 0, 0, 0, b'0', '2024-05-14 10:47:02', '2024-06-15 13:55:03', 0, 1, NULL, NULL),
(10, '7MOJYIGO', 'vcxvx', '0999999999', 'fsd', '', 'sd', 'NEW', 0, 20000, 20000, b'0', '2024-05-14 10:47:02', '2024-08-01 10:45:22', 0, 1, NULL, NULL),
(11, '8XVO3RJ8', 'nguyễn quang anh', '4553333542', 'số 18 ngõ 222 tựu liệt,thanh trì, hà nội', '', '', 'NEW', 990000, 0, 990000, b'1', '2024-05-14 10:47:02', '2024-06-15 13:55:03', 0, NULL, NULL, NULL),
(12, '98ZCL96V', 'quang anh', '0365151822', '4dvsdsf', '', 'd', 'NEW', 750000, 0, 750000, b'0', '2024-05-14 10:47:02', '2024-06-15 13:55:03', 0, 2, NULL, NULL),
(13, 'A5K1TOQE', 'gdfgfdg', '0999999999', 'số 18 ngõ 222 tựu liệt,thanh trì, hà nội', '', 'vsd', 'PROCESS', 2300000, 30000, 2330000, b'0', '2024-05-14 10:47:02', '2024-08-01 10:45:22', 0, NULL, NULL, NULL),
(14, 'AEAXIQS0', 'quang anh', '0999999999', 'ssd', '', 'x', 'CANCEL', 990000, 0, NULL, b'0', '2024-05-14 10:47:02', '2024-06-15 13:51:40', 0, 1, NULL, NULL),
(15, 'B90AZKP8', 'quang anh', '0365151822', '4dvsdsf', '', 'f', 'NEW', 750000, 0, 750000, b'0', '2024-05-14 10:47:02', '2024-06-15 13:55:03', 0, 1, NULL, NULL),
(16, 'BOXLJSBK', 'quang anh', '0365151822', '4dvsdsf', '', 'sd', 'NEW', 480000, 30000, 510000, b'0', '2024-05-14 10:47:02', '2024-06-15 13:55:03', 0, 2, NULL, NULL),
(17, 'BSONPNNZ', 'quang anh', '0365151822', '4dvsdsf', '', 'gsd', 'NEW', 500000, 0, 500000, b'1', '2024-05-14 10:47:02', '2024-06-15 13:55:03', 0, 1, NULL, NULL),
(18, 'CDJBJ419', 'quang anh', '0365151822', '4dvsdsf', '', 'd', 'NEW', 750000, 0, 750000, b'0', '2024-05-14 10:47:02', '2024-06-15 13:55:03', 0, 1, NULL, NULL),
(19, 'CK0I8M9L', 'quang anh', '0365151822', '4dvsdsf', '', 'a', 'NEW', 750000, 0, 750000, b'0', '2024-05-14 10:47:02', '2024-06-15 13:55:03', 0, 1, NULL, NULL),
(20, 'CK2RNNXU', 'quang anh', '0365151822', '4dvsdsf', '', 'd', 'NEW', 990000, 0, 990000, b'0', '2024-05-14 10:47:02', '2024-06-15 13:55:03', 0, 1, NULL, NULL),
(21, 'CQK0DVXD', 'quang anh', '0365151822', '4dvsdsf', '', 's', 'NEW', 990000, 0, 990000, b'0', '2024-05-14 10:47:02', '2024-06-15 13:55:03', 0, 1, NULL, NULL),
(22, 'CYFRIM6O', 'quang anh', '0365151822', '4dvsdsf', '', 's', 'NEW', 420000, 30000, 450000, b'0', '2024-05-14 10:47:02', '2024-06-15 13:55:03', 0, 2, NULL, NULL),
(23, 'DMJHRKWM', 'nguyễn quang anh', '0999999999', 'số 18 ngõ 222 tựu liệt,thanh trì, hà nội', '', 'cs', 'NEW', 580000, 0, 580000, b'0', '2024-05-14 10:47:02', '2024-06-17 13:33:56', 0, 1, NULL, NULL),
(24, 'EAEUPXUE', 'quang anh', '0365151822', '4dvsdsf', '', 's', 'NEW', 990000, 0, 990000, b'0', '2024-05-14 10:47:02', '2024-06-15 13:55:03', 0, NULL, NULL, NULL),
(25, 'EIIMQTNF', 'quang anh', '0365151822', '4dvsdsf', '', 'd', 'SUCCESS', 1150000, 30000, 1180000, b'0', '2024-05-14 10:47:02', '2024-08-08 13:46:34', 0, 1, '2024-05-14', '2024-05-14'),
(26, 'EXAWZYY2', 'quang anh', '0365151822', '4dvsdsf', '', 's', 'NEW', 990000, 0, 990000, b'0', '2024-05-14 10:47:02', '2024-06-15 13:55:03', 0, 1, NULL, NULL),
(27, 'EYCDR8PC', 'nguyễn quang anh', '0999999999', 'số 18 ngõ 222 tựu liệt,thanh trì, hà nội', '                        fsd', NULL, 'NEW', 0, 0, 0, b'0', '2024-05-14 10:47:02', '2024-08-01 10:45:22', 0, 2, NULL, NULL),
(28, 'F6GYDSV1', 'nguyễn quang anh', '0365151821', 'số 18 ngõ 222 tựu liệt,thanh trì, hà nội', '', NULL, 'NEW', 0, 0, 0, b'0', '2024-05-14 10:47:02', '2024-06-15 13:55:03', 0, 1, NULL, NULL),
(29, 'GB4ENHC1', 'nguyễn quang anh', '0999999999', 'số 18 ngõ 222 tựu liệt,thanh trì, hà nội', '', 'dfs', 'CANCEL', 0, 0, 0, b'0', '2024-05-14 10:47:02', '2024-08-01 10:45:22', 0, 1, NULL, NULL),
(30, 'GCRM2OC5', 'quang anh', '0365151822', '4dvsdsf', '', 'sd', 'NEW', NULL, 30000, 380000, b'0', '2024-05-14 10:47:02', '2024-06-15 13:55:03', 0, 1, NULL, NULL),
(31, 'GGTWEEBJ', 'quang anh', '0365151822', '4dvsdsf', '', 'd', 'NEW', 200000, 30000, 230000, b'1', '2024-05-14 10:47:02', '2024-06-15 13:55:03', 0, 1, NULL, NULL),
(32, 'GQ9U9AXK', 'quang anh', '0365151822', '4dvsdsf', '', 'fd', 'NEW', 380000, 0, 380000, b'0', '2024-05-14 10:47:02', '2024-06-15 13:55:03', 0, 2, NULL, NULL),
(33, 'GWW0LOZ8', 'quang anh', '0365151822', '4dvsdsf', '', 'v', 'NEW', 750000, 0, 750000, b'0', '2024-05-14 10:47:02', '2024-06-15 13:55:03', 0, 1, NULL, NULL),
(34, 'I1TWS5QJ', 'quang anh', '0999999999', 'sdf', '', 'sd', 'NEW', 0, 0, 0, b'0', '2024-05-14 10:47:02', '2024-08-01 10:45:22', 0, 1, NULL, NULL),
(35, 'I8XDEQJH', 'nguyễn quang anh', '0999999999', 'số 18 ngõ 222 tựu liệt,thanh trì, hà nội', '', 'sd', 'PROCESS', 0, 0, 0, b'0', '2024-05-14 10:47:02', '2024-08-01 10:45:22', 0, 1, NULL, NULL),
(36, 'IS8THSPA', 'quang anh', '0365151822', '4dvsdsf', '', 'd', 'NEW', 100000, 30000, 130000, b'0', '2024-05-14 10:47:02', '2024-06-15 13:55:03', 0, 1, NULL, NULL),
(37, 'JDIVW1PL', 'quang anh', '0365151822', '4dvsdsf', '', 's', 'NEW', 500000, 0, 500000, b'0', '2024-05-14 10:47:02', '2024-06-15 13:55:03', 0, 1, NULL, NULL),
(38, 'JFFE99ZQ', 'quang anh', '0365151822', '4dvsdsf', '', 'fd', 'NEW', 1250000, 0, 1250000, b'0', '2024-05-14 10:47:02', '2024-06-15 13:55:03', 0, 1, NULL, NULL),
(39, 'KT9P9ZMY', 'nguyễn quang anh', '0999999999', 'số 18 ngõ 222 tựu liệt,thanh trì, hà nội', '', 'dsf', 'NEW', 0, 20000, 20000, b'0', '2024-05-14 10:47:02', '2024-08-01 10:45:22', 0, 1, NULL, NULL),
(40, 'KYGSBUBG', 'quang anh', '0365151822', '4dvsdsf', '', 'd', 'NEW', 500000, 0, 500000, b'0', '2024-05-14 10:47:02', '2024-06-15 13:55:03', 0, 1, NULL, NULL),
(41, 'LUW8V8TY', 'quang anh', '0365151822', '4dvsdsf', '', 'd', 'NEW', 750000, 0, 750000, b'0', '2024-05-14 10:47:02', '2024-06-15 13:55:03', 0, 1, NULL, NULL),
(42, 'MDXPM23G', 'quang anh', '0365151822', '4dvsdsf', 'cvs', NULL, 'NEW', 760000, 10000, 770000, b'0', '2024-05-14 10:47:02', '2024-06-15 13:55:03', 0, 1, NULL, NULL),
(43, 'MSFDUEXY', 'nguyễn quang anh', '0999999999', 'số 18 ngõ 222 tựu liệt,thanh trì, hà nội', '', 'sd', 'NEW', 0, 0, 0, b'0', '2024-05-14 10:47:02', '2024-08-01 10:45:22', 0, 1, NULL, NULL),
(44, 'MVNWRADX', 'nhanvien1', '0999999999', 'số 18 ngõ 222 tựu liệt,thanh trì, hà nội', '                        ', NULL, 'SUCCESS', 0, 0, 0, b'0', '2024-05-14 10:47:02', '2024-08-08 13:46:34', 0, 1, '2024-05-14', '2024-05-14'),
(45, 'N6VKCD4X', 'quang anh', '0365151822', '4dvsdsf', '', 's', 'NEW', 750000, 0, 750000, b'0', '2024-05-14 10:47:02', '2024-06-15 13:55:03', 0, 1, NULL, NULL),
(46, 'NHMSP1VU', 'nguyễn quang anh', '0365151822', 'số 18 ngõ 222 tựu liệt,thanh trì, hà nội', '', NULL, 'NEW', 0, 0, 0, b'0', '2024-05-14 10:47:02', '2024-06-15 13:55:03', 0, 1, NULL, NULL),
(47, 'NQHLQRH4', 'quang anh', '0365151822', '4dvsdsf', '', NULL, 'NEW', 0, 0, 0, b'0', '2024-05-14 10:47:02', '2024-06-15 13:55:03', 0, 1, NULL, NULL),
(48, 'NV7CM7AY', 'quang anh', '0365151822', '4dvsdsf', '', 'gh', 'NEW', 750000, 0, 750000, b'0', '2024-05-14 10:47:02', '2024-06-15 13:55:03', 0, 1, NULL, NULL),
(49, 'OCFAOWMB', 'fsdfsd', '0999999999', 'vd', '', 'd', 'NEW', 0, 30000, 30000, b'0', '2024-05-14 10:47:02', '2024-08-01 10:45:22', 0, 1, NULL, NULL),
(50, 'OUFWELJT', 'quang anh', '0365151822', '4dvsdsf', '', '', 'NEW', 990000, 0, 990000, b'0', '2024-05-14 10:47:02', '2024-06-15 13:55:03', 0, 1, NULL, NULL),
(51, 'PPKY3TZA', 'quang anh', '0365151822', '4dvsdsf', '', 'g', 'NEW', 990000, 0, 990000, b'0', '2024-05-14 10:47:02', '2024-06-15 13:55:03', 0, 1, NULL, NULL),
(52, 'QIPTDMTO', 'nguyễn quang anh', '5342423432', 'số 18 ngõ 222 tựu liệt,thanh trì, hà nội', '', '', 'NEW', 990000, 0, 990000, b'0', '2024-05-14 10:47:02', '2024-06-15 13:55:03', 0, 1, NULL, NULL),
(53, 'QUZEPN5K', 'quang anh', '0365151822', '4dvsdsf', '', 'd', 'NEW', 750000, 0, 750000, b'0', '2024-05-14 10:47:02', '2024-06-15 13:55:03', 0, 1, NULL, NULL),
(54, 'ROSWZNSR', 'quang anh', '0365151822', '4dvsdsf', '', 'sd', 'NEW', 380000, 30000, 410000, b'0', '2024-05-14 10:47:02', '2024-06-15 13:55:03', 0, 1, NULL, NULL),
(55, 'S9BQOPOP', 'quang anh', '0365151822', '4dvsdsf', '', 'f', 'NEW', 750000, 0, 750000, b'0', '2024-05-14 10:47:02', '2024-06-15 13:55:03', 0, 1, NULL, NULL),
(56, 'SGVWGKLQ', 'quang anh', '0365151822', '4dvsdsf', '', 'd', 'NEW', 990000, 0, 990000, b'0', '2024-05-14 10:47:02', '2024-06-15 13:55:03', 0, 1, NULL, NULL),
(57, 'SMMKHRU1', 'dfsd', '0999999999', 'sdf', '', 'fds', 'SUCCESS', 750000, 30000, 780000, b'0', '2024-05-14 10:47:02', '2024-08-08 13:46:34', 0, 1, '2024-05-14', '2024-05-14'),
(58, 'SNGWGR4V', 'quang anh', '0365151822', '4dvsdsf', '', 'd', 'NEW', 750000, 0, 750000, b'0', '2024-05-14 10:47:02', '2024-06-15 13:55:03', 0, 1, NULL, NULL),
(59, 'SRXO1SSG', 'quang anh', '0365151822', '4dvsdsf', '', 'h', 'NEW', 400000, 30000, 430000, b'0', '2024-05-14 10:47:02', '2024-06-15 13:55:03', 0, 1, NULL, NULL),
(60, 'T1VCKYYG', 'sser', '0999999999', 'f', 'dfs', NULL, 'ORDER_CREATED', 0, 0, 0, b'0', '2024-05-14 10:47:02', '2024-08-08 13:46:21', 0, 1, '2024-05-14', NULL),
(61, 'TFWOAP9I', 'nguyễn quang anh', '4343222342', 'số 18 ngõ 222 tựu liệt,thanh trì, hà nội', '', '', 'NEW', 1046666, 0, 1046666, b'0', '2024-05-14 10:47:02', '2024-06-15 13:55:03', 0, 1, NULL, NULL),
(62, 'TGPIGVXB', 'quang anh', '0365151822', '4dvsdsf', '', 'd', 'NEW', 990000, 0, 990000, b'0', '2024-05-14 10:47:02', '2024-06-15 13:55:03', 0, 1, NULL, NULL),
(63, 'TLSY7TFT', 'dfgdf', '0999999999', 'fds', '', 'f', 'NEW', 0, 0, 0, b'0', '2024-05-14 10:47:02', '2024-08-01 10:45:22', 0, 1, NULL, NULL),
(64, 'U0F7TYG1', 'quang anh', '0365151822', '4dvsdsf', '', 'vs', 'NEW', 890000, 0, 890000, b'0', '2024-05-14 10:47:02', '2024-06-15 13:55:03', 0, 1, NULL, NULL),
(65, 'U7DZUREO', 'quang anh', '0365151822', '4dvsdsf', '', 'gd', 'NEW', 500000, 0, 500000, b'0', '2024-05-14 10:47:02', '2024-06-15 13:55:03', 0, 1, NULL, NULL),
(66, 'UAEZV8YX', 'gdfgfdg', '0999999999', 'số 18 ngõ 222 tựu liệt,thanh trì, hà nội', '', 'vsd', 'NEW', 0, 30000, 30000, b'0', '2024-05-14 10:47:02', '2024-08-01 10:45:22', 0, 1, NULL, NULL),
(67, 'UAGHYL6A', 'quang anh', '0365151822', '4dvsdsf', '', 'd', 'NEW', 750000, 0, 750000, b'0', '2024-05-14 10:47:02', '2024-06-15 13:55:03', 0, 1, NULL, NULL),
(68, 'UZZHM3TR', 'nguyễn quang anh', '0999999999', 'số 18 ngõ 222 tựu liệt,thanh trì, hà nội', '', 'fs', 'NEW', 0, 30000, 30000, b'0', '2024-05-14 10:47:02', '2024-08-01 10:45:22', 0, 1, NULL, NULL),
(69, 'V2PBUUIU', 'quang anh', '2313121312', '4dvsdsf', '', NULL, 'NEW', NULL, 0, NULL, b'0', '2024-05-14 10:47:02', '2024-06-15 13:55:03', 0, 1, NULL, NULL),
(70, 'VAZZJUMT', 'nguyễn quang anh', '3651518222', 'số 18 ngõ 222 tựu liệt,thanh trì, hà nội', '', 'zcx', 'NEW', 990000, 0, 990000, b'0', '2024-05-14 10:47:02', '2024-06-15 13:55:03', 0, 1, NULL, NULL),
(71, 'VWQKIORR', 'quang anh', '0365151822', '4dvsdsf', '', 's', 'NEW', 750000, 0, 750000, b'0', '2024-05-14 10:47:02', '2024-06-15 13:55:03', 0, 1, NULL, NULL),
(72, 'WDVTINII', 'quang anh', '0365151822', '4dvsdsf', '', 'sda', 'NEW', 1250000, 0, 1250000, b'0', '2024-05-14 10:47:02', '2024-06-15 13:55:03', 0, 1, NULL, NULL),
(73, 'WQKH3LAS', 'string', '1362370307', 'string', 'string', 'string', 'NEW', 0, 0, 0, b'0', '2024-05-14 10:47:02', '2024-06-15 13:55:03', 0, 1, NULL, NULL),
(74, 'WVHNNQAC', 'quang anh', '0365151822', '4dvsdsf', '', 'gfd', 'NEW', 500000, 999999, 1499999, b'0', '2024-05-14 10:47:02', '2024-06-15 13:55:03', 0, 1, NULL, NULL),
(75, 'X6JPOCJH', 'string', '4019020703', 'string', 'string', 'df', 'CANCEL', 6840000, 20000, 6860000, b'0', '2024-05-14 10:47:02', '2024-06-15 13:51:40', 0, 1, NULL, NULL),
(76, 'XNLM5KBW', 'quang anh', '0365151822', '4dvsdsf', '', 'f', 'NEW', 750000, 0, 750000, b'0', '2024-05-14 10:47:02', '2024-06-15 13:55:03', 0, 1, NULL, NULL),
(77, 'XRAPWYJI', 'quang anh', '0999999999', 'fđ', '', 'dgf', 'NEW', 0, 0, 0, b'0', '2024-05-14 10:47:02', '2024-08-01 10:45:22', 0, 1, NULL, NULL),
(78, 'YFJBR6YE', 'quang anh', '0365151822', '4dvsdsf', '', 'vd', 'NEW', 333333, 0, 333333, b'0', '2024-05-14 10:47:02', '2024-06-15 13:55:03', 0, 1, NULL, NULL),
(79, 'YHNB0POU', 'dsfds', '0999999999', 'f', '', 's', 'NEW', 0, 30000, 30000, b'0', '2024-05-14 10:47:02', '2024-08-01 10:45:22', 0, 1, NULL, NULL),
(80, 'YIFBIIM3', 'quang anh', '0365151822', '4dvsdsf', '', 's', 'NEW', 990000, 0, 990000, b'0', '2024-05-14 10:47:02', '2024-06-15 13:55:03', 0, 1, NULL, NULL),
(81, 'YK68ZX7R', 'nguyễn quang anh', '3432224222', 'số 18 ngõ 222 tựu liệt,thanh trì, hà nội', '', '', 'NEW', 990000, 0, 990000, b'0', '2024-05-14 10:47:02', '2024-06-15 13:55:03', 0, 1, NULL, NULL),
(82, 'YTNKBIKE', 'quang anh', '0365151822', '4dvsdsf', '', 's', 'NEW', 990000, 0, 990000, b'0', '2024-05-14 10:47:02', '2024-06-15 13:55:03', 0, 1, NULL, NULL),
(83, 'YZSGNG1E', 'quang anh', '0365151822', '4dvsdsf', '', 'd', 'NEW', 750000, 0, 750000, b'0', '2024-05-14 10:47:02', '2024-06-15 13:55:03', 0, 1, NULL, NULL),
(84, 'ZUI23NIT', 'nguyễn quang anh', '0999999999', 'số 18 ngõ 222 tựu liệt,thanh trì, hà nội', '                        dsf', NULL, 'NEW', 0, 20000, 20000, b'0', '2024-05-14 10:47:02', '2024-08-01 10:45:22', 0, 1, NULL, NULL),
(86, '7K1RTIHD', 'string', '2538878580', 'string', NULL, 'string', 'NEW', 1040000, 10000, 1050000, b'0', '2024-06-01 04:17:24', '2024-06-15 13:55:03', 0, 1, NULL, NULL),
(87, 'UPX8U4CZ', 'string', '2538878580', 'string', NULL, 'string', 'NEW', 1040000, 10000, 1050000, b'0', '2024-06-01 04:18:19', '2024-06-15 13:55:03', 0, 1, NULL, NULL),
(88, 'O0VRCG1N', 'string', '2538878580', 'string', NULL, 'string', 'NEW', 1040000, 10000, 1050000, b'0', '2024-06-01 04:22:37', '2024-06-15 13:55:03', 0, 1, NULL, NULL),
(89, '7ECXBCFQ', 'string', '2538878580', 'string', NULL, 'string', 'NEW', 1040000, 10000, 1050000, b'0', '2024-06-01 04:24:54', '2024-06-29 16:09:00', 0, 1, NULL, NULL),
(90, 'DK9QJKRV', 'stringr', '2538878580', 'string', NULL, 'string', 'PROCESS', 1040000, 10000, 1050000, b'1', '2024-06-01 04:30:43', '2024-08-07 13:14:39', 0, 1, NULL, NULL),
(94, 'BJSVA1HD', 'quang anh', '0364100196', 'dsva', NULL, '', 'NEW', 550000, 0, 550000, b'0', '2024-07-04 13:41:14', '2024-07-04 13:41:14', 0, NULL, NULL, NULL),
(95, 'E71SLKFT', 'quang anh', '0364100196', 'dsva', NULL, '', 'SUCCESS', 932000, 30000, 962000, b'0', '2024-07-04 13:41:55', '2024-08-08 13:46:34', 0, 1, '2024-07-04', '2024-07-04'),
(186, 'E71SLKFT', 'John Doe', '0912345678', '123 Main St', 'Note 1', 'Custom Note 1', 'RETURN', 3630000, 0, 3630000, b'0', '2024-07-04 11:39:43', '2024-08-08 13:46:21', 0, 1, '2024-07-04', NULL),
(187, 'D92KLMN1', 'Jane Smith', '0923456789', '456 Elm St', 'Note 2', 'Custom Note 2', 'PROCESS', 3550000, 0, 3550000, b'0', '2024-07-21 13:52:41', '2024-07-21 13:52:41', 0, 2, NULL, NULL),
(188, 'B84NOPQR', 'Alice Johnson', '0934567890', '789 Pine St', 'Note 3', 'Custom Note 3', 'DELIVERING', 2452000, 0, 2452000, b'1', '2024-07-17 17:24:20', '2024-08-08 13:46:21', 0, 4, '2024-07-18', NULL),
(189, 'C75QRSTU', 'Bob Brown', '0945678901', '101 Maple St', 'Note 4', 'Custom Note 4', 'SUCCESS', 3230000, 0, 3230000, b'1', '2024-07-23 04:23:36', '2024-08-08 13:46:34', 0, 1, '2024-07-23', '2024-07-23'),
(190, 'A63UVWX1', 'Charlie Davis', '0956789012', '202 Oak St', 'Note 5', 'Custom Note 5', 'ORDER_CREATED', 2248000, 0, 2248000, b'0', '2024-07-24 00:45:01', '2024-08-08 13:46:21', 0, 2, '2024-07-24', NULL),
(191, 'F48YZAB2', 'David Evans', '0967890123', '303 Birch St', 'Note 6', 'Custom Note 6', 'RETURN', 3232000, 0, 3232000, b'1', '2024-07-11 21:34:18', '2024-08-08 13:46:21', 0, 4, '2024-07-12', NULL),
(192, 'G57CDE3F', 'Eva White', '0978901234', '404 Cedar St', 'Note 7', 'Custom Note 7', 'CANCEL', 2628000, 0, 2628000, b'0', '2024-07-24 16:36:27', '2024-07-24 16:36:27', 0, 8, NULL, NULL),
(193, 'H82FGHI4', 'Frank Black', '0989012345', '505 Willow St', 'Note 8', 'Custom Note 8', 'NEW', 3480000, 0, 3480000, b'1', '2024-07-11 01:19:25', '2024-07-11 01:19:25', 0, 1, NULL, NULL),
(194, 'J19IJKL5', 'Grace Green', '0990123456', '606 Fir St', 'Note 9', 'Custom Note 9', 'PROCESS', 2870000, 0, 2870000, b'0', '2024-07-18 11:47:44', '2024-07-18 11:47:44', 0, 2, NULL, NULL),
(195, 'K23LMNO6', 'Henry Clark', '0901234567', '707 Redwood St', 'Note 10', 'Custom Note 10', 'DELIVERING', 1810000, 0, 1810000, b'0', '2024-07-20 14:00:25', '2024-08-08 13:46:21', 0, 4, '2024-07-20', NULL),
(196, 'L34NOPQ7', 'Ivy Lewis', '0912345670', '808 Cypress St', 'Note 11', 'Custom Note 11', 'SUCCESS', 2560000, 0, 2560000, b'1', '2024-07-08 17:38:54', '2024-08-08 13:46:34', 0, 8, '2024-07-09', '2024-07-09'),
(197, 'M45OPQR8', 'Jack Martin', '0923456781', '909 Palm St', 'Note 12', 'Custom Note 12', 'ORDER_CREATED', 2290000, 0, 2290000, b'0', '2024-07-19 05:13:15', '2024-08-08 13:46:21', 0, 1, '2024-07-19', NULL),
(198, 'N56PQRS9', 'Kathy Walker', '0934567892', '1010 Spruce St', 'Note 13', 'Custom Note 13', 'RETURN', 1242000, 0, 1242000, b'1', '2024-07-31 04:09:33', '2024-08-08 13:46:21', 0, 2, '2024-07-31', NULL),
(199, 'O67RST0A', 'Leo Adams', '0945678903', '1111 Pine St', 'Note 14', 'Custom Note 14', 'CANCEL', 2040000, 0, 2040000, b'0', '2024-07-21 12:08:04', '2024-07-21 12:08:04', 0, 4, NULL, NULL),
(200, 'P78STU1B', 'Mona Young', '0956789014', '1212 Maple St', 'Note 15', 'Custom Note 15', 'NEW', 1750000, 0, 1750000, b'1', '2024-07-13 07:11:42', '2024-07-13 07:11:42', 0, 8, NULL, NULL),
(201, 'Q89TUV2C', 'Nina Scott', '0967890125', '1313 Birch St', 'Note 16', 'Custom Note 16', 'PROCESS', 750000, 0, 750000, b'0', '2024-07-01 06:34:16', '2024-07-01 06:34:16', 0, 1, NULL, NULL),
(202, 'R90UVW3D', 'Oscar King', '0978901236', '1414 Cedar St', 'Note 17', 'Custom Note 17', 'DELIVERING', 400000, 0, 400000, b'1', '2024-07-03 18:16:16', '2024-08-08 13:46:21', 0, 2, '2024-07-04', NULL),
(203, 'S12VWX4E', 'Pamela Harris', '0989012347', '1515 Willow St', 'Note 18', 'Custom Note 18', 'SUCCESS', 400000, 0, 400000, b'1', '2024-07-14 06:38:32', '2024-08-08 13:46:34', 0, 4, '2024-07-14', '2024-07-14'),
(204, 'T23WXY5F', 'Quincy Allen', '0990123458', '1616 Fir St', 'Note 19', 'Custom Note 19', 'ORDER_CREATED', 550000, 0, 550000, b'0', '2024-07-21 09:23:53', '2024-08-08 13:46:21', 0, 8, '2024-07-21', NULL),
(205, 'U34XYZ6G', 'Rachel Baker', '0901234568', '1717 Redwood St', 'Note 20', 'Custom Note 20', 'RETURN', 380000, 0, 380000, b'1', '2024-07-25 10:03:50', '2024-08-08 13:46:21', 0, 1, '2024-07-25', NULL),
(206, 'V45YZA7H', 'Steve Carter', '0912345679', '1818 Cypress St', 'Note 21', 'Custom Note 21', 'CANCEL', 400000, 0, 400000, b'0', '2024-07-24 05:07:34', '2024-07-24 05:07:34', 0, 2, NULL, NULL),
(207, 'W56ZAB8I', 'Tina Murphy', '0923456782', '1919 Palm St', 'Note 22', 'Custom Note 22', 'SUCCESS', 960000, 0, 960000, b'0', '2024-07-06 02:26:19', '2024-08-08 13:46:34', 0, 4, '2024-07-06', '2024-07-06'),
(208, 'X67ABC9J', 'Ursula Fisher', '0934567893', '2020 Spruce St', 'Note 23', 'Custom Note 23', 'PROCESS', 990000, 0, 990000, b'1', '2024-08-02 03:48:54', '2024-08-02 03:48:54', 0, 8, NULL, NULL),
(209, 'Y78BCD0K', 'Victor Gomez', '0945678904', '2121 Pine St', 'Note 24', 'Custom Note 24', 'SUCCESS', 890000, 0, 890000, b'0', '2024-08-01 18:45:36', '2024-08-08 13:46:34', 0, 1, '2024-08-02', '2024-08-02'),
(210, 'Z89CDE1L', 'Wendy Peterson', '0956789015', '2222 Maple St', 'Note 25', 'Custom Note 25', 'SUCCESS', 480000, 0, 480000, b'1', '2024-07-25 17:21:20', '2024-08-08 13:46:34', 0, 2, '2024-07-26', '2024-07-26'),
(211, 'A90DEF2M', 'Xander Price', '0967890126', '2323 Birch St', 'Note 26', 'Custom Note 26', 'ORDER_CREATED', 480000, 0, 480000, b'0', '2024-07-29 13:29:53', '2024-08-08 13:46:21', 0, 4, '2024-07-29', NULL),
(212, 'B12EFG3N', 'Yvonne Bennett', '0978901237', '2424 Cedar St', 'Note 27', 'Custom Note 27', 'RETURN', 250000, 0, 250000, b'1', '2024-07-31 22:25:27', '2024-08-08 13:46:21', 0, 8, '2024-08-01', NULL),
(213, 'C23FGH4O', 'Zachary Collins', '0989012348', '2525 Willow St', 'Note 28', 'Custom Note 28', 'ORDER_CREATED', 2000000, 0, 2000000, b'0', '2024-08-01 06:37:36', '2024-08-08 15:24:14', 0, 1, '2024-08-08', NULL),
(214, 'D34GHI5P', 'Alice Morgan', '0990123459', '2626 Fir St', 'Note 29', 'Custom Note 29', 'NEW', 750000, 0, 750000, b'1', '2024-07-26 20:51:43', '2024-07-26 20:51:43', 0, 2, NULL, NULL),
(215, 'E45HIJ6Q', 'Brian Cooper', '0901234569', '2727 Redwood St', 'Note 30', 'Custom Note 30', 'PROCESS', 450000, 0, 450000, b'1', '2024-08-05 19:25:48', '2024-08-05 19:25:48', 0, 4, NULL, NULL),
(216, 'F56IJK7R', 'Clara Ramirez', '0912345670', '2828 Cypress St', 'Note 31', 'Custom Note 31', 'DELIVERING', 400000, 0, 400000, b'0', '2024-07-26 17:33:51', '2024-08-08 13:46:21', 0, 8, '2024-07-27', NULL),
(217, 'G67JKL8S', 'Daniel Cox', '0923456783', '2929 Palm St', 'Note 32', 'Custom Note 32', 'SUCCESS', 450000, 0, 450000, b'1', '2024-07-22 12:31:53', '2024-08-08 13:46:34', 0, 1, '2024-07-22', '2024-07-22'),
(218, 'H78KLM9T', 'Ella Ward', '0934567894', '3030 Spruce St', 'Note 33', 'Custom Note 33', 'ORDER_CREATED', 550000, 0, 550000, b'0', '2024-07-31 16:57:53', '2024-08-08 13:46:21', 0, 2, '2024-07-31', NULL),
(219, 'I89LMN0U', 'Frank Morris', '0945678905', '3131 Pine St', 'Note 34', 'Custom Note 34', 'RETURN', 500000, 0, 500000, b'1', '2024-07-14 06:13:49', '2024-08-08 13:46:21', 0, 4, '2024-07-14', NULL),
(220, 'J90MNO1V', 'Grace Rogers', '0956789016', '3232 Maple St', 'Note 35', 'Custom Note 35', 'CANCEL', 450000, 0, 450000, b'0', '2024-07-13 11:15:25', '2024-07-13 11:15:25', 0, 8, NULL, NULL),
(221, 'K12NOP2W', 'Henry Murphy', '0967890127', '3333 Birch St', 'Note 36', 'Custom Note 36', 'NEW', 400000, 0, 400000, b'1', '2024-07-23 20:35:37', '2024-07-23 20:35:37', 0, 1, NULL, NULL),
(222, 'L23OPQ3X', 'Ivy Sanders', '0978901238', '3434 Cedar St', 'Note 37', 'Custom Note 37', 'PROCESS', 300000, 0, 300000, b'1', '2024-07-02 04:11:52', '2024-07-02 04:11:52', 0, 2, NULL, NULL),
(223, 'M34PQR4Y', 'Jack Barnes', '0989012349', '3535 Willow St', 'Note 38', 'Custom Note 38', 'DELIVERING', 450000, 0, 450000, b'0', '2024-07-14 14:12:28', '2024-08-08 13:46:21', 0, 4, '2024-07-14', NULL),
(224, 'N45QRS5Z', 'Kathy Hayes', '0990123460', '3636 Fir St', 'Note 39', 'Custom Note 39', 'SUCCESS', 520000, 0, 520000, b'1', '2024-07-27 17:26:46', '2024-08-08 13:46:34', 0, 8, '2024-07-28', '2024-07-28'),
(225, 'O56RST6A', 'Leo Bennett', '0901234570', '3737 Redwood St', 'Note 40', 'Custom Note 40', 'ORDER_CREATED', 300000, 0, 300000, b'0', '2024-07-18 03:36:30', '2024-08-08 13:46:21', 0, 1, '2024-07-18', NULL),
(226, 'P67STU7B', 'Mona Kelly', '0912345671', '3838 Cypress St', 'Note 41', 'Custom Note 41', 'RETURN', 520000, 0, 520000, b'1', '2024-07-06 20:42:13', '2024-08-08 13:46:21', 0, 2, '2024-07-07', NULL),
(227, 'Q78TUV8C', 'Nina Hughes', '0923456784', '3939 Palm St', 'Note 42', 'Custom Note 42', 'CANCEL', 750000, 0, 750000, b'0', '2024-07-17 03:41:36', '2024-07-17 03:41:36', 0, 4, NULL, NULL),
(228, 'R89UVW9D', 'Oscar Ward', '0934567895', '4040 Spruce St', 'Note 43', 'Custom Note 43', 'NEW', 450000, 0, 450000, b'1', '2024-07-26 11:21:20', '2024-07-26 11:21:20', 0, 8, NULL, NULL),
(229, 'S90VWX0E', 'Pamela Cook', '0945678906', '4141 Pine St', 'Note 44', 'Custom Note 44', 'PROCESS', 400000, 0, 400000, b'1', '2024-07-04 04:41:54', '2024-07-04 04:41:54', 0, 1, NULL, NULL),
(230, 'T12WXY1F', 'Quincy Diaz', '0956789017', '4242 Maple St', 'Note 45', 'Custom Note 45', 'DELIVERING', 480000, 0, 480000, b'0', '2024-07-16 20:25:30', '2024-08-08 13:46:21', 0, 2, '2024-07-17', NULL),
(231, 'U23XYZ2G', 'Rachel Lee', '0967890128', '4343 Birch St', 'Note 46', 'Custom Note 46', 'SUCCESS', 400000, 0, 400000, b'1', '2024-08-01 23:01:51', '2024-08-08 13:46:34', 0, 4, '2024-08-02', '2024-08-02'),
(232, 'V34YZA3H', 'Steve Scott', '0978901239', '4444 Cedar St', 'Note 47', 'Custom Note 47', 'ORDER_CREATED', 400000, 0, 400000, b'0', '2024-08-06 12:52:45', '2024-08-08 13:46:21', 0, 8, '2024-08-06', NULL),
(233, 'W45ZAB4I', 'Tina Mitchell', '0989012350', '4545 Willow St', 'Note 48', 'Custom Note 48', 'RETURN', 480000, 0, 480000, b'1', '2024-07-12 02:18:15', '2024-08-08 13:46:21', 0, 1, '2024-07-12', NULL),
(234, 'X56ABC5J', 'Ursula Lopez', '0990123461', '4646 Fir St', 'Note 49', 'Custom Note 49', 'CANCEL', 550000, 0, 550000, b'0', '2024-07-23 03:52:58', '2024-07-23 03:52:58', 0, 2, NULL, NULL),
(235, 'Y67BCD6K', 'Victor Young', '0901234571', '4747 Redwood St', 'Note 50', 'Custom Note 50', 'NEW', 380000, 0, 380000, b'1', '2024-07-02 19:30:08', '2024-07-02 19:30:08', 0, 4, NULL, NULL),
(236, 'EO0LZ3UG', 'quang anh', '0364100196', 'dsva', NULL, '', 'ORDER_CREATED', 750000, 0, 750000, b'0', '2024-08-08 13:58:08', '2024-08-08 15:38:12', 0, 1, '2024-08-08', '2024-08-08');

--
-- Bẫy `invoices`
--
DELIMITER $$
CREATE TRIGGER `insert_history` AFTER INSERT ON `invoices` FOR EACH ROW BEGIN
    DECLARE content TEXT;
    DECLARE invoice_id INT;
    DECLARE account_name VARCHAR(255);
    DECLARE is_paid_status VARCHAR(55);
    
	IF NEW.is_paid = 0 THEN
    	SET is_paid_status = 'Chưa thanh toán';
    ELSEIF NEW.is_paid = 1 THEN
        SET is_paid_status = 'Đã thanh toán';
    ELSE
        SET is_paid_status = 'Giá trị không hợp lệ'; 
    END IF;
    
    SET invoice_id = NEW.id;
    
    SET content = CONCAT(
        IFNULL(@current_user, 'Hệ thống'), ' đã tạo đơn hàng: <br>Mã đơn: ', NEW.invoice_code, ',<br>Tên khách hàng: ', NEW.name, ',<br>Số điện thoại: ', NEW.phone, ',<br>Địa chỉ: ', NEW.address,',<br>Trạng thái thanh toán: ',is_paid_status);
    
    INSERT INTO invoices_history (invoice_id, content) VALUES (invoice_id, content);
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `update_history` AFTER UPDATE ON `invoices` FOR EACH ROW BEGIN
	DECLARE content TEXT;
    DECLARE invoice_id VARCHAR(25);
    DECLARE old_account VARCHAR(25);
    DECLARE new_account VARCHAR(25);
    DECLARE new_is_paid_status VARCHAR(55);
    DECLARE old_is_paid_status VARCHAR(55);
    
    SET old_account = (SELECT accounts.name FROM accounts WHERE id = OLD.account_id);
    SET new_account = (SELECT accounts.name FROM accounts WHERE id = NEW.account_id);
    SET invoice_id = NEW.id;
    SET content = "";
    
	IF NEW.is_paid = 0 THEN
    	SET new_is_paid_status = 'Chưa thanh toán';
    ELSEIF NEW.is_paid = 1 THEN
        SET new_is_paid_status = 'Đã thanh toán';
    ELSE
        SET new_is_paid_status = 'Giá trị không hợp lệ'; 
    END IF;
    
    IF OLD.is_paid = 0 THEN
    	SET old_is_paid_status = 'Chưa thanh toán';
    ELSEIF OLD.is_paid = 1 THEN
        SET old_is_paid_status = 'Đã thanh toán';
    ELSE
        SET old_is_paid_status = 'Giá trị không hợp lệ'; 
    END IF;
    
	IF NEW.name != OLD.name THEN
        SET content = CONCAT(@current_user , ' đã thay đổi Tên khách hàng: ', OLD.name, ' -> ', NEW.name,'<br>');
    END IF;
    
    IF NEW.phone != OLD.phone THEN
        SET content = CONCAT(content,@current_user ,' đã thay đổi Số điện thoại: ', OLD.phone, ' -> ', NEW.phone,'<br>');
    END IF;
    
    IF NEW.address != OLD.address THEN
        SET content = CONCAT(content,@current_user , ' đã thay đổi Địa chỉ: ', OLD.address, ' -> ', NEW.address,'<br>');
    END IF;
    
    IF NEW.note != OLD.note THEN
        SET content = CONCAT(content,@current_user , ' đã thay đổi Ghi chú: ', OLD.note, ' -> ', NEW.note,'<br>');
    END IF;
    
    IF NEW.invoice_status != OLD.invoice_status THEN
        SET content = CONCAT(content,@current_user , ' đã thay đổi Trạng thái đơn hàng: ', OLD.invoice_status , ' -> ', NEW.invoice_status,'<br>');
    END IF;
    
    IF NEW.account_id != OLD.account_id THEN
        SET content = CONCAT(content,@current_user , ' đã thay đổi nhân viên phụ trách đơn hàng: ', old_account , ' -> ', new_account,'<br>');
    END IF;
    
    IF NEW.shipping_fee != OLD.shipping_fee THEN
    SET content = CONCAT(content,@current_user , ' đã thay đổi Phí ship: ', FORMAT(OLD.shipping_fee, 0), ' VND)', ' -> ', FORMAT(NEW.shipping_fee, 0), ' VND) <br>');
    END IF;
    
    IF NEW.is_paid != OLD.is_paid THEN
    SET content = CONCAT(@current_user , ' đã thay đổi trạng thái thanh toán: ',old_is_paid_status,' -> ',new_is_paid_status,'<br>');
    END IF;
    
    IF content != "" THEN
    INSERT INTO invoices_history (invoice_id,content) VALUES (invoice_id,content);
    END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `invoices_detail`
--

CREATE TABLE `invoices_detail` (
  `id` int(11) NOT NULL,
  `invoice_id` int(11) DEFAULT NULL,
  `product_detail_id` int(11) DEFAULT NULL,
  `price` double DEFAULT NULL,
  `quantity` int(11) DEFAULT NULL,
  `total_price` int(20) DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `invoices_detail`
--

INSERT INTO `invoices_detail` (`id`, `invoice_id`, `product_detail_id`, `price`, `quantity`, `total_price`, `created_at`, `updated_at`) VALUES
(262, 14, 691, 990000, 1, 990000, '2024-05-14 10:47:14', '2024-05-14 10:47:14'),
(272, 13, 442, 480000, 4, 1920000, '2024-05-14 10:47:14', '2024-05-14 10:47:14'),
(274, 13, 614, 380000, 1, 380000, '2024-05-14 10:47:14', '2024-05-14 10:47:14'),
(365, 5, 614, 380000, 2, 760000, '2024-05-14 10:47:14', '2024-05-14 10:47:14'),
(368, 5, 541, 550000, 1, 550000, '2024-05-14 10:47:14', '2024-05-14 10:47:14'),
(369, 5, 542, 550000, 1, 550000, '2024-05-14 10:47:14', '2024-05-14 10:47:14'),
(370, 23, 190, 290000, 1, 290000, '2024-05-14 10:47:14', '2024-05-14 10:47:14'),
(371, 23, 191, 290000, 1, 290000, '2024-05-14 10:47:14', '2024-05-14 10:47:14'),
(372, 81, 691, 990000, 1, 990000, '2024-05-14 10:47:14', '2024-05-14 10:47:14'),
(374, 52, 691, 990000, 1, 990000, '2024-05-14 10:47:14', '2024-05-14 10:47:14'),
(375, 8, 691, 990000, 1, 990000, '2024-05-14 10:47:14', '2024-05-14 10:47:14'),
(376, 70, 691, 990000, 1, 990000, '2024-05-14 10:47:14', '2024-05-14 10:47:14'),
(377, 11, 691, 990000, 1, 990000, '2024-05-14 10:47:14', '2024-05-14 10:47:14'),
(379, 16, 502, 480000, 1, 480000, '2024-05-14 10:47:14', '2024-05-14 10:47:14'),
(380, 74, 522, 500000, 1, 500000, '2024-05-14 10:47:14', '2024-05-14 10:47:14'),
(381, 50, 691, 990000, 1, 990000, '2024-05-14 10:47:14', '2024-05-14 10:47:14'),
(382, 32, 16, 380000, 1, 380000, '2024-05-14 10:47:14', '2024-05-14 10:47:14'),
(383, 30, 573, 350000, 1, 350000, '2024-05-14 10:47:14', '2024-05-14 10:47:14'),
(384, 54, 16, 380000, 1, 380000, '2024-05-14 10:47:14', '2024-05-14 10:47:14'),
(385, 38, 697, 750000, 1, 750000, '2024-05-14 10:47:14', '2024-05-14 10:47:14'),
(386, 38, 522, 500000, 1, 500000, '2024-05-14 10:47:14', '2024-05-14 10:47:14'),
(387, 7, 691, 990000, 1, 990000, '2024-05-14 10:47:14', '2024-05-14 10:47:14'),
(388, 83, 709, 750000, 1, 750000, '2024-05-14 10:47:14', '2024-05-14 10:47:14'),
(389, 1, 692, 990000, 3, 2970000, '2024-05-14 10:47:14', '2024-06-17 17:23:16'),
(390, 56, 691, 990000, 1, 990000, '2024-05-14 10:47:14', '2024-05-14 10:47:14'),
(391, 20, 691, 990000, 1, 990000, '2024-05-14 10:47:14', '2024-05-14 10:47:14'),
(392, 24, 691, 990000, 1, 990000, '2024-05-14 10:47:14', '2024-05-14 10:47:14'),
(393, 26, 691, 990000, 1, 990000, '2024-05-14 10:47:14', '2024-05-14 10:47:14'),
(394, 37, 252, 500000, 1, 500000, '2024-05-14 10:47:14', '2024-05-14 10:47:14'),
(395, 22, 85, 420000, 1, 420000, '2024-05-14 10:47:14', '2024-05-14 10:47:14'),
(396, 36, 687, 50000, 2, 100000, '2024-05-14 10:47:14', '2024-05-14 10:47:14'),
(398, 48, 697, 750000, 1, 750000, '2024-05-14 10:47:14', '2024-05-14 10:47:14'),
(399, 6, 713, 890000, 1, 890000, '2024-05-14 10:47:14', '2024-05-14 10:47:14'),
(400, 64, 713, 890000, 1, 890000, '2024-05-14 10:47:14', '2024-05-14 10:47:14'),
(401, 62, 691, 990000, 1, 990000, '2024-05-14 10:47:14', '2024-05-14 10:47:14'),
(402, 55, 709, 750000, 1, 750000, '2024-05-14 10:47:14', '2024-05-14 10:47:14'),
(403, 76, 709, 750000, 1, 750000, '2024-05-14 10:47:14', '2024-05-14 10:47:14'),
(404, 2, 687, 50000, 2, 100000, '2024-05-14 10:47:14', '2024-06-17 17:40:22'),
(405, 80, 691, 990000, 1, 990000, '2024-05-14 10:47:14', '2024-05-14 10:47:14'),
(406, 59, 729, 400000, 1, 400000, '2024-05-14 10:47:14', '2024-05-14 10:47:14'),
(407, 15, 709, 750000, 1, 750000, '2024-05-14 10:47:14', '2024-05-14 10:47:14'),
(408, 3, 691, 990000, 1, 990000, '2024-05-14 10:47:14', '2024-05-14 10:47:14'),
(409, 41, 709, 750000, 1, 750000, '2024-05-14 10:47:14', '2024-05-14 10:47:14'),
(410, 67, 709, 750000, 1, 750000, '2024-05-14 10:47:14', '2024-05-14 10:47:14'),
(411, 40, 522, 500000, 1, 500000, '2024-05-14 10:47:14', '2024-05-14 10:47:14'),
(412, 25, 729, 400000, 1, 400000, '2024-05-14 10:47:14', '2024-05-14 10:47:14'),
(413, 45, 697, 750000, 1, 750000, '2024-05-14 10:47:14', '2024-05-14 10:47:14'),
(414, 53, 709, 750000, 1, 750000, '2024-05-14 10:47:14', '2024-05-14 10:47:14'),
(415, 71, 709, 750000, 1, 750000, '2024-05-14 10:47:14', '2024-05-14 10:47:14'),
(416, 21, 691, 990000, 1, 990000, '2024-05-14 10:47:14', '2024-05-14 10:47:14'),
(417, 82, 691, 990000, 1, 990000, '2024-05-14 10:47:14', '2024-05-14 10:47:14'),
(418, 19, 709, 750000, 1, 750000, '2024-05-14 10:47:14', '2024-05-14 10:47:14'),
(419, 18, 697, 750000, 1, 750000, '2024-05-14 10:47:14', '2024-05-14 10:47:14'),
(420, 12, 697, 750000, 1, 750000, '2024-05-14 10:47:14', '2024-05-14 10:47:14'),
(421, 51, 691, 990000, 1, 990000, '2024-05-14 10:47:14', '2024-05-14 10:47:14'),
(422, 78, 46, 333333, 1, 333333, '2024-05-14 10:47:14', '2024-05-14 10:47:14'),
(423, 33, 697, 750000, 1, 750000, '2024-05-14 10:47:14', '2024-05-14 10:47:14'),
(424, 7, 527, 550000, 1, 550000, '2024-05-14 10:47:14', '2024-05-14 10:47:14'),
(425, 1, 82, 420000, 1, 420000, '2024-05-14 10:47:14', '2024-05-14 10:47:14'),
(426, 72, 697, 750000, 1, 750000, '2024-05-14 10:47:14', '2024-05-14 10:47:14'),
(427, 72, 522, 500000, 1, 500000, '2024-05-14 10:47:14', '2024-05-14 10:47:14'),
(428, 58, 697, 750000, 1, 750000, '2024-05-14 10:47:14', '2024-05-14 10:47:14'),
(429, 65, 522, 500000, 1, 500000, '2024-05-14 10:47:14', '2024-05-14 10:47:14'),
(430, 31, 4, 200000, 1, 200000, '2024-05-14 10:47:14', '2024-05-14 10:47:14'),
(432, 42, 620, 380000, 2, 760000, '2024-05-14 10:47:14', '2024-05-14 10:47:14'),
(433, 4, 695, 990000, 1, 990000, '2024-05-14 10:47:14', '2024-05-14 10:47:14'),
(436, 1, 530, 550000, 1, 550000, '2024-05-14 10:47:14', '2024-05-14 10:47:14'),
(443, 61, 620, 380000, 1, 380000, '2024-05-14 10:47:14', '2024-05-14 10:47:14'),
(444, 61, 48, 333333, 2, 666666, '2024-05-14 10:47:14', '2024-05-14 10:47:14'),
(445, 17, 522, 500000, 1, 500000, '2024-05-14 10:47:14', '2024-05-14 10:47:14'),
(446, 75, 613, 380000, 2, 760000, '2024-05-14 10:47:14', '2024-05-14 10:47:14'),
(447, 75, 614, 380000, 1, 380000, '2024-05-14 10:47:14', '2024-05-14 10:47:14'),
(448, 75, 615, 380000, 13, 4940000, '2024-05-14 10:47:14', '2024-05-14 10:47:14'),
(453, 75, 655, 380000, 1, 380000, '2024-05-22 14:41:41', '2024-05-22 14:41:41'),
(454, 75, 654, 380000, 1, 380000, '2024-05-22 14:49:07', '2024-05-22 14:49:07'),
(455, 86, 447, 520000, 1, 520000, '2024-06-01 04:17:25', '2024-06-01 04:17:25'),
(456, 86, 448, 520000, 1, 520000, '2024-06-01 04:17:25', '2024-06-01 04:17:25'),
(457, 87, 447, 520000, 1, 520000, '2024-06-01 04:18:19', '2024-06-01 04:18:19'),
(458, 87, 448, 520000, 1, 520000, '2024-06-01 04:18:19', '2024-06-01 04:18:19'),
(459, 88, 447, 520000, 1, 520000, '2024-06-01 04:22:37', '2024-06-01 04:22:37'),
(460, 88, 448, 520000, 1, 520000, '2024-06-01 04:22:37', '2024-06-01 04:22:37'),
(461, 89, 447, 520000, 1, 520000, '2024-06-01 04:24:55', '2024-06-01 04:24:55'),
(462, 89, 448, 520000, 1, 520000, '2024-06-01 04:24:55', '2024-06-01 04:24:55'),
(463, 90, 447, 520000, 1, 520000, '2024-06-01 04:30:43', '2024-06-01 04:30:43'),
(464, 90, 448, 520000, 1, 520000, '2024-06-01 04:30:43', '2024-06-01 04:30:43'),
(466, 94, 548, 550000, 1, 550000, '2024-07-04 13:41:14', '2024-07-04 13:41:14'),
(467, 95, 415, 42000, 1, 42000, '2024-07-04 13:41:55', '2024-07-04 13:41:55'),
(521, 186, 355, 450000, 1, 450000, '2024-08-04 13:38:32', '2024-08-04 13:38:32'),
(522, 187, 587, 400000, 1, 400000, '2024-08-04 13:38:32', '2024-08-04 13:38:32'),
(523, 188, 352, 450000, 1, 450000, '2024-08-04 13:38:32', '2024-08-04 13:38:32'),
(524, 189, 356, 450000, 1, 450000, '2024-08-04 13:38:32', '2024-08-04 13:38:32'),
(525, 190, 138, 349000, 1, 349000, '2024-08-04 13:38:32', '2024-08-04 13:38:32'),
(526, 191, 186, 450000, 1, 450000, '2024-08-04 13:38:32', '2024-08-04 13:38:32'),
(527, 192, 130, 349000, 1, 349000, '2024-08-04 13:38:32', '2024-08-04 13:38:32'),
(528, 193, 566, 350000, 1, 350000, '2024-08-04 13:38:32', '2024-08-04 13:38:32'),
(529, 194, 328, 300000, 1, 300000, '2024-08-04 13:38:32', '2024-08-04 13:38:32'),
(530, 195, 82, 420000, 1, 420000, '2024-08-04 13:38:32', '2024-08-04 13:38:32'),
(531, 196, 330, 300000, 1, 300000, '2024-08-04 13:38:32', '2024-08-04 13:38:32'),
(532, 197, 423, 480000, 1, 480000, '2024-08-04 13:38:32', '2024-08-04 13:38:32'),
(533, 198, 180, 450000, 1, 450000, '2024-08-04 13:38:32', '2024-08-04 13:38:32'),
(534, 199, 721, 1200000, 1, 1200000, '2024-08-04 13:38:32', '2024-08-04 13:38:32'),
(535, 200, 240, 500000, 1, 500000, '2024-08-04 13:38:32', '2024-08-04 13:38:32'),
(536, 201, 283, 250000, 1, 250000, '2024-08-04 13:38:32', '2024-08-04 13:38:32'),
(537, 186, 685, 50000, 1, 50000, '2024-08-04 13:39:49', '2024-08-04 13:39:49'),
(538, 187, 251, 500000, 1, 500000, '2024-08-04 13:39:49', '2024-08-04 13:39:49'),
(539, 188, 417, 42000, 1, 42000, '2024-08-04 13:39:49', '2024-08-04 13:39:49'),
(540, 189, 449, 520000, 1, 520000, '2024-08-04 13:39:49', '2024-08-04 13:39:49'),
(541, 190, 684, 50000, 1, 50000, '2024-08-04 13:39:49', '2024-08-04 13:39:49'),
(542, 191, 515, 500000, 1, 500000, '2024-08-04 13:39:49', '2024-08-04 13:39:49'),
(543, 192, 688, 50000, 1, 50000, '2024-08-04 13:39:49', '2024-08-04 13:39:49'),
(544, 193, 347, 450000, 1, 450000, '2024-08-04 13:39:49', '2024-08-04 13:39:49'),
(545, 194, 614, 380000, 1, 380000, '2024-08-04 13:39:49', '2024-08-04 13:39:49'),
(546, 195, 426, 480000, 1, 480000, '2024-08-04 13:39:49', '2024-08-04 13:39:49'),
(547, 196, 703, 750000, 1, 750000, '2024-08-04 13:39:49', '2024-08-04 13:39:49'),
(548, 197, 563, 320000, 1, 320000, '2024-08-04 13:39:49', '2024-08-04 13:39:49'),
(549, 198, 284, 250000, 1, 250000, '2024-08-04 13:39:49', '2024-08-04 13:39:49'),
(550, 186, 251, 500000, 1, 500000, '2024-08-04 13:39:51', '2024-08-04 13:39:51'),
(551, 187, 731, 400000, 1, 400000, '2024-08-04 13:39:51', '2024-08-04 13:39:51'),
(552, 186, 511, 500000, 1, 500000, '2024-08-04 13:41:32', '2024-08-04 13:41:32'),
(553, 187, 489, 500000, 1, 500000, '2024-08-04 13:41:32', '2024-08-04 13:41:32'),
(554, 188, 587, 400000, 1, 400000, '2024-08-04 13:41:32', '2024-08-04 13:41:32'),
(555, 189, 426, 480000, 1, 480000, '2024-08-04 13:41:32', '2024-08-04 13:41:32'),
(556, 190, 541, 550000, 1, 550000, '2024-08-04 13:41:32', '2024-08-04 13:41:32'),
(557, 191, 508, 500000, 1, 500000, '2024-08-04 13:41:32', '2024-08-04 13:41:32'),
(558, 192, 672, 299000, 1, 299000, '2024-08-04 13:41:32', '2024-08-04 13:41:32'),
(559, 193, 543, 550000, 1, 550000, '2024-08-04 13:41:32', '2024-08-04 13:41:32'),
(560, 194, 422, 480000, 1, 480000, '2024-08-04 13:41:32', '2024-08-04 13:41:32'),
(561, 186, 566, 350000, 1, 350000, '2024-08-04 13:42:18', '2024-08-04 13:42:18'),
(562, 187, 357, 450000, 1, 450000, '2024-08-04 13:42:18', '2024-08-04 13:42:18'),
(563, 188, 632, 380000, 1, 380000, '2024-08-04 13:42:18', '2024-08-04 13:42:18'),
(564, 189, 512, 500000, 1, 500000, '2024-08-04 13:42:18', '2024-08-04 13:42:18'),
(565, 190, 535, 550000, 1, 550000, '2024-08-04 13:42:18', '2024-08-04 13:42:18'),
(566, 191, 705, 750000, 1, 750000, '2024-08-04 13:42:18', '2024-08-04 13:42:18'),
(567, 192, 425, 480000, 1, 480000, '2024-08-04 13:42:18', '2024-08-04 13:42:18'),
(568, 193, 603, 380000, 1, 380000, '2024-08-04 13:42:18', '2024-08-04 13:42:18'),
(569, 194, 595, 380000, 1, 380000, '2024-08-04 13:42:18', '2024-08-04 13:42:18'),
(570, 195, 593, 380000, 1, 380000, '2024-08-04 13:42:18', '2024-08-04 13:42:18'),
(571, 196, 700, 750000, 1, 750000, '2024-08-04 13:42:18', '2024-08-04 13:42:18'),
(572, 197, 695, 990000, 1, 990000, '2024-08-04 13:42:18', '2024-08-04 13:42:18'),
(573, 198, 404, 42000, 1, 42000, '2024-08-04 13:42:18', '2024-08-04 13:42:18'),
(574, 199, 449, 520000, 1, 520000, '2024-08-04 13:42:18', '2024-08-04 13:42:18'),
(575, 200, 708, 750000, 1, 750000, '2024-08-04 13:42:18', '2024-08-04 13:42:18'),
(576, 201, 689, 50000, 1, 50000, '2024-08-04 13:42:18', '2024-08-04 13:42:18'),
(577, 186, 470, 500000, 1, 500000, '2024-08-04 13:44:35', '2024-08-04 13:44:35'),
(578, 187, 300, 300000, 1, 300000, '2024-08-04 13:44:35', '2024-08-04 13:44:35'),
(579, 188, 519, 500000, 1, 500000, '2024-08-04 13:44:35', '2024-08-04 13:44:35'),
(580, 189, 464, 500000, 1, 500000, '2024-08-04 13:44:35', '2024-08-04 13:44:35'),
(581, 186, 425, 480000, 1, 480000, '2024-08-04 13:46:03', '2024-08-04 13:46:03'),
(582, 187, 507, 500000, 1, 500000, '2024-08-04 13:46:03', '2024-08-04 13:46:03'),
(583, 188, 631, 380000, 1, 380000, '2024-08-04 13:46:03', '2024-08-04 13:46:03'),
(584, 189, 579, 400000, 1, 400000, '2024-08-04 13:46:03', '2024-08-04 13:46:03'),
(585, 190, 396, 450000, 1, 450000, '2024-08-04 13:46:03', '2024-08-04 13:46:03'),
(586, 191, 413, 42000, 1, 42000, '2024-08-04 13:46:03', '2024-08-04 13:46:03'),
(587, 192, 259, 450000, 1, 450000, '2024-08-04 13:46:03', '2024-08-04 13:46:03'),
(588, 193, 751, 380000, 1, 380000, '2024-08-04 13:46:03', '2024-08-04 13:46:03'),
(589, 194, 758, 380000, 1, 380000, '2024-08-04 13:46:03', '2024-08-04 13:46:03'),
(590, 195, 689, 50000, 1, 50000, '2024-08-04 13:46:03', '2024-08-04 13:46:03'),
(591, 196, 625, 380000, 1, 380000, '2024-08-04 13:46:03', '2024-08-04 13:46:03'),
(592, 186, 588, 400000, 2, 800000, '2024-08-04 13:50:54', '2024-08-07 13:03:44'),
(593, 187, 248, 500000, 1, 500000, '2024-08-04 13:50:54', '2024-08-04 13:50:54'),
(594, 188, 333, 300000, 1, 300000, '2024-08-04 13:50:54', '2024-08-04 13:50:54'),
(595, 189, 659, 380000, 1, 380000, '2024-08-04 13:50:54', '2024-08-04 13:50:54'),
(596, 190, 676, 299000, 1, 299000, '2024-08-04 13:50:54', '2024-08-04 13:50:54'),
(597, 191, 695, 990000, 1, 990000, '2024-08-04 13:50:54', '2024-08-04 13:50:54'),
(598, 192, 387, 450000, 1, 450000, '2024-08-04 13:50:54', '2024-08-04 13:50:54'),
(599, 193, 695, 990000, 1, 990000, '2024-08-04 13:50:54', '2024-08-04 13:50:54'),
(600, 194, 588, 400000, 1, 400000, '2024-08-04 13:50:54', '2024-08-04 13:50:54'),
(601, 195, 437, 480000, 1, 480000, '2024-08-04 13:50:54', '2024-08-04 13:50:54'),
(602, 196, 627, 380000, 1, 380000, '2024-08-04 13:50:54', '2024-08-04 13:50:54'),
(603, 197, 517, 500000, 1, 500000, '2024-08-04 13:50:54', '2024-08-04 13:50:54'),
(604, 198, 524, 500000, 1, 500000, '2024-08-04 13:50:54', '2024-08-04 13:50:54'),
(605, 199, 557, 320000, 1, 320000, '2024-08-04 13:50:54', '2024-08-04 13:50:54'),
(606, 200, 471, 500000, 1, 500000, '2024-08-04 13:50:54', '2024-08-04 13:50:54'),
(607, 201, 362, 450000, 1, 450000, '2024-08-04 13:50:54', '2024-08-04 13:50:54'),
(608, 202, 739, 400000, 1, 400000, '2024-08-04 13:50:54', '2024-08-04 13:50:54'),
(609, 203, 729, 400000, 1, 400000, '2024-08-04 13:50:54', '2024-08-04 13:50:54'),
(610, 204, 542, 550000, 1, 550000, '2024-08-04 13:50:54', '2024-08-04 13:50:54'),
(611, 205, 750, 380000, 1, 380000, '2024-08-04 13:50:54', '2024-08-04 13:50:54'),
(612, 206, 580, 400000, 1, 400000, '2024-08-04 13:50:54', '2024-08-04 13:50:54'),
(613, 207, 436, 480000, 1, 480000, '2024-08-04 13:50:54', '2024-08-04 13:50:54'),
(614, 208, 691, 990000, 1, 990000, '2024-08-04 13:50:54', '2024-08-04 13:50:54'),
(615, 209, 715, 890000, 1, 890000, '2024-08-04 13:50:54', '2024-08-04 13:50:54'),
(616, 210, 424, 480000, 1, 480000, '2024-08-04 13:50:54', '2024-08-04 13:50:54'),
(617, 211, 429, 480000, 1, 480000, '2024-08-04 13:50:54', '2024-08-04 13:50:54'),
(618, 212, 285, 250000, 1, 250000, '2024-08-04 13:50:54', '2024-08-04 13:50:54'),
(619, 213, 475, 500000, 1, 500000, '2024-08-04 13:50:54', '2024-08-04 13:50:54'),
(620, 214, 705, 750000, 1, 750000, '2024-08-04 13:50:54', '2024-08-04 13:50:54'),
(621, 215, 348, 450000, 1, 450000, '2024-08-04 13:50:54', '2024-08-04 13:50:54'),
(622, 216, 589, 400000, 1, 400000, '2024-08-04 13:50:54', '2024-08-04 13:50:54'),
(623, 217, 365, 450000, 1, 450000, '2024-08-04 13:50:55', '2024-08-04 13:50:55'),
(624, 218, 528, 550000, 1, 550000, '2024-08-04 13:50:55', '2024-08-04 13:50:55'),
(625, 219, 518, 500000, 1, 500000, '2024-08-04 13:50:55', '2024-08-04 13:50:55'),
(626, 220, 366, 450000, 1, 450000, '2024-08-04 13:50:55', '2024-08-04 13:50:55'),
(627, 221, 590, 400000, 1, 400000, '2024-08-04 13:50:55', '2024-08-04 13:50:55'),
(628, 222, 303, 300000, 1, 300000, '2024-08-04 13:50:55', '2024-08-04 13:50:55'),
(629, 223, 389, 450000, 1, 450000, '2024-08-04 13:50:55', '2024-08-04 13:50:55'),
(630, 224, 454, 520000, 1, 520000, '2024-08-04 13:50:55', '2024-08-04 13:50:55'),
(631, 225, 287, 300000, 1, 300000, '2024-08-04 13:50:55', '2024-08-04 13:50:55'),
(632, 226, 460, 520000, 1, 520000, '2024-08-04 13:50:55', '2024-08-04 13:50:55'),
(633, 227, 709, 750000, 1, 750000, '2024-08-04 13:50:55', '2024-08-04 13:50:55'),
(634, 228, 355, 450000, 1, 450000, '2024-08-04 13:50:55', '2024-08-04 13:50:55'),
(635, 229, 581, 400000, 1, 400000, '2024-08-04 13:50:55', '2024-08-04 13:50:55'),
(636, 230, 428, 480000, 1, 480000, '2024-08-04 13:50:55', '2024-08-04 13:50:55'),
(637, 231, 737, 400000, 1, 400000, '2024-08-04 13:50:55', '2024-08-04 13:50:55'),
(638, 232, 737, 400000, 1, 400000, '2024-08-04 13:50:55', '2024-08-04 13:50:55'),
(639, 233, 422, 480000, 1, 480000, '2024-08-04 13:50:55', '2024-08-04 13:50:55'),
(640, 234, 545, 550000, 1, 550000, '2024-08-04 13:50:55', '2024-08-04 13:50:55'),
(641, 235, 603, 380000, 1, 380000, '2024-08-04 13:50:55', '2024-08-04 13:50:55'),
(642, 194, 532, 550000, 1, 550000, '2024-08-04 13:54:35', '2024-08-04 13:54:35'),
(643, 193, 615, 380000, 1, 380000, '2024-08-04 14:14:06', '2024-08-04 14:14:06'),
(644, 192, 528, 550000, 1, 550000, '2024-08-04 14:14:58', '2024-08-04 14:14:58'),
(645, 95, 716, 890000, 1, 890000, '2024-08-07 09:36:06', '2024-08-07 09:36:06'),
(646, 207, 426, 480000, 1, 480000, '2024-08-07 09:44:13', '2024-08-07 09:44:13'),
(647, 57, 704, 750000, 1, 750000, '2024-08-07 10:00:04', '2024-08-07 10:00:04'),
(648, 25, 704, 750000, 1, 750000, '2024-08-07 10:02:42', '2024-08-07 10:02:42'),
(651, 213, 703, 750000, 1, 750000, '2024-08-07 10:40:51', '2024-08-07 10:40:51'),
(652, 236, 700, 750000, 1, 750000, '2024-08-08 13:58:08', '2024-08-08 13:58:08'),
(653, 213, 700, 750000, 1, 750000, '2024-08-08 15:24:11', '2024-08-08 15:24:11');

--
-- Bẫy `invoices_detail`
--
DELIMITER $$
CREATE TRIGGER `delete_detail_history` BEFORE DELETE ON `invoices_detail` FOR EACH ROW BEGIN
	DECLARE content VARCHAR(255);
	DECLARE product_code VARCHAR(255);
    DECLARE invoice_id VARCHAR(25);
    SET invoice_id = OLD.invoice_id;
    SET product_code = (SELECT products_detail.code FROM products_detail WHERE id = OLD.product_detail_id);
    
    SET content = CONCAT(@current_user, ' đã xóa sản phẩm: ',product_code,' (giá = ',FORMAT(OLD.price, 0),')',',số lượng: ', OLD.quantity);

    INSERT INTO invoices_history (invoice_id,content) VALUES (invoice_id,content);
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `delete_invoice_detail` AFTER DELETE ON `invoices_detail` FOR EACH ROW BEGIN
    UPDATE invoices
    SET total_price = (
        SELECT COALESCE(SUM(total_price), 0)
        FROM invoices_detail
        WHERE invoice_id = OLD.invoice_id
    )
    WHERE id = OLD.invoice_id;
    
    UPDATE invoices
    SET total_bill = total_price + shipping_fee
    WHERE id = OLD.invoice_id;
    
    
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `insert_detail_history` AFTER INSERT ON `invoices_detail` FOR EACH ROW BEGIN
	DECLARE content VARCHAR(255);
	DECLARE product_code VARCHAR(255);
    DECLARE invoice_id VARCHAR(25);
    SET invoice_id = NEW.invoice_id;
    SET product_code = (SELECT products_detail.code FROM products_detail WHERE id = NEW.product_detail_id);
    
SET content = CONCAT(IFNULL(@current_user, 'Hệ thống'), ' đã thêm sản phẩm: ', product_code, ' (giá = ', FORMAT(NEW.price, 0), ' VND)');


    INSERT INTO invoices_history (invoice_id,content) VALUES (invoice_id,content);
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `insert_invoice_detail` AFTER INSERT ON `invoices_detail` FOR EACH ROW BEGIN
    UPDATE invoices
    SET total_price = (
        SELECT COALESCE(SUM(total_price), 0)
        FROM invoices_detail
       	WHERE invoice_id = NEW.invoice_id
    )
    WHERE id = NEW.invoice_id;
    
    UPDATE invoices
    SET total_bill = total_price + shipping_fee
    WHERE id = NEW.invoice_id;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `update_invoice_detail` AFTER UPDATE ON `invoices_detail` FOR EACH ROW BEGIN
    UPDATE invoices
    	SET total_price = (
        SELECT 
        COALESCE(SUM(invoices_detail.total_price),0)
        FROM invoices_detail
        WHERE invoice_id = NEW.invoice_id
    	)
    WHERE id = NEW.invoice_id;
    
    UPDATE invoices
    SET total_bill = total_price + shipping_fee
    WHERE id = NEW.invoice_id;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `update_quantity_history` BEFORE UPDATE ON `invoices_detail` FOR EACH ROW BEGIN
	DECLARE content VARCHAR(255);
    DECLARE product_code VARCHAR(255);
    DECLARE invoice_id VARCHAR(25);
    SET invoice_id = NEW.invoice_id;
    SET product_code = (SELECT products_detail.code FROM products_detail WHERE id = NEW.product_detail_id);
    
	IF NEW.quantity != OLD.quantity THEN
    SET content = CONCAT( ' đã thay đổi Số lượng (', product_code,') :' , OLD.quantity, ' -> ', NEW.quantity);
    
    INSERT INTO invoices_history (invoice_id,content) VALUES (invoice_id,content);
    END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `invoices_history`
--

CREATE TABLE `invoices_history` (
  `id` int(11) NOT NULL,
  `invoice_id` int(11) NOT NULL,
  `content` varchar(500) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `invoices_history`
--

INSERT INTO `invoices_history` (`id`, `invoice_id`, `content`, `created_at`, `updated_at`) VALUES
(54, 131, 'quang anh đã thêm sản phẩm: DABJ00401CT00SB_NV-30 (giá = 550000)', '2024-08-01 10:47:14', '2024-08-01 10:47:14'),
(55, 131, 'quang anh đã thêm sản phẩm: 380,000 VND)', '2024-08-01 10:48:43', '2024-08-01 10:48:43'),
(56, 131, 'quang anh đã thêm sản phẩm: ESBK00202CT00RB_NV-32 (giá = 380,000 VND)', '2024-08-01 10:49:40', '2024-08-01 10:49:40'),
(62, 131, 'quang anh đã thay đổi Phí ship: 10000 -> 20000', '2024-08-01 10:57:11', '2024-08-01 10:57:11'),
(63, 131, 'quang anh đã thay đổi Tên khách hàng: nguyễn quang anh -> nguyễn quang anhd', '2024-08-01 10:57:32', '2024-08-01 10:57:32'),
(64, 131, 'quang anh đã thay đổi Số điện thoại: 3651518222 -> 3651518211', '2024-08-01 10:57:32', '2024-08-01 10:57:32'),
(65, 131, ' đã thay đổi Số lượng (ESBK00202CT00RB_NV-32) :1 -> 2', '2024-08-01 11:00:11', '2024-08-01 11:00:11'),
(66, 131, 'quang anh đã thay đổi Phí ship: 20,000 VND) -> 10,000 VND)', '2024-08-01 11:02:10', '2024-08-01 11:02:10'),
(67, 131, 'quang anh đã xóa sản phẩm: ESBK00202CT00RB_NV-32 (giá = 380000)', '2024-08-01 11:03:47', '2024-08-01 11:03:47'),
(68, 131, 'quang anh đã xóa sản phẩm: ESBK00202CT00RB_LG-29 (giá = 380000),số lượng: 1', '2024-08-01 11:04:44', '2024-08-01 11:04:44'),
(69, 131, 'quang anh đã xóa sản phẩm: DABJ00401CT00SB_NV-30 (giá = 550,000),số lượng: 1', '2024-08-01 11:05:57', '2024-08-01 11:05:57'),
(71, 129, 'quang anh đã thay đổi Ghi chú: a -> ', '2024-08-01 12:04:42', '2024-08-01 12:04:42'),
(72, 129, 'quang anh đã thay đổi Ghi chú:  -> s', '2024-08-01 12:04:47', '2024-08-01 12:04:47'),
(73, 129, 'quang anh đã thay đổi Phí ship: 10,000 VND) -> 20,000 VND)', '2024-08-01 12:05:02', '2024-08-01 12:05:02'),
(74, 129, 'quang anh đã thay đổi Phí ship: 20,000 VND) -> 10,000 VND)', '2024-08-01 12:05:22', '2024-08-01 12:05:22'),
(75, 129, 'quang anh đã thay đổi Ghi chú: s -> a', '2024-08-01 12:05:31', '2024-08-01 12:05:31'),
(76, 134, 'quang anh đã thay đổi Ghi chú: a -> ', '2024-08-01 12:08:33', '2024-08-01 12:08:33'),
(77, 134, 'quang anh đã thay đổi Ghi chú:  -> a', '2024-08-01 12:08:39', '2024-08-01 12:08:39'),
(78, 134, 'quang anh đã thay đổi Trạng thái đơn hàng: DELIVERING -> SUCCESS', '2024-08-01 12:09:01', '2024-08-01 12:09:01'),
(79, 133, 'quang anh đã thay đổi Trạng thái đơn hàng: DELIVERING -> SUCCESS', '2024-08-01 12:14:51', '2024-08-01 12:14:51'),
(80, 131, 'quang anh đã thay đổi trạng thái thanh toán: Chưa thanh toán -> Đã thanh toán', '2024-08-01 12:15:04', '2024-08-01 12:15:04'),
(81, 131, 'quang anh đã thay đổi trạng thái thanh toán: Đã thanh toán -> Chưa thanh toán', '2024-08-01 12:15:08', '2024-08-01 12:15:08'),
(82, 126, 'quang anh đã thay đổi Số điện thoại: 0365151822 -> 0365151821', '2024-08-04 08:49:30', '2024-08-04 08:49:30'),
(83, 126, 'quang anh đã thay đổi Ghi chú: s -> sa', '2024-08-04 08:49:34', '2024-08-04 08:49:34'),
(84, 126, 'quang anh đã thay đổi Ghi chú: sa -> saa', '2024-08-04 08:50:05', '2024-08-04 08:50:05'),
(85, 131, 'quang anh đã thay đổi Trạng thái đơn hàng: PROCESS -> NEW', '2024-08-04 09:25:02', '2024-08-04 09:25:02'),
(86, 131, ' đã thay đổi Số lượng (DATB41671CA11RB_NBX-38) :1 -> 2', '2024-08-04 09:31:47', '2024-08-04 09:31:47'),
(87, 131, 'quang anh đã thay đổi Địa chỉ: số 18 ngõ 222 tựu liệt,thanh trì, hà nội -> số 18 ngõ 222 tựu liệt,thanh trì, hàc nội', '2024-08-04 09:34:02', '2024-08-04 09:34:02'),
(88, 131, 'quang anh đã thay đổi Phí ship: 10,000 VND) -> 30,000 VND)', '2024-08-04 09:37:26', '2024-08-04 09:37:26'),
(89, 131, 'quang anh đã thay đổi Địa chỉ: số 18 ngõ 222 tựu liệt,thanh trì, hàc nội -> số 18 ngõ 222 tựu liệt,thanh trì, hà nội', '2024-08-04 09:37:39', '2024-08-04 09:37:39'),
(90, 131, 'quang anh đã thay đổi Ghi chú: c -> ', '2024-08-04 09:37:39', '2024-08-04 09:37:39'),
(91, 131, 'quang anh đã thay đổi Tên khách hàng: nguyễn quang anhd -> nguyễn quang anh\nquang anh đã thay đổi Số điện thoại: 3651518211 -> 3651518222\n', '2024-08-04 09:44:04', '2024-08-04 09:44:04'),
(92, 131, 'quang anh đã thay đổi Tên khách hàng: nguyễn quang anh -> nguyễn quang anhh<br>quang anh đã thay đổi Số điện thoại: 3651518222 -> 3651518223<br>quang anh đã thay đổi Địa chỉ: số 18 ngõ 222 tựu liệt,thanh trì, hà nội -> số 18 ngõ 222 tựu liệt,thanh trì, hà nộii<br>quang anh đã thay đổi Ghi chú:  -> s<br>', '2024-08-04 09:48:28', '2024-08-04 09:48:28'),
(94, 135, 'quang anh đã tạo đơn hàng: <br>Mã đơn: BRBJTMWZ,<br>Tên khách hàng: quang anh,<br>Số điện thoại: 0364100196,<br>Địa chỉ: dsva,<br>Trạng thái thanh toán: Chưa thanh toán', '2024-08-04 10:36:26', '2024-08-04 10:36:26'),
(97, 135, 'quang anh đã thêm sản phẩm: DSBI01302LI00SB_WH-31 (giá = 380,000 VND)', '2024-08-04 10:36:26', '2024-08-04 10:36:26'),
(100, 135, 'quang anh đã thêm sản phẩm: DSBI01302LI00SB_LB-31 (giá = 380,000 VND)', '2024-08-04 10:36:27', '2024-08-04 10:36:27'),
(101, 135, 'quang anh đã xóa sản phẩm: DSBI01302LI00SB_WH-31 (giá = 380,000),số lượng: 1', '2024-08-04 12:17:24', '2024-08-04 12:17:24'),
(104, 135, 'quang anh đã xóa sản phẩm: DSBI01302LI00SB_LB-31 (giá = 380,000),số lượng: 1', '2024-08-04 12:17:26', '2024-08-04 12:17:26'),
(108, 134, 'quang anh đã thay đổi trạng thái thanh toán: Đã thanh toán -> Chưa thanh toán<br>', '2024-08-04 12:18:01', '2024-08-04 12:18:01'),
(109, 134, 'quang anh đã xóa sản phẩm: DATB92071BA00SB_WH-39 (giá = 42,000),số lượng: 1', '2024-08-04 12:18:05', '2024-08-04 12:18:05'),
(113, 133, 'quang anh đã xóa sản phẩm: DATB61471BA00SB_NV-41 (giá = 450,000),số lượng: 1', '2024-08-04 12:18:43', '2024-08-04 12:18:43'),
(117, 132, 'quang anh đã xóa sản phẩm: DATB61471BA00SB_LLB-40 (giá = 450,000),số lượng: 1', '2024-08-04 12:19:30', '2024-08-04 12:19:30'),
(121, 131, 'quang anh đã xóa sản phẩm: DATB41671CA11RB_NBX-38 (giá = 480,000),số lượng: 2', '2024-08-04 12:19:55', '2024-08-04 12:19:55'),
(125, 130, 'quang anh đã xóa sản phẩm: DATB41671CA11RB_NBX-39 (giá = 480,000),số lượng: 1', '2024-08-04 12:20:27', '2024-08-04 12:20:27'),
(128, 129, 'quang anh đã xóa sản phẩm: DATB61471BA00SB_WH-39 (giá = 450,000),số lượng: 1', '2024-08-04 12:20:41', '2024-08-04 12:20:41'),
(131, 128, 'quang anh đã xóa sản phẩm: DATB41671CA11RB_NBX-39 (giá = 480,000),số lượng: 1', '2024-08-04 12:21:10', '2024-08-04 12:21:10'),
(134, 127, 'quang anh đã xóa sản phẩm: DATB61471BA00SB_LLB-40 (giá = 450,000),số lượng: 1', '2024-08-04 12:21:16', '2024-08-04 12:21:16'),
(137, 126, 'quang anh đã xóa sản phẩm: DATB61471BA00SB_LLB-38 (giá = 450,000),số lượng: 1', '2024-08-04 12:21:22', '2024-08-04 12:21:22'),
(140, 125, 'quang anh đã xóa sản phẩm: DATB61471BA00SB_WH-39 (giá = 450,000),số lượng: 1', '2024-08-04 12:21:32', '2024-08-04 12:21:32'),
(143, 124, 'quang anh đã xóa sản phẩm: DATB41671CA11RB_NBX-39 (giá = 480,000),số lượng: 1', '2024-08-04 12:21:47', '2024-08-04 12:21:47'),
(146, 123, 'quang anh đã xóa sản phẩm: DATB41671CA11RB_NBX-38 (giá = 480,000),số lượng: 1', '2024-08-04 12:21:55', '2024-08-04 12:21:55'),
(149, 122, 'quang anh đã xóa sản phẩm: DATB41671CA11RB_NBX-38 (giá = 480,000),số lượng: 1', '2024-08-04 12:22:01', '2024-08-04 12:22:01'),
(152, 121, 'quang anh đã xóa sản phẩm: DATB41671CA11RB_NBX-38 (giá = 480,000),số lượng: 1', '2024-08-04 12:22:09', '2024-08-04 12:22:09'),
(155, 118, 'quang anh đã xóa sản phẩm: DATB41671CA11RB_NBX-38 (giá = 480,000),số lượng: 1', '2024-08-04 12:22:16', '2024-08-04 12:22:16'),
(158, 120, 'quang anh đã xóa sản phẩm: DATB41671CA11RB_NBX-38 (giá = 480,000),số lượng: 1', '2024-08-04 12:22:22', '2024-08-04 12:22:22'),
(161, 117, 'quang anh đã xóa sản phẩm: DATB61471BA00SB_WH-39 (giá = 450,000),số lượng: 1', '2024-08-04 12:22:37', '2024-08-04 12:22:37'),
(164, 116, 'quang anh đã xóa sản phẩm: DATB41671CA11RB_NBX-38 (giá = 480,000),số lượng: 1', '2024-08-04 12:22:42', '2024-08-04 12:22:42'),
(286, 179, 'quang anh đã thay đổi trạng thái thanh toán: Đã thanh toán -> Chưa thanh toán<br>', '2024-08-04 12:42:51', '2024-08-04 12:42:51'),
(289, 179, 'quang anh đã thêm sản phẩm: DABJ90801CT19SB_DBU-32 (giá = 550,000 VND)', '2024-08-04 12:42:57', '2024-08-04 12:42:57'),
(292, 179, 'quang anh đã thêm sản phẩm: CABJ00301CT19SB_BU-29 (giá = 550,000 VND)', '2024-08-04 12:43:02', '2024-08-04 12:43:02'),
(293, 179, 'quang anh đã thay đổi trạng thái thanh toán: Chưa thanh toán -> Đã thanh toán<br>', '2024-08-04 12:43:14', '2024-08-04 12:43:14'),
(294, 185, 'quang anh đã thay đổi trạng thái thanh toán: Đã thanh toán -> Chưa thanh toán<br>', '2024-08-04 12:44:35', '2024-08-04 12:44:35'),
(297, 185, 'quang anh đã thêm sản phẩm: DATB61471BA00SB_WH-38 (giá = 450,000 VND)', '2024-08-04 12:44:42', '2024-08-04 12:44:42'),
(299, 185, 'quang anh đã thay đổi trạng thái thanh toán: Chưa thanh toán -> Đã thanh toán<br>', '2024-08-04 12:44:50', '2024-08-04 12:44:50'),
(302, 184, 'quang anh đã thêm sản phẩm: DSBI01302LI00SB_BE-33 (giá = 380,000 VND)', '2024-08-04 12:46:24', '2024-08-04 12:46:24'),
(305, 184, 'quang anh đã thêm sản phẩm: DSBI01302LI00SB_LB-33 (giá = 380,000 VND)', '2024-08-04 12:46:30', '2024-08-04 12:46:30'),
(306, 138, 'quang anh đã thay đổi trạng thái thanh toán: Đã thanh toán -> Chưa thanh toán<br>', '2024-08-04 12:47:03', '2024-08-04 12:47:03'),
(307, 138, 'quang anh đã thay đổi trạng thái thanh toán: Chưa thanh toán -> Đã thanh toán<br>', '2024-08-04 12:47:10', '2024-08-04 12:47:10'),
(310, 185, 'quang anh đã thêm sản phẩm: DSBI01302LI00SB_BE-32 (giá = 380,000 VND)', '2024-08-04 12:59:53', '2024-08-04 12:59:53'),
(329, 186, 'Hệ thống đã tạo đơn hàng: <br>Mã đơn: E71SLKFT,<br>Tên khách hàng: John Doe,<br>Số điện thoại: 0912345678,<br>Địa chỉ: 123 Main St,<br>Trạng thái thanh toán: Đã thanh toán', '2024-08-04 13:10:15', '2024-08-04 13:10:15'),
(330, 187, 'Hệ thống đã tạo đơn hàng: <br>Mã đơn: D92KLMN1,<br>Tên khách hàng: Jane Smith,<br>Số điện thoại: 0923456789,<br>Địa chỉ: 456 Elm St,<br>Trạng thái thanh toán: Chưa thanh toán', '2024-08-04 13:10:15', '2024-08-04 13:10:15'),
(331, 188, 'Hệ thống đã tạo đơn hàng: <br>Mã đơn: B84NOPQR,<br>Tên khách hàng: Alice Johnson,<br>Số điện thoại: 0934567890,<br>Địa chỉ: 789 Pine St,<br>Trạng thái thanh toán: Đã thanh toán', '2024-08-04 13:10:15', '2024-08-04 13:10:15'),
(332, 189, 'Hệ thống đã tạo đơn hàng: <br>Mã đơn: C75QRSTU,<br>Tên khách hàng: Bob Brown,<br>Số điện thoại: 0945678901,<br>Địa chỉ: 101 Maple St,<br>Trạng thái thanh toán: Đã thanh toán', '2024-08-04 13:10:15', '2024-08-04 13:10:15'),
(333, 190, 'Hệ thống đã tạo đơn hàng: <br>Mã đơn: A63UVWX1,<br>Tên khách hàng: Charlie Davis,<br>Số điện thoại: 0956789012,<br>Địa chỉ: 202 Oak St,<br>Trạng thái thanh toán: Chưa thanh toán', '2024-08-04 13:10:15', '2024-08-04 13:10:15'),
(334, 191, 'Hệ thống đã tạo đơn hàng: <br>Mã đơn: F48YZAB2,<br>Tên khách hàng: David Evans,<br>Số điện thoại: 0967890123,<br>Địa chỉ: 303 Birch St,<br>Trạng thái thanh toán: Đã thanh toán', '2024-08-04 13:10:15', '2024-08-04 13:10:15'),
(335, 192, 'Hệ thống đã tạo đơn hàng: <br>Mã đơn: G57CDE3F,<br>Tên khách hàng: Eva White,<br>Số điện thoại: 0978901234,<br>Địa chỉ: 404 Cedar St,<br>Trạng thái thanh toán: Chưa thanh toán', '2024-08-04 13:10:15', '2024-08-04 13:10:15'),
(336, 193, 'Hệ thống đã tạo đơn hàng: <br>Mã đơn: H82FGHI4,<br>Tên khách hàng: Frank Black,<br>Số điện thoại: 0989012345,<br>Địa chỉ: 505 Willow St,<br>Trạng thái thanh toán: Đã thanh toán', '2024-08-04 13:10:15', '2024-08-04 13:10:15'),
(337, 194, 'Hệ thống đã tạo đơn hàng: <br>Mã đơn: J19IJKL5,<br>Tên khách hàng: Grace Green,<br>Số điện thoại: 0990123456,<br>Địa chỉ: 606 Fir St,<br>Trạng thái thanh toán: Đã thanh toán', '2024-08-04 13:10:15', '2024-08-04 13:10:15'),
(338, 195, 'Hệ thống đã tạo đơn hàng: <br>Mã đơn: K23LMNO6,<br>Tên khách hàng: Henry Clark,<br>Số điện thoại: 0901234567,<br>Địa chỉ: 707 Redwood St,<br>Trạng thái thanh toán: Chưa thanh toán', '2024-08-04 13:10:15', '2024-08-04 13:10:15'),
(339, 196, 'Hệ thống đã tạo đơn hàng: <br>Mã đơn: L34NOPQ7,<br>Tên khách hàng: Ivy Lewis,<br>Số điện thoại: 0912345670,<br>Địa chỉ: 808 Cypress St,<br>Trạng thái thanh toán: Đã thanh toán', '2024-08-04 13:10:15', '2024-08-04 13:10:15'),
(340, 197, 'Hệ thống đã tạo đơn hàng: <br>Mã đơn: M45OPQR8,<br>Tên khách hàng: Jack Martin,<br>Số điện thoại: 0923456781,<br>Địa chỉ: 909 Palm St,<br>Trạng thái thanh toán: Chưa thanh toán', '2024-08-04 13:10:15', '2024-08-04 13:10:15'),
(341, 198, 'Hệ thống đã tạo đơn hàng: <br>Mã đơn: N56PQRS9,<br>Tên khách hàng: Kathy Walker,<br>Số điện thoại: 0934567892,<br>Địa chỉ: 1010 Spruce St,<br>Trạng thái thanh toán: Đã thanh toán', '2024-08-04 13:10:15', '2024-08-04 13:10:15'),
(342, 199, 'Hệ thống đã tạo đơn hàng: <br>Mã đơn: O67RST0A,<br>Tên khách hàng: Leo Adams,<br>Số điện thoại: 0945678903,<br>Địa chỉ: 1111 Pine St,<br>Trạng thái thanh toán: Chưa thanh toán', '2024-08-04 13:10:15', '2024-08-04 13:10:15'),
(343, 200, 'Hệ thống đã tạo đơn hàng: <br>Mã đơn: P78STU1B,<br>Tên khách hàng: Mona Young,<br>Số điện thoại: 0956789014,<br>Địa chỉ: 1212 Maple St,<br>Trạng thái thanh toán: Đã thanh toán', '2024-08-04 13:10:15', '2024-08-04 13:10:15'),
(344, 201, 'Hệ thống đã tạo đơn hàng: <br>Mã đơn: Q89TUV2C,<br>Tên khách hàng: Nina Scott,<br>Số điện thoại: 0967890125,<br>Địa chỉ: 1313 Birch St,<br>Trạng thái thanh toán: Chưa thanh toán', '2024-08-04 13:10:15', '2024-08-04 13:10:15'),
(345, 202, 'Hệ thống đã tạo đơn hàng: <br>Mã đơn: R90UVW3D,<br>Tên khách hàng: Oscar King,<br>Số điện thoại: 0978901236,<br>Địa chỉ: 1414 Cedar St,<br>Trạng thái thanh toán: Đã thanh toán', '2024-08-04 13:10:15', '2024-08-04 13:10:15'),
(346, 203, 'Hệ thống đã tạo đơn hàng: <br>Mã đơn: S12VWX4E,<br>Tên khách hàng: Pamela Harris,<br>Số điện thoại: 0989012347,<br>Địa chỉ: 1515 Willow St,<br>Trạng thái thanh toán: Đã thanh toán', '2024-08-04 13:10:15', '2024-08-04 13:10:15'),
(347, 204, 'Hệ thống đã tạo đơn hàng: <br>Mã đơn: T23WXY5F,<br>Tên khách hàng: Quincy Allen,<br>Số điện thoại: 0990123458,<br>Địa chỉ: 1616 Fir St,<br>Trạng thái thanh toán: Chưa thanh toán', '2024-08-04 13:10:15', '2024-08-04 13:10:15'),
(348, 205, 'Hệ thống đã tạo đơn hàng: <br>Mã đơn: U34XYZ6G,<br>Tên khách hàng: Rachel Baker,<br>Số điện thoại: 0901234568,<br>Địa chỉ: 1717 Redwood St,<br>Trạng thái thanh toán: Đã thanh toán', '2024-08-04 13:10:15', '2024-08-04 13:10:15'),
(349, 206, 'Hệ thống đã tạo đơn hàng: <br>Mã đơn: V45YZA7H,<br>Tên khách hàng: Steve Carter,<br>Số điện thoại: 0912345679,<br>Địa chỉ: 1818 Cypress St,<br>Trạng thái thanh toán: Chưa thanh toán', '2024-08-04 13:10:15', '2024-08-04 13:10:15'),
(350, 207, 'Hệ thống đã tạo đơn hàng: <br>Mã đơn: W56ZAB8I,<br>Tên khách hàng: Tina Murphy,<br>Số điện thoại: 0923456782,<br>Địa chỉ: 1919 Palm St,<br>Trạng thái thanh toán: Đã thanh toán', '2024-08-04 13:10:15', '2024-08-04 13:10:15'),
(351, 208, 'Hệ thống đã tạo đơn hàng: <br>Mã đơn: X67ABC9J,<br>Tên khách hàng: Ursula Fisher,<br>Số điện thoại: 0934567893,<br>Địa chỉ: 2020 Spruce St,<br>Trạng thái thanh toán: Đã thanh toán', '2024-08-04 13:10:15', '2024-08-04 13:10:15'),
(352, 209, 'Hệ thống đã tạo đơn hàng: <br>Mã đơn: Y78BCD0K,<br>Tên khách hàng: Victor Gomez,<br>Số điện thoại: 0945678904,<br>Địa chỉ: 2121 Pine St,<br>Trạng thái thanh toán: Chưa thanh toán', '2024-08-04 13:10:15', '2024-08-04 13:10:15'),
(353, 210, 'Hệ thống đã tạo đơn hàng: <br>Mã đơn: Z89CDE1L,<br>Tên khách hàng: Wendy Peterson,<br>Số điện thoại: 0956789015,<br>Địa chỉ: 2222 Maple St,<br>Trạng thái thanh toán: Đã thanh toán', '2024-08-04 13:10:15', '2024-08-04 13:10:15'),
(354, 211, 'Hệ thống đã tạo đơn hàng: <br>Mã đơn: A90DEF2M,<br>Tên khách hàng: Xander Price,<br>Số điện thoại: 0967890126,<br>Địa chỉ: 2323 Birch St,<br>Trạng thái thanh toán: Chưa thanh toán', '2024-08-04 13:10:15', '2024-08-04 13:10:15'),
(355, 212, 'Hệ thống đã tạo đơn hàng: <br>Mã đơn: B12EFG3N,<br>Tên khách hàng: Yvonne Bennett,<br>Số điện thoại: 0978901237,<br>Địa chỉ: 2424 Cedar St,<br>Trạng thái thanh toán: Đã thanh toán', '2024-08-04 13:10:15', '2024-08-04 13:10:15'),
(356, 213, 'Hệ thống đã tạo đơn hàng: <br>Mã đơn: C23FGH4O,<br>Tên khách hàng: Zachary Collins,<br>Số điện thoại: 0989012348,<br>Địa chỉ: 2525 Willow St,<br>Trạng thái thanh toán: Chưa thanh toán', '2024-08-04 13:10:15', '2024-08-04 13:10:15'),
(357, 214, 'Hệ thống đã tạo đơn hàng: <br>Mã đơn: D34GHI5P,<br>Tên khách hàng: Alice Morgan,<br>Số điện thoại: 0990123459,<br>Địa chỉ: 2626 Fir St,<br>Trạng thái thanh toán: Đã thanh toán', '2024-08-04 13:10:15', '2024-08-04 13:10:15'),
(358, 215, 'Hệ thống đã tạo đơn hàng: <br>Mã đơn: E45HIJ6Q,<br>Tên khách hàng: Brian Cooper,<br>Số điện thoại: 0901234569,<br>Địa chỉ: 2727 Redwood St,<br>Trạng thái thanh toán: Đã thanh toán', '2024-08-04 13:10:15', '2024-08-04 13:10:15'),
(359, 216, 'Hệ thống đã tạo đơn hàng: <br>Mã đơn: F56IJK7R,<br>Tên khách hàng: Clara Ramirez,<br>Số điện thoại: 0912345670,<br>Địa chỉ: 2828 Cypress St,<br>Trạng thái thanh toán: Chưa thanh toán', '2024-08-04 13:10:15', '2024-08-04 13:10:15'),
(360, 217, 'Hệ thống đã tạo đơn hàng: <br>Mã đơn: G67JKL8S,<br>Tên khách hàng: Daniel Cox,<br>Số điện thoại: 0923456783,<br>Địa chỉ: 2929 Palm St,<br>Trạng thái thanh toán: Đã thanh toán', '2024-08-04 13:10:15', '2024-08-04 13:10:15'),
(361, 218, 'Hệ thống đã tạo đơn hàng: <br>Mã đơn: H78KLM9T,<br>Tên khách hàng: Ella Ward,<br>Số điện thoại: 0934567894,<br>Địa chỉ: 3030 Spruce St,<br>Trạng thái thanh toán: Chưa thanh toán', '2024-08-04 13:10:15', '2024-08-04 13:10:15'),
(362, 219, 'Hệ thống đã tạo đơn hàng: <br>Mã đơn: I89LMN0U,<br>Tên khách hàng: Frank Morris,<br>Số điện thoại: 0945678905,<br>Địa chỉ: 3131 Pine St,<br>Trạng thái thanh toán: Đã thanh toán', '2024-08-04 13:10:15', '2024-08-04 13:10:15'),
(363, 220, 'Hệ thống đã tạo đơn hàng: <br>Mã đơn: J90MNO1V,<br>Tên khách hàng: Grace Rogers,<br>Số điện thoại: 0956789016,<br>Địa chỉ: 3232 Maple St,<br>Trạng thái thanh toán: Chưa thanh toán', '2024-08-04 13:10:15', '2024-08-04 13:10:15'),
(364, 221, 'Hệ thống đã tạo đơn hàng: <br>Mã đơn: K12NOP2W,<br>Tên khách hàng: Henry Murphy,<br>Số điện thoại: 0967890127,<br>Địa chỉ: 3333 Birch St,<br>Trạng thái thanh toán: Đã thanh toán', '2024-08-04 13:10:15', '2024-08-04 13:10:15'),
(365, 222, 'Hệ thống đã tạo đơn hàng: <br>Mã đơn: L23OPQ3X,<br>Tên khách hàng: Ivy Sanders,<br>Số điện thoại: 0978901238,<br>Địa chỉ: 3434 Cedar St,<br>Trạng thái thanh toán: Đã thanh toán', '2024-08-04 13:10:15', '2024-08-04 13:10:15'),
(366, 223, 'Hệ thống đã tạo đơn hàng: <br>Mã đơn: M34PQR4Y,<br>Tên khách hàng: Jack Barnes,<br>Số điện thoại: 0989012349,<br>Địa chỉ: 3535 Willow St,<br>Trạng thái thanh toán: Chưa thanh toán', '2024-08-04 13:10:15', '2024-08-04 13:10:15'),
(367, 224, 'Hệ thống đã tạo đơn hàng: <br>Mã đơn: N45QRS5Z,<br>Tên khách hàng: Kathy Hayes,<br>Số điện thoại: 0990123460,<br>Địa chỉ: 3636 Fir St,<br>Trạng thái thanh toán: Đã thanh toán', '2024-08-04 13:10:15', '2024-08-04 13:10:15'),
(368, 225, 'Hệ thống đã tạo đơn hàng: <br>Mã đơn: O56RST6A,<br>Tên khách hàng: Leo Bennett,<br>Số điện thoại: 0901234570,<br>Địa chỉ: 3737 Redwood St,<br>Trạng thái thanh toán: Chưa thanh toán', '2024-08-04 13:10:15', '2024-08-04 13:10:15'),
(369, 226, 'Hệ thống đã tạo đơn hàng: <br>Mã đơn: P67STU7B,<br>Tên khách hàng: Mona Kelly,<br>Số điện thoại: 0912345671,<br>Địa chỉ: 3838 Cypress St,<br>Trạng thái thanh toán: Đã thanh toán', '2024-08-04 13:10:15', '2024-08-04 13:10:15'),
(370, 227, 'Hệ thống đã tạo đơn hàng: <br>Mã đơn: Q78TUV8C,<br>Tên khách hàng: Nina Hughes,<br>Số điện thoại: 0923456784,<br>Địa chỉ: 3939 Palm St,<br>Trạng thái thanh toán: Chưa thanh toán', '2024-08-04 13:10:15', '2024-08-04 13:10:15'),
(371, 228, 'Hệ thống đã tạo đơn hàng: <br>Mã đơn: R89UVW9D,<br>Tên khách hàng: Oscar Ward,<br>Số điện thoại: 0934567895,<br>Địa chỉ: 4040 Spruce St,<br>Trạng thái thanh toán: Đã thanh toán', '2024-08-04 13:10:15', '2024-08-04 13:10:15'),
(372, 229, 'Hệ thống đã tạo đơn hàng: <br>Mã đơn: S90VWX0E,<br>Tên khách hàng: Pamela Cook,<br>Số điện thoại: 0945678906,<br>Địa chỉ: 4141 Pine St,<br>Trạng thái thanh toán: Đã thanh toán', '2024-08-04 13:10:15', '2024-08-04 13:10:15'),
(373, 230, 'Hệ thống đã tạo đơn hàng: <br>Mã đơn: T12WXY1F,<br>Tên khách hàng: Quincy Diaz,<br>Số điện thoại: 0956789017,<br>Địa chỉ: 4242 Maple St,<br>Trạng thái thanh toán: Chưa thanh toán', '2024-08-04 13:10:15', '2024-08-04 13:10:15'),
(374, 231, 'Hệ thống đã tạo đơn hàng: <br>Mã đơn: U23XYZ2G,<br>Tên khách hàng: Rachel Lee,<br>Số điện thoại: 0967890128,<br>Địa chỉ: 4343 Birch St,<br>Trạng thái thanh toán: Đã thanh toán', '2024-08-04 13:10:15', '2024-08-04 13:10:15'),
(375, 232, 'Hệ thống đã tạo đơn hàng: <br>Mã đơn: V34YZA3H,<br>Tên khách hàng: Steve Scott,<br>Số điện thoại: 0978901239,<br>Địa chỉ: 4444 Cedar St,<br>Trạng thái thanh toán: Chưa thanh toán', '2024-08-04 13:10:15', '2024-08-04 13:10:15'),
(376, 233, 'Hệ thống đã tạo đơn hàng: <br>Mã đơn: W45ZAB4I,<br>Tên khách hàng: Tina Mitchell,<br>Số điện thoại: 0989012350,<br>Địa chỉ: 4545 Willow St,<br>Trạng thái thanh toán: Đã thanh toán', '2024-08-04 13:10:15', '2024-08-04 13:10:15'),
(377, 234, 'Hệ thống đã tạo đơn hàng: <br>Mã đơn: X56ABC5J,<br>Tên khách hàng: Ursula Lopez,<br>Số điện thoại: 0990123461,<br>Địa chỉ: 4646 Fir St,<br>Trạng thái thanh toán: Chưa thanh toán', '2024-08-04 13:10:15', '2024-08-04 13:10:15'),
(378, 235, 'Hệ thống đã tạo đơn hàng: <br>Mã đơn: Y67BCD6K,<br>Tên khách hàng: Victor Young,<br>Số điện thoại: 0901234571,<br>Địa chỉ: 4747 Redwood St,<br>Trạng thái thanh toán: Đã thanh toán', '2024-08-04 13:10:15', '2024-08-04 13:10:15'),
(381, 186, 'quang anh đã thêm sản phẩm: ESTB02672LI00RB_WH-41 (giá = 450,000 VND)', '2024-08-04 13:38:32', '2024-08-04 13:38:32'),
(384, 187, 'quang anh đã thêm sản phẩm: ESBK00702CT00RB_BL-29 (giá = 400,000 VND)', '2024-08-04 13:38:32', '2024-08-04 13:38:32'),
(387, 188, 'quang anh đã thêm sản phẩm: ESTB02672LI00RB_WH-40 (giá = 450,000 VND)', '2024-08-04 13:38:32', '2024-08-04 13:38:32'),
(390, 189, 'quang anh đã thêm sản phẩm: ESTB02672LI00RB_WH-42 (giá = 450,000 VND)', '2024-08-04 13:38:32', '2024-08-04 13:38:32'),
(393, 190, 'quang anh đã thêm sản phẩm: ESTP04272CV00SB_TU-XXL (giá = 349,000 VND)', '2024-08-04 13:38:32', '2024-08-04 13:38:32'),
(396, 191, 'quang anh đã thêm sản phẩm: ESTP01572CV32SB_WNV-S (giá = 450,000 VND)', '2024-08-04 13:38:32', '2024-08-04 13:38:32'),
(399, 192, 'quang anh đã thêm sản phẩm: ESTP04272CV00SB_DTU-M (giá = 349,000 VND)', '2024-08-04 13:38:32', '2024-08-04 13:38:32'),
(402, 193, 'quang anh đã thêm sản phẩm: ESBW00402PE01MB_LG-M (giá = 350,000 VND)', '2024-08-04 13:38:32', '2024-08-04 13:38:32'),
(405, 194, 'quang anh đã thêm sản phẩm: ESTS03812CT06MB_NV-S (giá = 300,000 VND)', '2024-08-04 13:38:32', '2024-08-04 13:38:32'),
(408, 195, 'quang anh đã thêm sản phẩm: ESTP07472CT00SB_WH-M (giá = 420,000 VND)', '2024-08-04 13:38:32', '2024-08-04 13:38:32'),
(411, 196, 'quang anh đã thêm sản phẩm: ESTS03812CT06MB_NV-XL (giá = 300,000 VND)', '2024-08-04 13:38:32', '2024-08-04 13:38:32'),
(414, 197, 'quang anh đã thêm sản phẩm: EATB00671LI13RB_DNV-39 (giá = 480,000 VND)', '2024-08-04 13:38:32', '2024-08-04 13:38:32'),
(417, 198, 'quang anh đã thêm sản phẩm: ESTP02072TC32SB_BBR-L (giá = 450,000 VND)', '2024-08-04 13:38:32', '2024-08-04 13:38:32'),
(420, 199, 'quang anh đã thêm sản phẩm: EWCP00251PE00SB_DNV-S (giá = 1,200,000 VND)', '2024-08-04 13:38:32', '2024-08-04 13:38:32'),
(423, 200, 'quang anh đã thêm sản phẩm: ESTP01272CT08SB_VCB-S (giá = 500,000 VND)', '2024-08-04 13:38:32', '2024-08-04 13:38:32'),
(426, 201, 'quang anh đã thêm sản phẩm: ESTA00612CT06MB_BL-M (giá = 250,000 VND)', '2024-08-04 13:38:32', '2024-08-04 13:38:32'),
(429, 186, 'quang anh đã thêm sản phẩm: EWCW00751PE00SB_NV-L (giá = 50,000 VND)', '2024-08-04 13:39:49', '2024-08-04 13:39:49'),
(432, 187, 'quang anh đã thêm sản phẩm: ESTP04772CA00SB_DCR-XL (giá = 500,000 VND)', '2024-08-04 13:39:49', '2024-08-04 13:39:49'),
(435, 188, 'quang anh đã thêm sản phẩm: DATB92071BA00SB_NV-38 (giá = 42,000 VND)', '2024-08-04 13:39:49', '2024-08-04 13:39:49'),
(438, 189, 'quang anh đã thêm sản phẩm: EATB00371CA11SB_GN-40 (giá = 520,000 VND)', '2024-08-04 13:39:49', '2024-08-04 13:39:49'),
(441, 190, 'quang anh đã thêm sản phẩm: EWCW00751PE00SB_NV-M (giá = 50,000 VND)', '2024-08-04 13:39:49', '2024-08-04 13:39:49'),
(444, 191, 'quang anh đã thêm sản phẩm: EABT01901PE00SB_LBL-32 (giá = 500,000 VND)', '2024-08-04 13:39:49', '2024-08-04 13:39:49'),
(447, 192, 'quang anh đã thêm sản phẩm: EWCW00751PE00SB_BL-M (giá = 50,000 VND)', '2024-08-04 13:39:49', '2024-08-04 13:39:49'),
(450, 193, 'quang anh đã thêm sản phẩm: ESTB02672LI00RB_DNV-38 (giá = 450,000 VND)', '2024-08-04 13:39:49', '2024-08-04 13:39:49'),
(453, 194, 'quang anh đã thêm sản phẩm: DSBI01302LI00SB_BE-31 (giá = 380,000 VND)', '2024-08-04 13:39:49', '2024-08-04 13:39:49'),
(456, 195, 'quang anh đã thêm sản phẩm: EATB00671LI13RB_DNV-42 (giá = 480,000 VND)', '2024-08-04 13:39:49', '2024-08-04 13:39:49'),
(459, 196, 'quang anh đã thêm sản phẩm: DWCT00431PE32SB_WH-L (giá = 750,000 VND)', '2024-08-04 13:39:49', '2024-08-04 13:39:49'),
(462, 197, 'quang anh đã thêm sản phẩm: ESBW00502PE00RB_NV-L (giá = 320,000 VND)', '2024-08-04 13:39:49', '2024-08-04 13:39:49'),
(465, 198, 'quang anh đã thêm sản phẩm: ESTA00612CT06MB_BL-S (giá = 250,000 VND)', '2024-08-04 13:39:49', '2024-08-04 13:39:49'),
(468, 186, 'quang anh đã thêm sản phẩm: ESTP04772CA00SB_DCR-XL (giá = 500,000 VND)', '2024-08-04 13:39:51', '2024-08-04 13:39:51'),
(471, 187, 'quang anh đã thêm sản phẩm: EWBS00103TC00RB_BL-L (giá = 400,000 VND)', '2024-08-04 13:39:51', '2024-08-04 13:39:51'),
(474, 186, 'quang anh đã thêm sản phẩm: EABT01901PE00SB_DNV-33 (giá = 500,000 VND)', '2024-08-04 13:41:32', '2024-08-04 13:41:32'),
(477, 187, 'quang anh đã thêm sản phẩm: DABK90801CT00SB_LG-31 (giá = 500,000 VND)', '2024-08-04 13:41:32', '2024-08-04 13:41:32'),
(480, 188, 'quang anh đã thêm sản phẩm: ESBK00702CT00RB_BL-29 (giá = 400,000 VND)', '2024-08-04 13:41:32', '2024-08-04 13:41:32'),
(483, 189, 'quang anh đã thêm sản phẩm: EATB00671LI13RB_DNV-42 (giá = 480,000 VND)', '2024-08-04 13:41:32', '2024-08-04 13:41:32'),
(486, 190, 'quang anh đã thêm sản phẩm: DABJ90301CT16SB_NV-29 (giá = 550,000 VND)', '2024-08-04 13:41:32', '2024-08-04 13:41:32'),
(489, 191, 'quang anh đã thêm sản phẩm: EABT01901PE00SB_DNV-30 (giá = 500,000 VND)', '2024-08-04 13:41:32', '2024-08-04 13:41:32'),
(492, 192, 'quang anh đã thêm sản phẩm: DWBS01203CV00SB_DGR-M (giá = 299,000 VND)', '2024-08-04 13:41:32', '2024-08-04 13:41:32'),
(495, 193, 'quang anh đã thêm sản phẩm: DABJ90801CT19SB_DBU-30 (giá = 550,000 VND)', '2024-08-04 13:41:32', '2024-08-04 13:41:32'),
(498, 194, 'quang anh đã thêm sản phẩm: EATB00671LI13RB_DNV-38 (giá = 480,000 VND)', '2024-08-04 13:41:32', '2024-08-04 13:41:32'),
(501, 186, 'quang anh đã thêm sản phẩm: ESBW00402PE01MB_LG-M (giá = 350,000 VND)', '2024-08-04 13:42:18', '2024-08-04 13:42:18'),
(504, 187, 'quang anh đã thêm sản phẩm: ESTB02672LI00RB_LG-38 (giá = 450,000 VND)', '2024-08-04 13:42:18', '2024-08-04 13:42:18'),
(507, 188, 'quang anh đã thêm sản phẩm: DSBI01302LI00SB_NV-29 (giá = 380,000 VND)', '2024-08-04 13:42:18', '2024-08-04 13:42:18'),
(510, 189, 'quang anh đã thêm sản phẩm: EABT01901PE00SB_LBL-29 (giá = 500,000 VND)', '2024-08-04 13:42:18', '2024-08-04 13:42:18'),
(513, 190, 'quang anh đã thêm sản phẩm: DABJ01001CT00SB_BU-32 (giá = 550,000 VND)', '2024-08-04 13:42:18', '2024-08-04 13:42:18'),
(516, 191, 'quang anh đã thêm sản phẩm: DWCU00761PE32SB_ENV-M (giá = 750,000 VND)', '2024-08-04 13:42:18', '2024-08-04 13:42:18'),
(519, 192, 'quang anh đã thêm sản phẩm: EATB00671LI13RB_DNV-41 (giá = 480,000 VND)', '2024-08-04 13:42:18', '2024-08-04 13:42:18'),
(522, 193, 'quang anh đã thêm sản phẩm: ESBK00202CT00RB_BL-30 (giá = 380,000 VND)', '2024-08-04 13:42:18', '2024-08-04 13:42:18'),
(525, 194, 'quang anh đã thêm sản phẩm: ESBK00202CT00RB_NV-32 (giá = 380,000 VND)', '2024-08-04 13:42:18', '2024-08-04 13:42:18'),
(528, 195, 'quang anh đã thêm sản phẩm: ESBK00202CT00RB_NV-30 (giá = 380,000 VND)', '2024-08-04 13:42:18', '2024-08-04 13:42:18'),
(531, 196, 'quang anh đã thêm sản phẩm: DWCT00431PE32SB_BL-XL (giá = 750,000 VND)', '2024-08-04 13:42:18', '2024-08-04 13:42:18'),
(534, 197, 'quang anh đã thêm sản phẩm: DWCT00161PE00RB_DGR-M (giá = 990,000 VND)', '2024-08-04 13:42:18', '2024-08-04 13:42:18'),
(537, 198, 'quang anh đã thêm sản phẩm: DATB92071BA00SB_BL-40 (giá = 42,000 VND)', '2024-08-04 13:42:18', '2024-08-04 13:42:18'),
(540, 199, 'quang anh đã thêm sản phẩm: EATB00371CA11SB_GN-40 (giá = 520,000 VND)', '2024-08-04 13:42:18', '2024-08-04 13:42:18'),
(543, 200, 'quang anh đã thêm sản phẩm: DWCU00761PE32SB_ENV-XL (giá = 750,000 VND)', '2024-08-04 13:42:18', '2024-08-04 13:42:18'),
(546, 201, 'quang anh đã thêm sản phẩm: EWCW00751PE00SB_BL-L (giá = 50,000 VND)', '2024-08-04 13:42:18', '2024-08-04 13:42:18'),
(549, 186, 'quang anh đã thêm sản phẩm: DABK90601CT00SB_LG-32 (giá = 500,000 VND)', '2024-08-04 13:44:35', '2024-08-04 13:44:35'),
(552, 187, 'quang anh đã thêm sản phẩm: ESTS04012CA06MB_WH-M (giá = 300,000 VND)', '2024-08-04 13:44:35', '2024-08-04 13:44:35'),
(555, 188, 'quang anh đã thêm sản phẩm: EABT01901PE00SB_GR-31 (giá = 500,000 VND)', '2024-08-04 13:44:35', '2024-08-04 13:44:35'),
(558, 189, 'quang anh đã thêm sản phẩm: DABK90601CT00SB_NV-31 (giá = 500,000 VND)', '2024-08-04 13:44:35', '2024-08-04 13:44:35'),
(561, 186, 'quang anh đã thêm sản phẩm: EATB00671LI13RB_DNV-41 (giá = 480,000 VND)', '2024-08-04 13:46:03', '2024-08-04 13:46:03'),
(564, 187, 'quang anh đã thêm sản phẩm: EABT01901PE00SB_DNV-29 (giá = 500,000 VND)', '2024-08-04 13:46:03', '2024-08-04 13:46:03'),
(567, 188, 'quang anh đã thêm sản phẩm: DSBI01302LI00SB_LG-33 (giá = 380,000 VND)', '2024-08-04 13:46:03', '2024-08-04 13:46:03'),
(570, 189, 'quang anh đã thêm sản phẩm: ESBK00702CT00RB_NV-31 (giá = 400,000 VND)', '2024-08-04 13:46:03', '2024-08-04 13:46:03'),
(573, 190, 'quang anh đã thêm sản phẩm: DATB61471BA00SB_NV-42 (giá = 450,000 VND)', '2024-08-04 13:46:03', '2024-08-04 13:46:03'),
(576, 191, 'quang anh đã thêm sản phẩm: DATB92071BA00SB_LB-39 (giá = 42,000 VND)', '2024-08-04 13:46:03', '2024-08-04 13:46:03'),
(579, 192, 'quang anh đã thêm sản phẩm: DSTP00472CV32SB_BL-XL (giá = 450,000 VND)', '2024-08-04 13:46:03', '2024-08-04 13:46:03'),
(582, 193, 'quang anh đã thêm sản phẩm: EWTW00311TC00RB_BE-XL (giá = 380,000 VND)', '2024-08-04 13:46:03', '2024-08-04 13:46:03'),
(585, 194, 'quang anh đã thêm sản phẩm: EWTW00311TC00RB_LG-XXL (giá = 380,000 VND)', '2024-08-04 13:46:03', '2024-08-04 13:46:03'),
(588, 195, 'quang anh đã thêm sản phẩm: EWCW00751PE00SB_BL-L (giá = 50,000 VND)', '2024-08-04 13:46:03', '2024-08-04 13:46:03'),
(591, 196, 'quang anh đã thêm sản phẩm: DSBI01302LI00SB_LB-32 (giá = 380,000 VND)', '2024-08-04 13:46:03', '2024-08-04 13:46:03'),
(594, 186, 'quang anh đã thêm sản phẩm: ESBK00702CT00RB_BL-30 (giá = 400,000 VND)', '2024-08-04 13:50:54', '2024-08-04 13:50:54'),
(597, 187, 'quang anh đã thêm sản phẩm: ESTP04772CA00SB_DCR-S (giá = 500,000 VND)', '2024-08-04 13:50:54', '2024-08-04 13:50:54'),
(600, 188, 'quang anh đã thêm sản phẩm: ESTS03812CT06MB_DCB-L (giá = 300,000 VND)', '2024-08-04 13:50:54', '2024-08-04 13:50:54'),
(603, 189, 'quang anh đã thêm sản phẩm: ESBI00602CA00SB_CR-31 (giá = 380,000 VND)', '2024-08-04 13:50:54', '2024-08-04 13:50:54'),
(606, 190, 'quang anh đã thêm sản phẩm: DWBS01203CV00SB_NV-M (giá = 299,000 VND)', '2024-08-04 13:50:54', '2024-08-04 13:50:54'),
(609, 191, 'quang anh đã thêm sản phẩm: DWCT00161PE00RB_DGR-M (giá = 990,000 VND)', '2024-08-04 13:50:54', '2024-08-04 13:50:54'),
(612, 192, 'quang anh đã thêm sản phẩm: DATB61471BA00SB_WH-38 (giá = 450,000 VND)', '2024-08-04 13:50:54', '2024-08-04 13:50:54'),
(615, 193, 'quang anh đã thêm sản phẩm: DWCT00161PE00RB_DGR-M (giá = 990,000 VND)', '2024-08-04 13:50:54', '2024-08-04 13:50:54'),
(618, 194, 'quang anh đã thêm sản phẩm: ESBK00702CT00RB_BL-30 (giá = 400,000 VND)', '2024-08-04 13:50:54', '2024-08-04 13:50:54'),
(621, 195, 'quang anh đã thêm sản phẩm: EATB00671LI13RB_LB-39 (giá = 480,000 VND)', '2024-08-04 13:50:54', '2024-08-04 13:50:54'),
(624, 196, 'quang anh đã thêm sản phẩm: DSBI01302LI00SB_LG-29 (giá = 380,000 VND)', '2024-08-04 13:50:54', '2024-08-04 13:50:54'),
(627, 197, 'quang anh đã thêm sản phẩm: EABT01901PE00SB_GR-29 (giá = 500,000 VND)', '2024-08-04 13:50:54', '2024-08-04 13:50:54'),
(630, 198, 'quang anh đã thêm sản phẩm: EABT01901PE00SB_BL-31 (giá = 500,000 VND)', '2024-08-04 13:50:54', '2024-08-04 13:50:54'),
(633, 199, 'quang anh đã thêm sản phẩm: ESBW00502PE00RB_BL-S (giá = 320,000 VND)', '2024-08-04 13:50:54', '2024-08-04 13:50:54'),
(636, 200, 'quang anh đã thêm sản phẩm: DABK90601CT00SB_LG-33 (giá = 500,000 VND)', '2024-08-04 13:50:54', '2024-08-04 13:50:54'),
(639, 201, 'quang anh đã thêm sản phẩm: ESTB02672LI00RB_LCR-42 (giá = 450,000 VND)', '2024-08-04 13:50:54', '2024-08-04 13:50:54'),
(642, 202, 'quang anh đã thêm sản phẩm: EWBS00103TC00RB_LG-L (giá = 400,000 VND)', '2024-08-04 13:50:54', '2024-08-04 13:50:54'),
(645, 203, 'quang anh đã thêm sản phẩm: EWBS00103TC00RB_BL-S (giá = 400,000 VND)', '2024-08-04 13:50:54', '2024-08-04 13:50:54'),
(648, 204, 'quang anh đã thêm sản phẩm: DABJ90801CT19SB_DBU-29 (giá = 550,000 VND)', '2024-08-04 13:50:54', '2024-08-04 13:50:54'),
(651, 205, 'quang anh đã thêm sản phẩm: EWTW00311TC00RB_BE-M (giá = 380,000 VND)', '2024-08-04 13:50:54', '2024-08-04 13:50:54'),
(654, 206, 'quang anh đã thêm sản phẩm: ESBK00702CT00RB_NV-32 (giá = 400,000 VND)', '2024-08-04 13:50:54', '2024-08-04 13:50:54'),
(657, 207, 'quang anh đã thêm sản phẩm: EATB00671LI13RB_LG-42 (giá = 480,000 VND)', '2024-08-04 13:50:54', '2024-08-04 13:50:54'),
(660, 208, 'quang anh đã thêm sản phẩm: DWCT00161PE00RB_NV-S (giá = 990,000 VND)', '2024-08-04 13:50:54', '2024-08-04 13:50:54'),
(663, 209, 'quang anh đã thêm sản phẩm: EWCL00361PE00RB_CR-L (giá = 890,000 VND)', '2024-08-04 13:50:54', '2024-08-04 13:50:54'),
(666, 210, 'quang anh đã thêm sản phẩm: EATB00671LI13RB_DNV-40 (giá = 480,000 VND)', '2024-08-04 13:50:54', '2024-08-04 13:50:54'),
(669, 211, 'quang anh đã thêm sản phẩm: EATB00671LI13RB_WH-40 (giá = 480,000 VND)', '2024-08-04 13:50:54', '2024-08-04 13:50:54'),
(672, 212, 'quang anh đã thêm sản phẩm: ESTA00612CT06MB_BL-L (giá = 250,000 VND)', '2024-08-04 13:50:54', '2024-08-04 13:50:54'),
(675, 213, 'quang anh đã thêm sản phẩm: DABK90601CT00SB_CN-32 (giá = 500,000 VND)', '2024-08-04 13:50:54', '2024-08-04 13:50:54'),
(678, 214, 'quang anh đã thêm sản phẩm: DWCU00761PE32SB_ENV-M (giá = 750,000 VND)', '2024-08-04 13:50:54', '2024-08-04 13:50:54'),
(681, 215, 'quang anh đã thêm sản phẩm: ESTB02672LI00RB_DNV-39 (giá = 450,000 VND)', '2024-08-04 13:50:54', '2024-08-04 13:50:54'),
(684, 216, 'quang anh đã thêm sản phẩm: ESBK00702CT00RB_BL-31 (giá = 400,000 VND)', '2024-08-04 13:50:54', '2024-08-04 13:50:54'),
(687, 217, 'quang anh đã thêm sản phẩm: ESTB02672LI00RB_LCR-39 (giá = 450,000 VND)', '2024-08-04 13:50:55', '2024-08-04 13:50:55'),
(690, 218, 'quang anh đã thêm sản phẩm: DABJ00401CT00SB_NV-30 (giá = 550,000 VND)', '2024-08-04 13:50:55', '2024-08-04 13:50:55'),
(693, 219, 'quang anh đã thêm sản phẩm: EABT01901PE00SB_GR-30 (giá = 500,000 VND)', '2024-08-04 13:50:55', '2024-08-04 13:50:55'),
(696, 220, 'quang anh đã thêm sản phẩm: ESTB02672LI00RB_LCR-38 (giá = 450,000 VND)', '2024-08-04 13:50:55', '2024-08-04 13:50:55'),
(699, 221, 'quang anh đã thêm sản phẩm: ESBK00702CT00RB_BL-32 (giá = 400,000 VND)', '2024-08-04 13:50:55', '2024-08-04 13:50:55'),
(702, 222, 'quang anh đã thêm sản phẩm: ESTS04012CA06MB_BL-S (giá = 300,000 VND)', '2024-08-04 13:50:55', '2024-08-04 13:50:55'),
(705, 223, 'quang anh đã thêm sản phẩm: DATB61471BA00SB_WH-40 (giá = 450,000 VND)', '2024-08-04 13:50:55', '2024-08-04 13:50:55'),
(708, 224, 'quang anh đã thêm sản phẩm: EATB00371CA11SB_LB-40 (giá = 520,000 VND)', '2024-08-04 13:50:55', '2024-08-04 13:50:55'),
(711, 225, 'quang anh đã thêm sản phẩm: ESTA00312CT06MB_NV-S (giá = 300,000 VND)', '2024-08-04 13:50:55', '2024-08-04 13:50:55'),
(714, 226, 'quang anh đã thêm sản phẩm: EATB00371CA11SB_BL-41 (giá = 520,000 VND)', '2024-08-04 13:50:55', '2024-08-04 13:50:55'),
(717, 227, 'quang anh đã thêm sản phẩm: DWCU00761PE32SB_LLG-S (giá = 750,000 VND)', '2024-08-04 13:50:55', '2024-08-04 13:50:55'),
(720, 228, 'quang anh đã thêm sản phẩm: ESTB02672LI00RB_WH-41 (giá = 450,000 VND)', '2024-08-04 13:50:55', '2024-08-04 13:50:55'),
(723, 229, 'quang anh đã thêm sản phẩm: ESBK00702CT00RB_NV-33 (giá = 400,000 VND)', '2024-08-04 13:50:55', '2024-08-04 13:50:55'),
(726, 230, 'quang anh đã thêm sản phẩm: EATB00671LI13RB_WH-39 (giá = 480,000 VND)', '2024-08-04 13:50:55', '2024-08-04 13:50:55'),
(729, 231, 'quang anh đã thêm sản phẩm: EWBS00103TC00RB_LG-S (giá = 400,000 VND)', '2024-08-04 13:50:55', '2024-08-04 13:50:55'),
(732, 232, 'quang anh đã thêm sản phẩm: EWBS00103TC00RB_LG-S (giá = 400,000 VND)', '2024-08-04 13:50:55', '2024-08-04 13:50:55'),
(735, 233, 'quang anh đã thêm sản phẩm: EATB00671LI13RB_DNV-38 (giá = 480,000 VND)', '2024-08-04 13:50:55', '2024-08-04 13:50:55'),
(738, 234, 'quang anh đã thêm sản phẩm: DABJ90801CT19SB_DBU-32 (giá = 550,000 VND)', '2024-08-04 13:50:55', '2024-08-04 13:50:55'),
(741, 235, 'quang anh đã thêm sản phẩm: ESBK00202CT00RB_BL-30 (giá = 380,000 VND)', '2024-08-04 13:50:55', '2024-08-04 13:50:55'),
(742, 194, 'quang anh đã thay đổi trạng thái thanh toán: Đã thanh toán -> Chưa thanh toán<br>', '2024-08-04 13:54:30', '2024-08-04 13:54:30'),
(745, 194, 'quang anh đã thêm sản phẩm: DABJ01001CT00SB_BU-29 (giá = 550,000 VND)', '2024-08-04 13:54:35', '2024-08-04 13:54:35'),
(748, 193, 'quang anh đã thêm sản phẩm: DSBI01302LI00SB_BE-32 (giá = 380,000 VND)', '2024-08-04 14:14:06', '2024-08-04 14:14:06'),
(751, 192, 'quang anh đã thêm sản phẩm: DABJ00401CT00SB_NV-30 (giá = 550,000 VND)', '2024-08-04 14:14:58', '2024-08-04 14:14:58'),
(902, 209, NULL, '2024-08-07 09:35:12', '2024-08-07 09:35:12'),
(903, 95, NULL, '2024-08-07 09:36:06', '2024-08-07 09:36:06'),
(904, 95, NULL, '2024-08-07 09:36:06', '2024-08-07 09:36:06'),
(905, 95, 'quang anh đã thêm sản phẩm: EWCL00361PE00RB_CR-XL (giá = 890,000 VND)', '2024-08-07 09:36:06', '2024-08-07 09:36:06'),
(906, 95, NULL, '2024-08-07 09:36:22', '2024-08-07 09:36:22'),
(907, 95, NULL, '2024-08-07 09:36:22', '2024-08-07 09:36:22'),
(908, 95, NULL, '2024-08-07 09:36:27', '2024-08-07 09:36:27'),
(909, 95, NULL, '2024-08-07 09:36:30', '2024-08-07 09:36:30'),
(910, 207, 'quang anh đã thay đổi trạng thái thanh toán: Đã thanh toán -> Chưa thanh toán<br>', '2024-08-07 09:44:08', '2024-08-07 09:44:08'),
(911, 207, NULL, '2024-08-07 09:44:13', '2024-08-07 09:44:13'),
(912, 207, NULL, '2024-08-07 09:44:13', '2024-08-07 09:44:13'),
(913, 207, 'quang anh đã thêm sản phẩm: EATB00671LI13RB_DNV-42 (giá = 480,000 VND)', '2024-08-07 09:44:13', '2024-08-07 09:44:13'),
(914, 207, NULL, '2024-08-07 09:44:33', '2024-08-07 09:44:33'),
(915, 207, NULL, '2024-08-07 09:44:37', '2024-08-07 09:44:37'),
(916, 207, NULL, '2024-08-07 09:44:39', '2024-08-07 09:44:39'),
(917, 57, NULL, '2024-08-07 10:00:04', '2024-08-07 10:00:04'),
(918, 57, NULL, '2024-08-07 10:00:04', '2024-08-07 10:00:04'),
(919, 57, 'quang anh đã thêm sản phẩm: DWCT00431PE32SB_WH-XL (giá = 750,000 VND)', '2024-08-07 10:00:04', '2024-08-07 10:00:04'),
(920, 57, NULL, '2024-08-07 10:00:08', '2024-08-07 10:00:08'),
(921, 57, NULL, '2024-08-07 10:00:12', '2024-08-07 10:00:12'),
(922, 57, NULL, '2024-08-07 10:00:14', '2024-08-07 10:00:14'),
(923, 25, NULL, '2024-08-07 10:02:42', '2024-08-07 10:02:42'),
(924, 25, NULL, '2024-08-07 10:02:42', '2024-08-07 10:02:42'),
(925, 25, 'quang anh đã thêm sản phẩm: DWCT00431PE32SB_WH-XL (giá = 750,000 VND)', '2024-08-07 10:02:42', '2024-08-07 10:02:42'),
(926, 25, NULL, '2024-08-07 10:02:45', '2024-08-07 10:02:45'),
(927, 25, NULL, '2024-08-07 10:02:48', '2024-08-07 10:02:48'),
(928, 25, NULL, '2024-08-07 10:02:50', '2024-08-07 10:02:50'),
(929, 213, NULL, '2024-08-07 10:20:16', '2024-08-07 10:20:16'),
(930, 213, NULL, '2024-08-07 10:20:16', '2024-08-07 10:20:16'),
(931, 213, 'quang anh đã thêm sản phẩm: DWCT00431PE32SB_WH-XL (giá = 750,000 VND)', '2024-08-07 10:20:16', '2024-08-07 10:20:16'),
(932, 213, 'quang anh đã xóa sản phẩm: DWCT00431PE32SB_WH-XL (giá = 750,000),số lượng: 1', '2024-08-07 10:20:20', '2024-08-07 10:20:20'),
(933, 213, NULL, '2024-08-07 10:20:20', '2024-08-07 10:20:20'),
(934, 213, NULL, '2024-08-07 10:20:20', '2024-08-07 10:20:20'),
(935, 213, NULL, '2024-08-07 10:39:53', '2024-08-07 10:39:53'),
(936, 213, NULL, '2024-08-07 10:39:53', '2024-08-07 10:39:53'),
(937, 213, 'quang anh đã thêm sản phẩm: DWCT00431PE32SB_WH-XL (giá = 750,000 VND)', '2024-08-07 10:39:53', '2024-08-07 10:39:53'),
(938, 213, 'quang anh đã xóa sản phẩm: DWCT00431PE32SB_WH-XL (giá = 750,000),số lượng: 1', '2024-08-07 10:39:58', '2024-08-07 10:39:58'),
(939, 213, NULL, '2024-08-07 10:39:58', '2024-08-07 10:39:58'),
(940, 213, NULL, '2024-08-07 10:39:58', '2024-08-07 10:39:58'),
(941, 213, NULL, '2024-08-07 10:40:51', '2024-08-07 10:40:51'),
(942, 213, NULL, '2024-08-07 10:40:51', '2024-08-07 10:40:51'),
(943, 213, 'quang anh đã thêm sản phẩm: DWCT00431PE32SB_WH-L (giá = 750,000 VND)', '2024-08-07 10:40:51', '2024-08-07 10:40:51'),
(944, 186, NULL, '2024-08-07 13:00:17', '2024-08-07 13:00:17'),
(945, 186, NULL, '2024-08-07 13:01:06', '2024-08-07 13:01:06'),
(946, 186, NULL, '2024-08-07 13:02:53', '2024-08-07 13:02:53'),
(947, 186, NULL, '2024-08-07 13:03:17', '2024-08-07 13:03:17'),
(948, 186, 'quang anh đã thay đổi trạng thái thanh toán: Đã thanh toán -> Chưa thanh toán<br>', '2024-08-07 13:03:39', '2024-08-07 13:03:39'),
(949, 186, ' đã thay đổi Số lượng (ESBK00702CT00RB_BL-30) :1 -> 2', '2024-08-07 13:03:44', '2024-08-07 13:03:44'),
(950, 186, NULL, '2024-08-07 13:03:44', '2024-08-07 13:03:44'),
(951, 186, NULL, '2024-08-07 13:03:44', '2024-08-07 13:03:44'),
(952, 186, NULL, '2024-08-07 13:03:49', '2024-08-07 13:03:49'),
(953, 186, NULL, '2024-08-07 13:04:08', '2024-08-07 13:04:08'),
(954, 186, NULL, '2024-08-07 13:04:10', '2024-08-07 13:04:10'),
(955, 90, NULL, '2024-08-07 13:14:21', '2024-08-07 13:14:21'),
(956, 90, 'quang anh đã thay đổi Tên khách hàng: string -> stringa<br>', '2024-08-07 13:14:30', '2024-08-07 13:14:30'),
(957, 90, NULL, '2024-08-07 13:14:32', '2024-08-07 13:14:32'),
(958, 90, 'quang anh đã thay đổi Tên khách hàng: stringa -> stringr<br>quang anh đã thay đổi Trạng thái đơn hàng: NEW -> PROCESS<br>', '2024-08-07 13:14:39', '2024-08-07 13:14:39'),
(959, 236, 'quang anh đã tạo đơn hàng: <br>Mã đơn: EO0LZ3UG,<br>Tên khách hàng: quang anh,<br>Số điện thoại: 0364100196,<br>Địa chỉ: dsva,<br>Trạng thái thanh toán: Chưa thanh toán', '2024-08-08 13:58:08', '2024-08-08 13:58:08'),
(960, 236, 'quang anh đã thêm sản phẩm: DWCT00431PE32SB_BL-XL (giá = 750,000 VND)', '2024-08-08 13:58:08', '2024-08-08 13:58:08'),
(961, 236, 'quang anh đã thay đổi Trạng thái đơn hàng: NEW -> ORDER_CREATED<br>', '2024-08-08 14:21:14', '2024-08-08 14:21:14'),
(962, 236, 'quang anh đã thay đổi Trạng thái đơn hàng: ORDER_CREATED -> DELIVERING<br>', '2024-08-08 15:13:46', '2024-08-08 15:13:46'),
(963, 236, 'quang anh đã thay đổi Trạng thái đơn hàng: DELIVERING -> SUCCESS<br>', '2024-08-08 15:13:50', '2024-08-08 15:13:50'),
(964, 236, 'quang anh đã thay đổi Trạng thái đơn hàng: NEW -> ORDER_CREATED<br>', '2024-08-08 15:16:06', '2024-08-08 15:16:06'),
(965, 213, 'quang anh đã thêm sản phẩm: DWCT00431PE32SB_BL-XL (giá = 750,000 VND)', '2024-08-08 15:24:11', '2024-08-08 15:24:11'),
(966, 213, 'quang anh đã thay đổi Trạng thái đơn hàng: CANCEL -> ORDER_CREATED<br>', '2024-08-08 15:24:14', '2024-08-08 15:24:14'),
(967, 236, 'quang anh đã thay đổi Trạng thái đơn hàng: ORDER_CREATED -> PROCESS<br>', '2024-08-08 15:33:20', '2024-08-08 15:33:20'),
(968, 236, 'quang anh đã thay đổi Trạng thái đơn hàng: PROCESS -> ORDER_CREATED<br>', '2024-08-08 15:38:12', '2024-08-08 15:38:12');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `jwt_tokens`
--

CREATE TABLE `jwt_tokens` (
  `id` int(11) NOT NULL,
  `token` varchar(255) NOT NULL,
  `expiration_date` datetime NOT NULL,
  `refresh_token` varchar(255) NOT NULL,
  `account_id` int(11) NOT NULL,
  `refresh_expiration_date` datetime NOT NULL,
  `revoked` tinyint(1) NOT NULL DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `jwt_tokens`
--

INSERT INTO `jwt_tokens` (`id`, `token`, `expiration_date`, `refresh_token`, `account_id`, `refresh_expiration_date`, `revoked`, `created_at`, `updated_at`) VALUES
(527, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJuZ3V5ZW5xdWFuZ2FuaCIsInBob25lIjoiMDM2NTE1MTgyMiIsInJvbGUiOiJST0xFX0VNUExPWUVFIiwiaWF0IjoxNzIyOTM2NTgxLCJleHAiOjE3MjI5MzcxODF9.JHDr7u1wF5VRb5m8MdSzW-HqnXyZSltKDUjJ-uH-XW4', '2024-08-06 16:39:41', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJuZ3V5ZW5xdWFuZ2FuaCIsInBob25lIjoiMDM2NTE1MTgyMiIsInJvbGUiOiJST0xFX0VNUExPWUVFIiwiaWF0IjoxNzIyOTM2NTgxLCJleHAiOjE3MjM1NDEzODF9.bHeup8lKMk-jxg7fPuGfFWCvX_DGpOTYV3_vk-CmSlw', 2, '2024-08-13 16:29:41', 0, '2024-08-06 09:29:41', '2024-08-06 09:29:41'),
(531, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJuZ3V5ZW5xdWFuZ2FuaCIsInBob25lIjoiMDM2NTE1MTgyMiIsInJvbGUiOiJST0xFX0VNUExPWUVFIiwiaWF0IjoxNzIyOTQ3NDUxLCJleHAiOjE3MjI5NDgwNTF9.nFEdpbXTF0tUkGwyB8DcIDtotql2UBxIxvWTifMPH9s', '2024-08-06 19:40:51', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJuZ3V5ZW5xdWFuZ2FuaCIsInBob25lIjoiMDM2NTE1MTgyMiIsInJvbGUiOiJST0xFX0VNUExPWUVFIiwiaWF0IjoxNzIyOTQ3NDUxLCJleHAiOjE3MjM1NTIyNTF9.vMzV_eI2Nf0Gezi8VaHIOCJtvRbAcJfamr3z3O6nF3U', 2, '2024-08-13 19:30:51', 0, '2024-08-06 12:30:51', '2024-08-06 12:30:51'),
(552, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJuZ3V5ZW5xdWFuZ2FuaCIsInBob25lIjoiMDM2NDEwMDE5NiIsInJvbGUiOiJST0xFX01BTkFHRVIiLCJpYXQiOjE3MjMxMzYyMTEsImV4cCI6MTcyMzEzNjgxMX0.5r13EOiL_gXS7phdtrp2hHEU0FZubdso9e_xYbK_zag', '2024-08-09 00:06:51', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJuZ3V5ZW5xdWFuZ2FuaCIsInBob25lIjoiMDM2NDEwMDE5NiIsInJvbGUiOiJST0xFX01BTkFHRVIiLCJpYXQiOjE3MjMxMzYyMTEsImV4cCI6MTcyMzc0MTAxMX0.jdC_meBKeAP6iW_LjagiDxXe6AVYRJas8F685Usr0Is', 1, '2024-09-07 23:56:51', 0, '2024-08-08 16:07:08', '2024-08-08 16:56:51'),
(553, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJuZ3V5ZW5xdWFuZ2FuaCIsInBob25lIjoiMDM2NDEwMDE5NiIsInJvbGUiOiJST0xFX01BTkFHRVIiLCJpYXQiOjE3MjMxMzY4NjEsImV4cCI6MTcyMzEzNzQ2MX0.Mff4rFqSEKnLYFUAJRyEBP5PYT1648fRAEV6GK9kHJU', '2024-08-09 00:17:41', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJuZ3V5ZW5xdWFuZ2FuaCIsInBob25lIjoiMDM2NDEwMDE5NiIsInJvbGUiOiJST0xFX01BTkFHRVIiLCJpYXQiOjE3MjMxMzY4NjEsImV4cCI6MTcyMzc0MTY2MX0.LWpOkgPf2UJIhFzZzTQc01ej3W6oCLkiHn1Bb27Ws3I', 1, '2024-08-16 00:07:41', 0, '2024-08-08 17:07:41', '2024-08-08 17:07:41');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `products`
--

CREATE TABLE `products` (
  `id` int(11) NOT NULL,
  `product_code` varchar(15) NOT NULL,
  `product_name` varchar(100) DEFAULT NULL,
  `cat_id` int(11) NOT NULL,
  `price` int(11) DEFAULT NULL,
  `discount_price` int(11) DEFAULT NULL,
  `discount_percent` int(11) DEFAULT NULL,
  `brand` varchar(20) DEFAULT 'TORANO',
  `description` text DEFAULT NULL,
  `total_size` int(11) DEFAULT 0,
  `total_color` int(11) DEFAULT 0,
  `image_background` varchar(255) DEFAULT 'no_image.jpg',
  `image_choose_size` varchar(255) DEFAULT 'no_image.jpg',
  `is_activated` bit(1) DEFAULT b'1',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `products`
--

INSERT INTO `products` (`id`, `product_code`, `product_name`, `cat_id`, `price`, `discount_price`, `discount_percent`, `brand`, `description`, `total_size`, `total_color`, `image_background`, `image_choose_size`, `is_activated`, `created_at`, `updated_at`) VALUES
(1, 'BI013', 'Quần short đũi BI013', 114, 380000, NULL, NULL, 'TORANO', '', 6, 7, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810365/1702814188840_tp038---bi013-_20__790f72cbd3d34a918920b73579e72ea5_master.jpg.webp', 'IMAGE_4', b'1', '2024-05-14 10:47:36', '2024-08-06 12:45:59'),
(2, 'CABJ003', 'Quần Jeans rách Slim CABJ003', 109, 550000, NULL, NULL, 'TORANO', 'Quần Jeans rách Slim CABJ003\r\n', 5, 1, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810773/1702810774291_cabj003_75aa0eb2e3ef4d7cb175dcef6ceae9cf_master.jpg.webp', 'IMAGE_4', b'1', '2024-05-14 10:47:36', '2024-05-14 10:47:36'),
(3, 'DABJ004', 'Quần Jeans basic Slim DABJ004', 108, 550000, NULL, NULL, 'TORANO', 'Quần Jeans basic Slim CABJ004/2\r\n', 5, 1, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810701/1702810004163_52706071935_8966d1e12f_o_a66489be76c949d791609a08ca73993f_master.jpg.webp', 'IMAGE_4', b'1', '2024-05-14 10:47:36', '2024-05-14 10:47:36'),
(4, 'DABJ010', 'Quần Jeans basic Slim DABJ010', 108, 550000, NULL, NULL, 'TORANO', 'Quần Jeans basic Slim CABJ010/2', 5, 1, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810727/1702810256808_52169110354_87bd6ccaa0_o_abf9f4cabd204376b1d1cba50d2deec9_master.jpg.webp', 'IMAGE_4', b'1', '2024-05-14 10:47:36', '2024-05-14 10:47:36'),
(5, 'DABJ903', 'Quần Jeans basic Slim DABJ903', 108, 550000, NULL, NULL, 'TORANO', 'Quần Jeans basic Slim DABJ903\r\n', 5, 1, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810748/1702810455348_dabj903_bf925f25f2c244aeb43a9c4430f64ef8_master.jpg.webp', 'IMAGE_4', b'1', '2024-05-14 10:47:36', '2024-06-10 08:54:54'),
(6, 'DABJ904', 'Quần Jeans rách Slim DABJ904', 109, 550000, NULL, NULL, 'TORANO', 'Quần Jeans rách Slim DABJ904\r\n', 5, 1, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810794/1702810960863_20230209_2nqi04eclesynryo_614790fe9b5a479095c6726ef90f2df7_master.jpg.jpg', 'IMAGE_4', b'1', '2024-05-14 10:47:36', '2024-05-14 10:47:36'),
(7, 'DABJ908', 'Quần Jeans rách Slim 1.DABJ908', 109, 550000, NULL, NULL, 'TORANO', '', 5, 1, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810768/1702810648513_bj908-2_53198051989_o_d8c0aeb3be18470c95b4e19e4481b38d_master.jpg.webp', 'IMAGE_4', b'1', '2024-05-14 10:47:36', '2024-05-14 10:47:36'),
(8, 'DABK906', 'Quần kaki dài basic cạp tender túi lé DABK906', 110, 500000, NULL, NULL, 'TORANO', '', 5, 4, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810591/1702808414194_dabk906-1_6be1255f7e6b427094e410388cb5f6a1_master.jpg.webp', 'IMAGE_4', b'1', '2024-05-14 10:47:36', '2024-05-14 10:47:36'),
(9, 'DABK908', 'Quần kaki dài basic DABK908', 110, 500000, NULL, NULL, 'TORANO', '', 5, 4, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810628/1702808850360_tp038---bk908-_20__de063447c1d34cf0a62c34b18ed2ffe6_master.jpg.webp', 'IMAGE_4', b'1', '2024-05-14 10:47:36', '2024-05-14 10:47:36'),
(10, 'DATB416', 'Sơ mi dài tay kẻ Checkerboard 2.DATB416', 122, 480000, NULL, NULL, 'TORANO', '', 5, 1, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810249/1703435106886_52695741049_ab53170a62_o_d4d8d423351a4330b41d0fc19ade0513_master.jpg.webp', 'IMAGE_2', b'1', '2024-05-14 10:47:36', '2024-08-06 12:13:37'),
(11, 'DATB614', 'Áo sơ mi dài tay trơn Bamboo 4.DATB614', 123, 450000, NULL, NULL, 'TORANO', '', 5, 4, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810494/1702806015812_52660558534_e1239eeb1b_o_786802e53d3843e19392b3f4e5199c71_master.jpg.webp', 'IMAGE_2', b'1', '2024-05-14 10:47:36', '2024-05-14 10:47:36'),
(12, 'DATB920', 'Áo sơ mi dài tay trơn Bamboo 4.DATB920', 123, 42000, NULL, NULL, 'TORANO', '', 5, 4, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810527/1702806426640_untitled_design__5__5744f2809b2c4d3499ef8f70899e3c18_master.jpg.webp', 'IMAGE_2', b'1', '2024-05-14 10:47:36', '2024-05-14 10:47:36'),
(13, 'DSTP611', 'Áo polo trơn bo kẻ DSTP611', 98, 333333, NULL, NULL, 'Torano', '', 4, 1, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811554/tp611_59ea616328234a9b969ce2d1c48c482f_master.jpg.webp', 'IMAGE_1', b'1', '2024-05-14 10:47:36', '2024-05-14 10:47:36'),
(14, 'DSTP650', 'Áo Polo monogram TRN DSTP650', 100, 450000, NULL, NULL, 'TORANO', 'Áo Polo monogram TRN 1.DSTP650', 4, 1, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811057/4_485c2d0480d84e4b983817d401d0c65d_master.jpg.jpg', 'IMAGE_1', b'1', '2024-05-14 10:47:36', '2024-05-14 10:47:36'),
(15, 'DSTP903', 'Áo polo can phối Horizontal Color Scheme DSTP903', 99, 420000, 290000, 31, 'TORANO', '', 4, 2, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811223/dstp903_52866905251_o_735380510ed1481090a9d817d712432b_master.jpg.webp', 'IMAGE_1', b'1', '2024-05-14 10:47:36', '2024-05-14 10:47:36'),
(16, 'DWBS012', 'Quần nỉ trơn Basic 4.DWBS012', 111, 380000, 299000, 21, 'TORANO', '', 4, 3, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810234/1703928526228_bs012-1_52615553322_o_0d15a75065ed4bf59b9e03ecded5d334_master.jpg.webp', 'IMAGE_4', b'1', '2024-05-14 10:47:36', '2024-05-14 10:47:36'),
(17, 'DWCT001', 'Áo khoác 2 lớp dạ cổ bomber 3.DWCT001', 87, 990000, NULL, NULL, 'TORANO', '', 4, 2, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810200/1704190979928_ct001_51762266972_o_9bee17ad6de44acca391c7ad9847bf08_master.jpg.webp', 'IMAGE_5', b'1', '2024-05-14 10:47:36', '2024-05-14 10:47:36'),
(18, 'DWCT004', 'Áo khoác 2 lớp dạ cổ cao 2.DWCT004', 88, 750000, NULL, NULL, 'TORANO', '', 4, 2, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810186/1704191300176_ct004-2_52410023919_o_fe0e3f9c03f642cf9309596415dc2278_master.jpg.webp', 'IMAGE_5', b'1', '2024-05-14 10:47:36', '2024-05-14 10:47:36'),
(19, 'DWCU007', 'Áo khoác 2 lớp lót lông cổ bomber 2.DWCU007', 87, 750000, NULL, NULL, 'TORANO', '', 4, 2, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810174/1704191606465_20220929_eflqusorg4g4ku3umeps5z9r_389f739d70b645d8a1d6a49d9b745c7b_compact.jpg.webp', 'IMAGE_5', b'1', '2024-05-14 10:47:36', '2024-05-14 10:47:36'),
(20, 'EABT019', 'Quần âu slim-fit cạp trơn EABT019', 105, 500000, NULL, NULL, 'TORANO', '', 5, 4, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810674/1702809800334_tb041---bt019-_14__13addb6f4b634d3bb1df83649ff1fdde_master.jpg.webp', 'IMAGE_3', b'1', '2024-05-14 10:47:36', '2024-05-14 10:47:36'),
(21, 'EABT021', 'Quần âu slim-fit điều chỉnh cạp trơn 1.EABT021', 105, 480000, NULL, NULL, 'TORANO', '', 5, 1, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810647/1702809333060_eabt021-4_52951993446_o_0d23aa6812b3462cb69bdc6b19240434_master.jpg.webp', 'IMAGE_3', b'1', '2024-05-14 10:47:36', '2024-05-14 10:47:36'),
(22, 'EATB003', 'Sơ mi dài tay kẻ Checkerboard 3.EATB003', 122, 520000, NULL, NULL, 'TORANO', '', 5, 3, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810577/1702807767115_eatb003-1_4b6bae1705b84deabfa237c94373b36e_master.jpg.webp', 'IMAGE_2', b'1', '2024-05-14 10:47:36', '2024-05-14 10:47:36'),
(23, 'EATB006', 'Sơ mi dài tay đũi 5.EATB006', 119, 480000, NULL, NULL, 'TORANO', 'Sơ mi dài tay nam vải đũi cao cấp thấm hút mồ hôi và thoáng mát\r\n', 5, 4, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810553/1702806927321_eatb006-1_802efda9723841d59eb56fabb46d7b22_master.jpg.webp', 'IMAGE_2', b'1', '2024-05-14 10:47:36', '2024-05-14 10:47:36'),
(24, 'ESBI006', 'Quần short đũi basic phối dây dệt gấu quần ESBI006', 114, 380000, NULL, NULL, 'TORANO', 'Quần short đũi nam basic phối dây dệt gấu quần. Chất đũi cao cấp mềm mịn, không bai xù và hạn chế nhăn nhàu. Vải thoáng mát thấm hút mồ hôi tốt và nhanh khô.\r\n', 5, 5, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810389/1702815216177_esbi006-1_405724795b8f4f22867f345eaab26319_master.jpg.webp', 'IMAGE_4', b'1', '2024-05-14 10:47:36', '2024-05-14 10:47:36'),
(25, 'ESBK002', 'Quần short kaki basic, gấp LV bọc viền dây dệt sườn ESBK002', 117, 380000, NULL, NULL, 'TORANO', '', 5, 4, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810325/1702813549148_52933853176_7967f42e52_o_208bdabebdb14986a84a5ed6be961474_master.jpg.webp', 'IMAGE_4', b'1', '2024-05-14 10:47:36', '2024-05-14 10:47:36'),
(26, 'ESBK007', 'Quần short kaki phối chun cạp 3.ESBK007', 117, 400000, NULL, NULL, 'TORANO', '', 5, 3, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810284/1702812911838_b_d29e6bdf78d04be1aa1575b44e69b2fb_master.jpg.webp', 'IMAGE_4', b'1', '2024-05-14 10:47:36', '2024-05-14 10:47:36'),
(27, 'ESBW004', 'Quần short gió cạp thường vải hiệu ứng 3.ESBW004', 116, 350000, NULL, NULL, 'TORANO', '', 4, 3, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810853/1702812478091_esbw004-12_52899473574_o_36fe3a92153a417b89b69bf2ce2d1490_master.jpg.webp', 'IMAGE_4', b'1', '2024-05-14 10:47:36', '2024-05-14 10:47:36'),
(28, 'ESBW005', 'Short gió cạp phối chun, in logo mép quần 2.ESBW005', 116, 320000, NULL, NULL, 'TORANO', '', 4, 2, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810827/1702812110775_4268bd5eeb3e637ed3b_master.jpg.webp', 'IMAGE_4', b'1', '2024-05-14 10:47:36', '2024-05-14 10:47:36'),
(29, 'ESTA003', 'Áo tanktop in họa tiết Tents 2. ESTA003', 126, 300000, NULL, NULL, 'TORANO', '', 4, 2, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810974/1702701667271_eata003-1_c8e90efa55944401946efba4f0ae02bf_master.jpg.webp', 'IMAGE_1', b'1', '2024-05-14 10:47:36', '2024-05-14 10:47:36'),
(30, 'ESTA005', 'Áo Tanktop họa tiết in Wild Sool 1.ESTA005', 126, 250000, NULL, NULL, 'TORANO', '', 4, 1, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810961/1702702646831_eata005-2_ef46f711d4734ba6a8be08d07f8f3567_master.jpg.webp', 'IMAGE_1', b'1', '2024-05-14 10:47:36', '2024-05-14 10:47:36'),
(31, 'ESTA006', 'Áo tanktop họa tiết in Shoes ESTA006', 126, 250000, NULL, NULL, 'TORANO', '', 4, 1, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810985/1702700896477_esta006-1_2a8dce82b88d4fd798c0434cf9bed833_master.jpg.webp', 'IMAGE_1', b'1', '2024-05-14 10:47:36', '2024-05-14 10:47:36'),
(32, 'ESTA010', 'Áo Tanktop họa tiết Defeat ESTA010', 126, 250000, NULL, NULL, 'TORANO', 'Áo tanktop nam cá tính, năng động mặc cực thoải mái. Mẫu áo ba lỗ nam trẻ trung với 2 màu dễ mặc.\r\n', 4, 1, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810015/1702537484269_esta010-1_ad9f734ad81a4f339a557960d10dd7f5_master.jpg.webp', 'IMAGE_1', b'1', '2024-05-14 10:47:36', '2024-05-14 10:47:36'),
(33, 'ESTB026', 'Sơ mi ngắn tay đũi ESTB026', 119, 450000, NULL, NULL, 'TORANO', '', 6, 5, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810474/1702803942386_estb026-11_52822828632_o_fb5c8442ec4146618cca5021c9f98643_master.jpg.webp', 'IMAGE_2', b'1', '2024-05-14 10:47:36', '2024-05-14 10:47:36'),
(34, 'ESTB030', 'Sơ mi ngắn tay trơn Bamboo ESTB030', 123, 400000, NULL, NULL, 'TORANO', '', 5, 2, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810115/1704715289535_eatb030-3_f4f3649109194318999a3e984bbd30f3_master.jpg.webp', 'IMAGE_2', b'1', '2024-05-14 10:47:36', '2024-05-14 10:47:36'),
(35, 'ESTP001', 'Áo polo họa tiết in tràn ESTP001', 100, 420000, NULL, NULL, 'TORANO', '', 4, 1, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811327/7_9bc29d0a14064c70aca802cc201f2750_master.jpg.webp', 'IMAGE_1', b'1', '2024-05-14 10:47:36', '2024-05-14 10:47:36'),
(36, 'ESTP005', 'Áo polo trơn bo kẻ, logo cánh tay ESTP005', 98, 420000, NULL, NULL, 'TORANO', 'Áo polo trơn bo kẻ, logo cánh tay ESTP005', 4, 1, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811464/estp005_52833497146_o_19f6e6d8b44947d4bcd7461012e1e40d_master.jpg.jpg', 'IMAGE_1', b'1', '2024-05-14 10:47:36', '2024-05-14 10:47:36'),
(37, 'ESTP007', 'Áo Polo can phối 3 màu ESTP007', 99, 420000, NULL, NULL, 'TORANO', 'Áo polo nam cao cấp đẹp, tôn dáng. Chất vải dệt mềm, dày dặn không bai xù nhăn nhàu', 4, 2, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811282/52898691562_67c82c3ca7_o_9da334afa0244604bf21a0d59cf2a7f2_master.jpg.webp', 'IMAGE_1', b'1', '2024-05-14 10:47:36', '2024-05-14 10:47:36'),
(38, 'ESTP010', 'Áo polo trơn bo kẻ ESTP010', 98, 400000, NULL, NULL, 'TORANO', '', 5, 3, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811545/tp010---bk603-_8__b6487398009b4c6eaa1950ee0f26e718_master.jpg.webp', 'IMAGE_1', b'1', '2024-05-14 10:47:36', '2024-05-14 10:47:36'),
(39, 'ESTP012', 'Áo Polo kẻ dệt ngang 1.ESTP012', 101, 500000, NULL, NULL, 'TORANO', '', 4, 1, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811086/tp012_0d295f194e3f4f0eab7eede288c3a7c5_master.jpg.webp', 'IMAGE_1', b'1', '2024-05-14 10:47:36', '2024-05-14 10:47:36'),
(40, 'ESTP014', 'Áo Polo kẻ dệt ngang 1.ESTP014', 101, 500000, NULL, NULL, 'TORANO', '', 4, 1, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811112/estp014_f4dabbabbe0346598163050a85b06f1a_master.jpg.webp', 'IMAGE_1', b'1', '2024-05-14 10:47:36', '2024-05-14 10:47:36'),
(41, 'ESTP015', 'Áo polo can phối Horizontal Color Scheme 1.ESTP015', 99, 450000, NULL, NULL, 'TORANO', '', 4, 1, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811242/estp015_a0e07e027c614085b06c261c289544ab_master.jpg.webp', 'IMAGE_1', b'1', '2024-05-14 10:47:36', '2024-05-14 10:47:36'),
(42, 'ESTP017', 'Áo polo can phối Horizontal Color Scheme ESTP017', 99, 420000, NULL, NULL, 'TORANO', '', 4, 1, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811175/52985905053_bdeffa314e_o_aa67bed06deb439399cc2046790f8c59_master.jpg.jpg', 'IMAGE_1', b'1', '2024-05-14 10:47:36', '2024-05-14 10:47:36'),
(43, 'ESTP018', 'Áo polo can phối, thêu logo ngực ESTP018', 99, 420000, NULL, NULL, 'TORANO', 'Áo polo can phối, thêu logo ngực ESTP018', 4, 1, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811140/tp018_0691972d076d4071a4fee5291912df9e_master.jpg.webp', 'IMAGE_1', b'1', '2024-05-14 10:47:36', '2024-05-14 10:47:36'),
(44, 'ESTP020', 'Áo Polo can phối 3 màu ESTP020', 99, 450000, NULL, NULL, 'TORANO', '', 4, 1, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811280/tp020---bk001-_10__b44a6900b6934440ad797f313b2cdd9a_master.jpg.webp', 'IMAGE_1', b'1', '2024-05-14 10:47:36', '2024-05-14 10:47:36'),
(45, 'ESTP021', 'Áo polo can phối, thêu logo ngực ESTP021', 99, 550000, 450000, 18, 'TORANO', '', 4, 1, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811124/estp021-2_7b1e8ac1a10c4163bf199b7b89332d81_master.jpg.webp', 'IMAGE_1', b'1', '2024-05-14 10:47:36', '2024-05-14 10:47:36'),
(46, 'ESTP022', 'Áo polo can phối vai ESTP022', 99, 450000, NULL, NULL, 'TORANO', 'Áo polo nam cao cấp đẹp, tôn dáng. Chất vải dệt mềm, dày dặn không bai xù nhăn nhàu', 5, 2, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811171/52901478774_f103d7180e_o_6ec337721b6d4a8bae3c2626bca7d037_master.jpg.webp', 'IMAGE_1', b'1', '2024-05-14 10:47:36', '2024-05-14 10:47:36'),
(47, 'ESTP023', 'Áo Polo can phối họa tiết TRN ESTP023', 99, 420000, NULL, NULL, 'TORANO', 'Áo Polo can phối họa tiết nam phong cách trẻ trung và lịch lãm thích hợp với mọi dáng người.', 4, 1, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811255/1_4554a899fc974e40bc58638b060b31ee_master.jpg.webp', 'IMAGE_1', b'1', '2024-05-14 10:47:36', '2024-05-14 10:47:36'),
(48, 'ESTP028', 'Áo polo trơn bo kẻ cổ V, in logo ngực ESTP028', 98, 420000, NULL, NULL, 'TORANO', '', 5, 4, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811570/tp028---bk004-_11__9246a1d8b0184518abd852704bd4fa02_master.jpg.webp', 'IMAGE_1', b'1', '2024-05-14 10:47:36', '2024-05-14 10:47:36'),
(49, 'ESTP032', 'Áo polo trơn bo kẻ ESTP032', 98, 400000, NULL, NULL, 'TORANO', '', 4, 3, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811526/estp032-3_f94042405af64ca581ca72c753b53b51_master.jpg.webp', 'IMAGE_1', b'1', '2024-05-14 10:47:36', '2024-05-14 10:47:36'),
(50, 'ESTP033', 'Áo polo trơn bo kẻ phối viền cổ ESTP033', 98, 420000, NULL, NULL, 'TORANO', 'Áo polo trơn bo kẻ phối viền cổ cao cấp', 4, 1, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811351/m1t1_9a04e0331596472281861b7f44cc3ca2_master.jpg.webp', 'IMAGE_1', b'1', '2024-05-14 10:47:36', '2024-05-14 10:47:36'),
(51, 'ESTP038', 'Áo Polo trơn basic đen thêu logo ngực ESTP038', 102, 330000, 200000, 39, 'TORANO', 'Áo Polo trơn TORANO cổ bẻ tay ngắn trơn, bo kẻ nhiều màu ESTP038 chính là item hoàn hảo dễ mặc dễ phối đồ cho cả nam và nữ. Khám phá ngay!!!\r\n\r\n+ Chất vải có độ co giãn tốt, thoáng khí và không phai màu.\r\n\r\n+60% Poly +35% cotton +5% Spandex\r\n\r\n+ Thấm hút mồ hôi tối đa và thoải mái khi vận động\r\n\r\n+ Thiết kế Slimfit vừa vặn tôn dáng\r\n\r\n+ Phù hợp với đi làm, đi học, đi chơi, hẹn hò, du lịch...\r\n\r\n+ Áo có 4 size : S – M –L – XL\r\n\r\nHướng dẫn sử dụng và bảo quản:\r\n\r\n+ Giặt ở nhiệt độ bình thường, với đồ có màu tương tự.\r\n\r\n+ Không được dùng hóa chất tẩy.\r\n\r\n+ Hạn chế sử dụng máy sấy và ủi ở nhiệt độ thích hợp.\r\n\r\n+ Lộn mặt trái khi phơi tránh bị phai màu\r\n\r\nChính sách và điều kiện đổi trả của TORANO:\r\n\r\n+ Cam kết chất lượng và mẫu mã sản phẩm giống với hình ảnh.\r\n\r\n+ Cam kết được đổi trả hàng trong vòng 7 ngày.\r\n\r\n+ Hàng phải còn nguyên tem mác và chưa qua sử dụng\r\n\r\n+ Sản phẩm bị lỗi do vận chuyển và do nhà sản xuất', 5, 1, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811636/tp038-1.jpeg.webp', 'IMAGE_1', b'1', '2024-05-14 10:47:36', '2024-05-14 10:47:36'),
(52, 'ESTP041', 'Áo Polo trơn hiệu ứng ESTP041', 102, 450000, NULL, NULL, 'TORANO', 'Áo polo nam cao cấp chống nhăn nhàu đang hot tại Torano', 4, 5, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811461/estp041-16_4cb9d42d84e7436884bd3f4e648621ed_master.jpg.webp', 'IMAGE_1', b'1', '2024-05-14 10:47:36', '2024-05-14 10:47:36'),
(53, 'ESTP042', 'Áo Polo trơn vải lục giác kèm logo ngực ESTP042', 102, 380000, 349000, 8, 'TORANO', 'Mẫu áo polo chất liệu cải tiến thế hệ mới mang lại cho các anh sự thoải mái cũng như vẻ ngoài lịch sự và đầy nam tính.', 5, 9, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811418/tp042---bk004-_9__2efe604ac9324e06841cf8edc590e169_master.jpg.webp', 'IMAGE_1', b'1', '2024-05-14 10:47:36', '2024-05-14 10:47:36'),
(54, 'ESTP047', 'Áo Polo len bo kẻ cổ 2.ESTP047', 98, 500000, NULL, NULL, 'TORANO', 'Áo polo len bo kẻ nam cao cấp chính hãng Torano. Chất vải len dệt chắc chắn, không xù và dão.', 4, 2, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811054/5_66590d1cba6041359e8a89a1c7e0feb5_master.jpg.webp', 'IMAGE_1', b'1', '2024-05-14 10:47:36', '2024-05-14 10:47:36'),
(55, 'ESTP060', 'Áo Polo can phối 2 màu ESTP060', 99, 420000, NULL, NULL, 'TORANO', 'Áo polo nam cao cấp đẹp, tôn dáng. Chất vải dệt mềm, dày dặn không bai xù nhăn nhàu', 4, 2, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811325/3_a6cdb2c46dd543fd9507418aef06c558_master.jpg.webp', 'IMAGE_1', b'1', '2024-05-14 10:47:36', '2024-05-14 10:47:36'),
(56, 'ESTP067', 'Áo Polo trơn bo kẻ cổ ESTP067', 98, 380000, NULL, NULL, 'TORANO', '', 5, 3, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811574/tp067---bk004-_16__bc6a55b32ddb4d94bc5c0fa5a7997db4_master.jpg.webp', 'IMAGE_1', b'1', '2024-05-14 10:47:36', '2024-05-14 10:47:36'),
(57, 'ESTP074', 'Áo Polo trơn bo kẻ ESTP074', 98, 420000, NULL, NULL, 'TORANO', 'Áo Polo nam trơn bo kẻ cao cấp phong cách trẻ trung và lịch lãm thích hợp với mọi dáng người.', 4, 2, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811013/1701361255452_1_50f16dbd5df34aa3acc99865b4820084_master.jpg.webp', 'IMAGE_1', b'1', '2024-05-14 10:47:36', '2024-05-14 10:47:36'),
(58, 'ESTS021', 'Áo T shirt họa tiết in Color scheme ESTS021', 125, 300000, NULL, NULL, 'TORANO', '', 4, 2, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810897/1702717756318_ests021_64a34ff68d6d4857bae234b1364576fc_master.jpg.webp', 'IMAGE_1', b'1', '2024-05-14 10:47:36', '2024-05-14 10:47:36'),
(59, 'ESTS036', 'Áo T shirt họa tiết in Anxiety Disorders 2.ESTS036', 125, 300000, NULL, NULL, 'TORANO', '', 4, 2, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810443/1702802725844_52932058522_9aba18e17a_o_e54f4d9597d9417c80ecba97a29c218c_master.jpg.webp', 'IMAGE_1', b'1', '2024-05-14 10:47:36', '2024-05-14 10:47:36'),
(60, 'ESTS038', 'Áo T shirt họa tiết in Vagabond 2.ESTS038', 125, 300000, NULL, NULL, 'TORANO', '', 4, 2, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810394/1702802210675_52933043930_8da87d7a6c_o_1af3f2feba9545f8be8a0a196b8b2567_master.jpg.jpg.webp', 'IMAGE_1', b'1', '2024-05-14 10:47:36', '2024-05-14 10:47:36'),
(61, 'ESTS040', 'Áo T shirt họa tiết in Smithereens 2.ESTS040', 125, 300000, NULL, NULL, 'TORANO', '', 4, 2, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810947/1702703208795_ests040-2_52988193045_o_8fd6a00033484ba78cd9122314ac7912_master.jpg.webp', 'IMAGE_1', b'1', '2024-05-14 10:47:36', '2024-05-14 10:47:36'),
(62, 'ESTS044', 'Áo T shirt họa tiết in monogram TRN 1.ESTS044', 125, 300000, NULL, NULL, 'TORANO', '', 4, 1, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810918/1702717326862_ests044-3_52952396788_o_5673812b89994da69cfc7ad22ca9677e_master.jpg.webp', 'IMAGE_1', b'1', '2024-05-14 10:47:36', '2024-05-14 10:47:36'),
(63, 'ESTS046', 'Áo T shirt họa tiết in hình Intense ESTS046', 125, 300000, NULL, NULL, 'TORANO', '', 4, 1, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810418/1702802457873_52932806289_bc52c62c78_o_f52bd9c5a85245f994c7648225599922_master.jpg.webp', 'IMAGE_1', b'1', '2024-05-14 10:47:36', '2024-05-14 10:47:36'),
(64, 'EWBS001', 'Quần nỉ trơn basic vải hiệu ứng 3.EWBS001', 111, 400000, NULL, NULL, 'TORANO', '', 4, 3, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810132/1704251898000_tw003-bs001-3_53291377849_o_110158d740fc40de9fceb818bda1132b_master.jpg.webp', 'IMAGE_5', b'1', '2024-05-14 10:47:36', '2024-05-14 10:47:36'),
(65, 'EWCL003', 'Áo khoác 2 lớp da lộn basic 1.EWCL003', 87, 890000, NULL, NULL, 'TORANO', '', 4, 1, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810171/1704250844877_ewcl003-7_53376839244_o_be698d6fa9ab4f78bf2132679fc67647_master.jpg.webp', 'IMAGE_5', b'1', '2024-05-14 10:47:36', '2024-05-14 10:47:36'),
(66, 'EWCP002', 'Áo khoác Hooded Puffer 4.EWCP002', 90, 1200000, NULL, NULL, 'TORANO', '', 4, 3, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810156/1704251255837_ewcp002-30_53376967025_o_d452a9fe67ca4f9b9803a72fa15b64fd_master.jpg.webp', 'IMAGE_5', b'1', '2024-05-14 10:47:36', '2024-05-14 10:47:36'),
(67, 'EWCW007', 'Áo khoác gió 1 lớp mũ liền EWCW007', 89, 50000, NULL, NULL, 'TORANO', 'Áo khoác gió 1 lớp mũ liền chống nước giá siêu tốt của nhà Torano đã cập bến.\r\n', 4, 3, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810212/1704189991841_ewcw007-1_c8b1f230ddb2408daa72728d0ecee531_master.jpg.webp', 'IMAGE_5', b'1', '2024-05-14 10:47:36', '2024-05-14 10:47:36'),
(68, 'EWTE003', 'Áo len kẻ ngang cổ tròn 2.EWTE003', 91, 520000, NULL, NULL, 'TORANO', '', 4, 2, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810003/1708267758762_ewte003-10_53297045794_o_af9bd1f2fa8246dab498a75b2a976f04_master.jpg.jpg', 'IMAGE_5', b'1', '2024-05-14 10:47:36', '2024-05-14 10:47:36'),
(69, 'EWTW003', 'Áo nỉ trơn basic vải hiệu ứng 3.EWTW003', 95, 380000, NULL, NULL, 'TORANO', '', 5, 3, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810052/1707657567773_tw003-bs001-6_53291471625_o_1f620c3d758e41d696fb128d159744a2_master.jpg.webp', 'IMAGE_5', b'1', '2024-05-14 10:47:36', '2024-05-14 10:47:36'),
(71, 'TP004', 'Áo polo phối màu color-block 1.TP004', 100, 450000, NULL, NULL, 'TORANO', 'Áo polo phối màu color-block TP004', 4, 1, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811025/tp004_45415f65d7bc4f4c8d52f4893d682a43_master.jpg.webp', 'IMAGE_1', b'1', '2024-05-14 10:47:36', '2024-05-14 10:47:36');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `products_detail`
--

CREATE TABLE `products_detail` (
  `id` int(11) NOT NULL,
  `product_id` int(11) DEFAULT NULL,
  `code` varchar(30) DEFAULT NULL,
  `color_id` int(11) NOT NULL,
  `size` varchar(10) NOT NULL,
  `quantity` int(11) DEFAULT NULL,
  `is_activated` bit(1) DEFAULT b'1',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `products_detail`
--

INSERT INTO `products_detail` (`id`, `product_id`, `code`, `color_id`, `size`, `quantity`, `is_activated`, `created_at`, `updated_at`) VALUES
(1, 51, 'ESTP03872PE00SB_BL-S', 4, 'SIZE_S', 0, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(2, 51, 'ESTP03872PE00SB_BL-M', 4, 'SIZE_M', 0, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(3, 51, 'ESTP03872PE00SB_BL-L', 4, 'SIZE_L', 0, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(4, 51, 'ESTP03872PE00SB_BL-XL', 4, 'SIZE_XL', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(5, 51, 'ESTP03872PE00SB_BL-XXL', 4, 'SIZE_XXL', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(6, 56, 'ESTP06772TC00SB_NV-S', 33, 'SIZE_S', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(7, 56, 'ESTP06772TC00SB_NV-M', 33, 'SIZE_M', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(8, 56, 'ESTP06772TC00SB_NV-L', 33, 'SIZE_L', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(9, 56, 'ESTP06772TC00SB_NV-XL', 33, 'SIZE_XL', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(10, 56, 'ESTP06772TC00SB_NV-XXL', 33, 'SIZE_XXL', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(11, 56, 'ESTP06772TC00SB_WH-S', 40, 'SIZE_S', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(12, 56, 'ESTP06772TC00SB_WH-M', 40, 'SIZE_M', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(13, 56, 'ESTP06772TC00SB_WH-L', 40, 'SIZE_L', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(14, 56, 'ESTP06772TC00SB_WH-XL', 40, 'SIZE_XL', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(15, 56, 'ESTP06772TC00SB_WH-XXL', 40, 'SIZE_XXL', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(16, 56, 'ESTP06772TC00SB_BL-S', 4, 'SIZE_S', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(17, 56, 'ESTP06772TC00SB_BL-M', 4, 'SIZE_M', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(18, 56, 'ESTP06772TC00SB_BL-L', 4, 'SIZE_L', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(19, 56, 'ESTP06772TC00SB_BL-XL', 4, 'SIZE_XL', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(20, 56, 'ESTP06772TC00SB_BL-XXL', 4, 'SIZE_XXL', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(26, 48, 'ESTP02872CV00SB_DCB-S', 11, 'SIZE_S', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(27, 48, 'ESTP02872CV00SB_DCB-M', 11, 'SIZE_M', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(28, 48, 'ESTP02872CV00SB_DCB-L', 11, 'SIZE_L', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(29, 48, 'ESTP02872CV00SB_DCB-XL', 11, 'SIZE_XL', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(30, 48, 'ESTP02872CV00SB_DCB-XXL', 11, 'SIZE_XXL', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(31, 48, 'ESTP02872CV00SB_WH-S', 40, 'SIZE_S', 0, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(32, 48, 'ESTP02872CV00SB_WH-M', 40, 'SIZE_M', 0, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(33, 48, 'ESTP02872CV00SB_WH-L', 40, 'SIZE_L', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(34, 48, 'ESTP02872CV00SB_WH-XL', 40, 'SIZE_XL', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(35, 48, 'ESTP02872CV00SB_WH-XXL', 40, 'SIZE_XXL', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(36, 48, 'ESTP02872CV00SB_BL-S', 4, 'SIZE_S', 0, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(37, 48, 'ESTP02872CV00SB_BL-M', 4, 'SIZE_M', 0, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(38, 48, 'ESTP02872CV00SB_BL-L', 4, 'SIZE_L', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(39, 48, 'ESTP02872CV00SB_BL-XL', 4, 'SIZE_XL', 0, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(40, 48, 'ESTP02872CV00SB_BL-XXL', 4, 'SIZE_XXL', 0, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(41, 48, 'ESTP02872CV00SB_NV-S', 33, 'SIZE_S', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(42, 48, 'ESTP02872CV00SB_NV-M', 33, 'SIZE_M', 0, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(43, 48, 'ESTP02872CV00SB_NV-L', 33, 'SIZE_L', 0, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(44, 48, 'ESTP02872CV00SB_NV-XL', 33, 'SIZE_XL', 0, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(45, 48, 'ESTP02872CV00SB_NV-XXL', 33, 'SIZE_XXL', 0, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(46, 13, 'DSTP61172CX00SB_WH-S', 40, 'SIZE_S', 777, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(47, 13, 'DSTP61172CX00SB_WH-M', 40, 'SIZE_M', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(48, 13, 'DSTP61172CX00SB_WH-L', 40, 'SIZE_L', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(49, 13, 'DSTP61172CX00SB_WH-XL', 40, 'SIZE_XL', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(50, 38, 'ESTP01072TC00SB_DGN-S', 13, 'SIZE_S', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(51, 38, 'ESTP01072TC00SB_DGN-M', 13, 'SIZE_M', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(52, 38, 'ESTP01072TC00SB_DGN-L', 13, 'SIZE_L', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(53, 38, 'ESTP01072TC00SB_DGN-XL', 13, 'SIZE_XL', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(54, 38, 'ESTP01072TC00SB_DGN-XXL', 13, 'SIZE_XXL', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(55, 38, 'ESTP01072TC00SB_CR-S', 9, 'SIZE_S', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(56, 38, 'ESTP01072TC00SB_CR-M', 9, 'SIZE_M', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(57, 38, 'ESTP01072TC00SB_CR-L', 9, 'SIZE_L', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(58, 38, 'ESTP01072TC00SB_CR-XL', 9, 'SIZE_XL', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(59, 38, 'ESTP01072TC00SB_CR-XXL', 9, 'SIZE_XXL', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(60, 38, 'ESTP01072TC00SB_WH-S', 40, 'SIZE_S', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(61, 38, 'ESTP01072TC00SB_WH-M', 40, 'SIZE_M', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(62, 38, 'ESTP01072TC00SB_WH-L', 40, 'SIZE_L', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(63, 38, 'ESTP01072TC00SB_WH-XL', 40, 'SIZE_XL', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(64, 38, 'ESTP01072TC00SB_WH-XXL', 40, 'SIZE_XXL', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(65, 49, 'ESTP03272TC00SB_BE-S', 3, 'SIZE_S', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(66, 49, 'ESTP03272TC00SB_BE-M', 3, 'SIZE_M', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(67, 49, 'ESTP03272TC00SB_BE-L', 3, 'SIZE_L', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(68, 49, 'ESTP03272TC00SB_BE-XL', 3, 'SIZE_XL', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(69, 49, 'ESTP03272TC00SB_BR-S', 6, 'SIZE_S', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(70, 49, 'ESTP03272TC00SB_BR-M', 6, 'SIZE_M', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(71, 49, 'ESTP03272TC00SB_BR-L', 6, 'SIZE_L', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(72, 49, 'ESTP03272TC00SB_BR-XL', 6, 'SIZE_XL', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(73, 49, 'ESTP03272TC00SB_WH-S', 40, 'SIZE_S', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(74, 49, 'ESTP03272TC00SB_WH-M', 40, 'SIZE_M', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(75, 49, 'ESTP03272TC00SB_WH-L', 40, 'SIZE_L', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(76, 49, 'ESTP03272TC00SB_WH-XL', 40, 'SIZE_XL', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(77, 57, 'ESTP07472CT00SB_NV-S', 33, 'SIZE_S', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(78, 57, 'ESTP07472CT00SB_NV-M', 33, 'SIZE_M', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(79, 57, 'ESTP07472CT00SB_NV-L', 33, 'SIZE_L', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(80, 57, 'ESTP07472CT00SB_NV-XL', 33, 'SIZE_XL', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(81, 57, 'ESTP07472CT00SB_WH-S', 40, 'SIZE_S', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(82, 57, 'ESTP07472CT00SB_WH-M', 40, 'SIZE_M', 998, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(83, 57, 'ESTP07472CT00SB_WH-L', 40, 'SIZE_L', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(84, 57, 'ESTP07472CT00SB_WH-XL', 40, 'SIZE_XL', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(85, 36, 'ESTP00572CT00SB_DNV-S', 15, 'SIZE_S', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(86, 36, 'ESTP00572CT00SB_DNV-M', 15, 'SIZE_M', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(87, 36, 'ESTP00572CT00SB_DNV-L', 15, 'SIZE_L', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(88, 36, 'ESTP00572CT00SB_DNV-XL', 15, 'SIZE_XL', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(89, 52, 'ESTP04172CV01SB_DCR-S', 12, 'SIZE_S', 0, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(90, 52, 'ESTP04172CV01SB_DCR-M', 12, 'SIZE_M', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(91, 52, 'ESTP04172CV01SB_DCR-L', 12, 'SIZE_L', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(92, 52, 'ESTP04172CV01SB_DCR-XL', 12, 'SIZE_XL', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(93, 52, 'ESTP04172CV01SB_BL-S', 4, 'SIZE_S', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(94, 52, 'ESTP04172CV01SB_BL-M', 4, 'SIZE_M', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(95, 52, 'ESTP04172CV01SB_BL-L', 4, 'SIZE_L', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(96, 52, 'ESTP04172CV01SB_BL-XL', 4, 'SIZE_XL', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(97, 52, 'ESTP04172CV01SB_CN-S', 8, 'SIZE_S', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(98, 52, 'ESTP04172CV01SB_CN-M', 8, 'SIZE_M', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(99, 52, 'ESTP04172CV01SB_CN-L', 8, 'SIZE_L', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(100, 52, 'ESTP04172CV01SB_CN-XL', 8, 'SIZE_XL', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(101, 52, 'ESTP04172CV01SB_DNV-S', 15, 'SIZE_S', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(102, 52, 'ESTP04172CV01SB_DNV-M', 15, 'SIZE_M', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(103, 52, 'ESTP04172CV01SB_DNV-L', 15, 'SIZE_L', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(104, 52, 'ESTP04172CV01SB_DNV-XL', 15, 'SIZE_XL', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(105, 52, 'ESTP04172CV01SB_WH-S', 40, 'SIZE_S', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(106, 52, 'ESTP04172CV01SB_WH-M', 40, 'SIZE_M', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(107, 52, 'ESTP04172CV01SB_WH-L', 40, 'SIZE_L', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(108, 52, 'ESTP04172CV01SB_WH-XL', 40, 'SIZE_XL', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(109, 53, 'ESTP04272CV00SB_BR-S', 6, 'SIZE_S', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(110, 53, 'ESTP04272CV00SB_BR-M', 6, 'SIZE_M', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(111, 53, 'ESTP04272CV00SB_BR-L', 6, 'SIZE_L', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(112, 53, 'ESTP04272CV00SB_BR-XL', 6, 'SIZE_XL', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(113, 53, 'ESTP04272CV00SB_BR-XXL', 6, 'SIZE_XXL', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(114, 53, 'ESTP04272CV00SB_LI-S', 28, 'SIZE_S', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(115, 53, 'ESTP04272CV00SB_LI-M', 28, 'SIZE_M', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(116, 53, 'ESTP04272CV00SB_LI-L', 28, 'SIZE_L', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(117, 53, 'ESTP04272CV00SB_LI-XL', 28, 'SIZE_XL', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(118, 53, 'ESTP04272CV00SB_LI-XXL', 28, 'SIZE_XXL', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(119, 53, 'ESTP04272CV00SB_BL-S', 4, 'SIZE_S', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(120, 53, 'ESTP04272CV00SB_BL-M', 4, 'SIZE_M', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(121, 53, 'ESTP04272CV00SB_BL-L', 4, 'SIZE_L', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(122, 53, 'ESTP04272CV00SB_BL-XL', 4, 'SIZE_XL', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(123, 53, 'ESTP04272CV00SB_BL-XXL', 4, 'SIZE_XXL', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(124, 53, 'ESTP04272CV00SB_NV-S', 33, 'SIZE_S', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(125, 53, 'ESTP04272CV00SB_NV-M', 33, 'SIZE_M', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(126, 53, 'ESTP04272CV00SB_NV-L', 33, 'SIZE_L', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(127, 53, 'ESTP04272CV00SB_NV-XL', 33, 'SIZE_XL', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(128, 53, 'ESTP04272CV00SB_NV-XXL', 33, 'SIZE_XXL', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(129, 53, 'ESTP04272CV00SB_DTU-S', 16, 'SIZE_S', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(130, 53, 'ESTP04272CV00SB_DTU-M', 16, 'SIZE_M', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(131, 53, 'ESTP04272CV00SB_DTU-L', 16, 'SIZE_L', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(132, 53, 'ESTP04272CV00SB_DTU-XL', 16, 'SIZE_XL', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(133, 53, 'ESTP04272CV00SB_DTU-XXL', 16, 'SIZE_XXL', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(134, 53, 'ESTP04272CV00SB_TU-S', 36, 'SIZE_S', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(135, 53, 'ESTP04272CV00SB_TU-M', 36, 'SIZE_M', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(136, 53, 'ESTP04272CV00SB_TU-L', 36, 'SIZE_L', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(137, 53, 'ESTP04272CV00SB_TU-XL', 36, 'SIZE_XL', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(138, 53, 'ESTP04272CV00SB_TU-XXL', 36, 'SIZE_XXL', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(139, 53, 'ESTP04272CV00SB_LYL-S', 31, 'SIZE_S', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(140, 53, 'ESTP04272CV00SB_LYL-M', 31, 'SIZE_M', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(141, 53, 'ESTP04272CV00SB_LYL-L', 31, 'SIZE_L', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(142, 53, 'ESTP04272CV00SB_LYL-XL', 31, 'SIZE_XL', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(143, 53, 'ESTP04272CV00SB_LYL-XXL', 31, 'SIZE_XXL', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(144, 53, 'ESTP04272CV00SB_CR-S', 9, 'SIZE_S', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(145, 53, 'ESTP04272CV00SB_CR-M', 9, 'SIZE_M', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(146, 53, 'ESTP04272CV00SB_CR-L', 9, 'SIZE_L', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(147, 53, 'ESTP04272CV00SB_CR-XL', 9, 'SIZE_XL', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(148, 53, 'ESTP04272CV00SB_CR-XXL', 9, 'SIZE_XXL', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(149, 53, 'ESTP04272CV00SB_WH-S', 40, 'SIZE_S', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(150, 53, 'ESTP04272CV00SB_WH-M', 40, 'SIZE_M', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(151, 53, 'ESTP04272CV00SB_WH-L', 40, 'SIZE_L', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(152, 53, 'ESTP04272CV00SB_WH-XL', 40, 'SIZE_XL', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(153, 53, 'ESTP04272CV00SB_WH-XXL', 40, 'SIZE_XXL', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(154, 50, 'ESTP03372CT00SB_BL-S', 4, 'SIZE_S', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(155, 50, 'ESTP03372CT00SB_BL-M', 4, 'SIZE_M', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(156, 50, 'ESTP03372CT00SB_BL-L', 4, 'SIZE_L', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(157, 50, 'ESTP03372CT00SB_BL-XL', 4, 'SIZE_XL', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(158, 35, 'ESTP00172TC04SB_WH-S', 40, 'SIZE_S', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(159, 35, 'ESTP00172TC04SB_WH-M', 40, 'SIZE_M', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(160, 35, 'ESTP00172TC04SB_WH-L', 40, 'SIZE_L', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(161, 35, 'ESTP00172TC04SB_WH-XL', 40, 'SIZE_XL', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(162, 55, 'ESTP06072CV32SB_NVC-S', 34, 'SIZE_S', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(163, 55, 'ESTP06072CV32SB_NVC-M', 34, 'SIZE_M', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(164, 55, 'ESTP06072CV32SB_NVC-L', 34, 'SIZE_L', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(165, 55, 'ESTP06072CV32SB_NVC-XL', 34, 'SIZE_XL', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(166, 55, 'ESTP06072CV32SB_HBR-S', 20, 'SIZE_S', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(167, 55, 'ESTP06072CV32SB_HBR-M', 20, 'SIZE_M', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(168, 55, 'ESTP06072CV32SB_HBR-L', 20, 'SIZE_L', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(169, 55, 'ESTP06072CV32SB_HBR-XL', 20, 'SIZE_XL', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(170, 37, 'ESTP00772CX32SB_WBL-S', 38, 'SIZE_S', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(171, 37, 'ESTP00772CX32SB_WBL-M', 38, 'SIZE_M', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(172, 37, 'ESTP00772CX32SB_WBL-L', 38, 'SIZE_L', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(173, 37, 'ESTP00772CX32SB_WBL-XL', 38, 'SIZE_XL', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(174, 37, 'ESTP00772CX32SB_WNV-S', 41, 'SIZE_S', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(175, 37, 'ESTP00772CX32SB_WNV-M', 41, 'SIZE_M', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(176, 37, 'ESTP00772CX32SB_WNV-L', 41, 'SIZE_L', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(177, 37, 'ESTP00772CX32SB_WNV-XL', 41, 'SIZE_XL', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(178, 44, 'ESTP02072TC32SB_BBR-S', 1, 'SIZE_S', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(179, 44, 'ESTP02072TC32SB_BBR-M', 1, 'SIZE_M', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(180, 44, 'ESTP02072TC32SB_BBR-L', 1, 'SIZE_L', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(181, 44, 'ESTP02072TC32SB_BBR-XL', 1, 'SIZE_XL', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(182, 47, 'ESTP02372CT32SB_NWH-S', 35, 'SIZE_S', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(183, 47, 'ESTP02372CT32SB_NWH-M', 35, 'SIZE_M', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(184, 47, 'ESTP02372CT32SB_NWH-L', 35, 'SIZE_L', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(185, 47, 'ESTP02372CT32SB_NWH-XL', 35, 'SIZE_XL', 0, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(186, 41, 'ESTP01572CV32SB_WNV-S', 41, 'SIZE_S', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(187, 41, 'ESTP01572CV32SB_WNV-M', 41, 'SIZE_M', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(188, 41, 'ESTP01572CV32SB_WNV-L', 41, 'SIZE_L', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(189, 41, 'ESTP01572CV32SB_WNV-XL', 41, 'SIZE_XL', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(190, 15, 'DSTP90372CT32RB_WCB-S', 39, 'SIZE_S', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(191, 15, 'DSTP90372CT32RB_WCB-M', 39, 'SIZE_M', 989, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(192, 15, 'DSTP90372CT32RB_WCB-L', 39, 'SIZE_L', 994, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(193, 15, 'DSTP90372CT32RB_WCB-XL', 39, 'SIZE_XL', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(194, 15, 'DSTP90372CT32RB_HCR-S', 21, 'SIZE_S', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(195, 15, 'DSTP90372CT32RB_HCR-M', 21, 'SIZE_M', 995, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(196, 15, 'DSTP90372CT32RB_HCR-L', 21, 'SIZE_L', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(197, 15, 'DSTP90372CT32RB_HCR-XL', 21, 'SIZE_XL', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(198, 42, 'ESTP01772CV32SB_BLE-S', 5, 'SIZE_S', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(199, 42, 'ESTP01772CV32SB_BLE-M', 5, 'SIZE_M', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(200, 42, 'ESTP01772CV32SB_BLE-L', 5, 'SIZE_L', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(201, 42, 'ESTP01772CV32SB_BLE-XL', 5, 'SIZE_XL', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(202, 46, 'ESTP02272CV32SB_WH-S', 40, 'SIZE_S', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(203, 46, 'ESTP02272CV32SB_WH-M', 40, 'SIZE_M', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(204, 46, 'ESTP02272CV32SB_WH-L', 40, 'SIZE_L', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(205, 46, 'ESTP02272CV32SB_WH-XL', 40, 'SIZE_XL', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(206, 46, 'ESTP02272CV32SB_WH-XXL', 40, 'SIZE_XXL', 0, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(207, 46, 'ESTP02272CV32SB_NV-S', 33, 'SIZE_S', 0, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(208, 46, 'ESTP02272CV32SB_NV-M', 33, 'SIZE_M', 0, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(209, 46, 'ESTP02272CV32SB_NV-L', 33, 'SIZE_L', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(210, 46, 'ESTP02272CV32SB_NV-XL', 33, 'SIZE_XL', 0, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(211, 46, 'ESTP02272CV32SB_NV-XXL', 33, 'SIZE_XXL', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(212, 43, 'ESTP01872CV32SB_NWH-S', 40, 'SIZE_S', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(213, 43, 'ESTP01872CV32SB_NWH-M', 40, 'SIZE_M', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(214, 43, 'ESTP01872CV32SB_NWH-L', 40, 'SIZE_L', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(215, 43, 'ESTP01872CV32SB_NWH-XL', 40, 'SIZE_XL', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(224, 45, 'ESTP02172CT32SB_NWH-S', 40, 'SIZE_S', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(225, 45, 'ESTP02172CT32SB_NWH-M', 40, 'SIZE_M', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(226, 45, 'ESTP02172CT32SB_NWH-L', 40, 'SIZE_L', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(227, 45, 'ESTP02172CT32SB_NWH-XL', 40, 'SIZE_XL', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(232, 40, 'ESTP01472CV08SB_BCR-S', 2, 'SIZE_S', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(233, 40, 'ESTP01472CV08SB_BCR-M', 2, 'SIZE_M', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(234, 40, 'ESTP01472CV08SB_BCR-L', 2, 'SIZE_L', 998, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(235, 40, 'ESTP01472CV08SB_BCR-XL', 2, 'SIZE_XL', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(240, 39, 'ESTP01272CT08SB_VCB-S', 37, 'SIZE_S', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(241, 39, 'ESTP01272CT08SB_VCB-M', 37, 'SIZE_M', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(242, 39, 'ESTP01272CT08SB_VCB-L', 37, 'SIZE_L', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(243, 39, 'ESTP01272CT08SB_VCB-XL', 37, 'SIZE_XL', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(244, 14, 'DSTP65072CT04SB_BL-S', 4, 'SIZE_S', 998, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(245, 14, 'DSTP65072CT04SB_BL-M', 4, 'SIZE_M', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(246, 14, 'DSTP65072CT04SB_BL-L', 4, 'SIZE_L', 997, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(247, 14, 'DSTP65072CT04SB_BL-XL', 4, 'SIZE_XL', 998, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(248, 54, 'ESTP04772CA00SB_DCR-S', 12, 'SIZE_S', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(249, 54, 'ESTP04772CA00SB_DCR-M', 12, 'SIZE_M', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(250, 54, 'ESTP04772CA00SB_DCR-L', 12, 'SIZE_L', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(251, 54, 'ESTP04772CA00SB_DCR-XL', 12, 'SIZE_XL', 999, b'1', '2024-05-14 10:47:45', '2024-08-07 13:04:10'),
(252, 54, 'ESTP04772CA00SB_BL-S', 4, 'SIZE_S', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(253, 54, 'ESTP04772CA00SB_BL-M', 4, 'SIZE_M', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(254, 54, 'ESTP04772CA00SB_BL-L', 4, 'SIZE_L', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(255, 54, 'ESTP04772CA00SB_BL-XL', 4, 'SIZE_XL', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(256, 71, 'DSTP00472CV32SB_BL-S', 4, 'SIZE_S', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(257, 71, 'DSTP00472CV32SB_BL-M', 4, 'SIZE_M', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(258, 71, 'DSTP00472CV32SB_BL-L', 4, 'SIZE_L', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(259, 71, 'DSTP00472CV32SB_BL-XL', 4, 'SIZE_XL', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(271, 32, 'ESTA01012CT06MB_NV-M', 33, 'SIZE_M', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(272, 32, 'ESTA01012CT06MB_NV-S', 33, 'SIZE_S', 0, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(273, 32, 'ESTA01012CT06MB_NV-L', 33, 'SIZE_L', 0, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(277, 32, 'ESTA01012CT06MB_NV-XL', 33, 'SIZE_XL', 0, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(283, 31, 'ESTA00612CT06MB_BL-M', 4, 'SIZE_M', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(284, 31, 'ESTA00612CT06MB_BL-S', 4, 'SIZE_S', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(285, 31, 'ESTA00612CT06MB_BL-L', 4, 'SIZE_L', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(286, 31, 'ESTA00612CT06MB_BL-XL', 4, 'SIZE_XL', 998, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(287, 29, 'ESTA00312CT06MB_NV-S', 33, 'SIZE_S', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(288, 29, 'ESTA00312CT06MB_NV-M', 33, 'SIZE_M', 0, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(289, 29, 'ESTA00312CT06MB_NV-L', 33, 'SIZE_L', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(290, 29, 'ESTA00312CT06MB_NV-XL', 33, 'SIZE_XL', 998, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(291, 29, 'ESTA00312CT06MB_WH-S', 40, 'SIZE_S', 998, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(292, 29, 'ESTA00312CT06MB_WH-M', 40, 'SIZE_M', 0, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(293, 29, 'ESTA00312CT06MB_WH-L', 40, 'SIZE_L', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(294, 29, 'ESTA00312CT06MB_WH-XL', 40, 'SIZE_XL', 0, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(295, 30, 'ESTA00512CT06MB_BL-S', 4, 'SIZE_S', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(296, 30, 'ESTA00512CT06MB_BL-M', 4, 'SIZE_M', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(297, 30, 'ESTA00512CT06MB_BL-L', 4, 'SIZE_L', 0, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(298, 30, 'ESTA00512CT06MB_BL-XL', 4, 'SIZE_XL', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(299, 61, 'ESTS04012CA06MB_WH-S', 40, 'SIZE_S', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(300, 61, 'ESTS04012CA06MB_WH-M', 40, 'SIZE_M', 998, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(301, 61, 'ESTS04012CA06MB_WH-L', 40, 'SIZE_L', 0, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(302, 61, 'ESTS04012CA06MB_WH-XL', 40, 'SIZE_XL', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(303, 61, 'ESTS04012CA06MB_BL-S', 4, 'SIZE_S', 0, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(304, 61, 'ESTS04012CA06MB_BL-M', 4, 'SIZE_M', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(305, 61, 'ESTS04012CA06MB_BL-L', 4, 'SIZE_L', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(306, 61, 'ESTS04012CA06MB_BL_XL', 4, 'SIZE_XL', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(307, 62, 'ESTS04412CA04MB_WH-S', 40, 'SIZE_S', 998, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(308, 62, 'ESTS04412CA04MB_WH-M', 40, 'SIZE_M', 0, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(309, 62, 'ESTS04412CA04MB_WH-L', 40, 'SIZE_L', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(310, 62, 'ESTS04412CA04MB_WH-XL', 40, 'SIZE_XL', 0, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(311, 58, 'ESTS02112CV06MB_DCB-S', 11, 'SIZE_S', 0, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(312, 58, 'ESTS02112CV06MB_DCB-M', 11, 'SIZE_M', 0, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(313, 58, 'ESTS02112CV06MB_DCB-L', 11, 'SIZE_L', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(314, 58, 'ESTS02112CV06MB_DCB-XL', 40, 'SIZE_XL', 998, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(315, 58, 'ESTS02112CV06MB_WH-L', 40, 'SIZE_L', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(316, 58, 'ESTS02112CV06MB_WH-S', 40, 'SIZE_S', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(317, 58, 'ESTS02112CV06MB_WH-M', 40, 'SIZE_M', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(318, 58, 'ESTS02112CV06MB_WH-XL', 40, 'SIZE_XL', 998, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(327, 60, 'ESTS03812CT06MB_NV-M', 33, 'SIZE_M', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(328, 60, 'ESTS03812CT06MB_NV-S', 33, 'SIZE_S', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(329, 60, 'ESTS03812CT06MB_NV-L', 33, 'SIZE_L', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(330, 60, 'ESTS03812CT06MB_NV-XL', 33, 'SIZE_XL', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(331, 60, 'ESTS03812CT06MB_DCB-S', 11, 'SIZE_S', 0, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(332, 60, 'ESTS03812CT06MB_DCB-M', 11, 'SIZE_M', 0, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(333, 60, 'ESTS03812CT06MB_DCB-L', 11, 'SIZE_L', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(334, 60, 'ESTS03812CT06MB_DCB-XL', 11, 'SIZE_XL', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(335, 63, 'ESTS04612CT06MB_WH-S', 40, 'SIZE_S', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(336, 63, 'ESTS04612CT06MB_WH-M', 40, 'SIZE_M', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(337, 63, 'ESTS04612CT06MB_WH-L', 40, 'SIZE_L', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(338, 63, 'ESTS04612CT06MB_WH-XL', 40, 'SIZE_XL', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(339, 59, 'ESTS03612CA06MB_BL-XL', 4, 'SIZE_XL', 0, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(340, 59, 'ESTS03612CA06MB_BL-L', 4, 'SIZE_L', 0, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(341, 59, 'ESTS03612CA06MB_BL-M', 4, 'SIZE_M', 0, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(342, 59, 'ESTS03612CA06MB_BL-S', 4, 'SIZE_S', 0, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(343, 59, 'ESTS03612CA06MB_WH-L', 40, 'SIZE_L', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(344, 59, 'ESTS03612CA06MB_WH-S', 40, 'SIZE_S', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(345, 59, 'ESTS03612CA06MB_WH-M', 40, 'SIZE_M', 0, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(346, 59, 'ESTS03612CA06MB_WH-XL', 40, 'SIZE_XL', 0, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(347, 33, 'ESTB02672LI00RB_DNV-38', 15, 'SIZE_38', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(348, 33, 'ESTB02672LI00RB_DNV-39', 15, 'SIZE_39', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(349, 33, 'ESTB02672LI00RB_DNV-40', 15, 'SIZE_40', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(350, 33, 'ESTB02672LI00RB_DNV-41', 15, 'SIZE_41', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(351, 33, 'ESTB02672LI00RB_DNV-42', 15, 'SIZE_42', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(352, 33, 'ESTB02672LI00RB_WH-40', 40, 'SIZE_40', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(353, 33, 'ESTB02672LI00RB_WH-39', 40, 'SIZE_39', 0, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(354, 33, 'ESTB02672LI00RB_WH-38', 40, 'SIZE_38', 0, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(355, 33, 'ESTB02672LI00RB_WH-41', 40, 'SIZE_41', 0, b'1', '2024-05-14 10:47:45', '2024-08-07 13:04:10'),
(356, 33, 'ESTB02672LI00RB_WH-42', 40, 'SIZE_XL', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(357, 33, 'ESTB02672LI00RB_LG-38', 27, 'SIZE_38', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(358, 33, 'ESTB02672LI00RB_LG-39', 27, 'SIZE_39', 0, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(359, 33, 'ESTB02672LI00RB_LG-40', 27, 'SIZE_40', 0, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(360, 33, 'ESTB02672LI00RB_LG-41', 27, 'SIZE_41', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(361, 33, 'ESTB02672LI00RB_LG-42', 27, 'SIZE_42', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(362, 33, 'ESTB02672LI00RB_LCR-42', 26, 'SIZE_42', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(363, 33, 'ESTB02672LI00RB_LCR-41', 26, 'SIZE_41', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(364, 33, 'ESTB02672LI00RB_LCR-40', 26, 'SIZE_40', 0, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(365, 33, 'ESTB02672LI00RB_LCR-39', 26, 'SIZE_39', 0, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(366, 33, 'ESTB02672LI00RB_LCR-38', 26, 'SIZE_38', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(367, 33, 'ESTB02672LI00RB_LB-42', 22, 'SIZE_42', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(368, 33, 'ESTB02672LI00RB_LB-41', 22, 'SIZE_41', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(369, 33, 'ESTB02672LI00RB_LB-40', 22, 'SIZE_40', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(370, 33, 'ESTB02672LI00RB_LB-39', 22, 'SIZE_39', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(371, 33, 'ESTB02672LI00RB_LB-38', 22, 'SIZE_38', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(372, 34, 'ESTB03071BA02SB_WH-38', 40, 'SIZE_38', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(373, 34, 'ESTB03071BA02SB_WH-39', 40, 'SIZE_39', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(374, 34, 'ESTB03071BA02SB_WH-40', 40, 'SIZE_40', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(375, 34, 'ESTB03071BA02SB_WH-41', 40, 'SIZE_41', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(376, 34, 'ESTB03071BA02SB_WH-42', 40, 'SIZE_42', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(377, 34, 'ESTB03071BA02SB_LCB-38', 25, 'SIZE_38', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(378, 34, 'ESTB03071BA02SB_LCB-39', 25, 'SIZE_39', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(379, 34, 'ESTB03071BA02SB_LCB-40', 25, 'SIZE_40', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(380, 34, 'ESTB03071BA02SB_LCB-41', 25, 'SIZE_41', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(381, 34, 'ESTB03071BA02SB_LCB-42', 25, 'SIZE_42', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(382, 11, 'DATB61471BA00SB_LLB-38', 29, 'SIZE_38', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(383, 11, 'DATB61471BA00SB_LLB-39', 29, 'SIZE_39', 0, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(384, 11, 'DATB61471BA00SB_LLB-40', 29, 'SIZE_40', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(385, 11, 'DATB61471BA00SB_LLB-41', 29, 'SIZE_41', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(386, 11, 'DATB61471BA00SB_LLB-42', 29, 'SIZE_42', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(387, 11, 'DATB61471BA00SB_WH-38', 40, 'SIZE_38', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(388, 11, 'DATB61471BA00SB_WH-39', 40, 'SIZE_39', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(389, 11, 'DATB61471BA00SB_WH-40', 40, 'SIZE_39', 0, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(390, 11, 'DATB61471BA00SB_WH-41', 40, 'SIZE_41', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(391, 11, 'DATB61471BA00SB_WH-42', 40, 'SIZE_42', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(392, 11, 'DATB61471BA00SB_NV-38', 33, 'SIZE_38', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(393, 11, 'DATB61471BA00SB_NV-39', 33, 'SIZE_39', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(394, 11, 'DATB61471BA00SB_NV-40', 33, 'SIZE_40', 0, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(395, 11, 'DATB61471BA00SB_NV-41', 33, 'SIZE_41', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(396, 11, 'DATB61471BA00SB_NV-42', 33, 'SIZE_42', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(397, 11, 'DATB61471BA00SB_BL-38', 4, 'SIZE_38', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(398, 11, 'DATB61471BA00SB_BL-39', 4, 'SIZE_39', 0, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(399, 11, 'DATB61471BA00SB_BL-40', 4, 'SIZE_40', 0, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(400, 11, 'DATB61471BA00SB_BL-41', 4, 'SIZE_41', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(401, 11, 'DATB61471BA00SB_BL-42', 4, 'SIZE_42', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(402, 12, 'DATB92071BA00SB_BL-38', 4, 'SIZE_38', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(403, 12, 'DATB92071BA00SB_BL-39', 4, 'SIZE_39', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(404, 12, 'DATB92071BA00SB_BL-40', 4, 'SIZE_40', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(405, 12, 'DATB92071BA00SB_BL-41', 4, 'SIZE_41', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(406, 12, 'DATB92071BA00SB_BL-42', 4, 'SIZE_42', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(407, 12, 'DATB92071BA00SB_WH-38', 40, 'SIZE_38', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(408, 12, 'DATB92071BA00SB_WH-39', 40, 'SIZE_39', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(409, 12, 'DATB92071BA00SB_WH-40', 40, 'SIZE_40', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(410, 12, 'DATB92071BA00SB_WH-41', 40, 'SIZE_41', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(411, 12, 'DATB92071BA00SB_WH-42', 40, 'SIZE_42', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(412, 12, 'DATB92071BA00SB_LB-38', 22, 'SIZE_38', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(413, 12, 'DATB92071BA00SB_LB-39', 22, 'SIZE_39', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(414, 12, 'DATB92071BA00SB_LB-40', 22, 'SIZE_40', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(415, 12, 'DATB92071BA00SB_LB-41', 22, 'SIZE_41', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(416, 12, 'DATB92071BA00SB_LB-42', 22, 'SIZE_42', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(417, 12, 'DATB92071BA00SB_NV-38', 33, 'SIZE_38', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(418, 12, 'DATB92071BA00SB_NV-39', 33, 'SIZE_39', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(419, 12, 'DATB92071BA00SB_NV-40', 33, 'SIZE_40', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(420, 12, 'DATB92071BA00SB_NV-41', 33, 'SIZE_41', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(421, 12, 'DATB92071BA00SB_NV-42', 33, 'SIZE_42', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(422, 23, 'EATB00671LI13RB_DNV-38', 15, 'SIZE_38', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(423, 23, 'EATB00671LI13RB_DNV-39', 15, 'SIZE_39', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(424, 23, 'EATB00671LI13RB_DNV-40', 15, 'SIZE_40', 0, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(425, 23, 'EATB00671LI13RB_DNV-41', 15, 'SIZE_41', 999, b'1', '2024-05-14 10:47:45', '2024-08-07 13:04:10'),
(426, 23, 'EATB00671LI13RB_DNV-42', 15, 'SIZE_42', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(427, 23, 'EATB00671LI13RB_WH-38', 40, 'SIZE_38', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(428, 23, 'EATB00671LI13RB_WH-39', 40, 'SIZE_39', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(429, 23, 'EATB00671LI13RB_WH-40', 40, 'SIZE_40', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(430, 23, 'EATB00671LI13RB_WH-41', 40, 'SIZE_41', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(431, 23, 'EATB00671LI13RB_WH-42', 40, 'SIZE_42', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(432, 23, 'EATB00671LI13RB_LG-38', 27, 'SIZE_38', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(433, 23, 'EATB00671LI13RB_LG-39', 27, 'SIZE_39', 0, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(434, 23, 'EATB00671LI13RB_LG-40', 27, 'SIZE_40', 0, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(435, 23, 'EATB00671LI13RB_LG-41', 27, 'SIZE_41', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(436, 23, 'EATB00671LI13RB_LG-42', 27, 'SIZE_42', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(437, 23, 'EATB00671LI13RB_LB-39', 22, 'SIZE_39', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(438, 23, 'EATB00671LI13RB_LB-38', 22, 'SIZE_38', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(439, 23, 'EATB00671LI13RB_LB-40', 22, 'SIZE_40', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(440, 23, 'EATB00671LI13RB_LB-41', 22, 'SIZE_41', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(441, 23, 'EATB00671LI13RB_LB-42', 22, 'SIZE_42', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(442, 10, 'DATB41671CA11RB_NBX-38', 32, 'SIZE_38', 992, b'1', '2024-05-14 10:47:45', '2024-08-06 12:13:37'),
(443, 10, 'DATB41671CA11RB_NBX-39', 32, 'SIZE_39', 996, b'1', '2024-05-14 10:47:45', '2024-08-06 12:13:37'),
(444, 10, 'DATB41671CA11RB_NBX-40', 32, 'SIZE_40', 999, b'1', '2024-05-14 10:47:45', '2024-08-06 12:13:37'),
(445, 10, 'DATB41671CA11RB_NBX-41', 32, 'SIZE_41', 999, b'1', '2024-05-14 10:47:45', '2024-08-06 12:13:37'),
(446, 10, 'DATB41671CA11RB_NBX-42', 32, 'SIZE_42', 999, b'1', '2024-05-14 10:47:45', '2024-08-06 12:13:37'),
(447, 22, 'EATB00371CA11SB_GN-38', 18, 'SIZE_38', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(448, 22, 'EATB00371CA11SB_GN-39', 18, 'SIZE_39', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(449, 22, 'EATB00371CA11SB_GN-40', 18, 'SIZE_40', 0, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(450, 22, 'EATB00371CA11SB_GN-41', 18, 'SIZE_41', 0, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(451, 22, 'EATB00371CA11SB_GN-42', 18, 'SIZE_42', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(452, 22, 'EATB00371CA11SB_LB-38', 22, 'SIZE_38', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(453, 22, 'EATB00371CA11SB_LB-39', 22, 'SIZE_39', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(454, 22, 'EATB00371CA11SB_LB-40', 22, 'SIZE_40', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(455, 22, 'EATB00371CA11SB_LB-41', 22, 'SIZE_41', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(456, 22, 'EATB00371CA11SB_LB-42', 22, 'SIZE_42', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(457, 22, 'EATB00371CA11SB_BL-38', 4, 'SIZE_38', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(458, 22, 'EATB00371CA11SB_BL-39', 4, 'SIZE_39', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(459, 22, 'EATB00371CA11SB_BL-40', 4, 'SIZE_40', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(460, 22, 'EATB00371CA11SB_BL-41', 4, 'SIZE_41', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(461, 22, 'EATB00371CA11SB_BL-42', 4, 'SIZE_42', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(462, 8, 'DABK90601CT00SB_NV-29', 33, 'SIZE_29', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(463, 8, 'DABK90601CT00SB_NV-30', 33, 'SIZE_30', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(464, 8, 'DABK90601CT00SB_NV-31', 33, 'SIZE_31', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(465, 8, 'DABK90601CT00SB_NV-32', 33, 'SIZE_32', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(466, 8, 'DABK90601CT00SB_NV-33', 33, 'SIZE_33', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(467, 8, 'DABK90601CT00SB_LG-29', 27, 'SIZE_29', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(468, 8, 'DABK90601CT00SB_LG-30', 27, 'SIZE_30', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(469, 8, 'DABK90601CT00SB_LG-31', 27, 'SIZE_31', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(470, 8, 'DABK90601CT00SB_LG-32', 27, 'SIZE_32', 999, b'1', '2024-05-14 10:47:45', '2024-08-07 13:04:10'),
(471, 8, 'DABK90601CT00SB_LG-33', 27, 'SIZE_33', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(472, 8, 'DABK90601CT00SB_CN-29', 8, 'SIZE_29', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(473, 8, 'DABK90601CT00SB_CN-30', 8, 'SIZE_30', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(474, 8, 'DABK90601CT00SB_CN-31', 8, 'SIZE_31', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(475, 8, 'DABK90601CT00SB_CN-32', 8, 'SIZE_32', 998, b'1', '2024-05-14 10:47:45', '2024-08-08 15:24:14'),
(476, 8, 'DABK90601CT00SB_CN-33', 8, 'SIZE_33', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(477, 8, 'DABK90601CT00SB_BL-31', 4, 'SIZE_31', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(478, 8, 'DABK90601CT00SB_BL-30', 4, 'SIZE_30', 0, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(479, 8, 'DABK90601CT00SB_BL-32', 4, 'SIZE_32', 0, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(480, 8, 'DABK90601CT00SB_BL-33', 4, 'SIZE_33', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(481, 8, 'DABK90601CT00SB_BL-29', 4, 'SIZE_29', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(482, 9, 'DABK90801CT00SB_NV-29', 33, 'SIZE_29', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(483, 9, 'DABK90801CT00SB_NV-30', 33, 'SIZE_30', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(484, 9, 'DABK90801CT00SB_NV-31', 33, 'SIZE_31', 0, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(485, 9, 'DABK90801CT00SB_NV-32', 33, 'SIZE_32', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(486, 9, 'DABK90801CT00SB_NV-33', 33, 'SIZE_33', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(487, 9, 'DABK90801CT00SB_LG-32', 27, 'SIZE_32', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(488, 9, 'DABK90801CT00SB_LG-33', 27, 'SIZE_33', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(489, 9, 'DABK90801CT00SB_LG-31', 27, 'SIZE_31', 0, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(490, 9, 'DABK90801CT00SB_LG-30', 27, 'SIZE_30', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(491, 9, 'DABK90801CT00SB_LG-29', 27, 'SIZE_29', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(492, 9, 'DABK90801CT00SB_CN-29', 8, 'SIZE_29', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(493, 9, 'DABK90801CT00SB_CN-30', 8, 'SIZE_30', 0, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(494, 9, 'DABK90801CT00SB_CN-31', 8, 'SIZE_31', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(495, 9, 'DABK90801CT00SB_CN-32', 8, 'SIZE_32', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(496, 9, 'DABK90801CT00SB_CN-33', 8, 'SIZE_33', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(497, 9, 'DABK90801CT00SB_BL-30', 4, 'SIZE_30', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(498, 9, 'DABK90801CT00SB_BL-29', 4, 'SIZE_29', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(499, 9, 'DABK90801CT00SB_BL-31', 4, 'SIZE_31', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(500, 9, 'DABK90801CT00SB_BL-32', 4, 'SIZE_32', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(501, 9, 'DABK90801CT00SB_BL-33', 4, 'SIZE_33', 0, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(502, 21, 'EABT02101PE00SB_BL-29', 4, 'SIZE_29', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(503, 21, 'EABT02101PE00SB_BL-30', 4, 'SIZE_30', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(504, 21, 'EABT02101PE00SB_BL-31', 4, 'SIZE_31', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(505, 21, 'EABT02101PE00SB_BL-32', 4, 'SIZE_32', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(506, 21, 'EABT02101PE00SB_BL-33', 4, 'SIZE_33', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(507, 20, 'EABT01901PE00SB_DNV-29', 15, 'SIZE_29', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(508, 20, 'EABT01901PE00SB_DNV-30', 15, 'SIZE_30', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(509, 20, 'EABT01901PE00SB_DNV-31', 15, 'SIZE_31', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(510, 20, 'EABT01901PE00SB_DNV-32', 15, 'SIZE_32', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(511, 20, 'EABT01901PE00SB_DNV-33', 15, 'SIZE_33', 999, b'1', '2024-05-14 10:47:45', '2024-08-07 13:04:10'),
(512, 20, 'EABT01901PE00SB_LBL-29', 24, 'SIZE_29', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(513, 20, 'EABT01901PE00SB_LBL-30', 24, 'SIZE_30', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(514, 20, 'EABT01901PE00SB_LBL-31', 24, 'SIZE_31', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(515, 20, 'EABT01901PE00SB_LBL-32', 24, 'SIZE_32', 0, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(516, 20, 'EABT01901PE00SB_LBL-33', 24, 'SIZE_33', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(517, 20, 'EABT01901PE00SB_GR-29', 19, 'SIZE_29', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(518, 20, 'EABT01901PE00SB_GR-30', 19, 'SIZE_30', 0, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(519, 20, 'EABT01901PE00SB_GR-31', 19, 'SIZE_31', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(520, 20, 'EABT01901PE00SB_GR-32', 19, 'SIZE_32', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(521, 20, 'EABT01901PE00SB_GR-33', 19, 'SIZE_33', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(522, 20, 'EABT01901PE00SB_BL-29', 4, 'SIZE_29', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(523, 20, 'EABT01901PE00SB_BL-30', 4, 'SIZE_30', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(524, 20, 'EABT01901PE00SB_BL-31', 4, 'SIZE_31', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59');
INSERT INTO `products_detail` (`id`, `product_id`, `code`, `color_id`, `size`, `quantity`, `is_activated`, `created_at`, `updated_at`) VALUES
(525, 20, 'EABT01901PE00SB_BL-32', 4, 'SIZE_32', 0, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(526, 20, 'EABT01901PE00SB_BL-33', 4, 'SIZE_33', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(527, 3, 'DABJ00401CT00SB_NV-29', 33, 'SIZE_29', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(528, 3, 'DABJ00401CT00SB_NV-30', 33, 'SIZE_30', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(529, 3, 'DABJ00401CT00SB_NV-31', 33, 'SIZE_31', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(530, 3, 'DABJ00401CT00SB_NV-32', 33, 'SIZE_32', 998, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(531, 3, 'DABJ00401CT00SB_NV-33', 33, 'SIZE_33', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(532, 4, 'DABJ01001CT00SB_BU-29', 7, 'SIZE_29', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(533, 4, 'DABJ01001CT00SB_BU-30', 7, 'SIZE_30', -5, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(534, 4, 'DABJ01001CT00SB_BU-31', 7, 'SIZE_31', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(535, 4, 'DABJ01001CT00SB_BU-32', 7, 'SIZE_32', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(536, 4, 'DABJ01001CT00SB_BU-33', 7, 'SIZE_33', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(537, 5, 'DABJ90301CT16SB_NV-33', 33, 'SIZE_33', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(538, 5, 'DABJ90301CT16SB_NV-32', 33, 'SIZE_32', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(539, 5, 'DABJ90301CT16SB_NV-31', 33, 'SIZE_31', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(540, 5, 'DABJ90301CT16SB_NV-30', 33, 'SIZE_30', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(541, 5, 'DABJ90301CT16SB_NV-29', 33, 'SIZE_29', 997, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(542, 7, 'DABJ90801CT19SB_DBU-29', 10, 'SIZE_29', 997, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(543, 7, 'DABJ90801CT19SB_DBU-30', 10, 'SIZE_30', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(544, 7, 'DABJ90801CT19SB_DBU-31', 10, 'SIZE_31', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(545, 7, 'DABJ90801CT19SB_DBU-32', 10, 'SIZE_32', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(546, 7, 'DABJ90801CT19SB_DBU-33', 10, 'SIZE_33', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(547, 2, 'CABJ00301CT19SB_BU-29', 7, 'SIZE_29', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(548, 2, 'CABJ00301CT19SB_BU-30', 7, 'SIZE_30', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(549, 2, 'CABJ00301CT19SB_BU-31', 7, 'SIZE_31', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(550, 2, 'CABJ00301CT19SB_BU-32', 7, 'SIZE_32', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(551, 2, 'CABJ00301CT19SB_BU-33', 7, 'SIZE_33', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(552, 6, 'DABJ90401CT19SB_NV-29', 33, 'SIZE_29', 0, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(553, 6, 'DABJ90401CT19SB_NV-30', 33, 'SIZE_30', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(554, 6, 'DABJ90401CT19SB_NV-31', 33, 'SIZE_31', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(555, 6, 'DABJ90401CT19SB_NV-32', 33, 'SIZE_32', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(556, 6, 'DABJ90401CT19SB_NV-33', 33, 'SIZE_33', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(557, 28, 'ESBW00502PE00RB_BL-S', 4, 'SIZE_S', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(558, 28, 'ESBW00502PE00RB_BL-M', 4, 'SIZE_M', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(559, 28, 'ESBW00502PE00RB_BL-L', 4, 'SIZE_L', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(560, 28, 'ESBW00502PE00RB_BL-XL', 4, 'SIZE_XL', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(561, 28, 'ESBW00502PE00RB_NV-S', 33, 'SIZE_S', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(562, 28, 'ESBW00502PE00RB_NV-M', 33, 'SIZE_M', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(563, 28, 'ESBW00502PE00RB_NV-L', 33, 'SIZE_L', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(564, 28, 'ESBW00502PE00RB_NV-XL', 33, 'SIZE_XL', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(565, 27, 'ESBW00402PE01MB_LG-S', 27, 'SIZE_S', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(566, 27, 'ESBW00402PE01MB_LG-M', 27, 'SIZE_M', 0, b'1', '2024-05-14 10:47:45', '2024-08-07 13:04:10'),
(567, 27, 'ESBW00402PE01MB_LG-L', 27, 'SIZE_L', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(568, 27, 'ESBW00402PE01MB_LG-XL', 27, 'SIZE_XL', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(569, 27, 'ESBW00402PE01MB_NV-S', 33, 'SIZE_S', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(570, 27, 'ESBW00402PE01MB_NV-M', 33, 'SIZE_M', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(571, 27, 'ESBW00402PE01MB_NV-L', 33, 'SIZE_L', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(572, 27, 'ESBW00402PE01MB_NV-XL', 33, 'SIZE_XL', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(573, 27, 'ESBW00402PE01MB_BL-S', 4, 'SIZE_S', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(574, 27, 'ESBW00402PE01MB_BL-M', 4, 'SIZE_M', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(575, 27, 'ESBW00402PE01MB_BL-L', 4, 'SIZE_L', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(576, 27, 'ESBW00402PE01MB_BL-XL', 4, 'SIZE_XL', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(577, 26, 'ESBK00702CT00RB_NV-29', 33, 'SIZE_29', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(578, 26, 'ESBK00702CT00RB_NV-30', 33, 'SIZE_30', 0, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(579, 26, 'ESBK00702CT00RB_NV-31', 33, 'SIZE_31', 0, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(580, 26, 'ESBK00702CT00RB_NV-32', 33, 'SIZE_32', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(581, 26, 'ESBK00702CT00RB_NV-33', 33, 'SIZE_33', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(582, 26, 'ESBK00702CT00RB_LG-29', 27, 'SIZE_29', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(583, 26, 'ESBK00702CT00RB_LG-30', 27, 'SIZE_30', 0, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(584, 26, 'ESBK00702CT00RB_LG-31', 27, 'SIZE_31', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(585, 26, 'ESBK00702CT00RB_LG-32', 27, 'SIZE_32', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(586, 26, 'ESBK00702CT00RB_LG-33', 27, 'SIZE_33', 0, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(587, 26, 'ESBK00702CT00RB_BL-29', 4, 'SIZE_29', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(588, 26, 'ESBK00702CT00RB_BL-30', 4, 'SIZE_30', 999, b'1', '2024-05-14 10:47:45', '2024-08-07 13:04:10'),
(589, 26, 'ESBK00702CT00RB_BL-31', 4, 'SIZE_31', 0, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(590, 26, 'ESBK00702CT00RB_BL-32', 4, 'SIZE_32', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(591, 26, 'ESBK00702CT00RB_BL-33', 4, 'SIZE_33', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(592, 25, 'ESBK00202CT00RB_NV-29', 33, 'SIZE_29', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(593, 25, 'ESBK00202CT00RB_NV-30', 33, 'SIZE_30', 0, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(594, 25, 'ESBK00202CT00RB_NV-31', 33, 'SIZE_31', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(595, 25, 'ESBK00202CT00RB_NV-32', 33, 'SIZE_32', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(596, 25, 'ESBK00202CT00RB_NV-33', 33, 'SIZE_33', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(597, 25, 'ESBK00202CT00RB_LG-29', 27, 'SIZE_29', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(598, 25, 'ESBK00202CT00RB_LG-30', 27, 'SIZE_30', 0, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(599, 25, 'ESBK00202CT00RB_LG-31', 27, 'SIZE_31', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(600, 25, 'ESBK00202CT00RB_LG-32', 27, 'SIZE_32', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(601, 25, 'ESBK00202CT00RB_LG-33', 27, 'SIZE_33', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(602, 25, 'ESBK00202CT00RB_BL-29', 4, 'SIZE_29', 0, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(603, 25, 'ESBK00202CT00RB_BL-30', 4, 'SIZE_30', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(604, 25, 'ESBK00202CT00RB_BL-31', 4, 'SIZE_31', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(605, 25, 'ESBK00202CT00RB_BL-32', 4, 'SIZE_32', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(606, 25, 'ESBK00202CT00RB_BL-33', 3, 'SIZE_33', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(607, 25, 'ESBK00202CT00RB_BE-29', 3, 'SIZE_29', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(608, 25, 'ESBK00202CT00RB_BE-30', 3, 'SIZE_30', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(609, 25, 'ESBK00202CT00RB_BE-31', 3, 'SIZE_31', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(610, 25, 'ESBK00202CT00RB_BE-32', 3, 'SIZE_32', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(611, 25, 'ESBK00202CT00RB_BE-33', 3, 'SIZE_33', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(613, 1, 'DSBI01302LI00SB_BE-30', 3, 'SIZE_30', 999, b'1', '2024-05-14 10:47:45', '2024-08-06 12:45:59'),
(614, 1, 'DSBI01302LI00SB_BE-31', 3, 'SIZE_31', 991, b'1', '2024-05-14 10:47:45', '2024-08-06 12:45:59'),
(615, 1, 'DSBI01302LI00SB_BE-32', 3, 'SIZE_32', 999, b'1', '2024-05-14 10:47:45', '2024-08-06 12:45:59'),
(616, 1, 'DSBI01302LI00SB_BE-33', 3, 'SIZE_33', 999, b'1', '2024-05-14 10:47:45', '2024-08-06 12:45:59'),
(617, 1, 'DSBI01302LI00SB_WH-29', 40, 'SIZE_29', 999, b'1', '2024-05-14 10:47:45', '2024-08-06 12:45:59'),
(618, 1, 'DSBI01302LI00SB_WH-31', 40, 'SIZE_31', 999, b'1', '2024-05-14 10:47:45', '2024-08-06 12:45:59'),
(619, 1, 'DSBI01302LI00SB_WH-30', 40, 'SIZE_30', 999, b'1', '2024-05-14 10:47:45', '2024-08-06 12:45:59'),
(620, 1, 'DSBI01302LI00SB_WH-32', 40, 'SIZE_32', 999, b'1', '2024-05-14 10:47:45', '2024-08-06 12:45:59'),
(621, 1, 'DSBI01302LI00SB_WH-33', 40, 'SIZE_33', 999, b'1', '2024-05-14 10:47:45', '2024-08-06 12:45:59'),
(622, 1, 'DSBI01302LI00SB_LB-31', 22, 'SIZE_31', 999, b'1', '2024-05-14 10:47:45', '2024-08-06 12:45:59'),
(623, 1, 'DSBI01302LI00SB_LB-30', 22, 'SIZE_30', 999, b'1', '2024-05-14 10:47:45', '2024-08-06 12:45:59'),
(625, 1, 'DSBI01302LI00SB_LB-32', 22, 'SIZE_32', 999, b'1', '2024-05-14 10:47:45', '2024-08-06 12:45:59'),
(626, 1, 'DSBI01302LI00SB_LB-33', 22, 'SIZE_33', 999, b'1', '2024-05-14 10:47:45', '2024-08-06 12:45:59'),
(627, 1, 'DSBI01302LI00SB_LG-29', 27, 'SIZE_29', 999, b'1', '2024-05-14 10:47:45', '2024-08-06 12:45:59'),
(628, 1, 'DSBI01302LI00SB_LG-30', 27, 'SIZE_30', 0, b'1', '2024-05-14 10:47:45', '2024-08-06 12:45:59'),
(629, 1, 'DSBI01302LI00SB_LG-31', 27, 'SIZE_31', 999, b'1', '2024-05-14 10:47:45', '2024-08-06 12:45:59'),
(630, 1, 'DSBI01302LI00SB_LG-32', 27, 'SIZE_32', 999, b'1', '2024-05-14 10:47:45', '2024-08-06 12:45:59'),
(631, 1, 'DSBI01302LI00SB_LG-33', 27, 'SIZE_33', 999, b'1', '2024-05-14 10:47:45', '2024-08-06 12:45:59'),
(632, 1, 'DSBI01302LI00SB_NV-29', 33, 'SIZE_29', 999, b'1', '2024-05-14 10:47:45', '2024-08-06 12:45:59'),
(633, 1, 'DSBI01302LI00SB_NV-30', 33, 'SIZE_30', 999, b'1', '2024-05-14 10:47:45', '2024-08-06 12:45:59'),
(634, 1, 'DSBI01302LI00SB_NV-31', 33, 'SIZE_31', 999, b'1', '2024-05-14 10:47:45', '2024-08-06 12:45:59'),
(635, 1, 'DSBI01302LI00SB_NV-32', 33, 'SIZE_32', 999, b'1', '2024-05-14 10:47:45', '2024-08-06 12:45:59'),
(636, 1, 'DSBI01302LI00SB_NV-33', 33, 'SIZE_33', 999, b'1', '2024-05-14 10:47:45', '2024-08-06 12:45:59'),
(637, 1, 'DSBI01302LI00SB_BL-29', 4, 'SIZE_29', 999, b'1', '2024-05-14 10:47:45', '2024-08-06 12:45:59'),
(638, 1, 'DSBI01302LI00SB_BL-30', 4, 'SIZE_30', 999, b'1', '2024-05-14 10:47:45', '2024-08-06 12:45:59'),
(639, 1, 'DSBI01302LI00SB_BL-31', 4, 'SIZE_31', 999, b'1', '2024-05-14 10:47:45', '2024-08-06 12:45:59'),
(640, 1, 'DSBI01302LI00SB_BL-32', 4, 'SIZE_31', 999, b'1', '2024-05-14 10:47:45', '2024-08-06 12:45:59'),
(641, 1, 'DSBI01302LI00SB_BL-33', 4, 'SIZE_33', 999, b'1', '2024-05-14 10:47:45', '2024-08-06 12:45:59'),
(642, 24, 'ESBI00602CA00SB_BL-29', 4, 'SIZE_29', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(643, 24, 'ESBI00602CA00SB_BL-30', 4, 'SIZE_29', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(644, 24, 'ESBI00602CA00SB_BL-31', 4, 'SIZE_31', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(645, 24, 'ESBI00602CA00SB_BL-32', 4, 'SIZE_32', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(646, 24, 'ESBI00602CA00SB_BL-33', 4, 'SIZE_33', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(647, 24, 'ESBI00602CA00SB_NV-29', 33, 'SIZE_29', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(648, 24, 'ESBI00602CA00SB_NV-30', 33, 'SIZE_30', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(649, 24, 'ESBI00602CA00SB_NV-31', 33, 'SIZE_31', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(650, 24, 'ESBI00602CA00SB_NV-32', 33, 'SIZE_32', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(651, 24, 'ESBI00602CA00SB_NV-33', 33, 'SIZE_33', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(652, 24, 'ESBI00602CA00SB_LG-29', 27, 'SIZE_29', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(653, 24, 'ESBI00602CA00SB_LG-30', 27, 'SIZE_30', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(654, 24, 'ESBI00602CA00SB_LG-31', 27, 'SIZE_31', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(655, 24, 'ESBI00602CA00SB_LG-32', 27, 'SIZE_32', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(656, 24, 'ESBI00602CA00SB_LG-33', 27, 'SIZE_33', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(657, 24, 'ESBI00602CA00SB_CR-29', 9, 'SIZE_29', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(658, 24, 'ESBI00602CA00SB_CR-30', 9, 'SIZE_30', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(659, 24, 'ESBI00602CA00SB_CR-31', 9, 'SIZE_31', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(660, 24, 'ESBI00602CA00SB_CR-32', 9, 'SIZE_32', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(661, 24, 'ESBI00602CA00SB_CR-33', 9, 'SIZE_33', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(662, 24, 'ESBI00602CA00SB_WH-29', 40, 'SIZE_29', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(663, 24, 'ESBI00602CA00SB_WH-30', 40, 'SIZE_30', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(664, 24, 'ESBI00602CA00SB_WH-31', 40, 'SIZE_31', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(665, 24, 'ESBI00602CA00SB_WH-32', 40, 'SIZE_32', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(666, 24, 'ESBI00602CA00SB_WH-33', 40, 'SIZE_33', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(667, 16, 'DWBS01203CV00SB_CN-S', 8, 'SIZE_S', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(668, 16, 'DWBS01203CV00SB_CN-M', 8, 'SIZE_M', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(669, 16, 'DWBS01203CV00SB_CN-L', 8, 'SIZE_L', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(670, 16, 'DWBS01203CV00SB_CN-XL', 8, 'SIZE_XL', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(671, 16, 'DWBS01203CV00SB_DGR-S-S', 13, 'SIZE_S', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(672, 16, 'DWBS01203CV00SB_DGR-M', 13, 'SIZE_M', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(673, 16, 'DWBS01203CV00SB_DGR-L', 13, 'SIZE_L', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(674, 16, 'DWBS01203CV00SB_DGR-XL', 13, 'SIZE_XL', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(675, 16, 'DWBS01203CV00SB_NV-S', 33, 'SIZE_S', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(676, 16, 'DWBS01203CV00SB_NV-M', 33, 'SIZE_M', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(677, 16, 'DWBS01203CV00SB_NV-L', 33, 'SIZE_L', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(678, 16, 'DWBS01203CV00SB_NV-XL', 33, 'SIZE_XL', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(679, 67, 'EWCW00751PE00SB_LG-S', 27, 'SIZE_S', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(680, 67, 'EWCW00751PE00SB_LG-M', 27, 'SIZE_M', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(681, 67, 'EWCW00751PE00SB_LG-L', 27, 'SIZE_L', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(682, 67, 'EWCW00751PE00SB_LG-XL', 27, 'SIZE_XL', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(683, 67, 'EWCW00751PE00SB_NV-S', 33, 'SIZE_S', 0, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(684, 67, 'EWCW00751PE00SB_NV-M', 33, 'SIZE_M', 0, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(685, 67, 'EWCW00751PE00SB_NV-L', 33, 'SIZE_L', 0, b'1', '2024-05-14 10:47:45', '2024-08-07 13:04:10'),
(686, 67, 'EWCW00751PE00SB_NV-XL', 33, 'SIZE_XL', 0, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(687, 67, 'EWCW00751PE00SB_BL-S', 4, 'SIZE_S', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(688, 67, 'EWCW00751PE00SB_BL-M', 4, 'SIZE_M', 0, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(689, 67, 'EWCW00751PE00SB_BL-L', 4, 'SIZE_L', 0, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(690, 67, 'EWCW00751PE00SB_BL-XL', 4, 'SIZE_XL', 0, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(691, 17, 'DWCT00161PE00RB_NV-S', 33, 'SIZE_S', 996, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(692, 17, 'DWCT00161PE00RB_NV-M', 33, 'SIZE_M', 998, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(693, 17, 'DWCT00161PE00RB_NV-L', 33, 'SIZE_L', 0, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(694, 17, 'DWCT00161PE00RB_NV-XL', 33, 'SIZE_XL', 0, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(695, 17, 'DWCT00161PE00RB_DGR-M', 14, 'SIZE_M', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(696, 17, 'DWCT00161PE00RB_DGR-S', 14, 'SIZE_S', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(697, 18, 'DWCT00431PE32SB_BL-S', 4, 'SIZE_S', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(698, 18, 'DWCT00431PE32SB_BL-M', 4, 'SIZE_M', 0, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(699, 18, 'DWCT00431PE32SB_BL-L', 4, 'SIZE_L', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(700, 18, 'DWCT00431PE32SB_BL-XL', 4, 'SIZE_XL', 996, b'1', '2024-05-14 10:47:45', '2024-08-08 15:38:12'),
(701, 18, 'DWCT00431PE32SB_WH-S', 40, 'SIZE_S', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(702, 18, 'DWCT00431PE32SB_WH-M', 40, 'SIZE_M', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(703, 18, 'DWCT00431PE32SB_WH-L', 40, 'SIZE_L', 998, b'1', '2024-05-14 10:47:45', '2024-08-08 15:24:14'),
(704, 18, 'DWCT00431PE32SB_WH-XL', 40, 'SIZE_XL', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(705, 19, 'DWCU00761PE32SB_ENV-M', 17, 'SIZE_M', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(706, 19, 'DWCU00761PE32SB_ENV-S', 17, 'SIZE_S', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(707, 19, 'DWCU00761PE32SB_ENV-L', 17, 'SIZE_L', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(708, 19, 'DWCU00761PE32SB_ENV-XL', 17, 'SIZE_XL', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(709, 19, 'DWCU00761PE32SB_LLG-S', 30, 'SIZE_S', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(710, 19, 'DWCU00761PE32SB_LLG-M', 30, 'SIZE_M', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(711, 19, 'DWCU00761PE32SB_LLG-L', 30, 'SIZE_L', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(712, 19, 'DWCU00761PE32SB_LLG-XXL', 30, 'SIZE_XL', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(713, 65, 'EWCL00361PE00RB_CR-S', 9, 'SIZE_S', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(714, 65, 'EWCL00361PE00RB_CR-M', 9, 'SIZE_M', 0, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(715, 65, 'EWCL00361PE00RB_CR-L', 9, 'SIZE_L', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(716, 65, 'EWCL00361PE00RB_CR-XL', 9, 'SIZE_XL', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(717, 66, 'EWCP00251PE00SB_LG-S', 27, 'SIZE_S', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(718, 66, 'EWCP00251PE00SB_LG-M', 27, 'SIZE_M', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(719, 66, 'EWCP00251PE00SB_LG-L', 27, 'SIZE_L', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(720, 66, 'EWCP00251PE00SB_LG-XL', 27, 'SIZE_XL', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(721, 66, 'EWCP00251PE00SB_DNV-S', 15, 'SIZE_S', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(722, 66, 'EWCP00251PE00SB_DNV-M', 15, 'SIZE_M', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(723, 66, 'EWCP00251PE00SB_DNV-L', 15, 'SIZE_L', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(724, 66, 'EWCP00251PE00SB_DNV-XL', 15, 'SIZE_XL', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(725, 66, 'EWCP00251PE00SB_LBE-S', 23, 'SIZE_S', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(726, 66, 'EWCP00251PE00SB_LBE-M', 23, 'SIZE_M', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(727, 66, 'EWCP00251PE00SB_LBE-L', 23, 'SIZE_L', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(728, 66, 'EWCP00251PE00SB_LBE-XL', 23, 'SIZE_XL', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(729, 64, 'EWBS00103TC00RB_BL-S', 4, 'SIZE_S', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(730, 64, 'EWBS00103TC00RB_BL-M', 4, 'SIZE_M', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(731, 64, 'EWBS00103TC00RB_BL-L', 4, 'SIZE_L', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(732, 64, 'EWBS00103TC00RB_BL-XL', 4, 'SIZE_XL', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(733, 64, 'EWBS00103TC00RB_BE-S', 3, 'SIZE_S', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(734, 64, 'EWBS00103TC00RB_BE-M', 3, 'SIZE_M', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(735, 64, 'EWBS00103TC00RB_BE-L', 3, 'SIZE_L', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(736, 64, 'EWBS00103TC00RB_BE-XL', 3, 'SIZE_XL', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(737, 64, 'EWBS00103TC00RB_LG-S', 27, 'SIZE_S', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(738, 64, 'EWBS00103TC00RB_LG-M', 27, 'SIZE_M', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(739, 64, 'EWBS00103TC00RB_LG-L', 27, 'SIZE_L', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(740, 64, 'EWBS00103TC00RB_LG-XL', 27, 'SIZE_XL', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(744, 69, 'EWTW00311TC00RB_BL-S', 4, 'SIZE_S', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(745, 69, 'EWTW00311TC00RB_BL-M', 4, 'SIZE_M', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(746, 69, 'EWTW00311TC00RB_BL-L', 4, 'SIZE_L', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(747, 69, 'EWTW00311TC00RB_BL-XL', 4, 'SIZE_XL', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(748, 69, 'EWTW00311TC00RB_BE-L', 3, 'SIZE_S', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(749, 69, 'EWTW00311TC00RB_BE-S', 3, 'SIZE_S', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(750, 69, 'EWTW00311TC00RB_BE-M', 3, 'SIZE_M', 0, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(751, 69, 'EWTW00311TC00RB_BE-XL', 3, 'SIZE_XL', 0, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(752, 69, 'EWTW00311TC00RB_BE-XXL', 3, 'SIZE_XXL', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(753, 69, 'EWTW00311TC00RB_BL-XXL', 4, 'SIZE_XXL', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(754, 69, 'EWTW00311TC00RB_LG-M', 27, 'SIZE_M', 0, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(755, 69, 'EWTW00311TC00RB_LG-L', 27, 'SIZE_L', 0, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(756, 69, 'EWTW00311TC00RB_LG-S', 27, 'SIZE_S', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(757, 69, 'EWTW00311TC00RB_LG-XL', 27, 'SIZE_XL', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(758, 69, 'EWTW00311TC00RB_LG-XXL', 27, 'SIZE_XXL', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(759, 68, 'EWTE00311AC08SB_NV-M', 33, 'SIZE_M', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(760, 68, 'EWTE00311AC08SB_NV-S', 33, 'SIZE_S', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(761, 68, 'EWTE00311AC08SB_NV-L', 33, 'SIZE_L', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(762, 68, 'EWTE00311AC08SB_NV-XL', 33, 'SIZE_XL', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(763, 68, 'EWTE00311AC08SB_BL-S', 4, 'SIZE_S', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(764, 68, 'EWTE00311AC08SB_BL-M', 4, 'SIZE_M', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(765, 68, 'EWTE00311AC08SB_BL-XL', 4, 'SIZE_XL', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59'),
(766, 68, ' EWTE00311AC08SB_BL-L', 4, 'SIZE_L', 999, b'1', '2024-05-14 10:47:45', '2024-05-16 12:28:59');

-- --------------------------------------------------------

--
-- Cấu trúc đóng vai cho view `sales_sent_view`
-- (See below for the actual view)
--
CREATE TABLE `sales_sent_view` (
`id` double(17,0)
,`total_sales` decimal(41,0)
,`total_invoices` bigint(21)
,`confirmation_date` date
,`created_at` timestamp
,`updated_at` timestamp
);

-- --------------------------------------------------------

--
-- Cấu trúc đóng vai cho view `selling_products`
-- (See below for the actual view)
--
CREATE TABLE `selling_products` (
`id` int(11)
,`product_name` varchar(100)
,`price` int(11)
,`discount_price` int(11)
,`discount_percent` int(11)
,`total_size` int(11)
,`total_color` int(11)
,`image_background` varchar(255)
,`created_at` timestamp
,`updated_at` timestamp
,`total_quantity_sold` decimal(32,0)
,`total_sales` decimal(41,0)
);

-- --------------------------------------------------------

--
-- Cấu trúc cho view `sales_sent_view`
--
DROP TABLE IF EXISTS `sales_sent_view`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `sales_sent_view`  AS SELECT floor(rand() * 1000000000) AS `id`, sum(`id`.`total_price`) AS `total_sales`, count(distinct `i`.`id`) AS `total_invoices`, `i`.`confirmation_date` AS `confirmation_date`, `i`.`created_at` AS `created_at`, `i`.`updated_at` AS `updated_at` FROM (`invoices_detail` `id` join `invoices` `i` on(`id`.`invoice_id` = `i`.`id`)) WHERE `i`.`confirmation_date` is not null GROUP BY `i`.`confirmation_date` ;

-- --------------------------------------------------------

--
-- Cấu trúc cho view `selling_products`
--
DROP TABLE IF EXISTS `selling_products`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `selling_products`  AS SELECT `p`.`id` AS `id`, `p`.`product_name` AS `product_name`, `p`.`price` AS `price`, `p`.`discount_price` AS `discount_price`, `p`.`discount_percent` AS `discount_percent`, `p`.`total_size` AS `total_size`, `p`.`total_color` AS `total_color`, `p`.`image_background` AS `image_background`, `i`.`created_at` AS `created_at`, `i`.`updated_at` AS `updated_at`, coalesce(sum(`id`.`quantity`),0) AS `total_quantity_sold`, coalesce(sum(`id`.`total_price`),0) AS `total_sales` FROM (((`invoices_detail` `id` left join `products_detail` `pd` on(`id`.`product_detail_id` = `pd`.`id`)) left join `products` `p` on(`pd`.`product_id` = `p`.`id`)) left join `invoices` `i` on(`id`.`invoice_id` = `i`.`id`)) WHERE `i`.`invoice_status` = 'SUCCESS' GROUP BY `p`.`product_name` ;

--
-- Chỉ mục cho các bảng đã đổ
--

--
-- Chỉ mục cho bảng `accounts`
--
ALTER TABLE `accounts`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`),
  ADD UNIQUE KEY `phone` (`phone`);

--
-- Chỉ mục cho bảng `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`id`),
  ADD KEY `parent_id` (`parent_id`);

--
-- Chỉ mục cho bảng `colors`
--
ALTER TABLE `colors`
  ADD PRIMARY KEY (`id`);

--
-- Chỉ mục cho bảng `customer_emails`
--
ALTER TABLE `customer_emails`
  ADD PRIMARY KEY (`id`);

--
-- Chỉ mục cho bảng `feedback_customers`
--
ALTER TABLE `feedback_customers`
  ADD PRIMARY KEY (`id`);

--
-- Chỉ mục cho bảng `imgs_product`
--
ALTER TABLE `imgs_product`
  ADD PRIMARY KEY (`id`),
  ADD KEY `product_id` (`product_id`);

--
-- Chỉ mục cho bảng `invoices`
--
ALTER TABLE `invoices`
  ADD PRIMARY KEY (`id`),
  ADD KEY `account_id` (`account_id`);

--
-- Chỉ mục cho bảng `invoices_detail`
--
ALTER TABLE `invoices_detail`
  ADD PRIMARY KEY (`id`),
  ADD KEY `invoice_id` (`invoice_id`),
  ADD KEY `product_detail_id` (`product_detail_id`);

--
-- Chỉ mục cho bảng `invoices_history`
--
ALTER TABLE `invoices_history`
  ADD PRIMARY KEY (`id`);

--
-- Chỉ mục cho bảng `jwt_tokens`
--
ALTER TABLE `jwt_tokens`
  ADD PRIMARY KEY (`id`),
  ADD KEY `account_id` (`account_id`);

--
-- Chỉ mục cho bảng `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`id`),
  ADD KEY `cat_id` (`cat_id`);

--
-- Chỉ mục cho bảng `products_detail`
--
ALTER TABLE `products_detail`
  ADD PRIMARY KEY (`id`),
  ADD KEY `product_id` (`product_id`),
  ADD KEY `color_id` (`color_id`);

--
-- AUTO_INCREMENT cho các bảng đã đổ
--

--
-- AUTO_INCREMENT cho bảng `accounts`
--
ALTER TABLE `accounts`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=37;

--
-- AUTO_INCREMENT cho bảng `categories`
--
ALTER TABLE `categories`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=135;

--
-- AUTO_INCREMENT cho bảng `colors`
--
ALTER TABLE `colors`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=43;

--
-- AUTO_INCREMENT cho bảng `customer_emails`
--
ALTER TABLE `customer_emails`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT cho bảng `feedback_customers`
--
ALTER TABLE `feedback_customers`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT cho bảng `imgs_product`
--
ALTER TABLE `imgs_product`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=722;

--
-- AUTO_INCREMENT cho bảng `invoices`
--
ALTER TABLE `invoices`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=237;

--
-- AUTO_INCREMENT cho bảng `invoices_detail`
--
ALTER TABLE `invoices_detail`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=654;

--
-- AUTO_INCREMENT cho bảng `invoices_history`
--
ALTER TABLE `invoices_history`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=969;

--
-- AUTO_INCREMENT cho bảng `jwt_tokens`
--
ALTER TABLE `jwt_tokens`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=554;

--
-- AUTO_INCREMENT cho bảng `products`
--
ALTER TABLE `products`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=81;

--
-- AUTO_INCREMENT cho bảng `products_detail`
--
ALTER TABLE `products_detail`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=822;

--
-- Các ràng buộc cho các bảng đã đổ
--

--
-- Các ràng buộc cho bảng `categories`
--
ALTER TABLE `categories`
  ADD CONSTRAINT `categories_ibfk_1` FOREIGN KEY (`parent_id`) REFERENCES `categories` (`id`);

--
-- Các ràng buộc cho bảng `imgs_product`
--
ALTER TABLE `imgs_product`
  ADD CONSTRAINT `imgs_product_ibfk_1` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`);

--
-- Các ràng buộc cho bảng `invoices`
--
ALTER TABLE `invoices`
  ADD CONSTRAINT `invoices_ibfk_1` FOREIGN KEY (`account_id`) REFERENCES `accounts` (`id`);

--
-- Các ràng buộc cho bảng `invoices_detail`
--
ALTER TABLE `invoices_detail`
  ADD CONSTRAINT `invoices_detail_ibfk_1` FOREIGN KEY (`invoice_id`) REFERENCES `invoices` (`id`),
  ADD CONSTRAINT `invoices_detail_ibfk_2` FOREIGN KEY (`product_detail_id`) REFERENCES `products_detail` (`id`);

--
-- Các ràng buộc cho bảng `jwt_tokens`
--
ALTER TABLE `jwt_tokens`
  ADD CONSTRAINT `jwt_tokens_ibfk_1` FOREIGN KEY (`account_id`) REFERENCES `accounts` (`id`);

--
-- Các ràng buộc cho bảng `products`
--
ALTER TABLE `products`
  ADD CONSTRAINT `products_ibfk_1` FOREIGN KEY (`cat_id`) REFERENCES `categories` (`id`);

--
-- Các ràng buộc cho bảng `products_detail`
--
ALTER TABLE `products_detail`
  ADD CONSTRAINT `products_detail_ibfk_1` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`),
  ADD CONSTRAINT `products_detail_ibfk_2` FOREIGN KEY (`color_id`) REFERENCES `colors` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

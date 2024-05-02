-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Máy chủ: 127.0.0.1
-- Thời gian đã tạo: Th4 29, 2024 lúc 01:36 PM
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

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `accounts`
--

CREATE TABLE `accounts` (
  `account_id` int(11) NOT NULL,
  `username` varchar(50) NOT NULL,
  `password` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `email` varchar(55) NOT NULL,
  `phone` varchar(55) NOT NULL,
  `address` varchar(255) NOT NULL,
  `role` varchar(15) NOT NULL,
  `enabled` bit(1) NOT NULL DEFAULT b'1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `accounts`
--

INSERT INTO `accounts` (`account_id`, `username`, `password`, `name`, `email`, `phone`, `address`, `role`, `enabled`) VALUES
(1, 'quanly', '$2a$10$WzsM01uig9/kwbSzenxYXuh9Vcs3VJrB4.CRgsinAsvq7PVRUIZ/e', 'quang anh', 'quanganhnguyen100196@gmail.com', '0364100196', 'h', 'ROLE_MANAGER', b'1'),
(2, 'nhanvien1', '$2a$10$cIsfc/R8PIsJWzbgolJRheAfJ7hK9hxwxxpqplMP4CSlTBJhcoMk.', 'nhanvien1', 'nhanvien1@gmail.com', '0365151822', 'hanoi', 'ROLE_EMPLOYEE', b'1'),
(4, 'nhanvien2', '$2a$10$5D2B5O4CmS5RN4VxaTwJXOi9B83aa0lGwWy.sICls9O3LKRgNXyDm', 'quanganh', 'nhanvien2@gmail.com', '0364421123', 'hanoi', 'ROLE_EMPLOYEE', b'1'),
(8, 'nhanvien3', '$2a$10$Eh581hpIm67HRwTrHJDpi.iNlHtcbYIBOy313HikKSFJQ4BUPycNu', 'nhanvien3', 'nhanvien3@gmail.com', '0312646431', 'hanoi', 'ROLE_EMPLOYEE', b'1'),
(14, 'khachhang', '$2a$10$txuPDKVLcA7VGk5x9L8NfuLd2GcUeNAxRzZGl/pWgQl.LpFdcA8QK', 'khách hàng', 'khachhang@gmail.com', '0364431132', 'hanoi', 'ROLE_CUSTOMER', b'1'),
(27, 'test', '$2a$10$XxAI/.unxYZtuYaCUmSQyucyMCSLjzzi82.XSyVlY/Rz2jd2IS/q6', 'name', 'test2@gmail.com', '012345789', 'test', 'ROLE_CUSTOMER', b'1');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `categories`
--

CREATE TABLE `categories` (
  `cat_id` varchar(10) NOT NULL,
  `cat_name` varchar(30) DEFAULT NULL,
  `parent_id` varchar(10) DEFAULT NULL,
  `cat_background` varchar(255) DEFAULT NULL,
  `is_cat_active` bit(1) NOT NULL DEFAULT b'1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `categories`
--

INSERT INTO `categories` (`cat_id`, `cat_name`, `parent_id`, `cat_background`, `is_cat_active`) VALUES
('AK', 'Áo khoác', 'AO', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711887062/trmwzjbstkhva5q3s12g.jpg', b'1'),
('AKBB', 'Áo khoác Bomber', 'AK', NULL, b'1'),
('AKCC', 'Áo khoác cổ cao', 'AK', NULL, b'1'),
('AKG', 'Áo khoác gió', 'AK', NULL, b'1'),
('AKP', 'Áo khoác phao', 'AK', NULL, b'1'),
('ALK', 'Áo len kẻ', 'ANL', NULL, b'1'),
('ALT', 'Áo len trơn', 'ANL', NULL, b'1'),
('ANK', 'Áo nỉ kẻ', 'ANL', NULL, b'1'),
('ANL', 'Áo nỉ - len', 'AO', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711887116/qasfi8lttpdvyvgmolah.webp', b'1'),
('ANT', 'Áo nỉ trơn', 'ANL', NULL, b'1'),
('AO', 'Áo nam', NULL, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711889153/vsxicuhzwi7pnbttle2w.webp', b'1'),
('BN', 'Bộ nỉ', 'SET', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711887418/zisn6ikfcajpyoqvwits.webp', b'1'),
('PLBK', 'Polo Bo Kẻ', 'POLO', 'no_image.jpg', b'1'),
('PLCP', 'Polo can phối', 'POLO', 'no_image.jpg', b'1'),
('PLHT', 'Polo họa tiết', 'POLO', '1707659794400_home_category_7_img.jpg', b'1'),
('PLK', 'Polo kẻ', 'POLO', 'no_image.jpg', b'1'),
('PLT', 'Polo trơn', 'POLO', 'no_image.jpg', b'1'),
('POLO', 'Áo polo', 'AO', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711887135/ikfhqgyc649ojjh98kwr.webp', b'1'),
('QA', 'Quần âu', 'QUAN', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711887256/ubsonyurdhhfwczmykoy.webp', b'1'),
('QAPTC', 'Quần âu phối thun cạp', 'QA', 'no_image.jpg', b'1'),
('QDK', 'Quần dài kaki', 'QUAN', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711887282/etuppqbnkbxufsqmy7el.jpg', b'1'),
('QJ', 'Quần jeans', 'QUAN', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711887311/d3eqcj37abqwnwv4dmvu.webp', b'1'),
('QJB', 'Quần jeans basic', 'QJ', 'no_image.jpg', b'1'),
('QJR', 'Quần jeans rách', 'QJ', 'no_image.jpg', b'1'),
('QKB', 'Quần kaki basic', 'QDK', 'no_image.jpg', b'1'),
('QN', 'Quần nỉ', 'QUAN', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711887352/x23rz8v9cqdaadztvexs.webp', b'1'),
('QS', 'Quần short', 'QUAN', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711887380/x9muxebcf9z8xa4naqte.webp', b'1'),
('QUAN', 'Quần nam', NULL, 'no_image.jpg', b'1'),
('SD', 'Short đũi', 'QS', 'no_image.jpg', b'1'),
('SET', 'Set', NULL, '1707658980103_home_category_2_img.jpg', b'1'),
('SG', 'Short gió', 'QS', 'no_image.jpg', b'1'),
('SKK', 'Short kaki', 'QS', 'no_image.jpg', b'1'),
('SM', 'Sơ mi', 'AO', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711887158/qrazso5enu9rfz1zrwze.webp', b'1'),
('SMD', 'Sơ mi đũi', 'SM', NULL, b'1'),
('SMDM', 'Sơ mi Demin', 'SM', NULL, b'1'),
('SMHT', 'Sơ mi họa tiết', 'SMD', NULL, b'1'),
('SMK', 'Sơ mi kẻ', 'SM', NULL, b'1'),
('SMT', 'Sơ mi trơn', 'SM', NULL, b'1'),
('test2', 'test2', NULL, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1713974194/x9kpqj3bmxayzm2f8sq3.jpg', b'1'),
('THUN', 'Áo thun', 'AO', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711887206/weftgxxcytuuh11xtpj8.webp', b'1'),
('TIH', 'Thun in hình', 'THUN', NULL, b'1'),
('TT', 'Tank top', 'THUN', NULL, b'1');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `colors`
--

CREATE TABLE `colors` (
  `color_id` varchar(5) NOT NULL,
  `name` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `colors`
--

INSERT INTO `colors` (`color_id`, `name`) VALUES
('BBR', 'Phối đen-nâu'),
('BCR', 'Phối xanh đá đậm - kem đậm'),
('BE', 'Màu be'),
('BL', 'Màu đen'),
('BLE', 'Phối đen-be'),
('BR', 'Nâu'),
('BU', 'Xanh da trời'),
('CN', 'Xanh cổ vịt'),
('CR', 'Trắng kem'),
('DBU', 'Xanh da trời đậm'),
('DCB', 'Xanh đã đậm'),
('DCR', 'Trắng - kem đậm'),
('DGN', 'Xanh lá cây đậm'),
('DGR', 'Xám đậm'),
('DNV', 'Dark Navy'),
('DTU', 'Xanh ngọc đậm'),
('ENV', 'Phối Be - Navy'),
('GN', 'Xanh lá cây'),
('GR', 'Xám'),
('HBR', 'Phối nâu trắng'),
('HCR', 'Phối kem đậm - trắng'),
('LB', 'Xanh da trời nhạt'),
('LBE', 'Be nhạt'),
('LBL', 'Đen nhạt'),
('LCB', 'Xanh đá nhạt'),
('LCR', 'Trắng kem nhạt'),
('LG', 'Xám Nhạt'),
('LI', 'Tím phớt'),
('LLB', 'Xanh da trời phai'),
('LLG', 'Phối đen - xám nhạt'),
('LYL', 'Vàng nhạt'),
('NBX', 'Phối navy - Đỏ đô'),
('NV', 'Xanh navy'),
('NVC', 'Phối kem navi'),
('NWH', 'Phối Navy-trắng'),
('TU', 'Xanh ngọc'),
('VCB', 'Phối xanh đá - navy'),
('WBL', 'Phối trắng-đen'),
('WCB', 'Phối Trắng - Xanh đá'),
('WH', 'Trắng'),
('WNV', 'Phối trắng-xanh navy');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `imgs_product`
--

CREATE TABLE `imgs_product` (
  `img_id` int(11) NOT NULL,
  `product_id` varchar(15) DEFAULT NULL,
  `file_img` varchar(250) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `imgs_product`
--

INSERT INTO `imgs_product` (`img_id`, `product_id`, `file_img`) VALUES
(3, 'ESTP038', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811636/tp038-1.jpeg.webp'),
(4, 'ESTP038', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811639/tp038.jpeg.webp'),
(5, 'ESTP038', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811634/tp038-41.jpeg.webp'),
(6, 'ESTP038', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811631/tp038-42.jpeg.webp'),
(7, 'ESTP038', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811628/tp038-43.jpeg.webp'),
(8, 'ESTP038', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811625/tp038-44.jpeg.webp'),
(9, 'ESTP038', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811622/tp038-45.jpeg.webp'),
(10, 'ESTP067', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811574/tp067---bk004-_16__bc6a55b32ddb4d94bc5c0fa5a7997db4_master.jpg.webp'),
(11, 'ESTP067', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811577/tp067---bk004-_13__eb790ac8d5dd44618429783c9ed42844_master.jpg.webp'),
(12, 'ESTP067', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811602/52867073164_c93edc6a70_k_9447f869422f4aa793f65556da2f944c_master.jpg.jpg'),
(13, 'ESTP067', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811613/52866332867_b3e9385404_k_e7aa9db13469468e86586673d414a1f3_master.jpg.jpg'),
(14, 'ESTP067', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811582/52867351953_9e3e03f2b1_k_096de1bcfee34099969d0edd7b8e6f26_master.jpg.jpg'),
(15, 'ESTP067', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811616/52866332727_2f58586473_k_7ac15a1978a04a37a6713af0bab43b09_master.jpg.jpg'),
(16, 'ESTP067', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811599/52867351793_7fdd444ee2_k_4c9345e571394a009fa0e3e68e76a451_master.jpg.jpg'),
(17, 'ESTP067', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811596/52867351808_e5a4600839_k_f877288ddfab4de6b74713bccd8dc336_master.jpg.jpg'),
(18, 'ESTP067', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811620/52866332657_414108a7c6_k_b4b4ef2544e94d1c9e65de3dc7f57209_master.jpg.jpg'),
(19, 'ESTP067', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811592/52867351903_e8df6368ea_k_93703527ed854f82a3c46db0c674704c_master.jpg.jpg'),
(20, 'ESTP067', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811589/52867351913_203d16cda4_k_d6e60d7f209d4832b26a4e9044b8af9e_master.jpg.jpg'),
(21, 'ESTP067', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811586/52867351923_7cae731772_k_c20306b870404071b12dad2f38d0d093_master.jpg.jpg'),
(22, 'ESTP028', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811570/tp028---bk004-_11__9246a1d8b0184518abd852704bd4fa02_master.jpg.webp'),
(28, 'ESTP067', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811560/4_8fb2c95d0ce84becbb58fd9ed237ba08_master.jpg.jpg'),
(29, 'ESTP067', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811558/6_6839924c418d47e183d08e255b8c3c63_master.jpg.jpg'),
(30, 'ESTP067', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811557/52789526191_861fe9d52b_o_21ebcee1355d4c3dad77e7d3c1ff0d4c_master.jpg.jpg'),
(31, 'DSTP611', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811554/tp611_59ea616328234a9b969ce2d1c48c482f_master.jpg.webp'),
(32, 'DSTP611', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811551/tp611-1_e64e507a26034c7cab4000647d260ede_master.jpg.webp'),
(33, 'DSTP611', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811549/1_1e206b362a714f3d98754a060ce09454_master.jpg.jpg'),
(34, 'DSTP611', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811547/3_4dd89c6d76d54a4d96db9ec8d1ab1e93_master.jpg.jpg'),
(41, 'ESTP010', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811545/tp010---bk603-_8__b6487398009b4c6eaa1950ee0f26e718_master.jpg.webp'),
(42, 'ESTP010', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811543/tp010---bk603-_18__182eb99ee71a46a381827867ad2a96de_master.jpg.webp'),
(43, 'ESTP010', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811540/52769491109_e6fb49f9f0_o_32455b99bcaf4082aa9cd70b23af5f9e_master.jpg.webp'),
(44, 'ESTP010', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811537/52769491159_ba17744c21_o_9ef26ec3123b4c97aab4ab0e25cba4d5_master.jpg.webp'),
(45, 'ESTP010', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811533/52769491004_ecb5666549_o_219d2b308f9e43a6a1afbbb5fe2bd5b9_master.jpg.webp'),
(46, 'ESTP010', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811530/52769490734_e7c5ff8fef_o_e395740c9186424989fac889b1c7d4f7_master.jpg.webp'),
(47, 'ESTP032', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811526/estp032-3_f94042405af64ca581ca72c753b53b51_master.jpg.webp'),
(48, 'ESTP032', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811523/estp032-3_5833a48d93d041fab7b4a56668a78262_master.jpg.webp'),
(49, 'ESTP032', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811520/estp032-1_86750080b9b3454bb7b35f79c996f898_master.jpg.webp'),
(50, 'ESTP032', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811517/estp032-2_c5486330b45845dd9e4e9dd652d9fe51_master.jpg.webp'),
(51, 'ESTP032', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811514/estp032-3_52866931581_o_696a4be7241646908451a50a1ab3ec7c_master.jpg.webp'),
(52, 'ESTP032', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811510/estp032-4_52866931551_o_a66d94b2046f471d8bfb1bf8342400c9_master.jpg.jpg'),
(53, 'ESTP032', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811507/estp032-5_52867320575_o_3c67b3a8e6f74535aa323e0926391185_master.jpg.jpg'),
(54, 'ESTP032', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811503/estp032-11_52866355737_o_a52dd32e7b96416ab120276b6d4403e4_master.jpg.webp'),
(55, 'ESTP032', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811500/1_50f16dbd5df34aa3acc99865b4820084_master.jpg.webp'),
(56, 'ESTP032', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811498/2_5933a603e4074662bfe7cc6b5fe1e44b_master.jpg.webp'),
(57, 'ESTP032', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811496/3_e2f6d02236ac4e0397a15b372c85bfb2_master.jpg.webp'),
(58, 'ESTP032', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811494/4_aaa0fd53411a441e85605a458aab67f7_master.jpg.webp'),
(62, 'ESTP005', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811485/tp005_52e371ed726e4f2d8401d86c5e0b38fb_master.jpg.webp'),
(63, 'ESTP005', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811483/tp005-1_540fc6869412410498fde0786b1e4ae5_master.jpg.jpg'),
(64, 'ESTP005', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811480/52826115451_f0f0e4aba3_o_1e2aaae876504b3781a5bf9eaa3e8649_master.jpg.jpg'),
(65, 'ESTP005', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811477/estp005_52832929942_o_1fa1849607d14981bf7a289fa35bca7e_master.jpg.jpg'),
(66, 'ESTP005', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811468/estp005_52832930232_o_c2dc6fe645224bbdace38aee17ba4ebc_master.jpg.jpg'),
(67, 'ESTP005', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811464/estp005_52833497146_o_19f6e6d8b44947d4bcd7461012e1e40d_master.jpg.jpg'),
(68, 'ESTP041', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811461/estp041-16_4cb9d42d84e7436884bd3f4e648621ed_master.jpg.webp'),
(69, 'ESTP041', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811459/estp041-12_f4f5deac05fa47789c5897ba7a06818f_master.jpg.webp'),
(70, 'ESTP041', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811457/estp041-11_5cc08ee5a7f94d739d935b090e8657ce_master.jpg.jpg'),
(71, 'ESTP041', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811454/estp041-15_0af52441e90e49aebae6f5874f100c2d_master.jpg.webp'),
(72, 'ESTP041', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811452/estp041-13_052acb199d294321a1158807cea0d5b4_master.jpg.webp'),
(73, 'ESTP041', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811450/estp041-14_c216ec36194c4f7da5d099aff22b8316_master.jpg.webp'),
(74, 'ESTP041', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811447/estp041-6_3141cb9f439d4fb0b02a8d09f2d0e836_master.jpg.webp'),
(75, 'ESTP041', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811444/estp041-3_83014782b53841358a80703e3de20b49_master.jpg.webp'),
(76, 'ESTP041', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811441/estp041-7_38c774c7c3f74bfa852ec9fb4923a3de_master.jpg.jpg'),
(77, 'ESTP041', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811433/estp041-9_b544581a872a4d32bb9c8c4ed240c6dd_master.jpg.webp'),
(78, 'ESTP041', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811430/estp041-8_316b7cd7e97744ac925f985863972761_master.jpg.webp'),
(79, 'ESTP041', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811427/estp041-1_6a52d5fd1f594e2b9acee2d830b78b58_master.jpg.webp'),
(80, 'ESTP041', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811424/estp041-2_0fe28f88db44491aa3f4e7ce0daf884e_master.jpg.webp'),
(81, 'ESTP041', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811422/estp041-4_0f2a7f2b52d645dab95a9cdd5fdee0f3_master.jpg.webp'),
(82, 'ESTP041', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811420/estp041-5_2d4ac01b779044a4ba9e1e3343e328f9_master.jpg.webp'),
(83, 'ESTP042', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811418/tp042---bk004-_9__2efe604ac9324e06841cf8edc590e169_master.jpg.webp'),
(84, 'ESTP042', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811415/tp042---bk004-_12__0fc56a3426f74ac79d1f10f9ab0b2fde_master.jpg.jpg'),
(85, 'ESTP042', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811412/estp042-br-4_52866363897_o_4cea7101361d4aeda23916a73776bc89_master.jpg.jpg'),
(86, 'ESTP042', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811409/estp042-br-5_52866363922_o_3b22baf5d6c540749f0eae1b143090b6_master.jpg.jpg'),
(87, 'ESTP042', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811404/estp042-br-1_52867103974_o_cfe354dcf6f54ba0b8a85cd45a0948a7_master.jpg.jpg'),
(88, 'ESTP042', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811399/estp042-br-2_52867382413_o_baf78a07a1e84447a3f01c49f2a55146_master.jpg.jpg'),
(89, 'ESTP042', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811395/estp042-br-3_52867103924_o_82a3a7e6860f480e91b11f3a5e7e18ed_master.jpg.jpg'),
(90, 'ESTP042', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811387/estp042-1_52867104114_o_aff74874616b45889ded6a949e0a1eb9_master.jpg.jpg'),
(91, 'ESTP042', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811384/estp042-bl-2_52867328655_o_55af013d6db2478fb8002da234a249d3_master.jpg.jpg'),
(92, 'ESTP042', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811380/estp042-cr-2_52867383288_o_cfa01925fc274a748e611e45bc874487_master.jpg.jpg'),
(93, 'ESTP042', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811377/estp042-dtu-2_52867383188_o_19e01fc82fca404e9629f3eff9993e76_master.jpg.jpg'),
(94, 'ESTP042', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811374/estp042-li-4_52866364592_o_4a615385ee834290ba6df68a2ed69311_master.jpg.jpg'),
(95, 'ESTP042', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811370/estp042-lyl-2_52867329090_o_51fd4f8cbbbf49f7890af4a9829581fb_master.jpg.jpg'),
(96, 'ESTP042', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811360/estp042-nv-3_52867104354_o_0580916685074dcdafdd251732674e2a_master.jpg.jpg'),
(97, 'ESTP042', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811357/estp042-tu-2_52866939911_o_96bd77d6c720444f86e520f606c880be_master.jpg.jpg'),
(98, 'ESTP042', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811354/estp042-wh-2_52867104164_o_0190b878eb0240c7bdc957655d380cbf_master.jpg.jpg'),
(99, 'ESTP033', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811351/m1t1_9a04e0331596472281861b7f44cc3ca2_master.jpg.webp'),
(100, 'ESTP033', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811349/2_9f21c1bc2bb4483aa055ffb7356ecf2b_master.jpg.jpg'),
(101, 'ESTP033', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811346/3_13e212d45d7d4bf0969316de7ea60043_master.jpg.jpg'),
(102, 'ESTP033', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811344/4_f4b074268aae494a83ba8ae43ff8ab3d_master.jpg.jpg'),
(103, 'ESTP033', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811341/5_b213c588677e4d9bb736c832971db86b_master.jpg.jpg'),
(114, 'ESTP001', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811339/estp001-2_ca463de5f50243ff920007e6314ac0eb_master.jpg.webp'),
(115, 'ESTP001', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811337/estp001-3_af8e67d349a34ea2857b8f923538bfba_master.jpg.webp'),
(116, 'ESTP001', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811335/estp001-1_e79f5d2eed6b4d15be9136100b48c52e_master.jpg.webp'),
(117, 'ESTP001', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811333/2_03d7f4c5170c475ab303f4a1a35f7772_master.jpg.jpg'),
(118, 'ESTP001', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811331/3_d899896ff01a4adeb430b83c94dc2483_master.jpg.jpg'),
(119, 'ESTP001', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811329/4_fe228fc01afa43a082ef4bda0d636e20_master.jpg.jpg'),
(120, 'ESTP001', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811327/7_9bc29d0a14064c70aca802cc201f2750_master.jpg.webp'),
(121, 'ESTP060', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811325/3_a6cdb2c46dd543fd9507418aef06c558_master.jpg.webp'),
(122, 'ESTP060', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811322/2_d527cf7f226e40c9bdf647d7cfcdb73d_master.jpg.jpg'),
(123, 'ESTP060', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811320/52951329992_50ac43f695_o_0d0d415fa295462dbb496e1cda501bad_master.jpg.jpg'),
(124, 'ESTP060', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811317/estp060-1_eb469e85967d44e3a36e4dc8ca9ae0ea_master.jpg.jpg'),
(125, 'ESTP060', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811314/estp060-4_3fbb20aa4c1b4ff1b054225ad070a6f9_master.jpg.jpg'),
(126, 'ESTP060', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811310/estp060-2_322d5e5eab9a4de399752a3783025240_master.jpg.jpg'),
(127, 'ESTP060', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811307/estp060-3_326826ec287a49b58f66324c764a15fe_master.jpg.jpg'),
(142, 'ESTP007', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811304/estp007-1_9cd4cd6e34ac4041bb7e96da2d1eeb22_master.jpg.webp'),
(143, 'ESTP007', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811301/tp007---bj901-_19__77bda55d7cb8490981e89a43f2accbb2_master.jpg.webp'),
(144, 'ESTP007', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811299/52898691552_37ea5079d3_o_ebb2277a32594cc7b1e9e4a218be9e8b_master.jpg.jpg'),
(145, 'ESTP007', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811296/52898691577_03b1414605_o_b27a16af3124429d86bf5da8f0cf0a0c_master.jpg.webp'),
(146, 'ESTP007', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811293/52899265456_b212798cac_o_9aef58b065eb48c38e1c8ec115b234d9_master.jpg.webp'),
(147, 'ESTP007', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811289/52899713483_5b59788a82_o_46b4209167da44989fbc7a67d156289c_master.jpg.jpg'),
(148, 'ESTP007', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811285/52899660480_41c01903c4_o_5bd3da357e264f1891e47d54d5d3b4ef_master.jpg.webp'),
(149, 'ESTP007', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811282/52898691562_67c82c3ca7_o_9da334afa0244604bf21a0d59cf2a7f2_master.jpg.webp'),
(150, 'ESTP020', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811280/tp020---bk001-_10__b44a6900b6934440ad797f313b2cdd9a_master.jpg.webp'),
(151, 'ESTP020', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811277/tp020---bk001-_19__39c7901d719942a790b6cf8a9584383a_master.jpg.webp'),
(152, 'ESTP020', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811274/estp020-2_52826081331_o_54237fd9c1084a329c27f40c559396b5_master.jpg.webp'),
(153, 'ESTP020', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811271/estp020-3_52826521153_o_065f5c020fe441299ef865b526ad311d_master.jpg.jpg'),
(154, 'ESTP020', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811262/estp020-1_52825506602_o_a115b5ddf53148a08d97e01ff7b86d24_master.jpg.jpg'),
(155, 'ESTP020', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811258/estp020-4_52825506387_o_91c212f08243413dbd963193d05a30e4_master.jpg.webp'),
(168, 'ESTP023', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811255/1_4554a899fc974e40bc58638b060b31ee_master.jpg.webp'),
(169, 'ESTP023', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811253/2_01804471604b4ce29bbd620d5ac8f08f_master.jpg.webp'),
(170, 'ESTP023', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811251/estp023_f704d9ca4a9142c587f3d01d7bf20088_master.jpg.webp'),
(171, 'ESTP023', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811249/estp023-2_e8cc41d54ae748558cbb1fefc99ffa80_master.jpg.webp'),
(172, 'ESTP023', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811245/estp023-3_cbe5abc9a09543df8bcd296c5b941ccf_master.jpg.webp'),
(173, 'ESTP015', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811242/estp015_a0e07e027c614085b06c261c289544ab_master.jpg.webp'),
(174, 'ESTP015', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811240/estp015-1_4850d0b18f664531958be981c80b3849_master.jpg.webp'),
(175, 'ESTP015', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811238/52984839667_2b60bd0a5c_o_3c6abb663b134583890c1f84a05afa34_master.jpg.jpg'),
(176, 'ESTP015', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811230/52985585104_6b4d0aa540_o_5bfd3df1d8074e8b988393d17058d82e_master.jpg.jpg'),
(177, 'ESTP015', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811227/52985814890_0e0f66878b_o_cb9d7e43b07940179e8a0377ef9f4496_master.jpg.jpg'),
(178, 'DSTP903', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811223/dstp903_52866905251_o_735380510ed1481090a9d817d712432b_master.jpg.webp'),
(179, 'DSTP903', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811220/dstp903-5_52899252161_o_fbbfca6789984d79a05a30395baebf8d_master.jpg.webp'),
(180, 'DSTP903', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811217/dstp903_52866328857_o_dcb32e4dd65b4c0692aba155328ae3f1_master.jpg.jpg'),
(181, 'DSTP903', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811213/dstp903_52867348133_o_1a35eb97c32d48aba7cc60754f132f89_master.jpg.jpg'),
(182, 'DSTP903', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811210/dstp903_52867348138_o_89a8c909f5ec431c9f313c754ae9e042_master.jpg.jpg'),
(183, 'DSTP903', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811206/dstp903_52867348178_o_9eaaa6a1c432440b8bc3a8863c2d4699_master.jpg.jpg'),
(184, 'DSTP903', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811196/dstp903-1_52899647210_o_3e4bedccc26c4921bf2d0e26cbd987bd_master.jpg.jpg'),
(185, 'DSTP903', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811203/dstp903-2_52899647325_o_d2a330409f00496ea82d68f220729469_master.jpg.jpg'),
(186, 'DSTP903', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811199/dstp903-3_52899414579_o_48d0f7660d7648f18f998fa3f52cd042_master.jpg.jpg'),
(187, 'DSTP903', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811192/dstp903-4_52899252121_o_ae557b13c3e54659beab9355b85ac6e1_master.jpg.jpg'),
(189, 'ESTP017', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811185/52984841597_c4f0a17882_o_537cdc00b2124e288af5d94002fba114_master.jpg.webp'),
(190, 'ESTP017', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811178/52984841637_be878f2e96_o_b2155ec1c2c6425a94b240f852a798d4_master.jpg.webp'),
(191, 'ESTP017', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811181/52985816615_83d5e68a16_o_a38ee4423e9a4d9e9a719237c6aa6f52_master.jpg.webp'),
(192, 'ESTP017', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811175/52985905053_bdeffa314e_o_aa67bed06deb439399cc2046790f8c59_master.jpg.jpg'),
(193, 'ESTP022', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811171/52901478774_f103d7180e_o_6ec337721b6d4a8bae3c2626bca7d037_master.jpg.webp'),
(194, 'ESTP022', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811169/52900747392_3bd87b9424_o_ef4fd5e38ee643538ccbfa25af4daa72_master.jpg.webp'),
(195, 'ESTP022', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811166/52900747527_b5ba3ab3a3_o_c0e500d9ecf04e648a5b4eadafa8c56d_master.jpg.webp'),
(196, 'ESTP022', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811158/52901708515_30006cf211_o_f3e3d22e5e3e42078feb7d3d311ef24c_master.jpg.webp'),
(197, 'ESTP022', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811154/52901317611_a0acf4ef9f_o_615c31feb98a4e81a2ef903f914370b3_master.jpg.webp'),
(198, 'ESTP022', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811151/52901708410_5a8af79350_o_a64f83bc7f1140c4bcd2cb9dfdcb1882_master.jpg.webp'),
(199, 'ESTP022', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811148/52901708465_503bdb72bc_o_44f82d09c0c549f7b87f0a9fc128200d_master.jpg.webp'),
(200, 'ESTP022', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811144/52901317591_9d166f4fa0_o_15c83e519bbb4b08bc17abc027167bb1_master.jpg.jpg'),
(201, 'ESTP018', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811140/tp018_0691972d076d4071a4fee5291912df9e_master.jpg.webp'),
(202, 'ESTP018', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811137/tp018---bk001-_14__c88cf49e00c3437cbed27b9e9b7e6bbb_master.jpg.webp'),
(203, 'ESTP018', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811135/52826112561_28a33161d2_o_863d94fe95454b768bab5808fcb136fe_master.jpg.webp'),
(204, 'ESTP018', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811129/20230418_utjkznvmqy_2bb5168802fa45a3aa7687b49275558c_master.jpg.webp'),
(205, 'ESTP018', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811126/20230418_zdan7vokau_193adb5ef92d4ff0a9628a7e8087719a_master.jpg.jpg'),
(206, 'ESTP021', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811124/estp021-2_7b1e8ac1a10c4163bf199b7b89332d81_master.jpg.webp'),
(207, 'ESTP021', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811122/52761369041_9f0e67d125_o_9032748cb48b41bc872cef7ab7b26fce_master.jpg.jpg'),
(208, 'ESTP021', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811119/3_a205919edf4d4446a1522a2c10bc383f_master.jpg.jpg'),
(209, 'ESTP021', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811117/4_c8d69e314ed348e4bd9c456f2721a78d_master.jpg.jpg'),
(210, 'ESTP021', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811114/5_1137cf2bb12540fe8f3e15d4b6719363_master.jpg.jpg'),
(221, 'ESTP014', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811112/estp014_f4dabbabbe0346598163050a85b06f1a_master.jpg.webp'),
(222, 'ESTP014', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811110/52963145971_d831ed870e_o_0cb9f3d06fb2434f92c94c572d9f7820_master.jpg.jpg'),
(223, 'ESTP014', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811106/52962545147_25055ccc29_o_af189f39f582417bb4e7d78258ba2afb_master.jpg.jpg'),
(224, 'ESTP014', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811101/52963145991_ed718131ed_o_c94a43b3e7be4f2d955466fc9ad6cafa_master.jpg.jpg'),
(225, 'ESTP014', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811090/52963286319_9f96c02b76_o_777e3a250afb437a834bb46e13a3b849_master.jpg.jpg'),
(226, 'ESTP012', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811086/tp012_0d295f194e3f4f0eab7eede288c3a7c5_master.jpg.webp'),
(227, 'ESTP012', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811084/52962546502_67cf66a988_o_50eedd51b47d489c851da09e2dd4787e_master.jpg.webp'),
(228, 'ESTP012', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811081/52963148566_1522e0b1d5_o_f23c0e6864fc465f8ba86fb4e02f6eca_master.jpg.jpg'),
(229, 'ESTP012', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811077/52963148571_85db89bd29_o_6be3d4ece33747288a86005d9ace3990_master.jpg.jpg'),
(230, 'ESTP012', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811073/52963526080_043a99d427_o_361c1c8965ed4a379649be937138d1a4_master.jpg.jpg'),
(237, 'DSTP650', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811070/tp650---bi801-_7__abbb944d2018481c829e959580b99514_master.jpg.webp'),
(238, 'DSTP650', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811066/tp650---bi801-_17__b30c2c74b038490f890dfec689b60602_master.jpg.webp'),
(239, 'DSTP650', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811064/1_dafd00796d394cdbafeebc27a23aebbe_master.jpg.jpg'),
(240, 'DSTP650', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811062/3_6e830c4790f546dd91780c15c5c3d2df_master.jpg.jpg'),
(241, 'DSTP650', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811059/2_3cd9ac4ea4134a5cb2377036c8858bfd_master.jpg.jpg'),
(242, 'DSTP650', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811057/4_485c2d0480d84e4b983817d401d0c65d_master.jpg.jpg'),
(243, 'ESTP047', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811054/5_66590d1cba6041359e8a89a1c7e0feb5_master.jpg.webp'),
(244, 'ESTP047', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811052/1_eaabf57d435740af8ed20d6f40378045_master.jpg.webp'),
(245, 'ESTP047', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811050/2_25c38d6c27394c258025535e2bc9d5bd_master.jpg.webp'),
(246, 'ESTP047', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811048/6_e4d2cb26997d464985a485cc7f212599_master.jpg.webp'),
(247, 'ESTP047', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811045/4_a52dff1ab14f48e7b978ced85dfb6806_master.jpg.webp'),
(248, 'ESTP047', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811043/estp047-1_1f39491e95314848a3036b88e0bdcc90_master.jpg.webp'),
(249, 'ESTP047', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811040/estp047-2_7378910d66be4c0a8dcc152afcb330e0_master.jpg.webp'),
(254, 'TP004', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811025/tp004_45415f65d7bc4f4c8d52f4893d682a43_master.jpg.webp'),
(255, 'TP004', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811022/tp004-2_572851b755514fa7b302d5120a7d3b94_master.jpg.webp'),
(256, 'TP004', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811019/5_14e1329ad875426cbc7afb776056eeae_master.jpg.jpg'),
(257, 'TP004', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811017/4_4d48bde78a5148fab5623251d0da8e08_master.jpg.jpg'),
(297, 'ESTP074', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810989/1701361255341_10_ab507de1e88747f99527ac4852b40535_master.jpg.jpg'),
(298, 'ESTP074', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810992/1701361255426_9_ae65d9fd2f8f4cfcb114ee123fcffd63_master.jpg.jpg'),
(299, 'ESTP074', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810996/1701361255431_8_62f9c35e209b490fa0012a46b2faada3_master.jpg.jpg'),
(300, 'ESTP074', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810999/1701361255434_7_e37142ddf18d4daa898aac91aa82eb92_master.jpg.jpg'),
(301, 'ESTP074', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811002/1701361255437_6_9622c2cf1ffe49dd9d06ac5ca4d10119_master.jpg.jpg'),
(302, 'ESTP074', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811005/1701361255440_5_5bf4a94b5b19485199441c580dae0f6a_master.jpg.jpg'),
(303, 'ESTP074', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811006/1701361255443_4_aaa0fd53411a441e85605a458aab67f7_master.jpg.webp'),
(304, 'ESTP074', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811009/1701361255445_3_e2f6d02236ac4e0397a15b372c85bfb2_master.jpg.jpg'),
(305, 'ESTP074', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811011/1701361255449_2_5933a603e4074662bfe7cc6b5fe1e44b_master.jpg.webp'),
(306, 'ESTP074', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811013/1701361255452_1_50f16dbd5df34aa3acc99865b4820084_master.jpg.webp'),
(308, 'ESTA010', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810005/1702537484257_esta010-5_2ba1b356efe4495cab57f32d9d25091c_master.jpg.webp'),
(309, 'ESTA010', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810008/1702537484260_esta010-4_270b822eb48441a1a53f5546346ddd40_master.jpg.webp'),
(310, 'ESTA010', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810011/1702537484263_esta010-3_0ba6357a968c46e0affaf07666b9c01b_master.jpg.webp'),
(311, 'ESTA010', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810013/1702537484266_esta010-2_8a537af4aa4444c0aa99eeaca96547da_master.jpg.webp'),
(312, 'ESTA010', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810015/1702537484269_esta010-1_ad9f734ad81a4f339a557960d10dd7f5_master.jpg.webp'),
(313, 'ESTA006', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810978/1702700896436_esta006-4_c514e01db8474d70b33092f7cd99164c_master.jpg.webp'),
(314, 'ESTA006', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810980/1702700896469_esta006-3_4df5bd70d3eb4967ad32074a57d6ba39_master.jpg.webp'),
(315, 'ESTA006', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810983/1702700896473_esta006-2_1c9f30407e6b4054a8e1d8851dcecdab_master.jpg.webp'),
(316, 'ESTA006', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810985/1702700896477_esta006-1_2a8dce82b88d4fd798c0434cf9bed833_master.jpg.webp'),
(317, 'ESTA003', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810963/1702701667209_eata005-2_d7ce58698163437ba1db1dedb9eb6b11_master.jpg.webp'),
(318, 'ESTA003', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810966/1702701667249_eata003-4_3278e31069de4a949432bdb95d84b15a_master.jpg.webp'),
(319, 'ESTA003', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810968/1702701667255_eata003-3_fcd31b6aead047a49d37bd2f4f15e7aa_master.jpg.webp'),
(320, 'ESTA003', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810970/1702701667264_eata003-2_06740cf99ddb4d81a574ea48aa9a34b9_master.jpg.webp'),
(321, 'ESTA003', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810974/1702701667271_eata003-1_c8e90efa55944401946efba4f0ae02bf_master.jpg.webp'),
(322, 'ESTA005', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810950/1702702646779_eata005-6_6c157a33937a44b497592693b64d7feb_master.jpg.webp'),
(323, 'ESTA005', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810953/1702702646814_eata005-5_3cc9485ee40445818e4c67208dcdf9b2_master.jpg.webp'),
(324, 'ESTA005', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810956/1702702646819_eata005-4_4024f1e717604680ace040117d1f362f_master.jpg.webp'),
(325, 'ESTA005', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810958/1702702646824_eata005-3_a2bc7b29fc1b47b6a97348d13ea83f41_master.jpg.webp'),
(326, 'ESTA005', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810961/1702702646831_eata005-2_ef46f711d4734ba6a8be08d07f8f3567_master.jpg.webp'),
(327, 'ESTS040', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810920/1702703208763_ests040-5_52987217372_o_72ea4d648501425a806b5111c47b91b6_master.jpg.webp'),
(328, 'ESTS040', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810923/1702703208771_ests040-4_52987961469_o_c152e6e7afcd4facbd707fb5586bc689_master.jpg.webp'),
(329, 'ESTS040', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810927/1702703208775_ests040-1_52988193050_o_0e50794abc7045348461b2a44f2f7756_master.jpg.webp'),
(330, 'ESTS040', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810930/1702703208778_ests040-3_52988281533_o_ef60746768644df19e5c12428fb5ed6b_master.jpg.webp'),
(331, 'ESTS040', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810934/1702703208781_ests040-4_52985587859_o_bc41df09b2474dc483a02fd152f7d372_master.jpg.webp'),
(332, 'ESTS040', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810937/1702703208783_ests040-3_52985817640_o_8ae0d260d3e2495991ce73334cbc2adc_master.jpg.jpg'),
(333, 'ESTS040', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810944/1702703208788_ests040-2_52985443091_o_82ed730d0f54440a839469648c303994_master.jpg.jpg'),
(334, 'ESTS040', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810945/1702703208791_ests040-1_52985817645_o_da637e28e79a4c9a8f467bc9801869fc_compact.jpg.webp'),
(335, 'ESTS040', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810947/1702703208795_ests040-2_52988193045_o_8fd6a00033484ba78cd9122314ac7912_master.jpg.webp'),
(336, 'ESTS044', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810901/1702717326826_ests044-7_52952326015_o_0bac266322e846e0a8fdfbef6ad564ac_master.jpg.jpg'),
(337, 'ESTS044', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810904/1702717326846_ests044-5_52952083504_o_5fae14cac84f41df80684c063252f356_master.jpg.webp'),
(338, 'ESTS044', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810907/1702717326849_ests044-4_52952325920_o_db452e2aca604cc99f713286eecff353_master.jpg.jpg'),
(339, 'ESTS044', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810911/1702717326853_ests044-2_52951946131_o_7ae2b619a4d64636be4010f88b76f599_master.jpg.webp'),
(340, 'ESTS044', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810915/1702717326858_ests044-1_52951946161_o_5b02f5c9e0ad4e30ad598e66309be6f9_master.jpg.webp'),
(341, 'ESTS044', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810918/1702717326862_ests044-3_52952396788_o_5673812b89994da69cfc7ad22ca9677e_master.jpg.webp'),
(342, 'ESTS021', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810882/1702717756299_52952382618_a5bfb52264_o_1dd1d8bfd5964b5ba39fa794245413c2_master.jpg.webp'),
(343, 'ESTS021', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810885/1702717756307_52951331472_2666f11939_o_4df65f417d014c27a790ea7f10643760_master.jpg.webp'),
(344, 'ESTS021', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810888/1702717756310_52951331432_de924a7667_o_ee8f89781bd546bbb3a8491609d8508b_master.jpg.webp'),
(345, 'ESTS021', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810891/1702717756312_ests021-2_e1e40d9fbd9949b3a121eb0118255897_master.jpg.webp'),
(346, 'ESTS021', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810894/1702717756315_ests021-1_c15a97c09eef4e6eb14482be0b841e8a_master.jpg.webp'),
(347, 'ESTS021', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810897/1702717756318_ests021_64a34ff68d6d4857bae234b1364576fc_master.jpg.webp'),
(357, 'ESTS038', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810392/1702802210671_52932807699_675718ff74_o_c51332dcd11d4ceb82ee7fd5d74a508d_master.jpg.webp.webp'),
(358, 'ESTS038', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810394/1702802210675_52933043930_8da87d7a6c_o_1af3f2feba9545f8be8a0a196b8b2567_master.jpg.jpg.webp'),
(359, 'ESTS046', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810398/1702802457847_ests046-4_52823383866_o_03a8719562174bfea3d3c34e9f6ce77c_master.jpg.webp'),
(360, 'ESTS046', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810401/1702802457852_ests046-3_52823787455_o_e32a02c616c541dea1916e0846fd4542_master.jpg.webp'),
(361, 'ESTS046', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810405/1702802457857_ests046-2_52823821213_o_c93187331d7744c5a2f29f0e0c12667a_master.jpg.webp'),
(362, 'ESTS046', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810408/1702802457861_ests046-1_52823383756_o_d4754aac7afc4e239bf0051796f9a08c_master.jpg.webp'),
(363, 'ESTS046', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810411/1702802457864_52822810917_399b0c9e61_o_f8b7ca92c7494149998a032945fdab3a_master.jpg.webp'),
(364, 'ESTS046', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810414/1702802457870_52933042335_6073fd6fbf_o_26515b1de83944d38a9c619c21cc769a_master.jpg.webp'),
(365, 'ESTS046', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810418/1702802457873_52932806289_bc52c62c78_o_f52bd9c5a85245f994c7648225599922_master.jpg.webp'),
(366, 'ESTS036', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810422/1702802725811_img_8589_52910931139_o_11a1939717b94032aee2aac1048f8f2f_master.jpg.jpg'),
(367, 'ESTS036', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810426/1702802725819_img_8588_52910203567_o_79d74ee4870542d5bb9c0c7d423fac31_master.jpg.webp'),
(368, 'ESTS036', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810429/1702802725823_img_8585_52911231748_o_2e3cb6c9417b4c4a863f3a1a66658fca_master.jpg.webp'),
(369, 'ESTS036', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810432/1702802725828_img_8583_52910203677_o_fb46608541cd4d43bcbf847e80ba49be_master.jpg.webp'),
(370, 'ESTS036', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810435/1702802725832_img_8582_52911164715_o_5a36f5119e5f450a859036561f4460f4_master.jpg.webp'),
(371, 'ESTS036', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810438/1702802725835_img_8578_52910203457_o_1a52bd3eab9049858c9e04b24c2df325_master.jpg.webp'),
(372, 'ESTS036', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810441/1702802725838_52932808504_eb04cf31e5_o_524c41c783ae49759badacbe15c3d9d7_master.jpg.webp'),
(373, 'ESTS036', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810443/1702802725844_52932058522_9aba18e17a_o_e54f4d9597d9417c80ecba97a29c218c_master.jpg.webp'),
(374, 'ESTB026', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810447/1702803852463_estb026-6_52823399121_o_7260dac727ce4fee98c47e9e1cface96_master.jpg.webp'),
(375, 'ESTB026', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810451/1702803852471_estb026-5_52823802475_o_3ac07df0a46749f8962e2c55cfcd89ce_master.jpg.webp'),
(376, 'ESTB026', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810454/1702803852475_estb026-4_52823836403_o_311a77c2f8a44b8f880af86b30450200_master.jpg.webp'),
(377, 'ESTB026', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810457/1702803852478_estb026-3_52823836533_o_d186ef013d2f4c84bc2ca03d360d935e_master.jpg.webp'),
(378, 'ESTB026', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810461/1702803852482_estb026-2_52822826977_o_0a051c27711c4eda8825e1a294e527d7_master.jpg.webp'),
(379, 'ESTB026', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810464/1702803852487_estb026-16_52822828202_o_3756dfb1091b4d09895dce49845d4e0e_master.jpg.webp'),
(380, 'ESTB026', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810466/1702803852491_estp026-2_8be997547b86427abb4dfb61fc15a5bf_master.jpg.webp'),
(381, 'ESTB026', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810468/1702803942376_estb026-22_52823803520_o_718ac96b8e95469db8a8ef74a023c2dc_master.jpg.webp'),
(382, 'ESTB026', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810471/1702803942380_estb026-17_52823400941_o_28946e8fe13e4123ae9010a5d2004bcd_master.jpg.webp'),
(383, 'ESTB026', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810474/1702803942386_estb026-11_52822828632_o_fb5c8442ec4146618cca5021c9f98643_master.jpg.webp'),
(384, 'DATB614', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810477/1702806015784_52659779297_47f3c457bc_o_a51ef16f093348b6b4f3cf870e85e08d_master.jpg.webp'),
(385, 'DATB614', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810479/1702806015791_52660278521_2f6709e709_o_5d182bb3af21461d92187ab883f3e1db_master.jpg.webp'),
(386, 'DATB614', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810482/1702806015796_52660277426_dc504ee577_o_21bd4f09db1d40e68e692253e8796e4b_master.jpg.webp'),
(387, 'DATB614', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810485/1702806015800_52660278786_9ba122257e_o_929bf419522b4ae0ae7e2c6a6fb1b46d_master.jpg.webp'),
(388, 'DATB614', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810488/1702806015803_52659780022_276e6ffe8f_o_538cb00491c24f7c8b6f1a02b952220c_master.jpg.webp'),
(389, 'DATB614', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810491/1702806015806_52660723970_bfd1c8d37d_o_1661ae6b3e4b44c281d809ceffd1fe58_master.jpg.webp'),
(390, 'DATB614', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810494/1702806015812_52660558534_e1239eeb1b_o_786802e53d3843e19392b3f4e5199c71_master.jpg.webp'),
(391, 'DATB920', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810497/1702806426600_52676411040_14a9edf7fb_k_274a9ee91f644bb497574ddf187a898a_master.jpg.webp'),
(392, 'DATB920', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810499/1702806426607_52675982306_1de686897f_k_b3f1e82afd564d57939092ede2e8712d_master.jpg.webp'),
(393, 'DATB920', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810501/1702806426610_52676267734_29ce1b8952_w_b5e73e512a94405184fa5e20ecf65fcc_master.jpg.webp'),
(394, 'DATB920', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810503/1702806426613_52675471287_ce95e63b8d_c_27120fb7463643f8bfb96af8f03a4f1b_master.jpg.webp'),
(395, 'DATB920', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810506/1702806426616_52676267774_9c7d4176e8_k_559ce960bc8b48a68d7aa9f1710f6cf7_master.jpg.webp'),
(396, 'DATB920', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810508/1702806426620_52675981811_16343f35a9_o_47f611111bbb46b3a3499a88b25c1126_master.jpg.webp'),
(397, 'DATB920', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810511/1702806426624_52676410670_9925195387_o_f81c51d94f4c452e8a98502af8e27a65_master.jpg.webp'),
(398, 'DATB920', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810514/1702806426628_52675470897_244d30d8d3_o_153eb48e037a42f4b422012eeb8edfcd_master.jpg.webp'),
(399, 'DATB920', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810517/1702806426631_52675470952_bac5dde46f_o_6e072690900e4c5bb133f84a697b0f1e_master.jpg.webp'),
(400, 'DATB920', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810519/1702806426637_52695476781_bac6e21f9c_k_fec22b5dee744ea0b0d2b622f99451fc_master.jpg.webp'),
(401, 'DATB920', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810527/1702806426640_untitled_design__5__5744f2809b2c4d3499ef8f70899e3c18_master.jpg.webp'),
(402, 'EATB006', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810531/1702806927283_eatb006-7_c9e79db0114c4200a63cd60475d6a122_master.jpg.jpg'),
(403, 'EATB006', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810534/1702806927289_eatb006-4_a248aa8e293a4fddbbdde47a4756d047_master.jpg.webp'),
(404, 'EATB006', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810536/1702806927292_eatb006-3_ce2f16403e4b49bd990f26b44947fce5_master.jpg.webp'),
(405, 'EATB006', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810538/1702806927296_eatb006-2_0511ad8acf754ee995e7c81347160cc6_master.jpg.webp'),
(406, 'EATB006', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810540/1702806927300_eatb006-5_697cbbe50fd24f45b3b62366f5bf48e8_compact.jpg.webp'),
(407, 'EATB006', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810542/1702806927304_eatb006-5_697cbbe50fd24f45b3b62366f5bf48e8_master.jpg.webp'),
(408, 'EATB006', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810545/1702806927308_eatb006-9_b1e0eef7be8c449dbab0b49c24dd2e48_master.jpg.jpg'),
(409, 'EATB006', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810548/1702806927311_eatb006-8_dc7583950c78485f9c62a509cccab61f_master.jpg.jpg'),
(410, 'EATB006', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810551/1702806927317_eatb006-6_ed5bf9508fe94a6da12e90ebd637f5bb_master.jpg.webp'),
(411, 'EATB006', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810553/1702806927321_eatb006-1_802efda9723841d59eb56fabb46d7b22_master.jpg.webp'),
(416, 'EATB003', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810556/1702807767083_eatb003-8_084c26b6c7684eb8b046a72e61083bb7_master.jpg.webp'),
(417, 'EATB003', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810559/1702807767088_eatb003-7_46d35176d4ad45afb53f50cb2bde044c_master.jpg.webp'),
(418, 'EATB003', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810562/1702807767092_eatb003-6_8eced11e6d14459cbb181b09b51ae20a_master.jpg.webp'),
(419, 'EATB003', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810565/1702807767097_eatb003-5_a9d10239ad594405819d73174c16f106_master.jpg.webp'),
(420, 'EATB003', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810569/1702807767101_eatb003-4_438ed372ba5047269b3eabc8cee7d87f_master.jpg.webp'),
(421, 'EATB003', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810572/1702807767105_eatb003-3_a934a4382e84499b9a267b113bd841e5_master.jpg.webp'),
(422, 'EATB003', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810574/1702807767111_eatb003-2_67d23b0fe4d24d15af3c78bb21a49bf7_master.jpg.webp'),
(423, 'EATB003', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810577/1702807767115_eatb003-1_4b6bae1705b84deabfa237c94373b36e_master.jpg.webp'),
(424, 'DABK906', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810579/1702808414165_dabk906-6_927e60d4ebbb4678b0d68f10ab3a54a2_master.jpg.webp'),
(425, 'DABK906', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810581/1702808414171_dabk906-5_98aa9c0da5cd4fb2a5cef7a73cefe36c_master.jpg.webp'),
(426, 'DABK906', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810583/1702808414176_dabk906-4_94214472d2504fea9977e199bfbdbd60_master.jpg.webp'),
(427, 'DABK906', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810585/1702808414180_dabk906-3_2e0eebbdc700441aa2c8455d175db942_master.jpg.webp'),
(428, 'DABK906', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810587/1702808414184_dabk906-2_bac3936bf9d84867b4992915c17c55e4_master.jpg.webp'),
(429, 'DABK906', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810589/1702808414188_dabk906-11_a2d5c942c2ff436c9f872d7393b79bff_master.jpg.webp'),
(430, 'DABK906', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810591/1702808414194_dabk906-1_6be1255f7e6b427094e410388cb5f6a1_master.jpg.webp'),
(431, 'DABK908', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810595/1702808850326_52709644909_ec78a5b681_o_2b532365a459475087eb1a60f1d7bf18_master.jpg.webp'),
(432, 'DABK908', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810597/1702808850332_20230112_kkdpzqbmudplbn4v_2ad921ea8c3446c8b03eac34c60ea840_master.jpg.webp'),
(433, 'DABK908', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810599/1702808850335_20230112_yemiyu2ietsvb00e_0133472491ac484380875734194b366e_master.jpg.webp'),
(434, 'DABK908', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810601/1702808850338_20230112_aegxlx220r0cyabo_79e1cfa1e7994745ae2a63f075017a50_master.jpg.webp'),
(435, 'DABK908', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810603/1702808850340_20230112_aswzjkmbtcswuecm_759b78b711fe4fccb346aafbb72afe3b_master.jpg.webp'),
(436, 'DABK908', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810612/1702808850344_52572958209_7a8958f472_o_6a35eb314f4e4386ba252c4c13aa46b9_master.jpg.webp'),
(437, 'DABK908', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810616/1702808850347_52572958079_bf18582296_o_b7b494c15e3d4e6eab215767950ac091_master.jpg.webp'),
(438, 'DABK908', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810620/1702808850350_52573214058_ae17e2ec7d_o_ae0d8762ed534d7da5f489fea388fb4a_master.jpg.jpg'),
(439, 'DABK908', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810623/1702808850353_52573133940_b5a8447253_o_cf8db422a9e04d11af61493907e9ebc8_master.jpg.webp'),
(440, 'DABK908', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810625/1702808850356_tp038---bk908-_23__34e8865287bc432c881c61e4c3b1614b_master.jpg.webp'),
(441, 'DABK908', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810628/1702808850360_tp038---bk908-_20__de063447c1d34cf0a62c34b18ed2ffe6_master.jpg.webp'),
(442, 'EABT021', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810631/1702809314674_eabt021-7_52952129974_o_36dd5e232c944505837e328306ca06d5_master.jpg.webp'),
(443, 'EABT021', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810636/1702809314794_eabt021-6_52951392377_o_06751b36a0b049c8a230d80e9b86d2e7_master.jpg.jpg'),
(444, 'EABT021', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810639/1702809314990_eabt021-3_52952129939_o_165a74ba54fe4f90afd689129e088fdb_master.jpg.webp'),
(445, 'EABT021', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810642/1702809315238_eabt021-2_52952443573_o_0c155321a61a4f33a482c51d6c0a1352_master.jpg.webp'),
(446, 'EABT021', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810645/1702809315614_eabt021-1_52951392367_o_e8f1b01918b54bc1a2631568f5dd458b_master.jpg.webp'),
(447, 'EABT021', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810647/1702809333060_eabt021-4_52951993446_o_0d23aa6812b3462cb69bdc6b19240434_master.jpg.webp'),
(448, 'EABT019', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810650/1702809798197_52776871749_e2c0b1e895_o_b3a1b7a40a0d426e878457df4294018c_master.jpg.webp'),
(449, 'EABT019', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810652/1702809798471_20230412_uq4kjvcmhj_70b56b5513de4d3ca66eac59642bef97_master.jpg.webp'),
(450, 'EABT019', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810654/1702809798810_20230412_fmolgheqgq_ff309b08c2d4476e895a27df755bef47_master.jpg.webp'),
(451, 'EABT019', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810655/1702809798874_20230412_i6l1zc67ts_d280fbc65e18401ba4be9fbf7a47c917_master.jpg.webp'),
(452, 'EABT019', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810658/1702809799004_52777027695_4802662c62_o_9cf976a814c74d1299a1a4e437d368c9_master.jpg.jpg'),
(453, 'EABT019', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810663/1702809799788_52776082972_d2e0349123_o_3b566765f10941fa8472b88063934868_master.jpg.jpg'),
(454, 'EABT019', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810667/1702809799967_52776615421_ec4b245843_o_449061a74c534691b47fa009d785f46d_master.jpg.jpg'),
(455, 'EABT019', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810670/1702809800088_52776615181_dcef200531_o_4e1c687fb840415a91c6320fe561c127_master.jpg.jpg');
INSERT INTO `imgs_product` (`img_id`, `product_id`, `file_img`) VALUES
(456, 'EABT019', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810672/1702809800238_tb041---bt019-_17__d4d6e2ec2dbf4dd897653f55781b4dcb_master.jpg.webp'),
(457, 'EABT019', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810674/1702809800334_tb041---bt019-_14__13addb6f4b634d3bb1df83649ff1fdde_master.jpg.webp'),
(458, 'DABJ004', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810678/1702810004147_52706148983_5e4cb0e46b_o_71a63d69ea764111817caab180516083_master.jpg.webp'),
(459, 'DABJ004', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810681/1702810004151_52706072330_c3ea1c6f70_o_218112c649264444827f130a5899eabd_master.jpg.jpg'),
(460, 'DABJ004', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810691/1702810004154_52706072235_9bf8c4e344_o_3275d856899841e194d0a50d5351fb2a_master.jpg.jpg'),
(461, 'DABJ004', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810696/1702810004156_52705134232_5dabe57723_o_284ab3859ae841c599e3e216c35d43f3_master.jpg.webp'),
(462, 'DABJ004', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810699/1702810004160_52705134532_9641266ba5_o_b0cd484e75c9447580fa232f4eef872c_master.jpg.webp'),
(463, 'DABJ004', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810701/1702810004163_52706071935_8966d1e12f_o_a66489be76c949d791609a08ca73993f_master.jpg.webp'),
(464, 'DABJ010', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810705/1702810256788_52167839967_2127960c61_o_d192322094cd4d1dab1790f5a4995e51_master.jpg.webp'),
(465, 'DABJ010', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810709/1702810256792_52169109624_4b0fdfea3e_o_d9919592f8e043f782d44ce65902c365_master.jpg.webp'),
(466, 'DABJ010', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810712/1702810256794_52168871298_5574f48047_o_34c442454a2d44fab30dd83481d5db41_master.jpg.jpg'),
(467, 'DABJ010', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810718/1702810256797_52167839292_d0471b70ce_o_7501f2fc994447218a00785c60f6bba7_master.jpg.webp'),
(468, 'DABJ010', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810721/1702810256802_52168871363_a4f22ded3c_o_027ce5b100a048bab3770456a090fe81_master.jpg.webp'),
(469, 'DABJ010', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810725/1702810256805_52169342265_2c7137e4bf_o_fa2fa32197bc4613973a8ddd59e488c0_master.jpg.webp'),
(470, 'DABJ010', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810727/1702810256808_52169110354_87bd6ccaa0_o_abf9f4cabd204376b1d1cba50d2deec9_master.jpg.webp'),
(471, 'DABJ903', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810730/1702810455332_52417006300_6f7ea894a2_o_155f8f02ec1b4c1fb2614e54faa89714_master.jpg.webp'),
(472, 'DABJ903', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810734/1702810455336_52417006270_e73e119ab9_o_3be117debb524beb882cb2d799498554_master.jpg.jpg'),
(473, 'DABJ903', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810740/1702810455340_52416563431_3f20b3e7c6_o_c89fbf176f5a4ecf93ee976ac7f76ffe_master.jpg.jpg'),
(474, 'DABJ903', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810743/1702810455343_52416845114_1fcba8292b_o_4a1de055394249548a5c8916b47fb821_master.jpg.webp'),
(475, 'DABJ903', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810746/1702810455346_dabj903-1_c6addc33aefe4f808d540f501dce25d0_master.jpg.webp'),
(476, 'DABJ903', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810748/1702810455348_dabj903_bf925f25f2c244aeb43a9c4430f64ef8_master.jpg.webp'),
(477, 'DABJ908', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810752/1702810648495_bj908-9_53198470183_o_2e9f86b18a2f4a8aaf1618dd68a5f2ef_master.jpg.webp'),
(478, 'DABJ908', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810755/1702810648499_bj908-8_53198052049_o_6c073d7ec7154209ba1631016af4beb9_master.jpg.webp'),
(479, 'DABJ908', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810759/1702810648502_bj908-7_53198579615_o_e8f28cfb917c43ed8426007765cac1de_master.jpg.jpg'),
(480, 'DABJ908', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810762/1702810648505_bj908-1_53197785252_o_5ce6fb79a2c5406e9653f8d522cc482b_master.jpg.webp'),
(481, 'DABJ908', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810765/1702810648509_bj908-6_53198579650_o_262e43d6cbbc44308abb23db80c9eb69_master.jpg.webp'),
(482, 'DABJ908', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810768/1702810648513_bj908-2_53198051989_o_d8c0aeb3be18470c95b4e19e4481b38d_master.jpg.webp'),
(483, 'CABJ003', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810770/1702810774286_cabj003-1_4c7c6104568d47139ab4f9b9df4e6a87_masterkpg.jpg.webp'),
(484, 'CABJ003', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810773/1702810774291_cabj003_75aa0eb2e3ef4d7cb175dcef6ceae9cf_master.jpg.webp'),
(485, 'DABJ904', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810776/1702810960842_52419688925_095875bbed_o_cdd18641318f48cda52c00a2c30264b8_master.jpg.webp'),
(486, 'DABJ904', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810781/1702810960848_52419688890_5e23d5cff3_o_d70f528721b945d4a34ccd1b51fb1362_master.jpg.jpg'),
(487, 'DABJ904', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810785/1702810960851_52419529844_90ed9dba78_o_9eef75f8b7b84523936675cd9fb42063_master.jpg.jpg'),
(488, 'DABJ904', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810788/1702810960854_52419250611_0f82236c1f_o_83cb1b62f83d4f698f691b321e12cac5_master.jpg.webp'),
(489, 'DABJ904', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810791/1702810960857_52418739412_cc775bbaa6_o_01791bf8f88049af935fc784aeea69f1_master.jpg.jpg'),
(490, 'DABJ904', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810794/1702810960863_20230209_2nqi04eclesynryo_614790fe9b5a479095c6726ef90f2df7_master.jpg.jpg'),
(507, 'ESBW005', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810801/1702812011588_esbw005--9_52899674460_o_296b1f20ae9941f6b17a610ac00d49b7_master.jpg.webp'),
(508, 'ESBW005', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810804/1702812011592_esbw005--7_52898705557_o_20994a6240134dc18c19850099a85f72_master.jpg.webp'),
(509, 'ESBW005', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810807/1702812011596_esbw005--6_52899279301_o_a9b92cb1a220466fb40a137f6b1032fc_master.jpg.webp'),
(510, 'ESBW005', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810810/1702812011599_esbw005--5_52899727433_o_f2e8e5c559fd4fad91e417a4fef1bc23_master.jpg.webp'),
(511, 'ESBW005', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810813/1702812011601_esbw005--3_52899440664_o_07f1e33f83c044bab736e9a55753d6b1_master.jpg.webp'),
(512, 'ESBW005', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810816/1702812011637_esbw005--2_52899440654_o_9d430ebd4f3c4efca91917e765c00d48_master.jpg.webp'),
(513, 'ESBW005', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810819/1702812011640_esbw005--1_52899279126_o_d3ed642f59914badb1c93ea5d031d2e8_master.jpg.webp'),
(514, 'ESBW005', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810822/1702812011644_ff_15927ceaf8c342d68b92a6f8f4488382_master.jpg.webp'),
(516, 'ESBW005', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810827/1702812110775_4268bd5eeb3e637ed3b_master.jpg.webp'),
(517, 'ESBW004', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810829/1702812478065_esbw004-9_52898739082_o_c82e5ce820cf41528e0d7a18081780ab_master.jpg.webp'),
(518, 'ESBW004', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810832/1702812478069_esbw004-8_52899706940_o_c1d188c2dba54add95671fe3d6937d7a_master.jpg.webp'),
(519, 'ESBW004', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810836/1702812478072_esbw004-7_52899707115_o_32f0c7e0c35445a095a9ca8c75344f20_master.jpg.webp'),
(520, 'ESBW004', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810839/1702812478074_esbw004-6_52899707285_o_f85f1a38257140879eb69b09e6d63608_master.jpg.webp'),
(521, 'ESBW004', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810843/1702812478078_esbw004-5_52898738362_o_d0ac614afbf24774b6edfb647a42ed0f_master.jpg.webp'),
(522, 'ESBW004', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810846/1702812478081_esbw004-4_52899760808_o_d8a6e9f0f34844feaf0a265800eef988_master.jpg.webp'),
(523, 'ESBW004', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810848/1702812478084_gg2_76e1acff4af64c92824f810fd840d106_master.jpg.webp'),
(524, 'ESBW004', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810851/1702812478087_gg_9291a873c71b40fe81bd4a65e6e9e1cf_master.jpg.webp'),
(525, 'ESBW004', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810853/1702812478091_esbw004-12_52899473574_o_36fe3a92153a417b89b69bf2ce2d1490_master.jpg.webp'),
(526, 'ESBK007', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810254/1702812911809_esbk007-19_52988201020_o_3df16f49342548df98e932f189c1484a_master.jpg.jpg'),
(527, 'ESBK007', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810258/1702812911813_esbk007-6_52988289443_o_d2d6cd03c5d84efab4ae4506ebb269ed_master.jpg.webp'),
(528, 'ESBK007', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810262/1702812911816_esbk007-5_52988289468_o_5d54497d13494a938810a0d461885986_master.jpg.webp'),
(529, 'ESBK007', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810266/1702812911820_esbk007-4_52988289103_o_05529d8d255e47ab9f049e81f195f63a_master.jpg.jpg'),
(530, 'ESBK007', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810270/1702812911824_esbk007-3_52988289118_o_26a2149e64da47fb812bce27361703a6_master.jpg.jpg'),
(531, 'ESBK007', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810273/1702812911827_esbk007-2_52988200955_o_cb741fb89c754e52a289bac1b7dc4359_master.jpg.jpg'),
(532, 'ESBK007', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810277/1702812911829_c_266c13d20919488f8a43881fd3d86ca3_master.jpg.webp'),
(533, 'ESBK007', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810282/1702812911835_a_01ad865f36cf4eb9bd17ae50ff4d7a76_master.jpg.webp'),
(534, 'ESBK007', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810284/1702812911838_b_d29e6bdf78d04be1aa1575b44e69b2fb_master.jpg.webp'),
(535, 'ESBK002', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810287/1702813549110_esbk002-17_52813989875_o_d400362148e04736bda41b2b86844201_master.jpg.webp'),
(536, 'ESBK002', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810289/1702813549116_esbk002-18_52814032098_o_8804bbb1b3d74439abaee51731a82b2b_master.jpg.webp'),
(537, 'ESBK002', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810293/1702813549119_esbk002-14_52813577276_o_2caabc86a631431c94c8ad7d198b438d_master.jpg.jpg'),
(538, 'ESBK002', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810295/1702813549122_esbk002-11_52813020512_o_6c397ca1a0484b66af09d98258cae11c_master.jpg.webp'),
(539, 'ESBK002', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810299/1702813549126_esbk002-25_52813772009_o_7cbce75ae5e645bcaec61489c3f6d783_master.jpg.webp'),
(540, 'ESBK002', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810303/1702813549130_esbk002-2_52813988905_o_bd8d3514db464a4e840a78635c9a192b_master.jpg.jpg'),
(541, 'ESBK002', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810312/1702813549133_esbk002-22_52813989440_o_072320897e0244c2946de08e00e68df5_master.jpg.jpg'),
(542, 'ESBK002', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810315/1702813549136_esbk002-19_52813772554_o_f63f7a794f0a4f3f96b3b22d212f378a_master.jpg.webp'),
(543, 'ESBK002', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810318/1702813549140_esbk002-8_52813990600_o_bbba896fe3744d0584fdce524ff888b1_master.jpg.webp'),
(544, 'ESBK002', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810320/1702813549143_esbk002-5_52813988720_o_52117d456e3d48d89d4c0b1e9cb62f93_master.jpg.webp'),
(545, 'ESBK002', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810323/1702813549146_52933853146_59370d1582_o_4bf573d486474c43b806540d25a49b65_master.jpg.webp'),
(546, 'ESBK002', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810325/1702813549148_52933853176_7967f42e52_o_208bdabebdb14986a84a5ed6be961474_master.jpg.webp'),
(547, 'BI013', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810330/1702814188800_20220214_rqmdfbzelhqp14kvbyjdov8e_4adea06d26014521b26f886e16175c5d_master.jpg.jpg'),
(548, 'BI013', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810333/1702814188803_20220214_aa2dxth7npokvdt73rxflrsg_e686cb6ec1be4f309c5a8b1305f8769c_master.jpg.webp'),
(549, 'BI013', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810337/1702814188807_20220214_cmjadhbvnqgvj2dl8qxlmkst_18dfb5a80b834f6d826e7b7918365b27_master.jpg.jpg'),
(550, 'BI013', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810341/1702814188816_20220214_yzxa3v6zuawe6zcbvw47ty0t_a101bd2336ef4b7091c1a97ed5734b09_master.jpg.webp'),
(551, 'BI013', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810344/1702814188820_20220214_9sqxfrp87yzcgtfw5gnv103y_ec5fec57d7f44d14819f71329d391d4d_master.jpg.webp'),
(552, 'BI013', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810348/1702814188823_20220214_zquxm0k25vusrzskw8qojnex_d0321582dc3342f4bb38d89f5c134a84_master.jpg.webp'),
(553, 'BI013', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810350/1702814188826_51988114534_238cde3543_o_7883ded929414df59b56b76e9a22e117_master.jpg.webp'),
(554, 'BI013', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810353/1702814188828_51988381170_eacbdaf22c_o_0e57a352daa34f50b70e03e77ec62792_master.jpg.webp'),
(555, 'BI013', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810357/1702814188831_51988114499_06741b197e_o_0ee210085cda4f85bc007c830526c361_master.jpg.webp'),
(556, 'BI013', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810360/1702814188835_51987823711_a1e404ba0d_o_075443e0b38240cd9b55ff269537bc67_master.jpg.webp'),
(557, 'BI013', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810363/1702814188838_tp038---bi013-_19__8e5d8348310741e48649ae329ee3e014_master.jpg.webp'),
(558, 'BI013', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810365/1702814188840_tp038---bi013-_20__790f72cbd3d34a918920b73579e72ea5_master.jpg.webp'),
(559, 'ESBI006', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810369/1702815216156_esbi006-9_95f00d733aba478891e327cea219dafb_master.jpg.jpg'),
(560, 'ESBI006', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810372/1702815216161_esbi006-8_efa8504febac44bc85dd73720a522e65_master.jpg.webp'),
(561, 'ESBI006', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810377/1702815216164_esbi006-7_e98b77784d774dc686f70e02e792fa68_master.jpg.webp'),
(562, 'ESBI006', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810380/1702815216168_esbi006-5_cdcf55a55aed4974a2116be589cb2504_master.jpg.webp'),
(563, 'ESBI006', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810382/1702815216171_esbi006-4_a3a684a716104aed8998d0f3dfd393f5_master.jpg.webp'),
(564, 'ESBI006', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810385/1702815216174_esbi006-2_0080bf175388476fa2cb9a7e9f3d728c_master.jpg.webp'),
(565, 'ESBI006', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810389/1702815216177_esbi006-1_405724795b8f4f22867f345eaab26319_master.jpg.webp'),
(601, 'DATB416', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810237/1703435106872_52695476436_cfce895223_o_32bf8a7c12f04f34963103b2b30b3dd0_master.jpg.webp'),
(602, 'DATB416', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810243/1703435106878_untitled_design__1__8e8dab846c1c444385812026eb549eb8_master.jpg.webp'),
(603, 'DATB416', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810245/1703435106881_datb416_e53618f106c54b85a436bd3e7f3025db_master.jpg.webp'),
(604, 'DATB416', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810249/1703435106886_52695741049_ab53170a62_o_d4d8d423351a4330b41d0fc19ade0513_master.jpg.webp'),
(609, 'DWBS012', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810226/1703928526192_bs012-7_52616063791_o_b73fd2ba1d004e6e9b6e00056a74a633_master.jpg.jpg'),
(610, 'DWBS012', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810228/1703928526208_bs012-4_52616554758_o_2d13878e693346e18cfb465e5e5d92aa_master.jpg.webp'),
(611, 'DWBS012', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810230/1703928526215_bs012-3_52615554827_o_cdf36ab14e2948ab984bbfe0c18c72ed_master.jpg.webp'),
(612, 'DWBS012', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810232/1703928526222_bs012-2_52616064151_o_3574494468a940998f25c86d6f815504_master.jpg.webp'),
(613, 'DWBS012', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810234/1703928526228_bs012-1_52615553322_o_0d15a75065ed4bf59b9e03ecded5d334_master.jpg.webp'),
(615, 'EWCW007', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810203/1704189991759_ewcw007-5_53a856c3e86b422d975b1323eb87e578_master.jpg.webp'),
(616, 'EWCW007', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810205/1704189991824_ewcw007-4_73d717aacbbb49539e8941f53860fb81_master.jpg.webp'),
(617, 'EWCW007', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810208/1704189991831_ewcw007-3_309fb3d06ea84910af0060f7178ba85c_master.jpg.webp'),
(618, 'EWCW007', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810210/1704189991836_ewcw007-2_91d0cfce3d134bb4b72cc3086067df2f_master.jpg.webp'),
(619, 'EWCW007', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810212/1704189991841_ewcw007-1_c8b1f230ddb2408daa72728d0ecee531_master.jpg.webp'),
(620, 'DWCT001', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810190/1704190979892_ct001_51763349788_o_786e5178773a4a1fb56f1bfee2157e9b_master.jpg.jpg'),
(621, 'DWCT001', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810193/1704190979915_ct001_51763349443_o_c46a7b646c5741ca865598fe0249b69b_master.jpg.webp'),
(622, 'DWCT001', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810196/1704190979920_ct001_51762271912_o_1e27b353ce35445b98aa64a0c024c655_master.jpg.webp'),
(623, 'DWCT001', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810198/1704190979924_ct001_51762269147_o_09bc5494840e48feb5ad0b9b16c3d37b_master.jpg.webp'),
(624, 'DWCT001', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810200/1704190979928_ct001_51762266972_o_9bee17ad6de44acca391c7ad9847bf08_master.jpg.webp'),
(625, 'DWCT004', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810177/1704191300141_ct004-5_52410247588_o_e018274348ee4e508c3bcd3e45191163_master.jpg.webp'),
(626, 'DWCT004', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810179/1704191300155_ct004-4_52409234072_o_c1cc144681a64b2da46f4a881600383c_master.jpg.webp'),
(627, 'DWCT004', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810182/1704191300165_ct004-3_52409738056_o_03e4212ea4ec4b85a89193a2233e3f29_master.jpg.webp'),
(628, 'DWCT004', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810184/1704191300171_ct004-13_52409234777_o_e7c882ac09994daaa3ef8a4b92a5614b_master.jpg.webp'),
(629, 'DWCT004', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810186/1704191300176_ct004-2_52410023919_o_fe0e3f9c03f642cf9309596415dc2278_master.jpg.webp'),
(630, 'DWCU007', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810173/1704191606458_20220929_3dshbpb0pecj63dcrkmah5yc_85f0fa938a844dc2a433bc82c3147ad4_master.jpg.webp'),
(631, 'DWCU007', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810174/1704191606465_20220929_eflqusorg4g4ku3umeps5z9r_389f739d70b645d8a1d6a49d9b745c7b_compact.jpg.webp'),
(632, 'EWCL003', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810159/1704250844847_ewcl003-3_53375595102_o_0f63b002aa3c4f57bc06d9ac92da343d_master.jpg.jpg'),
(633, 'EWCL003', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810162/1704250844861_ewcl003-2_53376963630_o_d253bb8cf4404fd18f7fb241c31b57eb_master.jpg.webp'),
(634, 'EWCL003', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810166/1704250844866_ewcl003-1_53375595057_o_fbf3267675b14c9780e1db57c53ea93c_master.jpg.jpg'),
(635, 'EWCL003', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810169/1704250844871_ewcl003-4_53376696493_o_f4e0d55389724e0cbab7cc411b7e7c0c_master.jpg.webp'),
(636, 'EWCL003', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810171/1704250844877_ewcl003-7_53376839244_o_be698d6fa9ab4f78bf2132679fc67647_master.jpg.webp'),
(637, 'EWCP002', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810135/1704251255788_ewcp002-23_53376842769_o_b7a0db0f11ca48088531456f72fdf5d1_master.jpg.webp'),
(638, 'EWCP002', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810138/1704251255810_ewcp002-21_53376967225_o_c150908e08e04b278de0f946bbe0e0ef_master.jpg.jpg'),
(639, 'EWCP002', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810141/1704251255816_ewcp002-20_53376521336_o_8acdf223364e4793aaf2a88c807b1838_master.jpg.jpg'),
(640, 'EWCP002', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810144/1704251255819_ewcp002-19_53376967265_o_01a8b7e951684afe9a01377cf739adba_master.jpg.webp'),
(641, 'EWCP002', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810147/1704251255823_ewcp002-22_53376699893_o_cd07acb23daf4c36a173731d6b33d8d3_master.jpg.webp'),
(642, 'EWCP002', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810149/1704251255826_ewcp002-11_53376521661_o_7b2fbf44c1f142a3ba2bc974def12378_master.jpg.webp'),
(643, 'EWCP002', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810152/1704251255829_ewcp002-3_53376520886_o_84a65b23bbfb4c54952d7d289b6e1ea8_master.jpg.webp'),
(644, 'EWCP002', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810153/1704251255834_ewcp002_53375619402_o_d0011756fdc646f79c7a39698e026fb8_master.jpg.webp'),
(645, 'EWCP002', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810156/1704251255837_ewcp002-30_53376967025_o_d452a9fe67ca4f9b9803a72fa15b64fd_master.jpg.webp'),
(646, 'EWBS001', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810118/1704251897974_fds.jpg.webp'),
(647, 'EWBS001', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810120/1704251897979_tw003-bs001-16_53290120977_o_cb4dfe2b55f74902ac3f0f64b38f6938_master.jpg.webp'),
(648, 'EWBS001', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810124/1704251897983_tw003-bs001-15_53291378099_o_66f09820de5a4e4f831b38eea4352fd5_master.jpg.webp'),
(649, 'EWBS001', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810126/1704251897988_tw003-bs001-11_53290121042_o_3786274e4f1c4ab88f1f015c551df7db_master.jpg.webp'),
(650, 'EWBS001', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810128/1704251897992_tw003-bs001-1_53291249648_o_e56244e6c0dc497e81cf8ca94a772493_master.jpg.webp'),
(651, 'EWBS001', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810130/1704251897996_tw003-bs001-2_53291377864_o_a93a2eb880cc4107a3a360378ed056fb_master.jpg.webp'),
(652, 'EWBS001', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810132/1704251898000_tw003-bs001-3_53291377849_o_110158d740fc40de9fceb818bda1132b_master.jpg.webp'),
(653, 'ESTB030', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810097/1704715289463_eatb030-7_782d228809784ac3865f80fc627aca89_master.jpg.jpg'),
(654, 'ESTB030', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810100/1704715289509_eatb030-6_aafbbad5453d4849876c636b5e4eaafa_master.jpg.jpg'),
(655, 'ESTB030', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810103/1704715289513_eatb030-5_1cfb4bdeccc14e5e8a4bb2d2eb22b2ee_master.jpg.jpg'),
(656, 'ESTB030', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810105/1704715289516_eatb030-4_736d2c9b503b4c02abae3f66998470f2_master.jpg.jpg'),
(657, 'ESTB030', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810108/1704715289522_eatb030-2_035426c852274f5881fe4cdbe7b7b137_master.jpg.jpg'),
(658, 'ESTB030', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810110/1704715289525_eatb030-1_994ff9e272a742e5af8ec9612e29cc73_master.jpg.webp'),
(659, 'ESTB030', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810112/1704715289529_eatb030-8_a93e54fb6b5a467dbeaa6d051fedcab2_master.jpg.jpg'),
(660, 'ESTB030', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810115/1704715289535_eatb030-3_f4f3649109194318999a3e984bbd30f3_master.jpg.webp'),
(668, 'EWTW003', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810037/1707657567733_tw003-bs001-7_53291006361_o_23d925c5d5fa4a95a81b830c4d783545_master.jpg.jpg'),
(669, 'EWTW003', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810039/1707657567754_tw003-bs001-4_53291249503_o_ef651bccfb984910b8e975fc3ad7beb3_master.jpg.webp'),
(670, 'EWTW003', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810043/1707657567757_tw003-bs001-2_53291377864_o_46e46bd906e8427199e10879f20aeec4_master.jpg.jpg'),
(671, 'EWTW003', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810046/1707657567761_tw003-bs001-8_53291006896_o_3d92c51738cc4ce3a9aa8a2200de966c_master.jpg.jpg'),
(672, 'EWTW003', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810048/1707657567765_tw003-bs001-5_53291006421_o_4c146c1d885147f3a8b19ce1a8bffbc1_master.jpg.webp'),
(673, 'EWTW003', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810050/1707657567769_tw003-bs001-3_53291377849_o_b80f1bc8d383439fb26263361ce7d0b9_master.jpg.webp'),
(674, 'EWTW003', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810052/1707657567773_tw003-bs001-6_53291471625_o_1f620c3d758e41d696fb128d159744a2_master.jpg.webp'),
(677, 'EWTE003', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711809993/1708267758741_ewte003-11_53296667811_o_7264b0c3f1ef468b88b3ce5f020da6c1_master.jpg.webp'),
(678, 'EWTE003', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711809996/1708267758748_ewte003-3_53295791637_o_480ba53e2ac94b97a948a4eacabd56ac_master.jpg.webp'),
(679, 'EWTE003', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711809999/1708267758753_ewte003-2_53295791657_o_78ef8b9c0744454ebaa261ef2461d146_master.jpg.webp'),
(680, 'EWTE003', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810001/1708267758758_ewte003-4_53297045664_o_0700cdbe5f3342d5a10b2719f03c7ab1_master.jpg.webp'),
(681, 'EWTE003', 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810003/1708267758762_ewte003-10_53297045794_o_af9bd1f2fa8246dab498a75b2a976f04_master.jpg.jpg');

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
  `revoked` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `jwt_tokens`
--

INSERT INTO `jwt_tokens` (`id`, `token`, `expiration_date`, `refresh_token`, `account_id`, `refresh_expiration_date`, `revoked`) VALUES
(53, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJuZ3V5ZW5xdWFuZ2FuaCIsInVzZXJuYW1lIjoibmhhbnZpZW4xIiwicm9sZSI6IlJPTEVfRU1QTE9ZRUUiLCJpYXQiOjE3MTM4ODk5NzMsImV4cCI6MTcxMzg5MzU3M30.UghEbLPKZUlWLiTXjqZauOAnIi3hxPHirXkD79ohzGk', '2024-04-24 00:32:53', '4bf80277-d71b-4533-ad94-d2dd16a472aa', 2, '2024-04-23 23:33:03', 0),
(54, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJuZ3V5ZW5xdWFuZ2FuaCIsInVzZXJuYW1lIjoibmhhbnZpZW4xIiwicm9sZSI6IlJPTEVfRU1QTE9ZRUUiLCJpYXQiOjE3MTM4OTE2OTEsImV4cCI6MTcxMzg5NTI5MX0.zMzZPWZrUHYOsIauCEH0o9mu8VKGsXtHSaO-TpX2Dbw', '2024-04-24 01:01:31', '9bb3c204-6b55-47f3-bada-ed056704b408', 2, '2024-04-24 00:01:41', 0),
(84, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJuZ3V5ZW5xdWFuZ2FuaCIsInVzZXJuYW1lIjoicXVhbmx5Iiwicm9sZSI6IlJPTEVfTUFOQUdFUiIsImlhdCI6MTcxNDM3NTIyMCwiZXhwIjoxNzE0NDYxNjIwfQ.SZXGWqYCfdr8LgPcrKZAo02jFK9xGxkwRS-OZFZqLOY', '2024-04-30 14:20:20', '0527cee0-5d7f-4682-8de5-c9e559bdc04b', 1, '2024-05-29 14:20:20', 0),
(85, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJuZ3V5ZW5xdWFuZ2FuaCIsInVzZXJuYW1lIjoicXVhbmx5Iiwicm9sZSI6IlJPTEVfTUFOQUdFUiIsImlhdCI6MTcxNDM3NTMwOSwiZXhwIjoxNzE0NDYxNzA5fQ.9tk28B2jNQP3In14qCECre5A4N7DxuqGPii51itV8vU', '2024-04-30 14:21:49', '9e49c923-8040-4fd9-be27-0427eefea0a6', 1, '2024-05-29 14:21:49', 0);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `products`
--

CREATE TABLE `products` (
  `product_id` varchar(15) NOT NULL,
  `product_name` varchar(100) DEFAULT NULL,
  `cat_id` varchar(10) DEFAULT NULL,
  `price` int(11) DEFAULT NULL,
  `discount_price` int(11) DEFAULT NULL,
  `discount_percent` int(11) DEFAULT NULL,
  `is_discount` bit(1) DEFAULT b'0',
  `brand` varchar(20) DEFAULT 'TORANO',
  `description` text DEFAULT NULL,
  `total_size` int(11) DEFAULT 0,
  `total_color` int(11) DEFAULT 0,
  `image_background` varchar(255) DEFAULT 'no_image.jpg',
  `image_choose_size` varchar(255) DEFAULT 'no_image.jpg',
  `is_product_active` bit(1) DEFAULT b'1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `products`
--

INSERT INTO `products` (`product_id`, `product_name`, `cat_id`, `price`, `discount_price`, `discount_percent`, `is_discount`, `brand`, `description`, `total_size`, `total_color`, `image_background`, `image_choose_size`, `is_product_active`) VALUES
('BI013', 'Quần short đũi phối chun eo BI013', 'SD', 380000, NULL, NULL, b'0', 'TORANO', '', 6, 7, 'https://res.cloudinary.com/dmmvhjl0m/video/upload/v1711858413/tvzzpjqeocumuaszfpxt.mp4', 'IMAGE_4', b'1'),
('CABJ003', 'Quần Jeans rách Slim CABJ003', 'QJR', 550000, NULL, NULL, b'0', 'TORANO', 'Quần Jeans rách Slim CABJ003\r\n', 5, 1, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810773/1702810774291_cabj003_75aa0eb2e3ef4d7cb175dcef6ceae9cf_master.jpg.webp', 'IMAGE_4', b'1'),
('DABJ004', 'Quần Jeans basic Slim DABJ004', 'QJB', 550000, NULL, NULL, b'0', 'TORANO', 'Quần Jeans basic Slim CABJ004/2\r\n', 5, 1, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810701/1702810004163_52706071935_8966d1e12f_o_a66489be76c949d791609a08ca73993f_master.jpg.webp', 'IMAGE_4', b'1'),
('DABJ010', 'Quần Jeans basic Slim DABJ010', 'QJB', 550000, NULL, NULL, b'0', 'TORANO', 'Quần Jeans basic Slim CABJ010/2', 5, 1, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810727/1702810256808_52169110354_87bd6ccaa0_o_abf9f4cabd204376b1d1cba50d2deec9_master.jpg.webp', 'IMAGE_4', b'1'),
('DABJ903', 'Quần Jeans basic Slim DABJ903', 'QJB', 550000, NULL, NULL, b'0', 'TORANO', 'Quần Jeans basic Slim DABJ903\r\n', 5, 1, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810748/1702810455348_dabj903_bf925f25f2c244aeb43a9c4430f64ef8_master.jpg.webp', 'IMAGE_4', b'1'),
('DABJ904', 'Quần Jeans rách Slim DABJ904', 'QJR', 550000, NULL, NULL, b'0', 'TORANO', 'Quần Jeans rách Slim DABJ904\r\n', 5, 1, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810794/1702810960863_20230209_2nqi04eclesynryo_614790fe9b5a479095c6726ef90f2df7_master.jpg.jpg', 'IMAGE_4', b'1'),
('DABJ908', 'Quần Jeans rách Slim 1.DABJ908', 'QJR', 550000, NULL, NULL, b'0', 'TORANO', '', 5, 1, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810768/1702810648513_bj908-2_53198051989_o_d8c0aeb3be18470c95b4e19e4481b38d_master.jpg.webp', 'IMAGE_4', b'1'),
('DABK906', 'Quần kaki dài basic cạp tender túi lé DABK906', 'QKB', 500000, NULL, NULL, b'0', 'TORANO', '', 5, 4, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810591/1702808414194_dabk906-1_6be1255f7e6b427094e410388cb5f6a1_master.jpg.webp', 'IMAGE_4', b'1'),
('DABK908', 'Quần kaki dài basic DABK908', 'QKB', 500000, NULL, NULL, b'0', 'TORANO', '', 5, 4, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810628/1702808850360_tp038---bk908-_20__de063447c1d34cf0a62c34b18ed2ffe6_master.jpg.webp', 'IMAGE_4', b'1'),
('DATB416', 'Sơ mi dài tay kẻ Checkerboard 2.DATB416', 'SMK', 480000, NULL, NULL, b'0', 'TORANO', '', 5, 1, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810249/1703435106886_52695741049_ab53170a62_o_d4d8d423351a4330b41d0fc19ade0513_master.jpg.webp', 'IMAGE_2', b'1'),
('DATB614', 'Áo sơ mi dài tay trơn Bamboo 4.DATB614', 'SMT', 450000, NULL, NULL, b'0', 'TORANO', '', 5, 4, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810494/1702806015812_52660558534_e1239eeb1b_o_786802e53d3843e19392b3f4e5199c71_master.jpg.webp', 'IMAGE_2', b'1'),
('DATB920', 'Áo sơ mi dài tay trơn Bamboo 4.DATB920', 'SMT', 42000, NULL, NULL, b'0', 'TORANO', '', 5, 4, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810527/1702806426640_untitled_design__5__5744f2809b2c4d3499ef8f70899e3c18_master.jpg.webp', 'IMAGE_2', b'1'),
('DSTP611', 'Áo polo trơn bo kẻ DSTP611', 'PLBK', 333333, NULL, NULL, b'0', 'Torano', '', 4, 1, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811554/tp611_59ea616328234a9b969ce2d1c48c482f_master.jpg.webp', 'IMAGE_1', b'1'),
('DSTP650', 'Áo Polo monogram TRN DSTP650', 'PLHT', 450000, NULL, NULL, b'0', 'TORANO', 'Áo Polo monogram TRN 1.DSTP650', 4, 1, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811057/4_485c2d0480d84e4b983817d401d0c65d_master.jpg.jpg', 'IMAGE_1', b'1'),
('DSTP903', 'Áo polo can phối Horizontal Color Scheme DSTP903', 'PLCP', 420000, 290000, 31, b'1', 'TORANO', '', 4, 2, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811223/dstp903_52866905251_o_735380510ed1481090a9d817d712432b_master.jpg.webp', 'IMAGE_1', b'1'),
('DWBS012', 'Quần nỉ trơn Basic 4.DWBS012', 'QN', 380000, 299000, 21, b'1', 'TORANO', '', 4, 3, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810234/1703928526228_bs012-1_52615553322_o_0d15a75065ed4bf59b9e03ecded5d334_master.jpg.webp', 'IMAGE_4', b'1'),
('DWCT001', 'Áo khoác 2 lớp dạ cổ bomber 3.DWCT001', 'AKBB', 990000, NULL, NULL, b'0', 'TORANO', '', 4, 2, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810200/1704190979928_ct001_51762266972_o_9bee17ad6de44acca391c7ad9847bf08_master.jpg.webp', 'IMAGE_5', b'1'),
('DWCT004', 'Áo khoác 2 lớp dạ cổ cao 2.DWCT004', 'AKCC', 750000, NULL, NULL, b'0', 'TORANO', '', 4, 2, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810186/1704191300176_ct004-2_52410023919_o_fe0e3f9c03f642cf9309596415dc2278_master.jpg.webp', 'IMAGE_5', b'1'),
('DWCU007', 'Áo khoác 2 lớp lót lông cổ bomber 2.DWCU007', 'AKBB', 750000, NULL, NULL, b'0', 'TORANO', '', 4, 2, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810174/1704191606465_20220929_eflqusorg4g4ku3umeps5z9r_389f739d70b645d8a1d6a49d9b745c7b_compact.jpg.webp', 'IMAGE_5', b'1'),
('EABT019', 'Quần âu slim-fit cạp trơn EABT019', 'QAPTC', 500000, NULL, NULL, b'0', 'TORANO', '', 5, 4, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810674/1702809800334_tb041---bt019-_14__13addb6f4b634d3bb1df83649ff1fdde_master.jpg.webp', 'IMAGE_3', b'1'),
('EABT021', 'Quần âu slim-fit điều chỉnh cạp trơn 1.EABT021', 'QAPTC', 480000, NULL, NULL, b'0', 'TORANO', '', 5, 1, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810647/1702809333060_eabt021-4_52951993446_o_0d23aa6812b3462cb69bdc6b19240434_master.jpg.webp', 'IMAGE_3', b'1'),
('EATB003', 'Sơ mi dài tay kẻ Checkerboard 3.EATB003', 'SMK', 520000, NULL, NULL, b'0', 'TORANO', '', 5, 3, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810577/1702807767115_eatb003-1_4b6bae1705b84deabfa237c94373b36e_master.jpg.webp', 'IMAGE_2', b'1'),
('EATB006', 'Sơ mi dài tay đũi 5.EATB006', 'SMD', 480000, NULL, NULL, b'0', 'TORANO', 'Sơ mi dài tay nam vải đũi cao cấp thấm hút mồ hôi và thoáng mát\r\n', 5, 4, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810553/1702806927321_eatb006-1_802efda9723841d59eb56fabb46d7b22_master.jpg.webp', 'IMAGE_2', b'1'),
('ESBI006', 'Quần short đũi basic phối dây dệt gấu quần ESBI006', 'SD', 380000, NULL, NULL, b'0', 'TORANO', 'Quần short đũi nam basic phối dây dệt gấu quần. Chất đũi cao cấp mềm mịn, không bai xù và hạn chế nhăn nhàu. Vải thoáng mát thấm hút mồ hôi tốt và nhanh khô.\r\n', 5, 5, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810389/1702815216177_esbi006-1_405724795b8f4f22867f345eaab26319_master.jpg.webp', 'IMAGE_4', b'1'),
('ESBK002', 'Quần short kaki basic, gấp LV bọc viền dây dệt sườn ESBK002', 'SKK', 380000, NULL, NULL, b'0', 'TORANO', '', 5, 4, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810325/1702813549148_52933853176_7967f42e52_o_208bdabebdb14986a84a5ed6be961474_master.jpg.webp', 'IMAGE_4', b'1'),
('ESBK007', 'Quần short kaki phối chun cạp 3.ESBK007', 'SKK', 400000, NULL, NULL, b'0', 'TORANO', '', 5, 3, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810284/1702812911838_b_d29e6bdf78d04be1aa1575b44e69b2fb_master.jpg.webp', 'IMAGE_4', b'1'),
('ESBW004', 'Quần short gió cạp thường vải hiệu ứng 3.ESBW004', 'SG', 350000, NULL, NULL, b'0', 'TORANO', '', 4, 3, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810853/1702812478091_esbw004-12_52899473574_o_36fe3a92153a417b89b69bf2ce2d1490_master.jpg.webp', 'IMAGE_4', b'1'),
('ESBW005', 'Short gió cạp phối chun, in logo mép quần 2.ESBW005', 'SG', 320000, NULL, NULL, b'0', 'TORANO', '', 4, 2, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810827/1702812110775_4268bd5eeb3e637ed3b_master.jpg.webp', 'IMAGE_4', b'1'),
('ESTA003', 'Áo tanktop in họa tiết Tents 2. ESTA003', 'TT', 300000, NULL, NULL, b'0', 'TORANO', '', 4, 2, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810974/1702701667271_eata003-1_c8e90efa55944401946efba4f0ae02bf_master.jpg.webp', 'IMAGE_1', b'1'),
('ESTA005', 'Áo Tanktop họa tiết in Wild Sool 1.ESTA005', 'TT', 250000, NULL, NULL, b'0', 'TORANO', '', 4, 1, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810961/1702702646831_eata005-2_ef46f711d4734ba6a8be08d07f8f3567_master.jpg.webp', 'IMAGE_1', b'1'),
('ESTA006', 'Áo tanktop họa tiết in Shoes ESTA006', 'TT', 250000, NULL, NULL, b'0', 'TORANO', '', 4, 1, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810985/1702700896477_esta006-1_2a8dce82b88d4fd798c0434cf9bed833_master.jpg.webp', 'IMAGE_1', b'1'),
('ESTA010', 'Áo Tanktop họa tiết Defeat ESTA010', 'TT', 250000, NULL, NULL, b'0', 'TORANO', 'Áo tanktop nam cá tính, năng động mặc cực thoải mái. Mẫu áo ba lỗ nam trẻ trung với 2 màu dễ mặc.\r\n', 4, 1, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810015/1702537484269_esta010-1_ad9f734ad81a4f339a557960d10dd7f5_master.jpg.webp', 'IMAGE_1', b'1'),
('ESTB026', 'Sơ mi ngắn tay đũi ESTB026', 'SMD', 450000, NULL, NULL, b'0', 'TORANO', '', 6, 5, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810474/1702803942386_estb026-11_52822828632_o_fb5c8442ec4146618cca5021c9f98643_master.jpg.webp', 'IMAGE_2', b'1'),
('ESTB030', 'Sơ mi ngắn tay trơn Bamboo ESTB030', 'SMT', 400000, NULL, NULL, b'0', 'TORANO', '', 5, 2, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810115/1704715289535_eatb030-3_f4f3649109194318999a3e984bbd30f3_master.jpg.webp', 'IMAGE_2', b'1'),
('ESTP001', 'Áo polo họa tiết in tràn ESTP001', 'PLHT', 420000, NULL, NULL, b'0', 'TORANO', '', 4, 1, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811327/7_9bc29d0a14064c70aca802cc201f2750_master.jpg.webp', 'IMAGE_1', b'1'),
('ESTP005', 'Áo polo trơn bo kẻ, logo cánh tay ESTP005', 'PLBK', 420000, NULL, NULL, b'0', 'TORANO', 'Áo polo trơn bo kẻ, logo cánh tay ESTP005', 4, 1, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811464/estp005_52833497146_o_19f6e6d8b44947d4bcd7461012e1e40d_master.jpg.jpg', 'IMAGE_1', b'1'),
('ESTP007', 'Áo Polo can phối 3 màu ESTP007', 'PLCP', 420000, NULL, NULL, b'0', 'TORANO', 'Áo polo nam cao cấp đẹp, tôn dáng. Chất vải dệt mềm, dày dặn không bai xù nhăn nhàu', 4, 2, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811282/52898691562_67c82c3ca7_o_9da334afa0244604bf21a0d59cf2a7f2_master.jpg.webp', 'IMAGE_1', b'1'),
('ESTP010', 'Áo polo trơn bo kẻ ESTP010', 'PLBK', 400000, NULL, NULL, b'0', 'TORANO', '', 5, 3, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811545/tp010---bk603-_8__b6487398009b4c6eaa1950ee0f26e718_master.jpg.webp', 'IMAGE_1', b'1'),
('ESTP012', 'Áo Polo kẻ dệt ngang 1.ESTP012', 'PLK', 500000, NULL, NULL, b'0', 'TORANO', '', 4, 1, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811086/tp012_0d295f194e3f4f0eab7eede288c3a7c5_master.jpg.webp', 'IMAGE_1', b'1'),
('ESTP014', 'Áo Polo kẻ dệt ngang 1.ESTP014', 'PLK', 500000, NULL, NULL, b'0', 'TORANO', '', 4, 1, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811112/estp014_f4dabbabbe0346598163050a85b06f1a_master.jpg.webp', 'IMAGE_1', b'1'),
('ESTP015', 'Áo polo can phối Horizontal Color Scheme 1.ESTP015', 'PLCP', 450000, NULL, NULL, b'0', 'TORANO', '', 4, 1, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811242/estp015_a0e07e027c614085b06c261c289544ab_master.jpg.webp', 'IMAGE_1', b'1'),
('ESTP017', 'Áo polo can phối Horizontal Color Scheme ESTP017', 'PLCP', 420000, NULL, NULL, b'0', 'TORANO', '', 4, 1, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811175/52985905053_bdeffa314e_o_aa67bed06deb439399cc2046790f8c59_master.jpg.jpg', 'IMAGE_1', b'1'),
('ESTP018', 'Áo polo can phối, thêu logo ngực ESTP018', 'PLCP', 420000, NULL, NULL, b'0', 'TORANO', 'Áo polo can phối, thêu logo ngực ESTP018', 4, 1, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811140/tp018_0691972d076d4071a4fee5291912df9e_master.jpg.webp', 'IMAGE_1', b'1'),
('ESTP020', 'Áo Polo can phối 3 màu ESTP020', 'PLCP', 450000, NULL, NULL, b'0', 'TORANO', '', 4, 1, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811280/tp020---bk001-_10__b44a6900b6934440ad797f313b2cdd9a_master.jpg.webp', 'IMAGE_1', b'1'),
('ESTP021', 'Áo polo can phối, thêu logo ngực ESTP021', 'PLCP', 550000, 450000, 18, b'1', 'TORANO', '', 4, 1, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811124/estp021-2_7b1e8ac1a10c4163bf199b7b89332d81_master.jpg.webp', 'IMAGE_1', b'1'),
('ESTP022', 'Áo polo can phối vai ESTP022', 'PLCP', 450000, NULL, NULL, b'0', 'TORANO', 'Áo polo nam cao cấp đẹp, tôn dáng. Chất vải dệt mềm, dày dặn không bai xù nhăn nhàu', 5, 2, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811171/52901478774_f103d7180e_o_6ec337721b6d4a8bae3c2626bca7d037_master.jpg.webp', 'IMAGE_1', b'1'),
('ESTP023', 'Áo Polo can phối họa tiết TRN ESTP023', 'PLCP', 420000, NULL, NULL, b'0', 'TORANO', 'Áo Polo can phối họa tiết nam phong cách trẻ trung và lịch lãm thích hợp với mọi dáng người.', 4, 1, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811255/1_4554a899fc974e40bc58638b060b31ee_master.jpg.webp', 'IMAGE_1', b'1'),
('ESTP028', 'Áo polo trơn bo kẻ cổ V, in logo ngực ESTP028', 'PLBK', 420000, NULL, NULL, b'0', 'TORANO', '', 5, 4, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811570/tp028---bk004-_11__9246a1d8b0184518abd852704bd4fa02_master.jpg.webp', 'IMAGE_1', b'1'),
('ESTP032', 'Áo polo trơn bo kẻ ESTP032', 'PLBK', 400000, NULL, NULL, b'0', 'TORANO', '', 4, 3, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811526/estp032-3_f94042405af64ca581ca72c753b53b51_master.jpg.webp', 'IMAGE_1', b'1'),
('ESTP033', 'Áo polo trơn bo kẻ phối viền cổ ESTP033', 'PLBK', 420000, NULL, NULL, b'0', 'TORANO', 'Áo polo trơn bo kẻ phối viền cổ cao cấp', 4, 1, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811351/m1t1_9a04e0331596472281861b7f44cc3ca2_master.jpg.webp', 'IMAGE_1', b'1'),
('ESTP038', 'Áo Polo trơn basic đen thêu logo ngực ESTP038', 'PLT', 330000, 200000, 39, b'1', 'TORANO', 'Áo Polo trơn TORANO cổ bẻ tay ngắn trơn, bo kẻ nhiều màu ESTP038 chính là item hoàn hảo dễ mặc dễ phối đồ cho cả nam và nữ. Khám phá ngay!!!\r\n\r\n+ Chất vải có độ co giãn tốt, thoáng khí và không phai màu.\r\n\r\n+60% Poly +35% cotton +5% Spandex\r\n\r\n+ Thấm hút mồ hôi tối đa và thoải mái khi vận động\r\n\r\n+ Thiết kế Slimfit vừa vặn tôn dáng\r\n\r\n+ Phù hợp với đi làm, đi học, đi chơi, hẹn hò, du lịch...\r\n\r\n+ Áo có 4 size : S – M –L – XL\r\n\r\nHướng dẫn sử dụng và bảo quản:\r\n\r\n+ Giặt ở nhiệt độ bình thường, với đồ có màu tương tự.\r\n\r\n+ Không được dùng hóa chất tẩy.\r\n\r\n+ Hạn chế sử dụng máy sấy và ủi ở nhiệt độ thích hợp.\r\n\r\n+ Lộn mặt trái khi phơi tránh bị phai màu\r\n\r\nChính sách và điều kiện đổi trả của TORANO:\r\n\r\n+ Cam kết chất lượng và mẫu mã sản phẩm giống với hình ảnh.\r\n\r\n+ Cam kết được đổi trả hàng trong vòng 7 ngày.\r\n\r\n+ Hàng phải còn nguyên tem mác và chưa qua sử dụng\r\n\r\n+ Sản phẩm bị lỗi do vận chuyển và do nhà sản xuất', 5, 1, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811636/tp038-1.jpeg.webp', 'IMAGE_1', b'1'),
('ESTP041', 'Áo Polo trơn hiệu ứng ESTP041', 'PLT', 450000, NULL, NULL, b'0', 'TORANO', 'Áo polo nam cao cấp chống nhăn nhàu đang hot tại Torano', 4, 5, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811461/estp041-16_4cb9d42d84e7436884bd3f4e648621ed_master.jpg.webp', 'IMAGE_1', b'1'),
('ESTP042', 'Áo Polo trơn vải lục giác kèm logo ngực ESTP042', 'PLT', 380000, 349000, 8, b'1', 'TORANO', 'Mẫu áo polo chất liệu cải tiến thế hệ mới mang lại cho các anh sự thoải mái cũng như vẻ ngoài lịch sự và đầy nam tính.', 5, 9, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811418/tp042---bk004-_9__2efe604ac9324e06841cf8edc590e169_master.jpg.webp', 'IMAGE_1', b'1'),
('ESTP047', 'Áo Polo len bo kẻ cổ 2.ESTP047', 'PLBK', 500000, NULL, NULL, b'0', 'TORANO', 'Áo polo len bo kẻ nam cao cấp chính hãng Torano. Chất vải len dệt chắc chắn, không xù và dão.', 4, 2, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811054/5_66590d1cba6041359e8a89a1c7e0feb5_master.jpg.webp', 'IMAGE_1', b'1'),
('ESTP060', 'Áo Polo can phối 2 màu ESTP060', 'PLCP', 420000, NULL, NULL, b'0', 'TORANO', 'Áo polo nam cao cấp đẹp, tôn dáng. Chất vải dệt mềm, dày dặn không bai xù nhăn nhàu', 4, 2, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811325/3_a6cdb2c46dd543fd9507418aef06c558_master.jpg.webp', 'IMAGE_1', b'1'),
('ESTP067', 'Áo Polo trơn bo kẻ cổ ESTP067', 'PLBK', 380000, NULL, NULL, b'0', 'TORANO', '', 5, 3, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811574/tp067---bk004-_16__bc6a55b32ddb4d94bc5c0fa5a7997db4_master.jpg.webp', 'IMAGE_1', b'1'),
('ESTP074', 'Áo Polo trơn bo kẻ ESTP074', 'PLBK', 420000, NULL, NULL, b'0', 'TORANO', 'Áo Polo nam trơn bo kẻ cao cấp phong cách trẻ trung và lịch lãm thích hợp với mọi dáng người.', 4, 2, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811013/1701361255452_1_50f16dbd5df34aa3acc99865b4820084_master.jpg.webp', 'IMAGE_1', b'1'),
('ESTS021', 'Áo T shirt họa tiết in Color scheme ESTS021', 'TIH', 300000, NULL, NULL, b'0', 'TORANO', '', 4, 2, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810897/1702717756318_ests021_64a34ff68d6d4857bae234b1364576fc_master.jpg.webp', 'IMAGE_1', b'1'),
('ESTS036', 'Áo T shirt họa tiết in Anxiety Disorders 2.ESTS036', 'TIH', 300000, NULL, NULL, b'0', 'TORANO', '', 4, 2, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810443/1702802725844_52932058522_9aba18e17a_o_e54f4d9597d9417c80ecba97a29c218c_master.jpg.webp', 'IMAGE_1', b'1'),
('ESTS038', 'Áo T shirt họa tiết in Vagabond 2.ESTS038', 'TIH', 300000, NULL, NULL, b'0', 'TORANO', '', 4, 2, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810394/1702802210675_52933043930_8da87d7a6c_o_1af3f2feba9545f8be8a0a196b8b2567_master.jpg.jpg.webp', 'IMAGE_1', b'1'),
('ESTS040', 'Áo T shirt họa tiết in Smithereens 2.ESTS040', 'TIH', 300000, NULL, NULL, b'0', 'TORANO', '', 4, 2, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810947/1702703208795_ests040-2_52988193045_o_8fd6a00033484ba78cd9122314ac7912_master.jpg.webp', 'IMAGE_1', b'1'),
('ESTS044', 'Áo T shirt họa tiết in monogram TRN 1.ESTS044', 'TIH', 300000, NULL, NULL, b'0', 'TORANO', '', 4, 1, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810918/1702717326862_ests044-3_52952396788_o_5673812b89994da69cfc7ad22ca9677e_master.jpg.webp', 'IMAGE_1', b'1'),
('ESTS046', 'Áo T shirt họa tiết in hình Intense ESTS046', 'TIH', 300000, NULL, NULL, b'0', 'TORANO', '', 4, 1, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810418/1702802457873_52932806289_bc52c62c78_o_f52bd9c5a85245f994c7648225599922_master.jpg.webp', 'IMAGE_1', b'1'),
('EWBS001', 'Quần nỉ trơn basic vải hiệu ứng 3.EWBS001', 'QN', 400000, NULL, NULL, b'0', 'TORANO', '', 4, 3, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810132/1704251898000_tw003-bs001-3_53291377849_o_110158d740fc40de9fceb818bda1132b_master.jpg.webp', 'IMAGE_5', b'1'),
('EWCL003', 'Áo khoác 2 lớp da lộn basic 1.EWCL003', 'AKBB', 890000, NULL, NULL, b'0', 'TORANO', '', 4, 1, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810171/1704250844877_ewcl003-7_53376839244_o_be698d6fa9ab4f78bf2132679fc67647_master.jpg.webp', 'IMAGE_5', b'1'),
('EWCP002', 'Áo khoác Hooded Puffer 4.EWCP002', 'AKP', 1200000, NULL, NULL, b'0', 'TORANO', '', 4, 3, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810156/1704251255837_ewcp002-30_53376967025_o_d452a9fe67ca4f9b9803a72fa15b64fd_master.jpg.webp', 'IMAGE_5', b'1'),
('EWCW007', 'Áo khoác gió 1 lớp mũ liền EWCW007', 'AKG', 50000, NULL, NULL, b'0', 'TORANO', 'Áo khoác gió 1 lớp mũ liền chống nước giá siêu tốt của nhà Torano đã cập bến.\r\n', 4, 3, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810212/1704189991841_ewcw007-1_c8b1f230ddb2408daa72728d0ecee531_master.jpg.webp', 'IMAGE_5', b'1'),
('EWTE003', 'Áo len kẻ ngang cổ tròn 2.EWTE003', 'ALK', 520000, NULL, NULL, b'0', 'TORANO', '', 4, 2, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810003/1708267758762_ewte003-10_53297045794_o_af9bd1f2fa8246dab498a75b2a976f04_master.jpg.jpg', 'IMAGE_5', b'1'),
('EWTW003', 'Áo nỉ trơn basic vải hiệu ứng 3.EWTW003', 'ANT', 380000, NULL, NULL, b'0', 'TORANO', '', 5, 3, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711810052/1707657567773_tw003-bs001-6_53291471625_o_1f620c3d758e41d696fb128d159744a2_master.jpg.webp', 'IMAGE_5', b'1'),
('test', 'test', 'QJB', 123465, 123456, 0, b'1', 'test', 'test', 0, 0, NULL, 'IMAGE_4', b'1'),
('TP004', 'Áo polo phối màu color-block 1.TP004', 'PLHT', 450000, NULL, NULL, b'0', 'TORANO', 'Áo polo phối màu color-block TP004', 4, 1, 'https://res.cloudinary.com/dmmvhjl0m/image/upload/v1711811025/tp004_45415f65d7bc4f4c8d52f4893d682a43_master.jpg.webp', 'IMAGE_1', b'1');

--
-- Bẫy `products`
--
DELIMITER $$
CREATE TRIGGER `insertProduct` BEFORE INSERT ON `products` FOR EACH ROW BEGIN
  
    IF NEW.discount_price IS NOT NULL THEN
    SET NEW.`discount_percent` = ((NEW.`price` - 				NEW.`discount_price`) / NEW.`price`) * 100;
    SET NEW.`is_discount` = 1;
    ELSE
    SET NEW.`discount_percent`= NULL;
    SET NEW.`is_discount` = 0;
    END IF;
     
    IF NEW.total_color IS NULL THEN
    SET NEW.total_color = (
    SELECT COUNT(DISTINCT color_id)
    FROM products_detail
    WHERE product_id = NEW.product_id
    );
    END IF;
    
    IF NEW.total_size IS NULL THEN
    SET NEW.total_size = (
    SELECT COUNT(DISTINCT size)
    FROM products_detail
    WHERE product_id = NEW.product_id
    );
    END IF;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `updateProducts` BEFORE UPDATE ON `products` FOR EACH ROW BEGIN
    IF NEW.discount_price IS NOT NULL THEN
    SET NEW.`discount_percent` = ((NEW.`price` - 				NEW.`discount_price`) / NEW.`price`) * 100;
    SET NEW.`is_discount` = 1;
    ELSE
    SET NEW.`discount_percent`= NULL;
    SET NEW.`is_discount` = 0;
    END IF;
     
    IF NEW.total_color IS NULL THEN
    SET NEW.total_color = (
    SELECT COUNT(DISTINCT color_id)
    FROM products_detail
    WHERE product_id = NEW.product_id
    );
    END IF;
    
    IF NEW.total_size IS NULL THEN
    SET NEW.total_size = (
    SELECT COUNT(DISTINCT size)
    FROM products_detail
    WHERE product_id = NEW.product_id
    );
    END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `products_detail`
--

CREATE TABLE `products_detail` (
  `product_detail_id` int(10) NOT NULL,
  `product_id` varchar(15) DEFAULT NULL,
  `code` varchar(30) DEFAULT NULL,
  `color_id` varchar(5) NOT NULL,
  `size` varchar(10) NOT NULL,
  `quantity` int(11) DEFAULT NULL,
  `out_of_stock` bit(1) DEFAULT NULL,
  `product_detail_active` bit(1) DEFAULT b'1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `products_detail`
--

INSERT INTO `products_detail` (`product_detail_id`, `product_id`, `code`, `color_id`, `size`, `quantity`, `out_of_stock`, `product_detail_active`) VALUES
(1, 'ESTP038', 'ESTP03872PE00SB_BL-S', 'BL', 'SIZE_S', 0, b'0', b'1'),
(2, 'ESTP038', 'ESTP03872PE00SB_BL-M', 'BL', 'SIZE_M', 0, b'0', b'1'),
(3, 'ESTP038', 'ESTP03872PE00SB_BL-L', 'BL', 'SIZE_L', 0, b'0', b'1'),
(4, 'ESTP038', 'ESTP03872PE00SB_BL-XL', 'BL', 'SIZE_XL', 999, b'1', b'1'),
(5, 'ESTP038', 'ESTP03872PE00SB_BL-XXL', 'BL', 'SIZE_XXL', 999, b'1', b'1'),
(6, 'ESTP067', 'ESTP06772TC00SB_NV-S', 'NV', 'SIZE_S', 999, b'1', b'1'),
(7, 'ESTP067', 'ESTP06772TC00SB_NV-M', 'NV', 'SIZE_M', 999, b'1', b'1'),
(8, 'ESTP067', 'ESTP06772TC00SB_NV-L', 'NV', 'SIZE_L', 999, b'1', b'1'),
(9, 'ESTP067', 'ESTP06772TC00SB_NV-XL', 'NV', 'SIZE_XL', 999, b'1', b'1'),
(10, 'ESTP067', 'ESTP06772TC00SB_NV-XXL', 'NV', 'SIZE_XXL', 999, b'1', b'1'),
(11, 'ESTP067', 'ESTP06772TC00SB_WH-S', 'WH', 'SIZE_S', 999, b'1', b'1'),
(12, 'ESTP067', 'ESTP06772TC00SB_WH-M', 'WH', 'SIZE_M', 999, b'1', b'1'),
(13, 'ESTP067', 'ESTP06772TC00SB_WH-L', 'WH', 'SIZE_L', 999, b'1', b'1'),
(14, 'ESTP067', 'ESTP06772TC00SB_WH-XL', 'WH', 'SIZE_XL', 999, b'1', b'1'),
(15, 'ESTP067', 'ESTP06772TC00SB_WH-XXL', 'WH', 'SIZE_XXL', 999, b'1', b'1'),
(16, 'ESTP067', 'ESTP06772TC00SB_BL-S', 'BL', 'SIZE_S', 999, b'1', b'1'),
(17, 'ESTP067', 'ESTP06772TC00SB_BL-M', 'BL', 'SIZE_M', 999, b'1', b'1'),
(18, 'ESTP067', 'ESTP06772TC00SB_BL-L', 'BL', 'SIZE_L', 999, b'1', b'1'),
(19, 'ESTP067', 'ESTP06772TC00SB_BL-XL', 'BL', 'SIZE_XL', 999, b'1', b'1'),
(20, 'ESTP067', 'ESTP06772TC00SB_BL-XXL', 'BL', 'SIZE_XXL', 999, b'1', b'1'),
(26, 'ESTP028', 'ESTP02872CV00SB_DCB-S', 'DCB', 'SIZE_S', 999, b'1', b'1'),
(27, 'ESTP028', 'ESTP02872CV00SB_DCB-M', 'DCB', 'SIZE_M', 999, b'1', b'1'),
(28, 'ESTP028', 'ESTP02872CV00SB_DCB-L', 'DCB', 'SIZE_L', 999, b'1', b'1'),
(29, 'ESTP028', 'ESTP02872CV00SB_DCB-XL', 'DCB', 'SIZE_XL', 999, b'1', b'1'),
(30, 'ESTP028', 'ESTP02872CV00SB_DCB-XXL', 'DCB', 'SIZE_XXL', 999, b'1', b'1'),
(31, 'ESTP028', 'ESTP02872CV00SB_WH-S', 'WH', 'SIZE_S', 0, b'0', b'1'),
(32, 'ESTP028', 'ESTP02872CV00SB_WH-M', 'WH', 'SIZE_M', 0, b'0', b'1'),
(33, 'ESTP028', 'ESTP02872CV00SB_WH-L', 'WH', 'SIZE_L', 999, b'1', b'1'),
(34, 'ESTP028', 'ESTP02872CV00SB_WH-XL', 'WH', 'SIZE_XL', 999, b'1', b'1'),
(35, 'ESTP028', 'ESTP02872CV00SB_WH-XXL', 'WH', 'SIZE_XXL', 999, b'1', b'1'),
(36, 'ESTP028', 'ESTP02872CV00SB_BL-S', 'BL', 'SIZE_S', 0, b'0', b'1'),
(37, 'ESTP028', 'ESTP02872CV00SB_BL-M', 'BL', 'SIZE_M', 0, b'0', b'1'),
(38, 'ESTP028', 'ESTP02872CV00SB_BL-L', 'BL', 'SIZE_L', 999, b'1', b'1'),
(39, 'ESTP028', 'ESTP02872CV00SB_BL-XL', 'BL', 'SIZE_XL', 0, b'0', b'1'),
(40, 'ESTP028', 'ESTP02872CV00SB_BL-XXL', 'BL', 'SIZE_XXL', 0, b'0', b'1'),
(41, 'ESTP028', 'ESTP02872CV00SB_NV-S', 'NV', 'SIZE_S', 999, b'1', b'1'),
(42, 'ESTP028', 'ESTP02872CV00SB_NV-M', 'NV', 'SIZE_M', 0, b'0', b'1'),
(43, 'ESTP028', 'ESTP02872CV00SB_NV-L', 'NV', 'SIZE_L', 0, b'0', b'1'),
(44, 'ESTP028', 'ESTP02872CV00SB_NV-XL', 'NV', 'SIZE_XL', 0, b'0', b'1'),
(45, 'ESTP028', 'ESTP02872CV00SB_NV-XXL', 'NV', 'SIZE_XXL', 0, b'0', b'1'),
(46, 'DSTP611', 'DSTP61172CX00SB_WH-S', 'WH', 'SIZE_S', 777, b'1', b'1'),
(47, 'DSTP611', 'DSTP61172CX00SB_WH-M', 'WH', 'SIZE_M', 999, b'1', b'1'),
(48, 'DSTP611', 'DSTP61172CX00SB_WH-L', 'WH', 'SIZE_L', 999, b'1', b'1'),
(49, 'DSTP611', 'DSTP61172CX00SB_WH-XL', 'WH', 'SIZE_XL', 999, b'1', b'1'),
(50, 'ESTP010', 'ESTP01072TC00SB_DGN-S', 'DGN', 'SIZE_S', 999, b'1', b'1'),
(51, 'ESTP010', 'ESTP01072TC00SB_DGN-M', 'DGN', 'SIZE_M', 999, b'1', b'1'),
(52, 'ESTP010', 'ESTP01072TC00SB_DGN-L', 'DGN', 'SIZE_L', 999, b'1', b'1'),
(53, 'ESTP010', 'ESTP01072TC00SB_DGN-XL', 'DGN', 'SIZE_XL', 999, b'1', b'1'),
(54, 'ESTP010', 'ESTP01072TC00SB_DGN-XXL', 'DGN', 'SIZE_XXL', 999, b'1', b'1'),
(55, 'ESTP010', 'ESTP01072TC00SB_CR-S', 'CR', 'SIZE_S', 999, b'1', b'1'),
(56, 'ESTP010', 'ESTP01072TC00SB_CR-M', 'CR', 'SIZE_M', 999, b'1', b'1'),
(57, 'ESTP010', 'ESTP01072TC00SB_CR-L', 'CR', 'SIZE_L', 999, b'1', b'1'),
(58, 'ESTP010', 'ESTP01072TC00SB_CR-XL', 'CR', 'SIZE_XL', 999, b'1', b'1'),
(59, 'ESTP010', 'ESTP01072TC00SB_CR-XXL', 'CR', 'SIZE_XXL', 999, b'1', b'1'),
(60, 'ESTP010', 'ESTP01072TC00SB_WH-S', 'WH', 'SIZE_S', 999, b'1', b'1'),
(61, 'ESTP010', 'ESTP01072TC00SB_WH-M', 'WH', 'SIZE_M', 999, b'1', b'1'),
(62, 'ESTP010', 'ESTP01072TC00SB_WH-L', 'WH', 'SIZE_L', 999, b'1', b'1'),
(63, 'ESTP010', 'ESTP01072TC00SB_WH-XL', 'WH', 'SIZE_XL', 999, b'1', b'1'),
(64, 'ESTP010', 'ESTP01072TC00SB_WH-XXL', 'WH', 'SIZE_XXL', 999, b'1', b'1'),
(65, 'ESTP032', 'ESTP03272TC00SB_BE-S', 'BE', 'SIZE_S', 999, b'1', b'1'),
(66, 'ESTP032', 'ESTP03272TC00SB_BE-M', 'BE', 'SIZE_M', 999, b'1', b'1'),
(67, 'ESTP032', 'ESTP03272TC00SB_BE-L', 'BE', 'SIZE_L', 999, b'1', b'1'),
(68, 'ESTP032', 'ESTP03272TC00SB_BE-XL', 'BE', 'SIZE_XL', 999, b'1', b'1'),
(69, 'ESTP032', 'ESTP03272TC00SB_BR-S', 'BR', 'SIZE_S', 999, b'1', b'1'),
(70, 'ESTP032', 'ESTP03272TC00SB_BR-M', 'BR', 'SIZE_M', 999, b'1', b'1'),
(71, 'ESTP032', 'ESTP03272TC00SB_BR-L', 'BR', 'SIZE_L', 999, b'1', b'1'),
(72, 'ESTP032', 'ESTP03272TC00SB_BR-XL', 'BR', 'SIZE_XL', 999, b'1', b'1'),
(73, 'ESTP032', 'ESTP03272TC00SB_WH-S', 'WH', 'SIZE_S', 999, b'1', b'1'),
(74, 'ESTP032', 'ESTP03272TC00SB_WH-M', 'WH', 'SIZE_M', 999, b'1', b'1'),
(75, 'ESTP032', 'ESTP03272TC00SB_WH-L', 'WH', 'SIZE_L', 999, b'1', b'1'),
(76, 'ESTP032', 'ESTP03272TC00SB_WH-XL', 'WH', 'SIZE_XL', 999, b'1', b'1'),
(77, 'ESTP074', 'ESTP07472CT00SB_NV-S', 'NV', 'SIZE_S', 999, b'1', b'1'),
(78, 'ESTP074', 'ESTP07472CT00SB_NV-M', 'NV', 'SIZE_M', 999, b'1', b'1'),
(79, 'ESTP074', 'ESTP07472CT00SB_NV-L', 'NV', 'SIZE_L', 999, b'1', b'1'),
(80, 'ESTP074', 'ESTP07472CT00SB_NV-XL', 'NV', 'SIZE_XL', 999, b'1', b'1'),
(81, 'ESTP074', 'ESTP07472CT00SB_WH-S', 'WH', 'SIZE_S', 999, b'1', b'1'),
(82, 'ESTP074', 'ESTP07472CT00SB_WH-M', 'WH', 'SIZE_M', 998, b'1', b'1'),
(83, 'ESTP074', 'ESTP07472CT00SB_WH-L', 'WH', 'SIZE_L', 999, b'1', b'1'),
(84, 'ESTP074', 'ESTP07472CT00SB_WH-XL', 'WH', 'SIZE_XL', 999, b'1', b'1'),
(85, 'ESTP005', 'ESTP00572CT00SB_DNV-S', 'DNV', 'SIZE_S', 999, b'1', b'1'),
(86, 'ESTP005', 'ESTP00572CT00SB_DNV-M', 'DNV', 'SIZE_M', 999, b'1', b'1'),
(87, 'ESTP005', 'ESTP00572CT00SB_DNV-L', 'DNV', 'SIZE_L', 999, b'1', b'1'),
(88, 'ESTP005', 'ESTP00572CT00SB_DNV-XL', 'DNV', 'SIZE_XL', 999, b'1', b'1'),
(89, 'ESTP041', 'ESTP04172CV01SB_DCR-S', 'DCR', 'SIZE_S', 0, b'0', b'1'),
(90, 'ESTP041', 'ESTP04172CV01SB_DCR-M', 'DCR', 'SIZE_M', 999, b'1', b'1'),
(91, 'ESTP041', 'ESTP04172CV01SB_DCR-L', 'DCR', 'SIZE_L', 999, b'1', b'1'),
(92, 'ESTP041', 'ESTP04172CV01SB_DCR-XL', 'DCR', 'SIZE_XL', 999, b'1', b'1'),
(93, 'ESTP041', 'ESTP04172CV01SB_BL-S', 'BL', 'SIZE_S', 999, b'1', b'1'),
(94, 'ESTP041', 'ESTP04172CV01SB_BL-M', 'BL', 'SIZE_M', 999, b'1', b'1'),
(95, 'ESTP041', 'ESTP04172CV01SB_BL-L', 'BL', 'SIZE_L', 999, b'1', b'1'),
(96, 'ESTP041', 'ESTP04172CV01SB_BL-XL', 'BL', 'SIZE_XL', 999, b'1', b'1'),
(97, 'ESTP041', 'ESTP04172CV01SB_CN-S', 'CN', 'SIZE_S', 999, b'1', b'1'),
(98, 'ESTP041', 'ESTP04172CV01SB_CN-M', 'CN', 'SIZE_M', 999, b'1', b'1'),
(99, 'ESTP041', 'ESTP04172CV01SB_CN-L', 'CN', 'SIZE_L', 999, b'1', b'1'),
(100, 'ESTP041', 'ESTP04172CV01SB_CN-XL', 'CN', 'SIZE_XL', 999, b'1', b'1'),
(101, 'ESTP041', 'ESTP04172CV01SB_DNV-S', 'DNV', 'SIZE_S', 999, b'1', b'1'),
(102, 'ESTP041', 'ESTP04172CV01SB_DNV-M', 'DNV', 'SIZE_M', 999, b'1', b'1'),
(103, 'ESTP041', 'ESTP04172CV01SB_DNV-L', 'DNV', 'SIZE_L', 999, b'1', b'1'),
(104, 'ESTP041', 'ESTP04172CV01SB_DNV-XL', 'DNV', 'SIZE_XL', 999, b'1', b'1'),
(105, 'ESTP041', 'ESTP04172CV01SB_WH-S', 'WH', 'SIZE_S', 999, b'1', b'1'),
(106, 'ESTP041', 'ESTP04172CV01SB_WH-M', 'WH', 'SIZE_M', 999, b'1', b'1'),
(107, 'ESTP041', 'ESTP04172CV01SB_WH-L', 'WH', 'SIZE_L', 999, b'1', b'1'),
(108, 'ESTP041', 'ESTP04172CV01SB_WH-XL', 'WH', 'SIZE_XL', 999, b'1', b'1'),
(109, 'ESTP042', 'ESTP04272CV00SB_BR-S', 'BR', 'SIZE_S', 999, b'1', b'1'),
(110, 'ESTP042', 'ESTP04272CV00SB_BR-M', 'BR', 'SIZE_M', 999, b'1', b'1'),
(111, 'ESTP042', 'ESTP04272CV00SB_BR-L', 'BR', 'SIZE_L', 999, b'1', b'1'),
(112, 'ESTP042', 'ESTP04272CV00SB_BR-XL', 'BR', 'SIZE_XL', 999, b'1', b'1'),
(113, 'ESTP042', 'ESTP04272CV00SB_BR-XXL', 'BR', 'SIZE_XXL', 999, b'1', b'1'),
(114, 'ESTP042', 'ESTP04272CV00SB_LI-S', 'LI', 'SIZE_S', 999, b'1', b'1'),
(115, 'ESTP042', 'ESTP04272CV00SB_LI-M', 'LI', 'SIZE_M', 999, b'1', b'1'),
(116, 'ESTP042', 'ESTP04272CV00SB_LI-L', 'LI', 'SIZE_L', 999, b'1', b'1'),
(117, 'ESTP042', 'ESTP04272CV00SB_LI-XL', 'LI', 'SIZE_XL', 999, b'1', b'1'),
(118, 'ESTP042', 'ESTP04272CV00SB_LI-XXL', 'LI', 'SIZE_XXL', 999, b'1', b'1'),
(119, 'ESTP042', 'ESTP04272CV00SB_BL-S', 'BL', 'SIZE_S', 999, b'1', b'1'),
(120, 'ESTP042', 'ESTP04272CV00SB_BL-M', 'BL', 'SIZE_M', 999, b'1', b'1'),
(121, 'ESTP042', 'ESTP04272CV00SB_BL-L', 'BL', 'SIZE_L', 999, b'1', b'1'),
(122, 'ESTP042', 'ESTP04272CV00SB_BL-XL', 'BL', 'SIZE_XL', 999, b'1', b'1'),
(123, 'ESTP042', 'ESTP04272CV00SB_BL-XXL', 'BL', 'SIZE_XXL', 999, b'1', b'1'),
(124, 'ESTP042', 'ESTP04272CV00SB_NV-S', 'NV', 'SIZE_S', 999, b'1', b'1'),
(125, 'ESTP042', 'ESTP04272CV00SB_NV-M', 'NV', 'SIZE_M', 999, b'1', b'1'),
(126, 'ESTP042', 'ESTP04272CV00SB_NV-L', 'NV', 'SIZE_L', 999, b'1', b'1'),
(127, 'ESTP042', 'ESTP04272CV00SB_NV-XL', 'NV', 'SIZE_XL', 999, b'1', b'1'),
(128, 'ESTP042', 'ESTP04272CV00SB_NV-XXL', 'NV', 'SIZE_XXL', 999, b'1', b'1'),
(129, 'ESTP042', 'ESTP04272CV00SB_DTU-S', 'DTU', 'SIZE_S', 999, b'1', b'1'),
(130, 'ESTP042', 'ESTP04272CV00SB_DTU-M', 'DTU', 'SIZE_M', 999, b'1', b'1'),
(131, 'ESTP042', 'ESTP04272CV00SB_DTU-L', 'DTU', 'SIZE_L', 999, b'1', b'1'),
(132, 'ESTP042', 'ESTP04272CV00SB_DTU-XL', 'DTU', 'SIZE_XL', 999, b'1', b'1'),
(133, 'ESTP042', 'ESTP04272CV00SB_DTU-XXL', 'DTU', 'SIZE_XXL', 999, b'1', b'1'),
(134, 'ESTP042', 'ESTP04272CV00SB_TU-S', 'TU', 'SIZE_S', 999, b'1', b'1'),
(135, 'ESTP042', 'ESTP04272CV00SB_TU-M', 'TU', 'SIZE_M', 999, b'1', b'1'),
(136, 'ESTP042', 'ESTP04272CV00SB_TU-L', 'TU', 'SIZE_L', 999, b'1', b'1'),
(137, 'ESTP042', 'ESTP04272CV00SB_TU-XL', 'TU', 'SIZE_XL', 999, b'1', b'1'),
(138, 'ESTP042', 'ESTP04272CV00SB_TU-XXL', 'TU', 'SIZE_XXL', 999, b'1', b'1'),
(139, 'ESTP042', 'ESTP04272CV00SB_LYL-S', 'LYL', 'SIZE_S', 999, b'1', b'1'),
(140, 'ESTP042', 'ESTP04272CV00SB_LYL-M', 'LYL', 'SIZE_M', 999, b'1', b'1'),
(141, 'ESTP042', 'ESTP04272CV00SB_LYL-L', 'LYL', 'SIZE_L', 999, b'1', b'1'),
(142, 'ESTP042', 'ESTP04272CV00SB_LYL-XL', 'LYL', 'SIZE_XL', 999, b'1', b'1'),
(143, 'ESTP042', 'ESTP04272CV00SB_LYL-XXL', 'LYL', 'SIZE_XXL', 999, b'1', b'1'),
(144, 'ESTP042', 'ESTP04272CV00SB_CR-S', 'CR', 'SIZE_S', 999, b'1', b'1'),
(145, 'ESTP042', 'ESTP04272CV00SB_CR-M', 'CR', 'SIZE_M', 999, b'1', b'1'),
(146, 'ESTP042', 'ESTP04272CV00SB_CR-L', 'CR', 'SIZE_L', 999, b'1', b'1'),
(147, 'ESTP042', 'ESTP04272CV00SB_CR-XL', 'CR', 'SIZE_XL', 999, b'1', b'1'),
(148, 'ESTP042', 'ESTP04272CV00SB_CR-XXL', 'CR', 'SIZE_XXL', 999, b'1', b'1'),
(149, 'ESTP042', 'ESTP04272CV00SB_WH-S', 'WH', 'SIZE_S', 999, b'1', b'1'),
(150, 'ESTP042', 'ESTP04272CV00SB_WH-M', 'WH', 'SIZE_M', 999, b'1', b'1'),
(151, 'ESTP042', 'ESTP04272CV00SB_WH-L', 'WH', 'SIZE_L', 999, b'1', b'1'),
(152, 'ESTP042', 'ESTP04272CV00SB_WH-XL', 'WH', 'SIZE_XL', 999, b'1', b'1'),
(153, 'ESTP042', 'ESTP04272CV00SB_WH-XXL', 'WH', 'SIZE_XXL', 999, b'1', b'1'),
(154, 'ESTP033', 'ESTP03372CT00SB_BL-S', 'BL', 'SIZE_S', 999, b'1', b'1'),
(155, 'ESTP033', 'ESTP03372CT00SB_BL-M', 'BL', 'SIZE_M', 999, b'1', b'1'),
(156, 'ESTP033', 'ESTP03372CT00SB_BL-L', 'BL', 'SIZE_L', 999, b'1', b'1'),
(157, 'ESTP033', 'ESTP03372CT00SB_BL-XL', 'BL', 'SIZE_XL', 999, b'1', b'1'),
(158, 'ESTP001', 'ESTP00172TC04SB_WH-S', 'WH', 'SIZE_S', 999, b'1', b'1'),
(159, 'ESTP001', 'ESTP00172TC04SB_WH-M', 'WH', 'SIZE_M', 999, b'1', b'1'),
(160, 'ESTP001', 'ESTP00172TC04SB_WH-L', 'WH', 'SIZE_L', 999, b'1', b'1'),
(161, 'ESTP001', 'ESTP00172TC04SB_WH-XL', 'WH', 'SIZE_XL', 999, b'1', b'1'),
(162, 'ESTP060', 'ESTP06072CV32SB_NVC-S', 'NVC', 'SIZE_S', 999, b'1', b'1'),
(163, 'ESTP060', 'ESTP06072CV32SB_NVC-M', 'NVC', 'SIZE_M', 999, b'1', b'1'),
(164, 'ESTP060', 'ESTP06072CV32SB_NVC-L', 'NVC', 'SIZE_L', 999, b'1', b'1'),
(165, 'ESTP060', 'ESTP06072CV32SB_NVC-XL', 'NVC', 'SIZE_XL', 999, b'1', b'1'),
(166, 'ESTP060', 'ESTP06072CV32SB_HBR-S', 'HBR', 'SIZE_S', 999, b'1', b'1'),
(167, 'ESTP060', 'ESTP06072CV32SB_HBR-M', 'HBR', 'SIZE_M', 999, b'1', b'1'),
(168, 'ESTP060', 'ESTP06072CV32SB_HBR-L', 'HBR', 'SIZE_L', 999, b'1', b'1'),
(169, 'ESTP060', 'ESTP06072CV32SB_HBR-XL', 'HBR', 'SIZE_XL', 999, b'1', b'1'),
(170, 'ESTP007', 'ESTP00772CX32SB_WBL-S', 'WBL', 'SIZE_S', 999, b'1', b'1'),
(171, 'ESTP007', 'ESTP00772CX32SB_WBL-M', 'WBL', 'SIZE_M', 999, b'1', b'1'),
(172, 'ESTP007', 'ESTP00772CX32SB_WBL-L', 'WBL', 'SIZE_L', 999, b'1', b'1'),
(173, 'ESTP007', 'ESTP00772CX32SB_WBL-XL', 'WBL', 'SIZE_XL', 999, b'1', b'1'),
(174, 'ESTP007', 'ESTP00772CX32SB_WNV-S', 'WNV', 'SIZE_S', 999, b'1', b'1'),
(175, 'ESTP007', 'ESTP00772CX32SB_WNV-M', 'WNV', 'SIZE_M', 999, b'1', b'1'),
(176, 'ESTP007', 'ESTP00772CX32SB_WNV-L', 'WNV', 'SIZE_L', 999, b'1', b'1'),
(177, 'ESTP007', 'ESTP00772CX32SB_WNV-XL', 'WNV', 'SIZE_XL', 999, b'1', b'1'),
(178, 'ESTP020', 'ESTP02072TC32SB_BBR-S', 'BBR', 'SIZE_S', 999, b'1', b'1'),
(179, 'ESTP020', 'ESTP02072TC32SB_BBR-M', 'BBR', 'SIZE_M', 999, b'1', b'1'),
(180, 'ESTP020', 'ESTP02072TC32SB_BBR-L', 'BBR', 'SIZE_L', 999, b'1', b'1'),
(181, 'ESTP020', 'ESTP02072TC32SB_BBR-XL', 'BBR', 'SIZE_XL', 999, b'1', b'1'),
(182, 'ESTP023', 'ESTP02372CT32SB_NWH-S', 'NWH', 'SIZE_S', 999, b'1', b'1'),
(183, 'ESTP023', 'ESTP02372CT32SB_NWH-M', 'NWH', 'SIZE_M', 999, b'1', b'1'),
(184, 'ESTP023', 'ESTP02372CT32SB_NWH-L', 'NWH', 'SIZE_L', 999, b'1', b'1'),
(185, 'ESTP023', 'ESTP02372CT32SB_NWH-XL', 'NWH', 'SIZE_XL', 0, b'0', b'1'),
(186, 'ESTP015', 'ESTP01572CV32SB_WNV-S', 'WNV', 'SIZE_S', 999, b'1', b'1'),
(187, 'ESTP015', 'ESTP01572CV32SB_WNV-M', 'WNV', 'SIZE_M', 999, b'1', b'1'),
(188, 'ESTP015', 'ESTP01572CV32SB_WNV-L', 'WNV', 'SIZE_L', 999, b'1', b'1'),
(189, 'ESTP015', 'ESTP01572CV32SB_WNV-XL', 'WNV', 'SIZE_XL', 999, b'1', b'1'),
(190, 'DSTP903', 'DSTP90372CT32RB_WCB-S', 'WCB', 'SIZE_S', 999, b'1', b'1'),
(191, 'DSTP903', 'DSTP90372CT32RB_WCB-M', 'WCB', 'SIZE_M', 989, b'1', b'1'),
(192, 'DSTP903', 'DSTP90372CT32RB_WCB-L', 'WCB', 'SIZE_L', 994, b'1', b'1'),
(193, 'DSTP903', 'DSTP90372CT32RB_WCB-XL', 'WCB', 'SIZE_XL', 999, b'1', b'1'),
(194, 'DSTP903', 'DSTP90372CT32RB_HCR-S', 'HCR', 'SIZE_S', 999, b'1', b'1'),
(195, 'DSTP903', 'DSTP90372CT32RB_HCR-M', 'HCR', 'SIZE_M', 995, b'1', b'1'),
(196, 'DSTP903', 'DSTP90372CT32RB_HCR-L', 'HCR', 'SIZE_L', 999, b'1', b'1'),
(197, 'DSTP903', 'DSTP90372CT32RB_HCR-XL', 'HCR', 'SIZE_XL', 999, b'1', b'1'),
(198, 'ESTP017', 'ESTP01772CV32SB_BLE-S', 'BLE', 'SIZE_S', 999, b'1', b'1'),
(199, 'ESTP017', 'ESTP01772CV32SB_BLE-M', 'BLE', 'SIZE_M', 999, b'1', b'1'),
(200, 'ESTP017', 'ESTP01772CV32SB_BLE-L', 'BLE', 'SIZE_L', 999, b'1', b'1'),
(201, 'ESTP017', 'ESTP01772CV32SB_BLE-XL', 'BLE', 'SIZE_XL', 999, b'1', b'1'),
(202, 'ESTP022', 'ESTP02272CV32SB_WH-S', 'WH', 'SIZE_S', 999, b'1', b'1'),
(203, 'ESTP022', 'ESTP02272CV32SB_WH-M', 'WH', 'SIZE_M', 999, b'1', b'1'),
(204, 'ESTP022', 'ESTP02272CV32SB_WH-L', 'WH', 'SIZE_L', 999, b'1', b'1'),
(205, 'ESTP022', 'ESTP02272CV32SB_WH-XL', 'WH', 'SIZE_XL', 999, b'1', b'1'),
(206, 'ESTP022', 'ESTP02272CV32SB_WH-XXL', 'WH', 'SIZE_XXL', 0, b'0', b'1'),
(207, 'ESTP022', 'ESTP02272CV32SB_NV-S', 'NV', 'SIZE_S', 0, b'0', b'1'),
(208, 'ESTP022', 'ESTP02272CV32SB_NV-M', 'NV', 'SIZE_M', 0, b'0', b'1'),
(209, 'ESTP022', 'ESTP02272CV32SB_NV-L', 'NV', 'SIZE_L', 999, b'1', b'1'),
(210, 'ESTP022', 'ESTP02272CV32SB_NV-XL', 'NV', 'SIZE_XL', 0, b'0', b'1'),
(211, 'ESTP022', 'ESTP02272CV32SB_NV-XXL', 'NV', 'SIZE_XXL', 999, b'1', b'1'),
(212, 'ESTP018', 'ESTP01872CV32SB_NWH-S', 'WH', 'SIZE_S', 999, b'1', b'1'),
(213, 'ESTP018', 'ESTP01872CV32SB_NWH-M', 'WH', 'SIZE_M', 999, b'1', b'1'),
(214, 'ESTP018', 'ESTP01872CV32SB_NWH-L', 'WH', 'SIZE_L', 999, b'1', b'1'),
(215, 'ESTP018', 'ESTP01872CV32SB_NWH-XL', 'WH', 'SIZE_XL', 999, b'1', b'1'),
(224, 'ESTP021', 'ESTP02172CT32SB_NWH-S', 'WH', 'SIZE_S', 999, b'1', b'1'),
(225, 'ESTP021', 'ESTP02172CT32SB_NWH-M', 'WH', 'SIZE_M', 999, b'1', b'1'),
(226, 'ESTP021', 'ESTP02172CT32SB_NWH-L', 'WH', 'SIZE_L', 999, b'1', b'1'),
(227, 'ESTP021', 'ESTP02172CT32SB_NWH-XL', 'WH', 'SIZE_XL', 999, b'1', b'1'),
(232, 'ESTP014', 'ESTP01472CV08SB_BCR-S', 'BCR', 'SIZE_S', 999, b'1', b'1'),
(233, 'ESTP014', 'ESTP01472CV08SB_BCR-M', 'BCR', 'SIZE_M', 999, b'1', b'1'),
(234, 'ESTP014', 'ESTP01472CV08SB_BCR-L', 'BCR', 'SIZE_L', 998, b'1', b'1'),
(235, 'ESTP014', 'ESTP01472CV08SB_BCR-XL', 'BCR', 'SIZE_XL', 999, b'1', b'1'),
(240, 'ESTP012', 'ESTP01272CT08SB_VCB-S', 'VCB', 'SIZE_S', 999, b'1', b'1'),
(241, 'ESTP012', 'ESTP01272CT08SB_VCB-M', 'VCB', 'SIZE_M', 999, b'1', b'1'),
(242, 'ESTP012', 'ESTP01272CT08SB_VCB-L', 'VCB', 'SIZE_L', 999, b'1', b'1'),
(243, 'ESTP012', 'ESTP01272CT08SB_VCB-XL', 'VCB', 'SIZE_XL', 999, b'1', b'1'),
(244, 'DSTP650', 'DSTP65072CT04SB_BL-S', 'BL', 'SIZE_S', 998, b'1', b'1'),
(245, 'DSTP650', 'DSTP65072CT04SB_BL-M', 'BL', 'SIZE_M', 999, b'1', b'1'),
(246, 'DSTP650', 'DSTP65072CT04SB_BL-L', 'BL', 'SIZE_L', 997, b'1', b'1'),
(247, 'DSTP650', 'DSTP65072CT04SB_BL-XL', 'BL', 'SIZE_XL', 998, b'1', b'1'),
(248, 'ESTP047', 'ESTP04772CA00SB_DCR-S', 'DCR', 'SIZE_S', 999, b'1', b'1'),
(249, 'ESTP047', 'ESTP04772CA00SB_DCR-M', 'DCR', 'SIZE_M', 999, b'1', b'1'),
(250, 'ESTP047', 'ESTP04772CA00SB_DCR-L', 'DCR', 'SIZE_L', 999, b'1', b'1'),
(251, 'ESTP047', 'ESTP04772CA00SB_DCR-XL', 'DCR', 'SIZE_XL', 999, b'1', b'1'),
(252, 'ESTP047', 'ESTP04772CA00SB_BL-S', 'BL', 'SIZE_S', 999, b'1', b'1'),
(253, 'ESTP047', 'ESTP04772CA00SB_BL-M', 'BL', 'SIZE_M', 999, b'1', b'1'),
(254, 'ESTP047', 'ESTP04772CA00SB_BL-L', 'BL', 'SIZE_L', 999, b'1', b'1'),
(255, 'ESTP047', 'ESTP04772CA00SB_BL-XL', 'BL', 'SIZE_XL', 999, b'1', b'1'),
(256, 'TP004', 'DSTP00472CV32SB_BL-S', 'BL', 'SIZE_S', 999, b'1', b'1'),
(257, 'TP004', 'DSTP00472CV32SB_BL-M', 'BL', 'SIZE_M', 999, b'1', b'1'),
(258, 'TP004', 'DSTP00472CV32SB_BL-L', 'BL', 'SIZE_L', 999, b'1', b'1'),
(259, 'TP004', 'DSTP00472CV32SB_BL-XL', 'BL', 'SIZE_XL', 999, b'1', b'1'),
(271, 'ESTA010', 'ESTA01012CT06MB_NV-M', 'NV', 'SIZE_M', 999, b'1', b'1'),
(272, 'ESTA010', 'ESTA01012CT06MB_NV-S', 'NV', 'SIZE_S', 0, b'0', b'1'),
(273, 'ESTA010', 'ESTA01012CT06MB_NV-L', 'NV', 'SIZE_L', 0, b'0', b'1'),
(277, 'ESTA010', 'ESTA01012CT06MB_NV-XL', 'NV', 'SIZE_XL', 0, b'0', b'1'),
(283, 'ESTA006', 'ESTA00612CT06MB_BL-M', 'BL', 'SIZE_M', 999, b'1', b'1'),
(284, 'ESTA006', 'ESTA00612CT06MB_BL-S', 'BL', 'SIZE_S', 999, b'1', b'1'),
(285, 'ESTA006', 'ESTA00612CT06MB_BL-L', 'BL', 'SIZE_L', 999, b'1', b'1'),
(286, 'ESTA006', 'ESTA00612CT06MB_BL-XL', 'BL', 'SIZE_XL', 998, b'1', b'1'),
(287, 'ESTA003', 'ESTA00312CT06MB_NV-S', 'NV', 'SIZE_S', 999, b'1', b'1'),
(288, 'ESTA003', 'ESTA00312CT06MB_NV-M', 'NV', 'SIZE_M', 0, b'0', b'1'),
(289, 'ESTA003', 'ESTA00312CT06MB_NV-L', 'NV', 'SIZE_L', 999, b'1', b'1'),
(290, 'ESTA003', 'ESTA00312CT06MB_NV-XL', 'NV', 'SIZE_XL', 998, b'1', b'1'),
(291, 'ESTA003', 'ESTA00312CT06MB_WH-S', 'WH', 'SIZE_S', 998, b'1', b'1'),
(292, 'ESTA003', 'ESTA00312CT06MB_WH-M', 'WH', 'SIZE_M', 0, b'0', b'1'),
(293, 'ESTA003', 'ESTA00312CT06MB_WH-L', 'WH', 'SIZE_L', 999, b'1', b'1'),
(294, 'ESTA003', 'ESTA00312CT06MB_WH-XL', 'WH', 'SIZE_XL', 0, b'0', b'1'),
(295, 'ESTA005', 'ESTA00512CT06MB_BL-S', 'BL', 'SIZE_S', 999, b'1', b'1'),
(296, 'ESTA005', 'ESTA00512CT06MB_BL-M', 'BL', 'SIZE_M', 999, b'1', b'1'),
(297, 'ESTA005', 'ESTA00512CT06MB_BL-L', 'BL', 'SIZE_L', 0, b'0', b'1'),
(298, 'ESTA005', 'ESTA00512CT06MB_BL-XL', 'BL', 'SIZE_XL', 999, b'1', b'1'),
(299, 'ESTS040', 'ESTS04012CA06MB_WH-S', 'WH', 'SIZE_S', 999, b'1', b'1'),
(300, 'ESTS040', 'ESTS04012CA06MB_WH-M', 'WH', 'SIZE_M', 998, b'1', b'1'),
(301, 'ESTS040', 'ESTS04012CA06MB_WH-L', 'WH', 'SIZE_L', 0, b'0', b'1'),
(302, 'ESTS040', 'ESTS04012CA06MB_WH-XL', 'WH', 'SIZE_XL', 999, b'1', b'1'),
(303, 'ESTS040', 'ESTS04012CA06MB_BL-S', 'BL', 'SIZE_S', 0, b'0', b'1'),
(304, 'ESTS040', 'ESTS04012CA06MB_BL-M', 'BL', 'SIZE_M', 999, b'1', b'1'),
(305, 'ESTS040', 'ESTS04012CA06MB_BL-L', 'BL', 'SIZE_L', 999, b'1', b'1'),
(306, 'ESTS040', 'ESTS04012CA06MB_BL_XL', 'BL', 'SIZE_XL', 999, b'1', b'1'),
(307, 'ESTS044', 'ESTS04412CA04MB_WH-S', 'WH', 'SIZE_S', 998, b'1', b'1'),
(308, 'ESTS044', 'ESTS04412CA04MB_WH-M', 'WH', 'SIZE_M', 0, b'0', b'1'),
(309, 'ESTS044', 'ESTS04412CA04MB_WH-L', 'WH', 'SIZE_L', 999, b'1', b'1'),
(310, 'ESTS044', 'ESTS04412CA04MB_WH-XL', 'WH', 'SIZE_XL', 0, b'0', b'1'),
(311, 'ESTS021', 'ESTS02112CV06MB_DCB-S', 'DCB', 'SIZE_S', 0, b'0', b'1'),
(312, 'ESTS021', 'ESTS02112CV06MB_DCB-M', 'DCB', 'SIZE_M', 0, b'0', b'1'),
(313, 'ESTS021', 'ESTS02112CV06MB_DCB-L', 'DCB', 'SIZE_L', 999, b'1', b'1'),
(314, 'ESTS021', 'ESTS02112CV06MB_DCB-XL', 'WH', 'SIZE_XL', 998, b'1', b'1'),
(315, 'ESTS021', 'ESTS02112CV06MB_WH-L', 'WH', 'SIZE_L', 999, b'1', b'1'),
(316, 'ESTS021', 'ESTS02112CV06MB_WH-S', 'WH', 'SIZE_S', 999, b'1', b'1'),
(317, 'ESTS021', 'ESTS02112CV06MB_WH-M', 'WH', 'SIZE_M', 999, b'1', b'1'),
(318, 'ESTS021', 'ESTS02112CV06MB_WH-XL', 'WH', 'SIZE_XL', 998, b'1', b'1'),
(327, 'ESTS038', 'ESTS03812CT06MB_NV-M', 'NV', 'SIZE_M', 999, b'1', b'1'),
(328, 'ESTS038', 'ESTS03812CT06MB_NV-S', 'NV', 'SIZE_S', 999, b'1', b'1'),
(329, 'ESTS038', 'ESTS03812CT06MB_NV-L', 'NV', 'SIZE_L', 999, b'1', b'1'),
(330, 'ESTS038', 'ESTS03812CT06MB_NV-XL', 'NV', 'SIZE_XL', 999, b'1', b'1'),
(331, 'ESTS038', 'ESTS03812CT06MB_DCB-S', 'DCB', 'SIZE_S', 0, b'0', b'1'),
(332, 'ESTS038', 'ESTS03812CT06MB_DCB-M', 'DCB', 'SIZE_M', 0, b'0', b'1'),
(333, 'ESTS038', 'ESTS03812CT06MB_DCB-L', 'DCB', 'SIZE_L', 999, b'1', b'1'),
(334, 'ESTS038', 'ESTS03812CT06MB_DCB-XL', 'DCB', 'SIZE_XL', 999, b'1', b'1'),
(335, 'ESTS046', 'ESTS04612CT06MB_WH-S', 'WH', 'SIZE_S', 999, b'1', b'1'),
(336, 'ESTS046', 'ESTS04612CT06MB_WH-M', 'WH', 'SIZE_M', 999, b'1', b'1'),
(337, 'ESTS046', 'ESTS04612CT06MB_WH-L', 'WH', 'SIZE_L', 999, b'1', b'1'),
(338, 'ESTS046', 'ESTS04612CT06MB_WH-XL', 'WH', 'SIZE_XL', 999, b'1', b'1'),
(339, 'ESTS036', 'ESTS03612CA06MB_BL-XL', 'BL', 'SIZE_XL', 0, b'0', b'1'),
(340, 'ESTS036', 'ESTS03612CA06MB_BL-L', 'BL', 'SIZE_L', 0, b'0', b'1'),
(341, 'ESTS036', 'ESTS03612CA06MB_BL-M', 'BL', 'SIZE_M', 0, b'0', b'1'),
(342, 'ESTS036', 'ESTS03612CA06MB_BL-S', 'BL', 'SIZE_S', 0, b'0', b'1'),
(343, 'ESTS036', 'ESTS03612CA06MB_WH-L', 'WH', 'SIZE_L', 999, b'1', b'1'),
(344, 'ESTS036', 'ESTS03612CA06MB_WH-S', 'WH', 'SIZE_S', 999, b'1', b'1'),
(345, 'ESTS036', 'ESTS03612CA06MB_WH-M', 'WH', 'SIZE_M', 0, b'0', b'1'),
(346, 'ESTS036', 'ESTS03612CA06MB_WH-XL', 'WH', 'SIZE_XL', 0, b'0', b'1'),
(347, 'ESTB026', 'ESTB02672LI00RB_DNV-38', 'DNV', 'SIZE_38', 999, b'1', b'1'),
(348, 'ESTB026', 'ESTB02672LI00RB_DNV-39', 'DNV', 'SIZE_39', 999, b'1', b'1'),
(349, 'ESTB026', 'ESTB02672LI00RB_DNV-40', 'DNV', 'SIZE_40', 999, b'1', b'1'),
(350, 'ESTB026', 'ESTB02672LI00RB_DNV-41', 'DNV', 'SIZE_41', 999, b'1', b'1'),
(351, 'ESTB026', 'ESTB02672LI00RB_DNV-42', 'DNV', 'SIZE_42', 999, b'1', b'1'),
(352, 'ESTB026', 'ESTB02672LI00RB_WH-40', 'WH', 'SIZE_40', 999, b'1', b'1'),
(353, 'ESTB026', 'ESTB02672LI00RB_WH-39', 'WH', 'SIZE_39', 0, b'0', b'1'),
(354, 'ESTB026', 'ESTB02672LI00RB_WH-38', 'WH', 'SIZE_38', 0, b'0', b'1'),
(355, 'ESTB026', 'ESTB02672LI00RB_WH-41', 'WH', 'SIZE_41', 0, b'0', b'1'),
(356, 'ESTB026', 'ESTB02672LI00RB_WH-42', 'WH', 'SIZE_XL', 999, b'1', b'1'),
(357, 'ESTB026', 'ESTB02672LI00RB_LG-38', 'LG', 'SIZE_38', 999, b'1', b'1'),
(358, 'ESTB026', 'ESTB02672LI00RB_LG-39', 'LG', 'SIZE_39', 0, b'0', b'1'),
(359, 'ESTB026', 'ESTB02672LI00RB_LG-40', 'LG', 'SIZE_40', 0, b'0', b'1'),
(360, 'ESTB026', 'ESTB02672LI00RB_LG-41', 'LG', 'SIZE_41', 999, b'1', b'1'),
(361, 'ESTB026', 'ESTB02672LI00RB_LG-42', 'LG', 'SIZE_42', 999, b'1', b'1'),
(362, 'ESTB026', 'ESTB02672LI00RB_LCR-42', 'LCR', 'SIZE_42', 999, b'1', b'1'),
(363, 'ESTB026', 'ESTB02672LI00RB_LCR-41', 'LCR', 'SIZE_41', 999, b'1', b'1'),
(364, 'ESTB026', 'ESTB02672LI00RB_LCR-40', 'LCR', 'SIZE_40', 0, b'0', b'1'),
(365, 'ESTB026', 'ESTB02672LI00RB_LCR-39', 'LCR', 'SIZE_39', 0, b'0', b'1'),
(366, 'ESTB026', 'ESTB02672LI00RB_LCR-38', 'LCR', 'SIZE_38', 999, b'1', b'1'),
(367, 'ESTB026', 'ESTB02672LI00RB_LB-42', 'LB', 'SIZE_42', 999, b'1', b'1'),
(368, 'ESTB026', 'ESTB02672LI00RB_LB-41', 'LB', 'SIZE_41', 999, b'1', b'1'),
(369, 'ESTB026', 'ESTB02672LI00RB_LB-40', 'LB', 'SIZE_40', 999, b'1', b'1'),
(370, 'ESTB026', 'ESTB02672LI00RB_LB-39', 'LB', 'SIZE_39', 999, b'1', b'1'),
(371, 'ESTB026', 'ESTB02672LI00RB_LB-38', 'LB', 'SIZE_38', 999, b'1', b'1'),
(372, 'ESTB030', 'ESTB03071BA02SB_WH-38', 'WH', 'SIZE_38', 999, b'1', b'1'),
(373, 'ESTB030', 'ESTB03071BA02SB_WH-39', 'WH', 'SIZE_39', 999, b'1', b'1'),
(374, 'ESTB030', 'ESTB03071BA02SB_WH-40', 'WH', 'SIZE_40', 999, b'1', b'1'),
(375, 'ESTB030', 'ESTB03071BA02SB_WH-41', 'WH', 'SIZE_41', 999, b'1', b'1'),
(376, 'ESTB030', 'ESTB03071BA02SB_WH-42', 'WH', 'SIZE_42', 999, b'1', b'1'),
(377, 'ESTB030', 'ESTB03071BA02SB_LCB-38', 'LCB', 'SIZE_38', 999, b'1', b'1'),
(378, 'ESTB030', 'ESTB03071BA02SB_LCB-39', 'LCB', 'SIZE_39', 999, b'1', b'1'),
(379, 'ESTB030', 'ESTB03071BA02SB_LCB-40', 'LCB', 'SIZE_40', 999, b'1', b'1'),
(380, 'ESTB030', 'ESTB03071BA02SB_LCB-41', 'LCB', 'SIZE_41', 999, b'1', b'1'),
(381, 'ESTB030', 'ESTB03071BA02SB_LCB-42', 'LCB', 'SIZE_42', 999, b'1', b'1'),
(382, 'DATB614', 'DATB61471BA00SB_LLB-38', 'LLB', 'SIZE_38', 999, b'1', b'1'),
(383, 'DATB614', 'DATB61471BA00SB_LLB-39', 'LLB', 'SIZE_39', 0, b'0', b'1'),
(384, 'DATB614', 'DATB61471BA00SB_LLB-40', 'LLB', 'SIZE_40', 999, b'1', b'1'),
(385, 'DATB614', 'DATB61471BA00SB_LLB-41', 'LLB', 'SIZE_41', 999, b'1', b'1'),
(386, 'DATB614', 'DATB61471BA00SB_LLB-42', 'LLB', 'SIZE_42', 999, b'1', b'1'),
(387, 'DATB614', 'DATB61471BA00SB_WH-38', 'WH', 'SIZE_38', 999, b'1', b'1'),
(388, 'DATB614', 'DATB61471BA00SB_WH-39', 'WH', 'SIZE_39', 999, b'1', b'1'),
(389, 'DATB614', 'DATB61471BA00SB_WH-40', 'WH', 'SIZE_39', 0, b'0', b'1'),
(390, 'DATB614', 'DATB61471BA00SB_WH-41', 'WH', 'SIZE_41', 999, b'1', b'1'),
(391, 'DATB614', 'DATB61471BA00SB_WH-42', 'WH', 'SIZE_42', 999, b'1', b'1'),
(392, 'DATB614', 'DATB61471BA00SB_NV-38', 'NV', 'SIZE_38', 999, b'1', b'1'),
(393, 'DATB614', 'DATB61471BA00SB_NV-39', 'NV', 'SIZE_39', 999, b'1', b'1'),
(394, 'DATB614', 'DATB61471BA00SB_NV-40', 'NV', 'SIZE_40', 0, b'0', b'1'),
(395, 'DATB614', 'DATB61471BA00SB_NV-41', 'NV', 'SIZE_41', 999, b'1', b'1'),
(396, 'DATB614', 'DATB61471BA00SB_NV-42', 'NV', 'SIZE_42', 999, b'1', b'1'),
(397, 'DATB614', 'DATB61471BA00SB_BL-38', 'BL', 'SIZE_38', 999, b'1', b'1'),
(398, 'DATB614', 'DATB61471BA00SB_BL-39', 'BL', 'SIZE_39', 0, b'0', b'1'),
(399, 'DATB614', 'DATB61471BA00SB_BL-40', 'BL', 'SIZE_40', 0, b'0', b'1'),
(400, 'DATB614', 'DATB61471BA00SB_BL-41', 'BL', 'SIZE_41', 999, b'1', b'1'),
(401, 'DATB614', 'DATB61471BA00SB_BL-42', 'BL', 'SIZE_42', 999, b'1', b'1'),
(402, 'DATB920', 'DATB92071BA00SB_BL-38', 'BL', 'SIZE_38', 999, b'1', b'1'),
(403, 'DATB920', 'DATB92071BA00SB_BL-39', 'BL', 'SIZE_39', 999, b'1', b'1'),
(404, 'DATB920', 'DATB92071BA00SB_BL-40', 'BL', 'SIZE_40', 999, b'1', b'1'),
(405, 'DATB920', 'DATB92071BA00SB_BL-41', 'BL', 'SIZE_41', 999, b'1', b'1'),
(406, 'DATB920', 'DATB92071BA00SB_BL-42', 'BL', 'SIZE_42', 999, b'1', b'1'),
(407, 'DATB920', 'DATB92071BA00SB_WH-38', 'WH', 'SIZE_38', 999, b'1', b'1'),
(408, 'DATB920', 'DATB92071BA00SB_WH-39', 'WH', 'SIZE_39', 999, b'1', b'1'),
(409, 'DATB920', 'DATB92071BA00SB_WH-40', 'WH', 'SIZE_40', 999, b'1', b'1'),
(410, 'DATB920', 'DATB92071BA00SB_WH-41', 'WH', 'SIZE_41', 999, b'1', b'1'),
(411, 'DATB920', 'DATB92071BA00SB_WH-42', 'WH', 'SIZE_42', 999, b'1', b'1'),
(412, 'DATB920', 'DATB92071BA00SB_LB-38', 'LB', 'SIZE_38', 999, b'1', b'1'),
(413, 'DATB920', 'DATB92071BA00SB_LB-39', 'LB', 'SIZE_39', 999, b'1', b'1'),
(414, 'DATB920', 'DATB92071BA00SB_LB-40', 'LB', 'SIZE_40', 999, b'1', b'1'),
(415, 'DATB920', 'DATB92071BA00SB_LB-41', 'LB', 'SIZE_41', 999, b'1', b'1'),
(416, 'DATB920', 'DATB92071BA00SB_LB-42', 'LB', 'SIZE_42', 999, b'1', b'1'),
(417, 'DATB920', 'DATB92071BA00SB_NV-38', 'NV', 'SIZE_38', 999, b'1', b'1'),
(418, 'DATB920', 'DATB92071BA00SB_NV-39', 'NV', 'SIZE_39', 999, b'1', b'1'),
(419, 'DATB920', 'DATB92071BA00SB_NV-40', 'NV', 'SIZE_40', 999, b'1', b'1'),
(420, 'DATB920', 'DATB92071BA00SB_NV-41', 'NV', 'SIZE_41', 999, b'1', b'1'),
(421, 'DATB920', 'DATB92071BA00SB_NV-42', 'NV', 'SIZE_42', 999, b'1', b'1'),
(422, 'EATB006', 'EATB00671LI13RB_DNV-38', 'DNV', 'SIZE_38', 999, b'1', b'1'),
(423, 'EATB006', 'EATB00671LI13RB_DNV-39', 'DNV', 'SIZE_39', 999, b'1', b'1'),
(424, 'EATB006', 'EATB00671LI13RB_DNV-40', 'DNV', 'SIZE_40', 0, b'0', b'1'),
(425, 'EATB006', 'EATB00671LI13RB_DNV-41', 'DNV', 'SIZE_41', 999, b'1', b'1'),
(426, 'EATB006', 'EATB00671LI13RB_DNV-42', 'DNV', 'SIZE_42', 999, b'1', b'1'),
(427, 'EATB006', 'EATB00671LI13RB_WH-38', 'WH', 'SIZE_38', 999, b'1', b'1'),
(428, 'EATB006', 'EATB00671LI13RB_WH-39', 'WH', 'SIZE_39', 999, b'1', b'1'),
(429, 'EATB006', 'EATB00671LI13RB_WH-40', 'WH', 'SIZE_40', 999, b'1', b'1'),
(430, 'EATB006', 'EATB00671LI13RB_WH-41', 'WH', 'SIZE_41', 999, b'1', b'1'),
(431, 'EATB006', 'EATB00671LI13RB_WH-42', 'WH', 'SIZE_42', 999, b'1', b'1'),
(432, 'EATB006', 'EATB00671LI13RB_LG-38', 'LG', 'SIZE_38', 999, b'1', b'1'),
(433, 'EATB006', 'EATB00671LI13RB_LG-39', 'LG', 'SIZE_39', 0, b'0', b'1'),
(434, 'EATB006', 'EATB00671LI13RB_LG-40', 'LG', 'SIZE_40', 0, b'0', b'1'),
(435, 'EATB006', 'EATB00671LI13RB_LG-41', 'LG', 'SIZE_41', 999, b'1', b'1'),
(436, 'EATB006', 'EATB00671LI13RB_LG-42', 'LG', 'SIZE_42', 999, b'1', b'1'),
(437, 'EATB006', 'EATB00671LI13RB_LB-39', 'LB', 'SIZE_39', 999, b'1', b'1'),
(438, 'EATB006', 'EATB00671LI13RB_LB-38', 'LB', 'SIZE_38', 999, b'1', b'1'),
(439, 'EATB006', 'EATB00671LI13RB_LB-40', 'LB', 'SIZE_40', 999, b'1', b'1'),
(440, 'EATB006', 'EATB00671LI13RB_LB-41', 'LB', 'SIZE_41', 999, b'1', b'1'),
(441, 'EATB006', 'EATB00671LI13RB_LB-42', 'LB', 'SIZE_42', 999, b'1', b'1'),
(442, 'DATB416', 'DATB41671CA11RB_NBX-38', 'NBX', 'SIZE_38', 992, b'1', b'1'),
(443, 'DATB416', 'DATB41671CA11RB_NBX-39', 'NBX', 'SIZE_39', 996, b'1', b'1'),
(444, 'DATB416', 'DATB41671CA11RB_NBX-40', 'NBX', 'SIZE_40', 999, b'1', b'1'),
(445, 'DATB416', 'DATB41671CA11RB_NBX-41', 'NBX', 'SIZE_41', 999, b'1', b'1'),
(446, 'DATB416', 'DATB41671CA11RB_NBX-42', 'NBX', 'SIZE_42', 999, b'1', b'1'),
(447, 'EATB003', 'EATB00371CA11SB_GN-38', 'GN', 'SIZE_38', 999, b'1', b'1'),
(448, 'EATB003', 'EATB00371CA11SB_GN-39', 'GN', 'SIZE_39', 999, b'1', b'1'),
(449, 'EATB003', 'EATB00371CA11SB_GN-40', 'GN', 'SIZE_40', 0, b'0', b'1'),
(450, 'EATB003', 'EATB00371CA11SB_GN-41', 'GN', 'SIZE_41', 0, b'0', b'1'),
(451, 'EATB003', 'EATB00371CA11SB_GN-42', 'GN', 'SIZE_42', 999, b'1', b'1'),
(452, 'EATB003', 'EATB00371CA11SB_LB-38', 'LB', 'SIZE_38', 999, b'1', b'1'),
(453, 'EATB003', 'EATB00371CA11SB_LB-39', 'LB', 'SIZE_39', 999, b'1', b'1'),
(454, 'EATB003', 'EATB00371CA11SB_LB-40', 'LB', 'SIZE_40', 999, b'1', b'1'),
(455, 'EATB003', 'EATB00371CA11SB_LB-41', 'LB', 'SIZE_41', 999, b'1', b'1'),
(456, 'EATB003', 'EATB00371CA11SB_LB-42', 'LB', 'SIZE_42', 999, b'1', b'1'),
(457, 'EATB003', 'EATB00371CA11SB_BL-38', 'BL', 'SIZE_38', 999, b'1', b'1'),
(458, 'EATB003', 'EATB00371CA11SB_BL-39', 'BL', 'SIZE_39', 999, b'1', b'1'),
(459, 'EATB003', 'EATB00371CA11SB_BL-40', 'BL', 'SIZE_40', 999, b'1', b'1'),
(460, 'EATB003', 'EATB00371CA11SB_BL-41', 'BL', 'SIZE_41', 999, b'1', b'1'),
(461, 'EATB003', 'EATB00371CA11SB_BL-42', 'BL', 'SIZE_42', 999, b'1', b'1'),
(462, 'DABK906', 'DABK90601CT00SB_NV-29', 'NV', 'SIZE_29', 999, b'1', b'1'),
(463, 'DABK906', 'DABK90601CT00SB_NV-30', 'NV', 'SIZE_30', 999, b'1', b'1'),
(464, 'DABK906', 'DABK90601CT00SB_NV-31', 'NV', 'SIZE_31', 999, b'1', b'1'),
(465, 'DABK906', 'DABK90601CT00SB_NV-32', 'NV', 'SIZE_32', 999, b'1', b'1'),
(466, 'DABK906', 'DABK90601CT00SB_NV-33', 'NV', 'SIZE_33', 999, b'1', b'1'),
(467, 'DABK906', 'DABK90601CT00SB_LG-29', 'LG', 'SIZE_29', 999, b'1', b'1'),
(468, 'DABK906', 'DABK90601CT00SB_LG-30', 'LG', 'SIZE_30', 999, b'1', b'1'),
(469, 'DABK906', 'DABK90601CT00SB_LG-31', 'LG', 'SIZE_31', 999, b'1', b'1'),
(470, 'DABK906', 'DABK90601CT00SB_LG-32', 'LG', 'SIZE_32', 999, b'1', b'1'),
(471, 'DABK906', 'DABK90601CT00SB_LG-33', 'LG', 'SIZE_33', 999, b'1', b'1'),
(472, 'DABK906', 'DABK90601CT00SB_CN-29', 'CN', 'SIZE_29', 999, b'1', b'1'),
(473, 'DABK906', 'DABK90601CT00SB_CN-30', 'CN', 'SIZE_30', 999, b'1', b'1'),
(474, 'DABK906', 'DABK90601CT00SB_CN-31', 'CN', 'SIZE_31', 999, b'1', b'1'),
(475, 'DABK906', 'DABK90601CT00SB_CN-32', 'CN', 'SIZE_32', 999, b'1', b'1'),
(476, 'DABK906', 'DABK90601CT00SB_CN-33', 'CN', 'SIZE_33', 999, b'1', b'1'),
(477, 'DABK906', 'DABK90601CT00SB_BL-31', 'BL', 'SIZE_31', 999, b'1', b'1'),
(478, 'DABK906', 'DABK90601CT00SB_BL-30', 'BL', 'SIZE_30', 0, b'0', b'1'),
(479, 'DABK906', 'DABK90601CT00SB_BL-32', 'BL', 'SIZE_32', 0, b'0', b'1'),
(480, 'DABK906', 'DABK90601CT00SB_BL-33', 'BL', 'SIZE_33', 999, b'1', b'1'),
(481, 'DABK906', 'DABK90601CT00SB_BL-29', 'BL', 'SIZE_29', 999, b'1', b'1'),
(482, 'DABK908', 'DABK90801CT00SB_NV-29', 'NV', 'SIZE_29', 999, b'1', b'1'),
(483, 'DABK908', 'DABK90801CT00SB_NV-30', 'NV', 'SIZE_30', 999, b'1', b'1'),
(484, 'DABK908', 'DABK90801CT00SB_NV-31', 'NV', 'SIZE_31', 0, b'0', b'1'),
(485, 'DABK908', 'DABK90801CT00SB_NV-32', 'NV', 'SIZE_32', 999, b'1', b'1'),
(486, 'DABK908', 'DABK90801CT00SB_NV-33', 'NV', 'SIZE_33', 999, b'1', b'1'),
(487, 'DABK908', 'DABK90801CT00SB_LG-32', 'LG', 'SIZE_32', 999, b'1', b'1'),
(488, 'DABK908', 'DABK90801CT00SB_LG-33', 'LG', 'SIZE_33', 999, b'1', b'1'),
(489, 'DABK908', 'DABK90801CT00SB_LG-31', 'LG', 'SIZE_31', 0, b'0', b'1'),
(490, 'DABK908', 'DABK90801CT00SB_LG-30', 'LG', 'SIZE_30', 999, b'1', b'1'),
(491, 'DABK908', 'DABK90801CT00SB_LG-29', 'LG', 'SIZE_29', 999, b'1', b'1'),
(492, 'DABK908', 'DABK90801CT00SB_CN-29', 'CN', 'SIZE_29', 999, b'1', b'1'),
(493, 'DABK908', 'DABK90801CT00SB_CN-30', 'CN', 'SIZE_30', 0, b'0', b'1'),
(494, 'DABK908', 'DABK90801CT00SB_CN-31', 'CN', 'SIZE_31', 999, b'1', b'1'),
(495, 'DABK908', 'DABK90801CT00SB_CN-32', 'CN', 'SIZE_32', 999, b'1', b'1'),
(496, 'DABK908', 'DABK90801CT00SB_CN-33', 'CN', 'SIZE_33', 999, b'1', b'1'),
(497, 'DABK908', 'DABK90801CT00SB_BL-30', 'BL', 'SIZE_30', 999, b'1', b'1'),
(498, 'DABK908', 'DABK90801CT00SB_BL-29', 'BL', 'SIZE_29', 999, b'1', b'1'),
(499, 'DABK908', 'DABK90801CT00SB_BL-31', 'BL', 'SIZE_31', 999, b'1', b'1'),
(500, 'DABK908', 'DABK90801CT00SB_BL-32', 'BL', 'SIZE_32', 999, b'1', b'1'),
(501, 'DABK908', 'DABK90801CT00SB_BL-33', 'BL', 'SIZE_33', 0, b'0', b'1'),
(502, 'EABT021', 'EABT02101PE00SB_BL-29', 'BL', 'SIZE_29', 999, b'1', b'1'),
(503, 'EABT021', 'EABT02101PE00SB_BL-30', 'BL', 'SIZE_30', 999, b'1', b'1'),
(504, 'EABT021', 'EABT02101PE00SB_BL-31', 'BL', 'SIZE_31', 999, b'1', b'1'),
(505, 'EABT021', 'EABT02101PE00SB_BL-32', 'BL', 'SIZE_32', 999, b'1', b'1'),
(506, 'EABT021', 'EABT02101PE00SB_BL-33', 'BL', 'SIZE_33', 999, b'1', b'1'),
(507, 'EABT019', 'EABT01901PE00SB_DNV-29', 'DNV', 'SIZE_29', 999, b'1', b'1'),
(508, 'EABT019', 'EABT01901PE00SB_DNV-30', 'DNV', 'SIZE_30', 999, b'1', b'1'),
(509, 'EABT019', 'EABT01901PE00SB_DNV-31', 'DNV', 'SIZE_31', 999, b'1', b'1'),
(510, 'EABT019', 'EABT01901PE00SB_DNV-32', 'DNV', 'SIZE_32', 999, b'1', b'1'),
(511, 'EABT019', 'EABT01901PE00SB_DNV-33', 'DNV', 'SIZE_33', 999, b'1', b'1'),
(512, 'EABT019', 'EABT01901PE00SB_LBL-29', 'LBL', 'SIZE_29', 999, b'1', b'1'),
(513, 'EABT019', 'EABT01901PE00SB_LBL-30', 'LBL', 'SIZE_30', 999, b'1', b'1'),
(514, 'EABT019', 'EABT01901PE00SB_LBL-31', 'LBL', 'SIZE_31', 999, b'1', b'1'),
(515, 'EABT019', 'EABT01901PE00SB_LBL-32', 'LBL', 'SIZE_32', 0, b'0', b'1'),
(516, 'EABT019', 'EABT01901PE00SB_LBL-33', 'LBL', 'SIZE_33', 999, b'1', b'1'),
(517, 'EABT019', 'EABT01901PE00SB_GR-29', 'GR', 'SIZE_29', 999, b'1', b'1'),
(518, 'EABT019', 'EABT01901PE00SB_GR-30', 'GR', 'SIZE_30', 0, b'0', b'1'),
(519, 'EABT019', 'EABT01901PE00SB_GR-31', 'GR', 'SIZE_31', 999, b'1', b'1'),
(520, 'EABT019', 'EABT01901PE00SB_GR-32', 'GR', 'SIZE_32', 999, b'1', b'1'),
(521, 'EABT019', 'EABT01901PE00SB_GR-33', 'GR', 'SIZE_33', 999, b'1', b'1'),
(522, 'EABT019', 'EABT01901PE00SB_BL-29', 'BL', 'SIZE_29', 999, b'1', b'1'),
(523, 'EABT019', 'EABT01901PE00SB_BL-30', 'BL', 'SIZE_30', 999, b'1', b'1'),
(524, 'EABT019', 'EABT01901PE00SB_BL-31', 'BL', 'SIZE_31', 999, b'1', b'1'),
(525, 'EABT019', 'EABT01901PE00SB_BL-32', 'BL', 'SIZE_32', 0, b'0', b'1'),
(526, 'EABT019', 'EABT01901PE00SB_BL-33', 'BL', 'SIZE_33', 999, b'1', b'1'),
(527, 'DABJ004', 'DABJ00401CT00SB_NV-29', 'NV', 'SIZE_29', 999, b'1', b'1'),
(528, 'DABJ004', 'DABJ00401CT00SB_NV-30', 'NV', 'SIZE_30', 999, b'1', b'1'),
(529, 'DABJ004', 'DABJ00401CT00SB_NV-31', 'NV', 'SIZE_31', 999, b'1', b'1'),
(530, 'DABJ004', 'DABJ00401CT00SB_NV-32', 'NV', 'SIZE_32', 998, b'1', b'1'),
(531, 'DABJ004', 'DABJ00401CT00SB_NV-33', 'NV', 'SIZE_33', 999, b'1', b'1'),
(532, 'DABJ010', 'DABJ01001CT00SB_BU-29', 'BU', 'SIZE_29', 999, b'1', b'1'),
(533, 'DABJ010', 'DABJ01001CT00SB_BU-30', 'BU', 'SIZE_30', -5, b'0', b'1'),
(534, 'DABJ010', 'DABJ01001CT00SB_BU-31', 'BU', 'SIZE_31', 999, b'1', b'1'),
(535, 'DABJ010', 'DABJ01001CT00SB_BU-32', 'BU', 'SIZE_32', 999, b'1', b'1'),
(536, 'DABJ010', 'DABJ01001CT00SB_BU-33', 'BU', 'SIZE_33', 999, b'1', b'1'),
(537, 'DABJ903', 'DABJ90301CT16SB_NV-33', 'NV', 'SIZE_33', 999, b'1', b'1'),
(538, 'DABJ903', 'DABJ90301CT16SB_NV-32', 'NV', 'SIZE_32', 999, b'1', b'1'),
(539, 'DABJ903', 'DABJ90301CT16SB_NV-31', 'NV', 'SIZE_31', 999, b'1', b'1'),
(540, 'DABJ903', 'DABJ90301CT16SB_NV-30', 'NV', 'SIZE_30', 999, b'1', b'1'),
(541, 'DABJ903', 'DABJ90301CT16SB_NV-29', 'NV', 'SIZE_29', 997, b'1', b'1'),
(542, 'DABJ908', 'DABJ90801CT19SB_DBU-29', 'DBU', 'SIZE_29', 997, b'1', b'1'),
(543, 'DABJ908', 'DABJ90801CT19SB_DBU-30', 'DBU', 'SIZE_30', 999, b'1', b'1'),
(544, 'DABJ908', 'DABJ90801CT19SB_DBU-31', 'DBU', 'SIZE_31', 999, b'1', b'1'),
(545, 'DABJ908', 'DABJ90801CT19SB_DBU-32', 'DBU', 'SIZE_32', 999, b'1', b'1'),
(546, 'DABJ908', 'DABJ90801CT19SB_DBU-33', 'DBU', 'SIZE_33', 999, b'1', b'1'),
(547, 'CABJ003', 'CABJ00301CT19SB_BU-29', 'BU', 'SIZE_29', 999, b'1', b'1'),
(548, 'CABJ003', 'CABJ00301CT19SB_BU-30', 'BU', 'SIZE_30', 999, b'1', b'1'),
(549, 'CABJ003', 'CABJ00301CT19SB_BU-31', 'BU', 'SIZE_31', 999, b'1', b'1'),
(550, 'CABJ003', 'CABJ00301CT19SB_BU-32', 'BU', 'SIZE_32', 999, b'1', b'1'),
(551, 'CABJ003', 'CABJ00301CT19SB_BU-33', 'BU', 'SIZE_33', 999, b'1', b'1'),
(552, 'DABJ904', 'DABJ90401CT19SB_NV-29', 'NV', 'SIZE_29', 0, b'0', b'1'),
(553, 'DABJ904', 'DABJ90401CT19SB_NV-30', 'NV', 'SIZE_30', 999, b'1', b'1'),
(554, 'DABJ904', 'DABJ90401CT19SB_NV-31', 'NV', 'SIZE_31', 999, b'1', b'1'),
(555, 'DABJ904', 'DABJ90401CT19SB_NV-32', 'NV', 'SIZE_32', 999, b'1', b'1'),
(556, 'DABJ904', 'DABJ90401CT19SB_NV-33', 'NV', 'SIZE_33', 999, b'1', b'1'),
(557, 'ESBW005', 'ESBW00502PE00RB_BL-S', 'BL', 'SIZE_S', 999, b'1', b'1'),
(558, 'ESBW005', 'ESBW00502PE00RB_BL-M', 'BL', 'SIZE_M', 999, b'1', b'1'),
(559, 'ESBW005', 'ESBW00502PE00RB_BL-L', 'BL', 'SIZE_L', 999, b'1', b'1'),
(560, 'ESBW005', 'ESBW00502PE00RB_BL-XL', 'BL', 'SIZE_XL', 999, b'1', b'1'),
(561, 'ESBW005', 'ESBW00502PE00RB_NV-S', 'NV', 'SIZE_S', 999, b'1', b'1'),
(562, 'ESBW005', 'ESBW00502PE00RB_NV-M', 'NV', 'SIZE_M', 999, b'1', b'1'),
(563, 'ESBW005', 'ESBW00502PE00RB_NV-L', 'NV', 'SIZE_L', 999, b'1', b'1'),
(564, 'ESBW005', 'ESBW00502PE00RB_NV-XL', 'NV', 'SIZE_XL', 999, b'1', b'1'),
(565, 'ESBW004', 'ESBW00402PE01MB_LG-S', 'LG', 'SIZE_S', 999, b'1', b'1'),
(566, 'ESBW004', 'ESBW00402PE01MB_LG-M', 'LG', 'SIZE_M', 0, b'0', b'1'),
(567, 'ESBW004', 'ESBW00402PE01MB_LG-L', 'LG', 'SIZE_L', 999, b'1', b'1'),
(568, 'ESBW004', 'ESBW00402PE01MB_LG-XL', 'LG', 'SIZE_XL', 999, b'1', b'1'),
(569, 'ESBW004', 'ESBW00402PE01MB_NV-S', 'NV', 'SIZE_S', 999, b'1', b'1'),
(570, 'ESBW004', 'ESBW00402PE01MB_NV-M', 'NV', 'SIZE_M', 999, b'1', b'1'),
(571, 'ESBW004', 'ESBW00402PE01MB_NV-L', 'NV', 'SIZE_L', 999, b'1', b'1'),
(572, 'ESBW004', 'ESBW00402PE01MB_NV-XL', 'NV', 'SIZE_XL', 999, b'1', b'1'),
(573, 'ESBW004', 'ESBW00402PE01MB_BL-S', 'BL', 'SIZE_S', 999, b'1', b'1'),
(574, 'ESBW004', 'ESBW00402PE01MB_BL-M', 'BL', 'SIZE_M', 999, b'1', b'1'),
(575, 'ESBW004', 'ESBW00402PE01MB_BL-L', 'BL', 'SIZE_L', 999, b'1', b'1'),
(576, 'ESBW004', 'ESBW00402PE01MB_BL-XL', 'BL', 'SIZE_XL', 999, b'1', b'1'),
(577, 'ESBK007', 'ESBK00702CT00RB_NV-29', 'NV', 'SIZE_29', 999, b'1', b'1'),
(578, 'ESBK007', 'ESBK00702CT00RB_NV-30', 'NV', 'SIZE_30', 0, b'0', b'1'),
(579, 'ESBK007', 'ESBK00702CT00RB_NV-31', 'NV', 'SIZE_31', 0, b'0', b'1'),
(580, 'ESBK007', 'ESBK00702CT00RB_NV-32', 'NV', 'SIZE_32', 999, b'1', b'1'),
(581, 'ESBK007', 'ESBK00702CT00RB_NV-33', 'NV', 'SIZE_33', 999, b'1', b'1'),
(582, 'ESBK007', 'ESBK00702CT00RB_LG-29', 'LG', 'SIZE_29', 999, b'1', b'1'),
(583, 'ESBK007', 'ESBK00702CT00RB_LG-30', 'LG', 'SIZE_30', 0, b'0', b'1'),
(584, 'ESBK007', 'ESBK00702CT00RB_LG-31', 'LG', 'SIZE_31', 999, b'1', b'1'),
(585, 'ESBK007', 'ESBK00702CT00RB_LG-32', 'LG', 'SIZE_32', 999, b'1', b'1'),
(586, 'ESBK007', 'ESBK00702CT00RB_LG-33', 'LG', 'SIZE_33', 0, b'0', b'1'),
(587, 'ESBK007', 'ESBK00702CT00RB_BL-29', 'BL', 'SIZE_29', 999, b'1', b'1'),
(588, 'ESBK007', 'ESBK00702CT00RB_BL-30', 'BL', 'SIZE_30', 999, b'1', b'1'),
(589, 'ESBK007', 'ESBK00702CT00RB_BL-31', 'BL', 'SIZE_31', 0, b'0', b'1'),
(590, 'ESBK007', 'ESBK00702CT00RB_BL-32', 'BL', 'SIZE_32', 999, b'1', b'1'),
(591, 'ESBK007', 'ESBK00702CT00RB_BL-33', 'BL', 'SIZE_33', 999, b'1', b'1'),
(592, 'ESBK002', 'ESBK00202CT00RB_NV-29', 'NV', 'SIZE_29', 999, b'1', b'1'),
(593, 'ESBK002', 'ESBK00202CT00RB_NV-30', 'NV', 'SIZE_30', 0, b'0', b'1'),
(594, 'ESBK002', 'ESBK00202CT00RB_NV-31', 'NV', 'SIZE_31', 999, b'1', b'1'),
(595, 'ESBK002', 'ESBK00202CT00RB_NV-32', 'NV', 'SIZE_32', 999, b'1', b'1'),
(596, 'ESBK002', 'ESBK00202CT00RB_NV-33', 'NV', 'SIZE_33', 999, b'1', b'1'),
(597, 'ESBK002', 'ESBK00202CT00RB_LG-29', 'LG', 'SIZE_29', 999, b'1', b'1'),
(598, 'ESBK002', 'ESBK00202CT00RB_LG-30', 'LG', 'SIZE_30', 0, b'0', b'1'),
(599, 'ESBK002', 'ESBK00202CT00RB_LG-31', 'LG', 'SIZE_31', 999, b'1', b'1'),
(600, 'ESBK002', 'ESBK00202CT00RB_LG-32', 'LG', 'SIZE_32', 999, b'1', b'1'),
(601, 'ESBK002', 'ESBK00202CT00RB_LG-33', 'LG', 'SIZE_33', 999, b'1', b'1'),
(602, 'ESBK002', 'ESBK00202CT00RB_BL-29', 'BL', 'SIZE_29', 0, b'0', b'1'),
(603, 'ESBK002', 'ESBK00202CT00RB_BL-30', 'BL', 'SIZE_30', 999, b'1', b'1'),
(604, 'ESBK002', 'ESBK00202CT00RB_BL-31', 'BL', 'SIZE_31', 999, b'1', b'1'),
(605, 'ESBK002', 'ESBK00202CT00RB_BL-32', 'BL', 'SIZE_32', 999, b'1', b'1'),
(606, 'ESBK002', 'ESBK00202CT00RB_BL-33', 'BE', 'SIZE_33', 999, b'1', b'1'),
(607, 'ESBK002', 'ESBK00202CT00RB_BE-29', 'BE', 'SIZE_29', 999, b'1', b'1'),
(608, 'ESBK002', 'ESBK00202CT00RB_BE-30', 'BE', 'SIZE_30', 999, b'1', b'1'),
(609, 'ESBK002', 'ESBK00202CT00RB_BE-31', 'BE', 'SIZE_31', 999, b'1', b'1'),
(610, 'ESBK002', 'ESBK00202CT00RB_BE-32', 'BE', 'SIZE_32', 999, b'1', b'1'),
(611, 'ESBK002', 'ESBK00202CT00RB_BE-33', 'BE', 'SIZE_33', 999, b'1', b'1'),
(612, 'BI013', 'DSBI01302LI00SB_BE-29', 'BE', 'SIZE_29', 996, b'1', b'1'),
(613, 'BI013', 'DSBI01302LI00SB_BE-30', 'BE', 'SIZE_30', 999, b'1', b'1'),
(614, 'BI013', 'DSBI01302LI00SB_BE-31', 'BE', 'SIZE_31', 991, b'1', b'1'),
(615, 'BI013', 'DSBI01302LI00SB_BE-32', 'BE', 'SIZE_32', 999, b'1', b'1'),
(616, 'BI013', 'DSBI01302LI00SB_BE-33', 'BE', 'SIZE_33', 999, b'1', b'1'),
(617, 'BI013', 'DSBI01302LI00SB_WH-29', 'WH', 'SIZE_29', 999, b'1', b'1'),
(618, 'BI013', 'DSBI01302LI00SB_WH-31', 'WH', 'SIZE_31', 999, b'1', b'1'),
(619, 'BI013', 'DSBI01302LI00SB_WH-30', 'WH', 'SIZE_30', 999, b'1', b'1'),
(620, 'BI013', 'DSBI01302LI00SB_WH-32', 'WH', 'SIZE_32', 999, b'1', b'1'),
(621, 'BI013', 'DSBI01302LI00SB_WH-33', 'WH', 'SIZE_33', 999, b'1', b'1'),
(622, 'BI013', 'DSBI01302LI00SB_LB-31', 'LB', 'SIZE_31', 999, b'1', b'1'),
(623, 'BI013', 'DSBI01302LI00SB_LB-30', 'LB', 'SIZE_30', 999, b'1', b'1'),
(624, NULL, 'DSBI01302LI00SB_LB-29', 'LB', 'SIZE_29', 0, b'0', b'1'),
(625, 'BI013', 'DSBI01302LI00SB_LB-32', 'LB', 'SIZE_32', 999, b'1', b'1'),
(626, 'BI013', 'DSBI01302LI00SB_LB-33', 'LB', 'SIZE_33', 999, b'1', b'1'),
(627, 'BI013', 'DSBI01302LI00SB_LG-29', 'LG', 'SIZE_29', 999, b'1', b'1'),
(628, 'BI013', 'DSBI01302LI00SB_LG-30', 'LG', 'SIZE_30', 0, b'0', b'1'),
(629, 'BI013', 'DSBI01302LI00SB_LG-31', 'LG', 'SIZE_31', 999, b'1', b'1'),
(630, 'BI013', 'DSBI01302LI00SB_LG-32', 'LG', 'SIZE_32', 999, b'1', b'1'),
(631, 'BI013', 'DSBI01302LI00SB_LG-33', 'LG', 'SIZE_33', 999, b'1', b'1'),
(632, 'BI013', 'DSBI01302LI00SB_NV-29', 'NV', 'SIZE_29', 999, b'1', b'1'),
(633, 'BI013', 'DSBI01302LI00SB_NV-30', 'NV', 'SIZE_30', 999, b'1', b'1'),
(634, 'BI013', 'DSBI01302LI00SB_NV-31', 'NV', 'SIZE_31', 999, b'1', b'1'),
(635, 'BI013', 'DSBI01302LI00SB_NV-32', 'NV', 'SIZE_32', 999, b'1', b'1'),
(636, 'BI013', 'DSBI01302LI00SB_NV-33', 'NV', 'SIZE_33', 999, b'1', b'1'),
(637, 'BI013', 'DSBI01302LI00SB_BL-29', 'BL', 'SIZE_29', 999, b'1', b'1'),
(638, 'BI013', 'DSBI01302LI00SB_BL-30', 'BL', 'SIZE_30', 999, b'1', b'1'),
(639, 'BI013', 'DSBI01302LI00SB_BL-31', 'BL', 'SIZE_31', 999, b'1', b'1'),
(640, 'BI013', 'DSBI01302LI00SB_BL-32', 'BL', 'SIZE_31', 999, b'1', b'1'),
(641, 'BI013', 'DSBI01302LI00SB_BL-33', 'BL', 'SIZE_33', 999, b'1', b'1'),
(642, 'ESBI006', 'ESBI00602CA00SB_BL-29', 'BL', 'SIZE_29', 999, b'1', b'1'),
(643, 'ESBI006', 'ESBI00602CA00SB_BL-30', 'BL', 'SIZE_29', 999, b'1', b'1'),
(644, 'ESBI006', 'ESBI00602CA00SB_BL-31', 'BL', 'SIZE_31', 999, b'1', b'1'),
(645, 'ESBI006', 'ESBI00602CA00SB_BL-32', 'BL', 'SIZE_32', 999, b'1', b'1'),
(646, 'ESBI006', 'ESBI00602CA00SB_BL-33', 'BL', 'SIZE_33', 999, b'1', b'1'),
(647, 'ESBI006', 'ESBI00602CA00SB_NV-29', 'NV', 'SIZE_29', 999, b'1', b'1'),
(648, 'ESBI006', 'ESBI00602CA00SB_NV-30', 'NV', 'SIZE_30', 999, b'1', b'1'),
(649, 'ESBI006', 'ESBI00602CA00SB_NV-31', 'NV', 'SIZE_31', 999, b'1', b'1'),
(650, 'ESBI006', 'ESBI00602CA00SB_NV-32', 'NV', 'SIZE_32', 999, b'1', b'1'),
(651, 'ESBI006', 'ESBI00602CA00SB_NV-33', 'NV', 'SIZE_33', 999, b'1', b'1'),
(652, 'ESBI006', 'ESBI00602CA00SB_LG-29', 'LG', 'SIZE_29', 999, b'1', b'1'),
(653, 'ESBI006', 'ESBI00602CA00SB_LG-30', 'LG', 'SIZE_30', 999, b'1', b'1'),
(654, 'ESBI006', 'ESBI00602CA00SB_LG-31', 'LG', 'SIZE_31', 999, b'1', b'1'),
(655, 'ESBI006', 'ESBI00602CA00SB_LG-32', 'LG', 'SIZE_32', 999, b'1', b'1'),
(656, 'ESBI006', 'ESBI00602CA00SB_LG-33', 'LG', 'SIZE_33', 999, b'1', b'1'),
(657, 'ESBI006', 'ESBI00602CA00SB_CR-29', 'CR', 'SIZE_29', 999, b'1', b'1'),
(658, 'ESBI006', 'ESBI00602CA00SB_CR-30', 'CR', 'SIZE_30', 999, b'1', b'1'),
(659, 'ESBI006', 'ESBI00602CA00SB_CR-31', 'CR', 'SIZE_31', 999, b'1', b'1'),
(660, 'ESBI006', 'ESBI00602CA00SB_CR-32', 'CR', 'SIZE_32', 999, b'1', b'1'),
(661, 'ESBI006', 'ESBI00602CA00SB_CR-33', 'CR', 'SIZE_33', 999, b'1', b'1'),
(662, 'ESBI006', 'ESBI00602CA00SB_WH-29', 'WH', 'SIZE_29', 999, b'1', b'1'),
(663, 'ESBI006', 'ESBI00602CA00SB_WH-30', 'WH', 'SIZE_30', 999, b'1', b'1'),
(664, 'ESBI006', 'ESBI00602CA00SB_WH-31', 'WH', 'SIZE_31', 999, b'1', b'1'),
(665, 'ESBI006', 'ESBI00602CA00SB_WH-32', 'WH', 'SIZE_32', 999, b'1', b'1'),
(666, 'ESBI006', 'ESBI00602CA00SB_WH-33', 'WH', 'SIZE_33', 999, b'1', b'1'),
(667, 'DWBS012', 'DWBS01203CV00SB_CN-S', 'CN', 'SIZE_S', 999, b'1', b'1'),
(668, 'DWBS012', 'DWBS01203CV00SB_CN-M', 'CN', 'SIZE_M', 999, b'1', b'1'),
(669, 'DWBS012', 'DWBS01203CV00SB_CN-L', 'CN', 'SIZE_L', 999, b'1', b'1'),
(670, 'DWBS012', 'DWBS01203CV00SB_CN-XL', 'CN', 'SIZE_XL', 999, b'1', b'1'),
(671, 'DWBS012', 'DWBS01203CV00SB_DGR-S-S', 'DGN', 'SIZE_S', 999, b'1', b'1'),
(672, 'DWBS012', 'DWBS01203CV00SB_DGR-M', 'DGN', 'SIZE_M', 999, b'1', b'1'),
(673, 'DWBS012', 'DWBS01203CV00SB_DGR-L', 'DGN', 'SIZE_L', 999, b'1', b'1'),
(674, 'DWBS012', 'DWBS01203CV00SB_DGR-XL', 'DGN', 'SIZE_XL', 999, b'1', b'1'),
(675, 'DWBS012', 'DWBS01203CV00SB_NV-S', 'NV', 'SIZE_S', 999, b'1', b'1'),
(676, 'DWBS012', 'DWBS01203CV00SB_NV-M', 'NV', 'SIZE_M', 999, b'1', b'1'),
(677, 'DWBS012', 'DWBS01203CV00SB_NV-L', 'NV', 'SIZE_L', 999, b'1', b'1'),
(678, 'DWBS012', 'DWBS01203CV00SB_NV-XL', 'NV', 'SIZE_XL', 999, b'1', b'1'),
(679, 'EWCW007', 'EWCW00751PE00SB_LG-S', 'LG', 'SIZE_S', 999, b'1', b'1'),
(680, 'EWCW007', 'EWCW00751PE00SB_LG-M', 'LG', 'SIZE_M', 999, b'1', b'1'),
(681, 'EWCW007', 'EWCW00751PE00SB_LG-L', 'LG', 'SIZE_L', 999, b'1', b'1'),
(682, 'EWCW007', 'EWCW00751PE00SB_LG-XL', 'LG', 'SIZE_XL', 999, b'1', b'1'),
(683, 'EWCW007', 'EWCW00751PE00SB_NV-S', 'NV', 'SIZE_S', 0, b'0', b'1'),
(684, 'EWCW007', 'EWCW00751PE00SB_NV-M', 'NV', 'SIZE_M', 0, b'0', b'1'),
(685, 'EWCW007', 'EWCW00751PE00SB_NV-L', 'NV', 'SIZE_L', 0, b'0', b'1'),
(686, 'EWCW007', 'EWCW00751PE00SB_NV-XL', 'NV', 'SIZE_XL', 0, b'0', b'1'),
(687, 'EWCW007', 'EWCW00751PE00SB_BL-S', 'BL', 'SIZE_S', 999, b'1', b'1'),
(688, 'EWCW007', 'EWCW00751PE00SB_BL-M', 'BL', 'SIZE_M', 0, b'0', b'1'),
(689, 'EWCW007', 'EWCW00751PE00SB_BL-L', 'BL', 'SIZE_L', 0, b'0', b'1'),
(690, 'EWCW007', 'EWCW00751PE00SB_BL-XL', 'BL', 'SIZE_XL', 0, b'0', b'1'),
(691, 'DWCT001', 'DWCT00161PE00RB_NV-S', 'NV', 'SIZE_S', 996, b'1', b'1'),
(692, 'DWCT001', 'DWCT00161PE00RB_NV-M', 'NV', 'SIZE_M', 998, b'1', b'1'),
(693, 'DWCT001', 'DWCT00161PE00RB_NV-L', 'NV', 'SIZE_L', 0, b'0', b'1'),
(694, 'DWCT001', 'DWCT00161PE00RB_NV-XL', 'NV', 'SIZE_XL', 0, b'0', b'1'),
(695, 'DWCT001', 'DWCT00161PE00RB_DGR-M', 'DGR', 'SIZE_M', 999, b'1', b'1'),
(696, 'DWCT001', 'DWCT00161PE00RB_DGR-S', 'DGR', 'SIZE_S', 999, b'1', b'1'),
(697, 'DWCT004', 'DWCT00431PE32SB_BL-S', 'BL', 'SIZE_S', 999, b'1', b'1'),
(698, 'DWCT004', 'DWCT00431PE32SB_BL-M', 'BL', 'SIZE_M', 0, b'0', b'1'),
(699, 'DWCT004', 'DWCT00431PE32SB_BL-L', 'BL', 'SIZE_L', 999, b'1', b'1'),
(700, 'DWCT004', 'DWCT00431PE32SB_BL-XL', 'BL', 'SIZE_XL', 999, b'1', b'1'),
(701, 'DWCT004', 'DWCT00431PE32SB_WH-S', 'WH', 'SIZE_S', 999, b'1', b'1'),
(702, 'DWCT004', 'DWCT00431PE32SB_WH-M', 'WH', 'SIZE_M', 999, b'1', b'1'),
(703, 'DWCT004', 'DWCT00431PE32SB_WH-L', 'WH', 'SIZE_L', 999, b'1', b'1'),
(704, 'DWCT004', 'DWCT00431PE32SB_WH-XL', 'WH', 'SIZE_XL', 999, b'1', b'1'),
(705, 'DWCU007', 'DWCU00761PE32SB_ENV-M', 'ENV', 'SIZE_M', 999, b'1', b'1'),
(706, 'DWCU007', 'DWCU00761PE32SB_ENV-S', 'ENV', 'SIZE_S', 999, b'1', b'1'),
(707, 'DWCU007', 'DWCU00761PE32SB_ENV-L', 'ENV', 'SIZE_L', 999, b'1', b'1'),
(708, 'DWCU007', 'DWCU00761PE32SB_ENV-XL', 'ENV', 'SIZE_XL', 999, b'1', b'1'),
(709, 'DWCU007', 'DWCU00761PE32SB_LLG-S', 'LLG', 'SIZE_S', 999, b'1', b'1'),
(710, 'DWCU007', 'DWCU00761PE32SB_LLG-M', 'LLG', 'SIZE_M', 999, b'1', b'1'),
(711, 'DWCU007', 'DWCU00761PE32SB_LLG-L', 'LLG', 'SIZE_L', 999, b'1', b'1'),
(712, 'DWCU007', 'DWCU00761PE32SB_LLG-XXL', 'LLG', 'SIZE_XL', 999, b'1', b'1'),
(713, 'EWCL003', 'EWCL00361PE00RB_CR-S', 'CR', 'SIZE_S', 999, b'1', b'1'),
(714, 'EWCL003', 'EWCL00361PE00RB_CR-M', 'CR', 'SIZE_M', 0, b'0', b'1'),
(715, 'EWCL003', 'EWCL00361PE00RB_CR-L', 'CR', 'SIZE_L', 999, b'1', b'1'),
(716, 'EWCL003', 'EWCL00361PE00RB_CR-XL', 'CR', 'SIZE_XL', 999, b'1', b'1'),
(717, 'EWCP002', 'EWCP00251PE00SB_LG-S', 'LG', 'SIZE_S', 999, b'1', b'1'),
(718, 'EWCP002', 'EWCP00251PE00SB_LG-M', 'LG', 'SIZE_M', 999, b'1', b'1'),
(719, 'EWCP002', 'EWCP00251PE00SB_LG-L', 'LG', 'SIZE_L', 999, b'1', b'1');
INSERT INTO `products_detail` (`product_detail_id`, `product_id`, `code`, `color_id`, `size`, `quantity`, `out_of_stock`, `product_detail_active`) VALUES
(720, 'EWCP002', 'EWCP00251PE00SB_LG-XL', 'LG', 'SIZE_XL', 999, b'1', b'1'),
(721, 'EWCP002', 'EWCP00251PE00SB_DNV-S', 'DNV', 'SIZE_S', 999, b'1', b'1'),
(722, 'EWCP002', 'EWCP00251PE00SB_DNV-M', 'DNV', 'SIZE_M', 999, b'1', b'1'),
(723, 'EWCP002', 'EWCP00251PE00SB_DNV-L', 'DNV', 'SIZE_L', 999, b'1', b'1'),
(724, 'EWCP002', 'EWCP00251PE00SB_DNV-XL', 'DNV', 'SIZE_XL', 999, b'1', b'1'),
(725, 'EWCP002', 'EWCP00251PE00SB_LBE-S', 'LBE', 'SIZE_S', 999, b'1', b'1'),
(726, 'EWCP002', 'EWCP00251PE00SB_LBE-M', 'LBE', 'SIZE_M', 999, b'1', b'1'),
(727, 'EWCP002', 'EWCP00251PE00SB_LBE-L', 'LBE', 'SIZE_L', 999, b'1', b'1'),
(728, 'EWCP002', 'EWCP00251PE00SB_LBE-XL', 'LBE', 'SIZE_XL', 999, b'1', b'1'),
(729, 'EWBS001', 'EWBS00103TC00RB_BL-S', 'BL', 'SIZE_S', 999, b'1', b'1'),
(730, 'EWBS001', 'EWBS00103TC00RB_BL-M', 'BL', 'SIZE_M', 999, b'1', b'1'),
(731, 'EWBS001', 'EWBS00103TC00RB_BL-L', 'BL', 'SIZE_L', 999, b'1', b'1'),
(732, 'EWBS001', 'EWBS00103TC00RB_BL-XL', 'BL', 'SIZE_XL', 999, b'1', b'1'),
(733, 'EWBS001', 'EWBS00103TC00RB_BE-S', 'BE', 'SIZE_S', 999, b'1', b'1'),
(734, 'EWBS001', 'EWBS00103TC00RB_BE-M', 'BE', 'SIZE_M', 999, b'1', b'1'),
(735, 'EWBS001', 'EWBS00103TC00RB_BE-L', 'BE', 'SIZE_L', 999, b'1', b'1'),
(736, 'EWBS001', 'EWBS00103TC00RB_BE-XL', 'BE', 'SIZE_XL', 999, b'1', b'1'),
(737, 'EWBS001', 'EWBS00103TC00RB_LG-S', 'LG', 'SIZE_S', 999, b'1', b'1'),
(738, 'EWBS001', 'EWBS00103TC00RB_LG-M', 'LG', 'SIZE_M', 999, b'1', b'1'),
(739, 'EWBS001', 'EWBS00103TC00RB_LG-L', 'LG', 'SIZE_L', 999, b'1', b'1'),
(740, 'EWBS001', 'EWBS00103TC00RB_LG-XL', 'LG', 'SIZE_XL', 999, b'1', b'1'),
(744, 'EWTW003', 'EWTW00311TC00RB_BL-S', 'BL', 'SIZE_S', 999, b'1', b'1'),
(745, 'EWTW003', 'EWTW00311TC00RB_BL-M', 'BL', 'SIZE_M', 999, b'1', b'1'),
(746, 'EWTW003', 'EWTW00311TC00RB_BL-L', 'BL', 'SIZE_L', 999, b'1', b'1'),
(747, 'EWTW003', 'EWTW00311TC00RB_BL-XL', 'BL', 'SIZE_XL', 999, b'1', b'1'),
(748, 'EWTW003', 'EWTW00311TC00RB_BE-L', 'BE', 'SIZE_S', 999, b'1', b'1'),
(749, 'EWTW003', 'EWTW00311TC00RB_BE-S', 'BE', 'SIZE_S', 999, b'1', b'1'),
(750, 'EWTW003', 'EWTW00311TC00RB_BE-M', 'BE', 'SIZE_M', 0, b'0', b'1'),
(751, 'EWTW003', 'EWTW00311TC00RB_BE-XL', 'BE', 'SIZE_XL', 0, b'0', b'1'),
(752, 'EWTW003', 'EWTW00311TC00RB_BE-XXL', 'BE', 'SIZE_XXL', 999, b'1', b'1'),
(753, 'EWTW003', 'EWTW00311TC00RB_BL-XXL', 'BL', 'SIZE_XXL', 999, b'1', b'1'),
(754, 'EWTW003', 'EWTW00311TC00RB_LG-M', 'LG', 'SIZE_M', 0, b'0', b'1'),
(755, 'EWTW003', 'EWTW00311TC00RB_LG-L', 'LG', 'SIZE_L', 0, b'0', b'1'),
(756, 'EWTW003', 'EWTW00311TC00RB_LG-S', 'LG', 'SIZE_S', 999, b'1', b'1'),
(757, 'EWTW003', 'EWTW00311TC00RB_LG-XL', 'LG', 'SIZE_XL', 999, b'1', b'1'),
(758, 'EWTW003', 'EWTW00311TC00RB_LG-XXL', 'LG', 'SIZE_XXL', 999, b'1', b'1'),
(759, 'EWTE003', 'EWTE00311AC08SB_NV-M', 'NV', 'SIZE_M', 999, b'1', b'1'),
(760, 'EWTE003', 'EWTE00311AC08SB_NV-S', 'NV', 'SIZE_S', 999, b'1', b'1'),
(761, 'EWTE003', 'EWTE00311AC08SB_NV-L', 'NV', 'SIZE_L', 999, b'1', b'1'),
(762, 'EWTE003', 'EWTE00311AC08SB_NV-XL', 'NV', 'SIZE_XL', 999, b'1', b'1'),
(763, 'EWTE003', 'EWTE00311AC08SB_BL-S', 'BL', 'SIZE_S', 999, b'1', b'1'),
(764, 'EWTE003', 'EWTE00311AC08SB_BL-M', 'BL', 'SIZE_M', 999, b'1', b'1'),
(765, 'EWTE003', 'EWTE00311AC08SB_BL-XL', 'BL', 'SIZE_XL', 999, b'1', b'1'),
(766, 'EWTE003', ' EWTE00311AC08SB_BL-L', 'BL', 'SIZE_L', 999, b'1', b'1'),
(792, 'BI013', 'test', 'BBR', 'SIZE_M', 1, b'1', b'1'),
(794, 'BI013', 'test2', 'BBR', 'SIZE_M', 1, b'1', b'1'),
(796, 'BI013', 'test3', 'BBR', 'SIZE_M', 1, b'1', b'1'),
(799, 'BI013', 'test4', 'BBR', 'SIZE_M', 1, b'1', b'1');

--
-- Bẫy `products_detail`
--
DELIMITER $$
CREATE TRIGGER `delete_total_color` AFTER DELETE ON `products_detail` FOR EACH ROW BEGIN
    UPDATE products
    SET total_color = (
        SELECT COUNT(DISTINCT color_id)
        FROM products_detail
        WHERE product_id = OLD.product_id
    )
    WHERE product_id = OLD.product_id;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `delete_total_size` AFTER DELETE ON `products_detail` FOR EACH ROW BEGIN
    UPDATE products
    SET total_size = (
        SELECT COUNT(DISTINCT size)
        FROM products_detail
        WHERE product_id = OLD.product_id
    )
    WHERE product_id = OLD.product_id;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `insert_status` BEFORE INSERT ON `products_detail` FOR EACH ROW BEGIN
    IF NEW.quantity <= 0 THEN
        SET NEW.out_of_stock = 0;
    ELSE
        SET NEW.out_of_stock = 1;
    END IF;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `insert_total_color` AFTER INSERT ON `products_detail` FOR EACH ROW BEGIN
    UPDATE products
    SET total_color = (
        SELECT COUNT(DISTINCT color_id)
        FROM products_detail
        WHERE product_id = NEW.product_id
    )
    WHERE product_id = NEW.product_id;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `insert_total_size` AFTER INSERT ON `products_detail` FOR EACH ROW BEGIN
    UPDATE products
    SET total_size = (
        SELECT COUNT(DISTINCT size)
        FROM products_detail
        WHERE product_id = NEW.product_id
    )
    WHERE product_id = NEW.product_id;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `update_status` BEFORE UPDATE ON `products_detail` FOR EACH ROW BEGIN
    IF NEW.quantity <= 0 THEN
        SET NEW.out_of_stock = 0;
    ELSE
        SET NEW.out_of_stock = 1;
    END IF;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `update_total_color` AFTER UPDATE ON `products_detail` FOR EACH ROW BEGIN
    UPDATE products
    SET total_color = (
        SELECT COUNT(DISTINCT color_id)
        FROM products_detail
        WHERE product_id = NEW.product_id
    )
    WHERE product_id = NEW.product_id;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `update_total_size` AFTER UPDATE ON `products_detail` FOR EACH ROW BEGIN
    UPDATE products
    SET total_size = (
        SELECT COUNT(DISTINCT size)
        FROM products_detail
        WHERE product_id = NEW.product_id
    )
    WHERE product_id = NEW.product_id;
END
$$
DELIMITER ;

--
-- Chỉ mục cho các bảng đã đổ
--

--
-- Chỉ mục cho bảng `accounts`
--
ALTER TABLE `accounts`
  ADD PRIMARY KEY (`account_id`),
  ADD UNIQUE KEY `unique_constraint_name` (`username`,`phone`,`email`);

--
-- Chỉ mục cho bảng `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`cat_id`),
  ADD KEY `dsgsg` (`parent_id`);

--
-- Chỉ mục cho bảng `colors`
--
ALTER TABLE `colors`
  ADD PRIMARY KEY (`color_id`);

--
-- Chỉ mục cho bảng `imgs_product`
--
ALTER TABLE `imgs_product`
  ADD PRIMARY KEY (`img_id`),
  ADD KEY `bd` (`product_id`);

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
  ADD PRIMARY KEY (`product_id`),
  ADD KEY `dsgd` (`cat_id`);

--
-- Chỉ mục cho bảng `products_detail`
--
ALTER TABLE `products_detail`
  ADD PRIMARY KEY (`product_detail_id`),
  ADD UNIQUE KEY `code` (`code`),
  ADD KEY `gfd` (`color_id`),
  ADD KEY `grwr` (`product_id`);

--
-- AUTO_INCREMENT cho các bảng đã đổ
--

--
-- AUTO_INCREMENT cho bảng `accounts`
--
ALTER TABLE `accounts`
  MODIFY `account_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=28;

--
-- AUTO_INCREMENT cho bảng `imgs_product`
--
ALTER TABLE `imgs_product`
  MODIFY `img_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=706;

--
-- AUTO_INCREMENT cho bảng `jwt_tokens`
--
ALTER TABLE `jwt_tokens`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=86;

--
-- AUTO_INCREMENT cho bảng `products_detail`
--
ALTER TABLE `products_detail`
  MODIFY `product_detail_id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=804;

--
-- Các ràng buộc cho các bảng đã đổ
--

--
-- Các ràng buộc cho bảng `categories`
--
ALTER TABLE `categories`
  ADD CONSTRAINT `dsgsg` FOREIGN KEY (`parent_id`) REFERENCES `categories` (`cat_id`);

--
-- Các ràng buộc cho bảng `imgs_product`
--
ALTER TABLE `imgs_product`
  ADD CONSTRAINT `bd` FOREIGN KEY (`product_id`) REFERENCES `products` (`product_id`);

--
-- Các ràng buộc cho bảng `jwt_tokens`
--
ALTER TABLE `jwt_tokens`
  ADD CONSTRAINT `jwt_tokens_ibfk_1` FOREIGN KEY (`account_id`) REFERENCES `accounts` (`account_id`);

--
-- Các ràng buộc cho bảng `products`
--
ALTER TABLE `products`
  ADD CONSTRAINT `dsgd` FOREIGN KEY (`cat_id`) REFERENCES `categories` (`cat_id`);

--
-- Các ràng buộc cho bảng `products_detail`
--
ALTER TABLE `products_detail`
  ADD CONSTRAINT `gfd` FOREIGN KEY (`color_id`) REFERENCES `colors` (`color_id`),
  ADD CONSTRAINT `grwr` FOREIGN KEY (`product_id`) REFERENCES `products` (`product_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

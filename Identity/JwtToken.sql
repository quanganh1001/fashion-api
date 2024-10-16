-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Máy chủ: localhost
-- Thời gian đã tạo: Th10 16, 2024 lúc 11:47 AM
-- Phiên bản máy phục vụ: 10.4.28-MariaDB
-- Phiên bản PHP: 8.2.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Cơ sở dữ liệu: `JwtToken`
--
CREATE DATABASE IF NOT EXISTS `JwtToken` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `JwtToken`;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `jwt_tokens`
--

DROP TABLE IF EXISTS `jwt_tokens`;
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
(74, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJuZ3V5ZW5xdWFuZ2FuaCIsInBob25lIjoiMDM2NTE1MTgyMiIsInJvbGUiOiJST0xFX0VNUExPWUVFIiwiaWF0IjoxNzI5MDY3MDE0LCJleHAiOjE3MjkwNjc2MTR9.zYcQtcvD-GtjlcRCHotegTwN4UOMAXya3LI9N5bcWhs', '2024-10-16 15:33:34', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJuZ3V5ZW5xdWFuZ2FuaCIsInBob25lIjoiMDM2NTE1MTgyMiIsInJvbGUiOiJST0xFX0VNUExPWUVFIiwiaWF0IjoxNzI5MDY3MDE0LCJleHAiOjE3Mjk2NzE4MTR9.J5gnRl9h26RmKmfTn9fVEj0zUf-3oGVWp6qi6z05-2E', 2, '2024-10-23 15:23:34', 0, '2024-10-16 08:23:34', '2024-10-16 08:23:34'),
(80, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJuZ3V5ZW5xdWFuZ2FuaCIsInBob25lIjoiMDM2NDEwMDE5NiIsInJvbGUiOiJST0xFX01BTkFHRVIiLCJpYXQiOjE3MjkwNzAzMDcsImV4cCI6MTcyOTA3MDkwN30.iaohqfrZU-FLufZMNY0ieThM0DA0Jq2NqZXdvwGXwRU', '2024-10-16 16:28:27', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJuZ3V5ZW5xdWFuZ2FuaCIsInBob25lIjoiMDM2NDEwMDE5NiIsInJvbGUiOiJST0xFX01BTkFHRVIiLCJpYXQiOjE3MjkwNzAzMDcsImV4cCI6MTcyOTY3NTEwN30.cQpmZahI2RoOdqOtItK5QmWU2ImAM3hETwa8KCDK5bU', 1, '2024-11-15 16:18:27', 0, '2024-10-16 09:17:28', '2024-10-16 09:18:27'),
(84, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJuZ3V5ZW5xdWFuZ2FuaCIsInBob25lIjoiMDM2NDEwMDE5NiIsInJvbGUiOiJST0xFX01BTkFHRVIiLCJpYXQiOjE3MjkwNzEyODIsImV4cCI6MTcyOTA3MTg4Mn0.3_hkg9N2VFVGNgh5OoW_tOzFSLsjO1vU9m_2ZgXtm34', '2024-10-16 16:44:42', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJuZ3V5ZW5xdWFuZ2FuaCIsInBob25lIjoiMDM2NDEwMDE5NiIsInJvbGUiOiJST0xFX01BTkFHRVIiLCJpYXQiOjE3MjkwNzEyODIsImV4cCI6MTcyOTY3NjA4Mn0.CBYQwx9EO3KfuuDFA55gXCIjXJ5H4uHBF_yEd16Rf2o', 1, '2024-11-15 16:34:42', 0, '2024-10-16 09:24:51', '2024-10-16 09:34:42');

--
-- Chỉ mục cho các bảng đã đổ
--

--
-- Chỉ mục cho bảng `jwt_tokens`
--
ALTER TABLE `jwt_tokens`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT cho các bảng đã đổ
--

--
-- AUTO_INCREMENT cho bảng `jwt_tokens`
--
ALTER TABLE `jwt_tokens`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=85;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

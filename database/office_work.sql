/*
 Navicat Premium Data Transfer

 Source Server         : localhost_3306
 Source Server Type    : MySQL
 Source Server Version : 100131
 Source Host           : localhost:3306
 Source Schema         : office_work

 Target Server Type    : MySQL
 Target Server Version : 100131
 File Encoding         : 65001

 Date: 22/06/2019 13:20:48
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for attendance_settings
-- ----------------------------
DROP TABLE IF EXISTS `attendance_settings`;
CREATE TABLE `attendance_settings`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `company_id` int(10) UNSIGNED NULL DEFAULT NULL,
  `office_start_time` time(0) NOT NULL,
  `office_end_time` time(0) NOT NULL,
  `halfday_mark_time` time(0) NULL DEFAULT NULL,
  `late_mark_duration` tinyint(4) NOT NULL,
  `clockin_in_day` int(11) NOT NULL DEFAULT 1,
  `employee_clock_in_out` enum('yes','no') CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT 'yes',
  `office_open_days` varchar(191) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT '[1,2,3,4,5]',
  `ip_address` text CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL,
  `radius` int(11) NULL DEFAULT NULL,
  `radius_check` enum('yes','no') CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT 'no',
  `ip_check` enum('yes','no') CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT 'no',
  `created_at` timestamp(0) NULL DEFAULT NULL,
  `updated_at` timestamp(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `attendance_settings_company_id_foreign`(`company_id`) USING BTREE,
  CONSTRAINT `attendance_settings_company_id_foreign` FOREIGN KEY (`company_id`) REFERENCES `companies` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8 COLLATE = utf8_unicode_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of attendance_settings
-- ----------------------------
INSERT INTO `attendance_settings` VALUES (1, NULL, '09:00:00', '18:00:00', NULL, 20, 2, 'yes', '[1,2,3,4,5]', NULL, NULL, 'no', 'no', '2019-06-16 06:25:10', '2019-06-16 06:25:10');
INSERT INTO `attendance_settings` VALUES (2, 1, '09:30:00', '17:30:00', '00:00:00', 20, 1, 'yes', '[\"1\",\"2\",\"3\",\"4\",\"6\",\"0\"]', '[null]', NULL, 'no', 'no', '2019-06-16 06:34:22', '2019-06-22 05:54:41');

-- ----------------------------
-- Table structure for attendances
-- ----------------------------
DROP TABLE IF EXISTS `attendances`;
CREATE TABLE `attendances`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `company_id` int(10) UNSIGNED NULL DEFAULT NULL,
  `user_id` int(10) UNSIGNED NOT NULL,
  `clock_in_time` datetime(0) NOT NULL,
  `clock_out_time` datetime(0) NULL DEFAULT NULL,
  `clock_in_ip` varchar(191) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `clock_out_ip` varchar(191) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `working_from` varchar(191) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT 'office',
  `late` enum('yes','no') CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT 'no',
  `half_day` enum('yes','no') CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `created_at` timestamp(0) NULL DEFAULT NULL,
  `updated_at` timestamp(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `attendances_user_id_foreign`(`user_id`) USING BTREE,
  INDEX `attendances_company_id_foreign`(`company_id`) USING BTREE,
  CONSTRAINT `attendances_company_id_foreign` FOREIGN KEY (`company_id`) REFERENCES `companies` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `attendances_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8 COLLATE = utf8_unicode_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of attendances
-- ----------------------------
INSERT INTO `attendances` VALUES (1, 1, 5, '2019-06-22 05:21:55', NULL, '127.0.0.1', '', 'ISA', 'yes', 'no', '2019-06-22 05:21:55', '2019-06-22 05:21:55');

-- ----------------------------
-- Table structure for client_contacts
-- ----------------------------
DROP TABLE IF EXISTS `client_contacts`;
CREATE TABLE `client_contacts`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` int(10) UNSIGNED NOT NULL,
  `contact_name` varchar(191) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `phone` varchar(191) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT NULL,
  `email` varchar(191) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT NULL,
  `created_at` timestamp(0) NULL DEFAULT NULL,
  `updated_at` timestamp(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `client_contacts_user_id_foreign`(`user_id`) USING BTREE,
  CONSTRAINT `client_contacts_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_unicode_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for client_details
-- ----------------------------
DROP TABLE IF EXISTS `client_details`;
CREATE TABLE `client_details`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `company_id` int(10) UNSIGNED NULL DEFAULT NULL,
  `user_id` int(10) UNSIGNED NOT NULL,
  `company_name` varchar(191) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT NULL,
  `address` text CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL,
  `website` varchar(191) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT NULL,
  `note` text CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL,
  `linkedin` varchar(191) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT NULL,
  `facebook` varchar(191) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT NULL,
  `twitter` varchar(191) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT NULL,
  `skype` varchar(191) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT NULL,
  `gst_number` varchar(191) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT NULL,
  `created_at` timestamp(0) NULL DEFAULT NULL,
  `updated_at` timestamp(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `client_details_user_id_foreign`(`user_id`) USING BTREE,
  INDEX `client_details_company_id_foreign`(`company_id`) USING BTREE,
  CONSTRAINT `client_details_company_id_foreign` FOREIGN KEY (`company_id`) REFERENCES `companies` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `client_details_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8 COLLATE = utf8_unicode_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of client_details
-- ----------------------------
INSERT INTO `client_details` VALUES (1, 1, 4, 'Jahangirnagar University', 'Savar,Dhaka', 'http://www.juniv.edu/', NULL, NULL, NULL, NULL, NULL, NULL, '2019-06-18 06:41:48', '2019-06-18 06:41:48');
INSERT INTO `client_details` VALUES (2, 1, 6, 'Transcom Limited', 'Gulshan 2', 'http://www.transcom.com', NULL, NULL, NULL, NULL, NULL, NULL, '2019-06-19 05:20:54', '2019-06-19 05:20:54');
INSERT INTO `client_details` VALUES (3, 1, 11, 'Pepsi Bangladesh', 'Gulshan Tower', 'http://pepsibd.com', NULL, NULL, NULL, NULL, NULL, NULL, '2019-06-20 15:32:44', '2019-06-20 15:32:44');
INSERT INTO `client_details` VALUES (4, 1, 12, 'Pepsi Bangladesh', 'Gulshan Tower', 'http://pepsibd.com', NULL, NULL, NULL, NULL, NULL, NULL, '2019-06-20 15:36:25', '2019-06-20 15:36:25');

-- ----------------------------
-- Table structure for companies
-- ----------------------------
DROP TABLE IF EXISTS `companies`;
CREATE TABLE `companies`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `company_name` varchar(191) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `company_email` varchar(191) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `company_phone` varchar(191) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `logo` varchar(191) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT NULL,
  `login_background` varchar(191) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT NULL,
  `address` text CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `website` varchar(191) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT NULL,
  `currency_id` int(10) UNSIGNED NULL DEFAULT NULL,
  `package_id` int(10) UNSIGNED NULL DEFAULT NULL,
  `package_type` enum('monthly','annual') CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT 'monthly',
  `timezone` varchar(191) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT 'Asia/Kolkata',
  `date_format` varchar(20) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT 'd-m-Y',
  `time_format` varchar(20) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT 'h:i a',
  `locale` varchar(191) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT 'en',
  `latitude` decimal(10, 8) NOT NULL DEFAULT 26.91243360,
  `longitude` decimal(11, 8) NOT NULL DEFAULT 75.78727090,
  `leaves_start_from` enum('joining_date','year_start') CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT 'joining_date',
  `active_theme` enum('default','custom') CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT 'default',
  `status` enum('active','inactive','license_expired') CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT 'active',
  `task_self` enum('yes','no') CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT 'yes',
  `last_updated_by` int(10) UNSIGNED NULL DEFAULT NULL,
  `created_at` timestamp(0) NULL DEFAULT NULL,
  `updated_at` timestamp(0) NULL DEFAULT NULL,
  `stripe_id` varchar(191) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT NULL,
  `card_brand` varchar(191) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT NULL,
  `card_last_four` varchar(191) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT NULL,
  `trial_ends_at` timestamp(0) NULL DEFAULT NULL,
  `licence_expire_on` date NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `organisation_settings_last_updated_by_foreign`(`last_updated_by`) USING BTREE,
  INDEX `companies_package_id_foreign`(`package_id`) USING BTREE,
  INDEX `companies_currency_id_foreign`(`currency_id`) USING BTREE,
  CONSTRAINT `companies_currency_id_foreign` FOREIGN KEY (`currency_id`) REFERENCES `currencies` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `companies_package_id_foreign` FOREIGN KEY (`package_id`) REFERENCES `packages` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `organisation_settings_last_updated_by_foreign` FOREIGN KEY (`last_updated_by`) REFERENCES `users` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8 COLLATE = utf8_unicode_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of companies
-- ----------------------------
INSERT INTO `companies` VALUES (1, 'eOFFICE', 'admin@example.com', '+8801829647199', 'D0TNbpUy1SPvEmcalVloi1H3s7T7wgrwxHj8Zygf.png', NULL, 'Company address', 'www.eOffice.com', 5, 6, 'annual', 'Asia/Dhaka', 'd-m-Y', 'h:i A', 'en', 23.88130000, 90.26740000, 'year_start', 'default', 'active', 'yes', 1, '2019-06-16 06:34:18', '2019-06-22 05:47:40', NULL, NULL, NULL, NULL, '2020-06-18');

-- ----------------------------
-- Table structure for conversation
-- ----------------------------
DROP TABLE IF EXISTS `conversation`;
CREATE TABLE `conversation`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_one` int(10) UNSIGNED NOT NULL,
  `user_two` int(10) UNSIGNED NOT NULL,
  `created_at` timestamp(0) NULL DEFAULT NULL,
  `updated_at` timestamp(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `conversation_user_one_foreign`(`user_one`) USING BTREE,
  INDEX `conversation_user_two_foreign`(`user_two`) USING BTREE,
  CONSTRAINT `conversation_user_one_foreign` FOREIGN KEY (`user_one`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `conversation_user_two_foreign` FOREIGN KEY (`user_two`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_unicode_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for conversation_reply
-- ----------------------------
DROP TABLE IF EXISTS `conversation_reply`;
CREATE TABLE `conversation_reply`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `conversation_id` int(10) UNSIGNED NOT NULL,
  `reply` text CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `user_id` int(10) UNSIGNED NOT NULL,
  `created_at` timestamp(0) NULL DEFAULT NULL,
  `updated_at` timestamp(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `conversation_reply_conversation_id_foreign`(`conversation_id`) USING BTREE,
  INDEX `conversation_reply_user_id_foreign`(`user_id`) USING BTREE,
  CONSTRAINT `conversation_reply_conversation_id_foreign` FOREIGN KEY (`conversation_id`) REFERENCES `conversation` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `conversation_reply_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_unicode_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for countries
-- ----------------------------
DROP TABLE IF EXISTS `countries`;
CREATE TABLE `countries`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(200) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `is_visible` tinyint(4) NOT NULL,
  `iso_alpha2` char(2) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `iso_alpha3` char(2) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `iso_numeric` int(10) UNSIGNED NOT NULL,
  `currency_code` varchar(3) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `currency_name` varchar(32) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `currency_symbol` varchar(3) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `flag` varchar(6) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `countries_iso_alpha2_index`(`iso_alpha2`) USING BTREE,
  INDEX `countries_iso_alpha3_index`(`iso_alpha3`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 240 CHARACTER SET = utf8 COLLATE = utf8_unicode_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of countries
-- ----------------------------
INSERT INTO `countries` VALUES (1, 'Aruba', 1, 'AW', 'AB', 0, 'AWG', 'Guilder', 'ƒ', 'aw.png');
INSERT INTO `countries` VALUES (2, 'Afghanistan', 1, 'AF', 'AF', 0, 'AFN', 'Afghani', '؋', 'af.png');
INSERT INTO `countries` VALUES (3, 'Angola', 1, 'AO', 'AG', 0, 'AOA', 'Kwanza', 'Kz', 'ao.png');
INSERT INTO `countries` VALUES (4, 'Anguilla', 1, 'AI', 'AI', 0, 'XCD', 'Dollar', '$', 'ai.png');
INSERT INTO `countries` VALUES (5, 'Albania', 1, 'AL', 'AL', 0, 'ALL', 'Lek', 'Lek', 'al.png');
INSERT INTO `countries` VALUES (6, 'Andorra', 1, 'AD', 'AN', 0, 'EUR', 'Euro', '€', 'ad.png');
INSERT INTO `countries` VALUES (7, 'Netherlands Antilles', 1, 'AN', 'AN', 0, 'ANG', 'Guilder', 'ƒ', 'an.png');
INSERT INTO `countries` VALUES (8, 'United Arab Emirates', 1, 'AE', 'AR', 0, 'AED', 'Dirham', '', 'ae.png');
INSERT INTO `countries` VALUES (9, 'Argentina', 1, 'AR', 'AR', 0, 'ARS', 'Peso', '$', 'ar.png');
INSERT INTO `countries` VALUES (10, 'Armenia', 1, 'AM', 'AR', 0, 'AMD', 'Dram', '', 'am.png');
INSERT INTO `countries` VALUES (11, 'American Samoa', 1, 'AS', 'AS', 0, 'USD', 'Dollar', '$', 'as.png');
INSERT INTO `countries` VALUES (12, 'Antarctica', 1, 'AQ', 'AT', 0, '', '', '', 'aq.png');
INSERT INTO `countries` VALUES (13, 'French Southern territories', 1, 'TF', 'AT', 0, 'EUR', 'Euro  ', '€', 'tf.png');
INSERT INTO `countries` VALUES (14, 'Antigua and Barbuda', 1, 'AG', 'AT', 0, 'XCD', 'Dollar', '$', 'ag.png');
INSERT INTO `countries` VALUES (15, 'Australia', 1, 'AU', 'AU', 0, 'AUD', 'Dollar', '$', 'au.png');
INSERT INTO `countries` VALUES (16, 'Austria', 1, 'AT', 'AU', 0, 'EUR', 'Euro', '€', 'at.png');
INSERT INTO `countries` VALUES (17, 'Azerbaijan', 1, 'AZ', 'AZ', 0, 'AZN', 'Manat', 'ман', 'az.png');
INSERT INTO `countries` VALUES (18, 'Burundi', 1, 'BI', 'BD', 0, 'BIF', 'Franc', '', 'bi.png');
INSERT INTO `countries` VALUES (19, 'Belgium', 1, 'BE', 'BE', 0, 'EUR', 'Euro', '€', 'be.png');
INSERT INTO `countries` VALUES (20, 'Benin', 1, 'BJ', 'BE', 0, 'XOF', 'Franc', '', 'bj.png');
INSERT INTO `countries` VALUES (21, 'Burkina Faso', 1, 'BF', 'BF', 0, 'XOF', 'Franc', '', 'bf.png');
INSERT INTO `countries` VALUES (22, 'Bangladesh', 1, 'BD', 'BG', 0, 'BDT', 'Taka', '', 'bd.png');
INSERT INTO `countries` VALUES (23, 'Bulgaria', 1, 'BG', 'BG', 0, 'BGN', 'Lev', 'лв', 'bg.png');
INSERT INTO `countries` VALUES (24, 'Bahrain', 1, 'BH', 'BH', 0, 'BHD', 'Dinar', '', 'bh.png');
INSERT INTO `countries` VALUES (25, 'Bahamas', 1, 'BS', 'BH', 0, 'BSD', 'Dollar', '$', 'bs.png');
INSERT INTO `countries` VALUES (26, 'Bosnia and Herzegovina', 1, 'BA', 'BI', 0, 'BAM', 'Marka', 'KM', 'ba.png');
INSERT INTO `countries` VALUES (27, 'Belarus', 1, 'BY', 'BL', 0, 'BYR', 'Ruble', 'p.', 'by.png');
INSERT INTO `countries` VALUES (28, 'Belize', 1, 'BZ', 'BL', 0, 'BZD', 'Dollar', 'BZ$', 'bz.png');
INSERT INTO `countries` VALUES (29, 'Bermuda', 1, 'BM', 'BM', 0, 'BMD', 'Dollar', '$', 'bm.png');
INSERT INTO `countries` VALUES (30, 'Bolivia', 1, 'BO', 'BO', 0, 'BOB', 'Boliviano', '$b', 'bo.png');
INSERT INTO `countries` VALUES (31, 'Brazil', 1, 'BR', 'BR', 0, 'BRL', 'Real', 'R$', 'br.png');
INSERT INTO `countries` VALUES (32, 'Barbados', 1, 'BB', 'BR', 0, 'BBD', 'Dollar', '$', 'bb.png');
INSERT INTO `countries` VALUES (33, 'Brunei', 1, 'BN', 'BR', 0, 'BND', 'Dollar', '$', 'bn.png');
INSERT INTO `countries` VALUES (34, 'Bhutan', 1, 'BT', 'BT', 0, 'BTN', 'Ngultrum', '', 'bt.png');
INSERT INTO `countries` VALUES (35, 'Bouvet Island', 1, 'BV', 'BV', 0, 'NOK', 'Krone', 'kr', 'bv.png');
INSERT INTO `countries` VALUES (36, 'Botswana', 1, 'BW', 'BW', 0, 'BWP', 'Pula', 'P', 'bw.png');
INSERT INTO `countries` VALUES (37, 'Central African Republic', 1, 'CF', 'CA', 0, 'XAF', 'Franc', 'FCF', 'cf.png');
INSERT INTO `countries` VALUES (38, 'Canada', 1, 'CA', 'CA', 0, 'CAD', 'Dollar', '$', 'ca.png');
INSERT INTO `countries` VALUES (40, 'Switzerland', 1, 'CH', 'CH', 0, 'CHF', 'Franc', 'CHF', 'ch.png');
INSERT INTO `countries` VALUES (41, 'Chile', 1, 'CL', 'CH', 0, 'CLP', 'Peso', '', 'cl.png');
INSERT INTO `countries` VALUES (42, 'China', 1, 'CN', 'CH', 0, 'CNY', 'Yuan Renminbi', '¥', 'cn.png');
INSERT INTO `countries` VALUES (44, 'Cameroon', 1, 'CM', 'CM', 0, 'XAF', 'Franc', 'FCF', 'cm.png');
INSERT INTO `countries` VALUES (47, 'Cook Islands', 1, 'CK', 'CO', 0, 'NZD', 'Dollar', '$', 'ck.png');
INSERT INTO `countries` VALUES (48, 'Colombia', 1, 'CO', 'CO', 0, 'COP', 'Peso', '$', 'co.png');
INSERT INTO `countries` VALUES (49, 'Comoros', 1, 'KM', 'CO', 0, 'KMF', 'Franc', '', 'km.png');
INSERT INTO `countries` VALUES (50, 'Cape Verde', 1, 'CV', 'CP', 0, 'CVE', 'Escudo', '', 'cv.png');
INSERT INTO `countries` VALUES (51, 'Costa Rica', 1, 'CR', 'CR', 0, 'CRC', 'Colon', '₡', 'cr.png');
INSERT INTO `countries` VALUES (52, 'Cuba', 1, 'CU', 'CU', 0, 'CUP', 'Peso', '₱', 'cu.png');
INSERT INTO `countries` VALUES (53, 'Christmas Island', 1, 'CX', 'CX', 0, 'AUD', 'Dollar', '$', 'cx.png');
INSERT INTO `countries` VALUES (54, 'Cayman Islands', 1, 'KY', 'CY', 0, 'KYD', 'Dollar', '$', 'ky.png');
INSERT INTO `countries` VALUES (55, 'Cyprus', 1, 'CY', 'CY', 0, 'CYP', 'Pound', '', 'cy.png');
INSERT INTO `countries` VALUES (56, 'Czech Republic', 1, 'CZ', 'CZ', 0, 'CZK', 'Koruna', 'Kč', 'cz.png');
INSERT INTO `countries` VALUES (57, 'Germany', 1, 'DE', 'DE', 0, 'EUR', 'Euro', '€', 'de.png');
INSERT INTO `countries` VALUES (58, 'Djibouti', 1, 'DJ', 'DJ', 0, 'DJF', 'Franc', '', 'dj.png');
INSERT INTO `countries` VALUES (59, 'Dominica', 1, 'DM', 'DM', 0, 'XCD', 'Dollar', '$', 'dm.png');
INSERT INTO `countries` VALUES (60, 'Denmark', 1, 'DK', 'DN', 0, 'DKK', 'Krone', 'kr', 'dk.png');
INSERT INTO `countries` VALUES (61, 'Dominican Republic', 1, 'DO', 'DO', 0, 'DOP', 'Peso', 'RD$', 'do.png');
INSERT INTO `countries` VALUES (62, 'Algeria', 1, 'DZ', 'DZ', 0, 'DZD', 'Dinar', '', 'dz.png');
INSERT INTO `countries` VALUES (63, 'Ecuador', 1, 'EC', 'EC', 0, 'USD', 'Dollar', '$', 'ec.png');
INSERT INTO `countries` VALUES (64, 'Egypt', 1, 'EG', 'EG', 0, 'EGP', 'Pound', '£', 'eg.png');
INSERT INTO `countries` VALUES (65, 'Eritrea', 1, 'ER', 'ER', 0, 'ERN', 'Nakfa', 'Nfk', 'er.png');
INSERT INTO `countries` VALUES (66, 'Western Sahara', 1, 'EH', 'ES', 0, 'MAD', 'Dirham', '', 'eh.png');
INSERT INTO `countries` VALUES (67, 'Spain', 1, 'ES', 'ES', 0, 'EUR', 'Euro', '€', 'es.png');
INSERT INTO `countries` VALUES (68, 'Estonia', 1, 'EE', 'ES', 0, 'EEK', 'Kroon', 'kr', 'ee.png');
INSERT INTO `countries` VALUES (69, 'Ethiopia', 1, 'ET', 'ET', 0, 'ETB', 'Birr', '', 'et.png');
INSERT INTO `countries` VALUES (70, 'Finland', 1, 'FI', 'FI', 0, 'EUR', 'Euro', '€', 'fi.png');
INSERT INTO `countries` VALUES (72, 'Falkland Islands', 1, 'FK', 'FL', 0, 'FKP', 'Pound', '£', 'fk.png');
INSERT INTO `countries` VALUES (73, 'France', 1, 'FR', 'FR', 0, 'EUR', 'Euro', '€', 'fr.png');
INSERT INTO `countries` VALUES (74, 'Faroe Islands', 1, 'FO', 'FR', 0, 'DKK', 'Krone', 'kr', 'fo.png');
INSERT INTO `countries` VALUES (76, 'Gabon', 1, 'GA', 'GA', 0, 'XAF', 'Franc', 'FCF', 'ga.png');
INSERT INTO `countries` VALUES (77, 'United Kingdom', 1, 'GB', 'GB', 0, 'GBP', 'Pound', '£', 'gb.png');
INSERT INTO `countries` VALUES (78, 'Georgia', 1, 'GE', 'GE', 0, 'GEL', 'Lari', '', 'ge.png');
INSERT INTO `countries` VALUES (79, 'Ghana', 1, 'GH', 'GH', 0, 'GHC', 'Cedi', '¢', 'gh.png');
INSERT INTO `countries` VALUES (80, 'Gibraltar', 1, 'GI', 'GI', 0, 'GIP', 'Pound', '£', 'gi.png');
INSERT INTO `countries` VALUES (81, 'Guinea', 1, 'GN', 'GI', 0, 'GNF', 'Franc', '', 'gn.png');
INSERT INTO `countries` VALUES (82, 'Guadeloupe', 1, 'GP', 'GL', 0, 'EUR', 'Euro', '€', 'gp.png');
INSERT INTO `countries` VALUES (83, 'Gambia', 1, 'GM', 'GM', 0, 'GMD', 'Dalasi', 'D', 'gm.png');
INSERT INTO `countries` VALUES (84, 'Guinea-Bissau', 1, 'GW', 'GN', 0, 'XOF', 'Franc', '', 'gw.png');
INSERT INTO `countries` VALUES (85, 'Equatorial Guinea', 1, 'GQ', 'GN', 0, 'XAF', 'Franc', 'FCF', 'gq.png');
INSERT INTO `countries` VALUES (86, 'Greece', 1, 'GR', 'GR', 0, 'EUR', 'Euro', '€', 'gr.png');
INSERT INTO `countries` VALUES (87, 'Grenada', 1, 'GD', 'GR', 0, 'XCD', 'Dollar', '$', 'gd.png');
INSERT INTO `countries` VALUES (88, 'Greenland', 1, 'GL', 'GR', 0, 'DKK', 'Krone', 'kr', 'gl.png');
INSERT INTO `countries` VALUES (89, 'Guatemala', 1, 'GT', 'GT', 0, 'GTQ', 'Quetzal', 'Q', 'gt.png');
INSERT INTO `countries` VALUES (90, 'French Guiana', 1, 'GF', 'GU', 0, 'EUR', 'Euro', '€', 'gf.png');
INSERT INTO `countries` VALUES (91, 'Guam', 1, 'GU', 'GU', 0, 'USD', 'Dollar', '$', 'gu.png');
INSERT INTO `countries` VALUES (92, 'Guyana', 1, 'GY', 'GU', 0, 'GYD', 'Dollar', '$', 'gy.png');
INSERT INTO `countries` VALUES (93, 'Hong Kong', 1, 'HK', 'HK', 0, 'HKD', 'Dollar', '$', 'hk.png');
INSERT INTO `countries` VALUES (95, 'Honduras', 1, 'HN', 'HN', 0, 'HNL', 'Lempira', 'L', 'hn.png');
INSERT INTO `countries` VALUES (96, 'Croatia', 1, 'HR', 'HR', 0, 'HRK', 'Kuna', 'kn', 'hr.png');
INSERT INTO `countries` VALUES (97, 'Haiti', 1, 'HT', 'HT', 0, 'HTG', 'Gourde', 'G', 'ht.png');
INSERT INTO `countries` VALUES (98, 'Hungary', 1, 'HU', 'HU', 0, 'HUF', 'Forint', 'Ft', 'hu.png');
INSERT INTO `countries` VALUES (99, 'Indonesia', 1, 'ID', 'ID', 0, 'IDR', 'Rupiah', 'Rp', 'id.png');
INSERT INTO `countries` VALUES (100, 'India', 1, 'IN', 'IN', 0, 'INR', 'Rupee', '₹', 'in.png');
INSERT INTO `countries` VALUES (101, 'British Indian Ocean Territory', 1, 'IO', 'IO', 0, 'USD', 'Dollar', '$', 'io.png');
INSERT INTO `countries` VALUES (102, 'Ireland', 1, 'IE', 'IR', 0, 'EUR', 'Euro', '€', 'ie.png');
INSERT INTO `countries` VALUES (103, 'Iran', 1, 'IR', 'IR', 0, 'IRR', 'Rial', '﷼', 'ir.png');
INSERT INTO `countries` VALUES (104, 'Iraq', 1, 'IQ', 'IR', 0, 'IQD', 'Dinar', '', 'iq.png');
INSERT INTO `countries` VALUES (105, 'Iceland', 1, 'IS', 'IS', 0, 'ISK', 'Krona', 'kr', 'is.png');
INSERT INTO `countries` VALUES (106, 'Israel', 1, 'IL', 'IS', 0, 'ILS', 'Shekel', '₪', 'il.png');
INSERT INTO `countries` VALUES (107, 'Italy', 1, 'IT', 'IT', 0, 'EUR', 'Euro', '€', 'it.png');
INSERT INTO `countries` VALUES (108, 'Jamaica', 1, 'JM', 'JA', 0, 'JMD', 'Dollar', '$', 'jm.png');
INSERT INTO `countries` VALUES (109, 'Jordan', 1, 'JO', 'JO', 0, 'JOD', 'Dinar', '', 'jo.png');
INSERT INTO `countries` VALUES (110, 'Japan', 1, 'JP', 'JP', 0, 'JPY', 'Yen', '¥', 'jp.png');
INSERT INTO `countries` VALUES (112, 'Kenya', 1, 'KE', 'KE', 0, 'KES', 'Shilling', '', 'ke.png');
INSERT INTO `countries` VALUES (113, 'Kyrgyzstan', 1, 'KG', 'KG', 0, 'KGS', 'Som', 'лв', 'kg.png');
INSERT INTO `countries` VALUES (114, 'Cambodia', 1, 'KH', 'KH', 0, 'KHR', 'Riels', '៛', 'kh.png');
INSERT INTO `countries` VALUES (115, 'Kiribati', 1, 'KI', 'KI', 0, 'AUD', 'Dollar', '$', 'ki.png');
INSERT INTO `countries` VALUES (116, 'Saint Kitts and Nevis', 1, 'KN', 'KN', 0, 'XCD', 'Dollar', '$', 'kn.png');
INSERT INTO `countries` VALUES (117, 'South Korea', 1, 'KR', 'KO', 0, 'KRW', 'Won', '₩', 'kr.png');
INSERT INTO `countries` VALUES (118, 'Kuwait', 1, 'KW', 'KW', 0, 'KWD', 'Dinar', '', 'kw.png');
INSERT INTO `countries` VALUES (119, 'Laos', 1, 'LA', 'LA', 0, 'LAK', 'Kip', '₭', 'la.png');
INSERT INTO `countries` VALUES (120, 'Lebanon', 1, 'LB', 'LB', 0, 'LBP', 'Pound', '£', 'lb.png');
INSERT INTO `countries` VALUES (121, 'Liberia', 1, 'LR', 'LB', 0, 'LRD', 'Dollar', '$', 'lr.png');
INSERT INTO `countries` VALUES (123, 'Saint Lucia', 1, 'LC', 'LC', 0, 'XCD', 'Dollar', '$', 'lc.png');
INSERT INTO `countries` VALUES (124, 'Liechtenstein', 1, 'LI', 'LI', 0, 'CHF', 'Franc', 'CHF', 'li.png');
INSERT INTO `countries` VALUES (125, 'Sri Lanka', 1, 'LK', 'LK', 0, 'LKR', 'Rupee', '₨', 'lk.png');
INSERT INTO `countries` VALUES (126, 'Lesotho', 1, 'LS', 'LS', 0, 'LSL', 'Loti', 'L', 'ls.png');
INSERT INTO `countries` VALUES (127, 'Lithuania', 1, 'LT', 'LT', 0, 'LTL', 'Litas', 'Lt', 'lt.png');
INSERT INTO `countries` VALUES (128, 'Luxembourg', 1, 'LU', 'LU', 0, 'EUR', 'Euro', '€', 'lu.png');
INSERT INTO `countries` VALUES (129, 'Latvia', 1, 'LV', 'LV', 0, 'LVL', 'Lat', 'Ls', 'lv.png');
INSERT INTO `countries` VALUES (130, 'Macao', 1, 'MO', 'MA', 0, 'MOP', 'Pataca', 'MOP', 'mo.png');
INSERT INTO `countries` VALUES (131, 'Morocco', 1, 'MA', 'MA', 0, 'MAD', 'Dirham', '', 'ma.png');
INSERT INTO `countries` VALUES (132, 'Monaco', 1, 'MC', 'MC', 0, 'EUR', 'Euro', '€', 'mc.png');
INSERT INTO `countries` VALUES (133, 'Moldova', 1, 'MD', 'MD', 0, 'MDL', 'Leu', '', 'md.png');
INSERT INTO `countries` VALUES (134, 'Madagascar', 1, 'MG', 'MD', 0, 'MGA', 'Ariary', '', 'mg.png');
INSERT INTO `countries` VALUES (135, 'Maldives', 1, 'MV', 'MD', 0, 'MVR', 'Rufiyaa', 'Rf', 'mv.png');
INSERT INTO `countries` VALUES (136, 'Mexico', 1, 'MX', 'ME', 0, 'MXN', 'Peso', '$', 'mx.png');
INSERT INTO `countries` VALUES (137, 'Marshall Islands', 1, 'MH', 'MH', 0, 'USD', 'Dollar', '$', 'mh.png');
INSERT INTO `countries` VALUES (138, 'Macedonia', 1, 'MK', 'MK', 0, 'MKD', 'Denar', 'ден', 'mk.png');
INSERT INTO `countries` VALUES (139, 'Mali', 1, 'ML', 'ML', 0, 'XOF', 'Franc', '', 'ml.png');
INSERT INTO `countries` VALUES (140, 'Malta', 1, 'MT', 'ML', 0, 'MTL', 'Lira', '', 'mt.png');
INSERT INTO `countries` VALUES (141, 'Myanmar', 1, 'MM', 'MM', 0, 'MMK', 'Kyat', 'K', 'mm.png');
INSERT INTO `countries` VALUES (142, 'Mongolia', 1, 'MN', 'MN', 0, 'MNT', 'Tugrik', '₮', 'mn.png');
INSERT INTO `countries` VALUES (143, 'Northern Mariana Islands', 1, 'MP', 'MN', 0, 'USD', 'Dollar', '$', 'mp.png');
INSERT INTO `countries` VALUES (144, 'Mozambique', 1, 'MZ', 'MO', 0, 'MZN', 'Meticail', 'MT', 'mz.png');
INSERT INTO `countries` VALUES (145, 'Mauritania', 1, 'MR', 'MR', 0, 'MRO', 'Ouguiya', 'UM', 'mr.png');
INSERT INTO `countries` VALUES (146, 'Montserrat', 1, 'MS', 'MS', 0, 'XCD', 'Dollar', '$', 'ms.png');
INSERT INTO `countries` VALUES (147, 'Martinique', 1, 'MQ', 'MT', 0, 'EUR', 'Euro', '€', 'mq.png');
INSERT INTO `countries` VALUES (148, 'Mauritius', 1, 'MU', 'MU', 0, 'MUR', 'Rupee', '₨', 'mu.png');
INSERT INTO `countries` VALUES (149, 'Malawi', 1, 'MW', 'MW', 0, 'MWK', 'Kwacha', 'MK', 'mw.png');
INSERT INTO `countries` VALUES (150, 'Malaysia', 1, 'MY', 'MY', 0, 'MYR', 'Ringgit', 'RM', 'my.png');
INSERT INTO `countries` VALUES (151, 'Mayotte', 1, 'YT', 'MY', 0, 'EUR', 'Euro', '€', 'yt.png');
INSERT INTO `countries` VALUES (152, 'Namibia', 1, 'NA', 'NA', 0, 'NAD', 'Dollar', '$', 'na.png');
INSERT INTO `countries` VALUES (153, 'New Caledonia', 1, 'NC', 'NC', 0, 'XPF', 'Franc', '', 'nc.png');
INSERT INTO `countries` VALUES (154, 'Niger', 1, 'NE', 'NE', 0, 'XOF', 'Franc', '', 'ne.png');
INSERT INTO `countries` VALUES (155, 'Norfolk Island', 1, 'NF', 'NF', 0, 'AUD', 'Dollar', '$', 'nf.png');
INSERT INTO `countries` VALUES (156, 'Nigeria', 1, 'NG', 'NG', 0, 'NGN', 'Naira', '₦', 'ng.png');
INSERT INTO `countries` VALUES (157, 'Nicaragua', 1, 'NI', 'NI', 0, 'NIO', 'Cordoba', 'C$', 'ni.png');
INSERT INTO `countries` VALUES (158, 'Niue', 1, 'NU', 'NI', 0, 'NZD', 'Dollar', '$', 'nu.png');
INSERT INTO `countries` VALUES (159, 'Netherlands', 1, 'NL', 'NL', 0, 'EUR', 'Euro', '€', 'nl.png');
INSERT INTO `countries` VALUES (160, 'Norway', 1, 'NO', 'NO', 0, 'NOK', 'Krone', 'kr', 'no.png');
INSERT INTO `countries` VALUES (161, 'Nepal', 1, 'NP', 'NP', 0, 'NPR', 'Rupee', '₨', 'np.png');
INSERT INTO `countries` VALUES (162, 'Nauru', 1, 'NR', 'NR', 0, 'AUD', 'Dollar', '$', 'nr.png');
INSERT INTO `countries` VALUES (163, 'New Zealand', 1, 'NZ', 'NZ', 0, 'NZD', 'Dollar', '$', 'nz.png');
INSERT INTO `countries` VALUES (164, 'Oman', 1, 'OM', 'OM', 0, 'OMR', 'Rial', '﷼', 'om.png');
INSERT INTO `countries` VALUES (165, 'Pakistan', 1, 'PK', 'PA', 0, 'PKR', 'Rupee', '₨', 'pk.png');
INSERT INTO `countries` VALUES (166, 'Panama', 1, 'PA', 'PA', 0, 'PAB', 'Balboa', 'B/.', 'pa.png');
INSERT INTO `countries` VALUES (167, 'Pitcairn', 1, 'PN', 'PC', 0, 'NZD', 'Dollar', '$', 'pn.png');
INSERT INTO `countries` VALUES (168, 'Peru', 1, 'PE', 'PE', 0, 'PEN', 'Sol', 'S/.', 'pe.png');
INSERT INTO `countries` VALUES (169, 'Philippines', 1, 'PH', 'PH', 0, 'PHP', 'Peso', 'Php', 'ph.png');
INSERT INTO `countries` VALUES (170, 'Palau', 1, 'PW', 'PL', 0, 'USD', 'Dollar', '$', 'pw.png');
INSERT INTO `countries` VALUES (171, 'Papua New Guinea', 1, 'PG', 'PN', 0, 'PGK', 'Kina', '', 'pg.png');
INSERT INTO `countries` VALUES (172, 'Poland', 1, 'PL', 'PO', 0, 'PLN', 'Zloty', 'zł', 'pl.png');
INSERT INTO `countries` VALUES (173, 'Puerto Rico', 1, 'PR', 'PR', 0, 'USD', 'Dollar', '$', 'pr.png');
INSERT INTO `countries` VALUES (174, 'North Korea', 1, 'KP', 'PR', 0, 'KPW', 'Won', '₩', 'kp.png');
INSERT INTO `countries` VALUES (175, 'Portugal', 1, 'PT', 'PR', 0, 'EUR', 'Euro', '€', 'pt.png');
INSERT INTO `countries` VALUES (176, 'Paraguay', 1, 'PY', 'PR', 0, 'PYG', 'Guarani', 'Gs', 'py.png');
INSERT INTO `countries` VALUES (178, 'French Polynesia', 1, 'PF', 'PY', 0, 'XPF', 'Franc', '', 'pf.png');
INSERT INTO `countries` VALUES (179, 'Qatar', 1, 'QA', 'QA', 0, 'QAR', 'Rial', '﷼', 'qa.png');
INSERT INTO `countries` VALUES (181, 'Romania', 1, 'RO', 'RO', 0, 'RON', 'Leu', 'lei', 'ro.png');
INSERT INTO `countries` VALUES (183, 'Rwanda', 1, 'RW', 'RW', 0, 'RWF', 'Franc', '', 'rw.png');
INSERT INTO `countries` VALUES (184, 'Saudi Arabia', 1, 'SA', 'SA', 0, 'SAR', 'Rial', '﷼', 'sa.png');
INSERT INTO `countries` VALUES (185, 'Sudan', 1, 'SD', 'SD', 0, 'SDD', 'Dinar', '', 'sd.png');
INSERT INTO `countries` VALUES (186, 'Senegal', 1, 'SN', 'SE', 0, 'XOF', 'Franc', '', 'sn.png');
INSERT INTO `countries` VALUES (187, 'Singapore', 1, 'SG', 'SG', 0, 'SGD', 'Dollar', '$', 'sg.png');
INSERT INTO `countries` VALUES (189, 'Saint Helena', 1, 'SH', 'SH', 0, 'SHP', 'Pound', '£', 'sh.png');
INSERT INTO `countries` VALUES (190, 'Svalbard and Jan Mayen', 1, 'SJ', 'SJ', 0, 'NOK', 'Krone', 'kr', 'sj.png');
INSERT INTO `countries` VALUES (191, 'Solomon Islands', 1, 'SB', 'SL', 0, 'SBD', 'Dollar', '$', 'sb.png');
INSERT INTO `countries` VALUES (192, 'Sierra Leone', 1, 'SL', 'SL', 0, 'SLL', 'Leone', 'Le', 'sl.png');
INSERT INTO `countries` VALUES (193, 'El Salvador', 1, 'SV', 'SL', 0, 'SVC', 'Colone', '$', 'sv.png');
INSERT INTO `countries` VALUES (194, 'San Marino', 1, 'SM', 'SM', 0, 'EUR', 'Euro', '€', 'sm.png');
INSERT INTO `countries` VALUES (195, 'Somalia', 1, 'SO', 'SO', 0, 'SOS', 'Shilling', 'S', 'so.png');
INSERT INTO `countries` VALUES (196, 'Saint Pierre and Miquelon', 1, 'PM', 'SP', 0, 'EUR', 'Euro', '€', 'pm.png');
INSERT INTO `countries` VALUES (197, 'Sao Tome and Principe', 1, 'ST', 'ST', 0, 'STD', 'Dobra', 'Db', 'st.png');
INSERT INTO `countries` VALUES (198, 'Suriname', 1, 'SR', 'SU', 0, 'SRD', 'Dollar', '$', 'sr.png');
INSERT INTO `countries` VALUES (199, 'Slovakia', 1, 'SK', 'SV', 0, 'SKK', 'Koruna', 'Sk', 'sk.png');
INSERT INTO `countries` VALUES (200, 'Slovenia', 1, 'SI', 'SV', 0, 'EUR', 'Euro', '€', 'si.png');
INSERT INTO `countries` VALUES (201, 'Sweden', 1, 'SE', 'SW', 0, 'SEK', 'Krona', 'kr', 'se.png');
INSERT INTO `countries` VALUES (202, 'Swaziland', 1, 'SZ', 'SW', 0, 'SZL', 'Lilangeni', '', 'sz.png');
INSERT INTO `countries` VALUES (203, 'Seychelles', 1, 'SC', 'SY', 0, 'SCR', 'Rupee', '₨', 'sc.png');
INSERT INTO `countries` VALUES (204, 'Syria', 1, 'SY', 'SY', 0, 'SYP', 'Pound', '£', 'sy.png');
INSERT INTO `countries` VALUES (205, 'Turks and Caicos Islands', 1, 'TC', 'TC', 0, 'USD', 'Dollar', '$', 'tc.png');
INSERT INTO `countries` VALUES (206, 'Chad', 1, 'TD', 'TC', 0, 'XAF', 'Franc', '', 'td.png');
INSERT INTO `countries` VALUES (207, 'Togo', 1, 'TG', 'TG', 0, 'XOF', 'Franc', '', 'tg.png');
INSERT INTO `countries` VALUES (208, 'Thailand', 1, 'TH', 'TH', 0, 'THB', 'Baht', '฿', 'th.png');
INSERT INTO `countries` VALUES (209, 'Tajikistan', 1, 'TJ', 'TJ', 0, 'TJS', 'Somoni', '', 'tj.png');
INSERT INTO `countries` VALUES (210, 'Tokelau', 1, 'TK', 'TK', 0, 'NZD', 'Dollar', '$', 'tk.png');
INSERT INTO `countries` VALUES (211, 'Turkmenistan', 1, 'TM', 'TK', 0, 'TMM', 'Manat', 'm', 'tm.png');
INSERT INTO `countries` VALUES (212, 'East Timor', 1, 'TL', 'TL', 0, 'USD', 'Dollar', '$', 'tl.png');
INSERT INTO `countries` VALUES (213, 'Tonga', 1, 'TO', 'TO', 0, 'TOP', 'Pa\"anga', 'T$', 'to.png');
INSERT INTO `countries` VALUES (214, 'Trinidad and Tobago', 1, 'TT', 'TT', 0, 'TTD', 'Dollar', 'TT$', 'tt.png');
INSERT INTO `countries` VALUES (215, 'Tunisia', 1, 'TN', 'TU', 0, 'TND', 'Dinar', '', 'tn.png');
INSERT INTO `countries` VALUES (216, 'Turkey', 1, 'TR', 'TU', 0, 'TRY', 'Lira', 'YTL', 'tr.png');
INSERT INTO `countries` VALUES (217, 'Tuvalu', 1, 'TV', 'TU', 0, 'AUD', 'Dollar', '$', 'tv.png');
INSERT INTO `countries` VALUES (218, 'Taiwan', 1, 'TW', 'TW', 0, 'TWD', 'Dollar', 'NT$', 'tw.png');
INSERT INTO `countries` VALUES (219, 'Tanzania', 1, 'TZ', 'TZ', 0, 'TZS', 'Shilling', '', 'tz.png');
INSERT INTO `countries` VALUES (220, 'Uganda', 1, 'UG', 'UG', 0, 'UGX', 'Shilling', '', 'ug.png');
INSERT INTO `countries` VALUES (221, 'Ukraine', 1, 'UA', 'UK', 0, 'UAH', 'Hryvnia', '₴', 'ua.png');
INSERT INTO `countries` VALUES (223, 'Uruguay', 1, 'UY', 'UR', 0, 'UYU', 'Peso', '$U', 'uy.png');
INSERT INTO `countries` VALUES (224, 'United States', 1, 'US', 'US', 0, 'USD', 'Dollar', '$', 'us.png');
INSERT INTO `countries` VALUES (225, 'Uzbekistan', 1, 'UZ', 'UZ', 0, 'UZS', 'Som', 'лв', 'uz.png');
INSERT INTO `countries` VALUES (228, 'Venezuela', 1, 'VE', 'VE', 0, 'VEF', 'Bolivar', 'Bs', 've.png');
INSERT INTO `countries` VALUES (231, 'Vietnam', 1, 'VN', 'VN', 0, 'VND', 'Dong', '₫', 'vn.png');
INSERT INTO `countries` VALUES (232, 'Vanuatu', 1, 'VU', 'VU', 0, 'VUV', 'Vatu', 'Vt', 'vu.png');
INSERT INTO `countries` VALUES (233, 'Wallis and Futuna', 1, 'WF', 'WL', 0, 'XPF', 'Franc', '', 'wf.png');
INSERT INTO `countries` VALUES (234, 'Samoa', 1, 'WS', 'WS', 0, 'WST', 'Tala', 'WS$', 'ws.png');
INSERT INTO `countries` VALUES (235, 'Yemen', 1, 'YE', 'YE', 0, 'YER', 'Rial', '﷼', 'ye.png');
INSERT INTO `countries` VALUES (237, 'South Africa', 1, 'ZA', 'ZA', 0, 'ZAR', 'Rand', 'R', 'za.png');
INSERT INTO `countries` VALUES (238, 'Zambia', 1, 'ZM', 'ZM', 0, 'ZMK', 'Kwacha', 'ZK', 'zm.png');
INSERT INTO `countries` VALUES (239, 'Zimbabwe', 1, 'ZW', 'ZW', 0, 'ZWD', 'Dollar', 'Z$', 'zw.png');

-- ----------------------------
-- Table structure for currencies
-- ----------------------------
DROP TABLE IF EXISTS `currencies`;
CREATE TABLE `currencies`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `company_id` int(10) UNSIGNED NULL DEFAULT NULL,
  `currency_name` varchar(191) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `currency_symbol` varchar(191) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT NULL,
  `currency_code` varchar(191) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `exchange_rate` double NULL DEFAULT NULL,
  `is_cryptocurrency` enum('yes','no') CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT 'no',
  `usd_price` double NULL DEFAULT NULL,
  `created_at` timestamp(0) NULL DEFAULT NULL,
  `updated_at` timestamp(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `currencies_company_id_foreign`(`company_id`) USING BTREE,
  CONSTRAINT `currencies_company_id_foreign` FOREIGN KEY (`company_id`) REFERENCES `companies` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8 COLLATE = utf8_unicode_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of currencies
-- ----------------------------
INSERT INTO `currencies` VALUES (1, 1, 'Dollars', '$', 'USD', 0.01184, 'no', NULL, '2019-06-16 06:34:21', '2019-06-18 06:00:29');
INSERT INTO `currencies` VALUES (2, 1, 'Pounds', '£', 'GBP', 0.009444, 'no', NULL, '2019-06-16 06:34:21', '2019-06-18 06:00:32');
INSERT INTO `currencies` VALUES (3, 1, 'Euros', '€', 'EUR', 0.010536, 'no', NULL, '2019-06-16 06:34:21', '2019-06-18 06:00:33');
INSERT INTO `currencies` VALUES (5, 1, 'Taka', '৳', 'BDT', 1, 'no', NULL, '2019-06-18 05:59:35', '2019-06-18 06:00:35');

-- ----------------------------
-- Table structure for custom_field_groups
-- ----------------------------
DROP TABLE IF EXISTS `custom_field_groups`;
CREATE TABLE `custom_field_groups`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `company_id` int(10) UNSIGNED NULL DEFAULT NULL,
  `name` varchar(191) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `model` varchar(191) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `custom_field_groups_model_index`(`model`) USING BTREE,
  INDEX `custom_field_groups_company_id_foreign`(`company_id`) USING BTREE,
  CONSTRAINT `custom_field_groups_company_id_foreign` FOREIGN KEY (`company_id`) REFERENCES `companies` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8 COLLATE = utf8_unicode_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of custom_field_groups
-- ----------------------------
INSERT INTO `custom_field_groups` VALUES (1, 1, 'Client', 'App\\ClientDetails');
INSERT INTO `custom_field_groups` VALUES (2, 1, 'Employee', 'App\\EmployeeDetails');
INSERT INTO `custom_field_groups` VALUES (3, 1, 'Project', 'App\\Project');

-- ----------------------------
-- Table structure for custom_fields
-- ----------------------------
DROP TABLE IF EXISTS `custom_fields`;
CREATE TABLE `custom_fields`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `custom_field_group_id` int(10) UNSIGNED NULL DEFAULT NULL,
  `label` varchar(100) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `name` varchar(100) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `type` varchar(10) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `required` enum('yes','no') CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT 'no',
  `values` varchar(5000) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `custom_fields_custom_field_group_id_foreign`(`custom_field_group_id`) USING BTREE,
  CONSTRAINT `custom_fields_custom_field_group_id_foreign` FOREIGN KEY (`custom_field_group_id`) REFERENCES `custom_field_groups` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_unicode_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for custom_fields_data
-- ----------------------------
DROP TABLE IF EXISTS `custom_fields_data`;
CREATE TABLE `custom_fields_data`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `custom_field_id` int(10) UNSIGNED NOT NULL,
  `model_id` int(10) UNSIGNED NOT NULL,
  `model` varchar(191) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT NULL,
  `value` varchar(10000) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `custom_fields_data_custom_field_id_foreign`(`custom_field_id`) USING BTREE,
  INDEX `custom_fields_data_model_index`(`model`) USING BTREE,
  CONSTRAINT `custom_fields_data_custom_field_id_foreign` FOREIGN KEY (`custom_field_id`) REFERENCES `custom_fields` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_unicode_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for email_notification_settings
-- ----------------------------
DROP TABLE IF EXISTS `email_notification_settings`;
CREATE TABLE `email_notification_settings`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `company_id` int(10) UNSIGNED NULL DEFAULT NULL,
  `setting_name` varchar(191) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `send_email` enum('yes','no') CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT 'no',
  `send_slack` enum('yes','no') CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT 'no',
  `send_push` enum('yes','no') CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT 'no',
  `created_at` timestamp(0) NULL DEFAULT NULL,
  `updated_at` timestamp(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `email_notification_settings_company_id_foreign`(`company_id`) USING BTREE,
  CONSTRAINT `email_notification_settings_company_id_foreign` FOREIGN KEY (`company_id`) REFERENCES `companies` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 22 CHARACTER SET = utf8 COLLATE = utf8_unicode_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of email_notification_settings
-- ----------------------------
INSERT INTO `email_notification_settings` VALUES (7, 1, 'New Expense/Added by Admin', 'no', 'no', 'no', '2019-06-16 06:34:20', '2019-06-22 05:41:18');
INSERT INTO `email_notification_settings` VALUES (8, 1, 'New Expense/Added by Member', 'no', 'no', 'no', '2019-06-16 06:34:20', '2019-06-22 05:41:16');
INSERT INTO `email_notification_settings` VALUES (9, 1, 'Expense Status Changed', 'no', 'no', 'no', '2019-06-16 06:34:20', '2019-06-22 05:41:14');
INSERT INTO `email_notification_settings` VALUES (10, 1, 'New Support Ticket Request', 'yes', 'no', 'no', '2019-06-16 06:34:21', '2019-06-16 06:34:21');
INSERT INTO `email_notification_settings` VALUES (11, 1, 'User Registration/Added by Admin', 'yes', 'no', 'no', '2019-06-16 06:34:21', '2019-06-16 06:34:21');
INSERT INTO `email_notification_settings` VALUES (12, 1, 'Employee Assign to Project', 'yes', 'no', 'yes', '2019-06-16 06:34:21', '2019-06-18 05:59:05');
INSERT INTO `email_notification_settings` VALUES (13, 1, 'New Notice Published', 'yes', 'no', 'no', '2019-06-16 06:34:21', '2019-06-22 05:41:03');
INSERT INTO `email_notification_settings` VALUES (14, 1, 'User Assign to Task', 'yes', 'no', 'yes', '2019-06-16 06:34:21', '2019-06-18 05:59:07');
INSERT INTO `email_notification_settings` VALUES (15, 1, 'New Leave Application', 'yes', 'yes', 'yes', '2019-06-16 06:34:21', '2019-06-18 05:58:57');
INSERT INTO `email_notification_settings` VALUES (16, 1, 'Task Completed', 'yes', 'no', 'yes', '2019-06-16 06:34:21', '2019-06-18 05:58:59');
INSERT INTO `email_notification_settings` VALUES (17, 1, 'Invoice Create/Update Notification', 'no', 'no', 'no', '2019-06-16 06:34:21', '2019-06-22 05:41:08');
INSERT INTO `email_notification_settings` VALUES (18, NULL, 'User Registration/Added by Admin', 'yes', 'no', 'no', '2019-06-16 06:34:26', '2019-06-16 06:34:26');
INSERT INTO `email_notification_settings` VALUES (19, NULL, 'Employee Assign to Project', 'yes', 'no', 'no', '2019-06-16 06:34:26', '2019-06-16 06:34:26');
INSERT INTO `email_notification_settings` VALUES (20, NULL, 'New Notice Published', 'no', 'no', 'no', '2019-06-16 06:34:26', '2019-06-16 06:34:26');
INSERT INTO `email_notification_settings` VALUES (21, NULL, 'User Assign to Task', 'yes', 'no', 'no', '2019-06-16 06:34:26', '2019-06-16 06:34:26');

-- ----------------------------
-- Table structure for employee_details
-- ----------------------------
DROP TABLE IF EXISTS `employee_details`;
CREATE TABLE `employee_details`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `company_id` int(10) UNSIGNED NULL DEFAULT NULL,
  `user_id` int(10) UNSIGNED NOT NULL,
  `job_title` varchar(191) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `address` text CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL,
  `hourly_rate` double NULL DEFAULT NULL,
  `slack_username` varchar(191) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT NULL,
  `created_at` timestamp(0) NULL DEFAULT NULL,
  `updated_at` timestamp(0) NULL DEFAULT NULL,
  `joining_date` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `last_date` date NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `employee_details_slack_username_unique`(`slack_username`) USING BTREE,
  INDEX `employee_details_user_id_foreign`(`user_id`) USING BTREE,
  INDEX `employee_details_company_id_foreign`(`company_id`) USING BTREE,
  CONSTRAINT `employee_details_company_id_foreign` FOREIGN KEY (`company_id`) REFERENCES `companies` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `employee_details_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 8 CHARACTER SET = utf8 COLLATE = utf8_unicode_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of employee_details
-- ----------------------------
INSERT INTO `employee_details` VALUES (1, 1, 1, 'Project Manager', 'address', 50, NULL, '2019-06-16 06:34:25', '2019-06-16 06:34:25', '2019-06-16 12:34:25', NULL);
INSERT INTO `employee_details` VALUES (3, 1, 5, 'CTO', NULL, 12121212, 'admin@example.com', '2019-06-18 06:45:54', '2019-06-18 06:45:54', '2009-12-31 00:00:00', '2019-06-18');
INSERT INTO `employee_details` VALUES (4, 1, 7, 'Software Engineer', NULL, 800, NULL, '2019-06-20 08:31:09', '2019-06-20 08:31:09', '2019-03-01 00:00:00', '2019-06-20');
INSERT INTO `employee_details` VALUES (5, 1, 8, 'Software Engineer', NULL, 121212, NULL, '2019-06-20 15:16:18', '2019-06-20 15:16:18', '2018-10-01 00:00:00', '2019-06-20');
INSERT INTO `employee_details` VALUES (6, 1, 9, 'Marketing Officer', NULL, 121212, NULL, '2019-06-20 15:23:29', '2019-06-20 15:23:29', '2019-06-20 00:00:00', '2019-06-20');
INSERT INTO `employee_details` VALUES (7, 1, 10, 'Accounts Executive', 'Gulshan 2', 400000, NULL, '2019-06-20 15:29:57', '2019-06-20 15:29:57', '2019-03-01 00:00:00', '2019-06-20');

-- ----------------------------
-- Table structure for employee_docs
-- ----------------------------
DROP TABLE IF EXISTS `employee_docs`;
CREATE TABLE `employee_docs`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `company_id` int(10) UNSIGNED NULL DEFAULT NULL,
  `user_id` int(10) UNSIGNED NOT NULL,
  `name` varchar(200) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `filename` varchar(200) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `hashname` varchar(200) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `size` varchar(200) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT NULL,
  `created_at` timestamp(0) NULL DEFAULT NULL,
  `updated_at` timestamp(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `employee_docs_user_id_foreign`(`user_id`) USING BTREE,
  INDEX `employee_docs_company_id_foreign`(`company_id`) USING BTREE,
  CONSTRAINT `employee_docs_company_id_foreign` FOREIGN KEY (`company_id`) REFERENCES `companies` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `employee_docs_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_unicode_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for employee_skills
-- ----------------------------
DROP TABLE IF EXISTS `employee_skills`;
CREATE TABLE `employee_skills`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` int(10) UNSIGNED NOT NULL,
  `skill_id` int(10) UNSIGNED NOT NULL,
  `created_at` timestamp(0) NULL DEFAULT NULL,
  `updated_at` timestamp(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `employee_skills_user_id_foreign`(`user_id`) USING BTREE,
  INDEX `employee_skills_skill_id_foreign`(`skill_id`) USING BTREE,
  CONSTRAINT `employee_skills_skill_id_foreign` FOREIGN KEY (`skill_id`) REFERENCES `skills` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `employee_skills_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_unicode_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for employee_teams
-- ----------------------------
DROP TABLE IF EXISTS `employee_teams`;
CREATE TABLE `employee_teams`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `team_id` int(10) UNSIGNED NOT NULL,
  `user_id` int(10) UNSIGNED NOT NULL,
  `created_at` timestamp(0) NULL DEFAULT NULL,
  `updated_at` timestamp(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `employee_teams_team_id_foreign`(`team_id`) USING BTREE,
  INDEX `employee_teams_user_id_foreign`(`user_id`) USING BTREE,
  CONSTRAINT `employee_teams_team_id_foreign` FOREIGN KEY (`team_id`) REFERENCES `teams` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `employee_teams_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8 COLLATE = utf8_unicode_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of employee_teams
-- ----------------------------
INSERT INTO `employee_teams` VALUES (1, 1, 7, '2019-06-21 03:32:59', '2019-06-21 03:32:59');
INSERT INTO `employee_teams` VALUES (2, 1, 8, '2019-06-21 03:33:00', '2019-06-21 03:33:00');
INSERT INTO `employee_teams` VALUES (3, 1, 10, '2019-06-21 03:33:00', '2019-06-21 03:33:00');

-- ----------------------------
-- Table structure for estimate_items
-- ----------------------------
DROP TABLE IF EXISTS `estimate_items`;
CREATE TABLE `estimate_items`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `tax_id` int(10) UNSIGNED NULL DEFAULT NULL,
  `estimate_id` int(10) UNSIGNED NOT NULL,
  `item_name` varchar(191) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `type` enum('item','discount','tax') CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT 'item',
  `quantity` double(8, 2) NOT NULL,
  `unit_price` double(8, 2) NOT NULL,
  `amount` double NOT NULL,
  `created_at` timestamp(0) NULL DEFAULT NULL,
  `updated_at` timestamp(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `estimate_items_estimate_id_foreign`(`estimate_id`) USING BTREE,
  INDEX `estimate_items_tax_id_foreign`(`tax_id`) USING BTREE,
  CONSTRAINT `estimate_items_estimate_id_foreign` FOREIGN KEY (`estimate_id`) REFERENCES `estimates` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `estimate_items_tax_id_foreign` FOREIGN KEY (`tax_id`) REFERENCES `taxes` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_unicode_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for estimates
-- ----------------------------
DROP TABLE IF EXISTS `estimates`;
CREATE TABLE `estimates`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `company_id` int(10) UNSIGNED NULL DEFAULT NULL,
  `client_id` int(10) UNSIGNED NOT NULL,
  `estimate_number` varchar(191) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT NULL,
  `valid_till` date NOT NULL,
  `sub_total` double(8, 2) NOT NULL,
  `total` double(8, 2) NOT NULL,
  `currency_id` int(10) UNSIGNED NULL DEFAULT NULL,
  `status` enum('declined','accepted','waiting') CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT 'waiting',
  `note` mediumtext CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL,
  `created_at` timestamp(0) NULL DEFAULT NULL,
  `updated_at` timestamp(0) NULL DEFAULT NULL,
  `discount` varchar(191) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `discount_type` varchar(191) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `estimates_estimate_number_unique`(`estimate_number`) USING BTREE,
  INDEX `estimates_client_id_foreign`(`client_id`) USING BTREE,
  INDEX `estimates_currency_id_foreign`(`currency_id`) USING BTREE,
  INDEX `estimates_company_id_foreign`(`company_id`) USING BTREE,
  CONSTRAINT `estimates_client_id_foreign` FOREIGN KEY (`client_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `estimates_company_id_foreign` FOREIGN KEY (`company_id`) REFERENCES `companies` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `estimates_currency_id_foreign` FOREIGN KEY (`currency_id`) REFERENCES `currencies` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_unicode_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for event_attendees
-- ----------------------------
DROP TABLE IF EXISTS `event_attendees`;
CREATE TABLE `event_attendees`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` int(10) UNSIGNED NOT NULL,
  `event_id` int(10) UNSIGNED NOT NULL,
  `created_at` timestamp(0) NULL DEFAULT NULL,
  `updated_at` timestamp(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `event_attendees_user_id_foreign`(`user_id`) USING BTREE,
  INDEX `event_attendees_event_id_foreign`(`event_id`) USING BTREE,
  CONSTRAINT `event_attendees_event_id_foreign` FOREIGN KEY (`event_id`) REFERENCES `events` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `event_attendees_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8 COLLATE = utf8_unicode_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of event_attendees
-- ----------------------------
INSERT INTO `event_attendees` VALUES (1, 1, 1, '2019-06-20 08:34:08', '2019-06-20 08:34:08');
INSERT INTO `event_attendees` VALUES (2, 4, 1, '2019-06-20 08:34:08', '2019-06-20 08:34:08');
INSERT INTO `event_attendees` VALUES (3, 5, 1, '2019-06-20 08:34:08', '2019-06-20 08:34:08');
INSERT INTO `event_attendees` VALUES (4, 6, 1, '2019-06-20 08:34:08', '2019-06-20 08:34:08');
INSERT INTO `event_attendees` VALUES (5, 7, 1, '2019-06-20 08:34:08', '2019-06-20 08:34:08');

-- ----------------------------
-- Table structure for events
-- ----------------------------
DROP TABLE IF EXISTS `events`;
CREATE TABLE `events`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `company_id` int(10) UNSIGNED NULL DEFAULT NULL,
  `event_name` varchar(191) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `label_color` varchar(191) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `where` varchar(191) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `description` mediumtext CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `start_date_time` datetime(0) NOT NULL,
  `end_date_time` datetime(0) NOT NULL,
  `repeat` enum('yes','no') CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT 'no',
  `repeat_every` int(11) NULL DEFAULT NULL,
  `repeat_cycles` int(11) NULL DEFAULT NULL,
  `repeat_type` enum('day','week','month','year') CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT 'day',
  `created_at` timestamp(0) NULL DEFAULT NULL,
  `updated_at` timestamp(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `events_company_id_foreign`(`company_id`) USING BTREE,
  CONSTRAINT `events_company_id_foreign` FOREIGN KEY (`company_id`) REFERENCES `companies` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8 COLLATE = utf8_unicode_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of events
-- ----------------------------
INSERT INTO `events` VALUES (1, 1, 'TPL', 'bg-danger', 'DRMC', 'A Cricket Tournament', '2019-08-01 07:30:00', '2019-08-03 17:30:00', 'no', 1, NULL, 'day', '2019-06-20 08:34:08', '2019-06-20 08:34:08');

-- ----------------------------
-- Table structure for expenses
-- ----------------------------
DROP TABLE IF EXISTS `expenses`;
CREATE TABLE `expenses`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `company_id` int(10) UNSIGNED NULL DEFAULT NULL,
  `item_name` varchar(191) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `purchase_date` date NOT NULL,
  `purchase_from` varchar(191) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT NULL,
  `price` double(8, 2) NOT NULL,
  `currency_id` int(10) UNSIGNED NOT NULL,
  `bill` varchar(191) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT NULL,
  `user_id` int(10) UNSIGNED NOT NULL,
  `status` enum('pending','approved','rejected') CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT 'pending',
  `created_at` timestamp(0) NULL DEFAULT NULL,
  `updated_at` timestamp(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `expenses_currency_id_foreign`(`currency_id`) USING BTREE,
  INDEX `expenses_user_id_foreign`(`user_id`) USING BTREE,
  INDEX `expenses_company_id_foreign`(`company_id`) USING BTREE,
  CONSTRAINT `expenses_company_id_foreign` FOREIGN KEY (`company_id`) REFERENCES `companies` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `expenses_currency_id_foreign` FOREIGN KEY (`currency_id`) REFERENCES `currencies` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `expenses_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_unicode_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for features
-- ----------------------------
DROP TABLE IF EXISTS `features`;
CREATE TABLE `features`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `title` varchar(191) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `description` longtext CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL,
  `image` varchar(200) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT NULL,
  `icon` varchar(200) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT NULL,
  `type` enum('image','icon') CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT 'image',
  `created_at` timestamp(0) NULL DEFAULT NULL,
  `updated_at` timestamp(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 10 CHARACTER SET = utf8 COLLATE = utf8_unicode_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of features
-- ----------------------------
INSERT INTO `features` VALUES (1, 'Drag, drop, and share your files.', '<p>Not just your messages, but all your files, images, PDFs, documents, and spreadsheets can be dropped right into worksuite and shared with anyone you want. Add comments, star for later reference, and it’s all completely searchable.</p>\n                                    <p>If you use any services like Google Drive, Dropbox, or Box, just paste the link and that document is immediately in sync and searchable too.</p>', 'drag.png', NULL, 'image', '2019-06-16 06:33:45', '2019-06-16 06:33:45');
INSERT INTO `features` VALUES (2, 'Works everywhere you go', '<p>Everything in worksuite—messages, notifications, files, and all—is automatically indexed and archived so that you can have it at your fingertips whenever you want. worksuite also indexes the content of every file so you can search within PDFs, Word documents, Google docs, and more. With one search box and a set of powerful search operators, you can slice and dice your way to that one message in your communication haystack.</p>', 'everywhere.png', NULL, 'image', '2019-06-16 06:33:46', '2019-06-16 06:33:46');
INSERT INTO `features` VALUES (3, 'All your tools in one place.', '<p>Connect all the tools you use to worksuite and avoid all that constant switching between apps. Set up your integration so that you get all your notifications directly within worksuite—from support requests, code check-ins, and error logs to sales leads—all of them searchable in one central archive.</p>\n                                <p>If you use any services like Google Drive, Dropbox, or Box, just paste the link and that document is immediately in sync and searchable too.</p>', 'tools.png', NULL, 'image', '2019-06-16 06:33:46', '2019-06-16 06:33:46');
INSERT INTO `features` VALUES (4, 'Responsive', 'Your website works on any device: desktop, tablet or mobile.', NULL, 'fas fa-desktop', 'icon', '2019-06-16 06:33:46', '2019-06-16 06:33:46');
INSERT INTO `features` VALUES (5, 'Customizable', 'You can easily read, edit, and write your own code, or change everything.', NULL, 'fas fa-wrench', 'icon', '2019-06-16 06:33:46', '2019-06-16 06:33:46');
INSERT INTO `features` VALUES (6, 'UI Elements', 'There is a bunch of useful and necessary elements for developing your website.', NULL, 'fas fa-cubes', 'icon', '2019-06-16 06:33:46', '2019-06-16 06:33:46');
INSERT INTO `features` VALUES (7, 'Clean Code', 'You can find our code well organized, commented and readable.', NULL, 'fas fa-code', 'icon', '2019-06-16 06:33:46', '2019-06-16 06:33:46');
INSERT INTO `features` VALUES (8, 'Documented', 'As you can see in the source code, we provided a comprehensive documentation.', NULL, 'far fa-file-alt', 'icon', '2019-06-16 06:33:46', '2019-06-16 06:33:46');
INSERT INTO `features` VALUES (9, 'Free Updates', 'When you purchase this template, you\'ll freely receive future updates.', NULL, 'fas fa-download', 'icon', '2019-06-16 06:33:46', '2019-06-16 06:33:46');

-- ----------------------------
-- Table structure for file_storage_settings
-- ----------------------------
DROP TABLE IF EXISTS `file_storage_settings`;
CREATE TABLE `file_storage_settings`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `company_id` int(10) UNSIGNED NULL DEFAULT NULL,
  `filesystem` varchar(191) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `auth_keys` text CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL,
  `status` enum('enabled','disabled') CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT 'disabled',
  `created_at` timestamp(0) NULL DEFAULT NULL,
  `updated_at` timestamp(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `file_storage_settings_company_id_foreign`(`company_id`) USING BTREE,
  CONSTRAINT `file_storage_settings_company_id_foreign` FOREIGN KEY (`company_id`) REFERENCES `companies` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8 COLLATE = utf8_unicode_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of file_storage_settings
-- ----------------------------
INSERT INTO `file_storage_settings` VALUES (1, NULL, 'local', NULL, 'enabled', '2019-06-16 06:25:57', '2019-06-16 06:25:57');
INSERT INTO `file_storage_settings` VALUES (2, 1, 'local', NULL, 'enabled', '2019-06-16 06:34:23', '2019-06-16 06:34:23');

-- ----------------------------
-- Table structure for front_details
-- ----------------------------
DROP TABLE IF EXISTS `front_details`;
CREATE TABLE `front_details`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `header_title` varchar(200) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `header_description` text CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `image` varchar(200) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `get_started_show` enum('yes','no') CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT 'yes',
  `sign_in_show` enum('yes','no') CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT 'yes',
  `feature_title` varchar(191) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT NULL,
  `feature_description` varchar(191) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT NULL,
  `price_title` varchar(191) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT NULL,
  `price_description` varchar(191) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT NULL,
  `address` text CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL,
  `phone` varchar(20) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT NULL,
  `email` varchar(60) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT NULL,
  `created_at` timestamp(0) NULL DEFAULT NULL,
  `updated_at` timestamp(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8 COLLATE = utf8_unicode_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of front_details
-- ----------------------------
INSERT INTO `front_details` VALUES (1, 'Project Management System', 'The most powerful and simple way to collaborate with your team', 'dashboard.jpg', 'yes', 'yes', 'Team communications for the 21st century.', NULL, 'Affordable Pricing', 'Slack for Teams is a single workspace for your small- to medium-sized company or team.', 'Company address', '+91 1234567890', 'company@example.com', '2019-06-16 06:33:45', '2019-06-16 06:33:45');

-- ----------------------------
-- Table structure for global_currencies
-- ----------------------------
DROP TABLE IF EXISTS `global_currencies`;
CREATE TABLE `global_currencies`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `currency_name` varchar(191) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `currency_symbol` varchar(191) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `currency_code` varchar(191) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `exchange_rate` double NULL DEFAULT NULL,
  `usd_price` double NULL DEFAULT NULL,
  `is_cryptocurrency` enum('yes','no') CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT 'no',
  `created_at` timestamp(0) NULL DEFAULT NULL,
  `updated_at` timestamp(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8 COLLATE = utf8_unicode_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of global_currencies
-- ----------------------------
INSERT INTO `global_currencies` VALUES (1, 'Dollars', '$', 'USD', 1, NULL, 'no', '2019-06-16 06:34:17', '2019-06-18 03:59:02');
INSERT INTO `global_currencies` VALUES (2, 'Pounds', '£', 'GBP', 0.798525, NULL, 'no', '2019-06-16 06:34:18', '2019-06-18 03:59:04');
INSERT INTO `global_currencies` VALUES (3, 'Euros', '€', 'EUR', 0.890403, NULL, 'no', '2019-06-16 06:34:18', '2019-06-18 03:59:06');
INSERT INTO `global_currencies` VALUES (5, 'Taka', '৳', 'BDT', 84.459794, NULL, 'no', '2019-06-18 03:59:01', '2019-06-18 03:59:01');

-- ----------------------------
-- Table structure for global_settings
-- ----------------------------
DROP TABLE IF EXISTS `global_settings`;
CREATE TABLE `global_settings`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `currency_id` int(10) UNSIGNED NULL DEFAULT NULL,
  `timezone` varchar(191) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT 'Asia/Kolkata',
  `locale` varchar(191) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT 'en',
  `company_name` varchar(191) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `company_email` varchar(191) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `company_phone` varchar(191) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `logo` varchar(191) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT NULL,
  `login_background` varchar(191) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT NULL,
  `address` text CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `website` varchar(191) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT NULL,
  `last_updated_by` int(10) UNSIGNED NULL DEFAULT NULL,
  `created_at` timestamp(0) NULL DEFAULT NULL,
  `updated_at` timestamp(0) NULL DEFAULT NULL,
  `google_map_key` varchar(191) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `currency_converter_key` varchar(191) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `google_recaptcha_key` text CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `global_settings_last_updated_by_foreign`(`last_updated_by`) USING BTREE,
  INDEX `global_settings_currency_id_foreign`(`currency_id`) USING BTREE,
  CONSTRAINT `global_settings_currency_id_foreign` FOREIGN KEY (`currency_id`) REFERENCES `global_currencies` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `global_settings_last_updated_by_foreign` FOREIGN KEY (`last_updated_by`) REFERENCES `users` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8 COLLATE = utf8_unicode_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of global_settings
-- ----------------------------
INSERT INTO `global_settings` VALUES (1, 5, 'Asia/Dhaka', 'en', 'Ashik Chowdhury', 'ashik@email.com', '+8801675421147', 'coSc8iQgf7WfjUR3YeOKhbSdVtUUNtWeeeKPokDB.png', 'login-background.jpg', 'Department of Computer Science & Engineering. \r\nJahangirnagar University\r\nSavar, Dhaka', 'www.ashikchowdhury.com', 3, '2019-06-16 06:34:18', '2019-06-18 06:13:55', 'AIzaSyDht9EJqJzVWOIXqhAcEo6D1s0PMe0pRKk', '29c306c1354ff91a6dda', NULL);

-- ----------------------------
-- Table structure for holidays
-- ----------------------------
DROP TABLE IF EXISTS `holidays`;
CREATE TABLE `holidays`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `company_id` int(10) UNSIGNED NULL DEFAULT NULL,
  `date` date NOT NULL,
  `occassion` varchar(100) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT NULL,
  `created_at` timestamp(0) NULL DEFAULT NULL,
  `updated_at` timestamp(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `holidays_company_id_foreign`(`company_id`) USING BTREE,
  CONSTRAINT `holidays_company_id_foreign` FOREIGN KEY (`company_id`) REFERENCES `companies` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 157 CHARACTER SET = utf8 COLLATE = utf8_unicode_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of holidays
-- ----------------------------
INSERT INTO `holidays` VALUES (105, 1, '2019-01-04', 'Friday', '2019-06-22 05:57:14', '2019-06-22 05:57:14');
INSERT INTO `holidays` VALUES (106, 1, '2019-01-11', 'Friday', '2019-06-22 05:57:14', '2019-06-22 05:57:14');
INSERT INTO `holidays` VALUES (107, 1, '2019-01-18', 'Friday', '2019-06-22 05:57:14', '2019-06-22 05:57:14');
INSERT INTO `holidays` VALUES (108, 1, '2019-01-25', 'Friday', '2019-06-22 05:57:14', '2019-06-22 05:57:14');
INSERT INTO `holidays` VALUES (109, 1, '2019-02-01', 'Friday', '2019-06-22 05:57:14', '2019-06-22 05:57:14');
INSERT INTO `holidays` VALUES (110, 1, '2019-02-08', 'Friday', '2019-06-22 05:57:14', '2019-06-22 05:57:14');
INSERT INTO `holidays` VALUES (111, 1, '2019-02-15', 'Friday', '2019-06-22 05:57:14', '2019-06-22 05:57:14');
INSERT INTO `holidays` VALUES (112, 1, '2019-02-22', 'Friday', '2019-06-22 05:57:14', '2019-06-22 05:57:14');
INSERT INTO `holidays` VALUES (113, 1, '2019-03-01', 'Friday', '2019-06-22 05:57:14', '2019-06-22 05:57:14');
INSERT INTO `holidays` VALUES (114, 1, '2019-03-08', 'Friday', '2019-06-22 05:57:14', '2019-06-22 05:57:14');
INSERT INTO `holidays` VALUES (115, 1, '2019-03-15', 'Friday', '2019-06-22 05:57:14', '2019-06-22 05:57:14');
INSERT INTO `holidays` VALUES (116, 1, '2019-03-22', 'Friday', '2019-06-22 05:57:14', '2019-06-22 05:57:14');
INSERT INTO `holidays` VALUES (117, 1, '2019-03-29', 'Friday', '2019-06-22 05:57:14', '2019-06-22 05:57:14');
INSERT INTO `holidays` VALUES (118, 1, '2019-04-05', 'Friday', '2019-06-22 05:57:14', '2019-06-22 05:57:14');
INSERT INTO `holidays` VALUES (119, 1, '2019-04-12', 'Friday', '2019-06-22 05:57:14', '2019-06-22 05:57:14');
INSERT INTO `holidays` VALUES (120, 1, '2019-04-19', 'Friday', '2019-06-22 05:57:15', '2019-06-22 05:57:15');
INSERT INTO `holidays` VALUES (121, 1, '2019-04-26', 'Friday', '2019-06-22 05:57:15', '2019-06-22 05:57:15');
INSERT INTO `holidays` VALUES (122, 1, '2019-05-03', 'Friday', '2019-06-22 05:57:15', '2019-06-22 05:57:15');
INSERT INTO `holidays` VALUES (123, 1, '2019-05-10', 'Friday', '2019-06-22 05:57:15', '2019-06-22 05:57:15');
INSERT INTO `holidays` VALUES (124, 1, '2019-05-17', 'Friday', '2019-06-22 05:57:15', '2019-06-22 05:57:15');
INSERT INTO `holidays` VALUES (125, 1, '2019-05-24', 'Friday', '2019-06-22 05:57:15', '2019-06-22 05:57:15');
INSERT INTO `holidays` VALUES (126, 1, '2019-05-31', 'Friday', '2019-06-22 05:57:15', '2019-06-22 05:57:15');
INSERT INTO `holidays` VALUES (127, 1, '2019-06-07', 'Friday', '2019-06-22 05:57:15', '2019-06-22 05:57:15');
INSERT INTO `holidays` VALUES (128, 1, '2019-06-14', 'Friday', '2019-06-22 05:57:15', '2019-06-22 05:57:15');
INSERT INTO `holidays` VALUES (129, 1, '2019-06-21', 'Friday', '2019-06-22 05:57:15', '2019-06-22 05:57:15');
INSERT INTO `holidays` VALUES (130, 1, '2019-06-28', 'Friday', '2019-06-22 05:57:15', '2019-06-22 05:57:15');
INSERT INTO `holidays` VALUES (131, 1, '2019-07-05', 'Friday', '2019-06-22 05:57:15', '2019-06-22 05:57:15');
INSERT INTO `holidays` VALUES (132, 1, '2019-07-12', 'Friday', '2019-06-22 05:57:15', '2019-06-22 05:57:15');
INSERT INTO `holidays` VALUES (133, 1, '2019-07-19', 'Friday', '2019-06-22 05:57:15', '2019-06-22 05:57:15');
INSERT INTO `holidays` VALUES (134, 1, '2019-07-26', 'Friday', '2019-06-22 05:57:15', '2019-06-22 05:57:15');
INSERT INTO `holidays` VALUES (135, 1, '2019-08-02', 'Friday', '2019-06-22 05:57:15', '2019-06-22 05:57:15');
INSERT INTO `holidays` VALUES (136, 1, '2019-08-09', 'Friday', '2019-06-22 05:57:15', '2019-06-22 05:57:15');
INSERT INTO `holidays` VALUES (137, 1, '2019-08-16', 'Friday', '2019-06-22 05:57:15', '2019-06-22 05:57:15');
INSERT INTO `holidays` VALUES (138, 1, '2019-08-23', 'Friday', '2019-06-22 05:57:15', '2019-06-22 05:57:15');
INSERT INTO `holidays` VALUES (139, 1, '2019-08-30', 'Friday', '2019-06-22 05:57:16', '2019-06-22 05:57:16');
INSERT INTO `holidays` VALUES (140, 1, '2019-09-06', 'Friday', '2019-06-22 05:57:16', '2019-06-22 05:57:16');
INSERT INTO `holidays` VALUES (141, 1, '2019-09-13', 'Friday', '2019-06-22 05:57:16', '2019-06-22 05:57:16');
INSERT INTO `holidays` VALUES (142, 1, '2019-09-20', 'Friday', '2019-06-22 05:57:16', '2019-06-22 05:57:16');
INSERT INTO `holidays` VALUES (143, 1, '2019-09-27', 'Friday', '2019-06-22 05:57:16', '2019-06-22 05:57:16');
INSERT INTO `holidays` VALUES (144, 1, '2019-10-04', 'Friday', '2019-06-22 05:57:16', '2019-06-22 05:57:16');
INSERT INTO `holidays` VALUES (145, 1, '2019-10-11', 'Friday', '2019-06-22 05:57:16', '2019-06-22 05:57:16');
INSERT INTO `holidays` VALUES (146, 1, '2019-10-18', 'Friday', '2019-06-22 05:57:16', '2019-06-22 05:57:16');
INSERT INTO `holidays` VALUES (147, 1, '2019-10-25', 'Friday', '2019-06-22 05:57:16', '2019-06-22 05:57:16');
INSERT INTO `holidays` VALUES (148, 1, '2019-11-01', 'Friday', '2019-06-22 05:57:16', '2019-06-22 05:57:16');
INSERT INTO `holidays` VALUES (149, 1, '2019-11-08', 'Friday', '2019-06-22 05:57:16', '2019-06-22 05:57:16');
INSERT INTO `holidays` VALUES (150, 1, '2019-11-15', 'Friday', '2019-06-22 05:57:16', '2019-06-22 05:57:16');
INSERT INTO `holidays` VALUES (151, 1, '2019-11-22', 'Friday', '2019-06-22 05:57:17', '2019-06-22 05:57:17');
INSERT INTO `holidays` VALUES (152, 1, '2019-11-29', 'Friday', '2019-06-22 05:57:17', '2019-06-22 05:57:17');
INSERT INTO `holidays` VALUES (153, 1, '2019-12-06', 'Friday', '2019-06-22 05:57:17', '2019-06-22 05:57:17');
INSERT INTO `holidays` VALUES (154, 1, '2019-12-13', 'Friday', '2019-06-22 05:57:18', '2019-06-22 05:57:18');
INSERT INTO `holidays` VALUES (155, 1, '2019-12-20', 'Friday', '2019-06-22 05:57:18', '2019-06-22 05:57:18');
INSERT INTO `holidays` VALUES (156, 1, '2019-12-27', 'Friday', '2019-06-22 05:57:18', '2019-06-22 05:57:18');

-- ----------------------------
-- Table structure for invoice_items
-- ----------------------------
DROP TABLE IF EXISTS `invoice_items`;
CREATE TABLE `invoice_items`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `invoice_id` int(10) UNSIGNED NOT NULL,
  `item_name` varchar(191) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `type` enum('item','discount','tax') CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT 'item',
  `quantity` double(8, 2) NOT NULL,
  `unit_price` double(8, 2) NOT NULL,
  `amount` double(8, 2) NOT NULL,
  `tax_id` int(10) UNSIGNED NULL DEFAULT NULL,
  `created_at` timestamp(0) NULL DEFAULT NULL,
  `updated_at` timestamp(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `invoice_items_invoice_id_foreign`(`invoice_id`) USING BTREE,
  INDEX `invoice_items_tax_id_foreign`(`tax_id`) USING BTREE,
  CONSTRAINT `invoice_items_invoice_id_foreign` FOREIGN KEY (`invoice_id`) REFERENCES `invoices` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `invoice_items_tax_id_foreign` FOREIGN KEY (`tax_id`) REFERENCES `taxes` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_unicode_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for invoice_settings
-- ----------------------------
DROP TABLE IF EXISTS `invoice_settings`;
CREATE TABLE `invoice_settings`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `company_id` int(10) UNSIGNED NULL DEFAULT NULL,
  `invoice_prefix` varchar(191) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `template` varchar(191) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `due_after` int(11) NOT NULL,
  `invoice_terms` text CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `gst_number` varchar(191) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT NULL,
  `show_gst` enum('yes','no') CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT 'no',
  `created_at` timestamp(0) NULL DEFAULT NULL,
  `updated_at` timestamp(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `invoice_settings_company_id_foreign`(`company_id`) USING BTREE,
  CONSTRAINT `invoice_settings_company_id_foreign` FOREIGN KEY (`company_id`) REFERENCES `companies` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8 COLLATE = utf8_unicode_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of invoice_settings
-- ----------------------------
INSERT INTO `invoice_settings` VALUES (1, NULL, 'INV', 'invoice-1', 15, 'Thank you for your business. Please process this invoice within the due date.', NULL, 'no', '2019-06-16 06:24:42', '2019-06-16 06:24:42');
INSERT INTO `invoice_settings` VALUES (2, 1, 'INV', 'invoice-1', 15, 'Thank you for your business. Please process this invoice within the due date.', NULL, 'no', '2019-06-16 06:34:22', '2019-06-16 06:34:22');

-- ----------------------------
-- Table structure for invoices
-- ----------------------------
DROP TABLE IF EXISTS `invoices`;
CREATE TABLE `invoices`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `company_id` int(10) UNSIGNED NULL DEFAULT NULL,
  `project_id` int(10) UNSIGNED NULL DEFAULT NULL,
  `invoice_number` varchar(191) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `issue_date` date NOT NULL,
  `due_date` date NOT NULL,
  `sub_total` double(8, 2) NOT NULL,
  `discount` double NOT NULL DEFAULT 0,
  `discount_type` enum('percent','fixed') CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT 'percent',
  `total` double(8, 2) NOT NULL,
  `currency_id` int(10) UNSIGNED NULL DEFAULT NULL,
  `status` enum('paid','unpaid','partial') CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT 'unpaid',
  `recurring` enum('yes','no') CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT 'no',
  `billing_cycle` int(11) NULL DEFAULT NULL,
  `billing_interval` int(11) NULL DEFAULT NULL,
  `billing_frequency` varchar(191) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT NULL,
  `file` varchar(191) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT NULL,
  `file_original_name` varchar(191) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT NULL,
  `note` text CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL,
  `created_at` timestamp(0) NULL DEFAULT NULL,
  `updated_at` timestamp(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `invoices_invoice_number_unique`(`invoice_number`) USING BTREE,
  INDEX `invoices_project_id_foreign`(`project_id`) USING BTREE,
  INDEX `invoices_currency_id_foreign`(`currency_id`) USING BTREE,
  INDEX `invoices_company_id_foreign`(`company_id`) USING BTREE,
  CONSTRAINT `invoices_company_id_foreign` FOREIGN KEY (`company_id`) REFERENCES `companies` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `invoices_currency_id_foreign` FOREIGN KEY (`currency_id`) REFERENCES `currencies` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `invoices_project_id_foreign` FOREIGN KEY (`project_id`) REFERENCES `projects` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_unicode_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for issues
-- ----------------------------
DROP TABLE IF EXISTS `issues`;
CREATE TABLE `issues`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `description` mediumtext CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `user_id` int(10) UNSIGNED NULL DEFAULT NULL,
  `project_id` int(10) UNSIGNED NULL DEFAULT NULL,
  `status` enum('pending','resolved') CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT 'pending',
  `created_at` timestamp(0) NULL DEFAULT NULL,
  `updated_at` timestamp(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `issues_user_id_foreign`(`user_id`) USING BTREE,
  INDEX `issues_project_id_foreign`(`project_id`) USING BTREE,
  CONSTRAINT `issues_project_id_foreign` FOREIGN KEY (`project_id`) REFERENCES `projects` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `issues_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_unicode_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for jobs
-- ----------------------------
DROP TABLE IF EXISTS `jobs`;
CREATE TABLE `jobs`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `queue` varchar(191) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `payload` longtext CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `attempts` tinyint(3) UNSIGNED NOT NULL,
  `reserved_at` int(10) UNSIGNED NULL DEFAULT NULL,
  `available_at` int(10) UNSIGNED NOT NULL,
  `created_at` int(10) UNSIGNED NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `jobs_queue_index`(`queue`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_unicode_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for language_settings
-- ----------------------------
DROP TABLE IF EXISTS `language_settings`;
CREATE TABLE `language_settings`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `language_code` varchar(191) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `language_name` varchar(191) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `status` enum('enabled','disabled') CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `created_at` timestamp(0) NULL DEFAULT NULL,
  `updated_at` timestamp(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 18 CHARACTER SET = utf8 COLLATE = utf8_unicode_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of language_settings
-- ----------------------------
INSERT INTO `language_settings` VALUES (1, 'ar', 'Arabic', 'disabled', NULL, NULL);
INSERT INTO `language_settings` VALUES (2, 'de', 'German', 'disabled', NULL, NULL);
INSERT INTO `language_settings` VALUES (3, 'es', 'Spanish', 'disabled', NULL, '2019-06-18 05:00:36');
INSERT INTO `language_settings` VALUES (4, 'et', 'Estonian', 'disabled', NULL, NULL);
INSERT INTO `language_settings` VALUES (5, 'fa', 'Farsi', 'disabled', NULL, NULL);
INSERT INTO `language_settings` VALUES (6, 'fr', 'French', 'disabled', NULL, '2019-06-18 05:00:34');
INSERT INTO `language_settings` VALUES (7, 'gr', 'Greek', 'disabled', NULL, NULL);
INSERT INTO `language_settings` VALUES (8, 'it', 'Italian', 'disabled', NULL, NULL);
INSERT INTO `language_settings` VALUES (9, 'nl', 'Dutch', 'disabled', NULL, NULL);
INSERT INTO `language_settings` VALUES (10, 'pl', 'Polish', 'disabled', NULL, NULL);
INSERT INTO `language_settings` VALUES (11, 'pt', 'Portuguese', 'disabled', NULL, NULL);
INSERT INTO `language_settings` VALUES (12, 'pt-br', 'Portuguese (Brazil)', 'disabled', NULL, NULL);
INSERT INTO `language_settings` VALUES (13, 'ro', 'Romanian', 'disabled', NULL, NULL);
INSERT INTO `language_settings` VALUES (14, 'ru', 'Russian', 'disabled', NULL, '2019-06-18 05:00:30');
INSERT INTO `language_settings` VALUES (15, 'tr', 'Turkish', 'disabled', NULL, NULL);
INSERT INTO `language_settings` VALUES (16, 'zh-CN', 'Chinese (S)', 'disabled', NULL, NULL);
INSERT INTO `language_settings` VALUES (17, 'zh-TW', 'Chinese (T)', 'disabled', NULL, NULL);

-- ----------------------------
-- Table structure for lead_files
-- ----------------------------
DROP TABLE IF EXISTS `lead_files`;
CREATE TABLE `lead_files`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `company_id` int(10) UNSIGNED NULL DEFAULT NULL,
  `lead_id` int(10) UNSIGNED NOT NULL,
  `user_id` int(10) UNSIGNED NOT NULL,
  `filename` varchar(200) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `hashname` varchar(200) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `size` varchar(200) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `description` text CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL,
  `google_url` varchar(191) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT NULL,
  `dropbox_link` varchar(191) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT NULL,
  `created_at` timestamp(0) NULL DEFAULT NULL,
  `updated_at` timestamp(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `lead_files_lead_id_foreign`(`lead_id`) USING BTREE,
  INDEX `lead_files_user_id_foreign`(`user_id`) USING BTREE,
  INDEX `lead_files_company_id_foreign`(`company_id`) USING BTREE,
  CONSTRAINT `lead_files_company_id_foreign` FOREIGN KEY (`company_id`) REFERENCES `companies` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `lead_files_lead_id_foreign` FOREIGN KEY (`lead_id`) REFERENCES `leads` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `lead_files_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_unicode_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for lead_follow_up
-- ----------------------------
DROP TABLE IF EXISTS `lead_follow_up`;
CREATE TABLE `lead_follow_up`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `lead_id` int(10) UNSIGNED NOT NULL,
  `remark` longtext CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL,
  `next_follow_up_date` datetime(0) NULL DEFAULT NULL,
  `created_at` timestamp(0) NULL DEFAULT NULL,
  `updated_at` timestamp(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `lead_follow_up_lead_id_foreign`(`lead_id`) USING BTREE,
  CONSTRAINT `lead_follow_up_lead_id_foreign` FOREIGN KEY (`lead_id`) REFERENCES `leads` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_unicode_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for lead_sources
-- ----------------------------
DROP TABLE IF EXISTS `lead_sources`;
CREATE TABLE `lead_sources`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `company_id` int(10) UNSIGNED NULL DEFAULT NULL,
  `type` varchar(191) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `created_at` timestamp(0) NULL DEFAULT NULL,
  `updated_at` timestamp(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `lead_sources_company_id_foreign`(`company_id`) USING BTREE,
  CONSTRAINT `lead_sources_company_id_foreign` FOREIGN KEY (`company_id`) REFERENCES `companies` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 13 CHARACTER SET = utf8 COLLATE = utf8_unicode_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of lead_sources
-- ----------------------------
INSERT INTO `lead_sources` VALUES (1, NULL, 'email', NULL, NULL);
INSERT INTO `lead_sources` VALUES (2, NULL, 'google', NULL, NULL);
INSERT INTO `lead_sources` VALUES (3, NULL, 'facebook', NULL, NULL);
INSERT INTO `lead_sources` VALUES (4, NULL, 'friend', NULL, NULL);
INSERT INTO `lead_sources` VALUES (5, NULL, 'direct visit', NULL, NULL);
INSERT INTO `lead_sources` VALUES (6, NULL, 'tv ad', NULL, NULL);
INSERT INTO `lead_sources` VALUES (7, 1, 'email', NULL, NULL);
INSERT INTO `lead_sources` VALUES (8, 1, 'google', NULL, NULL);
INSERT INTO `lead_sources` VALUES (9, 1, 'facebook', NULL, NULL);
INSERT INTO `lead_sources` VALUES (10, 1, 'friend', NULL, NULL);
INSERT INTO `lead_sources` VALUES (11, 1, 'direct visit', NULL, NULL);
INSERT INTO `lead_sources` VALUES (12, 1, 'tv ad', NULL, NULL);

-- ----------------------------
-- Table structure for lead_status
-- ----------------------------
DROP TABLE IF EXISTS `lead_status`;
CREATE TABLE `lead_status`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `company_id` int(10) UNSIGNED NULL DEFAULT NULL,
  `type` varchar(191) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `created_at` timestamp(0) NULL DEFAULT NULL,
  `updated_at` timestamp(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `lead_status_company_id_foreign`(`company_id`) USING BTREE,
  CONSTRAINT `lead_status_company_id_foreign` FOREIGN KEY (`company_id`) REFERENCES `companies` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = utf8 COLLATE = utf8_unicode_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of lead_status
-- ----------------------------
INSERT INTO `lead_status` VALUES (1, NULL, 'pending', NULL, NULL);
INSERT INTO `lead_status` VALUES (2, NULL, 'inprocess', NULL, NULL);
INSERT INTO `lead_status` VALUES (3, NULL, 'converted', NULL, NULL);
INSERT INTO `lead_status` VALUES (4, 1, 'pending', NULL, NULL);
INSERT INTO `lead_status` VALUES (5, 1, 'inprocess', NULL, NULL);
INSERT INTO `lead_status` VALUES (6, 1, 'converted', NULL, NULL);

-- ----------------------------
-- Table structure for leads
-- ----------------------------
DROP TABLE IF EXISTS `leads`;
CREATE TABLE `leads`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `company_id` int(10) UNSIGNED NULL DEFAULT NULL,
  `client_id` int(11) NULL DEFAULT NULL,
  `source_id` int(11) NULL DEFAULT NULL,
  `status_id` int(11) NULL DEFAULT NULL,
  `company_name` varchar(191) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `website` varchar(191) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT NULL,
  `address` text CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL,
  `client_name` varchar(191) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `client_email` varchar(191) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `mobile` varchar(191) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT NULL,
  `note` text CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL,
  `next_follow_up` enum('yes','no') CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT 'yes',
  `created_at` timestamp(0) NULL DEFAULT NULL,
  `updated_at` timestamp(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `leads_company_id_foreign`(`company_id`) USING BTREE,
  CONSTRAINT `leads_company_id_foreign` FOREIGN KEY (`company_id`) REFERENCES `companies` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_unicode_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for leave_types
-- ----------------------------
DROP TABLE IF EXISTS `leave_types`;
CREATE TABLE `leave_types`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `company_id` int(10) UNSIGNED NULL DEFAULT NULL,
  `type_name` varchar(191) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `color` varchar(191) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `no_of_leaves` int(11) NOT NULL DEFAULT 5,
  `created_at` timestamp(0) NULL DEFAULT NULL,
  `updated_at` timestamp(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `leave_types_company_id_foreign`(`company_id`) USING BTREE,
  CONSTRAINT `leave_types_company_id_foreign` FOREIGN KEY (`company_id`) REFERENCES `companies` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = utf8 COLLATE = utf8_unicode_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of leave_types
-- ----------------------------
INSERT INTO `leave_types` VALUES (1, NULL, 'Casual', 'success', 5, '2019-06-16 06:25:36', '2019-06-16 06:25:36');
INSERT INTO `leave_types` VALUES (2, NULL, 'Sick', 'danger', 5, '2019-06-16 06:25:36', '2019-06-16 06:25:36');
INSERT INTO `leave_types` VALUES (3, NULL, 'Earned', 'info', 5, '2019-06-16 06:25:36', '2019-06-16 06:25:36');
INSERT INTO `leave_types` VALUES (4, 1, 'Casual', 'success', 10, '2019-06-16 06:34:20', '2019-06-22 05:29:27');
INSERT INTO `leave_types` VALUES (5, 1, 'Sick', 'danger', 14, '2019-06-16 06:34:20', '2019-06-22 05:29:33');
INSERT INTO `leave_types` VALUES (6, 1, 'Earned', 'info', 5, '2019-06-16 06:34:20', '2019-06-16 06:34:20');

-- ----------------------------
-- Table structure for leaves
-- ----------------------------
DROP TABLE IF EXISTS `leaves`;
CREATE TABLE `leaves`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `company_id` int(10) UNSIGNED NULL DEFAULT NULL,
  `user_id` int(10) UNSIGNED NOT NULL,
  `leave_type_id` int(10) UNSIGNED NOT NULL,
  `duration` varchar(191) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `leave_date` date NOT NULL,
  `reason` text CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `status` enum('approved','pending','rejected') CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `reject_reason` text CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL,
  `created_at` timestamp(0) NULL DEFAULT NULL,
  `updated_at` timestamp(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `leaves_user_id_foreign`(`user_id`) USING BTREE,
  INDEX `leaves_leave_type_id_foreign`(`leave_type_id`) USING BTREE,
  INDEX `leaves_company_id_foreign`(`company_id`) USING BTREE,
  CONSTRAINT `leaves_company_id_foreign` FOREIGN KEY (`company_id`) REFERENCES `companies` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `leaves_leave_type_id_foreign` FOREIGN KEY (`leave_type_id`) REFERENCES `leave_types` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `leaves_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8 COLLATE = utf8_unicode_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of leaves
-- ----------------------------
INSERT INTO `leaves` VALUES (1, 1, 5, 5, 'single', '2019-06-22', 'Food Poison', 'approved', NULL, '2019-06-22 05:24:37', '2019-06-22 05:30:35');
INSERT INTO `leaves` VALUES (4, 1, 5, 4, 'single', '2019-06-22', 'Family Affairs', 'approved', NULL, '2019-06-22 05:28:15', '2019-06-22 05:30:38');

-- ----------------------------
-- Table structure for licences
-- ----------------------------
DROP TABLE IF EXISTS `licences`;
CREATE TABLE `licences`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `company_id` int(10) UNSIGNED NULL DEFAULT NULL,
  `license_number` char(29) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `package_id` int(10) UNSIGNED NULL DEFAULT NULL,
  `company_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `email` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `contact_person` varchar(70) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT NULL,
  `billing_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT NULL,
  `billing_address` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT NULL,
  `tax_number` varchar(100) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT NULL,
  `expire_date` date NULL DEFAULT NULL,
  `last_payment_date` date NULL DEFAULT NULL,
  `next_payment_date` date NULL DEFAULT NULL,
  `status` enum('valid','invalid') CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT 'valid',
  `created_at` timestamp(0) NULL DEFAULT NULL,
  `updated_at` timestamp(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `licences_company_id_foreign`(`company_id`) USING BTREE,
  INDEX `licences_package_id_foreign`(`package_id`) USING BTREE,
  CONSTRAINT `licences_company_id_foreign` FOREIGN KEY (`company_id`) REFERENCES `companies` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `licences_package_id_foreign` FOREIGN KEY (`package_id`) REFERENCES `packages` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_unicode_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for log_time_for
-- ----------------------------
DROP TABLE IF EXISTS `log_time_for`;
CREATE TABLE `log_time_for`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `company_id` int(10) UNSIGNED NULL DEFAULT NULL,
  `log_time_for` enum('project','task') CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT 'project',
  `auto_timer_stop` enum('yes','no') CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT 'no',
  `created_at` timestamp(0) NULL DEFAULT NULL,
  `updated_at` timestamp(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `log_time_for_company_id_foreign`(`company_id`) USING BTREE,
  CONSTRAINT `log_time_for_company_id_foreign` FOREIGN KEY (`company_id`) REFERENCES `companies` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8 COLLATE = utf8_unicode_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of log_time_for
-- ----------------------------
INSERT INTO `log_time_for` VALUES (1, 1, 'project', 'no', '2019-06-16 06:34:23', '2019-06-16 06:34:23');

-- ----------------------------
-- Table structure for ltm_translations
-- ----------------------------
DROP TABLE IF EXISTS `ltm_translations`;
CREATE TABLE `ltm_translations`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `status` int(11) NOT NULL DEFAULT 0,
  `locale` varchar(191) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `group` varchar(191) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `key` varchar(191) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `value` text CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL,
  `created_at` timestamp(0) NULL DEFAULT NULL,
  `updated_at` timestamp(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2825 CHARACTER SET = utf8 COLLATE = utf8_unicode_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of ltm_translations
-- ----------------------------
INSERT INTO `ltm_translations` VALUES (1, 0, 'en', 'messages', 'unsubscribeSuccess', 'Plan unsubscribe successfully.', '2019-06-18 05:01:27', '2019-06-18 05:07:38');
INSERT INTO `ltm_translations` VALUES (2, 0, 'en', 'app', 'menu.taskCalendar', 'Task Calendar', '2019-06-18 05:01:27', '2019-06-18 05:06:37');
INSERT INTO `ltm_translations` VALUES (3, 0, 'en', 'app', 'menu.messages', 'Messages', '2019-06-18 05:01:28', '2019-06-18 05:06:38');
INSERT INTO `ltm_translations` VALUES (4, 0, 'en', 'messages', 'fetchChat', 'Fetching chat detail.', '2019-06-18 05:01:28', '2019-06-18 05:07:19');
INSERT INTO `ltm_translations` VALUES (5, 0, 'en', 'app', 'menu.customFields', 'Custom Fields', '2019-06-18 05:01:28', '2019-06-18 05:06:40');
INSERT INTO `ltm_translations` VALUES (6, 0, 'en', 'app', 'menu.dashboard', 'Dashboard', '2019-06-18 05:01:28', '2019-06-18 05:06:36');
INSERT INTO `ltm_translations` VALUES (7, 0, 'en', 'app', 'menu.Events', 'Events', '2019-06-18 05:01:28', '2019-06-18 05:06:40');
INSERT INTO `ltm_translations` VALUES (8, 0, 'en', 'messages', 'eventCreateSuccess', 'Event created successfully.', '2019-06-18 05:01:28', '2019-06-18 05:07:28');
INSERT INTO `ltm_translations` VALUES (9, 0, 'en', 'messages', 'eventDeleteSuccess', 'Event deleted successfully.', '2019-06-18 05:01:28', '2019-06-18 05:07:28');
INSERT INTO `ltm_translations` VALUES (10, 0, 'en', 'app', 'menu.products', 'Products', '2019-06-18 05:01:28', '2019-06-18 05:06:42');
INSERT INTO `ltm_translations` VALUES (11, 0, 'en', 'messages', 'productAdded', 'Product added successfully.', '2019-06-18 05:01:28', '2019-06-18 05:07:33');
INSERT INTO `ltm_translations` VALUES (12, 0, 'en', 'messages', 'productUpdated', 'Product updated successfully.', '2019-06-18 05:01:28', '2019-06-18 05:07:33');
INSERT INTO `ltm_translations` VALUES (13, 0, 'en', 'messages', 'productDeleted', 'Product deleted successfully.', '2019-06-18 05:01:28', '2019-06-18 05:07:33');
INSERT INTO `ltm_translations` VALUES (14, 0, 'en', 'app', 'menu.profileSettings', 'Profile Settings', '2019-06-18 05:01:28', '2019-06-18 05:06:38');
INSERT INTO `ltm_translations` VALUES (15, 0, 'en', 'modules', 'tasks.taskBoard', 'Task Board', '2019-06-18 05:01:28', '2019-06-18 05:07:54');
INSERT INTO `ltm_translations` VALUES (16, 0, 'en', 'messages', 'boardColumnSaved', 'Board column saved successfully.', '2019-06-18 05:01:28', '2019-06-18 05:07:28');
INSERT INTO `ltm_translations` VALUES (17, 0, 'en', 'app', 'menu.attendanceSettings', 'Attendance Settings', '2019-06-18 05:01:28', '2019-06-18 05:06:40');
INSERT INTO `ltm_translations` VALUES (18, 0, 'en', 'messages', 'settingsUpdated', 'Settings updated successfully.', '2019-06-18 05:01:28', '2019-06-18 05:07:14');
INSERT INTO `ltm_translations` VALUES (19, 0, 'en', 'messages', 'contactAdded', 'Contact added successfully.', '2019-06-18 05:01:29', '2019-06-18 05:07:13');
INSERT INTO `ltm_translations` VALUES (20, 0, 'en', 'messages', 'contactUpdated', 'Contact updated successfully.', '2019-06-18 05:01:29', '2019-06-18 05:07:13');
INSERT INTO `ltm_translations` VALUES (21, 0, 'en', 'messages', 'contactDeleted', 'Contact deleted successfully.', '2019-06-18 05:01:29', '2019-06-18 05:07:13');
INSERT INTO `ltm_translations` VALUES (22, 0, 'en', 'app', 'menu.currencySettings', 'Currency Settings', '2019-06-18 05:01:29', '2019-06-18 05:06:38');
INSERT INTO `ltm_translations` VALUES (23, 0, 'en', 'messages', 'currencyAdded', 'Currency added successfully.', '2019-06-18 05:01:29', '2019-06-18 05:07:13');
INSERT INTO `ltm_translations` VALUES (24, 0, 'en', 'messages', 'currencyUpdated', 'Currency updated successfully.', '2019-06-18 05:01:29', '2019-06-18 05:07:14');
INSERT INTO `ltm_translations` VALUES (25, 0, 'en', 'modules', 'currencySettings.cantDeleteDefault', 'Cannot delete default currency.', '2019-06-18 05:01:29', '2019-06-18 05:08:20');
INSERT INTO `ltm_translations` VALUES (26, 0, 'en', 'messages', 'currencyDeleted', 'Currency deleted successfully.', '2019-06-18 05:01:29', '2019-06-18 05:07:14');
INSERT INTO `ltm_translations` VALUES (27, 0, 'en', 'messages', 'exchangeRateUpdateSuccess', 'Exchange rate updated successfully.', '2019-06-18 05:01:29', '2019-06-18 05:07:24');
INSERT INTO `ltm_translations` VALUES (28, 0, 'en', 'messages', 'currencyConvertKeyUpdated', 'Currency convert API key updated successfully', '2019-06-18 05:01:29', '2019-06-18 05:07:35');
INSERT INTO `ltm_translations` VALUES (29, 0, 'en', 'app', 'menu.emailSettings', 'Email Settings', '2019-06-18 05:01:29', '2019-06-18 05:06:38');
INSERT INTO `ltm_translations` VALUES (30, 0, 'en', 'app', 'menu.employeeDocs', 'Employee Documents', '2019-06-18 05:01:29', '2019-06-18 05:06:45');
INSERT INTO `ltm_translations` VALUES (31, 0, 'en', 'messages', 'fileUploaded', 'File uploaded successfully.', '2019-06-18 05:01:29', '2019-06-18 05:07:17');
INSERT INTO `ltm_translations` VALUES (32, 0, 'en', 'messages', 'fileDeleted', 'File deleted successfully.', '2019-06-18 05:01:29', '2019-06-18 05:07:17');
INSERT INTO `ltm_translations` VALUES (33, 0, 'en', 'app', 'menu.financeReport', 'Finance Report', '2019-06-18 05:01:29', '2019-06-18 05:06:37');
INSERT INTO `ltm_translations` VALUES (34, 0, 'en', 'messages', 'reportGenerated', 'Report generated successfully.', '2019-06-18 05:01:29', '2019-06-18 05:07:14');
INSERT INTO `ltm_translations` VALUES (35, 0, 'en', 'app', 'client', 'Client', '2019-06-18 05:01:29', '2019-06-18 05:06:33');
INSERT INTO `ltm_translations` VALUES (36, 0, 'en', 'app', 'lead', 'Lead', '2019-06-18 05:01:29', '2019-06-18 05:06:35');
INSERT INTO `ltm_translations` VALUES (37, 0, 'en', 'messages', 'LeadDeleted', 'Lead deleted successfully.', '2019-06-18 05:01:29', '2019-06-18 05:07:31');
INSERT INTO `ltm_translations` VALUES (38, 0, 'en', 'messages', 'leadStatusChangeSuccess', 'Status changed successfully.', '2019-06-18 05:01:30', '2019-06-18 05:07:32');
INSERT INTO `ltm_translations` VALUES (39, 0, 'en', 'messages', 'leadFollowUpAddedSuccess', 'Lead follow up added successfully.', '2019-06-18 05:01:30', '2019-06-18 05:07:32');
INSERT INTO `ltm_translations` VALUES (40, 0, 'en', 'messages', 'holidayAddedSuccess', '<strong>New Holidays</strong> successfully added to the Database.', '2019-06-18 05:01:30', '2019-06-18 05:07:33');
INSERT INTO `ltm_translations` VALUES (41, 0, 'en', 'messages', 'holidayDeletedSuccess', 'Holidays successfully deleted.', '2019-06-18 05:01:30', '2019-06-18 05:07:34');
INSERT INTO `ltm_translations` VALUES (42, 0, 'en', 'messages', 'checkDayHoliday', 'Choose at-least 1.', '2019-06-18 05:01:30', '2019-06-18 05:07:19');
INSERT INTO `ltm_translations` VALUES (43, 0, 'en', 'app', 'menu.incomeVsExpenseReport', 'Income Vs Expense Report', '2019-06-18 05:01:30', '2019-06-18 05:06:38');
INSERT INTO `ltm_translations` VALUES (44, 0, 'en', 'app', 'menu.invoiceSettings', 'Invoice Settings', '2019-06-18 05:01:30', '2019-06-18 05:06:38');
INSERT INTO `ltm_translations` VALUES (45, 0, 'en', 'modules', 'lead.changeToClient', 'Change To Client', '2019-06-18 05:01:30', '2019-06-18 05:08:55');
INSERT INTO `ltm_translations` VALUES (46, 0, 'en', 'modules', 'lead.addFollowUp', 'Add Follow Up', '2019-06-18 05:01:31', '2019-06-18 05:08:55');
INSERT INTO `ltm_translations` VALUES (47, 0, 'en', 'modules', 'lead.action', 'Action', '2019-06-18 05:01:31', '2019-06-18 05:08:55');
INSERT INTO `ltm_translations` VALUES (48, 0, 'en', 'modules', 'lead.view', 'View', '2019-06-18 05:01:31', '2019-06-18 05:08:55');
INSERT INTO `ltm_translations` VALUES (49, 0, 'en', 'modules', 'lead.edit', 'Edit', '2019-06-18 05:01:31', '2019-06-18 05:08:55');
INSERT INTO `ltm_translations` VALUES (50, 0, 'en', 'app', 'delete', 'Delete', '2019-06-18 05:01:31', '2019-06-18 05:06:48');
INSERT INTO `ltm_translations` VALUES (51, 0, 'en', 'app', 'pending', 'Pending', '2019-06-18 05:01:31', '2019-06-18 05:06:46');
INSERT INTO `ltm_translations` VALUES (52, 0, 'en', 'messages', 'LeadAddedUpdated', 'Lead added successfully.', '2019-06-18 05:01:31', '2019-06-18 05:07:31');
INSERT INTO `ltm_translations` VALUES (53, 0, 'en', 'messages', 'LeadUpdated', 'Lead updated successfully.', '2019-06-18 05:01:31', '2019-06-18 05:07:31');
INSERT INTO `ltm_translations` VALUES (54, 0, 'en', 'messages', 'leadFollowUpUpdatedSuccess', 'Lead follow up added successfully.', '2019-06-18 05:01:31', '2019-06-18 05:07:32');
INSERT INTO `ltm_translations` VALUES (55, 0, 'en', 'messages', 'followUpFilter', 'Filter applied.', '2019-06-18 05:01:31', '2019-06-18 05:07:33');
INSERT INTO `ltm_translations` VALUES (56, 0, 'en', 'app', 'menu.leadFiles', 'Lead Files', '2019-06-18 05:01:31', '2019-06-18 05:06:43');
INSERT INTO `ltm_translations` VALUES (57, 0, 'en', 'app', 'menu.leadSource', 'Lead Source', '2019-06-18 05:01:31', '2019-06-18 05:06:42');
INSERT INTO `ltm_translations` VALUES (58, 0, 'en', 'messages', 'leadSourceAddSuccess', 'Lead source added successfully.', '2019-06-18 05:01:31', '2019-06-18 05:07:31');
INSERT INTO `ltm_translations` VALUES (59, 0, 'en', 'messages', 'leadSourceUpdateSuccess', 'Lead source updated successfully.', '2019-06-18 05:01:31', '2019-06-18 05:07:31');
INSERT INTO `ltm_translations` VALUES (60, 0, 'en', 'messages', 'leadSourceDeleteSuccess', 'Lead source deleted successfully.', '2019-06-18 05:01:31', '2019-06-18 05:07:31');
INSERT INTO `ltm_translations` VALUES (61, 0, 'en', 'app', 'menu.leadStatus', 'Lead Status', '2019-06-18 05:01:31', '2019-06-18 05:06:42');
INSERT INTO `ltm_translations` VALUES (62, 0, 'en', 'messages', 'leadStatusAddSuccess', 'Lead sttaus added successfully.', '2019-06-18 05:01:31', '2019-06-18 05:07:32');
INSERT INTO `ltm_translations` VALUES (63, 0, 'en', 'messages', 'leadStatusUpdateSuccess', 'Lead status updated successfully.', '2019-06-18 05:01:31', '2019-06-18 05:07:32');
INSERT INTO `ltm_translations` VALUES (64, 0, 'en', 'messages', 'leadStatusDeleteSuccess', 'Lead status deleted successfully.', '2019-06-18 05:01:31', '2019-06-18 05:07:32');
INSERT INTO `ltm_translations` VALUES (65, 0, 'en', 'app', 'menu.leaveReport', 'Leave Report', '2019-06-18 05:01:31', '2019-06-18 05:06:42');
INSERT INTO `ltm_translations` VALUES (66, 0, 'en', 'app', 'menu.leaveSettings', 'Leaves Settings', '2019-06-18 05:01:31', '2019-06-18 05:06:41');
INSERT INTO `ltm_translations` VALUES (67, 0, 'en', 'app', 'menu.themeSettings', 'Theme Settings', '2019-06-18 05:01:31', '2019-06-18 05:06:38');
INSERT INTO `ltm_translations` VALUES (68, 0, 'en', 'messages', 'logTimeUpdateSuccess', 'Log time updated successfully.', '2019-06-18 05:01:31', '2019-06-18 05:07:34');
INSERT INTO `ltm_translations` VALUES (69, 0, 'en', 'app', 'menu.invoices', 'Invoices', '2019-06-18 05:01:31', '2019-06-18 05:06:37');
INSERT INTO `ltm_translations` VALUES (70, 0, 'en', 'modules', 'payments.addPayment', 'Add Payment', '2019-06-18 05:01:32', '2019-06-18 05:08:24');
INSERT INTO `ltm_translations` VALUES (71, 0, 'en', 'modules', 'invoices.partial', 'Partially Paid', '2019-06-18 05:01:32', '2019-06-18 05:08:01');
INSERT INTO `ltm_translations` VALUES (72, 0, 'en', 'messages', 'invoiceDeleted', 'Invoice deleted successfully.', '2019-06-18 05:01:32', '2019-06-18 05:07:14');
INSERT INTO `ltm_translations` VALUES (73, 0, 'en', 'messages', 'quantityNumber', 'Quantity should be a number', '2019-06-18 05:01:32', '2019-06-18 05:07:14');
INSERT INTO `ltm_translations` VALUES (74, 0, 'en', 'messages', 'unitPriceNumber', 'Unit price should be a number', '2019-06-18 05:01:32', '2019-06-18 05:07:14');
INSERT INTO `ltm_translations` VALUES (75, 0, 'en', 'messages', 'amountNumber', 'Amount should be a number.', '2019-06-18 05:01:32', '2019-06-18 05:07:14');
INSERT INTO `ltm_translations` VALUES (76, 0, 'en', 'messages', 'itemBlank', 'Item name cannot be blank.', '2019-06-18 05:01:32', '2019-06-18 05:07:14');
INSERT INTO `ltm_translations` VALUES (77, 0, 'en', 'messages', 'invoiceCreated', 'Invoice created successfully.', '2019-06-18 05:01:32', '2019-06-18 05:07:15');
INSERT INTO `ltm_translations` VALUES (78, 0, 'en', 'messages', 'invalidRequest', 'Invalid Request', '2019-06-18 05:01:32', '2019-06-18 05:07:24');
INSERT INTO `ltm_translations` VALUES (79, 0, 'en', 'messages', 'invoiceUpdated', 'Invoice updated successfully.', '2019-06-18 05:01:32', '2019-06-18 05:07:15');
INSERT INTO `ltm_translations` VALUES (80, 0, 'en', 'messages', 'fileUploadedSuccessfully', 'File uploaded successfully.', '2019-06-18 05:01:32', '2019-06-18 05:07:11');
INSERT INTO `ltm_translations` VALUES (81, 0, 'en', 'messages', 'fileUploadIssue', 'File not uploaded. Please contact to administrator', '2019-06-18 05:01:32', '2019-06-18 05:07:21');
INSERT INTO `ltm_translations` VALUES (82, 0, 'en', 'app', 'menu.issues', 'Issues', '2019-06-18 05:01:32', '2019-06-18 05:06:37');
INSERT INTO `ltm_translations` VALUES (83, 0, 'en', 'modules', 'issues.markResolved', 'Mark Resolved', '2019-06-18 05:01:32', '2019-06-18 05:08:02');
INSERT INTO `ltm_translations` VALUES (84, 0, 'en', 'modules', 'issues.markPending', 'Mark Pending', '2019-06-18 05:01:32', '2019-06-18 05:08:02');
INSERT INTO `ltm_translations` VALUES (85, 0, 'en', 'modules', 'issues.pending', 'Pending', '2019-06-18 05:01:32', '2019-06-18 05:08:01');
INSERT INTO `ltm_translations` VALUES (86, 0, 'en', 'modules', 'issues.resolved', 'Resolved', '2019-06-18 05:01:32', '2019-06-18 05:08:02');
INSERT INTO `ltm_translations` VALUES (87, 0, 'en', 'messages', 'issueStatusChanged', 'Issue status changed successfully.', '2019-06-18 05:01:32', '2019-06-18 05:07:15');
INSERT INTO `ltm_translations` VALUES (88, 0, 'en', 'app', 'menu.tasks', 'Tasks', '2019-06-18 05:01:32', '2019-06-18 05:06:37');
INSERT INTO `ltm_translations` VALUES (89, 0, 'en', 'messages', 'taskUpdatedSuccessfully', 'Task updated successfully.', '2019-06-18 05:01:32', '2019-06-18 05:07:11');
INSERT INTO `ltm_translations` VALUES (90, 0, 'en', 'messages', 'taskDeletedSuccessfully', 'Task deleted successfully.', '2019-06-18 05:01:32', '2019-06-18 05:07:11');
INSERT INTO `ltm_translations` VALUES (91, 0, 'en', 'messages', 'newTaskAddedToTheProject', 'New task added to the project.', '2019-06-18 05:01:32', '2019-06-18 05:07:10');
INSERT INTO `ltm_translations` VALUES (92, 0, 'en', 'messages', 'taskCreatedSuccessfully', 'Task created successfully.', '2019-06-18 05:01:32', '2019-06-18 05:07:11');
INSERT INTO `ltm_translations` VALUES (93, 0, 'en', 'app', 'active', 'Active', '2019-06-18 05:01:32', '2019-06-18 05:06:35');
INSERT INTO `ltm_translations` VALUES (94, 0, 'en', 'messages', 'timeLogDeleted', 'Time log deleted successfully.', '2019-06-18 05:01:33', '2019-06-18 05:07:15');
INSERT INTO `ltm_translations` VALUES (95, 0, 'en', 'messages', 'timerStoppedSuccessfully', 'Timer stopped successfully.', '2019-06-18 05:01:33', '2019-06-18 05:07:10');
INSERT INTO `ltm_translations` VALUES (96, 0, 'en', 'app', 'menu.attendance', 'Attendance', '2019-06-18 05:01:33', '2019-06-18 05:06:40');
INSERT INTO `ltm_translations` VALUES (97, 0, 'en', 'messages', 'maxColckIn', NULL, '2019-06-18 05:01:33', '2019-06-18 05:01:33');
INSERT INTO `ltm_translations` VALUES (98, 0, 'en', 'messages', 'attendanceSaveSuccess', 'Attendance Saved Successfully.', '2019-06-18 05:01:33', '2019-06-18 05:07:28');
INSERT INTO `ltm_translations` VALUES (99, 0, 'en', 'messages', 'attendanceDelete', 'Attendance deleted successfully.', '2019-06-18 05:01:33', '2019-06-18 05:07:30');
INSERT INTO `ltm_translations` VALUES (100, 0, 'en', 'app', 'menu.clients', 'Clients', '2019-06-18 05:01:33', '2019-06-18 05:06:36');
INSERT INTO `ltm_translations` VALUES (101, 0, 'en', 'messages', 'leadClientChangeSuccess', 'Lead changed in client successfully.', '2019-06-18 05:01:33', '2019-06-18 05:07:32');
INSERT INTO `ltm_translations` VALUES (102, 0, 'en', 'messages', 'clientDeleted', 'Client deleted successfully.', '2019-06-18 05:01:33', '2019-06-18 05:07:16');
INSERT INTO `ltm_translations` VALUES (103, 0, 'en', 'app', 'deactive', 'Deactive', '2019-06-18 05:01:33', '2019-06-18 05:06:56');
INSERT INTO `ltm_translations` VALUES (104, 0, 'en', 'app', 'menu.employees', 'Employees', '2019-06-18 05:01:33', '2019-06-18 05:06:36');
INSERT INTO `ltm_translations` VALUES (105, 0, 'en', 'messages', 'upgradePackageForAddEmployees', 'You need to upgrade your package to create more employees because your employees length is :employeeCount and package max employees length is  :maxEmployees', '2019-06-18 05:01:33', '2019-06-18 05:07:39');
INSERT INTO `ltm_translations` VALUES (106, 0, 'en', 'messages', 'downGradePackageForAddEmployees', 'You can\\\'t downgrade package because your employees length is :employeeCount and package max employees length is :maxEmployees', '2019-06-18 05:01:33', '2019-06-18 05:07:39');
INSERT INTO `ltm_translations` VALUES (107, 0, 'en', 'messages', 'employeeAdded', 'Employee added successfully.', '2019-06-18 05:01:33', '2019-06-18 05:07:25');
INSERT INTO `ltm_translations` VALUES (108, 0, 'en', 'messages', 'employeeUpdated', 'Employee info updated successfully.', '2019-06-18 05:01:33', '2019-06-18 05:07:16');
INSERT INTO `ltm_translations` VALUES (109, 0, 'en', 'messages', 'adminCannotDelete', 'Admin user cannot be deleted.', '2019-06-18 05:01:33', '2019-06-18 05:07:16');
INSERT INTO `ltm_translations` VALUES (110, 0, 'en', 'messages', 'employeeDeleted', 'Employee deleted successfully.', '2019-06-18 05:01:33', '2019-06-18 05:07:16');
INSERT INTO `ltm_translations` VALUES (111, 0, 'en', 'messages', 'roleCannotChange', 'Role of this user cannot be changed.', '2019-06-18 05:01:33', '2019-06-18 05:07:23');
INSERT INTO `ltm_translations` VALUES (112, 0, 'en', 'app', 'inactive', 'Inactive', '2019-06-18 05:01:33', '2019-06-18 05:06:58');
INSERT INTO `ltm_translations` VALUES (113, 0, 'en', 'app', 'admin', 'Admin', '2019-06-18 05:01:33', '2019-06-18 05:06:53');
INSERT INTO `ltm_translations` VALUES (114, 0, 'en', 'app', 'employee', 'Employee', '2019-06-18 05:01:34', '2019-06-18 05:06:53');
INSERT INTO `ltm_translations` VALUES (115, 0, 'en', 'messages', 'roleAssigned', 'Roles assigned successfully.', '2019-06-18 05:01:34', '2019-06-18 05:07:23');
INSERT INTO `ltm_translations` VALUES (116, 0, 'en', 'app', 'menu.estimates', 'Estimates', '2019-06-18 05:01:34', '2019-06-18 05:06:38');
INSERT INTO `ltm_translations` VALUES (117, 0, 'en', 'messages', 'addItem', 'Add at-least 1 item.', '2019-06-18 05:01:34', '2019-06-18 05:07:14');
INSERT INTO `ltm_translations` VALUES (118, 0, 'en', 'messages', 'estimateCreated', 'Estimate created successfully.', '2019-06-18 05:01:34', '2019-06-18 05:07:23');
INSERT INTO `ltm_translations` VALUES (119, 0, 'en', 'messages', 'estimateUpdated', 'Estimate updated successfully.', '2019-06-18 05:01:34', '2019-06-18 05:07:24');
INSERT INTO `ltm_translations` VALUES (120, 0, 'en', 'messages', 'estimateDeleted', 'Estimate deleted successfully.', '2019-06-18 05:01:34', '2019-06-18 05:07:24');
INSERT INTO `ltm_translations` VALUES (121, 0, 'en', 'app', 'menu.expenses', 'Expenses', '2019-06-18 05:01:34', '2019-06-18 05:06:38');
INSERT INTO `ltm_translations` VALUES (122, 0, 'en', 'messages', 'expenseSuccess', 'Expense Added Successfully.', '2019-06-18 05:01:34', '2019-06-18 05:07:24');
INSERT INTO `ltm_translations` VALUES (123, 0, 'en', 'messages', 'expenseUpdateSuccess', 'Expense updated successfully.', '2019-06-18 05:01:34', '2019-06-18 05:07:24');
INSERT INTO `ltm_translations` VALUES (124, 0, 'en', 'messages', 'expenseDeleted', 'Expense deleted successfully.', '2019-06-18 05:01:34', '2019-06-18 05:07:24');
INSERT INTO `ltm_translations` VALUES (125, 0, 'en', 'app', 'menu.leaves', 'Leaves', '2019-06-18 05:01:34', '2019-06-18 05:06:41');
INSERT INTO `ltm_translations` VALUES (126, 0, 'en', 'messages', 'leaveAssignSuccess', 'Leave assigned successfully.', '2019-06-18 05:01:34', '2019-06-18 05:07:29');
INSERT INTO `ltm_translations` VALUES (127, 0, 'en', 'messages', 'leaveStatusUpdate', 'Leave status updated successfully.', '2019-06-18 05:01:34', '2019-06-18 05:07:30');
INSERT INTO `ltm_translations` VALUES (128, 0, 'en', 'messages', 'leaveTypeAdded', 'Leave type saved.', '2019-06-18 05:01:34', '2019-06-18 05:07:29');
INSERT INTO `ltm_translations` VALUES (129, 0, 'en', 'messages', 'leaveTypeDeleted', 'Leave type deleted.', '2019-06-18 05:01:34', '2019-06-18 05:07:29');
INSERT INTO `ltm_translations` VALUES (130, 0, 'en', 'app', 'menu.noticeBoard', 'Notice Board', '2019-06-18 05:01:34', '2019-06-18 05:06:37');
INSERT INTO `ltm_translations` VALUES (131, 0, 'en', 'messages', 'noticeAdded', 'Notice added successfully.', '2019-06-18 05:01:34', '2019-06-18 05:07:16');
INSERT INTO `ltm_translations` VALUES (132, 0, 'en', 'messages', 'noticeUpdated', 'Notice updated successfully.', '2019-06-18 05:01:34', '2019-06-18 05:07:16');
INSERT INTO `ltm_translations` VALUES (133, 0, 'en', 'messages', 'noticeDeleted', 'Notice deleted successfully.', '2019-06-18 05:01:34', '2019-06-18 05:07:16');
INSERT INTO `ltm_translations` VALUES (134, 0, 'en', 'app', 'menu.payments', 'Payments', '2019-06-18 05:01:34', '2019-06-18 05:06:38');
INSERT INTO `ltm_translations` VALUES (135, 0, 'en', 'messages', 'paymentSuccess', 'Payment added successfully.', '2019-06-18 05:01:34', '2019-06-18 05:07:24');
INSERT INTO `ltm_translations` VALUES (136, 0, 'en', 'messages', 'paymentDeleted', 'Payment deleted successfully.', '2019-06-18 05:01:34', '2019-06-18 05:07:24');
INSERT INTO `ltm_translations` VALUES (137, 0, 'en', 'messages', 'importSuccess', 'File imported successfully.', '2019-06-18 05:01:35', '2019-06-18 05:07:31');
INSERT INTO `ltm_translations` VALUES (138, 0, 'en', 'messages', 'categoryAdded', 'Category added successfully.', '2019-06-18 05:01:35', '2019-06-18 05:07:16');
INSERT INTO `ltm_translations` VALUES (139, 0, 'en', 'messages', 'categoryDeleted', 'Category deleted successfully.', '2019-06-18 05:01:35', '2019-06-18 05:07:17');
INSERT INTO `ltm_translations` VALUES (140, 0, 'en', 'app', 'menu.projects', 'Projects', '2019-06-18 05:01:35', '2019-06-18 05:06:37');
INSERT INTO `ltm_translations` VALUES (141, 0, 'en', 'messages', 'newFileUploadedToTheProject', 'New file uploaded to the project.', '2019-06-18 05:01:35', '2019-06-18 05:07:10');
INSERT INTO `ltm_translations` VALUES (142, 0, 'en', 'messages', 'isAddedAsProjectMember', 'is added as project member.', '2019-06-18 05:01:35', '2019-06-18 05:07:11');
INSERT INTO `ltm_translations` VALUES (143, 0, 'en', 'messages', 'membersAddedSuccessfully', 'Members added successfully.', '2019-06-18 05:01:35', '2019-06-18 05:07:11');
INSERT INTO `ltm_translations` VALUES (144, 0, 'en', 'messages', 'memberRemovedFromProject', 'Member removed from project successfully.', '2019-06-18 05:01:35', '2019-06-18 05:07:11');
INSERT INTO `ltm_translations` VALUES (145, 0, 'en', 'messages', 'addedAsNewProject', 'added as new project.', '2019-06-18 05:01:35', '2019-06-18 05:07:10');
INSERT INTO `ltm_translations` VALUES (146, 0, 'en', 'modules', 'projects.projectUpdated', ' project details updated.', '2019-06-18 05:01:35', '2019-06-18 05:07:52');
INSERT INTO `ltm_translations` VALUES (147, 0, 'en', 'messages', 'projectUpdated', 'Project updated successfully.', '2019-06-18 05:01:35', '2019-06-18 05:07:17');
INSERT INTO `ltm_translations` VALUES (148, 0, 'en', 'messages', 'projectDeleted', 'Project deleted successfully.', '2019-06-18 05:01:35', '2019-06-18 05:07:17');
INSERT INTO `ltm_translations` VALUES (149, 0, 'en', 'messages', 'projectArchiveSuccessfully', 'Project archived successfully.', '2019-06-18 05:01:35', '2019-06-18 05:07:34');
INSERT INTO `ltm_translations` VALUES (150, 0, 'en', 'messages', 'projectRevertSuccessfully', 'Project reverted successfully.', '2019-06-18 05:01:35', '2019-06-18 05:07:34');
INSERT INTO `ltm_translations` VALUES (151, 0, 'en', 'messages', 'noMemberAddedToProject', 'No member added to this project.', '2019-06-18 05:01:35', '2019-06-18 05:07:12');
INSERT INTO `ltm_translations` VALUES (152, 0, 'en', 'modules', 'projects.addMemberTitle', 'Add Project Members', '2019-06-18 05:01:35', '2019-06-18 05:07:51');
INSERT INTO `ltm_translations` VALUES (153, 0, 'en', 'app', 'progress', 'Progress', '2019-06-18 05:01:35', '2019-06-18 05:06:57');
INSERT INTO `ltm_translations` VALUES (154, 0, 'en', 'app', 'completed', 'Completed', '2019-06-18 05:01:35', '2019-06-18 05:06:32');
INSERT INTO `ltm_translations` VALUES (155, 0, 'en', 'app', 'menu.rolesPermission', 'Roles & Permissions', '2019-06-18 05:01:35', '2019-06-18 05:06:40');
INSERT INTO `ltm_translations` VALUES (156, 0, 'en', 'messages', 'roleCreated', 'Role created successfully.', '2019-06-18 05:01:35', '2019-06-18 05:07:29');
INSERT INTO `ltm_translations` VALUES (157, 0, 'en', 'messages', 'roleUpdated', 'Role updated successfully.', '2019-06-18 05:01:36', '2019-06-18 05:07:35');
INSERT INTO `ltm_translations` VALUES (158, 0, 'en', 'app', 'menu.stickyNotes', 'Sticky Notes', '2019-06-18 05:01:36', '2019-06-18 05:06:37');
INSERT INTO `ltm_translations` VALUES (159, 0, 'en', 'messages', 'noteCreated', 'Note created successfully.', '2019-06-18 05:01:36', '2019-06-18 05:07:17');
INSERT INTO `ltm_translations` VALUES (160, 0, 'en', 'messages', 'noteUpdated', 'Note updated successfully.', '2019-06-18 05:01:36', '2019-06-18 05:07:17');
INSERT INTO `ltm_translations` VALUES (161, 0, 'en', 'messages', 'noteDeleted', 'Note deleted successfully.', '2019-06-18 05:01:36', '2019-06-18 05:07:18');
INSERT INTO `ltm_translations` VALUES (162, 0, 'en', 'messages', 'subTaskAdded', 'Sub task added successfully.', '2019-06-18 05:01:36', '2019-06-18 05:07:35');
INSERT INTO `ltm_translations` VALUES (163, 0, 'en', 'messages', 'subTaskUpdated', 'Sub task updated successfully.', '2019-06-18 05:01:36', '2019-06-18 05:07:35');
INSERT INTO `ltm_translations` VALUES (164, 0, 'en', 'app', 'menu.teams', 'Teams', '2019-06-18 05:01:36', '2019-06-18 05:06:42');
INSERT INTO `ltm_translations` VALUES (165, 0, 'en', 'messages', 'groupUpdatedSuccessfully', 'Group updated successfully.', '2019-06-18 05:01:36', '2019-06-18 05:07:25');
INSERT INTO `ltm_translations` VALUES (166, 0, 'en', 'messages', 'deleteSuccess', 'Deleted Successfully.', '2019-06-18 05:01:36', '2019-06-18 05:07:28');
INSERT INTO `ltm_translations` VALUES (167, 0, 'en', 'app', 'menu.tickets', 'Tickets', '2019-06-18 05:01:36', '2019-06-18 05:06:40');
INSERT INTO `ltm_translations` VALUES (168, 0, 'en', 'messages', 'ticketAddSuccess', 'Ticket created successfully.', '2019-06-18 05:01:36', '2019-06-18 05:07:27');
INSERT INTO `ltm_translations` VALUES (169, 0, 'en', 'messages', 'ticketReplySuccess', 'Reply sent successfully.', '2019-06-18 05:01:36', '2019-06-18 05:07:27');
INSERT INTO `ltm_translations` VALUES (170, 0, 'en', 'modules', 'tickets.agent', 'Agent', '2019-06-18 05:01:36', '2019-06-18 05:08:32');
INSERT INTO `ltm_translations` VALUES (171, 0, 'en', 'app', 'status', 'Status', '2019-06-18 05:01:36', '2019-06-18 05:06:33');
INSERT INTO `ltm_translations` VALUES (172, 0, 'en', 'modules', 'tasks.priority', 'Priority', '2019-06-18 05:01:36', '2019-06-18 05:07:54');
INSERT INTO `ltm_translations` VALUES (173, 0, 'en', 'messages', 'ticketDeleteSuccess', 'Ticket deleted successfully.', '2019-06-18 05:01:36', '2019-06-18 05:07:27');
INSERT INTO `ltm_translations` VALUES (174, 0, 'en', 'messages', 'timeLogAdded', 'Time logged successfully.', '2019-06-18 05:01:36', '2019-06-18 05:07:18');
INSERT INTO `ltm_translations` VALUES (175, 0, 'en', 'messages', 'timelogAlreadyExist', 'Time-log already exist for this user.', '2019-06-18 05:01:36', '2019-06-18 05:07:39');
INSERT INTO `ltm_translations` VALUES (176, 0, 'en', 'messages', 'timeLogUpdated', 'Time log updated successfully.', '2019-06-18 05:01:36', '2019-06-18 05:07:18');
INSERT INTO `ltm_translations` VALUES (177, 0, 'en', 'app', 'menu.messageSettings', 'Message Settings', '2019-06-18 05:01:36', '2019-06-18 05:06:41');
INSERT INTO `ltm_translations` VALUES (178, 0, 'en', 'app', 'menu.moduleSettings', 'Module Settings', '2019-06-18 05:01:36', '2019-06-18 05:06:38');
INSERT INTO `ltm_translations` VALUES (179, 0, 'en', 'messages', 'methodsAdded', 'Offline method added successfully.', '2019-06-18 05:01:36', '2019-06-18 05:07:20');
INSERT INTO `ltm_translations` VALUES (180, 0, 'en', 'messages', 'methodsUpdated', 'Offline method updated successfully.', '2019-06-18 05:01:36', '2019-06-18 05:07:20');
INSERT INTO `ltm_translations` VALUES (181, 0, 'en', 'messages', 'methodsDeleted', 'Offline method deleted successfully.', '2019-06-18 05:01:36', '2019-06-18 05:07:20');
INSERT INTO `ltm_translations` VALUES (182, 0, 'en', 'app', 'menu.accountSettings', 'Company Settings', '2019-06-18 05:01:36', '2019-06-18 05:06:38');
INSERT INTO `ltm_translations` VALUES (183, 0, 'en', 'app', 'menu.paymentGatewayCredential', 'Payment Credentials', '2019-06-18 05:01:37', '2019-06-18 05:06:38');
INSERT INTO `ltm_translations` VALUES (184, 0, 'en', 'app', 'menu.projectTemplateMember', 'Project Template Member', '2019-06-18 05:01:37', '2019-06-18 05:06:43');
INSERT INTO `ltm_translations` VALUES (185, 0, 'en', 'messages', 'templateMembersAddedSuccessfully', 'Template Members added successfully.', '2019-06-18 05:01:37', '2019-06-18 05:07:20');
INSERT INTO `ltm_translations` VALUES (186, 0, 'en', 'messages', 'templateMemberRemovedFromProject', 'Template Member removed from project successfully.', '2019-06-18 05:01:37', '2019-06-18 05:07:20');
INSERT INTO `ltm_translations` VALUES (187, 0, 'en', 'app', 'menu.projectTemplate', 'Project Template', '2019-06-18 05:01:37', '2019-06-18 05:06:43');
INSERT INTO `ltm_translations` VALUES (188, 0, 'en', 'modules', 'projectTemplate.projectUpdated', ' project details updated.', '2019-06-18 05:01:37', '2019-06-18 05:09:06');
INSERT INTO `ltm_translations` VALUES (189, 0, 'en', 'modules', 'projectTemplate.addMemberTitle', 'Add Template Members', '2019-06-18 05:01:37', '2019-06-18 05:09:06');
INSERT INTO `ltm_translations` VALUES (190, 0, 'en', 'app', 'menu.projectTemplateTask', 'Project Template Task', '2019-06-18 05:01:37', '2019-06-18 05:06:43');
INSERT INTO `ltm_translations` VALUES (191, 0, 'en', 'messages', 'templateTaskCreatedSuccessfully', 'Template Task created successfully.', '2019-06-18 05:01:37', '2019-06-18 05:07:20');
INSERT INTO `ltm_translations` VALUES (192, 0, 'en', 'messages', 'templateTaskUpdatedSuccessfully', 'Template Task updated successfully.', '2019-06-18 05:01:37', '2019-06-18 05:07:20');
INSERT INTO `ltm_translations` VALUES (193, 0, 'en', 'modules', 'proposal.action', 'Action', '2019-06-18 05:01:37', '2019-06-18 05:08:58');
INSERT INTO `ltm_translations` VALUES (194, 0, 'en', 'modules', 'proposal.download', 'Download', '2019-06-18 05:01:37', '2019-06-18 05:08:58');
INSERT INTO `ltm_translations` VALUES (195, 0, 'en', 'modules', 'proposal.edit', 'Edit', '2019-06-18 05:01:37', '2019-06-18 05:08:58');
INSERT INTO `ltm_translations` VALUES (196, 0, 'en', 'modules', 'proposal.delete', 'Delete', '2019-06-18 05:01:37', '2019-06-18 05:08:58');
INSERT INTO `ltm_translations` VALUES (197, 0, 'en', 'messages', 'proposalCreated', 'Proposal created successfully.', '2019-06-18 05:01:37', '2019-06-18 05:07:32');
INSERT INTO `ltm_translations` VALUES (198, 0, 'en', 'messages', 'proposalUpdated', 'Proposal updated successfully.', '2019-06-18 05:01:37', '2019-06-18 05:07:32');
INSERT INTO `ltm_translations` VALUES (199, 0, 'en', 'messages', 'proposalDeleted', 'Proposal deleted successfully.', '2019-06-18 05:01:37', '2019-06-18 05:07:33');
INSERT INTO `ltm_translations` VALUES (200, 0, 'en', 'app', 'menu.pushNotifications', 'Push Notifications', '2019-06-18 05:01:37', '2019-06-18 05:06:43');
INSERT INTO `ltm_translations` VALUES (201, 0, 'en', 'app', 'menu.slackSettings', 'Slack Settings', '2019-06-18 05:01:37', '2019-06-18 05:06:39');
INSERT INTO `ltm_translations` VALUES (202, 0, 'en', 'app', 'menu.storageSettings', 'Storage Settings', '2019-06-18 05:01:37', '2019-06-18 05:06:41');
INSERT INTO `ltm_translations` VALUES (203, 0, 'en', 'app', 'menu.taskReport', 'Task Report', '2019-06-18 05:01:37', '2019-06-18 05:06:37');
INSERT INTO `ltm_translations` VALUES (204, 0, 'en', 'app', 'task', 'Task', '2019-06-18 05:01:38', '2019-06-18 05:06:33');
INSERT INTO `ltm_translations` VALUES (205, 0, 'en', 'app', 'menu.settings', 'Settings', '2019-06-18 05:01:38', '2019-06-18 05:06:37');
INSERT INTO `ltm_translations` VALUES (206, 0, 'en', 'messages', 'taskSettingUpdateSuccess', NULL, '2019-06-18 05:01:38', '2019-06-18 05:01:38');
INSERT INTO `ltm_translations` VALUES (207, 0, 'en', 'messages', 'taxAdded', 'Tax added successfully.', '2019-06-18 05:01:38', '2019-06-18 05:07:31');
INSERT INTO `ltm_translations` VALUES (208, 0, 'en', 'app', 'menu.ticketAgents', 'Ticket Agents', '2019-06-18 05:01:38', '2019-06-18 05:06:39');
INSERT INTO `ltm_translations` VALUES (209, 0, 'en', 'messages', 'agentAddedSuccessfully', 'Agent added successfully.', '2019-06-18 05:01:38', '2019-06-18 05:07:25');
INSERT INTO `ltm_translations` VALUES (210, 0, 'en', 'messages', 'statusUpdatedSuccessfully', 'Status updated successfully.', '2019-06-18 05:01:38', '2019-06-18 05:07:25');
INSERT INTO `ltm_translations` VALUES (211, 0, 'en', 'messages', 'agentRemoveSuccess', 'Agent removed successfully.', '2019-06-18 05:01:38', '2019-06-18 05:07:25');
INSERT INTO `ltm_translations` VALUES (212, 0, 'en', 'app', 'menu.ticketChannel', 'Ticket Channel', '2019-06-18 05:01:38', '2019-06-18 05:06:39');
INSERT INTO `ltm_translations` VALUES (213, 0, 'en', 'messages', 'ticketChannelAddSuccess', 'Ticket channel added successfully.', '2019-06-18 05:01:38', '2019-06-18 05:07:26');
INSERT INTO `ltm_translations` VALUES (214, 0, 'en', 'messages', 'ticketChannelUpdateSuccess', 'Ticket channel updated successfully.', '2019-06-18 05:01:38', '2019-06-18 05:07:26');
INSERT INTO `ltm_translations` VALUES (215, 0, 'en', 'messages', 'ticketChannelDeleteSuccess', 'Ticket channel deleted successfully.', '2019-06-18 05:01:38', '2019-06-18 05:07:27');
INSERT INTO `ltm_translations` VALUES (216, 0, 'en', 'messages', 'groupAddedSuccess', 'Group added successfully.', '2019-06-18 05:01:38', '2019-06-18 05:07:25');
INSERT INTO `ltm_translations` VALUES (217, 0, 'en', 'messages', 'groupDeleteSuccess', 'Group deleted successfully.', '2019-06-18 05:01:38', '2019-06-18 05:07:26');
INSERT INTO `ltm_translations` VALUES (218, 0, 'en', 'app', 'menu.replyTemplates', 'Reply Templates', '2019-06-18 05:01:38', '2019-06-18 05:06:39');
INSERT INTO `ltm_translations` VALUES (219, 0, 'en', 'messages', 'templateAddSuccess', 'Template added successfully.', '2019-06-18 05:01:38', '2019-06-18 05:07:26');
INSERT INTO `ltm_translations` VALUES (220, 0, 'en', 'messages', 'templateUpdateSuccess', 'Template update success.', '2019-06-18 05:01:39', '2019-06-18 05:07:27');
INSERT INTO `ltm_translations` VALUES (221, 0, 'en', 'messages', 'templateDeleteSuccess', 'Template deleted successfully.', '2019-06-18 05:01:39', '2019-06-18 05:07:27');
INSERT INTO `ltm_translations` VALUES (222, 0, 'en', 'app', 'menu.ticketTypes', 'Ticket Types', '2019-06-18 05:01:39', '2019-06-18 05:06:39');
INSERT INTO `ltm_translations` VALUES (223, 0, 'en', 'messages', 'ticketTypeAddSuccess', 'Ticket type added successfully.', '2019-06-18 05:01:39', '2019-06-18 05:07:26');
INSERT INTO `ltm_translations` VALUES (224, 0, 'en', 'messages', 'ticketTypeUpdateSuccess', 'Ticket type updated successfully.', '2019-06-18 05:01:39', '2019-06-18 05:07:26');
INSERT INTO `ltm_translations` VALUES (225, 0, 'en', 'messages', 'ticketTypeDeleteSuccess', 'Ticket type deleted successfully.', '2019-06-18 05:01:39', '2019-06-18 05:07:26');
INSERT INTO `ltm_translations` VALUES (226, 0, 'en', 'app', 'menu.timeLogReport', 'Time Log Report', '2019-06-18 05:01:39', '2019-06-18 05:06:37');
INSERT INTO `ltm_translations` VALUES (227, 0, 'en', 'messages', 'issueCreated', 'Issue created successfully.', '2019-06-18 05:01:39', '2019-06-18 05:07:19');
INSERT INTO `ltm_translations` VALUES (228, 0, 'en', 'messages', 'issueUpdated', 'Issue updated successfully.', '2019-06-18 05:01:39', '2019-06-18 05:07:19');
INSERT INTO `ltm_translations` VALUES (229, 0, 'en', 'messages', 'issueDeleted', 'Issue deleted successfully.', '2019-06-18 05:01:39', '2019-06-18 05:07:19');
INSERT INTO `ltm_translations` VALUES (230, 0, 'en', 'messages', 'profileUpdated', 'Profile updated successfully.', '2019-06-18 05:01:39', '2019-06-18 05:07:18');
INSERT INTO `ltm_translations` VALUES (231, 0, 'en', 'modules', 'client.viewDetails', 'View Details', '2019-06-18 05:01:39', '2019-06-18 05:07:45');
INSERT INTO `ltm_translations` VALUES (232, 0, 'en', 'modules', 'timeLogs.startTimer', 'Start Timer', '2019-06-18 05:01:39', '2019-06-18 05:08:04');
INSERT INTO `ltm_translations` VALUES (233, 0, 'en', 'messages', 'notAnAuthorisedDevice', 'This is not an authorised device for clock-in or clock-out', '2019-06-18 05:01:40', '2019-06-18 05:07:21');
INSERT INTO `ltm_translations` VALUES (234, 0, 'en', 'messages', 'notAnValidLocation', 'This is not an valid location for clock-in or clock-out', '2019-06-18 05:01:40', '2019-06-18 05:07:21');
INSERT INTO `ltm_translations` VALUES (235, 0, 'en', 'messages', 'clientAdded', 'Client info added successfully.', '2019-06-18 05:01:40', '2019-06-18 05:07:15');
INSERT INTO `ltm_translations` VALUES (236, 0, 'en', 'messages', 'clientUpdated', 'Client info updated successfully.', '2019-06-18 05:01:40', '2019-06-18 05:07:16');
INSERT INTO `ltm_translations` VALUES (237, 0, 'en', 'messages', 'unAuthorisedUser', 'You are not authorised user.', '2019-06-18 05:01:40', '2019-06-18 05:07:10');
INSERT INTO `ltm_translations` VALUES (238, 0, 'en', 'messages', 'updatedProfile', 'Updated profile.', '2019-06-18 05:01:40', '2019-06-18 05:07:12');
INSERT INTO `ltm_translations` VALUES (239, 0, 'en', 'messages', 'taskUpdated', 'Marked the task as ', '2019-06-18 05:01:40', '2019-06-18 05:07:12');
INSERT INTO `ltm_translations` VALUES (240, 0, 'en', 'messages', 'sortDone', 'Sorting done.', '2019-06-18 05:01:40', '2019-06-18 05:07:35');
INSERT INTO `ltm_translations` VALUES (241, 0, 'en', 'messages', 'timerStartedTask', 'Started the timer for task ', '2019-06-18 05:01:40', '2019-06-18 05:07:34');
INSERT INTO `ltm_translations` VALUES (242, 0, 'en', 'messages', 'timerStartedBy', 'Timer started by', '2019-06-18 05:01:40', '2019-06-18 05:07:10');
INSERT INTO `ltm_translations` VALUES (243, 0, 'en', 'messages', 'timerStartedProject', 'Started the timer for project ', '2019-06-18 05:01:40', '2019-06-18 05:07:12');
INSERT INTO `ltm_translations` VALUES (244, 0, 'en', 'messages', 'timerStartedSuccessfully', 'Timer started successfully.', '2019-06-18 05:01:40', '2019-06-18 05:07:10');
INSERT INTO `ltm_translations` VALUES (245, 0, 'en', 'app', 'stop', 'Stop', '2019-06-18 05:01:40', '2019-06-18 05:06:33');
INSERT INTO `ltm_translations` VALUES (246, 0, 'en', 'messages', 'timerAlreadyRunning', 'Timer is already running.', '2019-06-18 05:01:40', '2019-06-18 05:07:36');
INSERT INTO `ltm_translations` VALUES (247, 0, 'en', 'messages', 'timerStoppedBy', 'Timer stopped by', '2019-06-18 05:01:40', '2019-06-18 05:07:10');
INSERT INTO `ltm_translations` VALUES (248, 0, 'en', 'messages', 'notificationRead', 'Notification marked as read.', '2019-06-18 05:01:40', '2019-06-18 05:07:30');
INSERT INTO `ltm_translations` VALUES (249, 0, 'en', 'app', 'superAdmin', 'Super Admin', '2019-06-18 05:01:40', '2019-06-18 05:07:02');
INSERT INTO `ltm_translations` VALUES (250, 0, 'en', 'messages', 'userDeleted', NULL, '2019-06-18 05:01:40', '2019-06-18 05:01:40');
INSERT INTO `ltm_translations` VALUES (251, 0, 'en', 'messages', 'uploadSuccess', 'Details updated successfully.', '2019-06-18 05:01:40', '2019-06-18 05:07:38');
INSERT INTO `ltm_translations` VALUES (252, 0, 'en', 'app', 'language', 'Language', '2019-06-18 05:01:40', '2019-06-18 05:06:55');
INSERT INTO `ltm_translations` VALUES (253, 0, 'en', 'app', 'menu.packages', 'Packages', '2019-06-18 05:01:41', '2019-06-18 05:06:45');
INSERT INTO `ltm_translations` VALUES (254, 0, 'en', 'app', 'package', 'Package', '2019-06-18 05:01:41', '2019-06-18 05:07:01');
INSERT INTO `ltm_translations` VALUES (255, 0, 'en', 'messages', 'superAdminUpdated', 'Super Admin info updated successfully.', '2019-06-18 05:01:41', '2019-06-18 05:07:21');
INSERT INTO `ltm_translations` VALUES (256, 0, 'en', 'app', 'menu.pushNotificationSetting', 'Push Notification Setting', '2019-06-18 05:01:41', '2019-06-18 05:06:45');
INSERT INTO `ltm_translations` VALUES (257, 0, 'en', 'app', 'menu.updates', 'Update Log', '2019-06-18 05:01:41', '2019-06-18 05:06:39');
INSERT INTO `ltm_translations` VALUES (258, 0, 'en', 'messages', 'databaseUpdated', 'Database update successfully.', '2019-06-18 05:01:41', '2019-06-18 05:07:25');
INSERT INTO `ltm_translations` VALUES (259, 0, 'en', 'messages', 'atleastOneValidation', 'Choose at-least 1', '2019-06-18 05:01:41', '2019-06-18 05:07:30');
INSERT INTO `ltm_translations` VALUES (260, 0, 'en', 'messages', 'chooseProject', 'Choose a project.', '2019-06-18 05:01:41', '2019-06-18 05:07:30');
INSERT INTO `ltm_translations` VALUES (261, 0, 'en', 'modules', 'tickets.groupName', 'Group Name', '2019-06-18 05:01:41', '2019-06-18 05:08:31');
INSERT INTO `ltm_translations` VALUES (262, 0, 'en', 'app', 'required', 'Required', '2019-06-18 05:01:41', '2019-06-18 05:06:48');
INSERT INTO `ltm_translations` VALUES (263, 0, 'en', 'modules', 'tickets.requesterName', 'Requester Name', '2019-06-18 05:01:41', '2019-06-18 05:08:32');
INSERT INTO `ltm_translations` VALUES (264, 0, 'en', 'email', 'planPurchase.subject', NULL, '2019-06-18 05:01:41', '2019-06-18 05:01:41');
INSERT INTO `ltm_translations` VALUES (265, 0, 'en', 'email', 'hello', 'Hello', '2019-06-18 05:01:41', '2019-06-18 05:07:03');
INSERT INTO `ltm_translations` VALUES (266, 0, 'en', 'email', 'loginDashboard', 'Login To Dashboard', '2019-06-18 05:01:41', '2019-06-18 05:07:03');
INSERT INTO `ltm_translations` VALUES (267, 0, 'en', 'email', 'thankyouNote', 'Thank you for using our application!', '2019-06-18 05:01:41', '2019-06-18 05:07:03');
INSERT INTO `ltm_translations` VALUES (268, 0, 'en', 'email', 'planUpdate.subject', 'Company updated plan.', '2019-06-18 05:01:41', '2019-06-18 05:07:06');
INSERT INTO `ltm_translations` VALUES (269, 0, 'en', 'email', 'newEvent.subject', 'New Event Created', '2019-06-18 05:01:41', '2019-06-18 05:07:03');
INSERT INTO `ltm_translations` VALUES (270, 0, 'en', 'email', 'newEvent.text', 'New event has been created. Download the attachment to add event to your calendar.', '2019-06-18 05:01:41', '2019-06-18 05:07:03');
INSERT INTO `ltm_translations` VALUES (271, 0, 'en', 'email', 'leave.applied', 'Leave application applied.', '2019-06-18 05:01:41', '2019-06-18 05:07:06');
INSERT INTO `ltm_translations` VALUES (272, 0, 'en', 'app', 'date', 'Date', '2019-06-18 05:01:41', '2019-06-18 05:06:33');
INSERT INTO `ltm_translations` VALUES (273, 0, 'en', 'email', 'leaves.statusSubject', 'Leave application status updated', '2019-06-18 05:01:41', '2019-06-18 05:07:05');
INSERT INTO `ltm_translations` VALUES (274, 0, 'en', 'email', 'leave.approve', 'Leave application approved.', '2019-06-18 05:01:42', '2019-06-18 05:07:06');
INSERT INTO `ltm_translations` VALUES (275, 0, 'en', 'email', 'leave.reject', 'Leave application rejected.', '2019-06-18 05:01:42', '2019-06-18 05:07:06');
INSERT INTO `ltm_translations` VALUES (276, 0, 'en', 'app', 'reason', 'Reason', '2019-06-18 05:01:42', '2019-06-18 05:06:57');
INSERT INTO `ltm_translations` VALUES (277, 0, 'en', 'email', 'licenseExpire.subject', 'Company Licence expired.', '2019-06-18 05:01:42', '2019-06-18 05:07:07');
INSERT INTO `ltm_translations` VALUES (278, 0, 'en', 'email', 'licenseExpire.text', 'Your company license has been expired. Please check billing details.', '2019-06-18 05:01:42', '2019-06-18 05:07:07');
INSERT INTO `ltm_translations` VALUES (279, 0, 'en', 'email', 'licenseExpirePre.subject', 'Company license Expiring soon.', '2019-06-18 05:01:42', '2019-06-18 05:07:07');
INSERT INTO `ltm_translations` VALUES (280, 0, 'en', 'email', 'licenseExpirePre.text', 'Your company license is expiring soon Please check billing details.', '2019-06-18 05:01:42', '2019-06-18 05:07:07');
INSERT INTO `ltm_translations` VALUES (281, 0, 'en', 'email', 'newClientTask.subject', 'New Task Generated', '2019-06-18 05:01:42', '2019-06-18 05:07:06');
INSERT INTO `ltm_translations` VALUES (282, 0, 'en', 'email', 'newTask.subject', 'New Task Assigned to You', '2019-06-18 05:01:42', '2019-06-18 05:07:05');
INSERT INTO `ltm_translations` VALUES (283, 0, 'en', 'email', 'newCompany.subject', 'New company registered', '2019-06-18 05:01:42', '2019-06-18 05:07:06');
INSERT INTO `ltm_translations` VALUES (284, 0, 'en', 'email', 'newCompany.text', 'New company has been registered.', '2019-06-18 05:01:42', '2019-06-18 05:07:06');
INSERT INTO `ltm_translations` VALUES (285, 0, 'en', 'email', 'newExpense.subject', 'New Expense added', '2019-06-18 05:01:42', '2019-06-18 05:07:04');
INSERT INTO `ltm_translations` VALUES (286, 0, 'en', 'email', 'expenseStatus.subject', 'Expense status updated', '2019-06-18 05:01:42', '2019-06-18 05:07:04');
INSERT INTO `ltm_translations` VALUES (287, 0, 'en', 'email', 'expenseStatus.text', 'Your expense status updated to', '2019-06-18 05:01:42', '2019-06-18 05:07:04');
INSERT INTO `ltm_translations` VALUES (288, 0, 'en', 'email', 'leaves.subject', 'New leave request received', '2019-06-18 05:01:42', '2019-06-18 05:07:05');
INSERT INTO `ltm_translations` VALUES (289, 0, 'en', 'email', 'newNotice.subject', 'New Notice Published', '2019-06-18 05:01:42', '2019-06-18 05:07:04');
INSERT INTO `ltm_translations` VALUES (290, 0, 'en', 'email', 'newNotice.text', 'New notice has been published. Login to view the notice.', '2019-06-18 05:01:42', '2019-06-18 05:07:05');
INSERT INTO `ltm_translations` VALUES (291, 0, 'en', 'email', 'newProjectMember.subject', 'New Project Assigned', '2019-06-18 05:01:42', '2019-06-18 05:07:05');
INSERT INTO `ltm_translations` VALUES (292, 0, 'en', 'email', 'newProjectMember.text', 'You have been added as a member to the project', '2019-06-18 05:01:42', '2019-06-18 05:07:05');
INSERT INTO `ltm_translations` VALUES (293, 0, 'en', 'email', 'newTicket.subject', 'New Support Ticket Requested', '2019-06-18 05:01:42', '2019-06-18 05:07:05');
INSERT INTO `ltm_translations` VALUES (294, 0, 'en', 'email', 'newTicket.text', 'New Support Ticket is requested. Login to view the ticket.', '2019-06-18 05:01:42', '2019-06-18 05:07:05');
INSERT INTO `ltm_translations` VALUES (295, 0, 'en', 'email', 'newUser.subject', 'Welcome to', '2019-06-18 05:01:42', '2019-06-18 05:07:05');
INSERT INTO `ltm_translations` VALUES (296, 0, 'en', 'email', 'newUser.text', 'Your account has been created successfully.', '2019-06-18 05:01:42', '2019-06-18 05:07:05');
INSERT INTO `ltm_translations` VALUES (297, 0, 'en', 'email', 'taskComplete.subject', 'Task marked as complete', '2019-06-18 05:01:43', '2019-06-18 05:07:05');
INSERT INTO `ltm_translations` VALUES (298, 0, 'en', 'email', 'reminder.subject', 'Reminder for assigned task', '2019-06-18 05:01:43', '2019-06-18 05:07:06');
INSERT INTO `ltm_translations` VALUES (299, 0, 'en', 'email', 'taskUpdate.subject', 'Task updated', '2019-06-18 05:01:43', '2019-06-18 05:07:06');
INSERT INTO `ltm_translations` VALUES (300, 0, 'en', 'modules', 'permission.projectNote', 'User can view the basic details of projects assigned to him even without any permission.', '2019-06-18 05:01:43', '2019-06-18 05:08:43');
INSERT INTO `ltm_translations` VALUES (301, 0, 'en', 'modules', 'permission.attendanceNote', 'User can view his own attendance even without any permission.', '2019-06-18 05:01:43', '2019-06-18 05:08:44');
INSERT INTO `ltm_translations` VALUES (302, 0, 'en', 'modules', 'permission.taskNote', 'User can view the tasks assigned to him even without any permission.', '2019-06-18 05:01:43', '2019-06-18 05:08:44');
INSERT INTO `ltm_translations` VALUES (303, 0, 'en', 'modules', 'permission.ticketNote', 'User can view the tickets generated by him as default even without any permission.', '2019-06-18 05:01:43', '2019-06-18 05:08:44');
INSERT INTO `ltm_translations` VALUES (304, 0, 'en', 'modules', 'permission.eventNote', 'User can view the events to be attended by him as default even without any permission.', '2019-06-18 05:01:43', '2019-06-18 05:08:44');
INSERT INTO `ltm_translations` VALUES (305, 0, 'en', 'modules', 'permission.holidayNote', 'User can view the holidays as default even without any permission.', '2019-06-18 05:01:43', '2019-06-18 05:08:44');
INSERT INTO `ltm_translations` VALUES (306, 0, 'en', 'app', 'yes', 'Yes', '2019-06-18 05:01:43', '2019-06-18 05:06:47');
INSERT INTO `ltm_translations` VALUES (307, 0, 'en', 'app', 'no', 'No', '2019-06-18 05:01:43', '2019-06-18 05:06:47');
INSERT INTO `ltm_translations` VALUES (308, 0, 'en', 'modules', 'attendance.present', 'Present', '2019-06-18 05:01:43', '2019-06-18 05:08:37');
INSERT INTO `ltm_translations` VALUES (309, 0, 'en', 'modules', 'attendance.absent', 'Absent', '2019-06-18 05:01:43', '2019-06-18 05:08:37');
INSERT INTO `ltm_translations` VALUES (310, 0, 'en', 'app', 'save', 'Save', '2019-06-18 05:01:43', '2019-06-18 05:06:31');
INSERT INTO `ltm_translations` VALUES (311, 0, 'en', 'modules', 'attendance.holidayfor', 'Holiday for', '2019-06-18 05:01:43', '2019-06-18 05:08:38');
INSERT INTO `ltm_translations` VALUES (312, 0, 'en', 'messages', 'noRecordFound', 'No record found.', '2019-06-18 05:01:43', '2019-06-18 05:07:30');
INSERT INTO `ltm_translations` VALUES (313, 0, 'en', 'app', 'datatable', '//cdn.datatables.net/plug-ins/1.10.15/i18n/English.json', '2019-06-18 05:01:43', '2019-06-18 05:06:46');
INSERT INTO `ltm_translations` VALUES (314, 0, 'en', 'modules', 'attendance.attendanceDetail', 'Attendance Detail', '2019-06-18 05:01:43', '2019-06-18 05:08:39');
INSERT INTO `ltm_translations` VALUES (315, 0, 'en', 'modules', 'attendance.late', 'Late', '2019-06-18 05:01:43', '2019-06-18 05:08:36');
INSERT INTO `ltm_translations` VALUES (316, 0, 'en', 'modules', 'attendance.holidays', 'Holidays', '2019-06-18 05:01:43', '2019-06-18 05:08:38');
INSERT INTO `ltm_translations` VALUES (317, 0, 'en', 'app', 'apply', 'Apply', '2019-06-18 05:01:43', '2019-06-18 05:06:34');
INSERT INTO `ltm_translations` VALUES (318, 0, 'en', 'app', 'cancel', 'Cancel', '2019-06-18 05:01:43', '2019-06-18 05:06:50');
INSERT INTO `ltm_translations` VALUES (319, 0, 'en', 'app', 'su', 'Su', '2019-06-18 05:01:43', '2019-06-18 05:06:53');
INSERT INTO `ltm_translations` VALUES (320, 0, 'en', 'app', 'mo', 'Mo', '2019-06-18 05:01:43', '2019-06-18 05:06:52');
INSERT INTO `ltm_translations` VALUES (321, 0, 'en', 'app', 'tu', 'Tu', '2019-06-18 05:01:44', '2019-06-18 05:06:52');
INSERT INTO `ltm_translations` VALUES (322, 0, 'en', 'app', 'we', 'We', '2019-06-18 05:01:44', '2019-06-18 05:06:52');
INSERT INTO `ltm_translations` VALUES (323, 0, 'en', 'app', 'th', 'Th', '2019-06-18 05:01:44', '2019-06-18 05:06:52');
INSERT INTO `ltm_translations` VALUES (324, 0, 'en', 'app', 'fr', 'Fr', '2019-06-18 05:01:44', '2019-06-18 05:06:52');
INSERT INTO `ltm_translations` VALUES (325, 0, 'en', 'app', 'sa', 'Sa', '2019-06-18 05:01:44', '2019-06-18 05:06:52');
INSERT INTO `ltm_translations` VALUES (326, 0, 'en', 'app', 'january', 'January', '2019-06-18 05:01:44', '2019-06-18 05:06:50');
INSERT INTO `ltm_translations` VALUES (327, 0, 'en', 'app', 'february', 'February', '2019-06-18 05:01:44', '2019-06-18 05:06:50');
INSERT INTO `ltm_translations` VALUES (328, 0, 'en', 'app', 'march', 'March', '2019-06-18 05:01:44', '2019-06-18 05:06:50');
INSERT INTO `ltm_translations` VALUES (329, 0, 'en', 'app', 'april', 'April', '2019-06-18 05:01:44', '2019-06-18 05:06:50');
INSERT INTO `ltm_translations` VALUES (330, 0, 'en', 'app', 'may', 'May', '2019-06-18 05:01:44', '2019-06-18 05:06:50');
INSERT INTO `ltm_translations` VALUES (331, 0, 'en', 'app', 'june', 'June', '2019-06-18 05:01:44', '2019-06-18 05:06:50');
INSERT INTO `ltm_translations` VALUES (332, 0, 'en', 'app', 'july', 'July', '2019-06-18 05:01:44', '2019-06-18 05:06:51');
INSERT INTO `ltm_translations` VALUES (333, 0, 'en', 'app', 'august', 'August', '2019-06-18 05:01:44', '2019-06-18 05:06:51');
INSERT INTO `ltm_translations` VALUES (334, 0, 'en', 'app', 'september', 'September', '2019-06-18 05:01:44', '2019-06-18 05:06:51');
INSERT INTO `ltm_translations` VALUES (335, 0, 'en', 'app', 'october', 'October', '2019-06-18 05:01:44', '2019-06-18 05:06:51');
INSERT INTO `ltm_translations` VALUES (336, 0, 'en', 'app', 'november', 'November', '2019-06-18 05:01:44', '2019-06-18 05:06:51');
INSERT INTO `ltm_translations` VALUES (337, 0, 'en', 'app', 'december', 'December', '2019-06-18 05:01:44', '2019-06-18 05:06:51');
INSERT INTO `ltm_translations` VALUES (338, 0, 'en', 'modules', 'attendance.leaveFor', 'Leave for', '2019-06-18 05:01:44', '2019-06-18 05:08:40');
INSERT INTO `ltm_translations` VALUES (339, 0, 'en', 'modules', 'attendance.ipAddress', 'IP Address', '2019-06-18 05:01:44', '2019-06-18 05:08:40');
INSERT INTO `ltm_translations` VALUES (340, 0, 'en', 'app', 'update', 'Update', '2019-06-18 05:01:44', '2019-06-18 05:06:31');
INSERT INTO `ltm_translations` VALUES (341, 0, 'en', 'modules', 'invoices.payPaypal', 'Pay via Paypal', '2019-06-18 05:01:44', '2019-06-18 05:07:59');
INSERT INTO `ltm_translations` VALUES (342, 0, 'en', 'modules', 'invoices.payStripe', 'Pay via Stripe', '2019-06-18 05:01:45', '2019-06-18 05:08:01');
INSERT INTO `ltm_translations` VALUES (343, 0, 'en', 'modules', 'contacts.addContact', 'Add Contact', '2019-06-18 05:01:45', '2019-06-18 05:07:46');
INSERT INTO `ltm_translations` VALUES (344, 0, 'en', 'modules', 'client.createTitle', 'Add Client Info', '2019-06-18 05:01:45', '2019-06-18 05:07:43');
INSERT INTO `ltm_translations` VALUES (345, 0, 'en', 'modules', 'client.passwordNote', 'Client will login using this password.', '2019-06-18 05:01:45', '2019-06-18 05:07:44');
INSERT INTO `ltm_translations` VALUES (346, 0, 'en', 'modules', 'client.updateTitle', 'Update Client Info', '2019-06-18 05:01:45', '2019-06-18 05:07:45');
INSERT INTO `ltm_translations` VALUES (347, 0, 'en', 'modules', 'client.passwordUpdateNote', 'Client will login using this password. (Leave blank to keep current password)', '2019-06-18 05:01:45', '2019-06-18 05:07:45');
INSERT INTO `ltm_translations` VALUES (348, 0, 'en', 'app', 'filterResults', 'Filter Results', '2019-06-18 05:01:45', '2019-06-18 05:06:34');
INSERT INTO `ltm_translations` VALUES (349, 0, 'en', 'app', 'exportExcel', 'Export To Excel', '2019-06-18 05:01:45', '2019-06-18 05:06:46');
INSERT INTO `ltm_translations` VALUES (350, 0, 'en', 'app', 'startDate', 'Start Date', '2019-06-18 05:01:45', '2019-06-18 05:06:58');
INSERT INTO `ltm_translations` VALUES (351, 0, 'en', 'app', 'endDate', 'End Date', '2019-06-18 05:01:45', '2019-06-18 05:06:59');
INSERT INTO `ltm_translations` VALUES (352, 0, 'en', 'app', 'reset', 'Reset', '2019-06-18 05:01:45', '2019-06-18 05:06:31');
INSERT INTO `ltm_translations` VALUES (353, 0, 'en', 'modules', 'currencySettings.exchangeRate', 'Exchange Rate', '2019-06-18 05:01:45', '2019-06-18 05:08:20');
INSERT INTO `ltm_translations` VALUES (354, 0, 'en', 'messages', 'exchangeRateNote', 'Exchange rate is calculated from your default currency. Change default currency in company settings.', '2019-06-18 05:01:45', '2019-06-18 05:07:24');
INSERT INTO `ltm_translations` VALUES (355, 0, 'en', 'modules', 'customFields.addField', 'Add Field', '2019-06-18 05:01:45', '2019-06-18 05:08:41');
INSERT INTO `ltm_translations` VALUES (356, 0, 'en', 'modules', 'dashboard.totalClients', 'Total Clients', '2019-06-18 05:01:45', '2019-06-18 05:07:39');
INSERT INTO `ltm_translations` VALUES (357, 0, 'en', 'modules', 'dashboard.totalEmployees', 'Total Employees', '2019-06-18 05:01:45', '2019-06-18 05:07:40');
INSERT INTO `ltm_translations` VALUES (358, 0, 'en', 'modules', 'dashboard.totalProjects', 'Total Projects', '2019-06-18 05:01:45', '2019-06-18 05:07:40');
INSERT INTO `ltm_translations` VALUES (359, 0, 'en', 'modules', 'dashboard.totalUnpaidInvoices', 'Unpaid Invoices', '2019-06-18 05:01:45', '2019-06-18 05:07:42');
INSERT INTO `ltm_translations` VALUES (360, 0, 'en', 'modules', 'dashboard.totalHoursLogged', 'Hours Logged', '2019-06-18 05:01:45', '2019-06-18 05:07:40');
INSERT INTO `ltm_translations` VALUES (361, 0, 'en', 'modules', 'dashboard.totalPendingTasks', 'Pending Tasks', '2019-06-18 05:01:45', '2019-06-18 05:07:40');
INSERT INTO `ltm_translations` VALUES (362, 0, 'en', 'modules', 'dashboard.totalCompletedTasks', 'Completed Tasks', '2019-06-18 05:01:45', '2019-06-18 05:07:40');
INSERT INTO `ltm_translations` VALUES (363, 0, 'en', 'modules', 'dashboard.totalTodayAttendance', 'Today Attendance', '2019-06-18 05:01:45', '2019-06-18 05:07:42');
INSERT INTO `ltm_translations` VALUES (364, 0, 'en', 'modules', 'tickets.totalResolvedTickets', 'Resolved Tickets', '2019-06-18 05:01:46', '2019-06-18 05:08:34');
INSERT INTO `ltm_translations` VALUES (365, 0, 'en', 'modules', 'tickets.totalUnresolvedTickets', 'Unresolved Tickets', '2019-06-18 05:01:46', '2019-06-18 05:08:35');
INSERT INTO `ltm_translations` VALUES (366, 0, 'en', 'modules', 'dashboard.weatherSetLocation', 'Set current location to see weather', '2019-06-18 05:01:46', '2019-06-18 05:07:41');
INSERT INTO `ltm_translations` VALUES (367, 0, 'en', 'messages', 'earningChartNote', 'The earnings are mentioned in your base currency. You can change it here.', '2019-06-18 05:01:46', '2019-06-18 05:07:10');
INSERT INTO `ltm_translations` VALUES (368, 0, 'en', 'messages', 'noTicketFound', 'No ticket found.', '2019-06-18 05:01:46', '2019-06-18 05:07:29');
INSERT INTO `ltm_translations` VALUES (369, 0, 'en', 'messages', 'noOpenTasks', 'No open tasks.', '2019-06-18 05:01:46', '2019-06-18 05:07:12');
INSERT INTO `ltm_translations` VALUES (370, 0, 'en', 'messages', 'noPendingLeadFollowUps', 'No pending follow-up.', '2019-06-18 05:01:46', '2019-06-18 05:07:33');
INSERT INTO `ltm_translations` VALUES (371, 0, 'en', 'modules', 'emailSettings.notificationSubtitle', 'Select the events for which an email should be sent to user.', '2019-06-18 05:01:46', '2019-06-18 05:08:13');
INSERT INTO `ltm_translations` VALUES (372, 0, 'en', 'modules', 'employees.createTitle', 'Add Employee Info', '2019-06-18 05:01:46', '2019-06-18 05:07:46');
INSERT INTO `ltm_translations` VALUES (373, 0, 'en', 'modules', 'employees.passwordNote', 'Employee will login using this password.', '2019-06-18 05:01:46', '2019-06-18 05:07:47');
INSERT INTO `ltm_translations` VALUES (374, 0, 'en', 'modules', 'employees.slackUsername', 'Slack Username', '2019-06-18 05:01:46', '2019-06-18 05:07:48');
INSERT INTO `ltm_translations` VALUES (375, 0, 'en', 'app', 'skills', 'Skills', '2019-06-18 05:01:46', '2019-06-18 05:06:59');
INSERT INTO `ltm_translations` VALUES (376, 0, 'en', 'modules', 'profile.uploadPicture', 'Upload your picture', '2019-06-18 05:01:46', '2019-06-18 05:08:13');
INSERT INTO `ltm_translations` VALUES (377, 0, 'en', 'app', 'selectImage', 'Select Image', '2019-06-18 05:01:46', '2019-06-18 05:06:34');
INSERT INTO `ltm_translations` VALUES (378, 0, 'en', 'app', 'change', 'Change', '2019-06-18 05:01:46', '2019-06-18 05:06:34');
INSERT INTO `ltm_translations` VALUES (379, 0, 'en', 'app', 'remove', 'Remove', '2019-06-18 05:01:46', '2019-06-18 05:06:33');
INSERT INTO `ltm_translations` VALUES (380, 0, 'en', 'messages', 'employeeDocsAllowedFormat', 'Allowed file formats: jpg, png, gif, doc, docx, xls, xlsx, pdf, txt.', '2019-06-18 05:01:47', '2019-06-18 05:07:21');
INSERT INTO `ltm_translations` VALUES (381, 0, 'en', 'modules', 'employees.updateTitle', 'update Employee Info', '2019-06-18 05:01:47', '2019-06-18 05:07:48');
INSERT INTO `ltm_translations` VALUES (382, 0, 'en', 'modules', 'employees.updatePasswordNote', 'Employee will login using this password. (Leave blank to keep current password)', '2019-06-18 05:01:47', '2019-06-18 05:07:48');
INSERT INTO `ltm_translations` VALUES (383, 0, 'en', 'modules', 'dashboard.freeEmployees', 'Not working on project', '2019-06-18 05:01:47', '2019-06-18 05:07:43');
INSERT INTO `ltm_translations` VALUES (384, 0, 'en', 'app', 'all', 'All', '2019-06-18 05:01:47', '2019-06-18 05:06:58');
INSERT INTO `ltm_translations` VALUES (385, 0, 'en', 'app', 'add', 'Add', '2019-06-18 05:01:47', '2019-06-18 05:06:48');
INSERT INTO `ltm_translations` VALUES (386, 0, 'en', 'modules', 'estimates.createEstimate', 'Create Estimate', '2019-06-18 05:01:47', '2019-06-18 05:08:23');
INSERT INTO `ltm_translations` VALUES (387, 0, 'en', 'modules', 'invoices.item', 'Item', '2019-06-18 05:01:47', '2019-06-18 05:07:57');
INSERT INTO `ltm_translations` VALUES (388, 0, 'en', 'modules', 'invoices.type', 'Type', '2019-06-18 05:01:47', '2019-06-18 05:07:59');
INSERT INTO `ltm_translations` VALUES (389, 0, 'en', 'modules', 'invoices.qty', 'Qty/Hrs', '2019-06-18 05:01:47', '2019-06-18 05:07:57');
INSERT INTO `ltm_translations` VALUES (390, 0, 'en', 'modules', 'invoices.unitPrice', 'Unit Price', '2019-06-18 05:01:47', '2019-06-18 05:07:57');
INSERT INTO `ltm_translations` VALUES (391, 0, 'en', 'modules', 'invoices.amount', 'Amount', '2019-06-18 05:01:47', '2019-06-18 05:07:57');
INSERT INTO `ltm_translations` VALUES (392, 0, 'en', 'modules', 'invoices.addItem', 'Add Item', '2019-06-18 05:01:48', '2019-06-18 05:07:57');
INSERT INTO `ltm_translations` VALUES (393, 0, 'en', 'modules', 'invoices.discount', 'Discount', '2019-06-18 05:01:48', '2019-06-18 05:07:58');
INSERT INTO `ltm_translations` VALUES (394, 0, 'en', 'modules', 'invoices.tax', 'Tax', '2019-06-18 05:01:48', '2019-06-18 05:07:58');
INSERT INTO `ltm_translations` VALUES (395, 0, 'en', 'modules', 'estimates.updateEstimate', 'Update Estimate', '2019-06-18 05:01:48', '2019-06-18 05:08:24');
INSERT INTO `ltm_translations` VALUES (396, 0, 'en', 'app', 'note', 'Note', '2019-06-18 05:01:48', '2019-06-18 05:06:30');
INSERT INTO `ltm_translations` VALUES (397, 0, 'en', 'app', 'edit', 'Edit', '2019-06-18 05:01:48', '2019-06-18 05:06:31');
INSERT INTO `ltm_translations` VALUES (398, 0, 'en', 'modules', 'events.viewAttendees', 'View Attendees', '2019-06-18 05:01:48', '2019-06-18 05:08:42');
INSERT INTO `ltm_translations` VALUES (399, 0, 'en', 'modules', 'events.addEvent', 'Add Event', '2019-06-18 05:01:48', '2019-06-18 05:08:41');
INSERT INTO `ltm_translations` VALUES (400, 0, 'en', 'modules', 'messages.chooseMember', 'Choose Member', '2019-06-18 05:01:48', '2019-06-18 05:08:20');
INSERT INTO `ltm_translations` VALUES (401, 0, 'en', 'modules', 'projects.selectClient', 'Select Client', '2019-06-18 05:01:48', '2019-06-18 05:07:49');
INSERT INTO `ltm_translations` VALUES (402, 0, 'en', 'app', 'details', 'Details', '2019-06-18 05:01:48', '2019-06-18 05:06:33');
INSERT INTO `ltm_translations` VALUES (403, 0, 'en', 'modules', 'expenses.addExpense', 'Add Expense', '2019-06-18 05:01:48', '2019-06-18 05:08:26');
INSERT INTO `ltm_translations` VALUES (404, 0, 'en', 'modules', 'expenses.updateExpense', 'Update Expense', '2019-06-18 05:01:48', '2019-06-18 05:08:27');
INSERT INTO `ltm_translations` VALUES (405, 0, 'en', 'modules', 'holiday.title', 'Holiday', '2019-06-18 05:01:48', '2019-06-18 05:09:00');
INSERT INTO `ltm_translations` VALUES (406, 0, 'en', 'app', 'year', 'Year', '2019-06-18 05:01:48', '2019-06-18 05:06:47');
INSERT INTO `ltm_translations` VALUES (407, 0, 'en', 'app', 'menu.holiday', 'Holiday', '2019-06-18 05:01:48', '2019-06-18 05:06:42');
INSERT INTO `ltm_translations` VALUES (408, 0, 'en', 'modules', 'holiday.occasion', 'Occasion', '2019-06-18 05:01:48', '2019-06-18 05:09:01');
INSERT INTO `ltm_translations` VALUES (409, 0, 'en', 'app', 'day', 'Day', '2019-06-18 05:01:48', '2019-06-18 05:06:48');
INSERT INTO `ltm_translations` VALUES (410, 0, 'en', 'app', 'action', 'Action', '2019-06-18 05:01:48', '2019-06-18 05:06:32');
INSERT INTO `ltm_translations` VALUES (411, 0, 'en', 'modules', 'holiday.listOf', 'List Of', '2019-06-18 05:01:49', '2019-06-18 05:09:01');
INSERT INTO `ltm_translations` VALUES (412, 0, 'en', 'modules', 'holiday.markSunday', ' Mark Default Holidays', '2019-06-18 05:01:49', '2019-06-18 05:09:00');
INSERT INTO `ltm_translations` VALUES (413, 0, 'en', 'modules', 'holiday.markHoliday', 'Mark Holiday', '2019-06-18 05:01:49', '2019-06-18 05:09:01');
INSERT INTO `ltm_translations` VALUES (414, 0, 'en', 'modules', 'estimates.convertEstimateTitle', 'Convert Estimate To Invoice', '2019-06-18 05:01:49', '2019-06-18 05:08:24');
INSERT INTO `ltm_translations` VALUES (415, 0, 'en', 'modules', 'proposal.convertProposalTitle', 'Convert Proposal To Invoice', '2019-06-18 05:01:49', '2019-06-18 05:08:58');
INSERT INTO `ltm_translations` VALUES (416, 0, 'en', 'modules', 'invoices.addInvoice', 'Add Invoice', '2019-06-18 05:01:49', '2019-06-18 05:07:56');
INSERT INTO `ltm_translations` VALUES (417, 0, 'en', 'app', 'invoice', 'Invoice', '2019-06-18 05:01:49', '2019-06-18 05:06:33');
INSERT INTO `ltm_translations` VALUES (418, 0, 'en', 'modules', 'projects.dropFile', 'Drop files here OR click to upload', '2019-06-18 05:01:49', '2019-06-18 05:07:52');
INSERT INTO `ltm_translations` VALUES (419, 0, 'en', 'app', 'gstIn', 'GSTIN', '2019-06-18 05:01:49', '2019-06-18 05:07:01');
INSERT INTO `ltm_translations` VALUES (420, 0, 'en', 'modules', 'payments.paymentDetails', 'Payment details', '2019-06-18 05:01:49', '2019-06-18 05:08:26');
INSERT INTO `ltm_translations` VALUES (421, 0, 'en', 'modules', 'invoices.downloadPdf', 'Download Pdf', '2019-06-18 05:01:49', '2019-06-18 05:07:59');
INSERT INTO `ltm_translations` VALUES (422, 0, 'en', 'modules', 'lead.createTitle', 'Add Lead Info', '2019-06-18 05:01:49', '2019-06-18 05:08:51');
INSERT INTO `ltm_translations` VALUES (423, 0, 'en', 'modules', 'lead.updateTitle', 'Update Lead Info', '2019-06-18 05:01:49', '2019-06-18 05:08:53');
INSERT INTO `ltm_translations` VALUES (424, 0, 'en', 'modules', 'followup.updateFollow', 'Update Follow Up', '2019-06-18 05:01:49', '2019-06-18 05:08:58');
INSERT INTO `ltm_translations` VALUES (425, 0, 'en', 'modules', 'followup.newFollowUp', 'New Follow Up', '2019-06-18 05:01:49', '2019-06-18 05:08:58');
INSERT INTO `ltm_translations` VALUES (426, 0, 'en', 'app', 'remark', 'Remark', '2019-06-18 05:01:49', '2019-06-18 05:06:57');
INSERT INTO `ltm_translations` VALUES (427, 0, 'en', 'app', 'next_follow_up', 'Next Follow Up', '2019-06-18 05:01:49', '2019-06-18 05:06:56');
INSERT INTO `ltm_translations` VALUES (428, 0, 'en', 'modules', 'followup.followUpNote', 'Follow up add and edit functionality will work when lead <b>next follow up</b> will <b>YES</b>.', '2019-06-18 05:01:49', '2019-06-18 05:09:00');
INSERT INTO `ltm_translations` VALUES (429, 0, 'en', 'modules', 'lead.leadFollowUp', 'Follow Up Next', '2019-06-18 05:01:49', '2019-06-18 05:08:53');
INSERT INTO `ltm_translations` VALUES (430, 0, 'en', 'app', 'close', 'Close', '2019-06-18 05:01:49', '2019-06-18 05:06:48');
INSERT INTO `ltm_translations` VALUES (431, 0, 'en', 'messages', 'noFileUploaded', 'You have not uploaded any file.', '2019-06-18 05:01:50', '2019-06-18 05:07:13');
INSERT INTO `ltm_translations` VALUES (432, 0, 'en', 'modules', 'projects.uploadFile', 'Upload File', '2019-06-18 05:01:50', '2019-06-18 05:07:52');
INSERT INTO `ltm_translations` VALUES (433, 0, 'en', 'modules', 'lead.leadSource', 'Lead Source', '2019-06-18 05:01:50', '2019-06-18 05:08:53');
INSERT INTO `ltm_translations` VALUES (434, 0, 'en', 'messages', 'noLeadSourceAdded', 'No lead source added.', '2019-06-18 05:01:50', '2019-06-18 05:07:31');
INSERT INTO `ltm_translations` VALUES (435, 0, 'en', 'modules', 'lead.leadStatus', 'Lead Status', '2019-06-18 05:01:50', '2019-06-18 05:08:53');
INSERT INTO `ltm_translations` VALUES (436, 0, 'en', 'messages', 'noLeadStatusAdded', 'No lead status added.', '2019-06-18 05:01:50', '2019-06-18 05:07:32');
INSERT INTO `ltm_translations` VALUES (437, 0, 'en', 'modules', 'leaves.assignLeave', 'Assign Leave', '2019-06-18 05:01:50', '2019-06-18 05:08:45');
INSERT INTO `ltm_translations` VALUES (438, 0, 'en', 'modules', 'leaves.addLeaveType', 'Add Leave Type', '2019-06-18 05:01:50', '2019-06-18 05:08:45');
INSERT INTO `ltm_translations` VALUES (439, 0, 'en', 'messages', 'selectMultipleDates', 'You can select multiple dates.', '2019-06-18 05:01:50', '2019-06-18 05:07:29');
INSERT INTO `ltm_translations` VALUES (440, 0, 'en', 'app', 'accept', 'Accept', '2019-06-18 05:01:50', '2019-06-18 05:06:49');
INSERT INTO `ltm_translations` VALUES (441, 0, 'en', 'app', 'reject', 'Reject', '2019-06-18 05:01:50', '2019-06-18 05:06:49');
INSERT INTO `ltm_translations` VALUES (442, 0, 'en', 'messages', 'noPendingLeaves', 'No pending leaves remaining.', '2019-06-18 05:01:50', '2019-06-18 05:07:30');
INSERT INTO `ltm_translations` VALUES (443, 0, 'en', 'app', 'optional', 'Optional', '2019-06-18 05:01:50', '2019-06-18 05:06:55');
INSERT INTO `ltm_translations` VALUES (444, 0, 'en', 'modules', 'leaves.leaveType', 'Leave Type', '2019-06-18 05:01:50', '2019-06-18 05:08:45');
INSERT INTO `ltm_translations` VALUES (445, 0, 'en', 'modules', 'sticky.colors', 'Color', '2019-06-18 05:01:50', '2019-06-18 05:08:06');
INSERT INTO `ltm_translations` VALUES (446, 0, 'en', 'messages', 'logTimeNote', 'Log time setting will update on select.', '2019-06-18 05:01:50', '2019-06-18 05:07:34');
INSERT INTO `ltm_translations` VALUES (447, 0, 'en', 'modules', 'moduleSettings.moduleSetting', 'Module Setting', '2019-06-18 05:01:50', '2019-06-18 05:08:18');
INSERT INTO `ltm_translations` VALUES (448, 0, 'en', 'modules', 'moduleSettings.employeeSubTitle', 'Select the modules which you want to enable.', '2019-06-18 05:01:50', '2019-06-18 05:08:18');
INSERT INTO `ltm_translations` VALUES (449, 0, 'en', 'modules', 'moduleSettings.section', 'section.', '2019-06-18 05:01:50', '2019-06-18 05:08:19');
INSERT INTO `ltm_translations` VALUES (450, 0, 'en', 'modules', 'notices.addNotice', 'Add New Notice', '2019-06-18 05:01:50', '2019-06-18 05:08:05');
INSERT INTO `ltm_translations` VALUES (451, 0, 'en', 'modules', 'notices.updateNotice', 'Update Notice', '2019-06-18 05:01:51', '2019-06-18 05:08:06');
INSERT INTO `ltm_translations` VALUES (452, 0, 'en', 'app', 'menu.offlinePaymentMethod', 'Offline Payment Method', '2019-06-18 05:01:51', '2019-06-18 05:06:42');
INSERT INTO `ltm_translations` VALUES (453, 0, 'en', 'messages', 'noMethodsAdded', 'No Methods Added.', '2019-06-18 05:01:51', '2019-06-18 05:07:19');
INSERT INTO `ltm_translations` VALUES (454, 0, 'en', 'modules', 'offlinePayment.title', 'Offline Payment Method', '2019-06-18 05:01:51', '2019-06-18 05:09:02');
INSERT INTO `ltm_translations` VALUES (455, 0, 'en', 'app', 'selectProject', 'Select Project', '2019-06-18 05:01:51', '2019-06-18 05:06:34');
INSERT INTO `ltm_translations` VALUES (456, 0, 'en', 'modules', 'payments.updatePayment', 'Update Payment', '2019-06-18 05:01:51', '2019-06-18 05:08:25');
INSERT INTO `ltm_translations` VALUES (457, 0, 'en', 'modules', 'payments.import', 'Import CSV', '2019-06-18 05:01:51', '2019-06-18 05:08:25');
INSERT INTO `ltm_translations` VALUES (458, 0, 'en', 'app', 'sampleFile', 'Sample File', '2019-06-18 05:01:51', '2019-06-18 05:06:55');
INSERT INTO `ltm_translations` VALUES (459, 0, 'en', 'messages', 'productPrice', 'Insert price without currency code.', '2019-06-18 05:01:51', '2019-06-18 05:07:21');
INSERT INTO `ltm_translations` VALUES (460, 0, 'en', 'app', 'inclusiveAllTaxes', 'Inclusive All Taxes', '2019-06-18 05:01:51', '2019-06-18 05:06:57');
INSERT INTO `ltm_translations` VALUES (461, 0, 'en', 'modules', 'profile.passwordNote', 'Leave blank to keep your current password.', '2019-06-18 05:01:52', '2019-06-18 05:08:12');
INSERT INTO `ltm_translations` VALUES (462, 0, 'en', 'modules', 'projectTemplate.createTitle', 'Add Template Template', '2019-06-18 05:01:52', '2019-06-18 05:09:03');
INSERT INTO `ltm_translations` VALUES (463, 0, 'en', 'modules', 'projectCategory.addProjectCategory', 'Add Project Category', '2019-06-18 05:01:52', '2019-06-18 05:08:21');
INSERT INTO `ltm_translations` VALUES (464, 0, 'en', 'modules', 'projectTemplate.updateTitle', 'Update Template Details', '2019-06-18 05:01:52', '2019-06-18 05:09:04');
INSERT INTO `ltm_translations` VALUES (465, 0, 'en', 'app', 'team', 'Team', '2019-06-18 05:01:52', '2019-06-18 05:06:55');
INSERT INTO `ltm_translations` VALUES (466, 0, 'en', 'modules', 'templateTasks.updateTask', 'Update Template Task', '2019-06-18 05:01:52', '2019-06-18 05:09:08');
INSERT INTO `ltm_translations` VALUES (467, 0, 'en', 'modules', 'templateTasks.high', 'High', '2019-06-18 05:01:52', '2019-06-18 05:09:07');
INSERT INTO `ltm_translations` VALUES (468, 0, 'en', 'modules', 'templateTasks.medium', 'Medium', '2019-06-18 05:01:52', '2019-06-18 05:09:08');
INSERT INTO `ltm_translations` VALUES (469, 0, 'en', 'modules', 'templateTasks.low', 'Low', '2019-06-18 05:01:52', '2019-06-18 05:09:08');
INSERT INTO `ltm_translations` VALUES (470, 0, 'en', 'modules', 'templateTasks.newTask', 'New Template Task', '2019-06-18 05:01:52', '2019-06-18 05:09:07');
INSERT INTO `ltm_translations` VALUES (471, 0, 'en', 'app', 'clientName', 'Client Name', '2019-06-18 05:01:52', '2019-06-18 05:06:35');
INSERT INTO `ltm_translations` VALUES (472, 0, 'en', 'messages', 'sweetAlertTitle', 'Are you sure?', '2019-06-18 05:01:52', '2019-06-18 05:07:35');
INSERT INTO `ltm_translations` VALUES (473, 0, 'en', 'messages', 'unArchiveMessage', 'Do you want to revert this project.', '2019-06-18 05:01:52', '2019-06-18 05:07:35');
INSERT INTO `ltm_translations` VALUES (474, 0, 'en', 'messages', 'confirmRevert', 'Yes, revert it!', '2019-06-18 05:01:52', '2019-06-18 05:07:34');
INSERT INTO `ltm_translations` VALUES (475, 0, 'en', 'messages', 'confirmNoArchive', 'No, cancel please!', '2019-06-18 05:01:53', '2019-06-18 05:07:35');
INSERT INTO `ltm_translations` VALUES (476, 0, 'en', 'modules', 'projects.createTitle', 'Add Project', '2019-06-18 05:01:53', '2019-06-18 05:07:49');
INSERT INTO `ltm_translations` VALUES (477, 0, 'en', 'modules', 'projects.updateTitle', 'Update Project Details', '2019-06-18 05:01:53', '2019-06-18 05:07:50');
INSERT INTO `ltm_translations` VALUES (478, 0, 'en', 'modules', 'tasks.assignTo', 'Assigned To', '2019-06-18 05:01:53', '2019-06-18 05:07:53');
INSERT INTO `ltm_translations` VALUES (479, 0, 'en', 'modules', 'projects.viewGanttChart', 'Gantt Chart', '2019-06-18 05:01:53', '2019-06-18 05:07:52');
INSERT INTO `ltm_translations` VALUES (480, 0, 'en', 'messages', 'archiveMessage', 'Do you want to archive this project.', '2019-06-18 05:01:53', '2019-06-18 05:07:34');
INSERT INTO `ltm_translations` VALUES (481, 0, 'en', 'messages', 'confirmArchive', 'Yes, archive it!', '2019-06-18 05:01:53', '2019-06-18 05:07:34');
INSERT INTO `ltm_translations` VALUES (482, 0, 'en', 'app', 'project', 'Project', '2019-06-18 05:01:53', '2019-06-18 05:06:32');
INSERT INTO `ltm_translations` VALUES (483, 0, 'en', 'messages', 'noInvoice', 'No invoice created.', '2019-06-18 05:01:53', '2019-06-18 05:07:13');
INSERT INTO `ltm_translations` VALUES (484, 0, 'en', 'messages', 'noIssue', 'No issue found.', '2019-06-18 05:01:53', '2019-06-18 05:07:13');
INSERT INTO `ltm_translations` VALUES (485, 0, 'en', 'modules', 'projects.activeTimers', 'Active Timers', '2019-06-18 05:01:53', '2019-06-18 05:07:51');
INSERT INTO `ltm_translations` VALUES (486, 0, 'en', 'app', 'complete', 'Complete', '2019-06-18 05:01:53', '2019-06-18 05:06:51');
INSERT INTO `ltm_translations` VALUES (487, 0, 'en', 'messages', 'noClientAddedToProject', 'No client assigned to the project.', '2019-06-18 05:01:53', '2019-06-18 05:07:27');
INSERT INTO `ltm_translations` VALUES (488, 0, 'en', 'modules', 'tasks.updateTask', 'Update Task', '2019-06-18 05:01:53', '2019-06-18 05:07:54');
INSERT INTO `ltm_translations` VALUES (489, 0, 'en', 'modules', 'taskCategory.addTaskCategory', 'Add Task Category', '2019-06-18 05:01:54', '2019-06-18 05:09:12');
INSERT INTO `ltm_translations` VALUES (490, 0, 'en', 'modules', 'tasks.high', 'High', '2019-06-18 05:01:54', '2019-06-18 05:07:53');
INSERT INTO `ltm_translations` VALUES (491, 0, 'en', 'modules', 'tasks.medium', 'Medium', '2019-06-18 05:01:54', '2019-06-18 05:07:53');
INSERT INTO `ltm_translations` VALUES (492, 0, 'en', 'modules', 'tasks.low', 'Low', '2019-06-18 05:01:54', '2019-06-18 05:07:54');
INSERT INTO `ltm_translations` VALUES (493, 0, 'en', 'modules', 'tasks.newTask', 'New Task', '2019-06-18 05:01:54', '2019-06-18 05:07:53');
INSERT INTO `ltm_translations` VALUES (494, 0, 'en', 'modules', 'taskCategory.manageTaskCategory', 'Manage Task Category', '2019-06-18 05:01:54', '2019-06-18 05:09:12');
INSERT INTO `ltm_translations` VALUES (495, 0, 'en', 'modules', 'timeLogs.logTime', 'Log Time', '2019-06-18 05:01:54', '2019-06-18 05:08:04');
INSERT INTO `ltm_translations` VALUES (496, 0, 'en', 'modules', 'proposal.createTitle', 'Add Proposal Info', '2019-06-18 05:01:54', '2019-06-18 05:08:55');
INSERT INTO `ltm_translations` VALUES (497, 0, 'en', 'modules', 'proposal.updateProposal', 'Update Proposal', '2019-06-18 05:01:54', '2019-06-18 05:08:57');
INSERT INTO `ltm_translations` VALUES (498, 0, 'en', 'modules', 'slackSettings.notificationSubtitle', 'Select the events for which an notification should be sent to user.', '2019-06-18 05:01:54', '2019-06-18 05:08:28');
INSERT INTO `ltm_translations` VALUES (499, 0, 'en', 'modules', 'invoices.currency', 'Currency', '2019-06-18 05:01:54', '2019-06-18 05:07:57');
INSERT INTO `ltm_translations` VALUES (500, 0, 'en', 'modules', 'financeReport.selectCurrency', 'Select Currency', '2019-06-18 05:01:54', '2019-06-18 05:08:08');
INSERT INTO `ltm_translations` VALUES (501, 0, 'en', 'modules', 'financeReport.noteText', 'The earnings are calculated with latest exchange rate for different currencies.', '2019-06-18 05:01:54', '2019-06-18 05:08:09');
INSERT INTO `ltm_translations` VALUES (502, 0, 'en', 'app', 'duration', 'Duration', '2019-06-18 05:01:54', '2019-06-18 05:06:46');
INSERT INTO `ltm_translations` VALUES (503, 0, 'en', 'app', 'days', 'Days', '2019-06-18 05:01:54', '2019-06-18 05:06:47');
INSERT INTO `ltm_translations` VALUES (504, 0, 'en', 'app', 'month', 'Month', '2019-06-18 05:01:55', '2019-06-18 05:06:47');
INSERT INTO `ltm_translations` VALUES (505, 0, 'en', 'app', 'name', 'Name', '2019-06-18 05:01:55', '2019-06-18 05:06:31');
INSERT INTO `ltm_translations` VALUES (506, 0, 'en', 'app', 'select', 'Select', '2019-06-18 05:01:55', '2019-06-18 05:06:47');
INSERT INTO `ltm_translations` VALUES (507, 0, 'en', 'app', 'approved', 'Approved', '2019-06-18 05:01:55', '2019-06-18 05:06:53');
INSERT INTO `ltm_translations` VALUES (508, 0, 'en', 'app', 'upcoming', 'Upcoming', '2019-06-18 05:01:55', '2019-06-18 05:06:56');
INSERT INTO `ltm_translations` VALUES (509, 0, 'en', 'modules', 'employees.employeeName', 'Employee Name', '2019-06-18 05:01:55', '2019-06-18 05:07:47');
INSERT INTO `ltm_translations` VALUES (510, 0, 'en', 'app', 'selectTask', 'Select Task', '2019-06-18 05:01:55', '2019-06-18 05:06:35');
INSERT INTO `ltm_translations` VALUES (511, 0, 'en', 'modules', 'roles.addRole', 'Manage Role', '2019-06-18 05:01:55', '2019-06-18 05:08:43');
INSERT INTO `ltm_translations` VALUES (512, 0, 'en', 'app', 'search', 'Search...', '2019-06-18 05:01:55', '2019-06-18 05:06:32');
INSERT INTO `ltm_translations` VALUES (513, 0, 'en', 'modules', 'accountSettings.uploadLogo', 'Upload your logo', '2019-06-18 05:01:55', '2019-06-18 05:08:11');
INSERT INTO `ltm_translations` VALUES (514, 0, 'en', 'modules', 'accountSettings.getLocation', 'Set current location', '2019-06-18 05:01:55', '2019-06-18 05:08:11');
INSERT INTO `ltm_translations` VALUES (515, 0, 'en', 'modules', 'slackSettings.uploadSlackLogo', 'Upload Notification Logo', '2019-06-18 05:01:55', '2019-06-18 05:08:28');
INSERT INTO `ltm_translations` VALUES (516, 0, 'en', 'app', 'addNew', 'Add New', '2019-06-18 05:01:55', '2019-06-18 05:06:31');
INSERT INTO `ltm_translations` VALUES (517, 0, 'en', 'modules', 'sticky.lastUpdated', 'Updated', '2019-06-18 05:01:55', '2019-06-18 05:08:06');
INSERT INTO `ltm_translations` VALUES (518, 0, 'en', 'modules', 'invoices.due', 'Due', '2019-06-18 05:01:56', '2019-06-18 05:08:01');
INSERT INTO `ltm_translations` VALUES (519, 0, 'en', 'modules', 'taskCalendar.note', 'Calendar shows the due tasks on their due dates.', '2019-06-18 05:01:56', '2019-06-18 05:08:05');
INSERT INTO `ltm_translations` VALUES (520, 0, 'en', 'modules', 'taskDetail', 'Task Detail', '2019-06-18 05:01:56', '2019-06-18 05:08:21');
INSERT INTO `ltm_translations` VALUES (521, 0, 'en', 'messages', 'taskSettingNote', 'Self task setting\n will update on select.', '2019-06-18 05:01:56', '2019-06-18 05:07:39');
INSERT INTO `ltm_translations` VALUES (522, 0, 'en', 'modules', 'tasks.comment', 'Comment', '2019-06-18 05:01:56', '2019-06-18 05:07:55');
INSERT INTO `ltm_translations` VALUES (523, 0, 'en', 'modules', 'tasks.subTask', 'Sub Task', '2019-06-18 05:01:56', '2019-06-18 05:07:55');
INSERT INTO `ltm_translations` VALUES (524, 0, 'en', 'modules', 'tasks.tasksTable', 'Tasks Table', '2019-06-18 05:01:56', '2019-06-18 05:07:55');
INSERT INTO `ltm_translations` VALUES (525, 0, 'en', 'modules', 'tasks.addBoardColumn', 'Add Column', '2019-06-18 05:01:56', '2019-06-18 05:07:54');
INSERT INTO `ltm_translations` VALUES (526, 0, 'en', 'modules', 'tasks.assignBy', 'Assigned By', '2019-06-18 05:01:56', '2019-06-18 05:07:55');
INSERT INTO `ltm_translations` VALUES (527, 0, 'en', 'modules', 'tasks.chooseAssignee', 'Choose Assignee', '2019-06-18 05:01:56', '2019-06-18 05:07:54');
INSERT INTO `ltm_translations` VALUES (528, 0, 'en', 'modules', 'tasks.markComplete', 'Mark as complete', '2019-06-18 05:01:56', '2019-06-18 05:07:56');
INSERT INTO `ltm_translations` VALUES (529, 0, 'en', 'modules', 'tasks.markIncomplete', 'Mark as incomplete', '2019-06-18 05:01:56', '2019-06-18 05:07:56');
INSERT INTO `ltm_translations` VALUES (530, 0, 'en', 'messages', 'remindToAssignedEmployee', 'Reminder to assigned employee', '2019-06-18 05:01:56', '2019-06-18 05:07:38');
INSERT INTO `ltm_translations` VALUES (531, 0, 'en', 'modules', 'tasks.reminder', 'Reminder', '2019-06-18 05:01:56', '2019-06-18 05:07:56');
INSERT INTO `ltm_translations` VALUES (532, 0, 'en', 'app', 'submit', 'Submit', '2019-06-18 05:01:57', '2019-06-18 05:06:48');
INSERT INTO `ltm_translations` VALUES (533, 0, 'en', 'modules', 'projects.members', 'Members', '2019-06-18 05:01:57', '2019-06-18 05:07:51');
INSERT INTO `ltm_translations` VALUES (534, 0, 'en', 'app', 'manage', 'Manage', '2019-06-18 05:01:58', '2019-06-18 05:06:55');
INSERT INTO `ltm_translations` VALUES (535, 0, 'en', 'messages', 'faviconNote', 'Go to https://www.favicon-generator.org/ and generate favicons.\n\nAfter that upload the favicons to public/favicon directory.', '2019-06-18 05:01:58', '2019-06-18 05:07:31');
INSERT INTO `ltm_translations` VALUES (536, 0, 'en', 'modules', 'themeSettings.customCss', 'Custom CSS', '2019-06-18 05:01:58', '2019-06-18 05:08:23');
INSERT INTO `ltm_translations` VALUES (537, 0, 'en', 'modules', 'tickets.agents', 'Agents', '2019-06-18 05:01:58', '2019-06-18 05:08:30');
INSERT INTO `ltm_translations` VALUES (538, 0, 'en', 'modules', 'tickets.chooseAgents', 'Choose Agents', '2019-06-18 05:01:58', '2019-06-18 05:08:30');
INSERT INTO `ltm_translations` VALUES (539, 0, 'en', 'modules', 'tickets.manageGroups', 'Manage Groups', '2019-06-18 05:01:58', '2019-06-18 05:08:30');
INSERT INTO `ltm_translations` VALUES (540, 0, 'en', 'messages', 'noAgentAdded', 'No agent added.', '2019-06-18 05:01:58', '2019-06-18 05:07:25');
INSERT INTO `ltm_translations` VALUES (541, 0, 'en', 'messages', 'noTicketChannelAdded', NULL, '2019-06-18 05:01:59', '2019-06-18 05:01:59');
INSERT INTO `ltm_translations` VALUES (542, 0, 'en', 'modules', 'tickets.template', 'Template', '2019-06-18 05:01:59', '2019-06-18 05:08:31');
INSERT INTO `ltm_translations` VALUES (543, 0, 'en', 'messages', 'noTemplateFound', 'No template found.', '2019-06-18 05:01:59', '2019-06-18 05:07:26');
INSERT INTO `ltm_translations` VALUES (544, 0, 'en', 'modules', 'tickets.ticketType', 'Ticket Type', '2019-06-18 05:01:59', '2019-06-18 05:08:31');
INSERT INTO `ltm_translations` VALUES (545, 0, 'en', 'messages', 'noTicketTypeAdded', 'No ticket type added.', '2019-06-18 05:01:59', '2019-06-18 05:07:26');
INSERT INTO `ltm_translations` VALUES (546, 0, 'en', 'modules', 'tickets.applyTemplate', 'Apply Template', '2019-06-18 05:01:59', '2019-06-18 05:08:32');
INSERT INTO `ltm_translations` VALUES (547, 0, 'en', 'app', 'open', 'Open', '2019-06-18 05:01:59', '2019-06-18 05:06:54');
INSERT INTO `ltm_translations` VALUES (548, 0, 'en', 'app', 'resolved', 'Resolved', '2019-06-18 05:01:59', '2019-06-18 05:06:55');
INSERT INTO `ltm_translations` VALUES (549, 0, 'en', 'modules', 'tickets.addType', 'Add Type', '2019-06-18 05:01:59', '2019-06-18 05:08:31');
INSERT INTO `ltm_translations` VALUES (550, 0, 'en', 'modules', 'tickets.addChannel', 'Add Channel', '2019-06-18 05:01:59', '2019-06-18 05:08:32');
INSERT INTO `ltm_translations` VALUES (551, 0, 'en', 'modules', 'tickets.ticketTypes', NULL, '2019-06-18 05:01:59', '2019-06-18 05:01:59');
INSERT INTO `ltm_translations` VALUES (552, 0, 'en', 'messages', 'noMessage', 'No message found.', '2019-06-18 05:01:59', '2019-06-18 05:07:18');
INSERT INTO `ltm_translations` VALUES (553, 0, 'en', 'app', 'menu.ticketSettings', 'Ticket Settings', '2019-06-18 05:01:59', '2019-06-18 05:06:39');
INSERT INTO `ltm_translations` VALUES (554, 0, 'en', 'app', 'menu.timeLogs', 'Time Logs', '2019-06-18 05:01:59', '2019-06-18 05:06:37');
INSERT INTO `ltm_translations` VALUES (555, 0, 'en', 'messages', 'noConversation', 'No conversation found.', '2019-06-18 05:01:59', '2019-06-18 05:07:18');
INSERT INTO `ltm_translations` VALUES (556, 0, 'en', 'modules', 'messages.startConversation', 'Start Conversation', '2019-06-18 05:01:59', '2019-06-18 05:08:20');
INSERT INTO `ltm_translations` VALUES (557, 0, 'en', 'modules', 'client.clientName', 'Client Name', '2019-06-18 05:01:59', '2019-06-18 05:07:44');
INSERT INTO `ltm_translations` VALUES (558, 0, 'en', 'modules', 'messages.send', 'Send', '2019-06-18 05:02:00', '2019-06-18 05:08:21');
INSERT INTO `ltm_translations` VALUES (559, 0, 'en', 'modules', 'messages.searchContact', 'Search Contact', '2019-06-18 05:02:00', '2019-06-18 05:08:21');
INSERT INTO `ltm_translations` VALUES (560, 0, 'en', 'messages', 'noUser', 'No user found.', '2019-06-18 05:02:00', '2019-06-18 05:07:19');
INSERT INTO `ltm_translations` VALUES (561, 0, 'en', 'modules', 'messages.typeMessage', 'Type your message here...', '2019-06-18 05:02:00', '2019-06-18 05:08:21');
INSERT INTO `ltm_translations` VALUES (562, 0, 'en', 'app', 'email', 'Email', '2019-06-18 05:02:00', '2019-06-18 05:06:32');
INSERT INTO `ltm_translations` VALUES (563, 0, 'en', 'modules', 'client.password', 'Password', '2019-06-18 05:02:00', '2019-06-18 05:07:44');
INSERT INTO `ltm_translations` VALUES (564, 0, 'en', 'app', 'rememberMe', 'Remember Me', '2019-06-18 05:02:00', '2019-06-18 05:06:53');
INSERT INTO `ltm_translations` VALUES (565, 0, 'en', 'app', 'forgotPassword', 'Forgot Password', '2019-06-18 05:02:00', '2019-06-18 05:06:53');
INSERT INTO `ltm_translations` VALUES (566, 0, 'en', 'modules', 'dashboard.totalPaidAmount', 'Paid Amount', '2019-06-18 05:02:00', '2019-06-18 05:07:40');
INSERT INTO `ltm_translations` VALUES (567, 0, 'en', 'modules', 'dashboard.totalOutstandingAmount', 'Outstanding Amount', '2019-06-18 05:02:00', '2019-06-18 05:07:41');
INSERT INTO `ltm_translations` VALUES (568, 0, 'en', 'modules', 'invoices.payNow', 'Pay Now', '2019-06-18 05:02:00', '2019-06-18 05:08:00');
INSERT INTO `ltm_translations` VALUES (569, 0, 'en', 'modules', 'issues.addIssue', 'Add Issue', '2019-06-18 05:02:00', '2019-06-18 05:08:02');
INSERT INTO `ltm_translations` VALUES (570, 0, 'en', 'modules', 'issues.updateIssue', 'Update Issue', '2019-06-18 05:02:00', '2019-06-18 05:08:02');
INSERT INTO `ltm_translations` VALUES (571, 0, 'en', 'modules', 'profile.updateTitle', 'Update Profile Info', '2019-06-18 05:02:00', '2019-06-18 05:08:12');
INSERT INTO `ltm_translations` VALUES (572, 0, 'en', 'app', 'dueDate', 'Due Date', '2019-06-18 05:02:00', '2019-06-18 05:06:32');
INSERT INTO `ltm_translations` VALUES (573, 0, 'en', 'modules', 'tickets.closeTicket', 'Close Ticket', '2019-06-18 05:02:00', '2019-06-18 05:08:34');
INSERT INTO `ltm_translations` VALUES (574, 0, 'en', 'modules', 'tickets.reopenTicket', 'Reopen Ticket', '2019-06-18 05:02:00', '2019-06-18 05:08:34');
INSERT INTO `ltm_translations` VALUES (575, 0, 'en', 'modules', 'messages.chooseAdmin', 'Choose Admin', '2019-06-18 05:02:00', '2019-06-18 05:08:21');
INSERT INTO `ltm_translations` VALUES (576, 0, 'en', 'app', 'forbiddenError', 'Forbidden Error', '2019-06-18 05:02:00', '2019-06-18 05:06:53');
INSERT INTO `ltm_translations` VALUES (577, 0, 'en', 'app', 'to', 'To', '2019-06-18 05:02:00', '2019-06-18 05:06:49');
INSERT INTO `ltm_translations` VALUES (578, 0, 'en', 'app', 'menu.home', 'Home', '2019-06-18 05:02:00', '2019-06-18 05:06:36');
INSERT INTO `ltm_translations` VALUES (579, 0, 'en', 'modules', 'tickets.ticket', 'Ticket', '2019-06-18 05:02:00', '2019-06-18 05:08:31');
INSERT INTO `ltm_translations` VALUES (580, 0, 'en', 'app', 'markRead', 'Mark as Read', '2019-06-18 05:02:01', '2019-06-18 05:06:32');
INSERT INTO `ltm_translations` VALUES (581, 0, 'en', 'app', 'logout', 'Logout', '2019-06-18 05:02:01', '2019-06-18 05:06:35');
INSERT INTO `ltm_translations` VALUES (582, 0, 'en', 'modules', 'sticky.addNote', 'Add Note', '2019-06-18 05:02:01', '2019-06-18 05:08:06');
INSERT INTO `ltm_translations` VALUES (583, 0, 'en', 'app', 'panel', 'Panel', '2019-06-18 05:02:01', '2019-06-18 05:06:36');
INSERT INTO `ltm_translations` VALUES (584, 0, 'en', 'app', 'employeePanel', 'Employee Panel', '2019-06-18 05:02:01', '2019-06-18 05:06:34');
INSERT INTO `ltm_translations` VALUES (585, 0, 'en', 'modules', 'accountSettings.google_map_key', 'Google map key', '2019-06-18 05:02:01', '2019-06-18 05:08:12');
INSERT INTO `ltm_translations` VALUES (586, 0, 'en', 'modules', 'accountSettings.google_recaptcha_key', 'Google Recpatcha Key', '2019-06-18 05:02:01', '2019-06-18 05:08:12');
INSERT INTO `ltm_translations` VALUES (587, 0, 'en', 'modules', 'accountSettings.currencyConverterKey', 'Currency converter key', '2019-06-18 05:02:01', '2019-06-18 05:08:12');
INSERT INTO `ltm_translations` VALUES (588, 0, 'en', 'app', 'view', 'View', '2019-06-18 05:02:01', '2019-06-18 05:06:49');
INSERT INTO `ltm_translations` VALUES (589, 0, 'en', 'email', 'regards', 'Regards', '2019-06-18 05:02:01', '2019-06-18 05:07:04');
INSERT INTO `ltm_translations` VALUES (590, 0, 'en', 'modules', 'holiday.date', 'Date', '2019-06-18 05:02:01', '2019-06-18 05:09:00');
INSERT INTO `ltm_translations` VALUES (591, 0, 'en', 'modules', 'holiday.day', 'Day', '2019-06-18 05:02:01', '2019-06-18 05:09:01');
INSERT INTO `ltm_translations` VALUES (592, 0, 'en', 'modules', 'holiday.action', 'Action', '2019-06-18 05:02:01', '2019-06-18 05:09:01');
INSERT INTO `ltm_translations` VALUES (593, 0, 'en', 'modules', 'leaves.applyLeave', 'Apply Leave', '2019-06-18 05:02:01', '2019-06-18 05:08:48');
INSERT INTO `ltm_translations` VALUES (594, 0, 'en', 'modules', 'projects.noOpenTasks', 'No open tasks.', '2019-06-18 05:02:01', '2019-06-18 05:07:52');
INSERT INTO `ltm_translations` VALUES (595, 0, 'en', 'modules', 'tasks.taskDetail', 'Task Detail', '2019-06-18 05:02:01', '2019-06-18 05:07:54');
INSERT INTO `ltm_translations` VALUES (596, 0, 'en', 'modules', 'timeLogs.selectTask', 'Select Task', '2019-06-18 05:02:01', '2019-06-18 05:08:04');
INSERT INTO `ltm_translations` VALUES (597, 0, 'en', 'modules', 'timeLogs.selectProject', 'Select Project', '2019-06-18 05:02:01', '2019-06-18 05:08:04');
INSERT INTO `ltm_translations` VALUES (598, 0, 'en', 'modules', 'timeLogs.noProjectFound', 'No Task Assigned', '2019-06-18 05:02:01', '2019-06-18 05:08:04');
INSERT INTO `ltm_translations` VALUES (599, 0, 'en', 'modules', 'timeLogs.noTaskFound', 'No Task Assigned', '2019-06-18 05:02:02', '2019-06-18 05:08:04');
INSERT INTO `ltm_translations` VALUES (600, 0, 'en', 'modules', 'timeLogs.stopTimer', 'Stop Timer', '2019-06-18 05:02:02', '2019-06-18 05:08:04');
INSERT INTO `ltm_translations` VALUES (601, 0, 'en', 'app', 'welcome', 'Welcome', '2019-06-18 05:02:02', '2019-06-18 05:06:53');
INSERT INTO `ltm_translations` VALUES (602, 0, 'en', 'messages', 'planPurchaseBy', 'Plan purchased by', '2019-06-18 05:02:02', '2019-06-18 05:07:36');
INSERT INTO `ltm_translations` VALUES (603, 0, 'en', 'messages', 'planUpdatedBy', 'Plan updated by', '2019-06-18 05:02:02', '2019-06-18 05:07:37');
INSERT INTO `ltm_translations` VALUES (604, 0, 'en', 'messages', 'namedCompanyRegistered.', 'named company registered.', '2019-06-18 05:02:02', '2019-06-18 05:07:36');
INSERT INTO `ltm_translations` VALUES (605, 0, 'en', 'app', 'loginAsEmployee', 'Login As Employee', '2019-06-18 05:02:02', '2019-06-18 05:06:30');
INSERT INTO `ltm_translations` VALUES (606, 0, 'en', 'app', 'menu.lead', 'Leads', '2019-06-18 05:02:02', '2019-06-18 05:06:42');
INSERT INTO `ltm_translations` VALUES (607, 0, 'en', 'app', 'menu.finance', 'Finance', '2019-06-18 05:02:02', '2019-06-18 05:06:40');
INSERT INTO `ltm_translations` VALUES (608, 0, 'en', 'app', 'menu.reports', 'Reports', '2019-06-18 05:02:02', '2019-06-18 05:06:37');
INSERT INTO `ltm_translations` VALUES (609, 0, 'en', 'app', 'menu.billing', 'Billing', '2019-06-18 05:02:02', '2019-06-18 05:06:46');
INSERT INTO `ltm_translations` VALUES (610, 0, 'en', 'app', 'loginAsAdmin', 'Login As Admin', '2019-06-18 05:02:02', '2019-06-18 05:06:30');
INSERT INTO `ltm_translations` VALUES (611, 0, 'en', 'messages', 'currencyConvertApiKeyUrl', 'Get API key by this url', '2019-06-18 05:02:02', '2019-06-18 05:07:35');
INSERT INTO `ltm_translations` VALUES (612, 0, 'en', 'messages', 'addCurrencyNote', 'Add currency covert key for  add or edit currency and Update exchange rate.', '2019-06-18 05:02:02', '2019-06-18 05:07:37');
INSERT INTO `ltm_translations` VALUES (613, 0, 'en', 'modules', 'update.newUpdate', 'New update available', '2019-06-18 05:02:03', '2019-06-18 05:08:29');
INSERT INTO `ltm_translations` VALUES (614, 0, 'en', 'messages', 'FeatureImageSizeMessage', 'Uploading image size should be 400x352.', '2019-06-18 05:02:03', '2019-06-18 05:07:37');
INSERT INTO `ltm_translations` VALUES (615, 0, 'en', 'app', 'icon', 'Icon', '2019-06-18 05:02:03', '2019-06-18 05:07:00');
INSERT INTO `ltm_translations` VALUES (616, 0, 'en', 'app', 'image', 'Image', '2019-06-18 05:02:03', '2019-06-18 05:07:00');
INSERT INTO `ltm_translations` VALUES (617, 0, 'en', 'modules', 'frontSettings.title', 'Frontend CMS', '2019-06-18 05:02:03', '2019-06-18 05:09:16');
INSERT INTO `ltm_translations` VALUES (618, 0, 'en', 'messages', 'headerImageSizeMessage', 'Uploading image size should be 688x504.', '2019-06-18 05:02:04', '2019-06-18 05:07:37');
INSERT INTO `ltm_translations` VALUES (619, 0, 'en', 'app', 'freeTrial', 'Free Trial', '2019-06-18 05:02:04', '2019-06-18 05:07:02');
INSERT INTO `ltm_translations` VALUES (620, 0, 'en', 'app', 'module', 'Module', '2019-06-18 05:02:04', '2019-06-18 05:07:01');
INSERT INTO `ltm_translations` VALUES (621, 0, 'en', 'app', 'info', NULL, '2019-06-18 05:02:04', '2019-06-18 05:02:04');
INSERT INTO `ltm_translations` VALUES (622, 0, 'en', 'app', 'price', 'Price', '2019-06-18 05:02:04', '2019-06-18 05:06:46');
INSERT INTO `ltm_translations` VALUES (623, 0, 'en', 'messages', 'addPaypalWebhookUrl', 'Add this webhook url on your paypal app settings.', '2019-06-18 05:02:05', '2019-06-18 05:07:39');
INSERT INTO `ltm_translations` VALUES (624, 0, 'en', 'app', 'new', 'New', '2019-06-18 05:02:05', '2019-06-18 05:07:02');
INSERT INTO `ltm_translations` VALUES (625, 0, 'en', 'messages', 'updateAlert', 'Do not click update now button if the application is customised. Your changes will be lost.', '2019-06-18 05:02:05', '2019-06-18 05:07:30');
INSERT INTO `ltm_translations` VALUES (626, 0, 'en', 'modules', 'update.fileReplaceAlert', 'To update the worksuite to new version check documentation for the instructions.', '2019-06-18 05:02:05', '2019-06-18 05:08:29');
INSERT INTO `ltm_translations` VALUES (627, 0, 'en', '_json', ' app.skills ', NULL, '2019-06-18 05:02:05', '2019-06-18 05:02:05');
INSERT INTO `ltm_translations` VALUES (628, 0, 'en', '_json', ' app.selectProject ', NULL, '2019-06-18 05:02:06', '2019-06-18 05:02:06');
INSERT INTO `ltm_translations` VALUES (629, 0, 'en', '_json', 'status', NULL, '2019-06-18 05:02:06', '2019-06-18 05:02:06');
INSERT INTO `ltm_translations` VALUES (630, 0, 'en', '_json', 'messages.noUser ', NULL, '2019-06-18 05:02:06', '2019-06-18 05:02:06');
INSERT INTO `ltm_translations` VALUES (631, 0, 'en', '_json', 'NewCompanyRegistered', NULL, '2019-06-18 05:02:06', '2019-06-18 05:02:06');
INSERT INTO `ltm_translations` VALUES (632, 0, 'ar', 'installer_messages', 'title', 'تنصيب Laravel', '2019-06-18 05:04:45', '2019-06-18 05:06:23');
INSERT INTO `ltm_translations` VALUES (633, 0, 'ar', 'installer_messages', 'next', 'متابعة', '2019-06-18 05:04:45', '2019-06-18 05:06:23');
INSERT INTO `ltm_translations` VALUES (634, 0, 'ar', 'installer_messages', 'welcome.title', 'تنصيب Laravel', '2019-06-18 05:04:45', '2019-06-18 05:06:23');
INSERT INTO `ltm_translations` VALUES (635, 0, 'ar', 'installer_messages', 'welcome.message', 'أهلا بك في صفحة تنصيب Laravel', '2019-06-18 05:04:45', '2019-06-18 05:06:23');
INSERT INTO `ltm_translations` VALUES (636, 0, 'ar', 'installer_messages', 'requirements.title', 'المتطلبات', '2019-06-18 05:04:45', '2019-06-18 05:06:23');
INSERT INTO `ltm_translations` VALUES (637, 0, 'ar', 'installer_messages', 'permissions.title', 'تراخيص المجلدات', '2019-06-18 05:04:45', '2019-06-18 05:06:23');
INSERT INTO `ltm_translations` VALUES (638, 0, 'ar', 'installer_messages', 'environment.title', 'الإعدادات', '2019-06-18 05:04:45', '2019-06-18 05:06:24');
INSERT INTO `ltm_translations` VALUES (639, 0, 'ar', 'installer_messages', 'environment.save', 'حفظ ملف .env', '2019-06-18 05:04:45', '2019-06-18 05:06:24');
INSERT INTO `ltm_translations` VALUES (640, 0, 'ar', 'installer_messages', 'environment.success', 'تم حفظ الإعدادات بنجاح', '2019-06-18 05:04:45', '2019-06-18 05:06:24');
INSERT INTO `ltm_translations` VALUES (641, 0, 'ar', 'installer_messages', 'environment.errors', 'حدث خطأ أثناء إنشاء ملف .env. رجاءا قم بإنشاءه يدويا', '2019-06-18 05:04:45', '2019-06-18 05:06:24');
INSERT INTO `ltm_translations` VALUES (642, 0, 'ar', 'installer_messages', 'final.title', 'النهاية', '2019-06-18 05:04:45', '2019-06-18 05:06:24');
INSERT INTO `ltm_translations` VALUES (643, 0, 'ar', 'installer_messages', 'final.finished', 'تم تنصيب البرنامج بنجاح...', '2019-06-18 05:04:45', '2019-06-18 05:06:24');
INSERT INTO `ltm_translations` VALUES (644, 0, 'ar', 'installer_messages', 'final.exit', 'إضغط هنا للخروج', '2019-06-18 05:04:46', '2019-06-18 05:06:24');
INSERT INTO `ltm_translations` VALUES (645, 0, 'ar', 'messages', 'title', 'تنصيب Laravel', '2019-06-18 05:04:46', '2019-06-18 05:06:24');
INSERT INTO `ltm_translations` VALUES (646, 0, 'ar', 'messages', 'next', 'متابعة', '2019-06-18 05:04:46', '2019-06-18 05:06:24');
INSERT INTO `ltm_translations` VALUES (647, 0, 'ar', 'messages', 'welcome.title', 'تنصيب Laravel', '2019-06-18 05:04:46', '2019-06-18 05:06:25');
INSERT INTO `ltm_translations` VALUES (648, 0, 'ar', 'messages', 'welcome.message', 'أهلا بك في صفحة تنصيب Laravel', '2019-06-18 05:04:46', '2019-06-18 05:06:25');
INSERT INTO `ltm_translations` VALUES (649, 0, 'ar', 'messages', 'requirements.title', 'المتطلبات', '2019-06-18 05:04:46', '2019-06-18 05:06:25');
INSERT INTO `ltm_translations` VALUES (650, 0, 'ar', 'messages', 'permissions.title', 'تراخيص المجلدات', '2019-06-18 05:04:46', '2019-06-18 05:06:25');
INSERT INTO `ltm_translations` VALUES (651, 0, 'ar', 'messages', 'environment.title', 'الإعدادات', '2019-06-18 05:04:46', '2019-06-18 05:06:25');
INSERT INTO `ltm_translations` VALUES (652, 0, 'ar', 'messages', 'environment.save', 'حفظ ملف .env', '2019-06-18 05:04:46', '2019-06-18 05:06:25');
INSERT INTO `ltm_translations` VALUES (653, 0, 'ar', 'messages', 'environment.success', 'تم حفظ الإعدادات بنجاح', '2019-06-18 05:04:46', '2019-06-18 05:06:25');
INSERT INTO `ltm_translations` VALUES (654, 0, 'ar', 'messages', 'environment.errors', 'حدث خطأ أثناء إنشاء ملف .env. رجاءا قم بإنشاءه يدويا', '2019-06-18 05:04:46', '2019-06-18 05:06:25');
INSERT INTO `ltm_translations` VALUES (655, 0, 'ar', 'messages', 'final.title', 'النهاية', '2019-06-18 05:04:46', '2019-06-18 05:06:26');
INSERT INTO `ltm_translations` VALUES (656, 0, 'ar', 'messages', 'final.finished', 'تم تنصيب البرنامج بنجاح...', '2019-06-18 05:04:46', '2019-06-18 05:06:26');
INSERT INTO `ltm_translations` VALUES (657, 0, 'ar', 'messages', 'final.exit', 'إضغط هنا للخروج', '2019-06-18 05:04:46', '2019-06-18 05:06:26');
INSERT INTO `ltm_translations` VALUES (658, 0, 'de', 'installer_messages', 'title', 'Laravel Installer', '2019-06-18 05:04:46', '2019-06-18 05:06:26');
INSERT INTO `ltm_translations` VALUES (659, 0, 'de', 'installer_messages', 'next', 'Nächster Schritt', '2019-06-18 05:04:46', '2019-06-18 05:06:26');
INSERT INTO `ltm_translations` VALUES (660, 0, 'de', 'installer_messages', 'finish', 'Installieren', '2019-06-18 05:04:46', '2019-06-18 05:06:26');
INSERT INTO `ltm_translations` VALUES (661, 0, 'de', 'installer_messages', 'welcome.title', 'Willkommen zum Installer', '2019-06-18 05:04:46', '2019-06-18 05:06:26');
INSERT INTO `ltm_translations` VALUES (662, 0, 'de', 'installer_messages', 'welcome.message', 'Willkommen zum Laravel Installationsassistent.', '2019-06-18 05:04:46', '2019-06-18 05:06:26');
INSERT INTO `ltm_translations` VALUES (663, 0, 'de', 'installer_messages', 'requirements.title', 'Vorraussetzungen', '2019-06-18 05:04:46', '2019-06-18 05:06:27');
INSERT INTO `ltm_translations` VALUES (664, 0, 'de', 'installer_messages', 'permissions.title', 'Berechtigungen', '2019-06-18 05:04:46', '2019-06-18 05:06:27');
INSERT INTO `ltm_translations` VALUES (665, 0, 'de', 'installer_messages', 'environment.title', 'Umgebungsvariablen', '2019-06-18 05:04:46', '2019-06-18 05:06:27');
INSERT INTO `ltm_translations` VALUES (666, 0, 'de', 'installer_messages', 'environment.save', 'Speicher .env', '2019-06-18 05:04:46', '2019-06-18 05:06:27');
INSERT INTO `ltm_translations` VALUES (667, 0, 'de', 'installer_messages', 'environment.success', 'Ihre .env Konfiguration wurde gespeichert.', '2019-06-18 05:04:46', '2019-06-18 05:06:27');
INSERT INTO `ltm_translations` VALUES (668, 0, 'de', 'installer_messages', 'environment.errors', 'Ihre .env Konfiguration konnte nicht gespeichert werden, Bitte erstellen Sie diese Manuell.', '2019-06-18 05:04:46', '2019-06-18 05:06:28');
INSERT INTO `ltm_translations` VALUES (669, 0, 'de', 'installer_messages', 'final.title', 'Fertig!', '2019-06-18 05:04:46', '2019-06-18 05:06:28');
INSERT INTO `ltm_translations` VALUES (670, 0, 'de', 'installer_messages', 'final.finished', 'Die Anwendung wurde erfolgreich Installiert.', '2019-06-18 05:04:46', '2019-06-18 05:06:28');
INSERT INTO `ltm_translations` VALUES (671, 0, 'de', 'installer_messages', 'final.exit', 'Hier Klicken zum Beenden', '2019-06-18 05:04:47', '2019-06-18 05:06:28');
INSERT INTO `ltm_translations` VALUES (672, 0, 'de', 'messages', 'title', 'Laravel Installer', '2019-06-18 05:04:47', '2019-06-18 05:06:28');
INSERT INTO `ltm_translations` VALUES (673, 0, 'de', 'messages', 'next', 'Nächster Schritt', '2019-06-18 05:04:47', '2019-06-18 05:06:28');
INSERT INTO `ltm_translations` VALUES (674, 0, 'de', 'messages', 'finish', 'Installieren', '2019-06-18 05:04:47', '2019-06-18 05:06:28');
INSERT INTO `ltm_translations` VALUES (675, 0, 'de', 'messages', 'welcome.title', 'Willkommen zum Installer', '2019-06-18 05:04:47', '2019-06-18 05:06:28');
INSERT INTO `ltm_translations` VALUES (676, 0, 'de', 'messages', 'welcome.message', 'Willkommen zum Laravel Installationsassistent.', '2019-06-18 05:04:47', '2019-06-18 05:06:29');
INSERT INTO `ltm_translations` VALUES (677, 0, 'de', 'messages', 'requirements.title', 'Vorraussetzungen', '2019-06-18 05:04:47', '2019-06-18 05:06:29');
INSERT INTO `ltm_translations` VALUES (678, 0, 'de', 'messages', 'permissions.title', 'Berechtigungen', '2019-06-18 05:04:47', '2019-06-18 05:06:29');
INSERT INTO `ltm_translations` VALUES (679, 0, 'de', 'messages', 'environment.title', 'Umgebungsvariablen', '2019-06-18 05:04:47', '2019-06-18 05:06:29');
INSERT INTO `ltm_translations` VALUES (680, 0, 'de', 'messages', 'environment.save', 'Speicher .env', '2019-06-18 05:04:47', '2019-06-18 05:06:29');
INSERT INTO `ltm_translations` VALUES (681, 0, 'de', 'messages', 'environment.success', 'Ihre .env Konfiguration wurde gespeichert.', '2019-06-18 05:04:47', '2019-06-18 05:06:29');
INSERT INTO `ltm_translations` VALUES (682, 0, 'de', 'messages', 'environment.errors', 'Ihre .env Konfiguration konnte nicht gespeichert werden, Bitte erstellen Sie diese Manuell.', '2019-06-18 05:04:47', '2019-06-18 05:06:29');
INSERT INTO `ltm_translations` VALUES (683, 0, 'de', 'messages', 'final.title', 'Fertig!', '2019-06-18 05:04:47', '2019-06-18 05:06:29');
INSERT INTO `ltm_translations` VALUES (684, 0, 'de', 'messages', 'final.finished', 'Die Anwendung wurde erfolgreich Installiert.', '2019-06-18 05:04:47', '2019-06-18 05:06:29');
INSERT INTO `ltm_translations` VALUES (685, 0, 'de', 'messages', 'final.exit', 'Hier Klicken zum Beenden', '2019-06-18 05:04:47', '2019-06-18 05:06:29');
INSERT INTO `ltm_translations` VALUES (686, 0, 'en', 'app', 'title', 'Title', '2019-06-18 05:04:47', '2019-06-18 05:06:30');
INSERT INTO `ltm_translations` VALUES (687, 0, 'en', 'app', 'back', 'Back', '2019-06-18 05:04:48', '2019-06-18 05:06:31');
INSERT INTO `ltm_translations` VALUES (688, 0, 'en', 'app', 'id', 'Id', '2019-06-18 05:04:48', '2019-06-18 05:06:31');
INSERT INTO `ltm_translations` VALUES (689, 0, 'en', 'app', 'phone', 'Phone', '2019-06-18 05:04:48', '2019-06-18 05:06:32');
INSERT INTO `ltm_translations` VALUES (690, 0, 'en', 'app', 'mobile', 'Mobile', '2019-06-18 05:04:48', '2019-06-18 05:06:32');
INSERT INTO `ltm_translations` VALUES (691, 0, 'en', 'app', 'createdAt', 'Created At', '2019-06-18 05:04:48', '2019-06-18 05:06:32');
INSERT INTO `ltm_translations` VALUES (692, 0, 'en', 'app', 'deadline', 'Deadline', '2019-06-18 05:04:48', '2019-06-18 05:06:32');
INSERT INTO `ltm_translations` VALUES (693, 0, 'en', 'app', 'completion', 'Completion', '2019-06-18 05:04:49', '2019-06-18 05:06:32');
INSERT INTO `ltm_translations` VALUES (694, 0, 'en', 'app', 'address', 'Address', '2019-06-18 05:04:49', '2019-06-18 05:06:32');
INSERT INTO `ltm_translations` VALUES (695, 0, 'en', 'app', 'hideCompletedTasks', 'Hide Completed Tasks', '2019-06-18 05:04:49', '2019-06-18 05:06:32');
INSERT INTO `ltm_translations` VALUES (696, 0, 'en', 'app', 'description', 'Description', '2019-06-18 05:04:50', '2019-06-18 05:06:33');
INSERT INTO `ltm_translations` VALUES (697, 0, 'en', 'app', 'incomplete', 'Incomplete', '2019-06-18 05:04:50', '2019-06-18 05:06:33');
INSERT INTO `ltm_translations` VALUES (698, 0, 'en', 'app', 'selectDateRange', 'Select Date Range', '2019-06-18 05:04:50', '2019-06-18 05:06:34');
INSERT INTO `ltm_translations` VALUES (699, 0, 'en', 'app', 'adminPanel', 'Admin Panel', '2019-06-18 05:04:51', '2019-06-18 05:06:34');
INSERT INTO `ltm_translations` VALUES (700, 0, 'en', 'app', 'clientPanel', 'Client Panel', '2019-06-18 05:04:51', '2019-06-18 05:06:34');
INSERT INTO `ltm_translations` VALUES (701, 0, 'en', 'app', 'paymentOn', 'Payment On', '2019-06-18 05:04:52', '2019-06-18 05:06:35');
INSERT INTO `ltm_translations` VALUES (702, 0, 'en', 'app', 'amount', 'Amount', '2019-06-18 05:04:52', '2019-06-18 05:06:35');
INSERT INTO `ltm_translations` VALUES (703, 0, 'en', 'app', 'gateway', 'Gateway', '2019-06-18 05:04:52', '2019-06-18 05:06:35');
INSERT INTO `ltm_translations` VALUES (704, 0, 'en', 'app', 'transactionId', 'Transaction Id', '2019-06-18 05:04:52', '2019-06-18 05:06:35');
INSERT INTO `ltm_translations` VALUES (705, 0, 'en', 'app', 'timeLog', 'Time Log ', '2019-06-18 05:04:52', '2019-06-18 05:06:35');
INSERT INTO `ltm_translations` VALUES (706, 0, 'en', 'app', 'category', 'Category', '2019-06-18 05:04:53', '2019-06-18 05:06:36');
INSERT INTO `ltm_translations` VALUES (707, 0, 'en', 'app', 'projectTemplate', 'Project Template', '2019-06-18 05:04:53', '2019-06-18 05:06:36');
INSERT INTO `ltm_translations` VALUES (708, 0, 'en', 'app', 'menu.contacts', 'Contacts', '2019-06-18 05:04:55', '2019-06-18 05:06:38');
INSERT INTO `ltm_translations` VALUES (709, 0, 'en', 'app', 'menu.payroll', 'Payroll', '2019-06-18 05:04:56', '2019-06-18 05:06:40');
INSERT INTO `ltm_translations` VALUES (710, 0, 'en', 'app', 'menu.employeeList', 'Employee List', '2019-06-18 05:04:57', '2019-06-18 05:06:41');
INSERT INTO `ltm_translations` VALUES (711, 0, 'en', 'app', 'menu.onlinePayment', 'Online Payment Credential', '2019-06-18 05:04:57', '2019-06-18 05:06:42');
INSERT INTO `ltm_translations` VALUES (712, 0, 'en', 'app', 'menu.method', 'Method', '2019-06-18 05:04:57', '2019-06-18 05:06:42');
INSERT INTO `ltm_translations` VALUES (713, 0, 'en', 'app', 'menu.timeLogSettings', 'Time Log Settings', '2019-06-18 05:04:58', '2019-06-18 05:06:42');
INSERT INTO `ltm_translations` VALUES (714, 0, 'en', 'app', 'menu.addProjectTemplate', 'Project Templates', '2019-06-18 05:04:58', '2019-06-18 05:06:43');
INSERT INTO `ltm_translations` VALUES (715, 0, 'en', 'app', 'menu.template', 'Template', '2019-06-18 05:04:58', '2019-06-18 05:06:43');
INSERT INTO `ltm_translations` VALUES (716, 0, 'en', 'app', 'menu.notificationSettings', 'Notification Settings', '2019-06-18 05:04:58', '2019-06-18 05:06:43');
INSERT INTO `ltm_translations` VALUES (717, 0, 'en', 'app', 'menu.viewArchive', 'View Archive', '2019-06-18 05:04:58', '2019-06-18 05:06:43');
INSERT INTO `ltm_translations` VALUES (718, 0, 'en', 'app', 'menu.clientModule', 'Client Module Setting', '2019-06-18 05:04:58', '2019-06-18 05:06:44');
INSERT INTO `ltm_translations` VALUES (719, 0, 'en', 'app', 'menu.employeeModule', 'Employee Module Setting', '2019-06-18 05:04:58', '2019-06-18 05:06:44');
INSERT INTO `ltm_translations` VALUES (720, 0, 'en', 'app', 'menu.adminModule', 'Admin Module Setting', '2019-06-18 05:04:58', '2019-06-18 05:06:45');
INSERT INTO `ltm_translations` VALUES (721, 0, 'en', 'app', 'menu.documents', 'Documents', '2019-06-18 05:04:58', '2019-06-18 05:06:45');
INSERT INTO `ltm_translations` VALUES (722, 0, 'en', 'app', 'menu.companies', 'Companies', '2019-06-18 05:04:59', '2019-06-18 05:06:45');
INSERT INTO `ltm_translations` VALUES (723, 0, 'en', 'app', 'role', 'User Role', '2019-06-18 05:04:59', '2019-06-18 05:06:46');
INSERT INTO `ltm_translations` VALUES (724, 0, 'en', 'app', 'projectAdminPanel', 'Project Admin Panel', '2019-06-18 05:04:59', '2019-06-18 05:06:46');
INSERT INTO `ltm_translations` VALUES (725, 0, 'en', 'app', 'loginAsProjectAdmin', 'Login As Project Admin', '2019-06-18 05:04:59', '2019-06-18 05:06:46');
INSERT INTO `ltm_translations` VALUES (726, 0, 'en', 'app', 'last', 'Last', '2019-06-18 05:04:59', '2019-06-18 05:06:46');
INSERT INTO `ltm_translations` VALUES (727, 0, 'en', 'app', 'income', 'Income', '2019-06-18 05:04:59', '2019-06-18 05:06:47');
INSERT INTO `ltm_translations` VALUES (728, 0, 'en', 'app', 'expense', 'Expense', '2019-06-18 05:04:59', '2019-06-18 05:06:47');
INSERT INTO `ltm_translations` VALUES (729, 0, 'en', 'app', 'total', 'Total', '2019-06-18 05:04:59', '2019-06-18 05:06:47');
INSERT INTO `ltm_translations` VALUES (730, 0, 'en', 'app', 'week', 'Week', '2019-06-18 05:05:00', '2019-06-18 05:06:48');
INSERT INTO `ltm_translations` VALUES (731, 0, 'en', 'app', 'filterBy', 'Filter by', '2019-06-18 05:05:00', '2019-06-18 05:06:48');
INSERT INTO `ltm_translations` VALUES (732, 0, 'en', 'app', 'others', 'Others', '2019-06-18 05:05:00', '2019-06-18 05:06:48');
INSERT INTO `ltm_translations` VALUES (733, 0, 'en', 'app', 'value', 'Value', '2019-06-18 05:05:00', '2019-06-18 05:06:48');
INSERT INTO `ltm_translations` VALUES (734, 0, 'en', 'app', 'monday', 'Monday', '2019-06-18 05:05:01', '2019-06-18 05:06:49');
INSERT INTO `ltm_translations` VALUES (735, 0, 'en', 'app', 'tuesday', 'Tuesday', '2019-06-18 05:05:01', '2019-06-18 05:06:49');
INSERT INTO `ltm_translations` VALUES (736, 0, 'en', 'app', 'wednesday', 'Wednesday', '2019-06-18 05:05:01', '2019-06-18 05:06:49');
INSERT INTO `ltm_translations` VALUES (737, 0, 'en', 'app', 'thursday', 'Thursday', '2019-06-18 05:05:01', '2019-06-18 05:06:49');
INSERT INTO `ltm_translations` VALUES (738, 0, 'en', 'app', 'friday', 'Friday', '2019-06-18 05:05:01', '2019-06-18 05:06:49');
INSERT INTO `ltm_translations` VALUES (739, 0, 'en', 'app', 'saturday', 'Saturday', '2019-06-18 05:05:01', '2019-06-18 05:06:49');
INSERT INTO `ltm_translations` VALUES (740, 0, 'en', 'app', 'sunday', 'Sunday', '2019-06-18 05:05:01', '2019-06-18 05:06:49');
INSERT INTO `ltm_translations` VALUES (741, 0, 'en', 'app', 'newNotifications', 'New notifications', '2019-06-18 05:05:02', '2019-06-18 05:06:50');
INSERT INTO `ltm_translations` VALUES (742, 0, 'en', 'app', 'from', 'From', '2019-06-18 05:05:02', '2019-06-18 05:06:50');
INSERT INTO `ltm_translations` VALUES (743, 0, 'en', 'app', 'low', 'Low', '2019-06-18 05:05:03', '2019-06-18 05:06:51');
INSERT INTO `ltm_translations` VALUES (744, 0, 'en', 'app', 'Manage role', 'Manage role', '2019-06-18 05:05:03', '2019-06-18 05:06:52');
INSERT INTO `ltm_translations` VALUES (745, 0, 'en', 'app', 'Search:', 'Search:', '2019-06-18 05:05:03', '2019-06-18 05:06:52');
INSERT INTO `ltm_translations` VALUES (746, 0, 'en', 'app', 'selectFile', 'Select File', '2019-06-18 05:05:03', '2019-06-18 05:06:53');
INSERT INTO `ltm_translations` VALUES (747, 0, 'en', 'app', 'login', 'Log In', '2019-06-18 05:05:03', '2019-06-18 05:06:53');
INSERT INTO `ltm_translations` VALUES (748, 0, 'en', 'app', 'noPermission', 'You do not have permission to access this.', '2019-06-18 05:05:04', '2019-06-18 05:06:54');
INSERT INTO `ltm_translations` VALUES (749, 0, 'en', 'app', 'recoverPassword', 'Recover Password', '2019-06-18 05:05:04', '2019-06-18 05:06:54');
INSERT INTO `ltm_translations` VALUES (750, 0, 'en', 'app', 'sendPasswordLink', 'Send Reset Link', '2019-06-18 05:05:04', '2019-06-18 05:06:54');
INSERT INTO `ltm_translations` VALUES (751, 0, 'en', 'app', 'enterEmailInstruction', 'Enter your Email and instructions will be sent to you!', '2019-06-18 05:05:04', '2019-06-18 05:06:54');
INSERT INTO `ltm_translations` VALUES (752, 0, 'en', 'app', 'medium', 'Medium', '2019-06-18 05:05:04', '2019-06-18 05:06:54');
INSERT INTO `ltm_translations` VALUES (753, 0, 'en', 'app', 'high', 'High', '2019-06-18 05:05:04', '2019-06-18 05:06:54');
INSERT INTO `ltm_translations` VALUES (754, 0, 'en', 'app', 'urgent', 'Urgent', '2019-06-18 05:05:04', '2019-06-18 05:06:54');
INSERT INTO `ltm_translations` VALUES (755, 0, 'en', 'app', 'male', 'male', '2019-06-18 05:05:04', '2019-06-18 05:06:55');
INSERT INTO `ltm_translations` VALUES (756, 0, 'en', 'app', 'female', 'female', '2019-06-18 05:05:04', '2019-06-18 05:06:55');
INSERT INTO `ltm_translations` VALUES (757, 0, 'en', 'app', 'source', 'Source', '2019-06-18 05:05:05', '2019-06-18 05:06:56');
INSERT INTO `ltm_translations` VALUES (758, 0, 'en', 'app', 'followUp', 'Follow Up', '2019-06-18 05:05:05', '2019-06-18 05:06:56');
INSERT INTO `ltm_translations` VALUES (759, 0, 'en', 'app', 'createdOn', 'Created On', '2019-06-18 05:05:05', '2019-06-18 05:06:56');
INSERT INTO `ltm_translations` VALUES (760, 0, 'en', 'app', 'notice', 'Note', '2019-06-18 05:05:05', '2019-06-18 05:06:57');
INSERT INTO `ltm_translations` VALUES (761, 0, 'en', 'app', 'minutes', 'Minutes', '2019-06-18 05:05:05', '2019-06-18 05:06:57');
INSERT INTO `ltm_translations` VALUES (762, 0, 'en', 'app', 'onLeave', 'On Leave', '2019-06-18 05:05:05', '2019-06-18 05:06:57');
INSERT INTO `ltm_translations` VALUES (763, 0, 'en', 'app', 'enable', 'Enable', '2019-06-18 05:05:06', '2019-06-18 05:06:57');
INSERT INTO `ltm_translations` VALUES (764, 0, 'en', 'app', 'disable', 'Disable', '2019-06-18 05:05:06', '2019-06-18 05:06:57');
INSERT INTO `ltm_translations` VALUES (765, 0, 'en', 'app', 'paid', 'Paid', '2019-06-18 05:05:06', '2019-06-18 05:06:58');
INSERT INTO `ltm_translations` VALUES (766, 0, 'en', 'app', 'unpaid', 'Unpaid', '2019-06-18 05:05:06', '2019-06-18 05:06:58');
INSERT INTO `ltm_translations` VALUES (767, 0, 'en', 'app', 'partial', 'Partial', '2019-06-18 05:05:06', '2019-06-18 05:06:58');
INSERT INTO `ltm_translations` VALUES (768, 0, 'en', 'app', 'global', 'Global', '2019-06-18 05:05:06', '2019-06-18 05:06:59');
INSERT INTO `ltm_translations` VALUES (769, 0, 'en', 'app', 'superAdminPanel', 'Super Admin Panel', '2019-06-18 05:05:06', '2019-06-18 05:06:59');
INSERT INTO `ltm_translations` VALUES (770, 0, 'en', 'app', 'earnings', 'Earnings', '2019-06-18 05:05:06', '2019-06-18 05:06:59');
INSERT INTO `ltm_translations` VALUES (771, 0, 'en', 'app', 'watchTutorial', 'Watch Tutorial', '2019-06-18 05:05:06', '2019-06-18 05:06:59');
INSERT INTO `ltm_translations` VALUES (772, 0, 'en', 'app', 'latitude', 'Latitude', '2019-06-18 05:05:07', '2019-06-18 05:06:59');
INSERT INTO `ltm_translations` VALUES (773, 0, 'en', 'app', 'longitude', 'Longitude', '2019-06-18 05:05:07', '2019-06-18 05:06:59');
INSERT INTO `ltm_translations` VALUES (774, 0, 'en', 'app', 'front', 'Front', '2019-06-18 05:05:07', '2019-06-18 05:07:00');
INSERT INTO `ltm_translations` VALUES (775, 0, 'en', 'app', 'featureWithImage', 'Feature With Image', '2019-06-18 05:05:07', '2019-06-18 05:07:00');
INSERT INTO `ltm_translations` VALUES (776, 0, 'en', 'app', 'featureWithIcon', 'Feature With Icon', '2019-06-18 05:05:07', '2019-06-18 05:07:01');
INSERT INTO `ltm_translations` VALUES (777, 0, 'en', 'app', 'gstNumber', 'GST Number', '2019-06-18 05:05:07', '2019-06-18 05:07:01');
INSERT INTO `ltm_translations` VALUES (778, 0, 'en', 'app', 'showGst', 'Show GST Number', '2019-06-18 05:05:08', '2019-06-18 05:07:01');
INSERT INTO `ltm_translations` VALUES (779, 0, 'en', 'app', 'mobileNumber', 'Mobile Number', '2019-06-18 05:05:08', '2019-06-18 05:07:02');
INSERT INTO `ltm_translations` VALUES (780, 0, 'en', 'app', 'password', 'Password', '2019-06-18 05:05:08', '2019-06-18 05:07:02');
INSERT INTO `ltm_translations` VALUES (781, 0, 'en', 'app', 'max', 'Max', '2019-06-18 05:05:08', '2019-06-18 05:07:02');
INSERT INTO `ltm_translations` VALUES (782, 0, 'en', 'app', 'annual', 'Annual', '2019-06-18 05:05:08', '2019-06-18 05:07:02');
INSERT INTO `ltm_translations` VALUES (783, 0, 'en', 'app', 'monthly', 'Monthly', '2019-06-18 05:05:08', '2019-06-18 05:07:02');
INSERT INTO `ltm_translations` VALUES (784, 0, 'en', 'app', 'webhook', 'Webhook URL', '2019-06-18 05:05:08', '2019-06-18 05:07:02');
INSERT INTO `ltm_translations` VALUES (785, 0, 'en', 'auth', 'failed', 'These credentials do not match our records.', '2019-06-18 05:05:09', '2019-06-18 05:07:03');
INSERT INTO `ltm_translations` VALUES (786, 0, 'en', 'auth', 'throttle', 'Too many login attempts. Please try again in :seconds seconds.', '2019-06-18 05:05:09', '2019-06-18 05:07:03');
INSERT INTO `ltm_translations` VALUES (787, 0, 'en', 'email', 'planUpdate.text', 'named company has been updated plan', '2019-06-18 05:05:10', '2019-06-18 05:07:06');
INSERT INTO `ltm_translations` VALUES (788, 0, 'en', 'email', 'planPurchase.text', 'Company purchased plan', '2019-06-18 05:05:11', '2019-06-18 05:07:07');
INSERT INTO `ltm_translations` VALUES (789, 0, 'en', 'installer_messages', 'title', 'Laravel Installer', '2019-06-18 05:05:11', '2019-06-18 05:07:07');
INSERT INTO `ltm_translations` VALUES (790, 0, 'en', 'installer_messages', 'next', 'Next Step', '2019-06-18 05:05:11', '2019-06-18 05:07:08');
INSERT INTO `ltm_translations` VALUES (791, 0, 'en', 'installer_messages', 'finish', 'Install', '2019-06-18 05:05:11', '2019-06-18 05:07:08');
INSERT INTO `ltm_translations` VALUES (792, 0, 'en', 'installer_messages', 'welcome.title', 'Welcome To The Installer', '2019-06-18 05:05:11', '2019-06-18 05:07:08');
INSERT INTO `ltm_translations` VALUES (793, 0, 'en', 'installer_messages', 'welcome.message', 'Welcome to the setup wizard.', '2019-06-18 05:05:11', '2019-06-18 05:07:08');
INSERT INTO `ltm_translations` VALUES (794, 0, 'en', 'installer_messages', 'requirements.title', 'Server Requirements', '2019-06-18 05:05:11', '2019-06-18 05:07:08');
INSERT INTO `ltm_translations` VALUES (795, 0, 'en', 'installer_messages', 'permissions.title', 'Permissions', '2019-06-18 05:05:11', '2019-06-18 05:07:08');
INSERT INTO `ltm_translations` VALUES (796, 0, 'en', 'installer_messages', 'environment.title', 'Database Configuration', '2019-06-18 05:05:11', '2019-06-18 05:07:08');
INSERT INTO `ltm_translations` VALUES (797, 0, 'en', 'installer_messages', 'environment.save', 'Save .env', '2019-06-18 05:05:11', '2019-06-18 05:07:08');
INSERT INTO `ltm_translations` VALUES (798, 0, 'en', 'installer_messages', 'environment.success', 'Your .env file settings have been saved.', '2019-06-18 05:05:11', '2019-06-18 05:07:08');
INSERT INTO `ltm_translations` VALUES (799, 0, 'en', 'installer_messages', 'environment.errors', 'Unable to save the .env file, Please create it manually.', '2019-06-18 05:05:11', '2019-06-18 05:07:09');
INSERT INTO `ltm_translations` VALUES (800, 0, 'en', 'installer_messages', 'install', 'Install', '2019-06-18 05:05:11', '2019-06-18 05:07:09');
INSERT INTO `ltm_translations` VALUES (801, 0, 'en', 'installer_messages', 'final.title', 'Finished', '2019-06-18 05:05:11', '2019-06-18 05:07:09');
INSERT INTO `ltm_translations` VALUES (802, 0, 'en', 'installer_messages', 'final.finished', 'Application has been successfully installed.', '2019-06-18 05:05:11', '2019-06-18 05:07:09');
INSERT INTO `ltm_translations` VALUES (803, 0, 'en', 'installer_messages', 'final.exit', 'Click here to exit', '2019-06-18 05:05:12', '2019-06-18 05:07:09');
INSERT INTO `ltm_translations` VALUES (804, 0, 'en', 'installer_messages', 'checkPermissionAgain', ' Check Permission Again', '2019-06-18 05:05:12', '2019-06-18 05:07:09');
INSERT INTO `ltm_translations` VALUES (805, 0, 'en', 'messages', 'Login As Employee', 'Login As Employee', '2019-06-18 05:05:12', '2019-06-18 05:07:10');
INSERT INTO `ltm_translations` VALUES (806, 0, 'en', 'messages', 'newMemberAddedToTheProject', 'New member added to the project.', '2019-06-18 05:05:12', '2019-06-18 05:07:10');
INSERT INTO `ltm_translations` VALUES (807, 0, 'en', 'messages', 'clientUploadedAFileToTheProject', '(Client) uploaded a file to the project.', '2019-06-18 05:05:13', '2019-06-18 05:07:11');
INSERT INTO `ltm_translations` VALUES (808, 0, 'en', 'messages', 'noProjectFound', 'No Project Found.', '2019-06-18 05:05:13', '2019-06-18 05:07:11');
INSERT INTO `ltm_translations` VALUES (809, 0, 'en', 'messages', 'noProjectAssigned', 'No project assigned to you.', '2019-06-18 05:05:13', '2019-06-18 05:07:11');
INSERT INTO `ltm_translations` VALUES (810, 0, 'en', 'messages', 'noActivityByThisUser', 'No activity by the user.', '2019-06-18 05:05:13', '2019-06-18 05:07:12');
INSERT INTO `ltm_translations` VALUES (811, 0, 'en', 'messages', 'noProjectCategoryAdded', 'No project category added.', '2019-06-18 05:05:13', '2019-06-18 05:07:12');
INSERT INTO `ltm_translations` VALUES (812, 0, 'en', 'messages', 'noClientAdded', 'No client added.', '2019-06-18 05:05:13', '2019-06-18 05:07:12');
INSERT INTO `ltm_translations` VALUES (813, 0, 'en', 'messages', 'noActiveTimer', 'No active timer.', '2019-06-18 05:05:13', '2019-06-18 05:07:12');
INSERT INTO `ltm_translations` VALUES (814, 0, 'en', 'messages', 'noOpenIssues', 'No open issues.', '2019-06-18 05:05:13', '2019-06-18 05:07:13');
INSERT INTO `ltm_translations` VALUES (815, 0, 'en', 'messages', 'defaultColorNote', 'If you will not choose any color blue will be default', '2019-06-18 05:05:14', '2019-06-18 05:07:13');
INSERT INTO `ltm_translations` VALUES (816, 0, 'en', 'messages', 'categoryUpdated', 'Category updated successfully.', '2019-06-18 05:05:16', '2019-06-18 05:07:17');
INSERT INTO `ltm_translations` VALUES (817, 0, 'en', 'messages', 'noNotice', 'No notice published.', '2019-06-18 05:05:17', '2019-06-18 05:07:18');
INSERT INTO `ltm_translations` VALUES (818, 0, 'en', 'messages', 'templateTaskDeletedSuccessfully', 'Template Task deleted successfully.', '2019-06-18 05:05:18', '2019-06-18 05:07:20');
INSERT INTO `ltm_translations` VALUES (819, 0, 'en', 'messages', 'noProjectTemplateAdded', 'No project template added.', '2019-06-18 05:05:18', '2019-06-18 05:07:21');
INSERT INTO `ltm_translations` VALUES (820, 0, 'en', 'messages', 'selectTemplate', 'Select Template', '2019-06-18 05:05:18', '2019-06-18 05:07:21');
INSERT INTO `ltm_translations` VALUES (821, 0, 'en', 'messages', 'monthWiseDataNotFound', 'No Holiday found for this month.', '2019-06-18 05:05:18', '2019-06-18 05:07:21');
INSERT INTO `ltm_translations` VALUES (822, 0, 'en', 'messages', 'noDocsFound', 'No Document found.', '2019-06-18 05:05:18', '2019-06-18 05:07:21');
INSERT INTO `ltm_translations` VALUES (823, 0, 'en', 'messages', 'welcome.message', 'Welcome to the setup wizard', '2019-06-18 05:05:19', '2019-06-18 05:07:21');
INSERT INTO `ltm_translations` VALUES (824, 0, 'en', 'messages', 'welcome.title', 'Welcome to the installer', '2019-06-18 05:05:19', '2019-06-18 05:07:22');
INSERT INTO `ltm_translations` VALUES (825, 0, 'en', 'messages', 'title', 'Laravel installer', '2019-06-18 05:05:19', '2019-06-18 05:07:22');
INSERT INTO `ltm_translations` VALUES (826, 0, 'en', 'messages', 'requirements.title', 'formalities', '2019-06-18 05:05:19', '2019-06-18 05:07:22');
INSERT INTO `ltm_translations` VALUES (827, 0, 'en', 'messages', 'permissions.title', 'Permissions', '2019-06-18 05:05:19', '2019-06-18 05:07:22');
INSERT INTO `ltm_translations` VALUES (828, 0, 'en', 'messages', 'next', 'Following', '2019-06-18 05:05:19', '2019-06-18 05:07:22');
INSERT INTO `ltm_translations` VALUES (829, 0, 'en', 'messages', 'finish', 'Install', '2019-06-18 05:05:19', '2019-06-18 05:07:22');
INSERT INTO `ltm_translations` VALUES (830, 0, 'en', 'messages', 'final.title', 'Finalized.', '2019-06-18 05:05:19', '2019-06-18 05:07:22');
INSERT INTO `ltm_translations` VALUES (831, 0, 'en', 'messages', 'final.finished', 'The application has been installed successfully!', '2019-06-18 05:05:19', '2019-06-18 05:07:22');
INSERT INTO `ltm_translations` VALUES (832, 0, 'en', 'messages', 'final.exit', 'Click here to exit.', '2019-06-18 05:05:19', '2019-06-18 05:07:22');
INSERT INTO `ltm_translations` VALUES (833, 0, 'en', 'messages', 'environment.errors', 'It is not possible to create the .env file, please try manually.', '2019-06-18 05:05:19', '2019-06-18 05:07:22');
INSERT INTO `ltm_translations` VALUES (834, 0, 'en', 'messages', 'environment.save', 'Save .env file', '2019-06-18 05:05:19', '2019-06-18 05:07:22');
INSERT INTO `ltm_translations` VALUES (835, 0, 'en', 'messages', 'environment.success', 'Changes to your .env file have been saved.', '2019-06-18 05:05:19', '2019-06-18 05:07:23');
INSERT INTO `ltm_translations` VALUES (836, 0, 'en', 'messages', 'environment.title', 'Settings of the environment', '2019-06-18 05:05:19', '2019-06-18 05:07:23');
INSERT INTO `ltm_translations` VALUES (837, 0, 'en', 'messages', 'noProjectCategory', 'No project category found.', '2019-06-18 05:05:19', '2019-06-18 05:07:23');
INSERT INTO `ltm_translations` VALUES (838, 0, 'en', 'messages', 'noTaskCategory', 'No task category found.', '2019-06-18 05:05:19', '2019-06-18 05:07:23');
INSERT INTO `ltm_translations` VALUES (839, 0, 'en', 'messages', 'noGroupAdded', 'No group added.', '2019-06-18 05:05:20', '2019-06-18 05:07:25');
INSERT INTO `ltm_translations` VALUES (840, 0, 'en', 'messages', 'noFeedbackReceived', 'No feedback received.', '2019-06-18 05:05:22', '2019-06-18 05:07:27');
INSERT INTO `ltm_translations` VALUES (841, 0, 'en', 'messages', 'customFieldCreateSuccess', 'Custom field created successfully.', '2019-06-18 05:05:22', '2019-06-18 05:07:28');
INSERT INTO `ltm_translations` VALUES (842, 0, 'en', 'messages', 'permissionUpdated', 'Permission updated successfully.', '2019-06-18 05:05:22', '2019-06-18 05:07:28');
INSERT INTO `ltm_translations` VALUES (843, 0, 'en', 'messages', 'noRoleMemberFound', 'No member is assigned to this role.', '2019-06-18 05:05:22', '2019-06-18 05:07:28');
INSERT INTO `ltm_translations` VALUES (844, 0, 'en', 'messages', 'noRoleFound', 'No role found.', '2019-06-18 05:05:22', '2019-06-18 05:07:29');
INSERT INTO `ltm_translations` VALUES (845, 0, 'en', 'messages', 'noLeaveTypeAdded', 'No leave type added.', '2019-06-18 05:05:22', '2019-06-18 05:07:29');
INSERT INTO `ltm_translations` VALUES (846, 0, 'en', 'messages', 'leaveDeleteSuccess', 'Leave deleted successfully.', '2019-06-18 05:05:22', '2019-06-18 05:07:29');
INSERT INTO `ltm_translations` VALUES (847, 0, 'en', 'messages', 'updateBackupNotice', 'Take backup of files and database before updating.', '2019-06-18 05:05:23', '2019-06-18 05:07:30');
INSERT INTO `ltm_translations` VALUES (848, 0, 'en', 'messages', 'fieldBlank', 'Field cannot be blank.', '2019-06-18 05:05:23', '2019-06-18 05:07:30');
INSERT INTO `ltm_translations` VALUES (849, 0, 'en', 'messages', 'defaultRoleCantDelete', 'Default role can not be deleted.', '2019-06-18 05:05:23', '2019-06-18 05:07:31');
INSERT INTO `ltm_translations` VALUES (850, 0, 'en', 'messages', 'noTaskAddedToProject', 'No task added to this project.', '2019-06-18 05:05:25', '2019-06-18 05:07:34');
INSERT INTO `ltm_translations` VALUES (851, 0, 'en', 'messages', 'noAttendanceDetailTOday', 'No attendance detail for today.', '2019-06-18 05:05:26', '2019-06-18 05:07:34');
INSERT INTO `ltm_translations` VALUES (852, 0, 'en', 'messages', 'noAttendanceDetail', 'No attendance detail.', '2019-06-18 05:05:26', '2019-06-18 05:07:34');
INSERT INTO `ltm_translations` VALUES (853, 0, 'en', 'messages', 'noTaskCategoryAdded', 'No task category added.', '2019-06-18 05:05:26', '2019-06-18 05:07:34');
INSERT INTO `ltm_translations` VALUES (854, 0, 'en', 'messages', 'NewCompanyRegistered', 'New company registered.', '2019-06-18 05:05:27', '2019-06-18 05:07:36');
INSERT INTO `ltm_translations` VALUES (855, 0, 'en', 'messages', 'planPurchaseByCompany', 'Plan purchased by company', '2019-06-18 05:05:27', '2019-06-18 05:07:36');
INSERT INTO `ltm_translations` VALUES (856, 0, 'en', 'messages', 'planUpdatedByCompany', 'Plan updated by company', '2019-06-18 05:05:27', '2019-06-18 05:07:36');
INSERT INTO `ltm_translations` VALUES (857, 0, 'en', 'messages', 'feature.addedSuccess', 'Feature added successfully.', '2019-06-18 05:05:27', '2019-06-18 05:07:37');
INSERT INTO `ltm_translations` VALUES (858, 0, 'en', 'messages', 'feature.updatedSuccess', 'Feature updated successfully.', '2019-06-18 05:05:27', '2019-06-18 05:07:37');
INSERT INTO `ltm_translations` VALUES (859, 0, 'en', 'messages', 'feature.deletedSuccess', 'Feature deleted successfully.', '2019-06-18 05:05:27', '2019-06-18 05:07:37');
INSERT INTO `ltm_translations` VALUES (860, 0, 'en', 'messages', 'reminderMailSuccess', 'Reminder sent successfully', '2019-06-18 05:05:28', '2019-06-18 05:07:38');
INSERT INTO `ltm_translations` VALUES (861, 0, 'en', 'messages', 'employeeSelfTask', 'Employee can create task for self.', '2019-06-18 05:05:28', '2019-06-18 05:07:39');
INSERT INTO `ltm_translations` VALUES (862, 0, 'en', 'messages', 'licenseExpiredNote', 'License has been expired please purchase.', '2019-06-18 05:05:28', '2019-06-18 05:07:39');
INSERT INTO `ltm_translations` VALUES (863, 0, 'en', 'modules', 'dashboard.totalPaidInvoices', 'Paid Invoices', '2019-06-18 05:05:28', '2019-06-18 05:07:40');
INSERT INTO `ltm_translations` VALUES (864, 0, 'en', 'modules', 'dashboard.totalPendingIssues', 'Total Pending Issues', '2019-06-18 05:05:29', '2019-06-18 05:07:40');
INSERT INTO `ltm_translations` VALUES (865, 0, 'en', 'modules', 'dashboard.recentEarnings', 'Recent Earnings', '2019-06-18 05:05:29', '2019-06-18 05:07:41');
INSERT INTO `ltm_translations` VALUES (866, 0, 'en', 'modules', 'dashboard.overdueTasks', 'Overdue Tasks', '2019-06-18 05:05:29', '2019-06-18 05:07:41');
INSERT INTO `ltm_translations` VALUES (867, 0, 'en', 'modules', 'dashboard.pendingClientIssues', 'Pending Issues', '2019-06-18 05:05:29', '2019-06-18 05:07:41');
INSERT INTO `ltm_translations` VALUES (868, 0, 'en', 'modules', 'dashboard.projectActivityTimeline', 'Project Activity Timeline', '2019-06-18 05:05:29', '2019-06-18 05:07:41');
INSERT INTO `ltm_translations` VALUES (869, 0, 'en', 'modules', 'dashboard.userActivityTimeline', 'User Activity Timeline', '2019-06-18 05:05:29', '2019-06-18 05:07:41');
INSERT INTO `ltm_translations` VALUES (870, 0, 'en', 'modules', 'dashboard.dueDate', 'Due Date', '2019-06-18 05:05:29', '2019-06-18 05:07:41');
INSERT INTO `ltm_translations` VALUES (871, 0, 'en', 'modules', 'dashboard.newTickets', 'New Tickets', '2019-06-18 05:05:29', '2019-06-18 05:07:42');
INSERT INTO `ltm_translations` VALUES (872, 0, 'en', 'modules', 'dashboard.followUpDate', 'Follow Up Date', '2019-06-18 05:05:29', '2019-06-18 05:07:42');
INSERT INTO `ltm_translations` VALUES (873, 0, 'en', 'modules', 'dashboard.pendingFollowUp', 'Pending FollowUp', '2019-06-18 05:05:29', '2019-06-18 05:07:42');
INSERT INTO `ltm_translations` VALUES (874, 0, 'en', 'modules', 'dashboard.totalLeads', 'Total Leads', '2019-06-18 05:05:30', '2019-06-18 05:07:42');
INSERT INTO `ltm_translations` VALUES (875, 0, 'en', 'modules', 'dashboard.totalConvertedClient', 'Total Client Convert', '2019-06-18 05:05:30', '2019-06-18 05:07:42');
INSERT INTO `ltm_translations` VALUES (876, 0, 'en', 'modules', 'dashboard.totalPendingFollowUps', 'Total Pending Follow Up', '2019-06-18 05:05:30', '2019-06-18 05:07:42');
INSERT INTO `ltm_translations` VALUES (877, 0, 'en', 'modules', 'dashboard.nextFollowUp', 'Next Follow Up', '2019-06-18 05:05:30', '2019-06-18 05:07:42');
INSERT INTO `ltm_translations` VALUES (878, 0, 'en', 'modules', 'dashboard.holidayCheck', 'Today is Holiday for', '2019-06-18 05:05:30', '2019-06-18 05:07:43');
INSERT INTO `ltm_translations` VALUES (879, 0, 'en', 'modules', 'dashboard.totalArchiveProjects', 'Total Archived Projects', '2019-06-18 05:05:30', '2019-06-18 05:07:43');
INSERT INTO `ltm_translations` VALUES (880, 0, 'en', 'modules', 'client.companyDetails', 'Company Details', '2019-06-18 05:05:30', '2019-06-18 05:07:43');
INSERT INTO `ltm_translations` VALUES (881, 0, 'en', 'modules', 'client.companyName', 'Company Name', '2019-06-18 05:05:30', '2019-06-18 05:07:44');
INSERT INTO `ltm_translations` VALUES (882, 0, 'en', 'modules', 'client.website', 'Website', '2019-06-18 05:05:30', '2019-06-18 05:07:44');
INSERT INTO `ltm_translations` VALUES (883, 0, 'en', 'modules', 'client.address', 'Address', '2019-06-18 05:05:30', '2019-06-18 05:07:44');
INSERT INTO `ltm_translations` VALUES (884, 0, 'en', 'modules', 'client.clientDetails', 'Client Details', '2019-06-18 05:05:30', '2019-06-18 05:07:44');
INSERT INTO `ltm_translations` VALUES (885, 0, 'en', 'modules', 'client.clientEmail', 'Client Email', '2019-06-18 05:05:31', '2019-06-18 05:07:44');
INSERT INTO `ltm_translations` VALUES (886, 0, 'en', 'modules', 'client.emailNote', 'Client will login using this email.', '2019-06-18 05:05:31', '2019-06-18 05:07:44');
INSERT INTO `ltm_translations` VALUES (887, 0, 'en', 'modules', 'client.mobile', 'Mobile', '2019-06-18 05:05:31', '2019-06-18 05:07:45');
INSERT INTO `ltm_translations` VALUES (888, 0, 'en', 'modules', 'client.addNewClient', 'Add New Client', '2019-06-18 05:05:31', '2019-06-18 05:07:45');
INSERT INTO `ltm_translations` VALUES (889, 0, 'en', 'modules', 'client.projectName', 'Project Name', '2019-06-18 05:05:31', '2019-06-18 05:07:45');
INSERT INTO `ltm_translations` VALUES (890, 0, 'en', 'modules', 'client.startedOn', 'Started On', '2019-06-18 05:05:31', '2019-06-18 05:07:45');
INSERT INTO `ltm_translations` VALUES (891, 0, 'en', 'modules', 'client.deadline', 'Deadline', '2019-06-18 05:05:31', '2019-06-18 05:07:45');
INSERT INTO `ltm_translations` VALUES (892, 0, 'en', 'modules', 'client.generateRandomPassword', 'Generate Random Password', '2019-06-18 05:05:31', '2019-06-18 05:07:46');
INSERT INTO `ltm_translations` VALUES (893, 0, 'en', 'modules', 'client.offline', 'Offline', '2019-06-18 05:05:31', '2019-06-18 05:07:46');
INSERT INTO `ltm_translations` VALUES (894, 0, 'en', 'modules', 'client.online', 'Online', '2019-06-18 05:05:32', '2019-06-18 05:07:46');
INSERT INTO `ltm_translations` VALUES (895, 0, 'en', 'modules', 'client.all', 'All', '2019-06-18 05:05:32', '2019-06-18 05:07:46');
INSERT INTO `ltm_translations` VALUES (896, 0, 'en', 'modules', 'contacts.contactName', 'Contact Name', '2019-06-18 05:05:32', '2019-06-18 05:07:46');
INSERT INTO `ltm_translations` VALUES (897, 0, 'en', 'modules', 'employees.addNewEmployee', 'Add New Employee', '2019-06-18 05:05:32', '2019-06-18 05:07:46');
INSERT INTO `ltm_translations` VALUES (898, 0, 'en', 'modules', 'employees.employeeEmail', 'Employee Email', '2019-06-18 05:05:32', '2019-06-18 05:07:47');
INSERT INTO `ltm_translations` VALUES (899, 0, 'en', 'modules', 'employees.emailNote', 'Employee will login using this email.', '2019-06-18 05:05:32', '2019-06-18 05:07:47');
INSERT INTO `ltm_translations` VALUES (900, 0, 'en', 'modules', 'employees.employeePassword', 'Password', '2019-06-18 05:05:32', '2019-06-18 05:07:47');
INSERT INTO `ltm_translations` VALUES (901, 0, 'en', 'modules', 'employees.jobTitle', 'Job Title', '2019-06-18 05:05:32', '2019-06-18 05:07:47');
INSERT INTO `ltm_translations` VALUES (902, 0, 'en', 'modules', 'employees.hourlyRate', 'Hourly Rate', '2019-06-18 05:05:33', '2019-06-18 05:07:47');
INSERT INTO `ltm_translations` VALUES (903, 0, 'en', 'modules', 'employees.tasksDone', 'Tasks Done', '2019-06-18 05:05:33', '2019-06-18 05:07:48');
INSERT INTO `ltm_translations` VALUES (904, 0, 'en', 'modules', 'employees.hoursLogged', 'Hours Logged', '2019-06-18 05:05:33', '2019-06-18 05:07:48');
INSERT INTO `ltm_translations` VALUES (905, 0, 'en', 'modules', 'employees.activity', 'Activity', '2019-06-18 05:05:33', '2019-06-18 05:07:48');
INSERT INTO `ltm_translations` VALUES (906, 0, 'en', 'modules', 'employees.profile', 'Profile', '2019-06-18 05:05:33', '2019-06-18 05:07:48');
INSERT INTO `ltm_translations` VALUES (907, 0, 'en', 'modules', 'employees.fullName', 'Full Name', '2019-06-18 05:05:33', '2019-06-18 05:07:48');
INSERT INTO `ltm_translations` VALUES (908, 0, 'en', 'modules', 'employees.startTime', 'Start Time', '2019-06-18 05:05:33', '2019-06-18 05:07:48');
INSERT INTO `ltm_translations` VALUES (909, 0, 'en', 'modules', 'employees.endTime', 'End Time', '2019-06-18 05:05:33', '2019-06-18 05:07:48');
INSERT INTO `ltm_translations` VALUES (910, 0, 'en', 'modules', 'employees.totalHours', 'Total Hours', '2019-06-18 05:05:34', '2019-06-18 05:07:48');
INSERT INTO `ltm_translations` VALUES (911, 0, 'en', 'modules', 'employees.memo', 'Memo', '2019-06-18 05:05:34', '2019-06-18 05:07:48');
INSERT INTO `ltm_translations` VALUES (912, 0, 'en', 'modules', 'employees.joiningDate', 'Joining Date', '2019-06-18 05:05:34', '2019-06-18 05:07:49');
INSERT INTO `ltm_translations` VALUES (913, 0, 'en', 'modules', 'employees.gender', 'Gender', '2019-06-18 05:05:34', '2019-06-18 05:07:49');
INSERT INTO `ltm_translations` VALUES (914, 0, 'en', 'modules', 'employees.title', 'Select Employee', '2019-06-18 05:05:34', '2019-06-18 05:07:49');
INSERT INTO `ltm_translations` VALUES (915, 0, 'en', 'modules', 'employees.role', 'Role', '2019-06-18 05:05:34', '2019-06-18 05:07:49');
INSERT INTO `ltm_translations` VALUES (916, 0, 'en', 'modules', 'employees.lastDate', 'Last Date', '2019-06-18 05:05:34', '2019-06-18 05:07:49');
INSERT INTO `ltm_translations` VALUES (917, 0, 'en', 'modules', 'projects.addNewProject', 'Add New Project', '2019-06-18 05:05:34', '2019-06-18 05:07:49');
INSERT INTO `ltm_translations` VALUES (918, 0, 'en', 'modules', 'projects.projectName', 'Project Name', '2019-06-18 05:05:34', '2019-06-18 05:07:49');
INSERT INTO `ltm_translations` VALUES (919, 0, 'en', 'modules', 'projects.projectMembers', 'Project Members', '2019-06-18 05:05:34', '2019-06-18 05:07:49');
INSERT INTO `ltm_translations` VALUES (920, 0, 'en', 'modules', 'projects.startDate', 'Start Date', '2019-06-18 05:05:34', '2019-06-18 05:07:49');
INSERT INTO `ltm_translations` VALUES (921, 0, 'en', 'modules', 'projects.deadline', 'Deadline', '2019-06-18 05:05:34', '2019-06-18 05:07:50');
INSERT INTO `ltm_translations` VALUES (922, 0, 'en', 'modules', 'projects.projectSummary', 'Project Summary', '2019-06-18 05:05:34', '2019-06-18 05:07:50');
INSERT INTO `ltm_translations` VALUES (923, 0, 'en', 'modules', 'projects.note', 'Note', '2019-06-18 05:05:35', '2019-06-18 05:07:50');
INSERT INTO `ltm_translations` VALUES (924, 0, 'en', 'modules', 'projects.projectCategory', 'Project Category', '2019-06-18 05:05:35', '2019-06-18 05:07:50');
INSERT INTO `ltm_translations` VALUES (925, 0, 'en', 'modules', 'projects.clientFeedback', 'Client Feedback', '2019-06-18 05:05:35', '2019-06-18 05:07:50');
INSERT INTO `ltm_translations` VALUES (926, 0, 'en', 'modules', 'projects.projectCompletionStatus', 'Project Completion Status', '2019-06-18 05:05:35', '2019-06-18 05:07:50');
INSERT INTO `ltm_translations` VALUES (927, 0, 'en', 'modules', 'projects.overview', 'Overview', '2019-06-18 05:05:35', '2019-06-18 05:07:51');
INSERT INTO `ltm_translations` VALUES (928, 0, 'en', 'modules', 'projects.files', 'Files', '2019-06-18 05:05:35', '2019-06-18 05:07:51');
INSERT INTO `ltm_translations` VALUES (929, 0, 'en', 'modules', 'projects.whoWorking', 'Who\'s Working', '2019-06-18 05:05:35', '2019-06-18 05:07:51');
INSERT INTO `ltm_translations` VALUES (930, 0, 'en', 'modules', 'projects.activeSince', 'Active Since', '2019-06-18 05:05:35', '2019-06-18 05:07:51');
INSERT INTO `ltm_translations` VALUES (931, 0, 'en', 'modules', 'projects.openTasks', 'Open Tasks', '2019-06-18 05:05:35', '2019-06-18 05:07:51');
INSERT INTO `ltm_translations` VALUES (932, 0, 'en', 'modules', 'projects.daysLeft', 'Days Left', '2019-06-18 05:05:35', '2019-06-18 05:07:51');
INSERT INTO `ltm_translations` VALUES (933, 0, 'en', 'modules', 'projects.hoursLogged', 'Hours Logged', '2019-06-18 05:05:35', '2019-06-18 05:07:51');
INSERT INTO `ltm_translations` VALUES (934, 0, 'en', 'modules', 'projects.issuesPending', 'Issues Pending', '2019-06-18 05:05:35', '2019-06-18 05:07:51');
INSERT INTO `ltm_translations` VALUES (935, 0, 'en', 'modules', 'projects.activityTimeline', 'Activity Timeline', '2019-06-18 05:05:35', '2019-06-18 05:07:51');
INSERT INTO `ltm_translations` VALUES (936, 0, 'en', 'modules', 'projects.calculateTasksProgress', 'Calculate progress through tasks', '2019-06-18 05:05:36', '2019-06-18 05:07:52');
INSERT INTO `ltm_translations` VALUES (937, 0, 'en', 'modules', 'projects.clientViewTask', 'Client can view tasks of this project', '2019-06-18 05:05:36', '2019-06-18 05:07:52');
INSERT INTO `ltm_translations` VALUES (938, 0, 'en', 'modules', 'projects.manualTimelog', 'Allow manual time logs?', '2019-06-18 05:05:36', '2019-06-18 05:07:52');
INSERT INTO `ltm_translations` VALUES (939, 0, 'en', 'modules', 'projects.clientTaskNotification', 'Send task notification to client?', '2019-06-18 05:05:36', '2019-06-18 05:07:53');
INSERT INTO `ltm_translations` VALUES (940, 0, 'en', 'modules', 'projects.allProject', 'All Projects', '2019-06-18 05:05:36', '2019-06-18 05:07:53');
INSERT INTO `ltm_translations` VALUES (941, 0, 'en', 'modules', 'projects.withoutDeadline', 'Without deadline', '2019-06-18 05:05:36', '2019-06-18 05:07:53');
INSERT INTO `ltm_translations` VALUES (942, 0, 'en', 'modules', 'tasks.lastCreated', 'Last Created', '2019-06-18 05:05:36', '2019-06-18 05:07:53');
INSERT INTO `ltm_translations` VALUES (943, 0, 'en', 'modules', 'tasks.dueSoon', 'Due Soon', '2019-06-18 05:05:36', '2019-06-18 05:07:53');
INSERT INTO `ltm_translations` VALUES (944, 0, 'en', 'modules', 'tasks.columnName', 'Column Name', '2019-06-18 05:05:37', '2019-06-18 05:07:54');
INSERT INTO `ltm_translations` VALUES (945, 0, 'en', 'modules', 'tasks.labelColor', 'Label Color', '2019-06-18 05:05:37', '2019-06-18 05:07:54');
INSERT INTO `ltm_translations` VALUES (946, 0, 'en', 'modules', 'tasks.position', 'Position', '2019-06-18 05:05:37', '2019-06-18 05:07:55');
INSERT INTO `ltm_translations` VALUES (947, 0, 'en', 'modules', 'tasks.taskCategory', 'Task Category', '2019-06-18 05:05:38', '2019-06-18 05:07:55');
INSERT INTO `ltm_translations` VALUES (948, 0, 'en', 'modules', 'tasks.category', 'Category', '2019-06-18 05:05:38', '2019-06-18 05:07:55');
INSERT INTO `ltm_translations` VALUES (949, 0, 'en', 'modules', 'invoices.paid', 'Paid', '2019-06-18 05:05:38', '2019-06-18 05:07:56');
INSERT INTO `ltm_translations` VALUES (950, 0, 'en', 'modules', 'invoices.unpaid', 'Unpaid', '2019-06-18 05:05:38', '2019-06-18 05:07:56');
INSERT INTO `ltm_translations` VALUES (951, 0, 'en', 'modules', 'invoices.invoiceDate', 'Invoice Date', '2019-06-18 05:05:38', '2019-06-18 05:07:57');
INSERT INTO `ltm_translations` VALUES (952, 0, 'en', 'modules', 'invoices.subTotal', 'Sub Total', '2019-06-18 05:05:39', '2019-06-18 05:07:57');
INSERT INTO `ltm_translations` VALUES (953, 0, 'en', 'modules', 'invoices.total', 'Total', '2019-06-18 05:05:39', '2019-06-18 05:07:58');
INSERT INTO `ltm_translations` VALUES (954, 0, 'en', 'modules', 'invoices.billedTo', 'Billed To', '2019-06-18 05:05:39', '2019-06-18 05:07:58');
INSERT INTO `ltm_translations` VALUES (955, 0, 'en', 'modules', 'invoices.generatedBy', 'Generated By', '2019-06-18 05:05:39', '2019-06-18 05:07:58');
INSERT INTO `ltm_translations` VALUES (956, 0, 'en', 'modules', 'invoices.price', 'Price', '2019-06-18 05:05:39', '2019-06-18 05:07:59');
INSERT INTO `ltm_translations` VALUES (957, 0, 'en', 'modules', 'invoices.isRecurringPayment', 'Is it a recurring payments?', '2019-06-18 05:05:39', '2019-06-18 05:07:59');
INSERT INTO `ltm_translations` VALUES (958, 0, 'en', 'modules', 'invoices.billingCycle', 'Billing Cycle', '2019-06-18 05:05:40', '2019-06-18 05:07:59');
INSERT INTO `ltm_translations` VALUES (959, 0, 'en', 'modules', 'invoices.billingFrequency', 'Billing Frequency', '2019-06-18 05:05:40', '2019-06-18 05:07:59');
INSERT INTO `ltm_translations` VALUES (960, 0, 'en', 'modules', 'invoices.billingInterval', 'Billing Interval', '2019-06-18 05:05:40', '2019-06-18 05:07:59');
INSERT INTO `ltm_translations` VALUES (961, 0, 'en', 'modules', 'invoices.recurringPayments', 'Recurring Payment', '2019-06-18 05:05:40', '2019-06-18 05:08:00');
INSERT INTO `ltm_translations` VALUES (962, 0, 'en', 'modules', 'invoices.taxName', 'Tax Name', '2019-06-18 05:05:40', '2019-06-18 05:08:01');
INSERT INTO `ltm_translations` VALUES (963, 0, 'en', 'modules', 'invoices.rate', 'Rate', '2019-06-18 05:05:40', '2019-06-18 05:08:01');
INSERT INTO `ltm_translations` VALUES (964, 0, 'en', 'modules', 'invoices.payOffline', 'Pay Offline', '2019-06-18 05:05:40', '2019-06-18 05:08:01');
INSERT INTO `ltm_translations` VALUES (965, 0, 'en', 'modules', 'invoices.uploadInvoice', 'Upload Invoice', '2019-06-18 05:05:40', '2019-06-18 05:08:01');
INSERT INTO `ltm_translations` VALUES (966, 0, 'en', 'modules', 'issues.reportedOn', 'Reported On', '2019-06-18 05:05:41', '2019-06-18 05:08:02');
INSERT INTO `ltm_translations` VALUES (967, 0, 'en', 'modules', 'timeLogs.whoLogged', 'Who Logged', '2019-06-18 05:05:41', '2019-06-18 05:08:02');
INSERT INTO `ltm_translations` VALUES (968, 0, 'en', 'modules', 'timeLogs.startTime', 'Start Time', '2019-06-18 05:05:41', '2019-06-18 05:08:02');
INSERT INTO `ltm_translations` VALUES (969, 0, 'en', 'modules', 'timeLogs.endTime', 'End Time', '2019-06-18 05:05:41', '2019-06-18 05:08:02');
INSERT INTO `ltm_translations` VALUES (970, 0, 'en', 'modules', 'timeLogs.totalHours', 'Total Hours', '2019-06-18 05:05:42', '2019-06-18 05:08:03');
INSERT INTO `ltm_translations` VALUES (971, 0, 'en', 'modules', 'timeLogs.memo', 'Memo', '2019-06-18 05:05:42', '2019-06-18 05:08:03');
INSERT INTO `ltm_translations` VALUES (972, 0, 'en', 'modules', 'timeLogs.lastUpdatedBy', 'Last updated by', '2019-06-18 05:05:42', '2019-06-18 05:08:03');
INSERT INTO `ltm_translations` VALUES (973, 0, 'en', 'modules', 'timeLogs.employeeName', 'Employee Name', '2019-06-18 05:05:42', '2019-06-18 05:08:03');
INSERT INTO `ltm_translations` VALUES (974, 0, 'en', 'modules', 'timeLogs.startDate', 'Start Date', '2019-06-18 05:05:42', '2019-06-18 05:08:03');
INSERT INTO `ltm_translations` VALUES (975, 0, 'en', 'modules', 'timeLogs.endDate', 'End Date', '2019-06-18 05:05:42', '2019-06-18 05:08:03');
INSERT INTO `ltm_translations` VALUES (976, 0, 'en', 'modules', 'timeLogs.task', 'Task', '2019-06-18 05:05:43', '2019-06-18 05:08:04');
INSERT INTO `ltm_translations` VALUES (977, 0, 'en', 'modules', 'taskCalendar.taskDetail', 'Task Detail', '2019-06-18 05:05:43', '2019-06-18 05:08:05');
INSERT INTO `ltm_translations` VALUES (978, 0, 'en', 'modules', 'notices.notice', 'Notice', '2019-06-18 05:05:43', '2019-06-18 05:08:05');
INSERT INTO `ltm_translations` VALUES (979, 0, 'en', 'modules', 'notices.noticeHeading', 'Notice Heading', '2019-06-18 05:05:43', '2019-06-18 05:08:05');
INSERT INTO `ltm_translations` VALUES (980, 0, 'en', 'modules', 'notices.noticeDetails', 'Notice Details', '2019-06-18 05:05:43', '2019-06-18 05:08:06');
INSERT INTO `ltm_translations` VALUES (981, 0, 'en', 'modules', 'taskReport.taskToComplete', 'Task To Be Completed', '2019-06-18 05:05:44', '2019-06-18 05:08:06');
INSERT INTO `ltm_translations` VALUES (982, 0, 'en', 'modules', 'taskReport.completedTasks', 'Completed Tasks', '2019-06-18 05:05:44', '2019-06-18 05:08:07');
INSERT INTO `ltm_translations` VALUES (983, 0, 'en', 'modules', 'taskReport.pendingTasks', 'Pending Tasks', '2019-06-18 05:05:44', '2019-06-18 05:08:07');
INSERT INTO `ltm_translations` VALUES (984, 0, 'en', 'modules', 'taskReport.chartTitle', 'Pie Chart', '2019-06-18 05:05:44', '2019-06-18 05:08:07');
INSERT INTO `ltm_translations` VALUES (985, 0, 'en', 'modules', 'leaveReport.leaveReport', 'Leave Report', '2019-06-18 05:05:44', '2019-06-18 05:08:08');
INSERT INTO `ltm_translations` VALUES (986, 0, 'en', 'modules', 'timeLogReport.chartTitle', 'Time Log Bar Chart', '2019-06-18 05:05:44', '2019-06-18 05:08:08');
INSERT INTO `ltm_translations` VALUES (987, 0, 'en', 'modules', 'financeReport.showAmountIn', 'Show amount in ', '2019-06-18 05:05:44', '2019-06-18 05:08:08');
INSERT INTO `ltm_translations` VALUES (988, 0, 'en', 'modules', 'financeReport.chartTitle', 'Earnings Bar Chart', '2019-06-18 05:05:44', '2019-06-18 05:08:08');
INSERT INTO `ltm_translations` VALUES (989, 0, 'en', 'modules', 'financeReport.financeReport', 'Earnings Bar Chart', '2019-06-18 05:05:45', '2019-06-18 05:08:09');
INSERT INTO `ltm_translations` VALUES (990, 0, 'en', 'modules', 'accountSettings.updateTitle', 'Update Organization Settings', '2019-06-18 05:05:45', '2019-06-18 05:08:09');
INSERT INTO `ltm_translations` VALUES (991, 0, 'en', 'modules', 'accountSettings.companyName', 'Company Name', '2019-06-18 05:05:45', '2019-06-18 05:08:09');
INSERT INTO `ltm_translations` VALUES (992, 0, 'en', 'modules', 'accountSettings.companyEmail', 'Company Email', '2019-06-18 05:05:45', '2019-06-18 05:08:09');
INSERT INTO `ltm_translations` VALUES (993, 0, 'en', 'modules', 'accountSettings.companyPhone', 'Company Phone', '2019-06-18 05:05:45', '2019-06-18 05:08:10');
INSERT INTO `ltm_translations` VALUES (994, 0, 'en', 'modules', 'accountSettings.companyWebsite', 'Company Website', '2019-06-18 05:05:45', '2019-06-18 05:08:10');
INSERT INTO `ltm_translations` VALUES (995, 0, 'en', 'modules', 'accountSettings.companyLogo', 'Company Logo', '2019-06-18 05:05:46', '2019-06-18 05:08:10');
INSERT INTO `ltm_translations` VALUES (996, 0, 'en', 'modules', 'accountSettings.companyAddress', 'Company Address', '2019-06-18 05:05:46', '2019-06-18 05:08:10');
INSERT INTO `ltm_translations` VALUES (997, 0, 'en', 'modules', 'accountSettings.defaultTimezone', 'Default Timezone', '2019-06-18 05:05:46', '2019-06-18 05:08:10');
INSERT INTO `ltm_translations` VALUES (998, 0, 'en', 'modules', 'accountSettings.defaultCurrency', 'Default Currency', '2019-06-18 05:05:46', '2019-06-18 05:08:11');
INSERT INTO `ltm_translations` VALUES (999, 0, 'en', 'modules', 'accountSettings.changeLanguage', 'Change Language', '2019-06-18 05:05:46', '2019-06-18 05:08:11');
INSERT INTO `ltm_translations` VALUES (1000, 0, 'en', 'modules', 'accountSettings.dateFormat', 'Date Format', '2019-06-18 05:05:47', '2019-06-18 05:08:11');
INSERT INTO `ltm_translations` VALUES (1001, 0, 'en', 'modules', 'accountSettings.timeFormat', 'Time Format', '2019-06-18 05:05:47', '2019-06-18 05:08:11');
INSERT INTO `ltm_translations` VALUES (1002, 0, 'en', 'modules', 'profile.yourName', 'Your Name', '2019-06-18 05:05:47', '2019-06-18 05:08:12');
INSERT INTO `ltm_translations` VALUES (1003, 0, 'en', 'modules', 'profile.yourEmail', 'Your Email', '2019-06-18 05:05:47', '2019-06-18 05:08:12');
INSERT INTO `ltm_translations` VALUES (1004, 0, 'en', 'modules', 'profile.yourPassword', 'Your Password', '2019-06-18 05:05:48', '2019-06-18 05:08:12');
INSERT INTO `ltm_translations` VALUES (1005, 0, 'en', 'modules', 'profile.yourMobileNumber', 'Your Mobile Number', '2019-06-18 05:05:48', '2019-06-18 05:08:13');
INSERT INTO `ltm_translations` VALUES (1006, 0, 'en', 'modules', 'profile.yourAddress', 'Your Address', '2019-06-18 05:05:48', '2019-06-18 05:08:13');
INSERT INTO `ltm_translations` VALUES (1007, 0, 'en', 'modules', 'profile.profilePicture', 'Profile Picture', '2019-06-18 05:05:48', '2019-06-18 05:08:13');
INSERT INTO `ltm_translations` VALUES (1008, 0, 'en', 'modules', 'emailSettings.notificationTitle', 'Set Email Notification Settings', '2019-06-18 05:05:48', '2019-06-18 05:08:13');
INSERT INTO `ltm_translations` VALUES (1009, 0, 'en', 'modules', 'emailSettings.configTitle', 'Mail Configuration', '2019-06-18 05:05:49', '2019-06-18 05:08:14');
INSERT INTO `ltm_translations` VALUES (1010, 0, 'en', 'modules', 'emailSettings.mailDriver', 'Mail Driver', '2019-06-18 05:05:49', '2019-06-18 05:08:14');
INSERT INTO `ltm_translations` VALUES (1011, 0, 'en', 'modules', 'emailSettings.mailHost', 'Mail Host', '2019-06-18 05:05:49', '2019-06-18 05:08:14');
INSERT INTO `ltm_translations` VALUES (1012, 0, 'en', 'modules', 'emailSettings.mailPort', 'Mail Port', '2019-06-18 05:05:49', '2019-06-18 05:08:14');
INSERT INTO `ltm_translations` VALUES (1013, 0, 'en', 'modules', 'emailSettings.mailUsername', 'Mail Username', '2019-06-18 05:05:49', '2019-06-18 05:08:14');
INSERT INTO `ltm_translations` VALUES (1014, 0, 'en', 'modules', 'emailSettings.mailPassword', 'Mail Password', '2019-06-18 05:05:49', '2019-06-18 05:08:15');
INSERT INTO `ltm_translations` VALUES (1015, 0, 'en', 'modules', 'emailSettings.mailFrom', 'Mail From Name', '2019-06-18 05:05:49', '2019-06-18 05:08:15');
INSERT INTO `ltm_translations` VALUES (1016, 0, 'en', 'modules', 'emailSettings.mailEncryption', 'Mail Encryption', '2019-06-18 05:05:49', '2019-06-18 05:08:15');
INSERT INTO `ltm_translations` VALUES (1017, 0, 'en', 'modules', 'emailSettings.userRegistration', 'User Registration/Added by Admin', '2019-06-18 05:05:49', '2019-06-18 05:08:15');
INSERT INTO `ltm_translations` VALUES (1018, 0, 'en', 'modules', 'emailSettings.employeeAssign', 'Employee Assign to Project', '2019-06-18 05:05:50', '2019-06-18 05:08:16');
INSERT INTO `ltm_translations` VALUES (1019, 0, 'en', 'modules', 'emailSettings.newNotice', 'New Notice Published', '2019-06-18 05:05:50', '2019-06-18 05:08:16');
INSERT INTO `ltm_translations` VALUES (1020, 0, 'en', 'modules', 'emailSettings.taskAssign', 'User Assign to Task', '2019-06-18 05:05:50', '2019-06-18 05:08:16');
INSERT INTO `ltm_translations` VALUES (1021, 0, 'en', 'modules', 'emailSettings.expenseAdded', 'New Expense (Added by Admin)', '2019-06-18 05:05:50', '2019-06-18 05:08:16');
INSERT INTO `ltm_translations` VALUES (1022, 0, 'en', 'modules', 'emailSettings.expenseMember', 'New Expense (Added by Member)', '2019-06-18 05:05:50', '2019-06-18 05:08:16');
INSERT INTO `ltm_translations` VALUES (1023, 0, 'en', 'modules', 'emailSettings.expenseStatus', 'Expense Status Changed', '2019-06-18 05:05:50', '2019-06-18 05:08:16');
INSERT INTO `ltm_translations` VALUES (1024, 0, 'en', 'modules', 'emailSettings.ticketRequest', 'New Support Ticket Request', '2019-06-18 05:05:50', '2019-06-18 05:08:16');
INSERT INTO `ltm_translations` VALUES (1025, 0, 'en', 'modules', 'emailSettings.mailFromEmail', 'Mail From Email', '2019-06-18 05:05:50', '2019-06-18 05:08:16');
INSERT INTO `ltm_translations` VALUES (1026, 0, 'en', 'modules', 'emailSettings.leaveRequest', 'Leave Request Received', '2019-06-18 05:05:50', '2019-06-18 05:08:17');
INSERT INTO `ltm_translations` VALUES (1027, 0, 'en', 'modules', 'emailSettings.taskComplete', 'Task completed', '2019-06-18 05:05:50', '2019-06-18 05:08:17');
INSERT INTO `ltm_translations` VALUES (1028, 0, 'en', 'modules', 'emailSettings.sendTestEmail', 'Send Test Email', '2019-06-18 05:05:51', '2019-06-18 05:08:17');
INSERT INTO `ltm_translations` VALUES (1029, 0, 'en', 'modules', 'emailSettings.removeImage', 'Remove Image', '2019-06-18 05:05:51', '2019-06-18 05:08:17');
INSERT INTO `ltm_translations` VALUES (1030, 0, 'en', 'modules', 'emailSettings.invoiceNotification', 'Invoice  Notification', '2019-06-18 05:05:51', '2019-06-18 05:08:18');
INSERT INTO `ltm_translations` VALUES (1031, 0, 'en', 'modules', 'moduleSettings.employeeModuleTitle', 'Modules', '2019-06-18 05:05:51', '2019-06-18 05:08:18');
INSERT INTO `ltm_translations` VALUES (1032, 0, 'en', 'modules', 'moduleSettings.clientModuleTitle', 'Client Module Title', '2019-06-18 05:05:51', '2019-06-18 05:08:18');
INSERT INTO `ltm_translations` VALUES (1033, 0, 'en', 'modules', 'moduleSettings.clientSubTitle', 'Select the modules which client can access.', '2019-06-18 05:05:51', '2019-06-18 05:08:18');
INSERT INTO `ltm_translations` VALUES (1034, 0, 'en', 'modules', 'currencySettings.addNewCurrency', 'Add New Currency', '2019-06-18 05:05:52', '2019-06-18 05:08:19');
INSERT INTO `ltm_translations` VALUES (1035, 0, 'en', 'modules', 'currencySettings.currencyName', 'Currency Name', '2019-06-18 05:05:52', '2019-06-18 05:08:19');
INSERT INTO `ltm_translations` VALUES (1036, 0, 'en', 'modules', 'currencySettings.currencySymbol', 'Currency Symbol', '2019-06-18 05:05:52', '2019-06-18 05:08:19');
INSERT INTO `ltm_translations` VALUES (1037, 0, 'en', 'modules', 'currencySettings.currencyCode', 'Currency Code', '2019-06-18 05:05:52', '2019-06-18 05:08:19');
INSERT INTO `ltm_translations` VALUES (1038, 0, 'en', 'modules', 'currencySettings.currencies', 'Currencies', '2019-06-18 05:05:53', '2019-06-18 05:08:19');
INSERT INTO `ltm_translations` VALUES (1039, 0, 'en', 'modules', 'currencySettings.updateTitle', 'Update Currency', '2019-06-18 05:05:53', '2019-06-18 05:08:19');
INSERT INTO `ltm_translations` VALUES (1040, 0, 'en', 'modules', 'currencySettings.isCryptoCurrency', 'Is Cryptocurrency', '2019-06-18 05:05:53', '2019-06-18 05:08:20');
INSERT INTO `ltm_translations` VALUES (1041, 0, 'en', 'modules', 'currencySettings.usdPrice', 'Usd Price', '2019-06-18 05:05:53', '2019-06-18 05:08:20');
INSERT INTO `ltm_translations` VALUES (1042, 0, 'en', 'modules', 'currencySettings.usdPriceInfo', 'Required to calculate earnings.', '2019-06-18 05:05:53', '2019-06-18 05:08:20');
INSERT INTO `ltm_translations` VALUES (1043, 0, 'en', 'modules', 'messages.message', 'Message', '2019-06-18 05:05:53', '2019-06-18 05:08:20');
INSERT INTO `ltm_translations` VALUES (1044, 0, 'en', 'modules', 'messages.allowClientEmployeeChat', 'Allow chat between client and employees?', '2019-06-18 05:05:54', '2019-06-18 05:08:21');
INSERT INTO `ltm_translations` VALUES (1045, 0, 'en', 'modules', 'messages.allowClientAdminChat', 'Allow chat between client and admin?', '2019-06-18 05:05:54', '2019-06-18 05:08:21');
INSERT INTO `ltm_translations` VALUES (1046, 0, 'en', 'modules', 'projectCategory.categoryName', 'Category Name', '2019-06-18 05:05:54', '2019-06-18 05:08:21');
INSERT INTO `ltm_translations` VALUES (1047, 0, 'en', 'modules', 'themeSettings.adminPanelTheme', 'Admin Panel Theme', '2019-06-18 05:05:54', '2019-06-18 05:08:21');
INSERT INTO `ltm_translations` VALUES (1048, 0, 'en', 'modules', 'themeSettings.projectAdminPanelTheme', 'Project Admin Panel Theme', '2019-06-18 05:05:54', '2019-06-18 05:08:22');
INSERT INTO `ltm_translations` VALUES (1049, 0, 'en', 'modules', 'themeSettings.employeePanelTheme', 'Employee Panel Theme', '2019-06-18 05:05:54', '2019-06-18 05:08:22');
INSERT INTO `ltm_translations` VALUES (1050, 0, 'en', 'modules', 'themeSettings.clientPanelTheme', 'Client Panel Theme', '2019-06-18 05:05:54', '2019-06-18 05:08:22');
INSERT INTO `ltm_translations` VALUES (1051, 0, 'en', 'modules', 'themeSettings.headerColor', 'Header Color (Primary)', '2019-06-18 05:05:54', '2019-06-18 05:08:22');
INSERT INTO `ltm_translations` VALUES (1052, 0, 'en', 'modules', 'themeSettings.sidebarColor', 'Sidebar Color', '2019-06-18 05:05:55', '2019-06-18 05:08:22');
INSERT INTO `ltm_translations` VALUES (1053, 0, 'en', 'modules', 'themeSettings.sidebarTextColor', 'Sidebar Text Color', '2019-06-18 05:05:55', '2019-06-18 05:08:23');
INSERT INTO `ltm_translations` VALUES (1054, 0, 'en', 'modules', 'themeSettings.linkColor', 'Link Color', '2019-06-18 05:05:55', '2019-06-18 05:08:23');
INSERT INTO `ltm_translations` VALUES (1055, 0, 'en', 'modules', 'themeSettings.loginScreenBackground', 'Login Screen Background', '2019-06-18 05:05:55', '2019-06-18 05:08:23');
INSERT INTO `ltm_translations` VALUES (1056, 0, 'en', 'modules', 'themeSettings.uploadImage', 'Upload Image', '2019-06-18 05:05:55', '2019-06-18 05:08:23');
INSERT INTO `ltm_translations` VALUES (1057, 0, 'en', 'modules', 'themeSettings.useDefaultTheme', 'Use Default Theme', '2019-06-18 05:05:55', '2019-06-18 05:08:23');
INSERT INTO `ltm_translations` VALUES (1058, 0, 'en', 'modules', 'themeSettings.useCustomTheme', 'Use Custom Theme', '2019-06-18 05:05:55', '2019-06-18 05:08:23');
INSERT INTO `ltm_translations` VALUES (1059, 0, 'en', 'modules', 'estimates.validTill', 'Valid Till', '2019-06-18 05:05:55', '2019-06-18 05:08:23');
INSERT INTO `ltm_translations` VALUES (1060, 0, 'en', 'modules', 'estimates.waiting', 'Waiting', '2019-06-18 05:05:55', '2019-06-18 05:08:23');
INSERT INTO `ltm_translations` VALUES (1061, 0, 'en', 'modules', 'estimates.accepted', 'Accepted', '2019-06-18 05:05:55', '2019-06-18 05:08:24');
INSERT INTO `ltm_translations` VALUES (1062, 0, 'en', 'modules', 'estimates.declined', 'Declined', '2019-06-18 05:05:55', '2019-06-18 05:08:24');
INSERT INTO `ltm_translations` VALUES (1063, 0, 'en', 'modules', 'payments.paidOn', 'Paid On', '2019-06-18 05:05:55', '2019-06-18 05:08:24');
INSERT INTO `ltm_translations` VALUES (1064, 0, 'en', 'modules', 'payments.selectInvoice', 'Select Invoice', '2019-06-18 05:05:55', '2019-06-18 05:08:24');
INSERT INTO `ltm_translations` VALUES (1065, 0, 'en', 'modules', 'payments.paymentGateway', 'Payment Gateway', '2019-06-18 05:05:55', '2019-06-18 05:08:24');
INSERT INTO `ltm_translations` VALUES (1066, 0, 'en', 'modules', 'payments.transactionId', 'Transaction Id', '2019-06-18 05:05:55', '2019-06-18 05:08:24');
INSERT INTO `ltm_translations` VALUES (1067, 0, 'en', 'modules', 'payments.paypalStatus', 'Paypal Status', '2019-06-18 05:05:56', '2019-06-18 05:08:25');
INSERT INTO `ltm_translations` VALUES (1068, 0, 'en', 'modules', 'payments.markInvoicePaid', 'Mark Invoice Paid?', '2019-06-18 05:05:56', '2019-06-18 05:08:25');
INSERT INTO `ltm_translations` VALUES (1069, 0, 'en', 'modules', 'payments.stripeStatus', 'Stripe Status', '2019-06-18 05:05:56', '2019-06-18 05:08:25');
INSERT INTO `ltm_translations` VALUES (1070, 0, 'en', 'modules', 'payments.firstCharacter', 'First Character is Currency?', '2019-06-18 05:05:56', '2019-06-18 05:08:25');
INSERT INTO `ltm_translations` VALUES (1071, 0, 'en', 'modules', 'payments.remark', 'Remark', '2019-06-18 05:05:56', '2019-06-18 05:08:25');
INSERT INTO `ltm_translations` VALUES (1072, 0, 'en', 'modules', 'payments.amount', 'Amount', '2019-06-18 05:05:56', '2019-06-18 05:08:25');
INSERT INTO `ltm_translations` VALUES (1073, 0, 'en', 'modules', 'payments.totalAmount', 'Total Amount', '2019-06-18 05:05:56', '2019-06-18 05:08:25');
INSERT INTO `ltm_translations` VALUES (1074, 0, 'en', 'modules', 'payments.totalPaid', 'Total Paid', '2019-06-18 05:05:56', '2019-06-18 05:08:26');
INSERT INTO `ltm_translations` VALUES (1075, 0, 'en', 'modules', 'payments.totalDue', 'Total Due', '2019-06-18 05:05:56', '2019-06-18 05:08:26');
INSERT INTO `ltm_translations` VALUES (1076, 0, 'en', 'modules', 'payments.paymentDetailNotFound', 'Payment details not found.', '2019-06-18 05:05:56', '2019-06-18 05:08:26');
INSERT INTO `ltm_translations` VALUES (1077, 0, 'en', 'modules', 'expenses.itemName', 'Item Name', '2019-06-18 05:05:56', '2019-06-18 05:08:26');
INSERT INTO `ltm_translations` VALUES (1078, 0, 'en', 'modules', 'expenses.purchaseDate', 'Purchase Date', '2019-06-18 05:05:56', '2019-06-18 05:08:27');
INSERT INTO `ltm_translations` VALUES (1079, 0, 'en', 'modules', 'expenses.purchaseFrom', 'Purchased From', '2019-06-18 05:05:56', '2019-06-18 05:08:27');
INSERT INTO `ltm_translations` VALUES (1080, 0, 'en', 'modules', 'invoiceSettings.invoicePrefix', 'Invoice Prefix', '2019-06-18 05:05:57', '2019-06-18 05:08:27');
INSERT INTO `ltm_translations` VALUES (1081, 0, 'en', 'modules', 'invoiceSettings.template', 'Template', '2019-06-18 05:05:57', '2019-06-18 05:08:27');
INSERT INTO `ltm_translations` VALUES (1082, 0, 'en', 'modules', 'invoiceSettings.dueAfter', 'Due after', '2019-06-18 05:05:57', '2019-06-18 05:08:27');
INSERT INTO `ltm_translations` VALUES (1083, 0, 'en', 'modules', 'invoiceSettings.invoiceTerms', 'Invoice terms', '2019-06-18 05:05:57', '2019-06-18 05:08:27');
INSERT INTO `ltm_translations` VALUES (1084, 0, 'en', 'modules', 'invoiceSettings.updateTitle', 'Update Invoice Settings', '2019-06-18 05:05:57', '2019-06-18 05:08:27');
INSERT INTO `ltm_translations` VALUES (1085, 0, 'en', 'modules', 'slackSettings.updateTitle', 'Update Slack Settings', '2019-06-18 05:05:57', '2019-06-18 05:08:28');
INSERT INTO `ltm_translations` VALUES (1086, 0, 'en', 'modules', 'slackSettings.notificationTitle', 'Set Notification Settings', '2019-06-18 05:05:58', '2019-06-18 05:08:28');
INSERT INTO `ltm_translations` VALUES (1087, 0, 'en', 'modules', 'slackSettings.sendTestNotification', 'Send Test Notification', '2019-06-18 05:05:58', '2019-06-18 05:08:28');
INSERT INTO `ltm_translations` VALUES (1088, 0, 'en', 'modules', 'slackSettings.slackWebhook', 'Slack Webhook', '2019-06-18 05:05:58', '2019-06-18 05:08:29');
INSERT INTO `ltm_translations` VALUES (1089, 0, 'en', 'modules', 'slackSettings.slackNotificationLogo', 'Notification Logo', '2019-06-18 05:05:58', '2019-06-18 05:08:29');
INSERT INTO `ltm_translations` VALUES (1090, 0, 'en', 'modules', 'update.systemDetails', 'System Details', '2019-06-18 05:05:58', '2019-06-18 05:08:29');
INSERT INTO `ltm_translations` VALUES (1091, 0, 'en', 'modules', 'update.updateTitle', 'Update To New Version', '2019-06-18 05:05:58', '2019-06-18 05:08:29');
INSERT INTO `ltm_translations` VALUES (1092, 0, 'en', 'modules', 'update.updateDatabase', 'Update Database', '2019-06-18 05:05:58', '2019-06-18 05:08:29');
INSERT INTO `ltm_translations` VALUES (1093, 0, 'en', 'modules', 'update.updateDatabaseButton', 'Click to update database', '2019-06-18 05:05:58', '2019-06-18 05:08:29');
INSERT INTO `ltm_translations` VALUES (1094, 0, 'en', 'modules', 'update.updateNow', 'Update Now', '2019-06-18 05:05:58', '2019-06-18 05:08:29');
INSERT INTO `ltm_translations` VALUES (1095, 0, 'en', 'modules', 'update.updateAlternate', 'If the Update Now button does not work then follow the update instructions as mentioned in the documentation.', '2019-06-18 05:05:58', '2019-06-18 05:08:30');
INSERT INTO `ltm_translations` VALUES (1096, 0, 'en', 'modules', 'incomeVsExpenseReport.totalIncome', 'Total Income', '2019-06-18 05:05:58', '2019-06-18 05:08:30');
INSERT INTO `ltm_translations` VALUES (1097, 0, 'en', 'modules', 'incomeVsExpenseReport.totalExpense', 'Total Expense', '2019-06-18 05:05:58', '2019-06-18 05:08:30');
INSERT INTO `ltm_translations` VALUES (1098, 0, 'en', 'modules', 'incomeVsExpenseReport.chartTitle', 'Bar Chart', '2019-06-18 05:05:58', '2019-06-18 05:08:30');
INSERT INTO `ltm_translations` VALUES (1099, 0, 'en', 'modules', 'tickets.assignGroup', 'Assign Group', '2019-06-18 05:05:58', '2019-06-18 05:08:30');
INSERT INTO `ltm_translations` VALUES (1100, 0, 'en', 'modules', 'tickets.addGroup', 'Add group', '2019-06-18 05:05:59', '2019-06-18 05:08:30');
INSERT INTO `ltm_translations` VALUES (1101, 0, 'en', 'modules', 'tickets.group', 'Group', '2019-06-18 05:05:59', '2019-06-18 05:08:30');
INSERT INTO `ltm_translations` VALUES (1102, 0, 'en', 'modules', 'tickets.channelName', 'Channel Name', '2019-06-18 05:05:59', '2019-06-18 05:08:31');
INSERT INTO `ltm_translations` VALUES (1103, 0, 'en', 'modules', 'tickets.templateHeading', 'Template Heading', '2019-06-18 05:05:59', '2019-06-18 05:08:31');
INSERT INTO `ltm_translations` VALUES (1104, 0, 'en', 'modules', 'tickets.templateText', 'Template Text', '2019-06-18 05:05:59', '2019-06-18 05:08:31');
INSERT INTO `ltm_translations` VALUES (1105, 0, 'en', 'modules', 'tickets.addTicket', 'Create Ticket', '2019-06-18 05:05:59', '2019-06-18 05:08:31');
INSERT INTO `ltm_translations` VALUES (1106, 0, 'en', 'modules', 'tickets.ticketSubject', 'Ticket Subject', '2019-06-18 05:05:59', '2019-06-18 05:08:32');
INSERT INTO `ltm_translations` VALUES (1107, 0, 'en', 'modules', 'tickets.ticketDescription', 'Ticket Description', '2019-06-18 05:06:00', '2019-06-18 05:08:32');
INSERT INTO `ltm_translations` VALUES (1108, 0, 'en', 'modules', 'tickets.tags', 'Tags', '2019-06-18 05:06:00', '2019-06-18 05:08:32');
INSERT INTO `ltm_translations` VALUES (1109, 0, 'en', 'modules', 'tickets.reply', 'Reply', '2019-06-18 05:06:00', '2019-06-18 05:08:32');
INSERT INTO `ltm_translations` VALUES (1110, 0, 'en', 'modules', 'tickets.totalTickets', 'Total Tickets', '2019-06-18 05:06:00', '2019-06-18 05:08:33');
INSERT INTO `ltm_translations` VALUES (1111, 0, 'en', 'modules', 'tickets.totalClosedTickets', 'Closed Tickets', '2019-06-18 05:06:00', '2019-06-18 05:08:33');
INSERT INTO `ltm_translations` VALUES (1112, 0, 'en', 'modules', 'tickets.totalOpenTickets', 'Open Tickets', '2019-06-18 05:06:00', '2019-06-18 05:08:33');
INSERT INTO `ltm_translations` VALUES (1113, 0, 'en', 'modules', 'tickets.totalPendingTickets', 'Pending Tickets', '2019-06-18 05:06:00', '2019-06-18 05:08:33');
INSERT INTO `ltm_translations` VALUES (1114, 0, 'en', 'modules', 'tickets.requestedOn', 'Requested On', '2019-06-18 05:06:00', '2019-06-18 05:08:34');
INSERT INTO `ltm_translations` VALUES (1115, 0, 'en', 'modules', 'tickets.requestTicket', 'Request Support Ticket', '2019-06-18 05:06:00', '2019-06-18 05:08:34');
INSERT INTO `ltm_translations` VALUES (1116, 0, 'en', 'modules', 'tickets.goToAgentDashboard', 'Go To Agent Dashboard', '2019-06-18 05:06:00', '2019-06-18 05:08:34');
INSERT INTO `ltm_translations` VALUES (1117, 0, 'en', 'modules', 'tickets.totalTicketInfo', 'No. of new tickets which were created for the selected date range.', '2019-06-18 05:06:01', '2019-06-18 05:08:34');
INSERT INTO `ltm_translations` VALUES (1118, 0, 'en', 'modules', 'tickets.closedTicketInfo', 'No. of tickets which were closed in the selected date range.', '2019-06-18 05:06:01', '2019-06-18 05:08:35');
INSERT INTO `ltm_translations` VALUES (1119, 0, 'en', 'modules', 'tickets.openTicketInfo', 'No. of tickets which are not yet assigned to any agent and updated in the selected date range.', '2019-06-18 05:06:01', '2019-06-18 05:08:35');
INSERT INTO `ltm_translations` VALUES (1120, 0, 'en', 'modules', 'tickets.pendingTicketInfo', 'No. of tickets which were updated in the selected date range and are assigned to an agent.', '2019-06-18 05:06:01', '2019-06-18 05:08:35');
INSERT INTO `ltm_translations` VALUES (1121, 0, 'en', 'modules', 'tickets.resolvedTicketInfo', 'No. of tickets which were resolved in the selected date range but waiting for requester confirmation.', '2019-06-18 05:06:01', '2019-06-18 05:08:35');
INSERT INTO `ltm_translations` VALUES (1122, 0, 'en', 'modules', 'tickets.completedProjects', 'Completed Projects', '2019-06-18 05:06:01', '2019-06-18 05:08:35');
INSERT INTO `ltm_translations` VALUES (1123, 0, 'en', 'modules', 'tickets.inProcessProjects', 'In Process Projects', '2019-06-18 05:06:01', '2019-06-18 05:08:35');
INSERT INTO `ltm_translations` VALUES (1124, 0, 'en', 'modules', 'tickets.overDueProjects', 'Overdue Projects', '2019-06-18 05:06:01', '2019-06-18 05:08:35');
INSERT INTO `ltm_translations` VALUES (1125, 0, 'en', 'modules', 'tickets.ticketTrendGraph', 'Ticket trend graph', '2019-06-18 05:06:01', '2019-06-18 05:08:35');
INSERT INTO `ltm_translations` VALUES (1126, 0, 'en', 'modules', 'tickets.urgent', 'Urgent', '2019-06-18 05:06:01', '2019-06-18 05:08:36');
INSERT INTO `ltm_translations` VALUES (1127, 0, 'en', 'modules', 'tickets.nofilter', 'No filter', '2019-06-18 05:06:01', '2019-06-18 05:08:36');
INSERT INTO `ltm_translations` VALUES (1128, 0, 'en', 'modules', 'attendance.officeStartTime', 'Office Start Time', '2019-06-18 05:06:01', '2019-06-18 05:08:36');
INSERT INTO `ltm_translations` VALUES (1129, 0, 'en', 'modules', 'attendance.officeEndTime', 'Office End Time', '2019-06-18 05:06:01', '2019-06-18 05:08:36');
INSERT INTO `ltm_translations` VALUES (1130, 0, 'en', 'modules', 'attendance.halfDayMarkTime', 'HalfDay Mark Time', '2019-06-18 05:06:01', '2019-06-18 05:08:36');
INSERT INTO `ltm_translations` VALUES (1131, 0, 'en', 'modules', 'attendance.lateMark', 'Late mark after (minutes)', '2019-06-18 05:06:02', '2019-06-18 05:08:36');
INSERT INTO `ltm_translations` VALUES (1132, 0, 'en', 'modules', 'attendance.allowSelfClock', 'Allowed Employee self Clock-In/Clock-Out', '2019-06-18 05:06:02', '2019-06-18 05:08:36');
INSERT INTO `ltm_translations` VALUES (1133, 0, 'en', 'modules', 'attendance.markAttendance', 'Mark Attendance', '2019-06-18 05:06:02', '2019-06-18 05:08:36');
INSERT INTO `ltm_translations` VALUES (1134, 0, 'en', 'modules', 'attendance.clock_in', 'Clock In', '2019-06-18 05:06:02', '2019-06-18 05:08:36');
INSERT INTO `ltm_translations` VALUES (1135, 0, 'en', 'modules', 'attendance.clock_out', 'Clock Out', '2019-06-18 05:06:02', '2019-06-18 05:08:36');
INSERT INTO `ltm_translations` VALUES (1136, 0, 'en', 'modules', 'attendance.halfDay', 'Half Day', '2019-06-18 05:06:02', '2019-06-18 05:08:37');
INSERT INTO `ltm_translations` VALUES (1137, 0, 'en', 'modules', 'attendance.working_from', 'Working From', '2019-06-18 05:06:02', '2019-06-18 05:08:37');
INSERT INTO `ltm_translations` VALUES (1138, 0, 'en', 'modules', 'attendance.officeOpenDays', 'Office opens on', '2019-06-18 05:06:02', '2019-06-18 05:08:37');
INSERT INTO `ltm_translations` VALUES (1139, 0, 'en', 'modules', 'attendance.totalWorkingDays', 'Total Working Days', '2019-06-18 05:06:02', '2019-06-18 05:08:37');
INSERT INTO `ltm_translations` VALUES (1140, 0, 'en', 'modules', 'attendance.daysPresent', 'Days Present', '2019-06-18 05:06:02', '2019-06-18 05:08:37');
INSERT INTO `ltm_translations` VALUES (1141, 0, 'en', 'modules', 'attendance.currentTime', 'Current Time', '2019-06-18 05:06:02', '2019-06-18 05:08:37');
INSERT INTO `ltm_translations` VALUES (1142, 0, 'en', 'modules', 'attendance.attendanceByDate', 'Attendance By Date', '2019-06-18 05:06:02', '2019-06-18 05:08:37');
INSERT INTO `ltm_translations` VALUES (1143, 0, 'en', 'modules', 'attendance.attendanceByMember', 'Attendance by Member', '2019-06-18 05:06:02', '2019-06-18 05:08:37');
INSERT INTO `ltm_translations` VALUES (1144, 0, 'en', 'modules', 'attendance.holiday', 'Holiday', '2019-06-18 05:06:03', '2019-06-18 05:08:37');
INSERT INTO `ltm_translations` VALUES (1145, 0, 'en', 'modules', 'attendance.checkininday', 'Maximum check-in allowed in a day?', '2019-06-18 05:06:03', '2019-06-18 05:08:38');
INSERT INTO `ltm_translations` VALUES (1146, 0, 'en', 'modules', 'attendance.maxColckIn', 'Maximum check-ins reached.', '2019-06-18 05:06:03', '2019-06-18 05:08:38');
INSERT INTO `ltm_translations` VALUES (1147, 0, 'en', 'modules', 'attendance.yes', 'Yes', '2019-06-18 05:06:03', '2019-06-18 05:08:39');
INSERT INTO `ltm_translations` VALUES (1148, 0, 'en', 'modules', 'attendance.no', 'No', '2019-06-18 05:06:03', '2019-06-18 05:08:39');
INSERT INTO `ltm_translations` VALUES (1149, 0, 'en', 'modules', 'attendance.leave', 'On Leave', '2019-06-18 05:06:03', '2019-06-18 05:08:39');
INSERT INTO `ltm_translations` VALUES (1150, 0, 'en', 'modules', 'attendance.checkForIp', 'Clock-in check with added IP address', '2019-06-18 05:06:04', '2019-06-18 05:08:40');
INSERT INTO `ltm_translations` VALUES (1151, 0, 'en', 'modules', 'attendance.checkForRadius', 'Clock-in check with added location Radius', '2019-06-18 05:06:04', '2019-06-18 05:08:40');
INSERT INTO `ltm_translations` VALUES (1152, 0, 'en', 'modules', 'attendance.radius', 'Radius (in meter)', '2019-06-18 05:06:04', '2019-06-18 05:08:40');
INSERT INTO `ltm_translations` VALUES (1153, 0, 'en', 'modules', 'customFields.label', 'Label', '2019-06-18 05:06:04', '2019-06-18 05:08:41');
INSERT INTO `ltm_translations` VALUES (1154, 0, 'en', 'modules', 'events.eventName', 'Event Name', '2019-06-18 05:06:04', '2019-06-18 05:08:41');
INSERT INTO `ltm_translations` VALUES (1155, 0, 'en', 'modules', 'events.startOn', 'Starts On', '2019-06-18 05:06:04', '2019-06-18 05:08:41');
INSERT INTO `ltm_translations` VALUES (1156, 0, 'en', 'modules', 'events.endOn', 'Ends On', '2019-06-18 05:06:04', '2019-06-18 05:08:42');
INSERT INTO `ltm_translations` VALUES (1157, 0, 'en', 'modules', 'events.addAttendees', 'Add Attendees', '2019-06-18 05:06:04', '2019-06-18 05:08:42');
INSERT INTO `ltm_translations` VALUES (1158, 0, 'en', 'modules', 'events.allEmployees', 'All Employees', '2019-06-18 05:06:04', '2019-06-18 05:08:42');
INSERT INTO `ltm_translations` VALUES (1159, 0, 'en', 'modules', 'events.where', 'Where', '2019-06-18 05:06:04', '2019-06-18 05:08:42');
INSERT INTO `ltm_translations` VALUES (1160, 0, 'en', 'modules', 'events.repeat', 'Repeat', '2019-06-18 05:06:04', '2019-06-18 05:08:42');
INSERT INTO `ltm_translations` VALUES (1161, 0, 'en', 'modules', 'events.repeatEvery', 'Repeat every', '2019-06-18 05:06:04', '2019-06-18 05:08:42');
INSERT INTO `ltm_translations` VALUES (1162, 0, 'en', 'modules', 'events.cycles', 'Cycles', '2019-06-18 05:06:05', '2019-06-18 05:08:42');
INSERT INTO `ltm_translations` VALUES (1163, 0, 'en', 'modules', 'events.cyclesToolTip', 'Recurring will be stopped after the number of cycles. Keep it blank for infinity.', '2019-06-18 05:06:05', '2019-06-18 05:08:42');
INSERT INTO `ltm_translations` VALUES (1164, 0, 'en', 'modules', 'payroll.addPayroll', 'Add Payroll', '2019-06-18 05:06:05', '2019-06-18 05:08:43');
INSERT INTO `ltm_translations` VALUES (1165, 0, 'en', 'modules', 'payroll.amountPaid', 'Amount Paid', '2019-06-18 05:06:05', '2019-06-18 05:08:43');
INSERT INTO `ltm_translations` VALUES (1166, 0, 'en', 'modules', 'payroll.updatePayroll', 'Update Payroll', '2019-06-18 05:06:05', '2019-06-18 05:08:43');
INSERT INTO `ltm_translations` VALUES (1167, 0, 'en', 'modules', 'payroll.projectPayrollReport', 'Project Payroll Report', '2019-06-18 05:06:05', '2019-06-18 05:08:43');
INSERT INTO `ltm_translations` VALUES (1168, 0, 'en', 'modules', 'payroll.totalEarning', 'Total Earning', '2019-06-18 05:06:05', '2019-06-18 05:08:43');
INSERT INTO `ltm_translations` VALUES (1169, 0, 'en', 'modules', 'permission.selectAll', 'Select All', '2019-06-18 05:06:05', '2019-06-18 05:08:45');
INSERT INTO `ltm_translations` VALUES (1170, 0, 'en', 'modules', 'permission.addRoleMember', 'Manage Role Members', '2019-06-18 05:06:05', '2019-06-18 05:08:45');
INSERT INTO `ltm_translations` VALUES (1171, 0, 'en', 'modules', 'permission.addMembers', 'Add Members', '2019-06-18 05:06:05', '2019-06-18 05:08:45');
INSERT INTO `ltm_translations` VALUES (1172, 0, 'en', 'modules', 'permission.roleName', 'Role Name', '2019-06-18 05:06:05', '2019-06-18 05:08:45');
INSERT INTO `ltm_translations` VALUES (1173, 0, 'en', 'modules', 'leaves.selectDuration', 'Select Duration', '2019-06-18 05:06:06', '2019-06-18 05:08:46');
INSERT INTO `ltm_translations` VALUES (1174, 0, 'en', 'modules', 'leaves.single', 'Single', '2019-06-18 05:06:06', '2019-06-18 05:08:46');
INSERT INTO `ltm_translations` VALUES (1175, 0, 'en', 'modules', 'leaves.multiple', 'Multiple', '2019-06-18 05:06:06', '2019-06-18 05:08:47');
INSERT INTO `ltm_translations` VALUES (1176, 0, 'en', 'modules', 'leaves.halfDay', 'Half Day', '2019-06-18 05:06:06', '2019-06-18 05:08:47');
INSERT INTO `ltm_translations` VALUES (1177, 0, 'en', 'modules', 'leaves.hours', 'Hours', '2019-06-18 05:06:06', '2019-06-18 05:08:47');
INSERT INTO `ltm_translations` VALUES (1178, 0, 'en', 'modules', 'leaves.selectDates', 'Select Dates', '2019-06-18 05:06:06', '2019-06-18 05:08:47');
INSERT INTO `ltm_translations` VALUES (1179, 0, 'en', 'modules', 'leaves.reason', 'Reason for absence', '2019-06-18 05:06:06', '2019-06-18 05:08:48');
INSERT INTO `ltm_translations` VALUES (1180, 0, 'en', 'modules', 'leaves.applicantName', 'Applicant Name', '2019-06-18 05:06:06', '2019-06-18 05:08:48');
INSERT INTO `ltm_translations` VALUES (1181, 0, 'en', 'modules', 'leaves.updateLeave', 'Update Leave', '2019-06-18 05:06:06', '2019-06-18 05:08:48');
INSERT INTO `ltm_translations` VALUES (1182, 0, 'en', 'modules', 'leaves.pendingLeaves', 'Pending Leaves', '2019-06-18 05:06:06', '2019-06-18 05:08:48');
INSERT INTO `ltm_translations` VALUES (1183, 0, 'en', 'modules', 'leaves.noOfLeaves', 'No of Leaves', '2019-06-18 05:06:06', '2019-06-18 05:08:49');
INSERT INTO `ltm_translations` VALUES (1184, 0, 'en', 'modules', 'leaves.countLeavesFromDateOfJoining', 'Count leaves from the date of joining', '2019-06-18 05:06:06', '2019-06-18 05:08:49');
INSERT INTO `ltm_translations` VALUES (1185, 0, 'en', 'modules', 'leaves.countLeavesFromStartOfYear', 'Count leaves from the start of the year', '2019-06-18 05:06:06', '2019-06-18 05:08:49');
INSERT INTO `ltm_translations` VALUES (1186, 0, 'en', 'modules', 'leaves.leavesTaken', 'Leaves Taken', '2019-06-18 05:06:06', '2019-06-18 05:08:50');
INSERT INTO `ltm_translations` VALUES (1187, 0, 'en', 'modules', 'leaves.remainingLeaves', 'Remaining Leaves', '2019-06-18 05:06:06', '2019-06-18 05:08:50');
INSERT INTO `ltm_translations` VALUES (1188, 0, 'en', 'modules', 'leaves.myLeaves', 'My Leaves', '2019-06-18 05:06:06', '2019-06-18 05:08:50');
INSERT INTO `ltm_translations` VALUES (1189, 0, 'en', 'modules', 'low', 'Low', '2019-06-18 05:06:07', '2019-06-18 05:08:50');
INSERT INTO `ltm_translations` VALUES (1190, 0, 'en', 'modules', 'lead.companyDetails', 'Company Details', '2019-06-18 05:06:07', '2019-06-18 05:08:51');
INSERT INTO `ltm_translations` VALUES (1191, 0, 'en', 'modules', 'lead.companyName', 'Company Name', '2019-06-18 05:06:07', '2019-06-18 05:08:51');
INSERT INTO `ltm_translations` VALUES (1192, 0, 'en', 'modules', 'lead.website', 'Website', '2019-06-18 05:06:07', '2019-06-18 05:08:51');
INSERT INTO `ltm_translations` VALUES (1193, 0, 'en', 'modules', 'lead.address', 'Address', '2019-06-18 05:06:07', '2019-06-18 05:08:51');
INSERT INTO `ltm_translations` VALUES (1194, 0, 'en', 'modules', 'lead.leadDetails', 'Lead Details', '2019-06-18 05:06:07', '2019-06-18 05:08:51');
INSERT INTO `ltm_translations` VALUES (1195, 0, 'en', 'modules', 'lead.clientName', 'Client Name', '2019-06-18 05:06:07', '2019-06-18 05:08:52');
INSERT INTO `ltm_translations` VALUES (1196, 0, 'en', 'modules', 'lead.clientEmail', 'Client Email', '2019-06-18 05:06:07', '2019-06-18 05:08:52');
INSERT INTO `ltm_translations` VALUES (1197, 0, 'en', 'modules', 'lead.emailNote', 'Lead will login using this email.', '2019-06-18 05:06:07', '2019-06-18 05:08:52');
INSERT INTO `ltm_translations` VALUES (1198, 0, 'en', 'modules', 'lead.password', 'Password', '2019-06-18 05:06:07', '2019-06-18 05:08:52');
INSERT INTO `ltm_translations` VALUES (1199, 0, 'en', 'modules', 'lead.passwordNote', 'Client will login using this password.', '2019-06-18 05:06:07', '2019-06-18 05:08:52');
INSERT INTO `ltm_translations` VALUES (1200, 0, 'en', 'modules', 'lead.passwordUpdateNote', 'Client will login using this password. (Leave blank to keep current password)', '2019-06-18 05:06:07', '2019-06-18 05:08:52');
INSERT INTO `ltm_translations` VALUES (1201, 0, 'en', 'modules', 'lead.mobile', 'Mobile', '2019-06-18 05:06:07', '2019-06-18 05:08:52');
INSERT INTO `ltm_translations` VALUES (1202, 0, 'en', 'modules', 'lead.addNewLead', 'Add New Lead', '2019-06-18 05:06:07', '2019-06-18 05:08:53');
INSERT INTO `ltm_translations` VALUES (1203, 0, 'en', 'modules', 'lead.viewDetails', 'View Details', '2019-06-18 05:06:07', '2019-06-18 05:08:53');
INSERT INTO `ltm_translations` VALUES (1204, 0, 'en', 'modules', 'lead.remark', 'Remark', '2019-06-18 05:06:08', '2019-06-18 05:08:53');
INSERT INTO `ltm_translations` VALUES (1205, 0, 'en', 'modules', 'lead.proposal', 'Proposal', '2019-06-18 05:06:08', '2019-06-18 05:08:53');
INSERT INTO `ltm_translations` VALUES (1206, 0, 'en', 'modules', 'lead.profile', 'Profile', '2019-06-18 05:06:08', '2019-06-18 05:08:53');
INSERT INTO `ltm_translations` VALUES (1207, 0, 'en', 'modules', 'lead.followUp', 'Follow Up', '2019-06-18 05:06:08', '2019-06-18 05:08:53');
INSERT INTO `ltm_translations` VALUES (1208, 0, 'en', 'modules', 'lead.note', 'Note', '2019-06-18 05:06:08', '2019-06-18 05:08:54');
INSERT INTO `ltm_translations` VALUES (1209, 0, 'en', 'modules', 'lead.email', 'Email', '2019-06-18 05:06:08', '2019-06-18 05:08:54');
INSERT INTO `ltm_translations` VALUES (1210, 0, 'en', 'modules', 'lead.source', 'Source', '2019-06-18 05:06:08', '2019-06-18 05:08:54');
INSERT INTO `ltm_translations` VALUES (1211, 0, 'en', 'modules', 'lead.status', 'Status', '2019-06-18 05:06:08', '2019-06-18 05:08:54');
INSERT INTO `ltm_translations` VALUES (1212, 0, 'en', 'modules', 'lead.leadDetail', 'Lead Detail', '2019-06-18 05:06:08', '2019-06-18 05:08:54');
INSERT INTO `ltm_translations` VALUES (1213, 0, 'en', 'modules', 'lead.nextFollowUp', 'Next Follow Up', '2019-06-18 05:06:09', '2019-06-18 05:08:54');
INSERT INTO `ltm_translations` VALUES (1214, 0, 'en', 'modules', 'lead.all', 'All', '2019-06-18 05:06:09', '2019-06-18 05:08:54');
INSERT INTO `ltm_translations` VALUES (1215, 0, 'en', 'modules', 'lead.lead', 'Lead', '2019-06-18 05:06:09', '2019-06-18 05:08:54');
INSERT INTO `ltm_translations` VALUES (1216, 0, 'en', 'modules', 'lead.client', 'Client', '2019-06-18 05:06:09', '2019-06-18 05:08:54');
INSERT INTO `ltm_translations` VALUES (1217, 0, 'en', 'modules', 'lead.pending', 'Pending', '2019-06-18 05:06:09', '2019-06-18 05:08:54');
INSERT INTO `ltm_translations` VALUES (1218, 0, 'en', 'modules', 'lead.file', 'Files', '2019-06-18 05:06:09', '2019-06-18 05:08:55');
INSERT INTO `ltm_translations` VALUES (1219, 0, 'en', 'modules', 'proposal.updateTitle', 'Update Proposal Info', '2019-06-18 05:06:09', '2019-06-18 05:08:56');
INSERT INTO `ltm_translations` VALUES (1220, 0, 'en', 'modules', 'proposal.addNewLead', 'Add New Proposal', '2019-06-18 05:06:09', '2019-06-18 05:08:56');
INSERT INTO `ltm_translations` VALUES (1221, 0, 'en', 'modules', 'proposal.viewDetails', 'View Details', '2019-06-18 05:06:09', '2019-06-18 05:08:56');
INSERT INTO `ltm_translations` VALUES (1222, 0, 'en', 'modules', 'proposal.title', ' Lead Proposal', '2019-06-18 05:06:09', '2019-06-18 05:08:56');
INSERT INTO `ltm_translations` VALUES (1223, 0, 'en', 'modules', 'proposal.proposal', ' Lead Proposal', '2019-06-18 05:06:10', '2019-06-18 05:08:56');
INSERT INTO `ltm_translations` VALUES (1224, 0, 'en', 'modules', 'proposal.createProposal', 'Create Proposal', '2019-06-18 05:06:10', '2019-06-18 05:08:56');
INSERT INTO `ltm_translations` VALUES (1225, 0, 'en', 'modules', 'proposal.validTill', 'Valid Till', '2019-06-18 05:06:10', '2019-06-18 05:08:56');
INSERT INTO `ltm_translations` VALUES (1226, 0, 'en', 'modules', 'proposal.waiting', 'Waiting', '2019-06-18 05:06:10', '2019-06-18 05:08:57');
INSERT INTO `ltm_translations` VALUES (1227, 0, 'en', 'modules', 'proposal.accepted', 'Accepted', '2019-06-18 05:06:10', '2019-06-18 05:08:57');
INSERT INTO `ltm_translations` VALUES (1228, 0, 'en', 'modules', 'proposal.declined', 'Declined', '2019-06-18 05:06:10', '2019-06-18 05:08:57');
INSERT INTO `ltm_translations` VALUES (1229, 0, 'en', 'modules', 'proposal.view', 'View', '2019-06-18 05:06:10', '2019-06-18 05:08:58');
INSERT INTO `ltm_translations` VALUES (1230, 0, 'en', 'modules', 'followup.addNewLead', 'Add New Proposal', '2019-06-18 05:06:10', '2019-06-18 05:08:58');
INSERT INTO `ltm_translations` VALUES (1231, 0, 'en', 'modules', 'followup.viewDetails', 'View Details', '2019-06-18 05:06:11', '2019-06-18 05:08:58');
INSERT INTO `ltm_translations` VALUES (1232, 0, 'en', 'modules', 'followup.title', ' Lead Proposal', '2019-06-18 05:06:11', '2019-06-18 05:08:59');
INSERT INTO `ltm_translations` VALUES (1233, 0, 'en', 'modules', 'followup.proposal', ' Lead Proposal', '2019-06-18 05:06:11', '2019-06-18 05:08:59');
INSERT INTO `ltm_translations` VALUES (1234, 0, 'en', 'modules', 'followup.createProposal', 'Create Proposal', '2019-06-18 05:06:11', '2019-06-18 05:08:59');
INSERT INTO `ltm_translations` VALUES (1235, 0, 'en', 'modules', 'followup.validTill', 'Valid Till', '2019-06-18 05:06:11', '2019-06-18 05:08:59');
INSERT INTO `ltm_translations` VALUES (1236, 0, 'en', 'modules', 'followup.waiting', 'Waiting', '2019-06-18 05:06:11', '2019-06-18 05:08:59');
INSERT INTO `ltm_translations` VALUES (1237, 0, 'en', 'modules', 'followup.accepted', 'Accepted', '2019-06-18 05:06:11', '2019-06-18 05:08:59');
INSERT INTO `ltm_translations` VALUES (1238, 0, 'en', 'modules', 'followup.declined', 'Declined', '2019-06-18 05:06:11', '2019-06-18 05:08:59');
INSERT INTO `ltm_translations` VALUES (1239, 0, 'en', 'modules', 'followup.updateProposal', 'Update Proposal', '2019-06-18 05:06:11', '2019-06-18 05:08:59');
INSERT INTO `ltm_translations` VALUES (1240, 0, 'en', 'modules', 'followup.convertProposalTitle', 'Convert Proposal To Invoice', '2019-06-18 05:06:11', '2019-06-18 05:08:59');
INSERT INTO `ltm_translations` VALUES (1241, 0, 'en', 'modules', 'followup.followUpNotFound', 'No follow up found', '2019-06-18 05:06:11', '2019-06-18 05:08:59');
INSERT INTO `ltm_translations` VALUES (1242, 0, 'en', 'modules', 'holiday.addNewHoliday', 'Add Holiday', '2019-06-18 05:06:12', '2019-06-18 05:09:00');
INSERT INTO `ltm_translations` VALUES (1243, 0, 'en', 'modules', 'holiday.viewDetails', 'View Details', '2019-06-18 05:06:12', '2019-06-18 05:09:00');
INSERT INTO `ltm_translations` VALUES (1244, 0, 'en', 'modules', 'holiday.createHoliday', 'Create Holiday', '2019-06-18 05:06:12', '2019-06-18 05:09:00');
INSERT INTO `ltm_translations` VALUES (1245, 0, 'en', 'modules', 'holiday.followUpNotFound', 'No Holiday found', '2019-06-18 05:06:12', '2019-06-18 05:09:00');
INSERT INTO `ltm_translations` VALUES (1246, 0, 'en', 'modules', 'holiday.viewOnCalendar', 'View on Calendar', '2019-06-18 05:06:12', '2019-06-18 05:09:01');
INSERT INTO `ltm_translations` VALUES (1247, 0, 'en', 'modules', 'holiday.officeHolidayMarkDays', 'Mark day for Holiday', '2019-06-18 05:06:13', '2019-06-18 05:09:01');
INSERT INTO `ltm_translations` VALUES (1248, 0, 'en', 'modules', 'offlinePayment.method', 'Method', '2019-06-18 05:06:13', '2019-06-18 05:09:02');
INSERT INTO `ltm_translations` VALUES (1249, 0, 'en', 'modules', 'offlinePayment.description', 'Description', '2019-06-18 05:06:13', '2019-06-18 05:09:02');
INSERT INTO `ltm_translations` VALUES (1250, 0, 'en', 'modules', 'offlinePayment.addMethod', 'Add Method', '2019-06-18 05:06:13', '2019-06-18 05:09:02');
INSERT INTO `ltm_translations` VALUES (1251, 0, 'en', 'modules', 'offlinePayment.active', 'Active', '2019-06-18 05:06:13', '2019-06-18 05:09:02');
INSERT INTO `ltm_translations` VALUES (1252, 0, 'en', 'modules', 'offlinePayment.inActive', 'Inactive', '2019-06-18 05:06:13', '2019-06-18 05:09:02');
INSERT INTO `ltm_translations` VALUES (1253, 0, 'en', 'modules', 'projectTemplate.addNewTemplate', 'Add New Template', '2019-06-18 05:06:13', '2019-06-18 05:09:03');
INSERT INTO `ltm_translations` VALUES (1254, 0, 'en', 'modules', 'projectTemplate.projectName', 'Template Name', '2019-06-18 05:06:13', '2019-06-18 05:09:03');
INSERT INTO `ltm_translations` VALUES (1255, 0, 'en', 'modules', 'projectTemplate.projectMembers', 'Template Members', '2019-06-18 05:06:13', '2019-06-18 05:09:03');
INSERT INTO `ltm_translations` VALUES (1256, 0, 'en', 'modules', 'projectTemplate.selectClient', 'Select Client', '2019-06-18 05:06:13', '2019-06-18 05:09:03');
INSERT INTO `ltm_translations` VALUES (1257, 0, 'en', 'modules', 'projectTemplate.startDate', 'Start Date', '2019-06-18 05:06:13', '2019-06-18 05:09:03');
INSERT INTO `ltm_translations` VALUES (1258, 0, 'en', 'modules', 'projectTemplate.deadline', 'Deadline', '2019-06-18 05:06:13', '2019-06-18 05:09:03');
INSERT INTO `ltm_translations` VALUES (1259, 0, 'en', 'modules', 'projectTemplate.projectSummary', 'Template Summary', '2019-06-18 05:06:13', '2019-06-18 05:09:04');
INSERT INTO `ltm_translations` VALUES (1260, 0, 'en', 'modules', 'projectTemplate.note', 'Note', '2019-06-18 05:06:14', '2019-06-18 05:09:04');
INSERT INTO `ltm_translations` VALUES (1261, 0, 'en', 'modules', 'projectTemplate.projectCategory', 'Template Category', '2019-06-18 05:06:14', '2019-06-18 05:09:04');
INSERT INTO `ltm_translations` VALUES (1262, 0, 'en', 'modules', 'projectTemplate.clientFeedback', 'Client Feedback', '2019-06-18 05:06:14', '2019-06-18 05:09:04');
INSERT INTO `ltm_translations` VALUES (1263, 0, 'en', 'modules', 'projectTemplate.projectCompletionStatus', 'Template Completion Status', '2019-06-18 05:06:14', '2019-06-18 05:09:04');
INSERT INTO `ltm_translations` VALUES (1264, 0, 'en', 'modules', 'projectTemplate.overview', 'Overview', '2019-06-18 05:06:14', '2019-06-18 05:09:04');
INSERT INTO `ltm_translations` VALUES (1265, 0, 'en', 'modules', 'projectTemplate.members', 'Members', '2019-06-18 05:06:14', '2019-06-18 05:09:04');
INSERT INTO `ltm_translations` VALUES (1266, 0, 'en', 'modules', 'projectTemplate.files', 'Files', '2019-06-18 05:06:14', '2019-06-18 05:09:04');
INSERT INTO `ltm_translations` VALUES (1267, 0, 'en', 'modules', 'projectTemplate.activeTimers', 'Active Timers', '2019-06-18 05:06:14', '2019-06-18 05:09:05');
INSERT INTO `ltm_translations` VALUES (1268, 0, 'en', 'modules', 'projectTemplate.whoWorking', 'Who\'s Working', '2019-06-18 05:06:14', '2019-06-18 05:09:05');
INSERT INTO `ltm_translations` VALUES (1269, 0, 'en', 'modules', 'projectTemplate.activeSince', 'Active Since', '2019-06-18 05:06:14', '2019-06-18 05:09:05');
INSERT INTO `ltm_translations` VALUES (1270, 0, 'en', 'modules', 'projectTemplate.openTasks', 'Open Tasks', '2019-06-18 05:06:14', '2019-06-18 05:09:05');
INSERT INTO `ltm_translations` VALUES (1271, 0, 'en', 'modules', 'projectTemplate.daysLeft', 'Days Left', '2019-06-18 05:06:15', '2019-06-18 05:09:05');
INSERT INTO `ltm_translations` VALUES (1272, 0, 'en', 'modules', 'projectTemplate.hoursLogged', 'Hours Logged', '2019-06-18 05:06:15', '2019-06-18 05:09:05');
INSERT INTO `ltm_translations` VALUES (1273, 0, 'en', 'modules', 'projectTemplate.issuesPending', 'Issues Pending', '2019-06-18 05:06:15', '2019-06-18 05:09:05');
INSERT INTO `ltm_translations` VALUES (1274, 0, 'en', 'modules', 'projectTemplate.activityTimeline', 'Activity Timeline', '2019-06-18 05:06:15', '2019-06-18 05:09:06');
INSERT INTO `ltm_translations` VALUES (1275, 0, 'en', 'modules', 'projectTemplate.uploadFile', 'Upload File', '2019-06-18 05:06:15', '2019-06-18 05:09:06');
INSERT INTO `ltm_translations` VALUES (1276, 0, 'en', 'modules', 'projectTemplate.dropFile', 'Drop files here OR click to upload', '2019-06-18 05:06:15', '2019-06-18 05:09:06');
INSERT INTO `ltm_translations` VALUES (1277, 0, 'en', 'modules', 'projectTemplate.noOpenTasks', 'No open tasks.', '2019-06-18 05:06:15', '2019-06-18 05:09:06');
INSERT INTO `ltm_translations` VALUES (1278, 0, 'en', 'modules', 'projectTemplate.calculateTasksProgress', 'Calculate progress through tasks', '2019-06-18 05:06:15', '2019-06-18 05:09:06');
INSERT INTO `ltm_translations` VALUES (1279, 0, 'en', 'modules', 'projectTemplate.viewGanttChart', 'Gantt Chart', '2019-06-18 05:06:15', '2019-06-18 05:09:06');
INSERT INTO `ltm_translations` VALUES (1280, 0, 'en', 'modules', 'projectTemplate.clientViewTask', 'Client can view tasks of this project', '2019-06-18 05:06:15', '2019-06-18 05:09:06');
INSERT INTO `ltm_translations` VALUES (1281, 0, 'en', 'modules', 'projectTemplate.clientTaskNotification', 'Send task notification to client?', '2019-06-18 05:06:15', '2019-06-18 05:09:06');
INSERT INTO `ltm_translations` VALUES (1282, 0, 'en', 'modules', 'projectTemplate.manualTimelog', 'Allow manual time logs?', '2019-06-18 05:06:15', '2019-06-18 05:09:07');
INSERT INTO `ltm_translations` VALUES (1283, 0, 'en', 'modules', 'templateTasks.lastCreated', 'Last Created', '2019-06-18 05:06:15', '2019-06-18 05:09:07');
INSERT INTO `ltm_translations` VALUES (1284, 0, 'en', 'modules', 'templateTasks.dueSoon', 'Due Soon', '2019-06-18 05:06:15', '2019-06-18 05:09:07');
INSERT INTO `ltm_translations` VALUES (1285, 0, 'en', 'modules', 'templateTasks.assignTo', 'Assigned To', '2019-06-18 05:06:15', '2019-06-18 05:09:07');
INSERT INTO `ltm_translations` VALUES (1286, 0, 'en', 'modules', 'templateTasks.priority', 'Priority', '2019-06-18 05:06:16', '2019-06-18 05:09:08');
INSERT INTO `ltm_translations` VALUES (1287, 0, 'en', 'modules', 'templateTasks.chooseAssignee', 'Choose Assignee', '2019-06-18 05:06:16', '2019-06-18 05:09:08');
INSERT INTO `ltm_translations` VALUES (1288, 0, 'en', 'modules', 'templateTasks.taskDetail', 'Template Task Detail', '2019-06-18 05:06:16', '2019-06-18 05:09:08');
INSERT INTO `ltm_translations` VALUES (1289, 0, 'en', 'modules', 'templateTasks.taskBoard', 'Template Task Board', '2019-06-18 05:06:16', '2019-06-18 05:09:09');
INSERT INTO `ltm_translations` VALUES (1290, 0, 'en', 'modules', 'templateTasks.addBoardColumn', 'Add Column', '2019-06-18 05:06:16', '2019-06-18 05:09:09');
INSERT INTO `ltm_translations` VALUES (1291, 0, 'en', 'modules', 'templateTasks.columnName', 'Column Name', '2019-06-18 05:06:16', '2019-06-18 05:09:09');
INSERT INTO `ltm_translations` VALUES (1292, 0, 'en', 'modules', 'templateTasks.labelColor', 'Label Color', '2019-06-18 05:06:16', '2019-06-18 05:09:10');
INSERT INTO `ltm_translations` VALUES (1293, 0, 'en', 'modules', 'templateTasks.tasksTable', 'Tasks Table', '2019-06-18 05:06:16', '2019-06-18 05:09:10');
INSERT INTO `ltm_translations` VALUES (1294, 0, 'en', 'modules', 'templateTasks.position', 'Position', '2019-06-18 05:06:16', '2019-06-18 05:09:10');
INSERT INTO `ltm_translations` VALUES (1295, 0, 'en', 'modules', 'templateTasks.subTask', 'Sub Template Task', '2019-06-18 05:06:16', '2019-06-18 05:09:10');
INSERT INTO `ltm_translations` VALUES (1296, 0, 'en', 'modules', 'templateTasks.comment', 'Comment', '2019-06-18 05:06:16', '2019-06-18 05:09:10');
INSERT INTO `ltm_translations` VALUES (1297, 0, 'en', 'modules', 'logTimeSetting.title', 'Log Time Setting', '2019-06-18 05:06:16', '2019-06-18 05:09:11');
INSERT INTO `ltm_translations` VALUES (1298, 0, 'en', 'modules', 'logTimeSetting.project', 'Project', '2019-06-18 05:06:16', '2019-06-18 05:09:11');
INSERT INTO `ltm_translations` VALUES (1299, 0, 'en', 'modules', 'logTimeSetting.task', 'Task', '2019-06-18 05:06:16', '2019-06-18 05:09:11');
INSERT INTO `ltm_translations` VALUES (1300, 0, 'en', 'modules', 'logTimeSetting.autoStopTimerAfterOfficeTime', 'Stop timer automatically after office time.', '2019-06-18 05:06:16', '2019-06-18 05:09:12');
INSERT INTO `ltm_translations` VALUES (1301, 0, 'en', 'modules', 'taskCategory.categoryName', 'Category Name', '2019-06-18 05:06:17', '2019-06-18 05:09:12');
INSERT INTO `ltm_translations` VALUES (1302, 0, 'en', 'modules', 'taskCategory.taskCategory', 'Task Category', '2019-06-18 05:06:17', '2019-06-18 05:09:12');
INSERT INTO `ltm_translations` VALUES (1303, 0, 'en', 'modules', 'pushSettings.updateTitle', 'Update Push Notification Settings', '2019-06-18 05:06:17', '2019-06-18 05:09:12');
INSERT INTO `ltm_translations` VALUES (1304, 0, 'en', 'modules', 'pushSettings.oneSignalAppId', 'One Signal App ID', '2019-06-18 05:06:17', '2019-06-18 05:09:12');
INSERT INTO `ltm_translations` VALUES (1305, 0, 'en', 'modules', 'pushSettings.oneSignalRestApiKey', 'One Signal Rest API Key', '2019-06-18 05:06:17', '2019-06-18 05:09:13');
INSERT INTO `ltm_translations` VALUES (1306, 0, 'en', 'modules', 'stripeSettings.title', 'Stripe Settings', '2019-06-18 05:06:17', '2019-06-18 05:09:13');
INSERT INTO `ltm_translations` VALUES (1307, 0, 'en', 'modules', 'stripeSettings.apiKey', 'Api Key', '2019-06-18 05:06:17', '2019-06-18 05:09:13');
INSERT INTO `ltm_translations` VALUES (1308, 0, 'en', 'modules', 'stripeSettings.apiSecret', 'Api Secret', '2019-06-18 05:06:17', '2019-06-18 05:09:13');
INSERT INTO `ltm_translations` VALUES (1309, 0, 'en', 'modules', 'stripeSettings.webhookKey', 'Webhook Key Secret', '2019-06-18 05:06:17', '2019-06-18 05:09:13');
INSERT INTO `ltm_translations` VALUES (1310, 0, 'en', 'modules', 'stripeSettings.subtitle', 'Stripe credentials', '2019-06-18 05:06:17', '2019-06-18 05:09:14');
INSERT INTO `ltm_translations` VALUES (1311, 0, 'en', 'modules', 'frontCms.updateTitle', 'Update Front Detail', '2019-06-18 05:06:17', '2019-06-18 05:09:14');
INSERT INTO `ltm_translations` VALUES (1312, 0, 'en', 'modules', 'frontCms.headerTitle', 'Header Title', '2019-06-18 05:06:17', '2019-06-18 05:09:14');
INSERT INTO `ltm_translations` VALUES (1313, 0, 'en', 'modules', 'frontCms.frontDetail', 'Front Detail', '2019-06-18 05:06:17', '2019-06-18 05:09:14');
INSERT INTO `ltm_translations` VALUES (1314, 0, 'en', 'modules', 'frontCms.featureDetail', 'Feature Detail', '2019-06-18 05:06:17', '2019-06-18 05:09:14');
INSERT INTO `ltm_translations` VALUES (1315, 0, 'en', 'modules', 'frontCms.headerDescription', 'Header Description', '2019-06-18 05:06:17', '2019-06-18 05:09:14');
INSERT INTO `ltm_translations` VALUES (1316, 0, 'en', 'modules', 'frontCms.mainImage', 'Header Image', '2019-06-18 05:06:17', '2019-06-18 05:09:14');
INSERT INTO `ltm_translations` VALUES (1317, 0, 'en', 'modules', 'frontCms.featureTitle', 'Feature Title', '2019-06-18 05:06:18', '2019-06-18 05:09:14');
INSERT INTO `ltm_translations` VALUES (1318, 0, 'en', 'modules', 'frontCms.featureDescription', 'Feature Description', '2019-06-18 05:06:18', '2019-06-18 05:09:14');
INSERT INTO `ltm_translations` VALUES (1319, 0, 'en', 'modules', 'frontCms.priceDetail', 'Price Detail', '2019-06-18 05:06:18', '2019-06-18 05:09:14');
INSERT INTO `ltm_translations` VALUES (1320, 0, 'en', 'modules', 'frontCms.priceTitle', 'Price Title', '2019-06-18 05:06:18', '2019-06-18 05:09:15');
INSERT INTO `ltm_translations` VALUES (1321, 0, 'en', 'modules', 'frontCms.priceDescription', 'Price Description', '2019-06-18 05:06:18', '2019-06-18 05:09:15');
INSERT INTO `ltm_translations` VALUES (1322, 0, 'en', 'modules', 'frontCms.contactDetail', 'Contact Detail', '2019-06-18 05:06:18', '2019-06-18 05:09:15');
INSERT INTO `ltm_translations` VALUES (1323, 0, 'en', 'modules', 'frontCms.getStartedButtonShow', 'Show get started button', '2019-06-18 05:06:18', '2019-06-18 05:09:15');
INSERT INTO `ltm_translations` VALUES (1324, 0, 'en', 'modules', 'frontCms.singInButtonShow', 'Show sign-in button', '2019-06-18 05:06:18', '2019-06-18 05:09:15');
INSERT INTO `ltm_translations` VALUES (1325, 0, 'en', 'modules', 'featureSetting.addFeature', 'Add Feature', '2019-06-18 05:06:18', '2019-06-18 05:09:15');
INSERT INTO `ltm_translations` VALUES (1326, 0, 'en', 'modules', 'featureSetting.editFeature', 'Edit Feature', '2019-06-18 05:06:18', '2019-06-18 05:09:15');
INSERT INTO `ltm_translations` VALUES (1327, 0, 'en', 'modules', 'feature.setting', 'Feature Setting', '2019-06-18 05:06:18', '2019-06-18 05:09:15');
INSERT INTO `ltm_translations` VALUES (1328, 0, 'en', 'modules', 'module.attendance', 'Attendance', '2019-06-18 05:06:18', '2019-06-18 05:09:16');
INSERT INTO `ltm_translations` VALUES (1329, 0, 'en', 'modules', 'module.clients', 'Clients', '2019-06-18 05:06:19', '2019-06-18 05:09:16');
INSERT INTO `ltm_translations` VALUES (1330, 0, 'en', 'modules', 'module.employees', 'Employees', '2019-06-18 05:06:19', '2019-06-18 05:09:16');
INSERT INTO `ltm_translations` VALUES (1331, 0, 'en', 'modules', 'module.estimates', 'Estimates', '2019-06-18 05:06:19', '2019-06-18 05:09:16');
INSERT INTO `ltm_translations` VALUES (1332, 0, 'en', 'modules', 'module.events', 'Events', '2019-06-18 05:06:19', '2019-06-18 05:09:16');
INSERT INTO `ltm_translations` VALUES (1333, 0, 'en', 'modules', 'module.expenses', 'Expenses', '2019-06-18 05:06:19', '2019-06-18 05:09:16');
INSERT INTO `ltm_translations` VALUES (1334, 0, 'en', 'modules', 'module.holidays', 'Holidays', '2019-06-18 05:06:19', '2019-06-18 05:09:16');
INSERT INTO `ltm_translations` VALUES (1335, 0, 'en', 'modules', 'module.invoices', 'Invoices', '2019-06-18 05:06:19', '2019-06-18 05:09:16');
INSERT INTO `ltm_translations` VALUES (1336, 0, 'en', 'modules', 'module.leads', 'Leads', '2019-06-18 05:06:19', '2019-06-18 05:09:17');
INSERT INTO `ltm_translations` VALUES (1337, 0, 'en', 'modules', 'module.leaves', 'Leaves', '2019-06-18 05:06:19', '2019-06-18 05:09:17');
INSERT INTO `ltm_translations` VALUES (1338, 0, 'en', 'modules', 'module.messages', 'Messages', '2019-06-18 05:06:19', '2019-06-18 05:09:17');
INSERT INTO `ltm_translations` VALUES (1339, 0, 'en', 'modules', 'module.notice board', 'Notice Board', '2019-06-18 05:06:19', '2019-06-18 05:09:17');
INSERT INTO `ltm_translations` VALUES (1340, 0, 'en', 'modules', 'module.noticeBoard', 'Notice Board', '2019-06-18 05:06:19', '2019-06-18 05:09:17');
INSERT INTO `ltm_translations` VALUES (1341, 0, 'en', 'modules', 'module.notices', 'Notices', '2019-06-18 05:06:19', '2019-06-18 05:09:17');
INSERT INTO `ltm_translations` VALUES (1342, 0, 'en', 'modules', 'module.payments', 'Payments', '2019-06-18 05:06:19', '2019-06-18 05:09:18');
INSERT INTO `ltm_translations` VALUES (1343, 0, 'en', 'modules', 'module.products', 'Products', '2019-06-18 05:06:19', '2019-06-18 05:09:18');
INSERT INTO `ltm_translations` VALUES (1344, 0, 'en', 'modules', 'module.projects', 'Projects', '2019-06-18 05:06:19', '2019-06-18 05:09:18');
INSERT INTO `ltm_translations` VALUES (1345, 0, 'en', 'modules', 'module.tasks', 'Tasks', '2019-06-18 05:06:19', '2019-06-18 05:09:19');
INSERT INTO `ltm_translations` VALUES (1346, 0, 'en', 'modules', 'module.tickets', 'Tickets', '2019-06-18 05:06:20', '2019-06-18 05:09:19');
INSERT INTO `ltm_translations` VALUES (1347, 0, 'en', 'modules', 'module.timelogs', 'Time Logs', '2019-06-18 05:06:20', '2019-06-18 05:09:20');
INSERT INTO `ltm_translations` VALUES (1348, 0, 'en', 'modules', 'paymentSetting.paypal', 'Paypal', '2019-06-18 05:06:20', '2019-06-18 05:09:20');
INSERT INTO `ltm_translations` VALUES (1349, 0, 'en', 'modules', 'paymentSetting.stripe', 'Stripe', '2019-06-18 05:06:20', '2019-06-18 05:09:20');
INSERT INTO `ltm_translations` VALUES (1350, 0, 'en', 'modules', 'paymentSetting.paypalClientId', 'Paypal Client Id', '2019-06-18 05:06:20', '2019-06-18 05:09:20');
INSERT INTO `ltm_translations` VALUES (1351, 0, 'en', 'modules', 'paymentSetting.paypalSecret', 'Paypal Secret', '2019-06-18 05:06:20', '2019-06-18 05:09:20');
INSERT INTO `ltm_translations` VALUES (1352, 0, 'en', 'modules', 'paymentSetting.stripeClientId', 'Publishable Key', '2019-06-18 05:06:20', '2019-06-18 05:09:20');
INSERT INTO `ltm_translations` VALUES (1353, 0, 'en', 'modules', 'paymentSetting.stripeSecret', 'Stripe Secret', '2019-06-18 05:06:20', '2019-06-18 05:09:20');
INSERT INTO `ltm_translations` VALUES (1354, 0, 'en', 'modules', 'paymentSetting.stripeWebhookSecret', 'Stripe Webhook Secret', '2019-06-18 05:06:20', '2019-06-18 05:09:21');
INSERT INTO `ltm_translations` VALUES (1355, 0, 'en', 'modules', 'packageSetting.noOfDays', 'Number Of Days', '2019-06-18 05:06:20', '2019-06-18 05:09:21');
INSERT INTO `ltm_translations` VALUES (1356, 0, 'en', 'modules', 'packageSetting.notificationBeforeDays', 'Notification Before Days', '2019-06-18 05:06:20', '2019-06-18 05:09:21');
INSERT INTO `ltm_translations` VALUES (1357, 0, 'en', 'modules', 'package.stripeAnnualPlanId', 'Stripe Annual Plan ID', '2019-06-18 05:06:20', '2019-06-18 05:09:21');
INSERT INTO `ltm_translations` VALUES (1358, 0, 'en', 'modules', 'package.stripeMonthlyPlanId', 'Stripe Monthly Plan ID', '2019-06-18 05:06:20', '2019-06-18 05:09:21');
INSERT INTO `ltm_translations` VALUES (1359, 0, 'en', 'pagination', 'previous', '&laquo; Previous', '2019-06-18 05:06:20', '2019-06-18 05:09:21');
INSERT INTO `ltm_translations` VALUES (1360, 0, 'en', 'pagination', 'next', 'Next &raquo;', '2019-06-18 05:06:20', '2019-06-18 05:09:21');
INSERT INTO `ltm_translations` VALUES (1361, 0, 'en', 'passwords', 'password', 'Passwords must be at least six characters and match the confirmation.', '2019-06-18 05:06:21', '2019-06-18 05:09:21');
INSERT INTO `ltm_translations` VALUES (1362, 0, 'en', 'passwords', 'reset', 'Your password has been reset!', '2019-06-18 05:06:21', '2019-06-18 05:09:21');
INSERT INTO `ltm_translations` VALUES (1363, 0, 'en', 'passwords', 'sent', 'We have e-mailed your password reset link!', '2019-06-18 05:06:21', '2019-06-18 05:09:22');
INSERT INTO `ltm_translations` VALUES (1364, 0, 'en', 'passwords', 'token', 'This password reset token is invalid.', '2019-06-18 05:06:21', '2019-06-18 05:09:22');
INSERT INTO `ltm_translations` VALUES (1365, 0, 'en', 'passwords', 'user', 'We can\'t find a user with that e-mail address.', '2019-06-18 05:06:21', '2019-06-18 05:09:22');
INSERT INTO `ltm_translations` VALUES (1366, 0, 'en', 'validation', 'accepted', 'The :attribute must be accepted.', '2019-06-18 05:06:21', '2019-06-18 05:09:22');
INSERT INTO `ltm_translations` VALUES (1367, 0, 'en', 'validation', 'active_url', 'The :attribute is not a valid URL.', '2019-06-18 05:06:21', '2019-06-18 05:09:22');
INSERT INTO `ltm_translations` VALUES (1368, 0, 'en', 'validation', 'after', 'The :attribute must be a date after :date.', '2019-06-18 05:06:21', '2019-06-18 05:09:22');
INSERT INTO `ltm_translations` VALUES (1369, 0, 'en', 'validation', 'after_or_equal', 'The :attribute must be a date after or equal to :date.', '2019-06-18 05:06:21', '2019-06-18 05:09:22');
INSERT INTO `ltm_translations` VALUES (1370, 0, 'en', 'validation', 'alpha', 'The :attribute may only contain letters.', '2019-06-18 05:06:21', '2019-06-18 05:09:22');
INSERT INTO `ltm_translations` VALUES (1371, 0, 'en', 'validation', 'alpha_dash', 'The :attribute may only contain letters, numbers, and dashes.', '2019-06-18 05:06:21', '2019-06-18 05:09:23');
INSERT INTO `ltm_translations` VALUES (1372, 0, 'en', 'validation', 'alpha_num', 'The :attribute may only contain letters and numbers.', '2019-06-18 05:06:21', '2019-06-18 05:09:23');
INSERT INTO `ltm_translations` VALUES (1373, 0, 'en', 'validation', 'array', 'The :attribute must be an array.', '2019-06-18 05:06:21', '2019-06-18 05:09:23');
INSERT INTO `ltm_translations` VALUES (1374, 0, 'en', 'validation', 'before', 'The :attribute must be a date before :date.', '2019-06-18 05:06:21', '2019-06-18 05:09:23');
INSERT INTO `ltm_translations` VALUES (1375, 0, 'en', 'validation', 'before_or_equal', 'The :attribute must be a date before or equal to :date.', '2019-06-18 05:06:21', '2019-06-18 05:09:23');
INSERT INTO `ltm_translations` VALUES (1376, 0, 'en', 'validation', 'between.numeric', 'The :attribute must be between :min and :max.', '2019-06-18 05:06:21', '2019-06-18 05:09:23');
INSERT INTO `ltm_translations` VALUES (1377, 0, 'en', 'validation', 'between.file', 'The :attribute must be between :min and :max kilobytes.', '2019-06-18 05:06:21', '2019-06-18 05:09:23');
INSERT INTO `ltm_translations` VALUES (1378, 0, 'en', 'validation', 'between.string', 'The :attribute must be between :min and :max characters.', '2019-06-18 05:06:22', '2019-06-18 05:09:23');
INSERT INTO `ltm_translations` VALUES (1379, 0, 'en', 'validation', 'between.array', 'The :attribute must have between :min and :max items.', '2019-06-18 05:06:22', '2019-06-18 05:09:24');
INSERT INTO `ltm_translations` VALUES (1380, 0, 'en', 'validation', 'boolean', 'The :attribute field must be true or false.', '2019-06-18 05:06:22', '2019-06-18 05:09:24');
INSERT INTO `ltm_translations` VALUES (1381, 0, 'en', 'validation', 'confirmed', 'The :attribute confirmation does not match.', '2019-06-18 05:06:22', '2019-06-18 05:09:24');
INSERT INTO `ltm_translations` VALUES (1382, 0, 'en', 'validation', 'date', 'The :attribute is not a valid date.', '2019-06-18 05:06:22', '2019-06-18 05:09:24');
INSERT INTO `ltm_translations` VALUES (1383, 0, 'en', 'validation', 'date_format', 'The :attribute does not match the format :format.', '2019-06-18 05:06:22', '2019-06-18 05:09:24');
INSERT INTO `ltm_translations` VALUES (1384, 0, 'en', 'validation', 'different', 'The :attribute and :other must be different.', '2019-06-18 05:06:22', '2019-06-18 05:09:24');
INSERT INTO `ltm_translations` VALUES (1385, 0, 'en', 'validation', 'digits', 'The :attribute must be :digits digits.', '2019-06-18 05:06:22', '2019-06-18 05:09:24');
INSERT INTO `ltm_translations` VALUES (1386, 0, 'en', 'validation', 'digits_between', 'The :attribute must be between :min and :max digits.', '2019-06-18 05:06:22', '2019-06-18 05:09:24');
INSERT INTO `ltm_translations` VALUES (1387, 0, 'en', 'validation', 'dimensions', 'The :attribute has invalid image dimensions.', '2019-06-18 05:06:22', '2019-06-18 05:09:24');
INSERT INTO `ltm_translations` VALUES (1388, 0, 'en', 'validation', 'distinct', 'The :attribute field has a duplicate value.', '2019-06-18 05:06:22', '2019-06-18 05:09:24');
INSERT INTO `ltm_translations` VALUES (1389, 0, 'en', 'validation', 'email', 'The :attribute must be a valid email address.', '2019-06-18 05:06:22', '2019-06-18 05:09:25');
INSERT INTO `ltm_translations` VALUES (1390, 0, 'en', 'validation', 'exists', 'The selected :attribute is invalid.', '2019-06-18 05:06:22', '2019-06-18 05:09:25');
INSERT INTO `ltm_translations` VALUES (1391, 0, 'en', 'validation', 'file', 'The :attribute must be a file.', '2019-06-18 05:06:22', '2019-06-18 05:09:25');
INSERT INTO `ltm_translations` VALUES (1392, 0, 'en', 'validation', 'filled', 'The :attribute field must have a value.', '2019-06-18 05:06:22', '2019-06-18 05:09:25');
INSERT INTO `ltm_translations` VALUES (1393, 0, 'en', 'validation', 'image', 'The :attribute must be an image.', '2019-06-18 05:06:22', '2019-06-18 05:09:25');
INSERT INTO `ltm_translations` VALUES (1394, 0, 'en', 'validation', 'in', 'The selected :attribute is invalid.', '2019-06-18 05:06:22', '2019-06-18 05:09:25');
INSERT INTO `ltm_translations` VALUES (1395, 0, 'en', 'validation', 'in_array', 'The :attribute field does not exist in :other.', '2019-06-18 05:06:22', '2019-06-18 05:09:26');
INSERT INTO `ltm_translations` VALUES (1396, 0, 'en', 'validation', 'integer', 'The :attribute must be an integer.', '2019-06-18 05:06:22', '2019-06-18 05:09:26');
INSERT INTO `ltm_translations` VALUES (1397, 0, 'en', 'validation', 'ip', 'The :attribute must be a valid IP address.', '2019-06-18 05:06:23', '2019-06-18 05:09:26');
INSERT INTO `ltm_translations` VALUES (1398, 0, 'en', 'validation', 'json', 'The :attribute must be a valid JSON string.', '2019-06-18 05:06:23', '2019-06-18 05:09:26');
INSERT INTO `ltm_translations` VALUES (1399, 0, 'en', 'validation', 'max.numeric', 'The :attribute may not be greater than :max.', '2019-06-18 05:06:23', '2019-06-18 05:09:26');
INSERT INTO `ltm_translations` VALUES (1400, 0, 'en', 'validation', 'max.file', 'The :attribute may not be greater than :max kilobytes.', '2019-06-18 05:06:23', '2019-06-18 05:09:26');
INSERT INTO `ltm_translations` VALUES (1401, 0, 'en', 'validation', 'max.string', 'The :attribute may not be greater than :max characters.', '2019-06-18 05:06:23', '2019-06-18 05:09:26');
INSERT INTO `ltm_translations` VALUES (1402, 0, 'en', 'validation', 'max.array', 'The :attribute may not have more than :max items.', '2019-06-18 05:06:23', '2019-06-18 05:09:26');
INSERT INTO `ltm_translations` VALUES (1403, 0, 'en', 'validation', 'mimes', 'The :attribute must be a file of type: :values.', '2019-06-18 05:06:23', '2019-06-18 05:09:26');
INSERT INTO `ltm_translations` VALUES (1404, 0, 'en', 'validation', 'mimetypes', 'The :attribute must be a file of type: :values.', '2019-06-18 05:06:23', '2019-06-18 05:09:27');
INSERT INTO `ltm_translations` VALUES (1405, 0, 'en', 'validation', 'min.numeric', 'The :attribute must be at least :min.', '2019-06-18 05:06:23', '2019-06-18 05:09:27');
INSERT INTO `ltm_translations` VALUES (1406, 0, 'en', 'validation', 'min.file', 'The :attribute must be at least :min kilobytes.', '2019-06-18 05:06:23', '2019-06-18 05:09:27');
INSERT INTO `ltm_translations` VALUES (1407, 0, 'en', 'validation', 'min.string', 'The :attribute must be at least :min characters.', '2019-06-18 05:06:23', '2019-06-18 05:09:27');
INSERT INTO `ltm_translations` VALUES (1408, 0, 'en', 'validation', 'min.array', 'The :attribute must have at least :min items.', '2019-06-18 05:06:23', '2019-06-18 05:09:27');
INSERT INTO `ltm_translations` VALUES (1409, 0, 'en', 'validation', 'not_in', 'The selected :attribute is invalid.', '2019-06-18 05:06:24', '2019-06-18 05:09:27');
INSERT INTO `ltm_translations` VALUES (1410, 0, 'en', 'validation', 'numeric', 'The :attribute must be a number.', '2019-06-18 05:06:24', '2019-06-18 05:09:27');
INSERT INTO `ltm_translations` VALUES (1411, 0, 'en', 'validation', 'present', 'The :attribute field must be present.', '2019-06-18 05:06:24', '2019-06-18 05:09:27');
INSERT INTO `ltm_translations` VALUES (1412, 0, 'en', 'validation', 'regex', 'The :attribute format is invalid.', '2019-06-18 05:06:24', '2019-06-18 05:09:28');
INSERT INTO `ltm_translations` VALUES (1413, 0, 'en', 'validation', 'required', 'The :attribute field is required.', '2019-06-18 05:06:24', '2019-06-18 05:09:28');
INSERT INTO `ltm_translations` VALUES (1414, 0, 'en', 'validation', 'required_if', 'The :attribute field is required when :other is :value.', '2019-06-18 05:06:24', '2019-06-18 05:09:28');
INSERT INTO `ltm_translations` VALUES (1415, 0, 'en', 'validation', 'required_unless', 'The :attribute field is required unless :other is in :values.', '2019-06-18 05:06:24', '2019-06-18 05:09:28');
INSERT INTO `ltm_translations` VALUES (1416, 0, 'en', 'validation', 'required_with', 'The :attribute field is required when :values is present.', '2019-06-18 05:06:25', '2019-06-18 05:09:28');
INSERT INTO `ltm_translations` VALUES (1417, 0, 'en', 'validation', 'required_with_all', 'The :attribute field is required when :values is present.', '2019-06-18 05:06:25', '2019-06-18 05:09:28');
INSERT INTO `ltm_translations` VALUES (1418, 0, 'en', 'validation', 'required_without', 'The :attribute field is required when :values is not present.', '2019-06-18 05:06:25', '2019-06-18 05:09:28');
INSERT INTO `ltm_translations` VALUES (1419, 0, 'en', 'validation', 'required_without_all', 'The :attribute field is required when none of :values are present.', '2019-06-18 05:06:25', '2019-06-18 05:09:28');
INSERT INTO `ltm_translations` VALUES (1420, 0, 'en', 'validation', 'same', 'The :attribute and :other must match.', '2019-06-18 05:06:25', '2019-06-18 05:09:29');
INSERT INTO `ltm_translations` VALUES (1421, 0, 'en', 'validation', 'size.numeric', 'The :attribute must be :size.', '2019-06-18 05:06:25', '2019-06-18 05:09:29');
INSERT INTO `ltm_translations` VALUES (1422, 0, 'en', 'validation', 'size.file', 'The :attribute must be :size kilobytes.', '2019-06-18 05:06:25', '2019-06-18 05:09:29');
INSERT INTO `ltm_translations` VALUES (1423, 0, 'en', 'validation', 'size.string', 'The :attribute must be :size characters.', '2019-06-18 05:06:26', '2019-06-18 05:09:29');
INSERT INTO `ltm_translations` VALUES (1424, 0, 'en', 'validation', 'size.array', 'The :attribute must contain :size items.', '2019-06-18 05:06:26', '2019-06-18 05:09:29');
INSERT INTO `ltm_translations` VALUES (1425, 0, 'en', 'validation', 'string', 'The :attribute must be a string.', '2019-06-18 05:06:26', '2019-06-18 05:09:29');
INSERT INTO `ltm_translations` VALUES (1426, 0, 'en', 'validation', 'timezone', 'The :attribute must be a valid zone.', '2019-06-18 05:06:26', '2019-06-18 05:09:29');
INSERT INTO `ltm_translations` VALUES (1427, 0, 'en', 'validation', 'unique', 'The :attribute has already been taken.', '2019-06-18 05:06:26', '2019-06-18 05:09:29');
INSERT INTO `ltm_translations` VALUES (1428, 0, 'en', 'validation', 'uploaded', 'The :attribute failed to upload.', '2019-06-18 05:06:26', '2019-06-18 05:09:30');
INSERT INTO `ltm_translations` VALUES (1429, 0, 'en', 'validation', 'url', 'The :attribute format is invalid.', '2019-06-18 05:06:26', '2019-06-18 05:09:30');
INSERT INTO `ltm_translations` VALUES (1430, 0, 'en', 'validation', 'custom.attribute-name.rule-name', 'custom-message', '2019-06-18 05:06:26', '2019-06-18 05:09:30');
INSERT INTO `ltm_translations` VALUES (1431, 0, 'es', 'app', 'loginAsEmployee', 'Iniciar sesión como empleado', '2019-06-18 05:06:27', '2019-06-18 05:09:30');
INSERT INTO `ltm_translations` VALUES (1432, 0, 'es', 'app', 'action', 'Acción', '2019-06-18 05:06:27', '2019-06-18 05:09:30');
INSERT INTO `ltm_translations` VALUES (1433, 0, 'es', 'app', 'active', 'activo', '2019-06-18 05:06:27', '2019-06-18 05:09:30');
INSERT INTO `ltm_translations` VALUES (1434, 0, 'es', 'app', 'addNew', 'Añadir nuevo', '2019-06-18 05:06:28', '2019-06-18 05:09:30');
INSERT INTO `ltm_translations` VALUES (1435, 0, 'es', 'app', 'address', 'la dirección', '2019-06-18 05:06:28', '2019-06-18 05:09:31');
INSERT INTO `ltm_translations` VALUES (1436, 0, 'es', 'app', 'adminPanel', 'Panel de administrador', '2019-06-18 05:06:28', '2019-06-18 05:09:31');
INSERT INTO `ltm_translations` VALUES (1437, 0, 'es', 'app', 'apply', 'aplicar', '2019-06-18 05:06:28', '2019-06-18 05:09:31');
INSERT INTO `ltm_translations` VALUES (1438, 0, 'es', 'app', 'back', 'Espalda', '2019-06-18 05:06:28', '2019-06-18 05:09:31');
INSERT INTO `ltm_translations` VALUES (1439, 0, 'es', 'app', 'change', 'el cambio', '2019-06-18 05:06:28', '2019-06-18 05:09:31');
INSERT INTO `ltm_translations` VALUES (1440, 0, 'es', 'app', 'client', 'cliente', '2019-06-18 05:06:29', '2019-06-18 05:09:31');
INSERT INTO `ltm_translations` VALUES (1441, 0, 'es', 'app', 'clientPanel', 'Panel de clientes', '2019-06-18 05:06:29', '2019-06-18 05:09:31');
INSERT INTO `ltm_translations` VALUES (1442, 0, 'es', 'app', 'completed', 'terminado', '2019-06-18 05:06:29', '2019-06-18 05:09:31');
INSERT INTO `ltm_translations` VALUES (1443, 0, 'es', 'app', 'completion', 'la terminación', '2019-06-18 05:06:29', '2019-06-18 05:09:31');
INSERT INTO `ltm_translations` VALUES (1444, 0, 'es', 'app', 'createdAt', 'Creado en', '2019-06-18 05:06:29', '2019-06-18 05:09:32');
INSERT INTO `ltm_translations` VALUES (1445, 0, 'es', 'app', 'date', 'la fecha', '2019-06-18 05:06:29', '2019-06-18 05:09:32');
INSERT INTO `ltm_translations` VALUES (1446, 0, 'es', 'app', 'deadline', 'la fecha tope', '2019-06-18 05:06:29', '2019-06-18 05:09:32');
INSERT INTO `ltm_translations` VALUES (1447, 0, 'es', 'app', 'description', 'la descripción', '2019-06-18 05:06:29', '2019-06-18 05:09:32');
INSERT INTO `ltm_translations` VALUES (1448, 0, 'es', 'app', 'details', 'detalles', '2019-06-18 05:06:30', '2019-06-18 05:09:32');
INSERT INTO `ltm_translations` VALUES (1449, 0, 'es', 'app', 'dueDate', 'Fecha de vencimiento', '2019-06-18 05:06:30', '2019-06-18 05:09:32');
INSERT INTO `ltm_translations` VALUES (1450, 0, 'es', 'app', 'edit', 'editar', '2019-06-18 05:06:30', '2019-06-18 05:09:32');
INSERT INTO `ltm_translations` VALUES (1451, 0, 'es', 'app', 'email', 'Email', '2019-06-18 05:06:30', '2019-06-18 05:09:32');
INSERT INTO `ltm_translations` VALUES (1452, 0, 'es', 'app', 'employeePanel', 'Panel de empleados', '2019-06-18 05:06:30', '2019-06-18 05:09:33');
INSERT INTO `ltm_translations` VALUES (1453, 0, 'es', 'app', 'filterResults', 'Filtrar Resultados', '2019-06-18 05:06:31', '2019-06-18 05:09:33');
INSERT INTO `ltm_translations` VALUES (1454, 0, 'es', 'app', 'hideCompletedTasks', 'Ocultar tareas completadas', '2019-06-18 05:06:31', '2019-06-18 05:09:33');
INSERT INTO `ltm_translations` VALUES (1455, 0, 'es', 'app', 'id', 'Idaho', '2019-06-18 05:06:31', '2019-06-18 05:09:33');
INSERT INTO `ltm_translations` VALUES (1456, 0, 'es', 'app', 'incomplete', 'incompleto', '2019-06-18 05:06:31', '2019-06-18 05:09:33');
INSERT INTO `ltm_translations` VALUES (1457, 0, 'es', 'app', 'invoice', 'la factura', '2019-06-18 05:06:31', '2019-06-18 05:09:33');
INSERT INTO `ltm_translations` VALUES (1458, 0, 'es', 'app', 'loginAsAdmin', 'Ingresar como administrador', '2019-06-18 05:06:31', '2019-06-18 05:09:33');
INSERT INTO `ltm_translations` VALUES (1459, 0, 'es', 'app', 'logout', 'Cerrar sesión', '2019-06-18 05:06:31', '2019-06-18 05:09:33');
INSERT INTO `ltm_translations` VALUES (1460, 0, 'es', 'app', 'markRead', 'Marcar como leído', '2019-06-18 05:06:32', '2019-06-18 05:09:33');
INSERT INTO `ltm_translations` VALUES (1461, 0, 'es', 'app', 'menu.accountSettings', 'Configuración de la empresa', '2019-06-18 05:06:32', '2019-06-18 05:09:33');
INSERT INTO `ltm_translations` VALUES (1462, 0, 'es', 'app', 'menu.clients', 'la clientela', '2019-06-18 05:06:32', '2019-06-18 05:09:34');
INSERT INTO `ltm_translations` VALUES (1463, 0, 'es', 'app', 'menu.contacts', 'el contacto', '2019-06-18 05:06:32', '2019-06-18 05:09:34');
INSERT INTO `ltm_translations` VALUES (1464, 0, 'es', 'app', 'menu.currencySettings', 'Configuración de la moneda', '2019-06-18 05:06:32', '2019-06-18 05:09:34');
INSERT INTO `ltm_translations` VALUES (1465, 0, 'es', 'app', 'menu.dashboard', 'el salpicadero', '2019-06-18 05:06:32', '2019-06-18 05:09:34');
INSERT INTO `ltm_translations` VALUES (1466, 0, 'es', 'app', 'menu.emailSettings', 'Ajustes del correo electrónico', '2019-06-18 05:06:32', '2019-06-18 05:09:34');
INSERT INTO `ltm_translations` VALUES (1467, 0, 'es', 'app', 'menu.employees', 'Empleados', '2019-06-18 05:06:32', '2019-06-18 05:09:34');
INSERT INTO `ltm_translations` VALUES (1468, 0, 'es', 'app', 'menu.financeReport', 'Informe Financiero', '2019-06-18 05:06:32', '2019-06-18 05:09:34');
INSERT INTO `ltm_translations` VALUES (1469, 0, 'es', 'app', 'menu.home', 'la casa', '2019-06-18 05:06:32', '2019-06-18 05:09:34');
INSERT INTO `ltm_translations` VALUES (1470, 0, 'es', 'app', 'menu.invoices', 'la factura', '2019-06-18 05:06:32', '2019-06-18 05:09:35');
INSERT INTO `ltm_translations` VALUES (1471, 0, 'es', 'app', 'menu.issues', 'emitir', '2019-06-18 05:06:32', '2019-06-18 05:09:35');
INSERT INTO `ltm_translations` VALUES (1472, 0, 'es', 'app', 'menu.messages', 'el mensaje', '2019-06-18 05:06:33', '2019-06-18 05:09:35');
INSERT INTO `ltm_translations` VALUES (1473, 0, 'es', 'app', 'menu.moduleSettings', 'Configuración del módulo', '2019-06-18 05:06:33', '2019-06-18 05:09:36');
INSERT INTO `ltm_translations` VALUES (1474, 0, 'es', 'app', 'menu.noticeBoard', 'Tablón de anuncios', '2019-06-18 05:06:33', '2019-06-18 05:09:36');
INSERT INTO `ltm_translations` VALUES (1475, 0, 'es', 'app', 'menu.profileSettings', 'Configuración de perfil', '2019-06-18 05:06:33', '2019-06-18 05:09:36');
INSERT INTO `ltm_translations` VALUES (1476, 0, 'es', 'app', 'menu.projects', 'el proyecto', '2019-06-18 05:06:33', '2019-06-18 05:09:36');
INSERT INTO `ltm_translations` VALUES (1477, 0, 'es', 'app', 'menu.reports', 'el informe', '2019-06-18 05:06:33', '2019-06-18 05:09:37');
INSERT INTO `ltm_translations` VALUES (1478, 0, 'es', 'app', 'menu.settings', 'el ajuste', '2019-06-18 05:06:33', '2019-06-18 05:09:37');
INSERT INTO `ltm_translations` VALUES (1479, 0, 'es', 'app', 'menu.stickyNotes', 'Notas adhesivas', '2019-06-18 05:06:33', '2019-06-18 05:09:37');
INSERT INTO `ltm_translations` VALUES (1480, 0, 'es', 'app', 'menu.taskCalendar', 'Calendario de tareas', '2019-06-18 05:06:33', '2019-06-18 05:09:37');
INSERT INTO `ltm_translations` VALUES (1481, 0, 'es', 'app', 'menu.taskReport', 'Informe de tareas', '2019-06-18 05:06:33', '2019-06-18 05:09:37');
INSERT INTO `ltm_translations` VALUES (1482, 0, 'es', 'app', 'menu.tasks', 'Tareas', '2019-06-18 05:06:34', '2019-06-18 05:09:37');
INSERT INTO `ltm_translations` VALUES (1483, 0, 'es', 'app', 'menu.timeLogReport', 'Informe de registro de tiempo', '2019-06-18 05:06:34', '2019-06-18 05:09:37');
INSERT INTO `ltm_translations` VALUES (1484, 0, 'es', 'app', 'menu.timeLogs', 'Registros de tiempo', '2019-06-18 05:06:34', '2019-06-18 05:09:38');
INSERT INTO `ltm_translations` VALUES (1485, 0, 'es', 'app', 'menu.themeSettings', 'Ajustes de tema', '2019-06-18 05:06:34', '2019-06-18 05:09:38');
INSERT INTO `ltm_translations` VALUES (1486, 0, 'es', 'app', 'menu.estimates', 'Estimates', '2019-06-18 05:06:34', '2019-06-18 05:09:38');
INSERT INTO `ltm_translations` VALUES (1487, 0, 'es', 'app', 'menu.paymentGatewayCredential', 'Credenciales de Gateway de pago', '2019-06-18 05:06:34', '2019-06-18 05:09:38');
INSERT INTO `ltm_translations` VALUES (1488, 0, 'es', 'app', 'menu.payments', 'Pagos', '2019-06-18 05:06:34', '2019-06-18 05:09:38');
INSERT INTO `ltm_translations` VALUES (1489, 0, 'es', 'app', 'menu.expenses', 'Expenses', '2019-06-18 05:06:34', '2019-06-18 05:09:38');
INSERT INTO `ltm_translations` VALUES (1490, 0, 'es', 'app', 'menu.incomeVsExpenseReport', 'Reporte de ingresos vs. gastos', '2019-06-18 05:06:34', '2019-06-18 05:09:38');
INSERT INTO `ltm_translations` VALUES (1491, 0, 'es', 'app', 'menu.invoiceSettings', 'Configuración de factura', '2019-06-18 05:06:35', '2019-06-18 05:09:38');
INSERT INTO `ltm_translations` VALUES (1492, 0, 'es', 'app', 'menu.updates', 'Registro de actualizaciones', '2019-06-18 05:06:35', '2019-06-18 05:09:38');
INSERT INTO `ltm_translations` VALUES (1493, 0, 'es', 'app', 'menu.ticketSettings', 'Configuración de entradas', '2019-06-18 05:06:35', '2019-06-18 05:09:38');
INSERT INTO `ltm_translations` VALUES (1494, 0, 'es', 'app', 'menu.ticketAgents', 'Agentes de entradas', '2019-06-18 05:06:35', '2019-06-18 05:09:39');
INSERT INTO `ltm_translations` VALUES (1495, 0, 'es', 'app', 'menu.ticketTypes', 'Tipos de entradas', '2019-06-18 05:06:35', '2019-06-18 05:09:39');
INSERT INTO `ltm_translations` VALUES (1496, 0, 'es', 'app', 'menu.ticketChannel', 'Canal de entrada', '2019-06-18 05:06:35', '2019-06-18 05:09:39');
INSERT INTO `ltm_translations` VALUES (1497, 0, 'es', 'app', 'menu.replyTemplates', 'Plantillas de respuesta', '2019-06-18 05:06:35', '2019-06-18 05:09:39');
INSERT INTO `ltm_translations` VALUES (1498, 0, 'es', 'app', 'menu.attendanceSettings', 'Configuración de Asistencia', '2019-06-18 05:06:35', '2019-06-18 05:09:39');
INSERT INTO `ltm_translations` VALUES (1499, 0, 'es', 'app', 'menu.attendance', 'la asistencia', '2019-06-18 05:06:35', '2019-06-18 05:09:39');
INSERT INTO `ltm_translations` VALUES (1500, 0, 'es', 'app', 'menu.slackSettings', 'Configuración de holgura', '2019-06-18 05:06:36', '2019-06-18 05:09:40');
INSERT INTO `ltm_translations` VALUES (1501, 0, 'es', 'app', 'menu.tickets', 'el billete', '2019-06-18 05:06:36', '2019-06-18 05:09:40');
INSERT INTO `ltm_translations` VALUES (1502, 0, 'es', 'app', 'menu.finance', 'Financiero', '2019-06-18 05:06:36', '2019-06-18 05:09:40');
INSERT INTO `ltm_translations` VALUES (1503, 0, 'es', 'app', 'menu.Events', 'evento', '2019-06-18 05:06:36', '2019-06-18 05:09:40');
INSERT INTO `ltm_translations` VALUES (1504, 0, 'es', 'app', 'menu.rolesPermission', 'Roles y Permisos', '2019-06-18 05:06:36', '2019-06-18 05:09:40');
INSERT INTO `ltm_translations` VALUES (1505, 0, 'es', 'app', 'menu.messageSettings', 'Configuraciones de mensajes', '2019-06-18 05:06:36', '2019-06-18 05:09:40');
INSERT INTO `ltm_translations` VALUES (1506, 0, 'es', 'app', 'menu.storageSettings', 'Configuración de almacenamiento', '2019-06-18 05:06:37', '2019-06-18 05:09:40');
INSERT INTO `ltm_translations` VALUES (1507, 0, 'es', 'app', 'menu.leaveSettings', 'Configuración de hojas', '2019-06-18 05:06:37', '2019-06-18 05:09:40');
INSERT INTO `ltm_translations` VALUES (1508, 0, 'es', 'app', 'menu.leaveReport', 'Dejar informe', '2019-06-18 05:06:37', '2019-06-18 05:09:40');
INSERT INTO `ltm_translations` VALUES (1509, 0, 'es', 'app', 'menu.products', 'Productos', '2019-06-18 05:06:37', '2019-06-18 05:09:40');
INSERT INTO `ltm_translations` VALUES (1510, 0, 'es', 'app', 'mobile', 'móvil', '2019-06-18 05:06:37', '2019-06-18 05:09:41');
INSERT INTO `ltm_translations` VALUES (1511, 0, 'es', 'app', 'name', 'el nombre', '2019-06-18 05:06:37', '2019-06-18 05:09:41');
INSERT INTO `ltm_translations` VALUES (1512, 0, 'es', 'app', 'note', 'la nota', '2019-06-18 05:06:37', '2019-06-18 05:09:41');
INSERT INTO `ltm_translations` VALUES (1513, 0, 'es', 'app', 'phone', 'el teléfono', '2019-06-18 05:06:37', '2019-06-18 05:09:41');
INSERT INTO `ltm_translations` VALUES (1514, 0, 'es', 'app', 'project', 'el proyecto', '2019-06-18 05:06:37', '2019-06-18 05:09:42');
INSERT INTO `ltm_translations` VALUES (1515, 0, 'es', 'app', 'remove', 'quitar', '2019-06-18 05:06:37', '2019-06-18 05:09:42');
INSERT INTO `ltm_translations` VALUES (1516, 0, 'es', 'app', 'reset', 'reajustar', '2019-06-18 05:06:37', '2019-06-18 05:09:42');
INSERT INTO `ltm_translations` VALUES (1517, 0, 'es', 'app', 'save', 'guardar', '2019-06-18 05:06:38', '2019-06-18 05:09:42');
INSERT INTO `ltm_translations` VALUES (1518, 0, 'es', 'app', 'search', 'Buscar...', '2019-06-18 05:06:38', '2019-06-18 05:09:42');
INSERT INTO `ltm_translations` VALUES (1519, 0, 'es', 'app', 'selectDateRange', 'Seleccione Rango de fechas', '2019-06-18 05:06:38', '2019-06-18 05:09:43');
INSERT INTO `ltm_translations` VALUES (1520, 0, 'es', 'app', 'selectImage', 'Seleccionar imagen', '2019-06-18 05:06:38', '2019-06-18 05:09:43');
INSERT INTO `ltm_translations` VALUES (1521, 0, 'es', 'app', 'selectProject', 'Seleccionar proyecto', '2019-06-18 05:06:38', '2019-06-18 05:09:43');
INSERT INTO `ltm_translations` VALUES (1522, 0, 'es', 'app', 'status', 'el estado', '2019-06-18 05:06:38', '2019-06-18 05:09:43');
INSERT INTO `ltm_translations` VALUES (1523, 0, 'es', 'app', 'stop', 'Deténgase', '2019-06-18 05:06:38', '2019-06-18 05:09:43');
INSERT INTO `ltm_translations` VALUES (1524, 0, 'es', 'app', 'task', 'la tarea', '2019-06-18 05:06:38', '2019-06-18 05:09:43');
INSERT INTO `ltm_translations` VALUES (1525, 0, 'es', 'app', 'title', 'el título', '2019-06-18 05:06:38', '2019-06-18 05:09:43');
INSERT INTO `ltm_translations` VALUES (1526, 0, 'es', 'app', 'update', 'actualizar', '2019-06-18 05:06:38', '2019-06-18 05:09:43');
INSERT INTO `ltm_translations` VALUES (1527, 0, 'es', 'app', 'exportExcel', 'Exportar a Excel', '2019-06-18 05:06:38', '2019-06-18 05:09:43');
INSERT INTO `ltm_translations` VALUES (1528, 0, 'es', 'app', 'datatable', '//cdn.datatables.net/plug-ins/1.10.15/i18n/Spanish.json', '2019-06-18 05:06:38', '2019-06-18 05:09:44');
INSERT INTO `ltm_translations` VALUES (1529, 0, 'es', 'app', 'role', 'Rol del usuario', '2019-06-18 05:06:38', '2019-06-18 05:09:44');
INSERT INTO `ltm_translations` VALUES (1530, 0, 'es', 'app', 'projectAdminPanel', 'Panel de administración del proyecto', '2019-06-18 05:06:38', '2019-06-18 05:09:44');
INSERT INTO `ltm_translations` VALUES (1531, 0, 'es', 'app', 'loginAsProjectAdmin', 'Iniciar Sesión como Project Admin', '2019-06-18 05:06:39', '2019-06-18 05:09:44');
INSERT INTO `ltm_translations` VALUES (1532, 0, 'es', 'app', 'pending', 'Pendiente', '2019-06-18 05:06:39', '2019-06-18 05:09:44');
INSERT INTO `ltm_translations` VALUES (1533, 0, 'es', 'app', 'price', 'Precio', '2019-06-18 05:06:39', '2019-06-18 05:09:44');
INSERT INTO `ltm_translations` VALUES (1534, 0, 'es', 'app', 'duration', 'Duración', '2019-06-18 05:06:39', '2019-06-18 05:09:44');
INSERT INTO `ltm_translations` VALUES (1535, 0, 'es', 'app', 'last', 'Último', '2019-06-18 05:06:39', '2019-06-18 05:09:44');
INSERT INTO `ltm_translations` VALUES (1536, 0, 'es', 'app', 'month', 'Mes', '2019-06-18 05:06:39', '2019-06-18 05:09:44');
INSERT INTO `ltm_translations` VALUES (1537, 0, 'es', 'app', 'select', 'Seleccionar', '2019-06-18 05:06:39', '2019-06-18 05:09:45');
INSERT INTO `ltm_translations` VALUES (1538, 0, 'es', 'app', 'income', 'Ingresos', '2019-06-18 05:06:39', '2019-06-18 05:09:45');
INSERT INTO `ltm_translations` VALUES (1539, 0, 'es', 'app', 'expense', 'Gastos', '2019-06-18 05:06:40', '2019-06-18 05:09:45');
INSERT INTO `ltm_translations` VALUES (1540, 0, 'es', 'app', 'total', 'Total', '2019-06-18 05:06:40', '2019-06-18 05:09:45');
INSERT INTO `ltm_translations` VALUES (1541, 0, 'es', 'app', 'days', 'Días', '2019-06-18 05:06:40', '2019-06-18 05:09:45');
INSERT INTO `ltm_translations` VALUES (1542, 0, 'es', 'app', 'year', 'Año', '2019-06-18 05:06:40', '2019-06-18 05:09:45');
INSERT INTO `ltm_translations` VALUES (1543, 0, 'es', 'app', 'yes', 'Sí', '2019-06-18 05:06:40', '2019-06-18 05:09:45');
INSERT INTO `ltm_translations` VALUES (1544, 0, 'es', 'app', 'no', 'No', '2019-06-18 05:06:40', '2019-06-18 05:09:46');
INSERT INTO `ltm_translations` VALUES (1545, 0, 'es', 'app', 'day', 'Día', '2019-06-18 05:06:40', '2019-06-18 05:09:46');
INSERT INTO `ltm_translations` VALUES (1546, 0, 'es', 'app', 'week', 'Semana', '2019-06-18 05:06:40', '2019-06-18 05:09:46');
INSERT INTO `ltm_translations` VALUES (1547, 0, 'es', 'app', 'submit', 'Enviar', '2019-06-18 05:06:41', '2019-06-18 05:09:47');
INSERT INTO `ltm_translations` VALUES (1548, 0, 'es', 'app', 'required', 'necesario', '2019-06-18 05:06:41', '2019-06-18 05:09:47');
INSERT INTO `ltm_translations` VALUES (1549, 0, 'es', 'app', 'filterBy', 'Filtrado por', '2019-06-18 05:06:41', '2019-06-18 05:09:47');
INSERT INTO `ltm_translations` VALUES (1550, 0, 'es', 'app', 'others', 'otros', '2019-06-18 05:06:41', '2019-06-18 05:09:47');
INSERT INTO `ltm_translations` VALUES (1551, 0, 'es', 'app', 'delete', 'borrar', '2019-06-18 05:06:41', '2019-06-18 05:09:48');
INSERT INTO `ltm_translations` VALUES (1552, 0, 'es', 'app', 'add', 'añadir', '2019-06-18 05:06:42', '2019-06-18 05:09:48');
INSERT INTO `ltm_translations` VALUES (1553, 0, 'es', 'app', 'view', 'ver', '2019-06-18 05:06:42', '2019-06-18 05:09:48');
INSERT INTO `ltm_translations` VALUES (1554, 0, 'es', 'app', 'accept', 'aceptar', '2019-06-18 05:06:42', '2019-06-18 05:09:48');
INSERT INTO `ltm_translations` VALUES (1555, 0, 'es', 'app', 'reject', 'rechazar', '2019-06-18 05:06:42', '2019-06-18 05:09:48');
INSERT INTO `ltm_translations` VALUES (1556, 0, 'es', 'app', 'newNotifications', 'Nuevas notificaciones', '2019-06-18 05:06:42', '2019-06-18 05:09:48');
INSERT INTO `ltm_translations` VALUES (1557, 0, 'es', 'app', 'from', 'desde', '2019-06-18 05:06:42', '2019-06-18 05:09:48');
INSERT INTO `ltm_translations` VALUES (1558, 0, 'es', 'app', 'cancel', 'anular', '2019-06-18 05:06:42', '2019-06-18 05:09:48');
INSERT INTO `ltm_translations` VALUES (1559, 0, 'es', 'app', 'april', 'abril', '2019-06-18 05:06:42', '2019-06-18 05:09:48');
INSERT INTO `ltm_translations` VALUES (1560, 0, 'es', 'app', 'august', 'agosto', '2019-06-18 05:06:42', '2019-06-18 05:09:49');
INSERT INTO `ltm_translations` VALUES (1561, 0, 'es', 'app', 'december', 'diciembre', '2019-06-18 05:06:42', '2019-06-18 05:09:49');
INSERT INTO `ltm_translations` VALUES (1562, 0, 'es', 'app', 'february', 'febrero', '2019-06-18 05:06:43', '2019-06-18 05:09:49');
INSERT INTO `ltm_translations` VALUES (1563, 0, 'es', 'app', 'january', 'enero', '2019-06-18 05:06:43', '2019-06-18 05:09:49');
INSERT INTO `ltm_translations` VALUES (1564, 0, 'es', 'app', 'july', 'julio', '2019-06-18 05:06:43', '2019-06-18 05:09:49');
INSERT INTO `ltm_translations` VALUES (1565, 0, 'es', 'app', 'june', 'junio', '2019-06-18 05:06:43', '2019-06-18 05:09:49');
INSERT INTO `ltm_translations` VALUES (1566, 0, 'es', 'app', 'march', 'marzo', '2019-06-18 05:06:43', '2019-06-18 05:09:49');
INSERT INTO `ltm_translations` VALUES (1567, 0, 'es', 'app', 'may', 'mayo', '2019-06-18 05:06:43', '2019-06-18 05:09:49');
INSERT INTO `ltm_translations` VALUES (1568, 0, 'es', 'app', 'november', 'noviembre', '2019-06-18 05:06:43', '2019-06-18 05:09:49');
INSERT INTO `ltm_translations` VALUES (1569, 0, 'es', 'app', 'october', 'octubre', '2019-06-18 05:06:43', '2019-06-18 05:09:49');
INSERT INTO `ltm_translations` VALUES (1570, 0, 'es', 'app', 'september', 'septiembre', '2019-06-18 05:06:43', '2019-06-18 05:09:49');
INSERT INTO `ltm_translations` VALUES (1571, 0, 'es', 'app', 'approved', 'aprobado', '2019-06-18 05:06:43', '2019-06-18 05:09:49');
INSERT INTO `ltm_translations` VALUES (1572, 0, 'es', 'app', 'selectFile', 'Seleccione Archivo', '2019-06-18 05:06:44', '2019-06-18 05:09:49');
INSERT INTO `ltm_translations` VALUES (1573, 0, 'es', 'app', 'login', 'Iniciar sesión', '2019-06-18 05:06:44', '2019-06-18 05:09:49');
INSERT INTO `ltm_translations` VALUES (1574, 0, 'es', 'app', 'rememberMe', 'Recuérdame', '2019-06-18 05:06:45', '2019-06-18 05:09:49');
INSERT INTO `ltm_translations` VALUES (1575, 0, 'es', 'app', 'forgotPassword', 'Se te olvidó tu contraseña', '2019-06-18 05:06:45', '2019-06-18 05:09:50');
INSERT INTO `ltm_translations` VALUES (1576, 0, 'es', 'app', 'welcome', 'Bienvenido', '2019-06-18 05:06:45', '2019-06-18 05:09:50');
INSERT INTO `ltm_translations` VALUES (1577, 0, 'es', 'app', 'admin', 'administración', '2019-06-18 05:06:45', '2019-06-18 05:09:50');
INSERT INTO `ltm_translations` VALUES (1578, 0, 'es', 'app', 'forbiddenError', 'Error prohibido', '2019-06-18 05:06:45', '2019-06-18 05:09:50');
INSERT INTO `ltm_translations` VALUES (1579, 0, 'es', 'app', 'noPermission', 'No tienes permiso para acceder a esto.', '2019-06-18 05:06:45', '2019-06-18 05:09:50');
INSERT INTO `ltm_translations` VALUES (1580, 0, 'es', 'app', 'recoverPassword', 'Recuperar contraseña', '2019-06-18 05:06:45', '2019-06-18 05:09:50');
INSERT INTO `ltm_translations` VALUES (1581, 0, 'es', 'app', 'open', 'Abierto', '2019-06-18 05:06:46', '2019-06-18 05:09:50');
INSERT INTO `ltm_translations` VALUES (1582, 0, 'es', 'app', 'resolved', 'resuelto', '2019-06-18 05:06:46', '2019-06-18 05:09:50');
INSERT INTO `ltm_translations` VALUES (1583, 0, 'es', 'app', 'optional', 'opcional', '2019-06-18 05:06:46', '2019-06-18 05:09:50');
INSERT INTO `ltm_translations` VALUES (1584, 0, 'es', 'app', 'female', 'masculino', '2019-06-18 05:06:46', '2019-06-18 05:09:50');
INSERT INTO `ltm_translations` VALUES (1585, 0, 'es', 'app', 'male', 'masculino', '2019-06-18 05:06:46', '2019-06-18 05:09:51');
INSERT INTO `ltm_translations` VALUES (1586, 0, 'es', 'app', 'language', 'idioma', '2019-06-18 05:06:46', '2019-06-18 05:09:51');
INSERT INTO `ltm_translations` VALUES (1587, 0, 'es', 'app', 'upcoming', 'Próximo', '2019-06-18 05:06:46', '2019-06-18 05:09:51');
INSERT INTO `ltm_translations` VALUES (1588, 0, 'es', 'app', 'minutes', 'Minutos', '2019-06-18 05:06:46', '2019-06-18 05:09:51');
INSERT INTO `ltm_translations` VALUES (1589, 0, 'es', 'app', 'onLeave', 'De vacaciones', '2019-06-18 05:06:46', '2019-06-18 05:09:51');
INSERT INTO `ltm_translations` VALUES (1590, 0, 'es', 'app', 'inclusiveAllTaxes', 'Inclusivo Todos los impuestos', '2019-06-18 05:06:47', '2019-06-18 05:09:51');
INSERT INTO `ltm_translations` VALUES (1591, 0, 'es', 'app', 'reason', 'Razón', '2019-06-18 05:06:47', '2019-06-18 05:09:51');
INSERT INTO `ltm_translations` VALUES (1592, 0, 'es', 'auth', 'failed', 'Estas credenciales no coinciden con nuestros registros.', '2019-06-18 05:06:47', '2019-06-18 05:09:52');
INSERT INTO `ltm_translations` VALUES (1593, 0, 'es', 'auth', 'throttle', 'Demasiados intentos de acceso. Por favor intente nuevamente en :seconds segundos.', '2019-06-18 05:06:47', '2019-06-18 05:09:52');
INSERT INTO `ltm_translations` VALUES (1594, 0, 'es', 'email', 'newEvent.subject', 'Nuevo evento creado', '2019-06-18 05:06:47', '2019-06-18 05:09:52');
INSERT INTO `ltm_translations` VALUES (1595, 0, 'es', 'email', 'newEvent.text', 'Nuevo evento ha sido creado. Descargue el archivo adjunto para agregar evento a su calendario.', '2019-06-18 05:06:47', '2019-06-18 05:09:52');
INSERT INTO `ltm_translations` VALUES (1596, 0, 'es', 'email', 'loginDashboard', 'Iniciar sesión en el tablero', '2019-06-18 05:06:47', '2019-06-18 05:09:52');
INSERT INTO `ltm_translations` VALUES (1597, 0, 'es', 'email', 'thankyouNote', '¡Gracias por usar nuestra aplicación!', '2019-06-18 05:06:47', '2019-06-18 05:09:52');
INSERT INTO `ltm_translations` VALUES (1598, 0, 'es', 'email', 'hello', 'Hola', '2019-06-18 05:06:47', '2019-06-18 05:09:52');
INSERT INTO `ltm_translations` VALUES (1599, 0, 'es', 'email', 'regards', 'recuerdos', '2019-06-18 05:06:48', '2019-06-18 05:09:52');
INSERT INTO `ltm_translations` VALUES (1600, 0, 'es', 'email', 'newExpense.subject', 'Nuevo gasto agregado', '2019-06-18 05:06:48', '2019-06-18 05:09:52');
INSERT INTO `ltm_translations` VALUES (1601, 0, 'es', 'email', 'expenseStatus.subject', 'Estado de gastos actualizado', '2019-06-18 05:06:48', '2019-06-18 05:09:52');
INSERT INTO `ltm_translations` VALUES (1602, 0, 'es', 'email', 'expenseStatus.text', 'Su estado de gasto actualizado a', '2019-06-18 05:06:48', '2019-06-18 05:09:53');
INSERT INTO `ltm_translations` VALUES (1603, 0, 'es', 'email', 'newNotice.subject', 'Nuevo aviso publicado', '2019-06-18 05:06:48', '2019-06-18 05:09:53');
INSERT INTO `ltm_translations` VALUES (1604, 0, 'es', 'email', 'newNotice.text', 'Nuevo aviso ha sido publicado. Inicie sesión para ver el aviso.', '2019-06-18 05:06:48', '2019-06-18 05:09:53');
INSERT INTO `ltm_translations` VALUES (1605, 0, 'es', 'email', 'newProjectMember.subject', 'Nuevo proyecto asignado', '2019-06-18 05:06:48', '2019-06-18 05:09:53');
INSERT INTO `ltm_translations` VALUES (1606, 0, 'es', 'email', 'newProjectMember.text', 'Usted ha sido agregado como miembro del proyecto', '2019-06-18 05:06:48', '2019-06-18 05:09:53');
INSERT INTO `ltm_translations` VALUES (1607, 0, 'es', 'email', 'newTask.subject', 'Nueva tarea asignada a usted', '2019-06-18 05:06:48', '2019-06-18 05:09:53');
INSERT INTO `ltm_translations` VALUES (1608, 0, 'es', 'email', 'newTicket.subject', 'Nuevo boleto de soporte solicitado', '2019-06-18 05:06:49', '2019-06-18 05:09:54');
INSERT INTO `ltm_translations` VALUES (1609, 0, 'es', 'email', 'newTicket.text', 'Se solicita un nuevo ticket de soporte. Inicia sesión para ver el boleto.', '2019-06-18 05:06:49', '2019-06-18 05:09:54');
INSERT INTO `ltm_translations` VALUES (1610, 0, 'es', 'email', 'newUser.subject', 'Bienvenido a', '2019-06-18 05:06:49', '2019-06-18 05:09:54');
INSERT INTO `ltm_translations` VALUES (1611, 0, 'es', 'email', 'newUser.text', 'Su cuenta ha sido creada con éxito.', '2019-06-18 05:06:49', '2019-06-18 05:09:54');
INSERT INTO `ltm_translations` VALUES (1612, 0, 'es', 'email', 'leaves.subject', 'Nueva solicitud de permiso recibida', '2019-06-18 05:06:49', '2019-06-18 05:09:54');
INSERT INTO `ltm_translations` VALUES (1613, 0, 'es', 'email', 'leaves.statusSubject', 'Deja el estado de la aplicación actualizado', '2019-06-18 05:06:49', '2019-06-18 05:09:54');
INSERT INTO `ltm_translations` VALUES (1614, 0, 'es', 'email', 'taskComplete.subject', 'Tarea marcada como completa', '2019-06-18 05:06:49', '2019-06-18 05:09:54');
INSERT INTO `ltm_translations` VALUES (1615, 0, 'es', 'email', 'leave.approve', 'Deje la solicitud aprobada.', '2019-06-18 05:06:49', '2019-06-18 05:09:54');
INSERT INTO `ltm_translations` VALUES (1616, 0, 'es', 'email', 'leave.reject', 'Deje la solicitud rechazada.', '2019-06-18 05:06:49', '2019-06-18 05:09:54');
INSERT INTO `ltm_translations` VALUES (1617, 0, 'es', 'email', 'leave.applied', 'Deja la aplicación aplicada.', '2019-06-18 05:06:49', '2019-06-18 05:09:55');
INSERT INTO `ltm_translations` VALUES (1618, 0, 'es', 'installer_messages', 'title', 'Instalador de Laravel', '2019-06-18 05:06:50', '2019-06-18 05:09:55');
INSERT INTO `ltm_translations` VALUES (1619, 0, 'es', 'installer_messages', 'next', 'Siguiente', '2019-06-18 05:06:50', '2019-06-18 05:09:55');
INSERT INTO `ltm_translations` VALUES (1620, 0, 'es', 'installer_messages', 'finish', 'Instalar', '2019-06-18 05:06:50', '2019-06-18 05:09:55');
INSERT INTO `ltm_translations` VALUES (1621, 0, 'es', 'installer_messages', 'welcome.title', 'Bienvenido al instalador', '2019-06-18 05:06:50', '2019-06-18 05:09:55');
INSERT INTO `ltm_translations` VALUES (1622, 0, 'es', 'installer_messages', 'welcome.message', 'Bienvenido al asistente de configuración', '2019-06-18 05:06:50', '2019-06-18 05:09:55');
INSERT INTO `ltm_translations` VALUES (1623, 0, 'es', 'installer_messages', 'requirements.title', 'Requisitos', '2019-06-18 05:06:50', '2019-06-18 05:09:55');
INSERT INTO `ltm_translations` VALUES (1624, 0, 'es', 'installer_messages', 'permissions.title', 'Permisos', '2019-06-18 05:06:50', '2019-06-18 05:09:55');
INSERT INTO `ltm_translations` VALUES (1625, 0, 'es', 'installer_messages', 'environment.title', 'Configuraciones del entorno', '2019-06-18 05:06:50', '2019-06-18 05:09:55');
INSERT INTO `ltm_translations` VALUES (1626, 0, 'es', 'installer_messages', 'environment.save', 'Guardar archivo .env', '2019-06-18 05:06:50', '2019-06-18 05:09:55');
INSERT INTO `ltm_translations` VALUES (1627, 0, 'es', 'installer_messages', 'environment.success', 'Los cambios en tu archivo .env han sido guardados.', '2019-06-18 05:06:50', '2019-06-18 05:09:55');
INSERT INTO `ltm_translations` VALUES (1628, 0, 'es', 'installer_messages', 'environment.errors', 'No es posible crear el archivo .env, por favor intentalo manualmente.', '2019-06-18 05:06:51', '2019-06-18 05:09:55');
INSERT INTO `ltm_translations` VALUES (1629, 0, 'es', 'installer_messages', 'final.title', 'Finalizado.', '2019-06-18 05:06:51', '2019-06-18 05:09:55');
INSERT INTO `ltm_translations` VALUES (1630, 0, 'es', 'installer_messages', 'final.finished', 'La aplicación ha sido instalada con éxito!', '2019-06-18 05:06:51', '2019-06-18 05:09:56');
INSERT INTO `ltm_translations` VALUES (1631, 0, 'es', 'installer_messages', 'final.exit', 'Haz click aquí para salir.', '2019-06-18 05:06:51', '2019-06-18 05:09:56');
INSERT INTO `ltm_translations` VALUES (1632, 0, 'es', 'messages', 'title', 'Instalador de Laravel', '2019-06-18 05:06:51', '2019-06-18 05:09:56');
INSERT INTO `ltm_translations` VALUES (1633, 0, 'es', 'messages', 'next', 'Siguiente', '2019-06-18 05:06:51', '2019-06-18 05:09:56');
INSERT INTO `ltm_translations` VALUES (1634, 0, 'es', 'messages', 'finish', 'Instalar', '2019-06-18 05:06:51', '2019-06-18 05:09:56');
INSERT INTO `ltm_translations` VALUES (1635, 0, 'es', 'messages', 'welcome.title', 'Bienvenido al instalador', '2019-06-18 05:06:52', '2019-06-18 05:09:56');
INSERT INTO `ltm_translations` VALUES (1636, 0, 'es', 'messages', 'welcome.message', 'Bienvenido al asistente de configuración', '2019-06-18 05:06:52', '2019-06-18 05:09:56');
INSERT INTO `ltm_translations` VALUES (1637, 0, 'es', 'messages', 'requirements.title', 'Requisitos', '2019-06-18 05:06:52', '2019-06-18 05:09:56');
INSERT INTO `ltm_translations` VALUES (1638, 0, 'es', 'messages', 'permissions.title', 'Permisos', '2019-06-18 05:06:52', '2019-06-18 05:09:56');
INSERT INTO `ltm_translations` VALUES (1639, 0, 'es', 'messages', 'environment.title', 'Configuraciones del entorno', '2019-06-18 05:06:52', '2019-06-18 05:09:56');
INSERT INTO `ltm_translations` VALUES (1640, 0, 'es', 'messages', 'environment.save', 'Guardar archivo .env', '2019-06-18 05:06:52', '2019-06-18 05:09:56');
INSERT INTO `ltm_translations` VALUES (1641, 0, 'es', 'messages', 'environment.success', 'Los cambios en tu archivo .env han sido guardados.', '2019-06-18 05:06:53', '2019-06-18 05:09:56');
INSERT INTO `ltm_translations` VALUES (1642, 0, 'es', 'messages', 'environment.errors', 'No es posible crear el archivo .env, por favor intentalo manualmente.', '2019-06-18 05:06:53', '2019-06-18 05:09:57');
INSERT INTO `ltm_translations` VALUES (1643, 0, 'es', 'messages', 'final.title', 'Finalizado.', '2019-06-18 05:06:53', '2019-06-18 05:09:57');
INSERT INTO `ltm_translations` VALUES (1644, 0, 'es', 'messages', 'final.finished', 'La aplicación ha sido instalada con éxito!', '2019-06-18 05:06:53', '2019-06-18 05:09:57');
INSERT INTO `ltm_translations` VALUES (1645, 0, 'es', 'messages', 'final.exit', 'Haz click aquí para salir.', '2019-06-18 05:06:53', '2019-06-18 05:09:57');
INSERT INTO `ltm_translations` VALUES (1646, 0, 'es', 'messages', 'addedAsNewProject', 'Añadido como nuevo proyecto.', '2019-06-18 05:06:53', '2019-06-18 05:09:57');
INSERT INTO `ltm_translations` VALUES (1647, 0, 'es', 'messages', 'addItem', 'Añadir al menos 1 elemento.', '2019-06-18 05:06:53', '2019-06-18 05:09:57');
INSERT INTO `ltm_translations` VALUES (1648, 0, 'es', 'messages', 'adminCannotDelete', 'No se puede eliminar el usuario administrador.', '2019-06-18 05:06:53', '2019-06-18 05:09:57');
INSERT INTO `ltm_translations` VALUES (1649, 0, 'es', 'messages', 'amountNumber', 'La cantidad debe ser un número.', '2019-06-18 05:06:53', '2019-06-18 05:09:57');
INSERT INTO `ltm_translations` VALUES (1650, 0, 'es', 'messages', 'categoryAdded', 'Categoría agregada correctamente.', '2019-06-18 05:06:53', '2019-06-18 05:09:57');
INSERT INTO `ltm_translations` VALUES (1651, 0, 'es', 'messages', 'categoryDeleted', 'Categoría eliminada correctamente.', '2019-06-18 05:06:54', '2019-06-18 05:09:57');
INSERT INTO `ltm_translations` VALUES (1652, 0, 'es', 'messages', 'categoryUpdated', 'Categoría actualizada correctamente.', '2019-06-18 05:06:54', '2019-06-18 05:09:57');
INSERT INTO `ltm_translations` VALUES (1653, 0, 'es', 'messages', 'clientDeleted', 'Cliente eliminado correctamente.', '2019-06-18 05:06:54', '2019-06-18 05:09:57');
INSERT INTO `ltm_translations` VALUES (1654, 0, 'es', 'messages', 'clientUpdated', 'La información del cliente se actualizó correctamente.', '2019-06-18 05:06:54', '2019-06-18 05:09:57');
INSERT INTO `ltm_translations` VALUES (1655, 0, 'es', 'messages', 'clientUploadedAFileToTheProject', '(Cliente) subió un archivo al proyecto.', '2019-06-18 05:06:54', '2019-06-18 05:09:57');
INSERT INTO `ltm_translations` VALUES (1656, 0, 'es', 'messages', 'contactAdded', 'Contacto agregado correctamente.', '2019-06-18 05:06:54', '2019-06-18 05:09:58');
INSERT INTO `ltm_translations` VALUES (1657, 0, 'es', 'messages', 'contactDeleted', 'Contacto eliminado correctamente.', '2019-06-18 05:06:54', '2019-06-18 05:09:58');
INSERT INTO `ltm_translations` VALUES (1658, 0, 'es', 'messages', 'contactUpdated', 'Contacto actualizado correctamente.', '2019-06-18 05:06:55', '2019-06-18 05:09:58');
INSERT INTO `ltm_translations` VALUES (1659, 0, 'es', 'messages', 'currencyAdded', 'Moneda agregada con éxito.', '2019-06-18 05:06:55', '2019-06-18 05:09:58');
INSERT INTO `ltm_translations` VALUES (1660, 0, 'es', 'messages', 'currencyDeleted', 'La moneda se eliminó correctamente.', '2019-06-18 05:06:55', '2019-06-18 05:09:58');
INSERT INTO `ltm_translations` VALUES (1661, 0, 'es', 'messages', 'currencyUpdated', 'Moneda actualizada con éxito.', '2019-06-18 05:06:55', '2019-06-18 05:09:58');
INSERT INTO `ltm_translations` VALUES (1662, 0, 'es', 'messages', 'defaultColorNote', 'Si no va a elegir ningún color azul será por defecto', '2019-06-18 05:06:55', '2019-06-18 05:09:58');
INSERT INTO `ltm_translations` VALUES (1663, 0, 'es', 'messages', 'earningChartNote', 'Las ganancias se mencionan en su moneda base. Puedes cambiarlo aquí.', '2019-06-18 05:06:55', '2019-06-18 05:09:58');
INSERT INTO `ltm_translations` VALUES (1664, 0, 'es', 'messages', 'employeeDeleted', 'Empleado eliminado correctamente.', '2019-06-18 05:06:55', '2019-06-18 05:09:58');
INSERT INTO `ltm_translations` VALUES (1665, 0, 'es', 'messages', 'employeeUpdated', 'Información del empleado actualizada con éxito.', '2019-06-18 05:06:55', '2019-06-18 05:09:58');
INSERT INTO `ltm_translations` VALUES (1666, 0, 'es', 'messages', 'fetchChat', 'Obtener información del chat.', '2019-06-18 05:06:55', '2019-06-18 05:09:58');
INSERT INTO `ltm_translations` VALUES (1667, 0, 'es', 'messages', 'fileDeleted', 'Archivo eliminado correctamente.', '2019-06-18 05:06:56', '2019-06-18 05:09:58');
INSERT INTO `ltm_translations` VALUES (1668, 0, 'es', 'messages', 'fileUploaded', 'El archivo ha subido correctamente.', '2019-06-18 05:06:56', '2019-06-18 05:09:58');
INSERT INTO `ltm_translations` VALUES (1669, 0, 'es', 'messages', 'fileUploadedSuccessfully', 'El archivo ha subido correctamente.', '2019-06-18 05:06:56', '2019-06-18 05:09:58');
INSERT INTO `ltm_translations` VALUES (1670, 0, 'es', 'messages', 'invoiceCreated', 'Factura creada correctamente.', '2019-06-18 05:06:56', '2019-06-18 05:09:58');
INSERT INTO `ltm_translations` VALUES (1671, 0, 'es', 'messages', 'invoiceDeleted', 'La factura se eliminó correctamente.', '2019-06-18 05:06:57', '2019-06-18 05:09:58');
INSERT INTO `ltm_translations` VALUES (1672, 0, 'es', 'messages', 'invoiceUpdated', 'Factura actualizada correctamente.', '2019-06-18 05:06:57', '2019-06-18 05:09:58');
INSERT INTO `ltm_translations` VALUES (1673, 0, 'es', 'messages', 'isAddedAsProjectMember', 'Se agrega como miembro del proyecto.', '2019-06-18 05:06:57', '2019-06-18 05:09:58');
INSERT INTO `ltm_translations` VALUES (1674, 0, 'es', 'messages', 'issueCreated', 'Problema creado correctamente.', '2019-06-18 05:06:57', '2019-06-18 05:09:58');
INSERT INTO `ltm_translations` VALUES (1675, 0, 'es', 'messages', 'issueDeleted', 'Problema eliminado correctamente.', '2019-06-18 05:06:57', '2019-06-18 05:09:59');
INSERT INTO `ltm_translations` VALUES (1676, 0, 'es', 'messages', 'issueStatusChanged', 'El estado del problema ha cambiado correctamente.', '2019-06-18 05:06:57', '2019-06-18 05:09:59');
INSERT INTO `ltm_translations` VALUES (1677, 0, 'es', 'messages', 'issueUpdated', 'Problema actualizado correctamente.', '2019-06-18 05:06:57', '2019-06-18 05:09:59');
INSERT INTO `ltm_translations` VALUES (1678, 0, 'es', 'messages', 'itemBlank', 'El nombre del artículo no puede estar en blanco.', '2019-06-18 05:06:57', '2019-06-18 05:09:59');
INSERT INTO `ltm_translations` VALUES (1679, 0, 'es', 'messages', 'Login As Employee', 'Iniciar sesión como empleado', '2019-06-18 05:06:58', '2019-06-18 05:09:59');
INSERT INTO `ltm_translations` VALUES (1680, 0, 'es', 'messages', 'memberRemovedFromProject', 'Miembro eliminado del proyecto con éxito.', '2019-06-18 05:06:58', '2019-06-18 05:10:00');
INSERT INTO `ltm_translations` VALUES (1681, 0, 'es', 'messages', 'membersAddedSuccessfully', 'Los miembros se agregaron correctamente.', '2019-06-18 05:06:58', '2019-06-18 05:10:00');
INSERT INTO `ltm_translations` VALUES (1682, 0, 'es', 'messages', 'newFileUploadedToTheProject', 'Nuevo archivo cargado en el proyecto.', '2019-06-18 05:06:58', '2019-06-18 05:10:00');
INSERT INTO `ltm_translations` VALUES (1683, 0, 'es', 'messages', 'newMemberAddedToTheProject', 'Nuevo miembro añadido al proyecto.', '2019-06-18 05:06:58', '2019-06-18 05:10:00');
INSERT INTO `ltm_translations` VALUES (1684, 0, 'es', 'messages', 'newTaskAddedToTheProject', 'Nueva tarea agregada al proyecto.', '2019-06-18 05:06:58', '2019-06-18 05:10:00');
INSERT INTO `ltm_translations` VALUES (1685, 0, 'es', 'messages', 'noActiveTimer', 'No hay temporizador activo.', '2019-06-18 05:06:59', '2019-06-18 05:10:00');
INSERT INTO `ltm_translations` VALUES (1686, 0, 'es', 'messages', 'noActivityByThisUser', 'Ninguna actividad por parte del usuario.', '2019-06-18 05:06:59', '2019-06-18 05:10:00');
INSERT INTO `ltm_translations` VALUES (1687, 0, 'es', 'messages', 'noClientAdded', 'Ningún cliente agregado.', '2019-06-18 05:06:59', '2019-06-18 05:10:00');
INSERT INTO `ltm_translations` VALUES (1688, 0, 'es', 'messages', 'noConversation', 'No se ha encontrado ninguna conversación.', '2019-06-18 05:06:59', '2019-06-18 05:10:00');
INSERT INTO `ltm_translations` VALUES (1689, 0, 'es', 'messages', 'noFileUploaded', 'No has subido ningún archivo.', '2019-06-18 05:06:59', '2019-06-18 05:10:01');
INSERT INTO `ltm_translations` VALUES (1690, 0, 'es', 'messages', 'noInvoice', 'No se ha creado ninguna factura.', '2019-06-18 05:06:59', '2019-06-18 05:10:01');
INSERT INTO `ltm_translations` VALUES (1691, 0, 'es', 'messages', 'noIssue', 'No se ha encontrado ningún problema.', '2019-06-18 05:06:59', '2019-06-18 05:10:01');
INSERT INTO `ltm_translations` VALUES (1692, 0, 'es', 'messages', 'noMemberAddedToProject', 'Ningún miembro se ha agregado a este proyecto.', '2019-06-18 05:06:59', '2019-06-18 05:10:01');
INSERT INTO `ltm_translations` VALUES (1693, 0, 'es', 'messages', 'noMessage', 'No se ha encontrado ningún mensaje.', '2019-06-18 05:07:00', '2019-06-18 05:10:01');
INSERT INTO `ltm_translations` VALUES (1694, 0, 'es', 'messages', 'noNotice', 'No se publicó ningún aviso.', '2019-06-18 05:07:00', '2019-06-18 05:10:01');
INSERT INTO `ltm_translations` VALUES (1695, 0, 'es', 'messages', 'noOpenIssues', 'No hay problemas abiertos.', '2019-06-18 05:07:00', '2019-06-18 05:10:01');
INSERT INTO `ltm_translations` VALUES (1696, 0, 'es', 'messages', 'noOpenTasks', 'No hay tareas abiertas.', '2019-06-18 05:07:00', '2019-06-18 05:10:01');
INSERT INTO `ltm_translations` VALUES (1697, 0, 'es', 'messages', 'noProjectAssigned', 'Ningún proyecto asignado a usted.', '2019-06-18 05:07:01', '2019-06-18 05:10:01');
INSERT INTO `ltm_translations` VALUES (1698, 0, 'es', 'messages', 'noProjectCategoryAdded', 'No se ha añadido ninguna categoría de proyecto.', '2019-06-18 05:07:01', '2019-06-18 05:10:01');
INSERT INTO `ltm_translations` VALUES (1699, 0, 'es', 'messages', 'noProjectFound', 'No se encontró ningún proyecto.', '2019-06-18 05:07:01', '2019-06-18 05:10:02');
INSERT INTO `ltm_translations` VALUES (1700, 0, 'es', 'messages', 'noteCreated', 'Nota creada correctamente.', '2019-06-18 05:07:01', '2019-06-18 05:10:02');
INSERT INTO `ltm_translations` VALUES (1701, 0, 'es', 'messages', 'noteDeleted', 'Nota eliminada correctamente.', '2019-06-18 05:07:01', '2019-06-18 05:10:02');
INSERT INTO `ltm_translations` VALUES (1702, 0, 'es', 'messages', 'noteUpdated', 'Nota actualizada correctamente.', '2019-06-18 05:07:01', '2019-06-18 05:10:02');
INSERT INTO `ltm_translations` VALUES (1703, 0, 'es', 'messages', 'noticeAdded', 'Aviso agregado correctamente.', '2019-06-18 05:07:01', '2019-06-18 05:10:02');
INSERT INTO `ltm_translations` VALUES (1704, 0, 'es', 'messages', 'noticeDeleted', 'Aviso eliminado correctamente.', '2019-06-18 05:07:02', '2019-06-18 05:10:02');
INSERT INTO `ltm_translations` VALUES (1705, 0, 'es', 'messages', 'noticeUpdated', 'Aviso actualizado correctamente.', '2019-06-18 05:07:02', '2019-06-18 05:10:02');
INSERT INTO `ltm_translations` VALUES (1706, 0, 'es', 'messages', 'noUser', 'Usuario no encontrado.', '2019-06-18 05:07:02', '2019-06-18 05:10:02');
INSERT INTO `ltm_translations` VALUES (1707, 0, 'es', 'messages', 'profileUpdated', 'Perfil actualizado con éxito.', '2019-06-18 05:07:02', '2019-06-18 05:10:03');
INSERT INTO `ltm_translations` VALUES (1708, 0, 'es', 'messages', 'projectDeleted', 'Proyecto eliminado correctamente.', '2019-06-18 05:07:02', '2019-06-18 05:10:03');
INSERT INTO `ltm_translations` VALUES (1709, 0, 'es', 'messages', 'projectUpdated', 'Proyecto actualizado correctamente.', '2019-06-18 05:07:02', '2019-06-18 05:10:03');
INSERT INTO `ltm_translations` VALUES (1710, 0, 'es', 'messages', 'quantityNumber', 'La cantidad debe ser un número', '2019-06-18 05:07:02', '2019-06-18 05:10:03');
INSERT INTO `ltm_translations` VALUES (1711, 0, 'es', 'messages', 'reportGenerated', 'Informe generado correctamente.', '2019-06-18 05:07:02', '2019-06-18 05:10:03');
INSERT INTO `ltm_translations` VALUES (1712, 0, 'es', 'messages', 'settingsUpdated', 'Configuración actualizada correctamente.', '2019-06-18 05:07:02', '2019-06-18 05:10:03');
INSERT INTO `ltm_translations` VALUES (1713, 0, 'es', 'messages', 'taskCreatedSuccessfully', 'Tarea creada correctamente.', '2019-06-18 05:07:03', '2019-06-18 05:10:03');
INSERT INTO `ltm_translations` VALUES (1714, 0, 'es', 'messages', 'taskDeletedSuccessfully', 'Se borró correctamente la tarea.', '2019-06-18 05:07:03', '2019-06-18 05:10:03');
INSERT INTO `ltm_translations` VALUES (1715, 0, 'es', 'messages', 'taskUpdated', 'Marcó la tarea como', '2019-06-18 05:07:03', '2019-06-18 05:10:04');
INSERT INTO `ltm_translations` VALUES (1716, 0, 'es', 'messages', 'taskUpdatedSuccessfully', 'Tarea actualizada correctamente.', '2019-06-18 05:07:03', '2019-06-18 05:10:04');
INSERT INTO `ltm_translations` VALUES (1717, 0, 'es', 'messages', 'timeLogAdded', 'Tiempo registrado con éxito.', '2019-06-18 05:07:03', '2019-06-18 05:10:04');
INSERT INTO `ltm_translations` VALUES (1718, 0, 'es', 'messages', 'timeLogDeleted', 'El registro de tiempo se eliminó correctamente.', '2019-06-18 05:07:03', '2019-06-18 05:10:04');
INSERT INTO `ltm_translations` VALUES (1719, 0, 'es', 'messages', 'timeLogUpdated', 'Registro de tiempo actualizado correctamente.', '2019-06-18 05:07:03', '2019-06-18 05:10:04');
INSERT INTO `ltm_translations` VALUES (1720, 0, 'es', 'messages', 'timerStartedBy', 'Temporizador iniciado por', '2019-06-18 05:07:04', '2019-06-18 05:10:04');
INSERT INTO `ltm_translations` VALUES (1721, 0, 'es', 'messages', 'timerStartedProject', 'Inició el temporizador para el proyecto', '2019-06-18 05:07:04', '2019-06-18 05:10:04');
INSERT INTO `ltm_translations` VALUES (1722, 0, 'es', 'messages', 'timerStartedSuccessfully', 'El temporizador comenzó correctamente.', '2019-06-18 05:07:04', '2019-06-18 05:10:05');
INSERT INTO `ltm_translations` VALUES (1723, 0, 'es', 'messages', 'timerStoppedBy', 'El temporizador se detuvo', '2019-06-18 05:07:04', '2019-06-18 05:10:05');
INSERT INTO `ltm_translations` VALUES (1724, 0, 'es', 'messages', 'timerStoppedSuccessfully', 'El temporizador se detuvo con éxito.', '2019-06-18 05:07:05', '2019-06-18 05:10:05');
INSERT INTO `ltm_translations` VALUES (1725, 0, 'es', 'messages', 'unAuthorisedUser', 'Usted no es usuario autorizado.', '2019-06-18 05:07:05', '2019-06-18 05:10:05');
INSERT INTO `ltm_translations` VALUES (1726, 0, 'es', 'messages', 'unitPriceNumber', 'El precio unitario debe ser un número', '2019-06-18 05:07:05', '2019-06-18 05:10:05');
INSERT INTO `ltm_translations` VALUES (1727, 0, 'es', 'messages', 'updatedProfile', 'Perfil actualizado.', '2019-06-18 05:07:05', '2019-06-18 05:10:05');
INSERT INTO `ltm_translations` VALUES (1728, 0, 'es', 'messages', 'noProjectCategory', 'No se encontró ninguna categoría de proyecto.', '2019-06-18 05:07:05', '2019-06-18 05:10:05');
INSERT INTO `ltm_translations` VALUES (1729, 0, 'es', 'messages', 'roleAssigned', 'Funciones asignadas correctamente.', '2019-06-18 05:07:05', '2019-06-18 05:10:05');
INSERT INTO `ltm_translations` VALUES (1730, 0, 'es', 'messages', 'roleCannotChange', 'La función de este usuario no se puede cambiar.', '2019-06-18 05:07:05', '2019-06-18 05:10:06');
INSERT INTO `ltm_translations` VALUES (1731, 0, 'es', 'messages', 'estimateCreated', 'La estimación se creó correctamente.', '2019-06-18 05:07:05', '2019-06-18 05:10:06');
INSERT INTO `ltm_translations` VALUES (1732, 0, 'es', 'messages', 'estimateUpdated', 'La estimación se actualizó correctamente.', '2019-06-18 05:07:05', '2019-06-18 05:10:06');
INSERT INTO `ltm_translations` VALUES (1733, 0, 'es', 'messages', 'estimateDeleted', 'La estimación se eliminó correctamente.', '2019-06-18 05:07:06', '2019-06-18 05:10:06');
INSERT INTO `ltm_translations` VALUES (1734, 0, 'es', 'messages', 'paymentSuccess', 'Pago agregado con éxito.', '2019-06-18 05:07:06', '2019-06-18 05:10:06');
INSERT INTO `ltm_translations` VALUES (1735, 0, 'es', 'messages', 'paymentDeleted', 'Pago eliminado correctamente.', '2019-06-18 05:07:06', '2019-06-18 05:10:06');
INSERT INTO `ltm_translations` VALUES (1736, 0, 'es', 'messages', 'expenseSuccess', 'Gastos agregados con éxito.', '2019-06-18 05:07:06', '2019-06-18 05:10:06');
INSERT INTO `ltm_translations` VALUES (1737, 0, 'es', 'messages', 'expenseUpdateSuccess', 'Gastos actualizados correctamente.', '2019-06-18 05:07:06', '2019-06-18 05:10:06');
INSERT INTO `ltm_translations` VALUES (1738, 0, 'es', 'messages', 'expenseDeleted', 'Gastos eliminados correctamente.', '2019-06-18 05:07:06', '2019-06-18 05:10:06');
INSERT INTO `ltm_translations` VALUES (1739, 0, 'es', 'messages', 'exchangeRateNote', 'La tasa de cambio se calcula a partir de su moneda predeterminada. Cambiar la moneda predeterminada en la configuración de la empresa.', '2019-06-18 05:07:06', '2019-06-18 05:10:06');
INSERT INTO `ltm_translations` VALUES (1740, 0, 'es', 'messages', 'exchangeRateUpdateSuccess', 'Tipo de cambio actualizado con éxito.', '2019-06-18 05:07:06', '2019-06-18 05:10:06');
INSERT INTO `ltm_translations` VALUES (1741, 0, 'es', 'messages', 'invalidRequest', 'Solicitud no válida', '2019-06-18 05:07:06', '2019-06-18 05:10:07');
INSERT INTO `ltm_translations` VALUES (1742, 0, 'es', 'messages', 'employeeAdded', 'Empleado agregado correctamente.', '2019-06-18 05:07:06', '2019-06-18 05:10:07');
INSERT INTO `ltm_translations` VALUES (1743, 0, 'es', 'messages', 'databaseUpdated', 'Actualización de la base de datos correctamente.', '2019-06-18 05:07:07', '2019-06-18 05:10:07');
INSERT INTO `ltm_translations` VALUES (1744, 0, 'es', 'messages', 'noAgentAdded', 'Ningún agente agregado.', '2019-06-18 05:07:07', '2019-06-18 05:10:07');
INSERT INTO `ltm_translations` VALUES (1745, 0, 'es', 'messages', 'noGroupAdded', 'Ningún grupo agregado.', '2019-06-18 05:07:07', '2019-06-18 05:10:07');
INSERT INTO `ltm_translations` VALUES (1746, 0, 'es', 'messages', 'agentAddedSuccessfully', 'Agente agregado correctamente.', '2019-06-18 05:07:07', '2019-06-18 05:10:08');
INSERT INTO `ltm_translations` VALUES (1747, 0, 'es', 'messages', 'statusUpdatedSuccessfully', 'Estado actualizado correctamente.', '2019-06-18 05:07:08', '2019-06-18 05:10:08');
INSERT INTO `ltm_translations` VALUES (1748, 0, 'es', 'messages', 'groupUpdatedSuccessfully', 'Grupo actualizado correctamente.', '2019-06-18 05:07:08', '2019-06-18 05:10:08');
INSERT INTO `ltm_translations` VALUES (1749, 0, 'es', 'messages', 'agentRemoveSuccess', 'Agente eliminado correctamente.', '2019-06-18 05:07:08', '2019-06-18 05:10:08');
INSERT INTO `ltm_translations` VALUES (1750, 0, 'es', 'messages', 'groupAddedSuccess', 'Grupo agregado correctamente.', '2019-06-18 05:07:08', '2019-06-18 05:10:08');
INSERT INTO `ltm_translations` VALUES (1751, 0, 'es', 'messages', 'groupDeleteSuccess', 'Grupo eliminado correctamente.', '2019-06-18 05:07:08', '2019-06-18 05:10:08');
INSERT INTO `ltm_translations` VALUES (1752, 0, 'es', 'messages', 'noTicketTypeAdded', 'No se ha añadido ningún tipo de boleto.', '2019-06-18 05:07:08', '2019-06-18 05:10:08');
INSERT INTO `ltm_translations` VALUES (1753, 0, 'es', 'messages', 'ticketTypeAddSuccess', 'Tipo de ticket agregado correctamente.', '2019-06-18 05:07:08', '2019-06-18 05:10:09');
INSERT INTO `ltm_translations` VALUES (1754, 0, 'es', 'messages', 'ticketTypeUpdateSuccess', 'Tipo de ticket actualizado correctamente.', '2019-06-18 05:07:08', '2019-06-18 05:10:09');
INSERT INTO `ltm_translations` VALUES (1755, 0, 'es', 'messages', 'ticketTypeDeleteSuccess', 'Tipo de ticket eliminado correctamente.', '2019-06-18 05:07:09', '2019-06-18 05:10:09');
INSERT INTO `ltm_translations` VALUES (1756, 0, 'es', 'messages', 'ticketChannelAddSuccess', 'Canal de entradas añadido correctamente.', '2019-06-18 05:07:09', '2019-06-18 05:10:09');
INSERT INTO `ltm_translations` VALUES (1757, 0, 'es', 'messages', 'ticketChannelUpdateSuccess', 'El canal de tickets se actualizó correctamente.', '2019-06-18 05:07:09', '2019-06-18 05:10:09');
INSERT INTO `ltm_translations` VALUES (1758, 0, 'es', 'messages', 'noTemplateFound', 'No se ha encontrado ninguna plantilla.', '2019-06-18 05:07:09', '2019-06-18 05:10:09');
INSERT INTO `ltm_translations` VALUES (1759, 0, 'es', 'messages', 'templateAddSuccess', 'Plantilla agregada correctamente.', '2019-06-18 05:07:09', '2019-06-18 05:10:09');
INSERT INTO `ltm_translations` VALUES (1760, 0, 'es', 'messages', 'templateUpdateSuccess', 'Plantilla actualización éxito.', '2019-06-18 05:07:10', '2019-06-18 05:10:10');
INSERT INTO `ltm_translations` VALUES (1761, 0, 'es', 'messages', 'templateDeleteSuccess', 'Plantilla eliminada correctamente.', '2019-06-18 05:07:10', '2019-06-18 05:10:10');
INSERT INTO `ltm_translations` VALUES (1762, 0, 'es', 'messages', 'ticketAddSuccess', 'Boleto creado correctamente.', '2019-06-18 05:07:10', '2019-06-18 05:10:10');
INSERT INTO `ltm_translations` VALUES (1763, 0, 'es', 'messages', 'ticketChannelDeleteSuccess', 'Canal de tickets eliminado correctamente.', '2019-06-18 05:07:10', '2019-06-18 05:10:10');
INSERT INTO `ltm_translations` VALUES (1764, 0, 'es', 'messages', 'ticketReplySuccess', 'Respuesta enviada correctamente.', '2019-06-18 05:07:10', '2019-06-18 05:10:10');
INSERT INTO `ltm_translations` VALUES (1765, 0, 'es', 'messages', 'ticketDeleteSuccess', 'Boleto eliminado correctamente.', '2019-06-18 05:07:10', '2019-06-18 05:10:11');
INSERT INTO `ltm_translations` VALUES (1766, 0, 'es', 'messages', 'noFeedbackReceived', 'No hay comentarios recibidos.', '2019-06-18 05:07:10', '2019-06-18 05:10:11');
INSERT INTO `ltm_translations` VALUES (1767, 0, 'es', 'messages', 'noClientAddedToProject', 'Ningún cliente asignado al proyecto.', '2019-06-18 05:07:10', '2019-06-18 05:10:11');
INSERT INTO `ltm_translations` VALUES (1768, 0, 'es', 'messages', 'attendanceSaveSuccess', 'Asistencia salvada con éxito.', '2019-06-18 05:07:10', '2019-06-18 05:10:11');
INSERT INTO `ltm_translations` VALUES (1769, 0, 'es', 'messages', 'boardColumnSaved', 'La columna de la placa se guardó correctamente.', '2019-06-18 05:07:11', '2019-06-18 05:10:11');
INSERT INTO `ltm_translations` VALUES (1770, 0, 'es', 'messages', 'customFieldCreateSuccess', 'Campo personalizado creado con éxito.', '2019-06-18 05:07:11', '2019-06-18 05:10:11');
INSERT INTO `ltm_translations` VALUES (1771, 0, 'es', 'messages', 'deleteSuccess', 'Borrado exitosamente.', '2019-06-18 05:07:11', '2019-06-18 05:10:11');
INSERT INTO `ltm_translations` VALUES (1772, 0, 'es', 'messages', 'eventCreateSuccess', 'Evento creado con éxito.', '2019-06-18 05:07:11', '2019-06-18 05:10:11');
INSERT INTO `ltm_translations` VALUES (1773, 0, 'es', 'messages', 'eventDeleteSuccess', 'Evento eliminado con éxito.', '2019-06-18 05:07:11', '2019-06-18 05:10:11');
INSERT INTO `ltm_translations` VALUES (1774, 0, 'es', 'messages', 'permissionUpdated', 'Permiso actualizado con éxito.', '2019-06-18 05:07:11', '2019-06-18 05:10:11');
INSERT INTO `ltm_translations` VALUES (1775, 0, 'es', 'messages', 'noRoleMemberFound', 'Ningún miembro está asignado a este rol.', '2019-06-18 05:07:11', '2019-06-18 05:10:11');
INSERT INTO `ltm_translations` VALUES (1776, 0, 'es', 'messages', 'roleCreated', 'Rol creado con éxito', '2019-06-18 05:07:11', '2019-06-18 05:10:11');
INSERT INTO `ltm_translations` VALUES (1777, 0, 'es', 'messages', 'noRoleFound', 'Ningún rol encontrado.', '2019-06-18 05:07:11', '2019-06-18 05:10:11');
INSERT INTO `ltm_translations` VALUES (1778, 0, 'es', 'messages', 'noTicketFound', 'No se encontró boleto.', '2019-06-18 05:07:11', '2019-06-18 05:10:12');
INSERT INTO `ltm_translations` VALUES (1779, 0, 'es', 'messages', 'noLeaveTypeAdded', 'No se agregó ningún tipo de permiso.', '2019-06-18 05:07:12', '2019-06-18 05:10:12');
INSERT INTO `ltm_translations` VALUES (1780, 0, 'es', 'messages', 'leaveTypeAdded', 'Deja el tipo guardado.', '2019-06-18 05:07:12', '2019-06-18 05:10:12');
INSERT INTO `ltm_translations` VALUES (1781, 0, 'es', 'messages', 'leaveTypeDeleted', 'Deja el tipo eliminado.', '2019-06-18 05:07:12', '2019-06-18 05:10:12');
INSERT INTO `ltm_translations` VALUES (1782, 0, 'es', 'messages', 'selectMultipleDates', 'Puede seleccionar múltiples fechas.', '2019-06-18 05:07:12', '2019-06-18 05:10:12');
INSERT INTO `ltm_translations` VALUES (1783, 0, 'es', 'messages', 'leaveAssignSuccess', 'Dejar asignado con éxito.', '2019-06-18 05:07:12', '2019-06-18 05:10:12');
INSERT INTO `ltm_translations` VALUES (1784, 0, 'es', 'messages', 'leaveDeleteSuccess', 'Deje eliminado con éxito.', '2019-06-18 05:07:12', '2019-06-18 05:10:13');
INSERT INTO `ltm_translations` VALUES (1785, 0, 'es', 'messages', 'leaveStatusUpdate', 'Deja el estado actualizado con éxito.', '2019-06-18 05:07:12', '2019-06-18 05:10:13');
INSERT INTO `ltm_translations` VALUES (1786, 0, 'es', 'messages', 'noPendingLeaves', 'No quedan hojas pendientes.', '2019-06-18 05:07:12', '2019-06-18 05:10:13');
INSERT INTO `ltm_translations` VALUES (1787, 0, 'es', 'messages', 'updateAlert', 'No haga clic en el botón actualizar ahora si la aplicación está personalizada. Sus cambios se perderán.', '2019-06-18 05:07:12', '2019-06-18 05:10:13');
INSERT INTO `ltm_translations` VALUES (1788, 0, 'es', 'messages', 'updateBackupNotice', 'Haga una copia de seguridad de los archivos y la base de datos antes de actualizar.', '2019-06-18 05:07:13', '2019-06-18 05:10:13');
INSERT INTO `ltm_translations` VALUES (1789, 0, 'es', 'messages', 'noRecordFound', 'Ningún record fue encontrado.', '2019-06-18 05:07:13', '2019-06-18 05:10:13');
INSERT INTO `ltm_translations` VALUES (1790, 0, 'es', 'messages', 'atleastOneValidation', 'Elija al menos 1', '2019-06-18 05:07:13', '2019-06-18 05:10:13');
INSERT INTO `ltm_translations` VALUES (1791, 0, 'es', 'messages', 'notificationRead', 'Notificación marcada como leída', '2019-06-18 05:07:13', '2019-06-18 05:10:13');
INSERT INTO `ltm_translations` VALUES (1792, 0, 'es', 'messages', 'chooseProject', 'Elige un proyecto.', '2019-06-18 05:07:13', '2019-06-18 05:10:13');
INSERT INTO `ltm_translations` VALUES (1793, 0, 'es', 'messages', 'fieldBlank', 'El campo no puede estar en blanco.', '2019-06-18 05:07:13', '2019-06-18 05:10:13');
INSERT INTO `ltm_translations` VALUES (1794, 0, 'es', 'messages', 'defaultRoleCantDelete', 'La función predeterminada no se puede eliminar.', '2019-06-18 05:07:13', '2019-06-18 05:10:13');
INSERT INTO `ltm_translations` VALUES (1795, 0, 'es', 'messages', 'taxAdded', 'impuesto agregado exitosamente', '2019-06-18 05:07:13', '2019-06-18 05:10:14');
INSERT INTO `ltm_translations` VALUES (1796, 0, 'es', 'messages', 'productAdded', 'Producto agregado con éxito.', '2019-06-18 05:07:14', '2019-06-18 05:10:14');
INSERT INTO `ltm_translations` VALUES (1797, 0, 'es', 'messages', 'productUpdated', 'Producto actualizado con éxito.', '2019-06-18 05:07:14', '2019-06-18 05:10:14');
INSERT INTO `ltm_translations` VALUES (1798, 0, 'es', 'messages', 'productDeleted', 'Producto eliminado con éxito.', '2019-06-18 05:07:14', '2019-06-18 05:10:14');
INSERT INTO `ltm_translations` VALUES (1799, 0, 'es', 'modules', 'accountSettings.changeLanguage', 'Cambiar idioma', '2019-06-18 05:07:14', '2019-06-18 05:10:14');
INSERT INTO `ltm_translations` VALUES (1800, 0, 'es', 'modules', 'accountSettings.companyAddress', 'Dirección de la empresa', '2019-06-18 05:07:14', '2019-06-18 05:10:14');
INSERT INTO `ltm_translations` VALUES (1801, 0, 'es', 'modules', 'accountSettings.companyEmail', 'Correo electrónico de la empresa', '2019-06-18 05:07:14', '2019-06-18 05:10:14');
INSERT INTO `ltm_translations` VALUES (1802, 0, 'es', 'modules', 'accountSettings.companyLogo', 'Logo de la compañía', '2019-06-18 05:07:14', '2019-06-18 05:10:14');
INSERT INTO `ltm_translations` VALUES (1803, 0, 'es', 'modules', 'accountSettings.companyName', 'nombre de empresa', '2019-06-18 05:07:14', '2019-06-18 05:10:14');
INSERT INTO `ltm_translations` VALUES (1804, 0, 'es', 'modules', 'accountSettings.companyPhone', 'Teléfono de la empresa', '2019-06-18 05:07:14', '2019-06-18 05:10:14');
INSERT INTO `ltm_translations` VALUES (1805, 0, 'es', 'modules', 'accountSettings.companyWebsite', 'Página Web de la compañía', '2019-06-18 05:07:14', '2019-06-18 05:10:15');
INSERT INTO `ltm_translations` VALUES (1806, 0, 'es', 'modules', 'accountSettings.defaultCurrency', 'Moneda predeterminada', '2019-06-18 05:07:15', '2019-06-18 05:10:15');
INSERT INTO `ltm_translations` VALUES (1807, 0, 'es', 'modules', 'accountSettings.defaultTimezone', 'Predeterminado Timezone', '2019-06-18 05:07:15', '2019-06-18 05:10:15');
INSERT INTO `ltm_translations` VALUES (1808, 0, 'es', 'modules', 'accountSettings.updateTitle', 'Actualizar configuración de la organización', '2019-06-18 05:07:15', '2019-06-18 05:10:15');
INSERT INTO `ltm_translations` VALUES (1809, 0, 'es', 'modules', 'accountSettings.uploadLogo', 'Sube tu logo', '2019-06-18 05:07:15', '2019-06-18 05:10:15');
INSERT INTO `ltm_translations` VALUES (1810, 0, 'es', 'modules', 'accountSettings.getLocation', 'Establecer la ubicación actual', '2019-06-18 05:07:15', '2019-06-18 05:10:15');
INSERT INTO `ltm_translations` VALUES (1811, 0, 'es', 'modules', 'client.addNewClient', 'Agregar nuevo cliente', '2019-06-18 05:07:15', '2019-06-18 05:10:15');
INSERT INTO `ltm_translations` VALUES (1812, 0, 'es', 'modules', 'client.address', 'Dirección', '2019-06-18 05:07:16', '2019-06-18 05:10:15');
INSERT INTO `ltm_translations` VALUES (1813, 0, 'es', 'modules', 'client.clientDetails', 'Detalles del cliente', '2019-06-18 05:07:16', '2019-06-18 05:10:15');
INSERT INTO `ltm_translations` VALUES (1814, 0, 'es', 'modules', 'client.clientEmail', 'Correo electrónico del cliente', '2019-06-18 05:07:16', '2019-06-18 05:10:15');
INSERT INTO `ltm_translations` VALUES (1815, 0, 'es', 'modules', 'client.clientName', 'nombre del cliente', '2019-06-18 05:07:16', '2019-06-18 05:10:15');
INSERT INTO `ltm_translations` VALUES (1816, 0, 'es', 'modules', 'client.companyDetails', 'Detalles de la compañía', '2019-06-18 05:07:16', '2019-06-18 05:10:16');
INSERT INTO `ltm_translations` VALUES (1817, 0, 'es', 'modules', 'client.companyName', 'nombre de empresa', '2019-06-18 05:07:16', '2019-06-18 05:10:16');
INSERT INTO `ltm_translations` VALUES (1818, 0, 'es', 'modules', 'client.createTitle', 'Agregar información del cliente', '2019-06-18 05:07:16', '2019-06-18 05:10:16');
INSERT INTO `ltm_translations` VALUES (1819, 0, 'es', 'modules', 'client.deadline', 'Fecha tope', '2019-06-18 05:07:16', '2019-06-18 05:10:16');
INSERT INTO `ltm_translations` VALUES (1820, 0, 'es', 'modules', 'client.emailNote', 'El cliente iniciará sesión con este correo electrónico.', '2019-06-18 05:07:16', '2019-06-18 05:10:17');
INSERT INTO `ltm_translations` VALUES (1821, 0, 'es', 'modules', 'client.mobile', 'Móvil', '2019-06-18 05:07:17', '2019-06-18 05:10:17');
INSERT INTO `ltm_translations` VALUES (1822, 0, 'es', 'modules', 'client.password', 'Contraseña', '2019-06-18 05:07:17', '2019-06-18 05:10:17');
INSERT INTO `ltm_translations` VALUES (1823, 0, 'es', 'modules', 'client.passwordNote', 'El cliente iniciará sesión con esta contraseña.', '2019-06-18 05:07:17', '2019-06-18 05:10:17');
INSERT INTO `ltm_translations` VALUES (1824, 0, 'es', 'modules', 'client.passwordUpdateNote', 'El cliente iniciará sesión con esta contraseña. (Deje en blanco para mantener la contraseña actual)', '2019-06-18 05:07:17', '2019-06-18 05:10:17');
INSERT INTO `ltm_translations` VALUES (1825, 0, 'es', 'modules', 'client.projectName', 'Nombre del proyecto', '2019-06-18 05:07:17', '2019-06-18 05:10:17');
INSERT INTO `ltm_translations` VALUES (1826, 0, 'es', 'modules', 'client.startedOn', 'Comenzó en', '2019-06-18 05:07:17', '2019-06-18 05:10:17');
INSERT INTO `ltm_translations` VALUES (1827, 0, 'es', 'modules', 'client.updateTitle', 'Actualizar información del cliente', '2019-06-18 05:07:17', '2019-06-18 05:10:17');
INSERT INTO `ltm_translations` VALUES (1828, 0, 'es', 'modules', 'client.viewDetails', 'Ver detalles', '2019-06-18 05:07:18', '2019-06-18 05:10:17');
INSERT INTO `ltm_translations` VALUES (1829, 0, 'es', 'modules', 'client.website', 'Sitio web', '2019-06-18 05:07:18', '2019-06-18 05:10:18');
INSERT INTO `ltm_translations` VALUES (1830, 0, 'es', 'modules', 'contacts.addContact', 'Agregar contacto', '2019-06-18 05:07:18', '2019-06-18 05:10:18');
INSERT INTO `ltm_translations` VALUES (1831, 0, 'es', 'modules', 'contacts.contactName', 'Nombre de contacto', '2019-06-18 05:07:18', '2019-06-18 05:10:18');
INSERT INTO `ltm_translations` VALUES (1832, 0, 'es', 'modules', 'currencySettings.addNewCurrency', 'Añadir nueva moneda', '2019-06-18 05:07:18', '2019-06-18 05:10:18');
INSERT INTO `ltm_translations` VALUES (1833, 0, 'es', 'modules', 'currencySettings.currencies', 'Monedas', '2019-06-18 05:07:18', '2019-06-18 05:10:18');
INSERT INTO `ltm_translations` VALUES (1834, 0, 'es', 'modules', 'currencySettings.currencyCode', 'Código de moneda', '2019-06-18 05:07:18', '2019-06-18 05:10:18');
INSERT INTO `ltm_translations` VALUES (1835, 0, 'es', 'modules', 'currencySettings.currencyName', 'Nombre de moneda', '2019-06-18 05:07:19', '2019-06-18 05:10:18');
INSERT INTO `ltm_translations` VALUES (1836, 0, 'es', 'modules', 'currencySettings.currencySymbol', 'Símbolo de moneda', '2019-06-18 05:07:19', '2019-06-18 05:10:19');
INSERT INTO `ltm_translations` VALUES (1837, 0, 'es', 'modules', 'currencySettings.updateTitle', 'Actualizar moneda', '2019-06-18 05:07:19', '2019-06-18 05:10:19');
INSERT INTO `ltm_translations` VALUES (1838, 0, 'es', 'modules', 'currencySettings.exchangeRate', 'Tipo de cambio', '2019-06-18 05:07:19', '2019-06-18 05:10:19');
INSERT INTO `ltm_translations` VALUES (1839, 0, 'es', 'modules', 'currencySettings.cantDeleteDefault', 'No se puede eliminar la moneda predeterminada.', '2019-06-18 05:07:19', '2019-06-18 05:10:19');
INSERT INTO `ltm_translations` VALUES (1840, 0, 'es', 'modules', 'currencySettings.isCryptoCurrency', 'Es Cryptocurrency', '2019-06-18 05:07:19', '2019-06-18 05:10:19');
INSERT INTO `ltm_translations` VALUES (1841, 0, 'es', 'modules', 'currencySettings.usdPrice', 'Precio de usd', '2019-06-18 05:07:20', '2019-06-18 05:10:19');
INSERT INTO `ltm_translations` VALUES (1842, 0, 'es', 'modules', 'currencySettings.usdPriceInfo', 'Requerido para calcular ganancias.', '2019-06-18 05:07:20', '2019-06-18 05:10:19');
INSERT INTO `ltm_translations` VALUES (1843, 0, 'es', 'modules', 'dashboard.dueDate', 'Fecha de vencimiento', '2019-06-18 05:07:20', '2019-06-18 05:10:19');
INSERT INTO `ltm_translations` VALUES (1844, 0, 'es', 'modules', 'dashboard.overdueTasks', 'Tareas vencidas', '2019-06-18 05:07:20', '2019-06-18 05:10:19');
INSERT INTO `ltm_translations` VALUES (1845, 0, 'es', 'modules', 'dashboard.pendingClientIssues', 'Asuntos pendientes', '2019-06-18 05:07:20', '2019-06-18 05:10:19');
INSERT INTO `ltm_translations` VALUES (1846, 0, 'es', 'modules', 'dashboard.projectActivityTimeline', 'Línea de tiempo de la actividad del proyecto', '2019-06-18 05:07:20', '2019-06-18 05:10:20');
INSERT INTO `ltm_translations` VALUES (1847, 0, 'es', 'modules', 'dashboard.recentEarnings', 'Ganancias Recientes', '2019-06-18 05:07:20', '2019-06-18 05:10:20');
INSERT INTO `ltm_translations` VALUES (1848, 0, 'es', 'modules', 'dashboard.totalClients', 'Total Clientes', '2019-06-18 05:07:20', '2019-06-18 05:10:20');
INSERT INTO `ltm_translations` VALUES (1849, 0, 'es', 'modules', 'dashboard.totalCompletedTasks', 'Total de tareas completadas', '2019-06-18 05:07:21', '2019-06-18 05:10:20');
INSERT INTO `ltm_translations` VALUES (1850, 0, 'es', 'modules', 'dashboard.totalEmployees', 'Empleados Totales', '2019-06-18 05:07:21', '2019-06-18 05:10:20');
INSERT INTO `ltm_translations` VALUES (1851, 0, 'es', 'modules', 'dashboard.totalHoursLogged', 'Total de horas registradas', '2019-06-18 05:07:21', '2019-06-18 05:10:20');
INSERT INTO `ltm_translations` VALUES (1852, 0, 'es', 'modules', 'dashboard.totalOutstandingAmount', 'Monto total pendiente', '2019-06-18 05:07:21', '2019-06-18 05:10:20');
INSERT INTO `ltm_translations` VALUES (1853, 0, 'es', 'modules', 'dashboard.totalPaidAmount', 'Importe total pagado', '2019-06-18 05:07:21', '2019-06-18 05:10:20');
INSERT INTO `ltm_translations` VALUES (1854, 0, 'es', 'modules', 'dashboard.totalPaidInvoices', 'Total de facturas pagadas', '2019-06-18 05:07:21', '2019-06-18 05:10:20');
INSERT INTO `ltm_translations` VALUES (1855, 0, 'es', 'modules', 'dashboard.totalPendingIssues', 'Total de asuntos pendientes', '2019-06-18 05:07:21', '2019-06-18 05:10:21');
INSERT INTO `ltm_translations` VALUES (1856, 0, 'es', 'modules', 'dashboard.totalPendingTasks', 'Total de tareas pendientes', '2019-06-18 05:07:21', '2019-06-18 05:10:21');
INSERT INTO `ltm_translations` VALUES (1857, 0, 'es', 'modules', 'dashboard.totalProjects', 'Total Proyectos', '2019-06-18 05:07:21', '2019-06-18 05:10:21');
INSERT INTO `ltm_translations` VALUES (1858, 0, 'es', 'modules', 'dashboard.userActivityTimeline', 'Línea de tiempo de la actividad del usuario', '2019-06-18 05:07:21', '2019-06-18 05:10:21');
INSERT INTO `ltm_translations` VALUES (1859, 0, 'es', 'modules', 'dashboard.weatherSetLocation', 'Establecer ubicación actual para ver el tiempo', '2019-06-18 05:07:21', '2019-06-18 05:10:21');
INSERT INTO `ltm_translations` VALUES (1860, 0, 'es', 'modules', 'dashboard.totalTodayAttendance', 'Asistencia de hoy', '2019-06-18 05:07:22', '2019-06-18 05:10:21');
INSERT INTO `ltm_translations` VALUES (1861, 0, 'es', 'modules', 'dashboard.newTickets', 'Nuevos boletos', '2019-06-18 05:07:22', '2019-06-18 05:10:21');
INSERT INTO `ltm_translations` VALUES (1862, 0, 'es', 'modules', 'emailSettings.configTitle', 'Configuración de correo', '2019-06-18 05:07:22', '2019-06-18 05:10:21');
INSERT INTO `ltm_translations` VALUES (1863, 0, 'es', 'modules', 'emailSettings.mailDriver', 'Conductor de correo', '2019-06-18 05:07:22', '2019-06-18 05:10:21');
INSERT INTO `ltm_translations` VALUES (1864, 0, 'es', 'modules', 'emailSettings.mailEncryption', 'Cifrado de correo', '2019-06-18 05:07:22', '2019-06-18 05:10:21');
INSERT INTO `ltm_translations` VALUES (1865, 0, 'es', 'modules', 'emailSettings.mailFrom', 'Correo del Nombre', '2019-06-18 05:07:22', '2019-06-18 05:10:22');
INSERT INTO `ltm_translations` VALUES (1866, 0, 'es', 'modules', 'emailSettings.mailHost', 'Anfitrión del correo', '2019-06-18 05:07:22', '2019-06-18 05:10:22');
INSERT INTO `ltm_translations` VALUES (1867, 0, 'es', 'modules', 'emailSettings.mailPassword', 'Contraseña del correo', '2019-06-18 05:07:22', '2019-06-18 05:10:22');
INSERT INTO `ltm_translations` VALUES (1868, 0, 'es', 'modules', 'emailSettings.mailPort', 'Puerto de correo', '2019-06-18 05:07:22', '2019-06-18 05:10:22');
INSERT INTO `ltm_translations` VALUES (1869, 0, 'es', 'modules', 'emailSettings.mailUsername', 'Correo electrónico', '2019-06-18 05:07:23', '2019-06-18 05:10:22');
INSERT INTO `ltm_translations` VALUES (1870, 0, 'es', 'modules', 'emailSettings.notificationSubtitle', 'Seleccione los eventos para los que se debe enviar un correo electrónico al usuario.', '2019-06-18 05:07:23', '2019-06-18 05:10:23');
INSERT INTO `ltm_translations` VALUES (1871, 0, 'es', 'modules', 'emailSettings.notificationTitle', 'Establecer configuraciones de notificación por correo electrónico', '2019-06-18 05:07:23', '2019-06-18 05:10:23');
INSERT INTO `ltm_translations` VALUES (1872, 0, 'es', 'modules', 'emailSettings.userRegistration', 'Registro de Usuario / Añadido por Admin', '2019-06-18 05:07:23', '2019-06-18 05:10:23');
INSERT INTO `ltm_translations` VALUES (1873, 0, 'es', 'modules', 'emailSettings.taskAssign', 'Asignación de usuario a la tarea', '2019-06-18 05:07:23', '2019-06-18 05:10:24');
INSERT INTO `ltm_translations` VALUES (1874, 0, 'es', 'modules', 'emailSettings.employeeAssign', 'Asignación del empleado al proyecto', '2019-06-18 05:07:23', '2019-06-18 05:10:24');
INSERT INTO `ltm_translations` VALUES (1875, 0, 'es', 'modules', 'emailSettings.newNotice', 'Nuevo aviso publicado', '2019-06-18 05:07:23', '2019-06-18 05:10:24');
INSERT INTO `ltm_translations` VALUES (1876, 0, 'es', 'modules', 'emailSettings.expenseAdded', 'Nuevo gasto (agregado por administrador)', '2019-06-18 05:07:24', '2019-06-18 05:10:24');
INSERT INTO `ltm_translations` VALUES (1877, 0, 'es', 'modules', 'emailSettings.expenseMember', 'Nuevo gasto (Añadido por miembro)', '2019-06-18 05:07:24', '2019-06-18 05:10:24');
INSERT INTO `ltm_translations` VALUES (1878, 0, 'es', 'modules', 'emailSettings.expenseStatus', 'Estado de gastos modificado', '2019-06-18 05:07:24', '2019-06-18 05:10:24');
INSERT INTO `ltm_translations` VALUES (1879, 0, 'es', 'modules', 'emailSettings.ticketRequest', 'Solicitud de nuevo ticket de soporte', '2019-06-18 05:07:24', '2019-06-18 05:10:24');
INSERT INTO `ltm_translations` VALUES (1880, 0, 'es', 'modules', 'emailSettings.mailFromEmail', 'Correo electrónico', '2019-06-18 05:07:24', '2019-06-18 05:10:24');
INSERT INTO `ltm_translations` VALUES (1881, 0, 'es', 'modules', 'emailSettings.leaveRequest', 'Solicitud de licencia recibida', '2019-06-18 05:07:24', '2019-06-18 05:10:24');
INSERT INTO `ltm_translations` VALUES (1882, 0, 'es', 'modules', 'emailSettings.taskComplete', 'Tarea terminada', '2019-06-18 05:07:24', '2019-06-18 05:10:24');
INSERT INTO `ltm_translations` VALUES (1883, 0, 'es', 'modules', 'employees.activity', 'Actividad', '2019-06-18 05:07:24', '2019-06-18 05:10:25');
INSERT INTO `ltm_translations` VALUES (1884, 0, 'es', 'modules', 'employees.addNewEmployee', 'Añadir nuevo empleado', '2019-06-18 05:07:24', '2019-06-18 05:10:25');
INSERT INTO `ltm_translations` VALUES (1885, 0, 'es', 'modules', 'employees.createTitle', 'Agregar información del empleado', '2019-06-18 05:07:25', '2019-06-18 05:10:25');
INSERT INTO `ltm_translations` VALUES (1886, 0, 'es', 'modules', 'employees.emailNote', 'El empleado se conectará con este correo electrónico.', '2019-06-18 05:07:25', '2019-06-18 05:10:25');
INSERT INTO `ltm_translations` VALUES (1887, 0, 'es', 'modules', 'employees.employeeEmail', 'Correo electrónico del empleado', '2019-06-18 05:07:25', '2019-06-18 05:10:25');
INSERT INTO `ltm_translations` VALUES (1888, 0, 'es', 'modules', 'employees.employeeName', 'Nombre de empleado', '2019-06-18 05:07:25', '2019-06-18 05:10:25');
INSERT INTO `ltm_translations` VALUES (1889, 0, 'es', 'modules', 'employees.employeePassword', 'Contraseña', '2019-06-18 05:07:25', '2019-06-18 05:10:25');
INSERT INTO `ltm_translations` VALUES (1890, 0, 'es', 'modules', 'employees.endTime', 'Hora de finalización', '2019-06-18 05:07:25', '2019-06-18 05:10:25');
INSERT INTO `ltm_translations` VALUES (1891, 0, 'es', 'modules', 'employees.fullName', 'Nombre completo', '2019-06-18 05:07:25', '2019-06-18 05:10:26');
INSERT INTO `ltm_translations` VALUES (1892, 0, 'es', 'modules', 'employees.hourlyRate', 'Tarifa por hora', '2019-06-18 05:07:25', '2019-06-18 05:10:26');
INSERT INTO `ltm_translations` VALUES (1893, 0, 'es', 'modules', 'employees.hoursLogged', 'Horas registradas', '2019-06-18 05:07:25', '2019-06-18 05:10:26');
INSERT INTO `ltm_translations` VALUES (1894, 0, 'es', 'modules', 'employees.jobTitle', 'Título profesional', '2019-06-18 05:07:26', '2019-06-18 05:10:26');
INSERT INTO `ltm_translations` VALUES (1895, 0, 'es', 'modules', 'employees.memo', 'Memorándum', '2019-06-18 05:07:26', '2019-06-18 05:10:26');
INSERT INTO `ltm_translations` VALUES (1896, 0, 'es', 'modules', 'employees.passwordNote', 'El empleado se conectará usando esta contraseña.', '2019-06-18 05:07:26', '2019-06-18 05:10:26');
INSERT INTO `ltm_translations` VALUES (1897, 0, 'es', 'modules', 'employees.profile', 'Perfil', '2019-06-18 05:07:26', '2019-06-18 05:10:26');
INSERT INTO `ltm_translations` VALUES (1898, 0, 'es', 'modules', 'employees.startTime', 'Hora de inicio', '2019-06-18 05:07:26', '2019-06-18 05:10:26');
INSERT INTO `ltm_translations` VALUES (1899, 0, 'es', 'modules', 'employees.tasksDone', 'Tareas realizadas', '2019-06-18 05:07:26', '2019-06-18 05:10:27');
INSERT INTO `ltm_translations` VALUES (1900, 0, 'es', 'modules', 'employees.totalHours', 'Horas totales', '2019-06-18 05:07:26', '2019-06-18 05:10:27');
INSERT INTO `ltm_translations` VALUES (1901, 0, 'es', 'modules', 'employees.updatePasswordNote', 'El empleado se conectará usando esta contraseña. (Deje en blanco para mantener la contraseña actual)', '2019-06-18 05:07:26', '2019-06-18 05:10:27');
INSERT INTO `ltm_translations` VALUES (1902, 0, 'es', 'modules', 'employees.updateTitle', 'Actualizar Info Empleado', '2019-06-18 05:07:27', '2019-06-18 05:10:27');
INSERT INTO `ltm_translations` VALUES (1903, 0, 'es', 'modules', 'employees.slackUsername', 'slack nombre de usuario', '2019-06-18 05:07:27', '2019-06-18 05:10:27');
INSERT INTO `ltm_translations` VALUES (1904, 0, 'es', 'modules', 'employees.joiningDate', 'Dia de ingreso', '2019-06-18 05:07:27', '2019-06-18 05:10:27');
INSERT INTO `ltm_translations` VALUES (1905, 0, 'es', 'modules', 'employees.gender', 'género', '2019-06-18 05:07:27', '2019-06-18 05:10:28');
INSERT INTO `ltm_translations` VALUES (1906, 0, 'es', 'modules', 'financeReport.chartTitle', 'Gráfico de barras de ganancias', '2019-06-18 05:07:27', '2019-06-18 05:10:28');
INSERT INTO `ltm_translations` VALUES (1907, 0, 'es', 'modules', 'financeReport.financeReport', 'Gráfico de barras de ganancias', '2019-06-18 05:07:27', '2019-06-18 05:10:28');
INSERT INTO `ltm_translations` VALUES (1908, 0, 'es', 'modules', 'financeReport.noteText', 'Las ganancias se calculan con el tipo de cambio más reciente para diferentes monedas.', '2019-06-18 05:07:28', '2019-06-18 05:10:28');
INSERT INTO `ltm_translations` VALUES (1909, 0, 'es', 'modules', 'financeReport.selectCurrency', 'Seleccione el tipo de moneda', '2019-06-18 05:07:28', '2019-06-18 05:10:28');
INSERT INTO `ltm_translations` VALUES (1910, 0, 'es', 'modules', 'financeReport.showAmountIn', 'Mostrar cantidad en', '2019-06-18 05:07:28', '2019-06-18 05:10:28');
INSERT INTO `ltm_translations` VALUES (1911, 0, 'es', 'modules', 'invoices.addInvoice', 'Añadir factura', '2019-06-18 05:07:28', '2019-06-18 05:10:28');
INSERT INTO `ltm_translations` VALUES (1912, 0, 'es', 'modules', 'invoices.addItem', 'Añadir artículo', '2019-06-18 05:07:28', '2019-06-18 05:10:29');
INSERT INTO `ltm_translations` VALUES (1913, 0, 'es', 'modules', 'invoices.amount', 'Cantidad', '2019-06-18 05:07:28', '2019-06-18 05:10:29');
INSERT INTO `ltm_translations` VALUES (1914, 0, 'es', 'modules', 'invoices.billedTo', 'Facturado a', '2019-06-18 05:07:28', '2019-06-18 05:10:29');
INSERT INTO `ltm_translations` VALUES (1915, 0, 'es', 'modules', 'invoices.currency', 'Moneda', '2019-06-18 05:07:28', '2019-06-18 05:10:29');
INSERT INTO `ltm_translations` VALUES (1916, 0, 'es', 'modules', 'invoices.discount', 'Descuento', '2019-06-18 05:07:29', '2019-06-18 05:10:29');
INSERT INTO `ltm_translations` VALUES (1917, 0, 'es', 'modules', 'invoices.generatedBy', 'Generado por', '2019-06-18 05:07:29', '2019-06-18 05:10:29');
INSERT INTO `ltm_translations` VALUES (1918, 0, 'es', 'modules', 'invoices.invoiceDate', 'Fecha de la factura', '2019-06-18 05:07:29', '2019-06-18 05:10:29');
INSERT INTO `ltm_translations` VALUES (1919, 0, 'es', 'modules', 'invoices.item', 'ít.', '2019-06-18 05:07:29', '2019-06-18 05:10:29');
INSERT INTO `ltm_translations` VALUES (1920, 0, 'es', 'modules', 'invoices.paid', 'Pagado', '2019-06-18 05:07:29', '2019-06-18 05:10:29');
INSERT INTO `ltm_translations` VALUES (1921, 0, 'es', 'modules', 'invoices.price', 'Precio', '2019-06-18 05:07:29', '2019-06-18 05:10:30');
INSERT INTO `ltm_translations` VALUES (1922, 0, 'es', 'modules', 'invoices.qty', 'Cantidad / hora', '2019-06-18 05:07:29', '2019-06-18 05:10:30');
INSERT INTO `ltm_translations` VALUES (1923, 0, 'es', 'modules', 'invoices.subTotal', 'Sub Total', '2019-06-18 05:07:29', '2019-06-18 05:10:30');
INSERT INTO `ltm_translations` VALUES (1924, 0, 'es', 'modules', 'invoices.tax', 'Impuesto', '2019-06-18 05:07:29', '2019-06-18 05:10:30');
INSERT INTO `ltm_translations` VALUES (1925, 0, 'es', 'modules', 'invoices.total', 'Total', '2019-06-18 05:07:29', '2019-06-18 05:10:30');
INSERT INTO `ltm_translations` VALUES (1926, 0, 'es', 'modules', 'invoices.unitPrice', 'Precio unitario', '2019-06-18 05:07:30', '2019-06-18 05:10:30');
INSERT INTO `ltm_translations` VALUES (1927, 0, 'es', 'modules', 'invoices.unpaid', 'No pagado', '2019-06-18 05:07:30', '2019-06-18 05:10:31');
INSERT INTO `ltm_translations` VALUES (1928, 0, 'es', 'modules', 'invoices.type', 'Tipo', '2019-06-18 05:07:30', '2019-06-18 05:10:31');
INSERT INTO `ltm_translations` VALUES (1929, 0, 'es', 'modules', 'invoices.downloadPdf', 'Descargar PDF', '2019-06-18 05:07:30', '2019-06-18 05:10:31');
INSERT INTO `ltm_translations` VALUES (1930, 0, 'es', 'modules', 'invoices.payPaypal', 'Pago a través de Paypal', '2019-06-18 05:07:30', '2019-06-18 05:10:31');
INSERT INTO `ltm_translations` VALUES (1931, 0, 'es', 'modules', 'invoices.isRecurringPayment', '¿Es un pago recurrente?', '2019-06-18 05:07:30', '2019-06-18 05:10:31');
INSERT INTO `ltm_translations` VALUES (1932, 0, 'es', 'modules', 'invoices.billingCycle', 'Ciclo de facturación', '2019-06-18 05:07:30', '2019-06-18 05:10:32');
INSERT INTO `ltm_translations` VALUES (1933, 0, 'es', 'modules', 'invoices.billingFrequency', 'Frecuencia de facturación', '2019-06-18 05:07:30', '2019-06-18 05:10:32');
INSERT INTO `ltm_translations` VALUES (1934, 0, 'es', 'modules', 'invoices.billingInterval', 'Intervalo de facturación', '2019-06-18 05:07:30', '2019-06-18 05:10:32');
INSERT INTO `ltm_translations` VALUES (1935, 0, 'es', 'modules', 'invoices.recurringPayments', 'Pago recurrente', '2019-06-18 05:07:31', '2019-06-18 05:10:32');
INSERT INTO `ltm_translations` VALUES (1936, 0, 'es', 'modules', 'invoices.payNow', 'Pague ahora', '2019-06-18 05:07:31', '2019-06-18 05:10:33');
INSERT INTO `ltm_translations` VALUES (1937, 0, 'es', 'modules', 'invoices.payStripe', 'Pague con Stripe', '2019-06-18 05:07:31', '2019-06-18 05:10:33');
INSERT INTO `ltm_translations` VALUES (1938, 0, 'es', 'modules', 'invoices.rate', 'tarifa', '2019-06-18 05:07:31', '2019-06-18 05:10:33');
INSERT INTO `ltm_translations` VALUES (1939, 0, 'es', 'modules', 'invoices.taxName', 'nombre del impuesto', '2019-06-18 05:07:31', '2019-06-18 05:10:33');
INSERT INTO `ltm_translations` VALUES (1940, 0, 'es', 'modules', 'issues.addIssue', 'Añadir problema', '2019-06-18 05:07:31', '2019-06-18 05:10:33');
INSERT INTO `ltm_translations` VALUES (1941, 0, 'es', 'modules', 'issues.markPending', 'Marcar pendiente', '2019-06-18 05:07:31', '2019-06-18 05:10:33');
INSERT INTO `ltm_translations` VALUES (1942, 0, 'es', 'modules', 'issues.markResolved', 'Mark Resolved', '2019-06-18 05:07:31', '2019-06-18 05:10:34');
INSERT INTO `ltm_translations` VALUES (1943, 0, 'es', 'modules', 'issues.pending', 'Pendiente', '2019-06-18 05:07:31', '2019-06-18 05:10:34');
INSERT INTO `ltm_translations` VALUES (1944, 0, 'es', 'modules', 'issues.reportedOn', 'Reportado en', '2019-06-18 05:07:32', '2019-06-18 05:10:34');
INSERT INTO `ltm_translations` VALUES (1945, 0, 'es', 'modules', 'issues.resolved', 'Resuelto', '2019-06-18 05:07:32', '2019-06-18 05:10:34');
INSERT INTO `ltm_translations` VALUES (1946, 0, 'es', 'modules', 'issues.updateIssue', 'Problema de actualización', '2019-06-18 05:07:32', '2019-06-18 05:10:34');
INSERT INTO `ltm_translations` VALUES (1947, 0, 'es', 'modules', 'timeLogs.whoLogged', 'Quien registró', '2019-06-18 05:07:32', '2019-06-18 05:10:34');
INSERT INTO `ltm_translations` VALUES (1948, 0, 'es', 'modules', 'timeLogs.totalHours', 'Horas totales', '2019-06-18 05:07:32', '2019-06-18 05:10:34');
INSERT INTO `ltm_translations` VALUES (1949, 0, 'es', 'modules', 'timeLogs.stopTimer', 'Detener temporizador', '2019-06-18 05:07:32', '2019-06-18 05:10:34');
INSERT INTO `ltm_translations` VALUES (1950, 0, 'es', 'modules', 'timeLogs.startTimer', 'Iniciar temporizador de proyecto', '2019-06-18 05:07:32', '2019-06-18 05:10:35');
INSERT INTO `ltm_translations` VALUES (1951, 0, 'es', 'modules', 'timeLogs.startTime', 'Hora de inicio', '2019-06-18 05:07:32', '2019-06-18 05:10:35');
INSERT INTO `ltm_translations` VALUES (1952, 0, 'es', 'modules', 'timeLogs.employeeName', 'Nombre de empleado', '2019-06-18 05:07:32', '2019-06-18 05:10:35');
INSERT INTO `ltm_translations` VALUES (1953, 0, 'es', 'modules', 'timeLogs.endDate', 'Fecha final', '2019-06-18 05:07:32', '2019-06-18 05:10:35');
INSERT INTO `ltm_translations` VALUES (1954, 0, 'es', 'modules', 'timeLogs.endTime', 'Hora de finalización', '2019-06-18 05:07:33', '2019-06-18 05:10:35');
INSERT INTO `ltm_translations` VALUES (1955, 0, 'es', 'modules', 'timeLogs.lastUpdatedBy', 'Última actualización por', '2019-06-18 05:07:33', '2019-06-18 05:10:35');
INSERT INTO `ltm_translations` VALUES (1956, 0, 'es', 'modules', 'timeLogs.logTime', 'Tiempo de registro', '2019-06-18 05:07:33', '2019-06-18 05:10:36');
INSERT INTO `ltm_translations` VALUES (1957, 0, 'es', 'modules', 'timeLogs.memo', 'Memorándum', '2019-06-18 05:07:33', '2019-06-18 05:10:36');
INSERT INTO `ltm_translations` VALUES (1958, 0, 'es', 'modules', 'timeLogs.selectProject', 'Memorándum', '2019-06-18 05:07:33', '2019-06-18 05:10:36');
INSERT INTO `ltm_translations` VALUES (1959, 0, 'es', 'modules', 'timeLogs.startDate', 'Hora de inicio', '2019-06-18 05:07:33', '2019-06-18 05:10:36');
INSERT INTO `ltm_translations` VALUES (1960, 0, 'es', 'modules', 'messages.chooseMember', 'Hora de inicio', '2019-06-18 05:07:33', '2019-06-18 05:10:36');
INSERT INTO `ltm_translations` VALUES (1961, 0, 'es', 'modules', 'messages.message', 'Mensaje', '2019-06-18 05:07:34', '2019-06-18 05:10:36');
INSERT INTO `ltm_translations` VALUES (1962, 0, 'es', 'modules', 'messages.searchContact', 'Búsqueda Contacto', '2019-06-18 05:07:34', '2019-06-18 05:10:36');
INSERT INTO `ltm_translations` VALUES (1963, 0, 'es', 'modules', 'messages.send', 'Enviar', '2019-06-18 05:07:34', '2019-06-18 05:10:37');
INSERT INTO `ltm_translations` VALUES (1964, 0, 'es', 'modules', 'messages.startConversation', 'Iniciar conversación', '2019-06-18 05:07:34', '2019-06-18 05:10:37');
INSERT INTO `ltm_translations` VALUES (1965, 0, 'es', 'modules', 'messages.typeMessage', 'Escribe tu mensaje aquí...', '2019-06-18 05:07:34', '2019-06-18 05:10:37');
INSERT INTO `ltm_translations` VALUES (1966, 0, 'es', 'modules', 'messages.chooseAdmin', 'Elige Admin', '2019-06-18 05:07:34', '2019-06-18 05:10:37');
INSERT INTO `ltm_translations` VALUES (1967, 0, 'es', 'modules', 'messages.allowClientAdminChat', 'Permitir chat entre el cliente y el administrador?', '2019-06-18 05:07:34', '2019-06-18 05:10:37');
INSERT INTO `ltm_translations` VALUES (1968, 0, 'es', 'modules', 'messages.allowClientEmployeeChat', 'Permitir el chat entre el cliente y los empleados?', '2019-06-18 05:07:34', '2019-06-18 05:10:37');
INSERT INTO `ltm_translations` VALUES (1969, 0, 'es', 'modules', 'moduleSettings.clientModuleTitle', 'Escribe tu mensaje aquí...', '2019-06-18 05:07:34', '2019-06-18 05:10:37');
INSERT INTO `ltm_translations` VALUES (1970, 0, 'es', 'modules', 'moduleSettings.clientSubTitle', 'Seleccione los módulos a los que el cliente puede acceder.', '2019-06-18 05:07:34', '2019-06-18 05:10:38');
INSERT INTO `ltm_translations` VALUES (1971, 0, 'es', 'modules', 'moduleSettings.employeeModuleTitle', 'módulo', '2019-06-18 05:07:34', '2019-06-18 05:10:38');
INSERT INTO `ltm_translations` VALUES (1972, 0, 'es', 'modules', 'moduleSettings.employeeSubTitle', 'Seleccione los módulos que desea habilitar.', '2019-06-18 05:07:35', '2019-06-18 05:10:38');
INSERT INTO `ltm_translations` VALUES (1973, 0, 'es', 'modules', 'notices.addNotice', 'Agregar nuevo aviso', '2019-06-18 05:07:35', '2019-06-18 05:10:38');
INSERT INTO `ltm_translations` VALUES (1974, 0, 'es', 'modules', 'notices.notice', 'darse cuenta', '2019-06-18 05:07:35', '2019-06-18 05:10:38');
INSERT INTO `ltm_translations` VALUES (1975, 0, 'es', 'modules', 'notices.noticeDetails', 'Detalles del aviso', '2019-06-18 05:07:35', '2019-06-18 05:10:39');
INSERT INTO `ltm_translations` VALUES (1976, 0, 'es', 'modules', 'notices.noticeHeading', 'Notificación', '2019-06-18 05:07:35', '2019-06-18 05:10:39');
INSERT INTO `ltm_translations` VALUES (1977, 0, 'es', 'modules', 'notices.updateNotice', 'Aviso de Actualización', '2019-06-18 05:07:35', '2019-06-18 05:10:39');
INSERT INTO `ltm_translations` VALUES (1978, 0, 'es', 'modules', 'profile.passwordNote', 'Deje en blanco para conservar su contraseña actual.', '2019-06-18 05:07:35', '2019-06-18 05:10:39');
INSERT INTO `ltm_translations` VALUES (1979, 0, 'es', 'modules', 'profile.profilePicture', 'Foto de perfil', '2019-06-18 05:07:35', '2019-06-18 05:10:39');
INSERT INTO `ltm_translations` VALUES (1980, 0, 'es', 'modules', 'profile.updateTitle', 'Actualizar información del perfil', '2019-06-18 05:07:36', '2019-06-18 05:10:39');
INSERT INTO `ltm_translations` VALUES (1981, 0, 'es', 'modules', 'profile.yourAddress', 'Su dirección', '2019-06-18 05:07:36', '2019-06-18 05:10:39');
INSERT INTO `ltm_translations` VALUES (1982, 0, 'es', 'modules', 'profile.yourEmail', 'Tu correo electrónico', '2019-06-18 05:07:36', '2019-06-18 05:10:40');
INSERT INTO `ltm_translations` VALUES (1983, 0, 'es', 'modules', 'profile.yourMobileNumber', 'Tú número de teléfono', '2019-06-18 05:07:36', '2019-06-18 05:10:40');
INSERT INTO `ltm_translations` VALUES (1984, 0, 'es', 'modules', 'profile.yourName', 'Tu nombre', '2019-06-18 05:07:36', '2019-06-18 05:10:40');
INSERT INTO `ltm_translations` VALUES (1985, 0, 'es', 'modules', 'profile.yourPassword', 'Tu contraseña', '2019-06-18 05:07:36', '2019-06-18 05:10:40');
INSERT INTO `ltm_translations` VALUES (1986, 0, 'es', 'modules', 'profile.uploadPicture', 'Sube tu foto', '2019-06-18 05:07:36', '2019-06-18 05:10:40');
INSERT INTO `ltm_translations` VALUES (1987, 0, 'es', 'modules', 'projects.activeSince', 'Activo Desde', '2019-06-18 05:07:37', '2019-06-18 05:10:40');
INSERT INTO `ltm_translations` VALUES (1988, 0, 'es', 'modules', 'projects.activeTimers', 'Temporizadores activos', '2019-06-18 05:07:37', '2019-06-18 05:10:40');
INSERT INTO `ltm_translations` VALUES (1989, 0, 'es', 'modules', 'projects.activityTimeline', 'Línea de tiempo de la actividad', '2019-06-18 05:07:37', '2019-06-18 05:10:41');
INSERT INTO `ltm_translations` VALUES (1990, 0, 'es', 'modules', 'projects.addMemberTitle', 'Agregar miembros del proyecto', '2019-06-18 05:07:37', '2019-06-18 05:10:41');
INSERT INTO `ltm_translations` VALUES (1991, 0, 'es', 'modules', 'projects.addNewProject', 'Añadir nuevo proyecto', '2019-06-18 05:07:37', '2019-06-18 05:10:41');
INSERT INTO `ltm_translations` VALUES (1992, 0, 'es', 'modules', 'projects.clientFeedback', 'Comentarios del cliente', '2019-06-18 05:07:37', '2019-06-18 05:10:41');
INSERT INTO `ltm_translations` VALUES (1993, 0, 'es', 'modules', 'projects.createTitle', 'Agregar proyecto', '2019-06-18 05:07:38', '2019-06-18 05:10:41');
INSERT INTO `ltm_translations` VALUES (1994, 0, 'es', 'modules', 'projects.daysLeft', 'Días que quedan', '2019-06-18 05:07:38', '2019-06-18 05:10:42');
INSERT INTO `ltm_translations` VALUES (1995, 0, 'es', 'modules', 'projects.deadline', 'Fecha tope', '2019-06-18 05:07:38', '2019-06-18 05:10:42');
INSERT INTO `ltm_translations` VALUES (1996, 0, 'es', 'modules', 'projects.dropFile', 'Descarga archivos aquí O haz clic para cargar', '2019-06-18 05:07:39', '2019-06-18 05:10:42');
INSERT INTO `ltm_translations` VALUES (1997, 0, 'es', 'modules', 'projects.files', 'Archivos', '2019-06-18 05:07:39', '2019-06-18 05:10:42');
INSERT INTO `ltm_translations` VALUES (1998, 0, 'es', 'modules', 'projects.hoursLogged', 'Horas registradas', '2019-06-18 05:07:39', '2019-06-18 05:10:42');
INSERT INTO `ltm_translations` VALUES (1999, 0, 'es', 'modules', 'projects.issuesPending', 'Problemas pendientes', '2019-06-18 05:07:39', '2019-06-18 05:10:42');
INSERT INTO `ltm_translations` VALUES (2000, 0, 'es', 'modules', 'projects.members', 'Miembros', '2019-06-18 05:07:39', '2019-06-18 05:10:43');
INSERT INTO `ltm_translations` VALUES (2001, 0, 'es', 'modules', 'projects.note', 'Nota', '2019-06-18 05:07:39', '2019-06-18 05:10:43');
INSERT INTO `ltm_translations` VALUES (2002, 0, 'es', 'modules', 'projects.openTasks', 'Tareas abiertas', '2019-06-18 05:07:39', '2019-06-18 05:10:43');
INSERT INTO `ltm_translations` VALUES (2003, 0, 'es', 'modules', 'projects.overview', 'Visión de conjunto', '2019-06-18 05:07:39', '2019-06-18 05:10:43');
INSERT INTO `ltm_translations` VALUES (2004, 0, 'es', 'modules', 'projects.projectCategory', 'Categoría del proyecto', '2019-06-18 05:07:39', '2019-06-18 05:10:43');
INSERT INTO `ltm_translations` VALUES (2005, 0, 'es', 'modules', 'projects.projectCompletionStatus', 'Estado de finalización del proyecto', '2019-06-18 05:07:40', '2019-06-18 05:10:43');
INSERT INTO `ltm_translations` VALUES (2006, 0, 'es', 'modules', 'projects.projectMembers', 'Miembros del proyecto', '2019-06-18 05:07:40', '2019-06-18 05:10:44');
INSERT INTO `ltm_translations` VALUES (2007, 0, 'es', 'modules', 'projects.projectName', 'Nombre del proyecto', '2019-06-18 05:07:40', '2019-06-18 05:10:44');
INSERT INTO `ltm_translations` VALUES (2008, 0, 'es', 'modules', 'projects.projectSummary', 'Resumen del proyecto', '2019-06-18 05:07:40', '2019-06-18 05:10:44');
INSERT INTO `ltm_translations` VALUES (2009, 0, 'es', 'modules', 'projects.projectUpdated', 'Detalles del proyecto actualizados.', '2019-06-18 05:07:40', '2019-06-18 05:10:44');
INSERT INTO `ltm_translations` VALUES (2010, 0, 'es', 'modules', 'projects.selectClient', 'Seleccione Cliente', '2019-06-18 05:07:40', '2019-06-18 05:10:44');
INSERT INTO `ltm_translations` VALUES (2011, 0, 'es', 'modules', 'projects.startDate', 'Fecha de inicio', '2019-06-18 05:07:40', '2019-06-18 05:10:45');
INSERT INTO `ltm_translations` VALUES (2012, 0, 'es', 'modules', 'projects.updateTitle', 'Actualizar detalles del proyecto', '2019-06-18 05:07:41', '2019-06-18 05:10:45');
INSERT INTO `ltm_translations` VALUES (2013, 0, 'es', 'modules', 'projects.uploadFile', 'Subir archivo', '2019-06-18 05:07:41', '2019-06-18 05:10:45');
INSERT INTO `ltm_translations` VALUES (2014, 0, 'es', 'modules', 'projects.whoWorking', 'Subir archivo', '2019-06-18 05:07:41', '2019-06-18 05:10:45');
INSERT INTO `ltm_translations` VALUES (2015, 0, 'es', 'modules', 'projects.noOpenTasks', 'No hay tareas abiertas.', '2019-06-18 05:07:41', '2019-06-18 05:10:45');
INSERT INTO `ltm_translations` VALUES (2016, 0, 'es', 'modules', 'projects.calculateTasksProgress', 'Calcular el progreso a través de las tareas', '2019-06-18 05:07:41', '2019-06-18 05:10:45');
INSERT INTO `ltm_translations` VALUES (2017, 0, 'es', 'modules', 'projects.viewGanttChart', 'diagrama de Gantt', '2019-06-18 05:07:41', '2019-06-18 05:10:46');
INSERT INTO `ltm_translations` VALUES (2018, 0, 'es', 'modules', 'projects.clientViewTask', 'El cliente puede ver las tareas de este proyecto', '2019-06-18 05:07:41', '2019-06-18 05:10:46');
INSERT INTO `ltm_translations` VALUES (2019, 0, 'es', 'modules', 'projects.manualTimelog', 'Permitir registros de tiempo manual?', '2019-06-18 05:07:41', '2019-06-18 05:10:46');
INSERT INTO `ltm_translations` VALUES (2020, 0, 'es', 'modules', 'sticky.addNote', 'Añadir la nota', '2019-06-18 05:07:42', '2019-06-18 05:10:46');
INSERT INTO `ltm_translations` VALUES (2021, 0, 'es', 'modules', 'sticky.colors', 'Colores', '2019-06-18 05:07:42', '2019-06-18 05:10:46');
INSERT INTO `ltm_translations` VALUES (2022, 0, 'es', 'modules', 'sticky.lastUpdated', 'actualizado', '2019-06-18 05:07:42', '2019-06-18 05:10:46');
INSERT INTO `ltm_translations` VALUES (2023, 0, 'es', 'modules', 'taskCalendar.note', 'Calendario muestra las tareas debidas en sus fechas de vencimiento.', '2019-06-18 05:07:42', '2019-06-18 05:10:46');
INSERT INTO `ltm_translations` VALUES (2024, 0, 'es', 'modules', 'taskCalendar.taskDetail', 'Detalle de tareas', '2019-06-18 05:07:42', '2019-06-18 05:10:47');
INSERT INTO `ltm_translations` VALUES (2025, 0, 'es', 'modules', 'taskReport.chartTitle', 'Gráfico circular', '2019-06-18 05:07:42', '2019-06-18 05:10:47');
INSERT INTO `ltm_translations` VALUES (2026, 0, 'es', 'modules', 'taskReport.completedTasks', 'Tareas Completas', '2019-06-18 05:07:42', '2019-06-18 05:10:47');
INSERT INTO `ltm_translations` VALUES (2027, 0, 'es', 'modules', 'taskReport.pendingTasks', 'Tareas pendientes', '2019-06-18 05:07:42', '2019-06-18 05:10:47');
INSERT INTO `ltm_translations` VALUES (2028, 0, 'es', 'modules', 'taskReport.taskToComplete', 'Tarea a completar', '2019-06-18 05:07:42', '2019-06-18 05:10:47');
INSERT INTO `ltm_translations` VALUES (2029, 0, 'es', 'modules', 'tasks.assignTo', 'Asignar a', '2019-06-18 05:07:43', '2019-06-18 05:10:47');
INSERT INTO `ltm_translations` VALUES (2030, 0, 'es', 'modules', 'tasks.chooseAssignee', 'Elegir cesionario', '2019-06-18 05:07:43', '2019-06-18 05:10:48');
INSERT INTO `ltm_translations` VALUES (2031, 0, 'es', 'modules', 'tasks.dueSoon', 'Debido pronto', '2019-06-18 05:07:43', '2019-06-18 05:10:48');
INSERT INTO `ltm_translations` VALUES (2032, 0, 'es', 'modules', 'tasks.high', 'Alto', '2019-06-18 05:07:43', '2019-06-18 05:10:48');
INSERT INTO `ltm_translations` VALUES (2033, 0, 'es', 'modules', 'tasks.lastCreated', 'Creado por última vez', '2019-06-18 05:07:43', '2019-06-18 05:10:48');
INSERT INTO `ltm_translations` VALUES (2034, 0, 'es', 'modules', 'tasks.low', 'Bajo', '2019-06-18 05:07:43', '2019-06-18 05:10:48');
INSERT INTO `ltm_translations` VALUES (2035, 0, 'es', 'modules', 'tasks.medium', 'Medio', '2019-06-18 05:07:44', '2019-06-18 05:10:48');
INSERT INTO `ltm_translations` VALUES (2036, 0, 'es', 'modules', 'tasks.newTask', 'Nueva tarea', '2019-06-18 05:07:44', '2019-06-18 05:10:49');
INSERT INTO `ltm_translations` VALUES (2037, 0, 'es', 'modules', 'tasks.priority', 'Prioridad', '2019-06-18 05:07:44', '2019-06-18 05:10:49');
INSERT INTO `ltm_translations` VALUES (2038, 0, 'es', 'modules', 'tasks.taskDetail', 'Prioridad', '2019-06-18 05:07:44', '2019-06-18 05:10:49');
INSERT INTO `ltm_translations` VALUES (2039, 0, 'es', 'modules', 'tasks.updateTask', 'Tarea de actualización', '2019-06-18 05:07:44', '2019-06-18 05:10:49');
INSERT INTO `ltm_translations` VALUES (2040, 0, 'es', 'modules', 'tasks.taskBoard', 'Tablero de tareas', '2019-06-18 05:07:44', '2019-06-18 05:10:49');
INSERT INTO `ltm_translations` VALUES (2041, 0, 'es', 'modules', 'tasks.addBoardColumn', 'Añadir columna', '2019-06-18 05:07:44', '2019-06-18 05:10:50');
INSERT INTO `ltm_translations` VALUES (2042, 0, 'es', 'modules', 'tasks.columnName', 'Nombre de columna', '2019-06-18 05:07:44', '2019-06-18 05:10:50');
INSERT INTO `ltm_translations` VALUES (2043, 0, 'es', 'modules', 'tasks.labelColor', 'Color de la etiqueta', '2019-06-18 05:07:45', '2019-06-18 05:10:50');
INSERT INTO `ltm_translations` VALUES (2044, 0, 'es', 'modules', 'tasks.tasksTable', 'Tabla de tareas', '2019-06-18 05:07:45', '2019-06-18 05:10:50');
INSERT INTO `ltm_translations` VALUES (2045, 0, 'es', 'modules', 'tasks.subTask', 'Sub Tarea', '2019-06-18 05:07:45', '2019-06-18 05:10:50');
INSERT INTO `ltm_translations` VALUES (2046, 0, 'es', 'modules', 'tasks.comment', 'comentario', '2019-06-18 05:07:45', '2019-06-18 05:10:50');
INSERT INTO `ltm_translations` VALUES (2047, 0, 'es', 'modules', 'timeLogReport.chartTitle', 'Gráfico de barras del registro de tiempo', '2019-06-18 05:07:45', '2019-06-18 05:10:50');
INSERT INTO `ltm_translations` VALUES (2048, 0, 'es', 'modules', 'projectCategory.addProjectCategory', 'Agregar categoría de proyecto', '2019-06-18 05:07:45', '2019-06-18 05:10:51');
INSERT INTO `ltm_translations` VALUES (2049, 0, 'es', 'modules', 'projectCategory.categoryName', 'nombre de la categoría', '2019-06-18 05:07:45', '2019-06-18 05:10:51');
INSERT INTO `ltm_translations` VALUES (2050, 0, 'es', 'modules', 'themeSettings.adminPanelTheme', 'Tema del panel de administración', '2019-06-18 05:07:45', '2019-06-18 05:10:51');
INSERT INTO `ltm_translations` VALUES (2051, 0, 'es', 'modules', 'themeSettings.clientPanelTheme', 'Tema Panel de Cliente', '2019-06-18 05:07:45', '2019-06-18 05:10:53');
INSERT INTO `ltm_translations` VALUES (2052, 0, 'es', 'modules', 'themeSettings.employeePanelTheme', 'Tema del panel de empleados', '2019-06-18 05:07:46', '2019-06-18 05:10:53');
INSERT INTO `ltm_translations` VALUES (2053, 0, 'es', 'modules', 'themeSettings.headerColor', 'Color del encabezado (color primario)', '2019-06-18 05:07:46', '2019-06-18 05:10:54');
INSERT INTO `ltm_translations` VALUES (2054, 0, 'es', 'modules', 'themeSettings.projectAdminPanelTheme', 'Tema del Panel de Administración del Proyecto', '2019-06-18 05:07:46', '2019-06-18 05:10:54');
INSERT INTO `ltm_translations` VALUES (2055, 0, 'es', 'modules', 'themeSettings.sidebarColor', 'Color de la barra lateral', '2019-06-18 05:07:46', '2019-06-18 05:10:54');
INSERT INTO `ltm_translations` VALUES (2056, 0, 'es', 'modules', 'themeSettings.sidebarTextColor', 'Color del texto de la barra lateral', '2019-06-18 05:07:46', '2019-06-18 05:10:55');
INSERT INTO `ltm_translations` VALUES (2057, 0, 'es', 'modules', 'themeSettings.linkColor', 'Color de enlace', '2019-06-18 05:07:46', '2019-06-18 05:10:55');
INSERT INTO `ltm_translations` VALUES (2058, 0, 'es', 'modules', 'themeSettings.loginScreenBackground', 'Fondo de pantalla de inicio de sesión', '2019-06-18 05:07:47', '2019-06-18 05:10:55');
INSERT INTO `ltm_translations` VALUES (2059, 0, 'es', 'modules', 'themeSettings.uploadImage', 'Cargar imagen', '2019-06-18 05:07:47', '2019-06-18 05:10:55');
INSERT INTO `ltm_translations` VALUES (2060, 0, 'es', 'modules', 'themeSettings.customCss', 'CSS personalizado', '2019-06-18 05:07:47', '2019-06-18 05:10:55');
INSERT INTO `ltm_translations` VALUES (2061, 0, 'es', 'modules', 'themeSettings.useCustomTheme', 'Usar tema personalizado', '2019-06-18 05:07:47', '2019-06-18 05:10:55');
INSERT INTO `ltm_translations` VALUES (2062, 0, 'es', 'modules', 'themeSettings.useDefaultTheme', 'Usar el tema predeterminado', '2019-06-18 05:07:47', '2019-06-18 05:10:55');
INSERT INTO `ltm_translations` VALUES (2063, 0, 'es', 'modules', 'estimates.createEstimate', 'Crear estimación', '2019-06-18 05:07:47', '2019-06-18 05:10:55');
INSERT INTO `ltm_translations` VALUES (2064, 0, 'es', 'modules', 'estimates.validTill', 'Válida hasta', '2019-06-18 05:07:47', '2019-06-18 05:10:55');
INSERT INTO `ltm_translations` VALUES (2065, 0, 'es', 'modules', 'estimates.accepted', 'Aceptado', '2019-06-18 05:07:48', '2019-06-18 05:10:56');
INSERT INTO `ltm_translations` VALUES (2066, 0, 'es', 'modules', 'estimates.declined', 'Rechazado', '2019-06-18 05:07:48', '2019-06-18 05:10:56');
INSERT INTO `ltm_translations` VALUES (2067, 0, 'es', 'modules', 'estimates.waiting', 'Esperando', '2019-06-18 05:07:48', '2019-06-18 05:10:56');
INSERT INTO `ltm_translations` VALUES (2068, 0, 'es', 'modules', 'estimates.updateEstimate', 'Actualizar estimación', '2019-06-18 05:07:48', '2019-06-18 05:10:56');
INSERT INTO `ltm_translations` VALUES (2069, 0, 'es', 'modules', 'estimates.convertEstimateTitle', 'Convertir estimación a factura', '2019-06-18 05:07:48', '2019-06-18 05:10:56');
INSERT INTO `ltm_translations` VALUES (2070, 0, 'es', 'modules', 'payments.addPayment', 'Añadir pago', '2019-06-18 05:07:48', '2019-06-18 05:10:57');
INSERT INTO `ltm_translations` VALUES (2071, 0, 'es', 'modules', 'payments.paidOn', 'Pagado', '2019-06-18 05:07:48', '2019-06-18 05:10:57');
INSERT INTO `ltm_translations` VALUES (2072, 0, 'es', 'modules', 'payments.paymentGateway', 'Gateway de pago', '2019-06-18 05:07:48', '2019-06-18 05:10:57');
INSERT INTO `ltm_translations` VALUES (2073, 0, 'es', 'modules', 'payments.selectInvoice', 'Seleccione Factura', '2019-06-18 05:07:48', '2019-06-18 05:10:57');
INSERT INTO `ltm_translations` VALUES (2074, 0, 'es', 'modules', 'payments.transactionId', 'ID de transacción', '2019-06-18 05:07:48', '2019-06-18 05:10:57');
INSERT INTO `ltm_translations` VALUES (2075, 0, 'es', 'modules', 'payments.updatePayment', 'Actualizar pago', '2019-06-18 05:07:48', '2019-06-18 05:10:57');
INSERT INTO `ltm_translations` VALUES (2076, 0, 'es', 'modules', 'payments.paypalStatus', 'Estado de Paypal', '2019-06-18 05:07:49', '2019-06-18 05:10:58');
INSERT INTO `ltm_translations` VALUES (2077, 0, 'es', 'modules', 'payments.markInvoicePaid', 'Marcar la factura pagada?', '2019-06-18 05:07:49', '2019-06-18 05:10:58');
INSERT INTO `ltm_translations` VALUES (2078, 0, 'es', 'modules', 'payments.stripeStatus', 'Estado de la raya', '2019-06-18 05:07:49', '2019-06-18 05:10:58');
INSERT INTO `ltm_translations` VALUES (2079, 0, 'es', 'modules', 'expenses.addExpense', 'Añadir gastos', '2019-06-18 05:07:49', '2019-06-18 05:10:58');
INSERT INTO `ltm_translations` VALUES (2080, 0, 'es', 'modules', 'expenses.itemName', 'Nombre del árticulo', '2019-06-18 05:07:49', '2019-06-18 05:10:58');
INSERT INTO `ltm_translations` VALUES (2081, 0, 'es', 'modules', 'expenses.purchaseDate', 'Fecha de compra', '2019-06-18 05:07:49', '2019-06-18 05:10:58');
INSERT INTO `ltm_translations` VALUES (2082, 0, 'es', 'modules', 'expenses.purchaseFrom', 'Comprado de', '2019-06-18 05:07:49', '2019-06-18 05:10:59');
INSERT INTO `ltm_translations` VALUES (2083, 0, 'es', 'modules', 'expenses.updateExpense', 'Actualizar gastos', '2019-06-18 05:07:49', '2019-06-18 05:10:59');
INSERT INTO `ltm_translations` VALUES (2084, 0, 'es', 'modules', 'invoiceSettings.invoicePrefix', 'Prefijo de factura', '2019-06-18 05:07:49', '2019-06-18 05:10:59');
INSERT INTO `ltm_translations` VALUES (2085, 0, 'es', 'modules', 'invoiceSettings.template', 'Modelo', '2019-06-18 05:07:49', '2019-06-18 05:10:59');
INSERT INTO `ltm_translations` VALUES (2086, 0, 'es', 'modules', 'invoiceSettings.dueAfter', 'Debido después', '2019-06-18 05:07:49', '2019-06-18 05:10:59');
INSERT INTO `ltm_translations` VALUES (2087, 0, 'es', 'modules', 'invoiceSettings.invoiceTerms', 'Términos de factura', '2019-06-18 05:07:50', '2019-06-18 05:10:59');
INSERT INTO `ltm_translations` VALUES (2088, 0, 'es', 'modules', 'invoiceSettings.updateTitle', 'Actualizar configuración de factura', '2019-06-18 05:07:50', '2019-06-18 05:10:59');
INSERT INTO `ltm_translations` VALUES (2089, 0, 'es', 'modules', 'slackSettings.updateTitle', 'Actualizar la configuración', '2019-06-18 05:07:50', '2019-06-18 05:11:00');
INSERT INTO `ltm_translations` VALUES (2090, 0, 'es', 'modules', 'slackSettings.uploadSlackLogo', 'Cargar el logotipo de notificación', '2019-06-18 05:07:50', '2019-06-18 05:11:00');
INSERT INTO `ltm_translations` VALUES (2091, 0, 'es', 'modules', 'slackSettings.notificationTitle', 'Establecer ajustes de notificación', '2019-06-18 05:07:50', '2019-06-18 05:11:00');
INSERT INTO `ltm_translations` VALUES (2092, 0, 'es', 'modules', 'slackSettings.notificationSubtitle', 'Seleccione los eventos para los que se debe enviar una notificación al usuario.', '2019-06-18 05:07:50', '2019-06-18 05:11:00');
INSERT INTO `ltm_translations` VALUES (2093, 0, 'es', 'modules', 'update.systemDetails', 'Detalles del sistema', '2019-06-18 05:07:50', '2019-06-18 05:11:00');
INSERT INTO `ltm_translations` VALUES (2094, 0, 'es', 'modules', 'update.updateTitle', 'Actualizar a la nueva versión', '2019-06-18 05:07:50', '2019-06-18 05:11:00');
INSERT INTO `ltm_translations` VALUES (2095, 0, 'es', 'modules', 'update.updateDatabase', 'Actualizar base de datos', '2019-06-18 05:07:51', '2019-06-18 05:11:00');
INSERT INTO `ltm_translations` VALUES (2096, 0, 'es', 'modules', 'update.fileReplaceAlert', 'Para actualizar la worksuite a la nueva versión, verifique la documentación de las instrucciones.', '2019-06-18 05:07:51', '2019-06-18 05:11:00');
INSERT INTO `ltm_translations` VALUES (2097, 0, 'es', 'modules', 'update.updateDatabaseButton', 'Haga clic para actualizar la base de datos', '2019-06-18 05:07:51', '2019-06-18 05:11:01');
INSERT INTO `ltm_translations` VALUES (2098, 0, 'es', 'modules', 'update.newUpdate', 'Nueva actualización disponible', '2019-06-18 05:07:51', '2019-06-18 05:11:01');
INSERT INTO `ltm_translations` VALUES (2099, 0, 'es', 'modules', 'update.updateNow', 'Actualizar ahora', '2019-06-18 05:07:51', '2019-06-18 05:11:01');
INSERT INTO `ltm_translations` VALUES (2100, 0, 'es', 'modules', 'update.updateAlternate', 'Si el botón Actualizar ahora no funciona, siga las instrucciones de actualización que se mencionan en la documentación.', '2019-06-18 05:07:51', '2019-06-18 05:11:01');
INSERT INTO `ltm_translations` VALUES (2101, 0, 'es', 'modules', 'incomeVsExpenseReport.totalIncome', 'Ingresos totales', '2019-06-18 05:07:51', '2019-06-18 05:11:01');
INSERT INTO `ltm_translations` VALUES (2102, 0, 'es', 'modules', 'incomeVsExpenseReport.totalExpense', 'Gasto total', '2019-06-18 05:07:51', '2019-06-18 05:11:02');
INSERT INTO `ltm_translations` VALUES (2103, 0, 'es', 'modules', 'incomeVsExpenseReport.chartTitle', 'Gráfico de barras', '2019-06-18 05:07:51', '2019-06-18 05:11:02');
INSERT INTO `ltm_translations` VALUES (2104, 0, 'es', 'modules', 'tickets.agents', 'Agents', '2019-06-18 05:07:51', '2019-06-18 05:11:02');
INSERT INTO `ltm_translations` VALUES (2105, 0, 'es', 'modules', 'tickets.assignGroup', 'Asignar grupo', '2019-06-18 05:07:52', '2019-06-18 05:11:02');
INSERT INTO `ltm_translations` VALUES (2106, 0, 'es', 'modules', 'tickets.chooseAgents', 'Elegir agentes', '2019-06-18 05:07:52', '2019-06-18 05:11:02');
INSERT INTO `ltm_translations` VALUES (2107, 0, 'es', 'modules', 'tickets.addGroup', 'Añadir grupo', '2019-06-18 05:07:52', '2019-06-18 05:11:02');
INSERT INTO `ltm_translations` VALUES (2108, 0, 'es', 'modules', 'tickets.group', 'Grupo', '2019-06-18 05:07:52', '2019-06-18 05:11:02');
INSERT INTO `ltm_translations` VALUES (2109, 0, 'es', 'modules', 'tickets.manageGroups', 'Administrar Grupos', '2019-06-18 05:07:52', '2019-06-18 05:11:03');
INSERT INTO `ltm_translations` VALUES (2110, 0, 'es', 'modules', 'tickets.groupName', 'Nombre del grupo', '2019-06-18 05:07:52', '2019-06-18 05:11:03');
INSERT INTO `ltm_translations` VALUES (2111, 0, 'es', 'modules', 'tickets.ticketType', 'Tipo de ticket', '2019-06-18 05:07:52', '2019-06-18 05:11:03');
INSERT INTO `ltm_translations` VALUES (2112, 0, 'es', 'modules', 'tickets.addType', 'Añadir Type', '2019-06-18 05:07:53', '2019-06-18 05:11:03');
INSERT INTO `ltm_translations` VALUES (2113, 0, 'es', 'modules', 'tickets.channelName', 'Nombre del Canal', '2019-06-18 05:07:53', '2019-06-18 05:11:04');
INSERT INTO `ltm_translations` VALUES (2114, 0, 'es', 'modules', 'tickets.template', 'Modelo', '2019-06-18 05:07:53', '2019-06-18 05:11:04');
INSERT INTO `ltm_translations` VALUES (2115, 0, 'es', 'modules', 'tickets.templateHeading', 'Encabezado de la plantilla', '2019-06-18 05:07:53', '2019-06-18 05:11:04');
INSERT INTO `ltm_translations` VALUES (2116, 0, 'es', 'modules', 'tickets.templateText', 'Texto de plantilla', '2019-06-18 05:07:53', '2019-06-18 05:11:04');
INSERT INTO `ltm_translations` VALUES (2117, 0, 'es', 'modules', 'tickets.addTicket', 'Añadir Ticket', '2019-06-18 05:07:53', '2019-06-18 05:11:04');
INSERT INTO `ltm_translations` VALUES (2118, 0, 'es', 'modules', 'tickets.ticket', 'Boleto', '2019-06-18 05:07:53', '2019-06-18 05:11:04');
INSERT INTO `ltm_translations` VALUES (2119, 0, 'es', 'modules', 'tickets.ticketSubject', 'Asunto del boleto', '2019-06-18 05:07:53', '2019-06-18 05:11:05');
INSERT INTO `ltm_translations` VALUES (2120, 0, 'es', 'modules', 'tickets.ticketDescription', 'Descripción del boleto', '2019-06-18 05:07:53', '2019-06-18 05:11:05');
INSERT INTO `ltm_translations` VALUES (2121, 0, 'es', 'modules', 'tickets.applyTemplate', 'Aplicar plantilla', '2019-06-18 05:07:54', '2019-06-18 05:11:05');
INSERT INTO `ltm_translations` VALUES (2122, 0, 'es', 'modules', 'tickets.agent', 'Agent', '2019-06-18 05:07:54', '2019-06-18 05:11:05');
INSERT INTO `ltm_translations` VALUES (2123, 0, 'es', 'modules', 'tickets.tags', 'Etiquetas', '2019-06-18 05:07:54', '2019-06-18 05:11:05');
INSERT INTO `ltm_translations` VALUES (2124, 0, 'es', 'modules', 'tickets.addChannel', 'Agregar canal', '2019-06-18 05:07:54', '2019-06-18 05:11:05');
INSERT INTO `ltm_translations` VALUES (2125, 0, 'es', 'modules', 'tickets.requesterName', 'Nombre del Solicitante', '2019-06-18 05:07:54', '2019-06-18 05:11:05');
INSERT INTO `ltm_translations` VALUES (2126, 0, 'es', 'modules', 'tickets.reply', 'respuesta', '2019-06-18 05:07:54', '2019-06-18 05:11:05');
INSERT INTO `ltm_translations` VALUES (2127, 0, 'es', 'modules', 'tickets.requestedOn', 'Solicitado', '2019-06-18 05:07:54', '2019-06-18 05:11:06');
INSERT INTO `ltm_translations` VALUES (2128, 0, 'es', 'modules', 'tickets.requestTicket', 'Solicitar boleto de soporte', '2019-06-18 05:07:55', '2019-06-18 05:11:06');
INSERT INTO `ltm_translations` VALUES (2129, 0, 'es', 'modules', 'tickets.closeTicket', 'Cerrar Ticket', '2019-06-18 05:07:55', '2019-06-18 05:11:06');
INSERT INTO `ltm_translations` VALUES (2130, 0, 'es', 'modules', 'tickets.goToAgentDashboard', 'Ir al panel de instrumentos del agente', '2019-06-18 05:07:55', '2019-06-18 05:11:06');
INSERT INTO `ltm_translations` VALUES (2131, 0, 'es', 'modules', 'tickets.reopenTicket', 'Reabrir boleto', '2019-06-18 05:07:55', '2019-06-18 05:11:06');
INSERT INTO `ltm_translations` VALUES (2132, 0, 'es', 'modules', 'tickets.totalTicketInfo', 'Nº de billetes nuevos creados para el periodo seleccionado.', '2019-06-18 05:07:55', '2019-06-18 05:11:06');
INSERT INTO `ltm_translations` VALUES (2133, 0, 'es', 'modules', 'tickets.closedTicketInfo', 'Nº de boletos que se cerraron en el rango de fechas seleccionado.', '2019-06-18 05:07:55', '2019-06-18 05:11:07');
INSERT INTO `ltm_translations` VALUES (2134, 0, 'es', 'modules', 'tickets.openTicketInfo', 'Número de boletos que aún no han sido asignados a ningún agente y actualizados en el rango de fechas seleccionado.', '2019-06-18 05:07:55', '2019-06-18 05:11:07');
INSERT INTO `ltm_translations` VALUES (2135, 0, 'es', 'modules', 'tickets.pendingTicketInfo', 'Número de tickets que se actualizaron en el intervalo de fechas seleccionado y que están asignados a un agente.', '2019-06-18 05:07:55', '2019-06-18 05:11:07');
INSERT INTO `ltm_translations` VALUES (2136, 0, 'es', 'modules', 'tickets.resolvedTicketInfo', 'Número de boletos que se resolvieron en el intervalo de fechas seleccionado pero que esperaban la confirmación del solicitante.', '2019-06-18 05:07:56', '2019-06-18 05:11:07');
INSERT INTO `ltm_translations` VALUES (2137, 0, 'es', 'modules', 'tickets.completedProjects', 'Proyectos completados', '2019-06-18 05:07:56', '2019-06-18 05:11:07');
INSERT INTO `ltm_translations` VALUES (2138, 0, 'es', 'modules', 'tickets.inProcessProjects', 'En Proyectos de Proceso', '2019-06-18 05:07:56', '2019-06-18 05:11:08');
INSERT INTO `ltm_translations` VALUES (2139, 0, 'es', 'modules', 'tickets.overDueProjects', 'Proyectos atrasados', '2019-06-18 05:07:56', '2019-06-18 05:11:08');
INSERT INTO `ltm_translations` VALUES (2140, 0, 'es', 'modules', 'tickets.totalClosedTickets', 'Entradas cerradas', '2019-06-18 05:07:57', '2019-06-18 05:11:08');
INSERT INTO `ltm_translations` VALUES (2141, 0, 'es', 'modules', 'tickets.totalOpenTickets', 'Entradas abiertas', '2019-06-18 05:07:57', '2019-06-18 05:11:08');
INSERT INTO `ltm_translations` VALUES (2142, 0, 'es', 'modules', 'tickets.totalPendingTickets', 'Boletos pendientes', '2019-06-18 05:07:57', '2019-06-18 05:11:08');
INSERT INTO `ltm_translations` VALUES (2143, 0, 'es', 'modules', 'tickets.totalResolvedTickets', 'Boletos resueltos', '2019-06-18 05:07:57', '2019-06-18 05:11:08');
INSERT INTO `ltm_translations` VALUES (2144, 0, 'es', 'modules', 'tickets.totalTickets', 'Boletos totales', '2019-06-18 05:07:57', '2019-06-18 05:11:08');
INSERT INTO `ltm_translations` VALUES (2145, 0, 'es', 'modules', 'tickets.totalUnresolvedTickets', 'Boletos sin resolver', '2019-06-18 05:07:57', '2019-06-18 05:11:09');
INSERT INTO `ltm_translations` VALUES (2146, 0, 'es', 'modules', 'tickets.ticketTrendGraph', 'Gráfico de tendencia de ticket', '2019-06-18 05:07:57', '2019-06-18 05:11:09');
INSERT INTO `ltm_translations` VALUES (2147, 0, 'es', 'modules', 'tickets.urgent', 'urgente', '2019-06-18 05:07:57', '2019-06-18 05:11:09');
INSERT INTO `ltm_translations` VALUES (2148, 0, 'es', 'modules', 'tickets.nofilter', 'Sin filtro', '2019-06-18 05:07:58', '2019-06-18 05:11:09');
INSERT INTO `ltm_translations` VALUES (2149, 0, 'es', 'modules', 'attendance.officeStartTime', 'Hora de inicio de Office', '2019-06-18 05:07:58', '2019-06-18 05:11:10');
INSERT INTO `ltm_translations` VALUES (2150, 0, 'es', 'modules', 'attendance.allowSelfClock', 'Permitido Employee auto Clock-In / Clock-Out', '2019-06-18 05:07:58', '2019-06-18 05:11:10');
INSERT INTO `ltm_translations` VALUES (2151, 0, 'es', 'modules', 'attendance.lateMark', 'Marca tardía después (minutos)', '2019-06-18 05:07:58', '2019-06-18 05:11:10');
INSERT INTO `ltm_translations` VALUES (2152, 0, 'es', 'modules', 'attendance.officeEndTime', 'Hora de finalización de Office', '2019-06-18 05:07:58', '2019-06-18 05:11:10');
INSERT INTO `ltm_translations` VALUES (2153, 0, 'es', 'modules', 'attendance.markAttendance', 'Marcar Asistencia', '2019-06-18 05:07:59', '2019-06-18 05:11:10');
INSERT INTO `ltm_translations` VALUES (2154, 0, 'es', 'modules', 'attendance.clock_in', 'Reloj en', '2019-06-18 05:07:59', '2019-06-18 05:11:10');
INSERT INTO `ltm_translations` VALUES (2155, 0, 'es', 'modules', 'attendance.late', 'tarde', '2019-06-18 05:07:59', '2019-06-18 05:11:10');
INSERT INTO `ltm_translations` VALUES (2156, 0, 'es', 'modules', 'attendance.clock_out', 'Clock Out', '2019-06-18 05:07:59', '2019-06-18 05:11:11');
INSERT INTO `ltm_translations` VALUES (2157, 0, 'es', 'modules', 'attendance.halfDay', 'Medio día', '2019-06-18 05:07:59', '2019-06-18 05:11:11');
INSERT INTO `ltm_translations` VALUES (2158, 0, 'es', 'modules', 'attendance.working_from', 'Trabajando desde', '2019-06-18 05:07:59', '2019-06-18 05:11:11');
INSERT INTO `ltm_translations` VALUES (2159, 0, 'es', 'modules', 'attendance.officeOpenDays', 'Office se abre en', '2019-06-18 05:07:59', '2019-06-18 05:11:11');
INSERT INTO `ltm_translations` VALUES (2160, 0, 'es', 'modules', 'attendance.totalWorkingDays', 'Días de trabajo totales', '2019-06-18 05:08:00', '2019-06-18 05:11:11');
INSERT INTO `ltm_translations` VALUES (2161, 0, 'es', 'modules', 'attendance.daysPresent', 'Días presentes', '2019-06-18 05:08:00', '2019-06-18 05:11:11');
INSERT INTO `ltm_translations` VALUES (2162, 0, 'es', 'modules', 'attendance.absent', 'ausente', '2019-06-18 05:08:00', '2019-06-18 05:11:11');
INSERT INTO `ltm_translations` VALUES (2163, 0, 'es', 'modules', 'attendance.present', '¡Presente!', '2019-06-18 05:08:01', '2019-06-18 05:11:11');
INSERT INTO `ltm_translations` VALUES (2164, 0, 'es', 'modules', 'attendance.currentTime', 'Hora actual', '2019-06-18 05:08:01', '2019-06-18 05:11:12');
INSERT INTO `ltm_translations` VALUES (2165, 0, 'es', 'modules', 'attendance.attendanceByDate', 'Asistencia por fecha', '2019-06-18 05:08:01', '2019-06-18 05:11:12');
INSERT INTO `ltm_translations` VALUES (2166, 0, 'es', 'modules', 'attendance.attendanceByMember', 'Asistencia por miembro', '2019-06-18 05:08:01', '2019-06-18 05:11:12');
INSERT INTO `ltm_translations` VALUES (2167, 0, 'es', 'modules', 'taskDetail', 'Detalle de la tarea', '2019-06-18 05:08:01', '2019-06-18 05:11:12');
INSERT INTO `ltm_translations` VALUES (2168, 0, 'es', 'modules', 'customFields.addField', 'Agregue campo', '2019-06-18 05:08:01', '2019-06-18 05:11:12');
INSERT INTO `ltm_translations` VALUES (2169, 0, 'es', 'modules', 'events.addEvent', 'Añadir evento', '2019-06-18 05:08:01', '2019-06-18 05:11:12');
INSERT INTO `ltm_translations` VALUES (2170, 0, 'es', 'modules', 'events.eventName', 'Nombre del evento', '2019-06-18 05:08:02', '2019-06-18 05:11:12');
INSERT INTO `ltm_translations` VALUES (2171, 0, 'es', 'modules', 'events.addAttendees', 'Agregar asistentes', '2019-06-18 05:08:02', '2019-06-18 05:11:13');
INSERT INTO `ltm_translations` VALUES (2172, 0, 'es', 'modules', 'events.endOn', 'Finaliza', '2019-06-18 05:08:02', '2019-06-18 05:11:13');
INSERT INTO `ltm_translations` VALUES (2173, 0, 'es', 'modules', 'events.startOn', 'Comienza en', '2019-06-18 05:08:02', '2019-06-18 05:11:13');
INSERT INTO `ltm_translations` VALUES (2174, 0, 'es', 'modules', 'events.allEmployees', 'Todos los empleados', '2019-06-18 05:08:02', '2019-06-18 05:11:13');
INSERT INTO `ltm_translations` VALUES (2175, 0, 'es', 'modules', 'events.repeat', 'repetir', '2019-06-18 05:08:02', '2019-06-18 05:11:13');
INSERT INTO `ltm_translations` VALUES (2176, 0, 'es', 'modules', 'events.repeatEvery', 'Repite cada', '2019-06-18 05:08:02', '2019-06-18 05:11:13');
INSERT INTO `ltm_translations` VALUES (2177, 0, 'es', 'modules', 'events.cyclesToolTip', 'Recurrente se detendrá después del número de ciclos. Manténgalo en blanco para el infinito.', '2019-06-18 05:08:03', '2019-06-18 05:11:14');
INSERT INTO `ltm_translations` VALUES (2178, 0, 'es', 'modules', 'events.viewAttendees', 'Ver asistentes', '2019-06-18 05:08:03', '2019-06-18 05:11:14');
INSERT INTO `ltm_translations` VALUES (2179, 0, 'es', 'modules', 'payroll.addPayroll', 'Agregar nómina', '2019-06-18 05:08:03', '2019-06-18 05:11:14');
INSERT INTO `ltm_translations` VALUES (2180, 0, 'es', 'modules', 'payroll.amountPaid', 'Cantidad pagada', '2019-06-18 05:08:03', '2019-06-18 05:11:14');
INSERT INTO `ltm_translations` VALUES (2181, 0, 'es', 'modules', 'payroll.updatePayroll', 'Actualizar nómina', '2019-06-18 05:08:03', '2019-06-18 05:11:14');
INSERT INTO `ltm_translations` VALUES (2182, 0, 'es', 'modules', 'payroll.projectPayrollReport', 'Informe de nómina del proyecto', '2019-06-18 05:08:03', '2019-06-18 05:11:15');
INSERT INTO `ltm_translations` VALUES (2183, 0, 'es', 'modules', 'payroll.totalEarning', 'Ganancia total', '2019-06-18 05:08:04', '2019-06-18 05:11:15');
INSERT INTO `ltm_translations` VALUES (2184, 0, 'es', 'modules', 'roles.addRole', 'Administrar rol', '2019-06-18 05:08:04', '2019-06-18 05:11:15');
INSERT INTO `ltm_translations` VALUES (2185, 0, 'es', 'modules', 'permission.projectNote', 'El usuario puede ver los detalles básicos de los proyectos asignados a él, incluso sin ningún permiso.', '2019-06-18 05:08:04', '2019-06-18 05:11:15');
INSERT INTO `ltm_translations` VALUES (2186, 0, 'es', 'modules', 'permission.attendanceNote', 'El usuario puede ver su propia asistencia incluso sin ningún permiso.', '2019-06-18 05:08:04', '2019-06-18 05:11:15');
INSERT INTO `ltm_translations` VALUES (2187, 0, 'es', 'modules', 'permission.taskNote', 'El usuario puede ver las tareas asignadas incluso sin ningún permiso.', '2019-06-18 05:08:04', '2019-06-18 05:11:16');
INSERT INTO `ltm_translations` VALUES (2188, 0, 'es', 'modules', 'permission.ticketNote', 'El usuario puede ver los tickets generados por él como predeterminados, incluso sin ningún permiso.', '2019-06-18 05:08:04', '2019-06-18 05:11:16');
INSERT INTO `ltm_translations` VALUES (2189, 0, 'es', 'modules', 'permission.eventNote', 'El usuario puede ver los eventos a los que asistirá como predeterminado, incluso sin ningún permiso.', '2019-06-18 05:08:04', '2019-06-18 05:11:16');
INSERT INTO `ltm_translations` VALUES (2190, 0, 'es', 'modules', 'permission.selectAll', 'Seleccionar todo', '2019-06-18 05:08:04', '2019-06-18 05:11:16');
INSERT INTO `ltm_translations` VALUES (2191, 0, 'es', 'modules', 'permission.addRoleMember', 'Administrar miembros de roles', '2019-06-18 05:08:05', '2019-06-18 05:11:16');
INSERT INTO `ltm_translations` VALUES (2192, 0, 'es', 'modules', 'permission.addMembers', 'Añadir miembros', '2019-06-18 05:08:05', '2019-06-18 05:11:16');
INSERT INTO `ltm_translations` VALUES (2193, 0, 'es', 'modules', 'permission.roleName', 'Nombre de rol', '2019-06-18 05:08:05', '2019-06-18 05:11:16');
INSERT INTO `ltm_translations` VALUES (2194, 0, 'es', 'modules', 'leaves.assignLeave', 'Asignar licencia', '2019-06-18 05:08:05', '2019-06-18 05:11:16');
INSERT INTO `ltm_translations` VALUES (2195, 0, 'es', 'modules', 'leaves.addLeaveType', 'Agregar tipo de licencia', '2019-06-18 05:08:05', '2019-06-18 05:11:16');
INSERT INTO `ltm_translations` VALUES (2196, 0, 'es', 'modules', 'leaves.leaveType', 'Tipo de licencia', '2019-06-18 05:08:06', '2019-06-18 05:11:17');
INSERT INTO `ltm_translations` VALUES (2197, 0, 'es', 'modules', 'leaves.selectDuration', 'Seleccionar duración', '2019-06-18 05:08:06', '2019-06-18 05:11:17');
INSERT INTO `ltm_translations` VALUES (2198, 0, 'es', 'modules', 'leaves.halfDay', 'Medio día', '2019-06-18 05:08:06', '2019-06-18 05:11:17');
INSERT INTO `ltm_translations` VALUES (2199, 0, 'es', 'modules', 'leaves.hours', 'horas', '2019-06-18 05:08:06', '2019-06-18 05:11:17');
INSERT INTO `ltm_translations` VALUES (2200, 0, 'es', 'modules', 'leaves.multiple', 'múltiplo', '2019-06-18 05:08:06', '2019-06-18 05:11:22');
INSERT INTO `ltm_translations` VALUES (2201, 1, 'es', 'modules', 'leaves.single', 'único', '2019-06-18 05:08:07', '2019-06-18 05:08:07');
INSERT INTO `ltm_translations` VALUES (2202, 1, 'es', 'modules', 'leaves.selectDates', 'Seleccionar fechas', '2019-06-18 05:08:07', '2019-06-18 05:08:07');
INSERT INTO `ltm_translations` VALUES (2203, 1, 'es', 'modules', 'leaves.reason', 'Motivo de la ausencia', '2019-06-18 05:08:07', '2019-06-18 05:08:07');
INSERT INTO `ltm_translations` VALUES (2204, 1, 'es', 'modules', 'leaves.applicantName', 'Nombre del solicitante', '2019-06-18 05:08:08', '2019-06-18 05:08:08');
INSERT INTO `ltm_translations` VALUES (2205, 1, 'es', 'modules', 'leaves.updateLeave', 'Actualizar licencia', '2019-06-18 05:08:08', '2019-06-18 05:08:08');
INSERT INTO `ltm_translations` VALUES (2206, 1, 'es', 'modules', 'leaves.pendingLeaves', 'Hojas pendientes', '2019-06-18 05:08:08', '2019-06-18 05:08:08');
INSERT INTO `ltm_translations` VALUES (2207, 1, 'es', 'modules', 'leaves.applyLeave', 'Aplicar licencia', '2019-06-18 05:08:08', '2019-06-18 05:08:08');
INSERT INTO `ltm_translations` VALUES (2208, 1, 'es', 'modules', 'leaves.noOfLeaves', 'No de hojas', '2019-06-18 05:08:08', '2019-06-18 05:08:08');
INSERT INTO `ltm_translations` VALUES (2209, 1, 'es', 'modules', 'leaves.countLeavesFromDateOfJoining', 'Contar desde la fecha de ingreso', '2019-06-18 05:08:09', '2019-06-18 05:08:09');
INSERT INTO `ltm_translations` VALUES (2210, 1, 'es', 'modules', 'leaves.countLeavesFromStartOfYear', 'El conteo deja desde el comienzo del año', '2019-06-18 05:08:09', '2019-06-18 05:08:09');
INSERT INTO `ltm_translations` VALUES (2211, 1, 'es', 'modules', 'leaves.remainingLeaves', 'Hojas restantes', '2019-06-18 05:08:09', '2019-06-18 05:08:09');
INSERT INTO `ltm_translations` VALUES (2212, 1, 'es', 'modules', 'leaves.leavesTaken', 'Hojas tomadas', '2019-06-18 05:08:09', '2019-06-18 05:08:09');
INSERT INTO `ltm_translations` VALUES (2213, 1, 'es', 'pagination', 'previous', '&laquo; Anterior', '2019-06-18 05:08:09', '2019-06-18 05:08:09');
INSERT INTO `ltm_translations` VALUES (2214, 1, 'es', 'pagination', 'next', 'Siguiente &raquo;', '2019-06-18 05:08:10', '2019-06-18 05:08:10');
INSERT INTO `ltm_translations` VALUES (2215, 1, 'es', 'passwords', 'password', 'Las contraseñas deben coincidir y contener al menos 6 caracteres', '2019-06-18 05:08:10', '2019-06-18 05:08:10');
INSERT INTO `ltm_translations` VALUES (2216, 1, 'es', 'passwords', 'reset', '¡Tu contraseña ha sido restablecida!', '2019-06-18 05:08:10', '2019-06-18 05:08:10');
INSERT INTO `ltm_translations` VALUES (2217, 1, 'es', 'passwords', 'sent', '¡Te hemos enviado por correo el enlace para restablecer tu contraseña!', '2019-06-18 05:08:10', '2019-06-18 05:08:10');
INSERT INTO `ltm_translations` VALUES (2218, 1, 'es', 'passwords', 'token', 'El token de recuperación de contraseña es inválido.', '2019-06-18 05:08:11', '2019-06-18 05:08:11');
INSERT INTO `ltm_translations` VALUES (2219, 1, 'es', 'passwords', 'user', 'No podemos encontrar ningún usuario con ese correo electrónico.', '2019-06-18 05:08:11', '2019-06-18 05:08:11');
INSERT INTO `ltm_translations` VALUES (2220, 1, 'es', 'validation', 'accepted', ':attribute debe ser aceptado.', '2019-06-18 05:08:11', '2019-06-18 05:08:11');
INSERT INTO `ltm_translations` VALUES (2221, 1, 'es', 'validation', 'active_url', ':attribute no es una URL válida.', '2019-06-18 05:08:11', '2019-06-18 05:08:11');
INSERT INTO `ltm_translations` VALUES (2222, 1, 'es', 'validation', 'after', ':attribute debe ser una fecha posterior a :date.', '2019-06-18 05:08:11', '2019-06-18 05:08:11');
INSERT INTO `ltm_translations` VALUES (2223, 1, 'es', 'validation', 'after_or_equal', ':attribute debe ser una fecha posterior o igual a :date.', '2019-06-18 05:08:11', '2019-06-18 05:08:11');
INSERT INTO `ltm_translations` VALUES (2224, 1, 'es', 'validation', 'alpha', ':attribute sólo debe contener letras.', '2019-06-18 05:08:11', '2019-06-18 05:08:11');
INSERT INTO `ltm_translations` VALUES (2225, 1, 'es', 'validation', 'alpha_dash', ':attribute sólo debe contener letras, números y guiones.', '2019-06-18 05:08:12', '2019-06-18 05:08:12');
INSERT INTO `ltm_translations` VALUES (2226, 1, 'es', 'validation', 'alpha_num', ':attribute sólo debe contener letras y números.', '2019-06-18 05:08:12', '2019-06-18 05:08:12');
INSERT INTO `ltm_translations` VALUES (2227, 1, 'es', 'validation', 'array', ':attribute debe ser un conjunto.', '2019-06-18 05:08:12', '2019-06-18 05:08:12');
INSERT INTO `ltm_translations` VALUES (2228, 1, 'es', 'validation', 'before', ':attribute debe ser una fecha anterior a :date.', '2019-06-18 05:08:12', '2019-06-18 05:08:12');
INSERT INTO `ltm_translations` VALUES (2229, 1, 'es', 'validation', 'before_or_equal', ':attribute debe ser una fecha anterior o igual a :date.', '2019-06-18 05:08:12', '2019-06-18 05:08:12');
INSERT INTO `ltm_translations` VALUES (2230, 1, 'es', 'validation', 'between.numeric', ':attribute tiene que estar entre :min - :max.', '2019-06-18 05:08:12', '2019-06-18 05:08:12');
INSERT INTO `ltm_translations` VALUES (2231, 1, 'es', 'validation', 'between.file', ':attribute debe pesar entre :min - :max kilobytes.', '2019-06-18 05:08:13', '2019-06-18 05:08:13');
INSERT INTO `ltm_translations` VALUES (2232, 1, 'es', 'validation', 'between.string', ':attribute tiene que tener entre :min - :max caracteres.', '2019-06-18 05:08:13', '2019-06-18 05:08:13');
INSERT INTO `ltm_translations` VALUES (2233, 1, 'es', 'validation', 'between.array', ':attribute tiene que tener entre :min - :max ítems.', '2019-06-18 05:08:13', '2019-06-18 05:08:13');
INSERT INTO `ltm_translations` VALUES (2234, 1, 'es', 'validation', 'boolean', 'El campo :attribute debe tener un valor verdadero o falso.', '2019-06-18 05:08:13', '2019-06-18 05:08:13');
INSERT INTO `ltm_translations` VALUES (2235, 1, 'es', 'validation', 'confirmed', 'La confirmación de :attribute no coincide.', '2019-06-18 05:08:13', '2019-06-18 05:08:13');
INSERT INTO `ltm_translations` VALUES (2236, 1, 'es', 'validation', 'date', ':attribute no es una fecha válida.', '2019-06-18 05:08:13', '2019-06-18 05:08:13');
INSERT INTO `ltm_translations` VALUES (2237, 1, 'es', 'validation', 'date_format', ':attribute no corresponde al formato :format.', '2019-06-18 05:08:13', '2019-06-18 05:08:13');
INSERT INTO `ltm_translations` VALUES (2238, 1, 'es', 'validation', 'different', ':attribute y :other deben ser diferentes.', '2019-06-18 05:08:14', '2019-06-18 05:08:14');
INSERT INTO `ltm_translations` VALUES (2239, 1, 'es', 'validation', 'digits', ':attribute debe tener :digits dígitos.', '2019-06-18 05:08:14', '2019-06-18 05:08:14');
INSERT INTO `ltm_translations` VALUES (2240, 1, 'es', 'validation', 'digits_between', ':attribute debe tener entre :min y :max dígitos.', '2019-06-18 05:08:14', '2019-06-18 05:08:14');
INSERT INTO `ltm_translations` VALUES (2241, 1, 'es', 'validation', 'dimensions', 'Las dimensiones de la imagen :attribute no son válidas.', '2019-06-18 05:08:14', '2019-06-18 05:08:14');
INSERT INTO `ltm_translations` VALUES (2242, 1, 'es', 'validation', 'distinct', 'El campo :attribute contiene un valor duplicado.', '2019-06-18 05:08:15', '2019-06-18 05:08:15');
INSERT INTO `ltm_translations` VALUES (2243, 1, 'es', 'validation', 'email', ':attribute no es un correo válido', '2019-06-18 05:08:15', '2019-06-18 05:08:15');
INSERT INTO `ltm_translations` VALUES (2244, 1, 'es', 'validation', 'exists', ':attribute es inválido.', '2019-06-18 05:08:15', '2019-06-18 05:08:15');
INSERT INTO `ltm_translations` VALUES (2245, 1, 'es', 'validation', 'file', 'El campo :attribute debe ser un archivo.', '2019-06-18 05:08:15', '2019-06-18 05:08:15');
INSERT INTO `ltm_translations` VALUES (2246, 1, 'es', 'validation', 'filled', 'El campo :attribute es obligatorio.', '2019-06-18 05:08:15', '2019-06-18 05:08:15');
INSERT INTO `ltm_translations` VALUES (2247, 1, 'es', 'validation', 'image', ':attribute debe ser una imagen.', '2019-06-18 05:08:16', '2019-06-18 05:08:16');
INSERT INTO `ltm_translations` VALUES (2248, 1, 'es', 'validation', 'in', ':attribute es inválido.', '2019-06-18 05:08:16', '2019-06-18 05:08:16');
INSERT INTO `ltm_translations` VALUES (2249, 1, 'es', 'validation', 'in_array', 'El campo :attribute no existe en :other.', '2019-06-18 05:08:16', '2019-06-18 05:08:16');
INSERT INTO `ltm_translations` VALUES (2250, 1, 'es', 'validation', 'integer', ':attribute debe ser un número entero.', '2019-06-18 05:08:16', '2019-06-18 05:08:16');
INSERT INTO `ltm_translations` VALUES (2251, 1, 'es', 'validation', 'ip', ':attribute debe ser una dirección IP válida.', '2019-06-18 05:08:16', '2019-06-18 05:08:16');
INSERT INTO `ltm_translations` VALUES (2252, 1, 'es', 'validation', 'ipv4', ':attribute debe ser un dirección IPv4 válida', '2019-06-18 05:08:16', '2019-06-18 05:08:16');
INSERT INTO `ltm_translations` VALUES (2253, 1, 'es', 'validation', 'ipv6', ':attribute debe ser un dirección IPv6 válida.', '2019-06-18 05:08:16', '2019-06-18 05:08:16');
INSERT INTO `ltm_translations` VALUES (2254, 1, 'es', 'validation', 'json', 'El campo :attribute debe tener una cadena JSON válida.', '2019-06-18 05:08:16', '2019-06-18 05:08:16');
INSERT INTO `ltm_translations` VALUES (2255, 1, 'es', 'validation', 'max.numeric', ':attribute no debe ser mayor a :max.', '2019-06-18 05:08:17', '2019-06-18 05:08:17');
INSERT INTO `ltm_translations` VALUES (2256, 1, 'es', 'validation', 'max.file', ':attribute no debe ser mayor que :max kilobytes.', '2019-06-18 05:08:17', '2019-06-18 05:08:17');
INSERT INTO `ltm_translations` VALUES (2257, 1, 'es', 'validation', 'max.string', ':attribute no debe ser mayor que :max caracteres.', '2019-06-18 05:08:18', '2019-06-18 05:08:18');
INSERT INTO `ltm_translations` VALUES (2258, 1, 'es', 'validation', 'max.array', ':attribute no debe tener más de :max elementos.', '2019-06-18 05:08:18', '2019-06-18 05:08:18');
INSERT INTO `ltm_translations` VALUES (2259, 1, 'es', 'validation', 'mimes', ':attribute debe ser un archivo con formato: :values.', '2019-06-18 05:08:18', '2019-06-18 05:08:18');
INSERT INTO `ltm_translations` VALUES (2260, 1, 'es', 'validation', 'mimetypes', ':attribute debe ser un archivo con formato: :values.', '2019-06-18 05:08:18', '2019-06-18 05:08:18');
INSERT INTO `ltm_translations` VALUES (2261, 1, 'es', 'validation', 'min.numeric', 'El tamaño de :attribute debe ser de al menos :min.', '2019-06-18 05:08:18', '2019-06-18 05:08:18');
INSERT INTO `ltm_translations` VALUES (2262, 1, 'es', 'validation', 'min.file', 'El tamaño de :attribute debe ser de al menos :min kilobytes.', '2019-06-18 05:08:18', '2019-06-18 05:08:18');
INSERT INTO `ltm_translations` VALUES (2263, 1, 'es', 'validation', 'min.string', ':attribute debe contener al menos :min caracteres.', '2019-06-18 05:08:18', '2019-06-18 05:08:18');
INSERT INTO `ltm_translations` VALUES (2264, 1, 'es', 'validation', 'min.array', ':attribute debe tener al menos :min elementos.', '2019-06-18 05:08:19', '2019-06-18 05:08:19');
INSERT INTO `ltm_translations` VALUES (2265, 1, 'es', 'validation', 'not_in', ':attribute es inválido.', '2019-06-18 05:08:19', '2019-06-18 05:08:19');
INSERT INTO `ltm_translations` VALUES (2266, 1, 'es', 'validation', 'numeric', ':attribute debe ser numérico.', '2019-06-18 05:08:19', '2019-06-18 05:08:19');
INSERT INTO `ltm_translations` VALUES (2267, 1, 'es', 'validation', 'present', 'El campo :attribute debe estar presente.', '2019-06-18 05:08:19', '2019-06-18 05:08:19');
INSERT INTO `ltm_translations` VALUES (2268, 1, 'es', 'validation', 'regex', 'El formato de :attribute es inválido.', '2019-06-18 05:08:19', '2019-06-18 05:08:19');
INSERT INTO `ltm_translations` VALUES (2269, 1, 'es', 'validation', 'required', 'El campo :attribute es obligatorio.', '2019-06-18 05:08:19', '2019-06-18 05:08:19');
INSERT INTO `ltm_translations` VALUES (2270, 1, 'es', 'validation', 'required_if', 'El campo :attribute es obligatorio cuando :other es :value.', '2019-06-18 05:08:19', '2019-06-18 05:08:19');
INSERT INTO `ltm_translations` VALUES (2271, 1, 'es', 'validation', 'required_unless', 'El campo :attribute es obligatorio a menos que :other esté en :values.', '2019-06-18 05:08:20', '2019-06-18 05:08:20');
INSERT INTO `ltm_translations` VALUES (2272, 1, 'es', 'validation', 'required_with', 'El campo :attribute es obligatorio cuando :values está presente.', '2019-06-18 05:08:20', '2019-06-18 05:08:20');
INSERT INTO `ltm_translations` VALUES (2273, 1, 'es', 'validation', 'required_with_all', 'El campo :attribute es obligatorio cuando :values está presente.', '2019-06-18 05:08:20', '2019-06-18 05:08:20');
INSERT INTO `ltm_translations` VALUES (2274, 1, 'es', 'validation', 'required_without', 'El campo :attribute es obligatorio cuando :values no está presente.', '2019-06-18 05:08:20', '2019-06-18 05:08:20');
INSERT INTO `ltm_translations` VALUES (2275, 1, 'es', 'validation', 'required_without_all', 'El campo :attribute es obligatorio cuando ninguno de :values estén presentes.', '2019-06-18 05:08:20', '2019-06-18 05:08:20');
INSERT INTO `ltm_translations` VALUES (2276, 1, 'es', 'validation', 'same', ':attribute y :other deben coincidir.', '2019-06-18 05:08:20', '2019-06-18 05:08:20');
INSERT INTO `ltm_translations` VALUES (2277, 1, 'es', 'validation', 'size.numeric', 'El tamaño de :attribute debe ser :size.', '2019-06-18 05:08:21', '2019-06-18 05:08:21');
INSERT INTO `ltm_translations` VALUES (2278, 1, 'es', 'validation', 'size.file', 'El tamaño de :attribute debe ser :size kilobytes.', '2019-06-18 05:08:21', '2019-06-18 05:08:21');
INSERT INTO `ltm_translations` VALUES (2279, 1, 'es', 'validation', 'size.string', ':attribute debe contener :size caracteres.', '2019-06-18 05:08:21', '2019-06-18 05:08:21');
INSERT INTO `ltm_translations` VALUES (2280, 1, 'es', 'validation', 'size.array', ':attribute debe contener :size elementos.', '2019-06-18 05:08:21', '2019-06-18 05:08:21');
INSERT INTO `ltm_translations` VALUES (2281, 1, 'es', 'validation', 'string', 'El campo :attribute debe ser una cadena de caracteres.', '2019-06-18 05:08:21', '2019-06-18 05:08:21');
INSERT INTO `ltm_translations` VALUES (2282, 1, 'es', 'validation', 'timezone', 'El :attribute debe ser una zona válida.', '2019-06-18 05:08:21', '2019-06-18 05:08:21');
INSERT INTO `ltm_translations` VALUES (2283, 1, 'es', 'validation', 'unique', ':attribute ya ha sido registrado.', '2019-06-18 05:08:21', '2019-06-18 05:08:21');
INSERT INTO `ltm_translations` VALUES (2284, 1, 'es', 'validation', 'uploaded', 'Subir :attribute ha fallado.', '2019-06-18 05:08:21', '2019-06-18 05:08:21');
INSERT INTO `ltm_translations` VALUES (2285, 1, 'es', 'validation', 'url', 'El formato :attribute es inválido.', '2019-06-18 05:08:22', '2019-06-18 05:08:22');
INSERT INTO `ltm_translations` VALUES (2286, 1, 'es', 'validation', 'custom.password.min', 'La :attribute debe contener más de :min caracteres', '2019-06-18 05:08:22', '2019-06-18 05:08:22');
INSERT INTO `ltm_translations` VALUES (2287, 1, 'es', 'validation', 'custom.email.unique', 'El :attribute ya ha sido registrado.', '2019-06-18 05:08:22', '2019-06-18 05:08:22');
INSERT INTO `ltm_translations` VALUES (2288, 1, 'es', 'validation', 'attributes.name', 'nombre', '2019-06-18 05:08:22', '2019-06-18 05:08:22');
INSERT INTO `ltm_translations` VALUES (2289, 1, 'es', 'validation', 'attributes.username', 'usuario', '2019-06-18 05:08:22', '2019-06-18 05:08:22');
INSERT INTO `ltm_translations` VALUES (2290, 1, 'es', 'validation', 'attributes.email', 'correo electrónico', '2019-06-18 05:08:22', '2019-06-18 05:08:22');
INSERT INTO `ltm_translations` VALUES (2291, 1, 'es', 'validation', 'attributes.first_name', 'nombre', '2019-06-18 05:08:23', '2019-06-18 05:08:23');
INSERT INTO `ltm_translations` VALUES (2292, 1, 'es', 'validation', 'attributes.last_name', 'apellido', '2019-06-18 05:08:23', '2019-06-18 05:08:23');
INSERT INTO `ltm_translations` VALUES (2293, 1, 'es', 'validation', 'attributes.password', 'contraseña', '2019-06-18 05:08:23', '2019-06-18 05:08:23');
INSERT INTO `ltm_translations` VALUES (2294, 1, 'es', 'validation', 'attributes.password_confirmation', 'confirmación de la contraseña', '2019-06-18 05:08:23', '2019-06-18 05:08:23');
INSERT INTO `ltm_translations` VALUES (2295, 1, 'es', 'validation', 'attributes.city', 'ciudad', '2019-06-18 05:08:23', '2019-06-18 05:08:23');
INSERT INTO `ltm_translations` VALUES (2296, 1, 'es', 'validation', 'attributes.country', 'país', '2019-06-18 05:08:23', '2019-06-18 05:08:23');
INSERT INTO `ltm_translations` VALUES (2297, 1, 'es', 'validation', 'attributes.address', 'dirección', '2019-06-18 05:08:23', '2019-06-18 05:08:23');
INSERT INTO `ltm_translations` VALUES (2298, 1, 'es', 'validation', 'attributes.phone', 'teléfono', '2019-06-18 05:08:23', '2019-06-18 05:08:23');
INSERT INTO `ltm_translations` VALUES (2299, 1, 'es', 'validation', 'attributes.mobile', 'móvil', '2019-06-18 05:08:24', '2019-06-18 05:08:24');
INSERT INTO `ltm_translations` VALUES (2300, 1, 'es', 'validation', 'attributes.age', 'edad', '2019-06-18 05:08:24', '2019-06-18 05:08:24');
INSERT INTO `ltm_translations` VALUES (2301, 1, 'es', 'validation', 'attributes.sex', 'sexo', '2019-06-18 05:08:24', '2019-06-18 05:08:24');
INSERT INTO `ltm_translations` VALUES (2302, 1, 'es', 'validation', 'attributes.gender', 'género', '2019-06-18 05:08:24', '2019-06-18 05:08:24');
INSERT INTO `ltm_translations` VALUES (2303, 1, 'es', 'validation', 'attributes.year', 'año', '2019-06-18 05:08:24', '2019-06-18 05:08:24');
INSERT INTO `ltm_translations` VALUES (2304, 1, 'es', 'validation', 'attributes.month', 'mes', '2019-06-18 05:08:24', '2019-06-18 05:08:24');
INSERT INTO `ltm_translations` VALUES (2305, 1, 'es', 'validation', 'attributes.day', 'día', '2019-06-18 05:08:24', '2019-06-18 05:08:24');
INSERT INTO `ltm_translations` VALUES (2306, 1, 'es', 'validation', 'attributes.hour', 'hora', '2019-06-18 05:08:24', '2019-06-18 05:08:24');
INSERT INTO `ltm_translations` VALUES (2307, 1, 'es', 'validation', 'attributes.minute', 'minuto', '2019-06-18 05:08:25', '2019-06-18 05:08:25');
INSERT INTO `ltm_translations` VALUES (2308, 1, 'es', 'validation', 'attributes.second', 'segundo', '2019-06-18 05:08:25', '2019-06-18 05:08:25');
INSERT INTO `ltm_translations` VALUES (2309, 1, 'es', 'validation', 'attributes.title', 'título', '2019-06-18 05:08:25', '2019-06-18 05:08:25');
INSERT INTO `ltm_translations` VALUES (2310, 1, 'es', 'validation', 'attributes.body', 'contenido', '2019-06-18 05:08:25', '2019-06-18 05:08:25');
INSERT INTO `ltm_translations` VALUES (2311, 1, 'es', 'validation', 'attributes.description', 'descripción', '2019-06-18 05:08:25', '2019-06-18 05:08:25');
INSERT INTO `ltm_translations` VALUES (2312, 1, 'es', 'validation', 'attributes.excerpt', 'extracto', '2019-06-18 05:08:25', '2019-06-18 05:08:25');
INSERT INTO `ltm_translations` VALUES (2313, 1, 'es', 'validation', 'attributes.date', 'fecha', '2019-06-18 05:08:25', '2019-06-18 05:08:25');
INSERT INTO `ltm_translations` VALUES (2314, 1, 'es', 'validation', 'attributes.time', 'hora', '2019-06-18 05:08:25', '2019-06-18 05:08:25');
INSERT INTO `ltm_translations` VALUES (2315, 1, 'es', 'validation', 'attributes.subject', 'asunto', '2019-06-18 05:08:25', '2019-06-18 05:08:25');
INSERT INTO `ltm_translations` VALUES (2316, 1, 'es', 'validation', 'attributes.message', 'mensaje', '2019-06-18 05:08:26', '2019-06-18 05:08:26');
INSERT INTO `ltm_translations` VALUES (2317, 1, 'et', 'installer_messages', 'title', 'Laraveli installer', '2019-06-18 05:08:26', '2019-06-18 05:08:26');
INSERT INTO `ltm_translations` VALUES (2318, 1, 'et', 'installer_messages', 'next', 'Järgmine samm', '2019-06-18 05:08:26', '2019-06-18 05:08:26');
INSERT INTO `ltm_translations` VALUES (2319, 1, 'et', 'installer_messages', 'welcome.title', 'Tere tulemast Laraveli installerisse', '2019-06-18 05:08:26', '2019-06-18 05:08:26');
INSERT INTO `ltm_translations` VALUES (2320, 1, 'et', 'installer_messages', 'welcome.message', 'Tere tulemast installatsiooniviisardisse.', '2019-06-18 05:08:26', '2019-06-18 05:08:26');
INSERT INTO `ltm_translations` VALUES (2321, 1, 'et', 'installer_messages', 'requirements.title', 'Nõuded', '2019-06-18 05:08:26', '2019-06-18 05:08:26');
INSERT INTO `ltm_translations` VALUES (2322, 1, 'et', 'installer_messages', 'permissions.title', 'Õigused', '2019-06-18 05:08:26', '2019-06-18 05:08:26');
INSERT INTO `ltm_translations` VALUES (2323, 1, 'et', 'installer_messages', 'environment.title', 'Keskkonna seaded', '2019-06-18 05:08:27', '2019-06-18 05:08:27');
INSERT INTO `ltm_translations` VALUES (2324, 1, 'et', 'installer_messages', 'environment.save', 'Salvesta .env', '2019-06-18 05:08:27', '2019-06-18 05:08:27');
INSERT INTO `ltm_translations` VALUES (2325, 1, 'et', 'installer_messages', 'environment.success', 'Sinu .env faili seaded on salvestatud.', '2019-06-18 05:08:27', '2019-06-18 05:08:27');
INSERT INTO `ltm_translations` VALUES (2326, 1, 'et', 'installer_messages', 'environment.errors', 'Ei saanud .env faili salvesta, palun loo see manuaalselt.', '2019-06-18 05:08:27', '2019-06-18 05:08:27');
INSERT INTO `ltm_translations` VALUES (2327, 1, 'et', 'installer_messages', 'final.title', 'Lõpetatud', '2019-06-18 05:08:27', '2019-06-18 05:08:27');
INSERT INTO `ltm_translations` VALUES (2328, 1, 'et', 'installer_messages', 'final.finished', 'Laravel on edukalt installitud', '2019-06-18 05:08:27', '2019-06-18 05:08:27');
INSERT INTO `ltm_translations` VALUES (2329, 1, 'et', 'installer_messages', 'final.exit', 'Väljumiseks vajuta siia', '2019-06-18 05:08:27', '2019-06-18 05:08:27');
INSERT INTO `ltm_translations` VALUES (2330, 1, 'et', 'messages', 'title', 'Laraveli installer', '2019-06-18 05:08:28', '2019-06-18 05:08:28');
INSERT INTO `ltm_translations` VALUES (2331, 1, 'et', 'messages', 'next', 'Järgmine samm', '2019-06-18 05:08:28', '2019-06-18 05:08:28');
INSERT INTO `ltm_translations` VALUES (2332, 1, 'et', 'messages', 'welcome.title', 'Tere tulemast Laraveli installerisse', '2019-06-18 05:08:28', '2019-06-18 05:08:28');
INSERT INTO `ltm_translations` VALUES (2333, 1, 'et', 'messages', 'welcome.message', 'Tere tulemast installatsiooniviisardisse.', '2019-06-18 05:08:28', '2019-06-18 05:08:28');
INSERT INTO `ltm_translations` VALUES (2334, 1, 'et', 'messages', 'requirements.title', 'Nõuded', '2019-06-18 05:08:28', '2019-06-18 05:08:28');
INSERT INTO `ltm_translations` VALUES (2335, 1, 'et', 'messages', 'permissions.title', 'Õigused', '2019-06-18 05:08:28', '2019-06-18 05:08:28');
INSERT INTO `ltm_translations` VALUES (2336, 1, 'et', 'messages', 'environment.title', 'Keskkonna seaded', '2019-06-18 05:08:29', '2019-06-18 05:08:29');
INSERT INTO `ltm_translations` VALUES (2337, 1, 'et', 'messages', 'environment.save', 'Salvesta .env', '2019-06-18 05:08:29', '2019-06-18 05:08:29');
INSERT INTO `ltm_translations` VALUES (2338, 1, 'et', 'messages', 'environment.success', 'Sinu .env faili seaded on salvestatud.', '2019-06-18 05:08:29', '2019-06-18 05:08:29');
INSERT INTO `ltm_translations` VALUES (2339, 1, 'et', 'messages', 'environment.errors', 'Ei saanud .env faili salvesta, palun loo see manuaalselt.', '2019-06-18 05:08:29', '2019-06-18 05:08:29');
INSERT INTO `ltm_translations` VALUES (2340, 1, 'et', 'messages', 'final.title', 'Lõpetatud', '2019-06-18 05:08:29', '2019-06-18 05:08:29');
INSERT INTO `ltm_translations` VALUES (2341, 1, 'et', 'messages', 'final.finished', 'Laravel on edukalt installitud', '2019-06-18 05:08:29', '2019-06-18 05:08:29');
INSERT INTO `ltm_translations` VALUES (2342, 1, 'et', 'messages', 'final.exit', 'Väljumiseks vajuta siia', '2019-06-18 05:08:29', '2019-06-18 05:08:29');
INSERT INTO `ltm_translations` VALUES (2343, 1, 'fa', 'installer_messages', 'title', 'نصب کننده لاراول', '2019-06-18 05:08:30', '2019-06-18 05:08:30');
INSERT INTO `ltm_translations` VALUES (2344, 1, 'fa', 'installer_messages', 'next', 'قدم بعدی', '2019-06-18 05:08:30', '2019-06-18 05:08:30');
INSERT INTO `ltm_translations` VALUES (2345, 1, 'fa', 'installer_messages', 'welcome.title', 'به نصب کننده خوش آمدید', '2019-06-18 05:08:30', '2019-06-18 05:08:30');
INSERT INTO `ltm_translations` VALUES (2346, 1, 'fa', 'installer_messages', 'welcome.message', 'به جادوگر نصب خوش آمدید .', '2019-06-18 05:08:30', '2019-06-18 05:08:30');
INSERT INTO `ltm_translations` VALUES (2347, 1, 'fa', 'installer_messages', 'requirements.title', 'نیازمندی ها', '2019-06-18 05:08:30', '2019-06-18 05:08:30');
INSERT INTO `ltm_translations` VALUES (2348, 1, 'fa', 'installer_messages', 'permissions.title', 'مجوز های دسترسی', '2019-06-18 05:08:30', '2019-06-18 05:08:30');
INSERT INTO `ltm_translations` VALUES (2349, 1, 'fa', 'installer_messages', 'environment.title', 'تنظیمات پیکربندی', '2019-06-18 05:08:30', '2019-06-18 05:08:30');
INSERT INTO `ltm_translations` VALUES (2350, 1, 'fa', 'installer_messages', 'environment.save', 'ذخیره کردن .env', '2019-06-18 05:08:30', '2019-06-18 05:08:30');
INSERT INTO `ltm_translations` VALUES (2351, 1, 'fa', 'installer_messages', 'environment.success', 'فایل .env برای شما ذخیره شد.', '2019-06-18 05:08:30', '2019-06-18 05:08:30');
INSERT INTO `ltm_translations` VALUES (2352, 1, 'fa', 'installer_messages', 'environment.errors', 'ذخیره کردن فایل .env امکان پذیر نیست، لطفا آن را به صورت دستی ایجاد کنید.', '2019-06-18 05:08:30', '2019-06-18 05:08:30');
INSERT INTO `ltm_translations` VALUES (2353, 1, 'fa', 'installer_messages', 'final.title', 'تمام شد', '2019-06-18 05:08:31', '2019-06-18 05:08:31');
INSERT INTO `ltm_translations` VALUES (2354, 1, 'fa', 'installer_messages', 'final.finished', 'اپلیکیشن با موفقیت نصب شد.', '2019-06-18 05:08:31', '2019-06-18 05:08:31');
INSERT INTO `ltm_translations` VALUES (2355, 1, 'fa', 'installer_messages', 'final.exit', 'برای خروج اینجا را کلیک کنید', '2019-06-18 05:08:31', '2019-06-18 05:08:31');
INSERT INTO `ltm_translations` VALUES (2356, 1, 'fa', 'messages', 'title', 'نصب کننده لاراول', '2019-06-18 05:08:31', '2019-06-18 05:08:31');
INSERT INTO `ltm_translations` VALUES (2357, 1, 'fa', 'messages', 'next', 'قدم بعدی', '2019-06-18 05:08:31', '2019-06-18 05:08:31');
INSERT INTO `ltm_translations` VALUES (2358, 1, 'fa', 'messages', 'welcome.title', 'به نصب کننده خوش آمدید', '2019-06-18 05:08:31', '2019-06-18 05:08:31');
INSERT INTO `ltm_translations` VALUES (2359, 1, 'fa', 'messages', 'welcome.message', 'به جادوگر نصب خوش آمدید .', '2019-06-18 05:08:31', '2019-06-18 05:08:31');
INSERT INTO `ltm_translations` VALUES (2360, 1, 'fa', 'messages', 'requirements.title', 'نیازمندی ها', '2019-06-18 05:08:31', '2019-06-18 05:08:31');
INSERT INTO `ltm_translations` VALUES (2361, 1, 'fa', 'messages', 'permissions.title', 'مجوز های دسترسی', '2019-06-18 05:08:31', '2019-06-18 05:08:31');
INSERT INTO `ltm_translations` VALUES (2362, 1, 'fa', 'messages', 'environment.title', 'تنظیمات پیکربندی', '2019-06-18 05:08:31', '2019-06-18 05:08:31');
INSERT INTO `ltm_translations` VALUES (2363, 1, 'fa', 'messages', 'environment.save', 'ذخیره کردن .env', '2019-06-18 05:08:32', '2019-06-18 05:08:32');
INSERT INTO `ltm_translations` VALUES (2364, 1, 'fa', 'messages', 'environment.success', 'فایل .env برای شما ذخیره شد.', '2019-06-18 05:08:32', '2019-06-18 05:08:32');
INSERT INTO `ltm_translations` VALUES (2365, 1, 'fa', 'messages', 'environment.errors', 'ذخیره کردن فایل .env امکان پذیر نیست، لطفا آن را به صورت دستی ایجاد کنید.', '2019-06-18 05:08:32', '2019-06-18 05:08:32');
INSERT INTO `ltm_translations` VALUES (2366, 1, 'fa', 'messages', 'final.title', 'تمام شد', '2019-06-18 05:08:32', '2019-06-18 05:08:32');
INSERT INTO `ltm_translations` VALUES (2367, 1, 'fa', 'messages', 'final.finished', 'اپلیکیشن با موفقیت نصب شد.', '2019-06-18 05:08:32', '2019-06-18 05:08:32');
INSERT INTO `ltm_translations` VALUES (2368, 1, 'fa', 'messages', 'final.exit', 'برای خروج اینجا را کلیک کنید', '2019-06-18 05:08:32', '2019-06-18 05:08:32');
INSERT INTO `ltm_translations` VALUES (2369, 1, 'fr', 'app', 'action', 'action', '2019-06-18 05:08:33', '2019-06-18 05:08:33');
INSERT INTO `ltm_translations` VALUES (2370, 1, 'fr', 'app', 'active', 'actif', '2019-06-18 05:08:33', '2019-06-18 05:08:33');
INSERT INTO `ltm_translations` VALUES (2371, 1, 'fr', 'app', 'addNew', 'Ajouter nouveau', '2019-06-18 05:08:33', '2019-06-18 05:08:33');
INSERT INTO `ltm_translations` VALUES (2372, 1, 'fr', 'app', 'address', 'la adresse', '2019-06-18 05:08:33', '2019-06-18 05:08:33');
INSERT INTO `ltm_translations` VALUES (2373, 1, 'fr', 'app', 'adminPanel', 'panneau d\'administration', '2019-06-18 05:08:34', '2019-06-18 05:08:34');
INSERT INTO `ltm_translations` VALUES (2374, 1, 'fr', 'app', 'apply', 'appliquer', '2019-06-18 05:08:34', '2019-06-18 05:08:34');
INSERT INTO `ltm_translations` VALUES (2375, 1, 'fr', 'app', 'back', 'Arrière', '2019-06-18 05:08:34', '2019-06-18 05:08:34');
INSERT INTO `ltm_translations` VALUES (2376, 1, 'fr', 'app', 'change', 'le changement', '2019-06-18 05:08:34', '2019-06-18 05:08:34');
INSERT INTO `ltm_translations` VALUES (2377, 1, 'fr', 'app', 'client', 'le client', '2019-06-18 05:08:34', '2019-06-18 05:08:34');
INSERT INTO `ltm_translations` VALUES (2378, 1, 'fr', 'app', 'clientPanel', 'Panneau client', '2019-06-18 05:08:34', '2019-06-18 05:08:34');
INSERT INTO `ltm_translations` VALUES (2379, 1, 'fr', 'app', 'completed', 'terminé', '2019-06-18 05:08:35', '2019-06-18 05:08:35');
INSERT INTO `ltm_translations` VALUES (2380, 1, 'fr', 'app', 'completion', 'le achèvement', '2019-06-18 05:08:35', '2019-06-18 05:08:35');
INSERT INTO `ltm_translations` VALUES (2381, 1, 'fr', 'app', 'createdAt', 'Créé à', '2019-06-18 05:08:35', '2019-06-18 05:08:35');
INSERT INTO `ltm_translations` VALUES (2382, 1, 'fr', 'app', 'date', 'la date', '2019-06-18 05:08:35', '2019-06-18 05:08:35');
INSERT INTO `ltm_translations` VALUES (2383, 1, 'fr', 'app', 'deadline', 'la date limite', '2019-06-18 05:08:35', '2019-06-18 05:08:35');
INSERT INTO `ltm_translations` VALUES (2384, 1, 'fr', 'app', 'description', 'la description', '2019-06-18 05:08:35', '2019-06-18 05:08:35');
INSERT INTO `ltm_translations` VALUES (2385, 1, 'fr', 'app', 'details', 'les détails', '2019-06-18 05:08:35', '2019-06-18 05:08:35');
INSERT INTO `ltm_translations` VALUES (2386, 1, 'fr', 'app', 'dueDate', 'Date d\'échéance', '2019-06-18 05:08:35', '2019-06-18 05:08:35');
INSERT INTO `ltm_translations` VALUES (2387, 1, 'fr', 'app', 'edit', 'éditer', '2019-06-18 05:08:35', '2019-06-18 05:08:35');
INSERT INTO `ltm_translations` VALUES (2388, 1, 'fr', 'app', 'email', 'Email', '2019-06-18 05:08:36', '2019-06-18 05:08:36');
INSERT INTO `ltm_translations` VALUES (2389, 1, 'fr', 'app', 'employeePanel', 'Panneau des employés', '2019-06-18 05:08:36', '2019-06-18 05:08:36');
INSERT INTO `ltm_translations` VALUES (2390, 1, 'fr', 'app', 'filterResults', 'Filtrer les résultats', '2019-06-18 05:08:36', '2019-06-18 05:08:36');
INSERT INTO `ltm_translations` VALUES (2391, 1, 'fr', 'app', 'hideCompletedTasks', 'Masquer les tâches terminées', '2019-06-18 05:08:36', '2019-06-18 05:08:36');
INSERT INTO `ltm_translations` VALUES (2392, 1, 'fr', 'app', 'id', 'ça', '2019-06-18 05:08:36', '2019-06-18 05:08:36');
INSERT INTO `ltm_translations` VALUES (2393, 1, 'fr', 'app', 'incomplete', 'incomplet', '2019-06-18 05:08:36', '2019-06-18 05:08:36');
INSERT INTO `ltm_translations` VALUES (2394, 1, 'fr', 'app', 'invoice', 'la facture', '2019-06-18 05:08:36', '2019-06-18 05:08:36');
INSERT INTO `ltm_translations` VALUES (2395, 1, 'fr', 'app', 'loginAsAdmin', 'Connexion en tant qu\'Administration', '2019-06-18 05:08:36', '2019-06-18 05:08:36');
INSERT INTO `ltm_translations` VALUES (2396, 1, 'fr', 'app', 'loginAsEmployee', 'Connectez-vous en tant qu\'employé', '2019-06-18 05:08:36', '2019-06-18 05:08:36');
INSERT INTO `ltm_translations` VALUES (2397, 1, 'fr', 'app', 'logout', 'Connectez - Out', '2019-06-18 05:08:36', '2019-06-18 05:08:36');
INSERT INTO `ltm_translations` VALUES (2398, 1, 'fr', 'app', 'markRead', 'Marquer comme lu', '2019-06-18 05:08:37', '2019-06-18 05:08:37');
INSERT INTO `ltm_translations` VALUES (2399, 1, 'fr', 'app', 'menu.accountSettings', 'Paramètres de l\'entreprise', '2019-06-18 05:08:37', '2019-06-18 05:08:37');
INSERT INTO `ltm_translations` VALUES (2400, 1, 'fr', 'app', 'menu.clients', 'le client', '2019-06-18 05:08:37', '2019-06-18 05:08:37');
INSERT INTO `ltm_translations` VALUES (2401, 1, 'fr', 'app', 'menu.contacts', 'le contact', '2019-06-18 05:08:37', '2019-06-18 05:08:37');
INSERT INTO `ltm_translations` VALUES (2402, 1, 'fr', 'app', 'menu.currencySettings', 'Paramètres de la devise', '2019-06-18 05:08:37', '2019-06-18 05:08:37');
INSERT INTO `ltm_translations` VALUES (2403, 1, 'fr', 'app', 'menu.dashboard', 'le tableau de bord', '2019-06-18 05:08:37', '2019-06-18 05:08:37');
INSERT INTO `ltm_translations` VALUES (2404, 1, 'fr', 'app', 'menu.emailSettings', 'Paramètres de messagerie', '2019-06-18 05:08:37', '2019-06-18 05:08:37');
INSERT INTO `ltm_translations` VALUES (2405, 1, 'fr', 'app', 'menu.employees', 'Employés', '2019-06-18 05:08:37', '2019-06-18 05:08:37');
INSERT INTO `ltm_translations` VALUES (2406, 1, 'fr', 'app', 'menu.financeReport', 'Rapport financier', '2019-06-18 05:08:37', '2019-06-18 05:08:37');
INSERT INTO `ltm_translations` VALUES (2407, 1, 'fr', 'app', 'menu.home', 'la maison', '2019-06-18 05:08:38', '2019-06-18 05:08:38');
INSERT INTO `ltm_translations` VALUES (2408, 1, 'fr', 'app', 'menu.invoices', 'la facture', '2019-06-18 05:08:38', '2019-06-18 05:08:38');
INSERT INTO `ltm_translations` VALUES (2409, 1, 'fr', 'app', 'menu.issues', 'la question', '2019-06-18 05:08:38', '2019-06-18 05:08:38');
INSERT INTO `ltm_translations` VALUES (2410, 1, 'fr', 'app', 'menu.messages', 'le message', '2019-06-18 05:08:38', '2019-06-18 05:08:38');
INSERT INTO `ltm_translations` VALUES (2411, 1, 'fr', 'app', 'menu.moduleSettings', 'Paramètres du module', '2019-06-18 05:08:38', '2019-06-18 05:08:38');
INSERT INTO `ltm_translations` VALUES (2412, 1, 'fr', 'app', 'menu.noticeBoard', 'Tableau d\'affichage', '2019-06-18 05:08:39', '2019-06-18 05:08:39');
INSERT INTO `ltm_translations` VALUES (2413, 1, 'fr', 'app', 'menu.profileSettings', 'Paramètres de profil', '2019-06-18 05:08:39', '2019-06-18 05:08:39');
INSERT INTO `ltm_translations` VALUES (2414, 1, 'fr', 'app', 'menu.projects', 'les projets', '2019-06-18 05:08:39', '2019-06-18 05:08:39');
INSERT INTO `ltm_translations` VALUES (2415, 1, 'fr', 'app', 'menu.reports', 'le rapport', '2019-06-18 05:08:40', '2019-06-18 05:08:40');
INSERT INTO `ltm_translations` VALUES (2416, 1, 'fr', 'app', 'menu.settings', 'le réglage', '2019-06-18 05:08:40', '2019-06-18 05:08:40');
INSERT INTO `ltm_translations` VALUES (2417, 1, 'fr', 'app', 'menu.stickyNotes', 'Notes autocollantes', '2019-06-18 05:08:40', '2019-06-18 05:08:40');
INSERT INTO `ltm_translations` VALUES (2418, 1, 'fr', 'app', 'menu.taskCalendar', 'Calendrier des tâches', '2019-06-18 05:08:40', '2019-06-18 05:08:40');
INSERT INTO `ltm_translations` VALUES (2419, 1, 'fr', 'app', 'menu.taskReport', 'Rapport de tâche', '2019-06-18 05:08:41', '2019-06-18 05:08:41');
INSERT INTO `ltm_translations` VALUES (2420, 1, 'fr', 'app', 'menu.tasks', 'les tâches', '2019-06-18 05:08:41', '2019-06-18 05:08:41');
INSERT INTO `ltm_translations` VALUES (2421, 1, 'fr', 'app', 'menu.timeLogReport', 'Rapport de journal de temps', '2019-06-18 05:08:41', '2019-06-18 05:08:41');
INSERT INTO `ltm_translations` VALUES (2422, 1, 'fr', 'app', 'menu.timeLogs', 'Journal de temps', '2019-06-18 05:08:41', '2019-06-18 05:08:41');
INSERT INTO `ltm_translations` VALUES (2423, 1, 'fr', 'app', 'menu.themeSettings', 'Réglage des thèmes', '2019-06-18 05:08:41', '2019-06-18 05:08:41');
INSERT INTO `ltm_translations` VALUES (2424, 1, 'fr', 'app', 'menu.estimates', 'Estimates', '2019-06-18 05:08:42', '2019-06-18 05:08:42');
INSERT INTO `ltm_translations` VALUES (2425, 1, 'fr', 'app', 'menu.paymentGatewayCredential', 'Pouvoirs de la passerelle de paiement', '2019-06-18 05:08:42', '2019-06-18 05:08:42');
INSERT INTO `ltm_translations` VALUES (2426, 1, 'fr', 'app', 'menu.payments', 'Paiements', '2019-06-18 05:08:42', '2019-06-18 05:08:42');
INSERT INTO `ltm_translations` VALUES (2427, 1, 'fr', 'app', 'menu.expenses', 'Expenses', '2019-06-18 05:08:42', '2019-06-18 05:08:42');
INSERT INTO `ltm_translations` VALUES (2428, 1, 'fr', 'app', 'menu.incomeVsExpenseReport', 'Rapport sur les revenus et les dépenses', '2019-06-18 05:08:42', '2019-06-18 05:08:42');
INSERT INTO `ltm_translations` VALUES (2429, 1, 'fr', 'app', 'menu.invoiceSettings', 'Paramètres de la facture', '2019-06-18 05:08:42', '2019-06-18 05:08:42');
INSERT INTO `ltm_translations` VALUES (2430, 1, 'fr', 'app', 'menu.updates', 'Mises à jourJournal des mises à jour', '2019-06-18 05:08:42', '2019-06-18 05:08:42');
INSERT INTO `ltm_translations` VALUES (2431, 1, 'fr', 'app', 'menu.ticketSettings', 'Paramètres du ticket', '2019-06-18 05:08:43', '2019-06-18 05:08:43');
INSERT INTO `ltm_translations` VALUES (2432, 1, 'fr', 'app', 'menu.ticketAgents', 'Agents de billet', '2019-06-18 05:08:43', '2019-06-18 05:08:43');
INSERT INTO `ltm_translations` VALUES (2433, 1, 'fr', 'app', 'menu.ticketTypes', 'Types de tickets', '2019-06-18 05:08:43', '2019-06-18 05:08:43');
INSERT INTO `ltm_translations` VALUES (2434, 1, 'fr', 'app', 'menu.ticketChannel', 'Chaîne de billets', '2019-06-18 05:08:43', '2019-06-18 05:08:43');
INSERT INTO `ltm_translations` VALUES (2435, 1, 'fr', 'app', 'menu.replyTemplates', 'Modèles de réponses', '2019-06-18 05:08:43', '2019-06-18 05:08:43');
INSERT INTO `ltm_translations` VALUES (2436, 1, 'fr', 'app', 'menu.attendanceSettings', 'Paramètres de présence', '2019-06-18 05:08:43', '2019-06-18 05:08:43');
INSERT INTO `ltm_translations` VALUES (2437, 1, 'fr', 'app', 'menu.attendance', 'présence', '2019-06-18 05:08:43', '2019-06-18 05:08:43');
INSERT INTO `ltm_translations` VALUES (2438, 1, 'fr', 'app', 'menu.slackSettings', 'Paramètres de relâchement', '2019-06-18 05:08:44', '2019-06-18 05:08:44');
INSERT INTO `ltm_translations` VALUES (2439, 1, 'fr', 'app', 'menu.tickets', 'le billet', '2019-06-18 05:08:44', '2019-06-18 05:08:44');
INSERT INTO `ltm_translations` VALUES (2440, 1, 'fr', 'app', 'menu.finance', 'financier', '2019-06-18 05:08:44', '2019-06-18 05:08:44');
INSERT INTO `ltm_translations` VALUES (2441, 1, 'fr', 'app', 'menu.Events', 'événements', '2019-06-18 05:08:44', '2019-06-18 05:08:44');
INSERT INTO `ltm_translations` VALUES (2442, 1, 'fr', 'app', 'menu.rolesPermission', 'Rôles et autorisations', '2019-06-18 05:08:44', '2019-06-18 05:08:44');
INSERT INTO `ltm_translations` VALUES (2443, 1, 'fr', 'app', 'menu.messageSettings', 'Paramètres de message', '2019-06-18 05:08:44', '2019-06-18 05:08:44');
INSERT INTO `ltm_translations` VALUES (2444, 1, 'fr', 'app', 'menu.storageSettings', 'Paramètres de stockage', '2019-06-18 05:08:45', '2019-06-18 05:08:45');
INSERT INTO `ltm_translations` VALUES (2445, 1, 'fr', 'app', 'menu.leaveSettings', 'Paramètres des feuilles', '2019-06-18 05:08:45', '2019-06-18 05:08:45');
INSERT INTO `ltm_translations` VALUES (2446, 1, 'fr', 'app', 'menu.leaveReport', 'Rapport de congé', '2019-06-18 05:08:45', '2019-06-18 05:08:45');
INSERT INTO `ltm_translations` VALUES (2447, 1, 'fr', 'app', 'menu.products', 'Des produits', '2019-06-18 05:08:45', '2019-06-18 05:08:45');
INSERT INTO `ltm_translations` VALUES (2448, 1, 'fr', 'app', 'mobile', 'mobile', '2019-06-18 05:08:45', '2019-06-18 05:08:45');
INSERT INTO `ltm_translations` VALUES (2449, 1, 'fr', 'app', 'name', 'le nom', '2019-06-18 05:08:45', '2019-06-18 05:08:45');
INSERT INTO `ltm_translations` VALUES (2450, 1, 'fr', 'app', 'note', 'noter', '2019-06-18 05:08:46', '2019-06-18 05:08:46');
INSERT INTO `ltm_translations` VALUES (2451, 1, 'fr', 'app', 'phone', 'le téléphone', '2019-06-18 05:08:46', '2019-06-18 05:08:46');
INSERT INTO `ltm_translations` VALUES (2452, 1, 'fr', 'app', 'project', 'le projet', '2019-06-18 05:08:47', '2019-06-18 05:08:47');
INSERT INTO `ltm_translations` VALUES (2453, 1, 'fr', 'app', 'remove', 'supprimer', '2019-06-18 05:08:47', '2019-06-18 05:08:47');
INSERT INTO `ltm_translations` VALUES (2454, 1, 'fr', 'app', 'reset', 'remettre', '2019-06-18 05:08:47', '2019-06-18 05:08:47');
INSERT INTO `ltm_translations` VALUES (2455, 1, 'fr', 'app', 'save', 'économiser', '2019-06-18 05:08:48', '2019-06-18 05:08:48');
INSERT INTO `ltm_translations` VALUES (2456, 1, 'fr', 'app', 'search', 'Chercher...', '2019-06-18 05:08:48', '2019-06-18 05:08:48');
INSERT INTO `ltm_translations` VALUES (2457, 1, 'fr', 'app', 'selectDateRange', 'Sélectionnez la plage de dates', '2019-06-18 05:08:48', '2019-06-18 05:08:48');
INSERT INTO `ltm_translations` VALUES (2458, 1, 'fr', 'app', 'selectImage', 'Sélectionner l\'image', '2019-06-18 05:08:48', '2019-06-18 05:08:48');
INSERT INTO `ltm_translations` VALUES (2459, 1, 'fr', 'app', 'selectProject', 'Sélectionnez le projet', '2019-06-18 05:08:48', '2019-06-18 05:08:48');
INSERT INTO `ltm_translations` VALUES (2460, 1, 'fr', 'app', 'status', 'le statut', '2019-06-18 05:08:49', '2019-06-18 05:08:49');
INSERT INTO `ltm_translations` VALUES (2461, 1, 'fr', 'app', 'stop', 'le statut', '2019-06-18 05:08:49', '2019-06-18 05:08:49');
INSERT INTO `ltm_translations` VALUES (2462, 1, 'fr', 'app', 'task', 'la tâche', '2019-06-18 05:08:49', '2019-06-18 05:08:49');
INSERT INTO `ltm_translations` VALUES (2463, 1, 'fr', 'app', 'title', 'le titre', '2019-06-18 05:08:50', '2019-06-18 05:08:50');
INSERT INTO `ltm_translations` VALUES (2464, 1, 'fr', 'app', 'update', 'mettre à jour', '2019-06-18 05:08:50', '2019-06-18 05:08:50');
INSERT INTO `ltm_translations` VALUES (2465, 1, 'fr', 'app', 'exportExcel', 'Exporter vers Excel', '2019-06-18 05:08:50', '2019-06-18 05:08:50');
INSERT INTO `ltm_translations` VALUES (2466, 1, 'fr', 'app', 'datatable', '//cdn.datatables.net/plug-ins/1.10.15/i18n/Russian.json', '2019-06-18 05:08:51', '2019-06-18 05:08:51');
INSERT INTO `ltm_translations` VALUES (2467, 1, 'fr', 'app', 'role', 'Rôle d\'utilisateur', '2019-06-18 05:08:51', '2019-06-18 05:08:51');
INSERT INTO `ltm_translations` VALUES (2468, 1, 'fr', 'app', 'projectAdminPanel', 'Panneau d\'administration du projet', '2019-06-18 05:08:51', '2019-06-18 05:08:51');
INSERT INTO `ltm_translations` VALUES (2469, 1, 'fr', 'app', 'loginAsProjectAdmin', 'Connectez-vous en tant que Project Admin', '2019-06-18 05:08:51', '2019-06-18 05:08:51');
INSERT INTO `ltm_translations` VALUES (2470, 1, 'fr', 'app', 'pending', 'en attendant', '2019-06-18 05:08:51', '2019-06-18 05:08:51');
INSERT INTO `ltm_translations` VALUES (2471, 1, 'fr', 'app', 'price', 'Prix', '2019-06-18 05:08:51', '2019-06-18 05:08:51');
INSERT INTO `ltm_translations` VALUES (2472, 1, 'fr', 'app', 'duration', 'Durée', '2019-06-18 05:08:52', '2019-06-18 05:08:52');
INSERT INTO `ltm_translations` VALUES (2473, 1, 'fr', 'app', 'last', 'Dernier', '2019-06-18 05:08:52', '2019-06-18 05:08:52');
INSERT INTO `ltm_translations` VALUES (2474, 1, 'fr', 'app', 'month', 'Mois', '2019-06-18 05:08:52', '2019-06-18 05:08:52');
INSERT INTO `ltm_translations` VALUES (2475, 1, 'fr', 'app', 'select', 'Sélectionner', '2019-06-18 05:08:52', '2019-06-18 05:08:52');
INSERT INTO `ltm_translations` VALUES (2476, 1, 'fr', 'app', 'income', 'le revenu', '2019-06-18 05:08:52', '2019-06-18 05:08:52');
INSERT INTO `ltm_translations` VALUES (2477, 1, 'fr', 'app', 'expense', 'Frais', '2019-06-18 05:08:52', '2019-06-18 05:08:52');
INSERT INTO `ltm_translations` VALUES (2478, 1, 'fr', 'app', 'total', 'Total', '2019-06-18 05:08:52', '2019-06-18 05:08:52');
INSERT INTO `ltm_translations` VALUES (2479, 1, 'fr', 'app', 'days', 'Journées', '2019-06-18 05:08:53', '2019-06-18 05:08:53');
INSERT INTO `ltm_translations` VALUES (2480, 1, 'fr', 'app', 'year', 'An', '2019-06-18 05:08:53', '2019-06-18 05:08:53');
INSERT INTO `ltm_translations` VALUES (2481, 1, 'fr', 'app', 'yes', 'Oui', '2019-06-18 05:08:53', '2019-06-18 05:08:53');
INSERT INTO `ltm_translations` VALUES (2482, 1, 'fr', 'app', 'no', 'Non', '2019-06-18 05:08:53', '2019-06-18 05:08:53');
INSERT INTO `ltm_translations` VALUES (2483, 1, 'fr', 'app', 'day', 'journée', '2019-06-18 05:08:53', '2019-06-18 05:08:53');
INSERT INTO `ltm_translations` VALUES (2484, 1, 'fr', 'app', 'week', 'La semaine', '2019-06-18 05:08:53', '2019-06-18 05:08:53');
INSERT INTO `ltm_translations` VALUES (2485, 1, 'fr', 'app', 'submit', 'Soumettre', '2019-06-18 05:08:53', '2019-06-18 05:08:53');
INSERT INTO `ltm_translations` VALUES (2486, 1, 'fr', 'app', 'required', 'requis', '2019-06-18 05:08:53', '2019-06-18 05:08:53');
INSERT INTO `ltm_translations` VALUES (2487, 1, 'fr', 'app', 'filterBy', 'Filtrer par', '2019-06-18 05:08:54', '2019-06-18 05:08:54');
INSERT INTO `ltm_translations` VALUES (2488, 1, 'fr', 'app', 'others', 'Autres', '2019-06-18 05:08:54', '2019-06-18 05:08:54');
INSERT INTO `ltm_translations` VALUES (2489, 1, 'fr', 'app', 'delete', 'effacer', '2019-06-18 05:08:54', '2019-06-18 05:08:54');
INSERT INTO `ltm_translations` VALUES (2490, 1, 'fr', 'app', 'add', 'ajouter', '2019-06-18 05:08:54', '2019-06-18 05:08:54');
INSERT INTO `ltm_translations` VALUES (2491, 1, 'fr', 'app', 'view', 'vue', '2019-06-18 05:08:54', '2019-06-18 05:08:54');
INSERT INTO `ltm_translations` VALUES (2492, 1, 'fr', 'app', 'accept', 'accepter', '2019-06-18 05:08:54', '2019-06-18 05:08:54');
INSERT INTO `ltm_translations` VALUES (2493, 1, 'fr', 'app', 'reject', 'refuser', '2019-06-18 05:08:54', '2019-06-18 05:08:54');
INSERT INTO `ltm_translations` VALUES (2494, 1, 'fr', 'app', 'newNotifications', 'Nouvelles notifications', '2019-06-18 05:08:54', '2019-06-18 05:08:54');
INSERT INTO `ltm_translations` VALUES (2495, 1, 'fr', 'app', 'from', 'à partir de', '2019-06-18 05:08:55', '2019-06-18 05:08:55');
INSERT INTO `ltm_translations` VALUES (2496, 1, 'fr', 'app', 'cancel', 'résilier', '2019-06-18 05:08:55', '2019-06-18 05:08:55');
INSERT INTO `ltm_translations` VALUES (2497, 1, 'fr', 'app', 'april', 'avril', '2019-06-18 05:08:55', '2019-06-18 05:08:55');
INSERT INTO `ltm_translations` VALUES (2498, 1, 'fr', 'app', 'august', 'août', '2019-06-18 05:08:55', '2019-06-18 05:08:55');
INSERT INTO `ltm_translations` VALUES (2499, 1, 'fr', 'app', 'december', 'décembre', '2019-06-18 05:08:55', '2019-06-18 05:08:55');
INSERT INTO `ltm_translations` VALUES (2500, 1, 'fr', 'app', 'february', 'février', '2019-06-18 05:08:55', '2019-06-18 05:08:55');
INSERT INTO `ltm_translations` VALUES (2501, 1, 'fr', 'app', 'january', 'janvier', '2019-06-18 05:08:55', '2019-06-18 05:08:55');
INSERT INTO `ltm_translations` VALUES (2502, 1, 'fr', 'app', 'july', 'juillet', '2019-06-18 05:08:56', '2019-06-18 05:08:56');
INSERT INTO `ltm_translations` VALUES (2503, 1, 'fr', 'app', 'june', 'juin', '2019-06-18 05:08:56', '2019-06-18 05:08:56');
INSERT INTO `ltm_translations` VALUES (2504, 1, 'fr', 'app', 'march', 'mars', '2019-06-18 05:08:56', '2019-06-18 05:08:56');
INSERT INTO `ltm_translations` VALUES (2505, 1, 'fr', 'app', 'may', 'mai', '2019-06-18 05:08:56', '2019-06-18 05:08:56');
INSERT INTO `ltm_translations` VALUES (2506, 1, 'fr', 'app', 'november', 'novembre', '2019-06-18 05:08:56', '2019-06-18 05:08:56');
INSERT INTO `ltm_translations` VALUES (2507, 1, 'fr', 'app', 'october', 'octobre', '2019-06-18 05:08:56', '2019-06-18 05:08:56');
INSERT INTO `ltm_translations` VALUES (2508, 1, 'fr', 'app', 'september', 'septembre', '2019-06-18 05:08:57', '2019-06-18 05:08:57');
INSERT INTO `ltm_translations` VALUES (2509, 1, 'fr', 'app', 'approved', 'approuvé', '2019-06-18 05:08:57', '2019-06-18 05:08:57');
INSERT INTO `ltm_translations` VALUES (2510, 1, 'fr', 'app', 'selectFile', 'Choisir le dossier', '2019-06-18 05:08:57', '2019-06-18 05:08:57');
INSERT INTO `ltm_translations` VALUES (2511, 1, 'fr', 'app', 'login', 'S\'identifier', '2019-06-18 05:08:57', '2019-06-18 05:08:57');
INSERT INTO `ltm_translations` VALUES (2512, 1, 'fr', 'app', 'rememberMe', 'Souviens-toi de moi', '2019-06-18 05:08:57', '2019-06-18 05:08:57');
INSERT INTO `ltm_translations` VALUES (2513, 1, 'fr', 'app', 'forgotPassword', 'Mot de passe oublié', '2019-06-18 05:08:58', '2019-06-18 05:08:58');
INSERT INTO `ltm_translations` VALUES (2514, 1, 'fr', 'app', 'welcome', 'Soyez le bienvenu', '2019-06-18 05:08:58', '2019-06-18 05:08:58');
INSERT INTO `ltm_translations` VALUES (2515, 1, 'fr', 'app', 'forbiddenError', 'Erreur interdite', '2019-06-18 05:08:58', '2019-06-18 05:08:58');
INSERT INTO `ltm_translations` VALUES (2516, 1, 'fr', 'app', 'noPermission', 'Vous n\'êtes pas autorisé à y accéder.', '2019-06-18 05:08:58', '2019-06-18 05:08:58');
INSERT INTO `ltm_translations` VALUES (2517, 1, 'fr', 'app', 'recoverPassword', 'Récupérer mot de passe', '2019-06-18 05:08:58', '2019-06-18 05:08:58');
INSERT INTO `ltm_translations` VALUES (2518, 1, 'fr', 'app', 'open', 'Ouvrir', '2019-06-18 05:08:58', '2019-06-18 05:08:58');
INSERT INTO `ltm_translations` VALUES (2519, 1, 'fr', 'app', 'resolved', 'résolu', '2019-06-18 05:08:58', '2019-06-18 05:08:58');
INSERT INTO `ltm_translations` VALUES (2520, 1, 'fr', 'app', 'optional', 'facultatif', '2019-06-18 05:08:58', '2019-06-18 05:08:58');
INSERT INTO `ltm_translations` VALUES (2521, 1, 'fr', 'app', 'female', 'femelle', '2019-06-18 05:08:59', '2019-06-18 05:08:59');
INSERT INTO `ltm_translations` VALUES (2522, 1, 'fr', 'app', 'male', 'mâle', '2019-06-18 05:08:59', '2019-06-18 05:08:59');
INSERT INTO `ltm_translations` VALUES (2523, 1, 'fr', 'app', 'language', 'la langue', '2019-06-18 05:08:59', '2019-06-18 05:08:59');
INSERT INTO `ltm_translations` VALUES (2524, 1, 'fr', 'app', 'upcoming', 'Prochain', '2019-06-18 05:08:59', '2019-06-18 05:08:59');
INSERT INTO `ltm_translations` VALUES (2525, 1, 'fr', 'app', 'minutes', 'Minutes', '2019-06-18 05:08:59', '2019-06-18 05:08:59');
INSERT INTO `ltm_translations` VALUES (2526, 1, 'fr', 'app', 'onLeave', 'En congé', '2019-06-18 05:08:59', '2019-06-18 05:08:59');
INSERT INTO `ltm_translations` VALUES (2527, 1, 'fr', 'app', 'inclusiveAllTaxes', 'Toutes taxes comprises', '2019-06-18 05:08:59', '2019-06-18 05:08:59');
INSERT INTO `ltm_translations` VALUES (2528, 1, 'fr', 'app', 'reason', 'Raison', '2019-06-18 05:08:59', '2019-06-18 05:08:59');
INSERT INTO `ltm_translations` VALUES (2529, 1, 'fr', 'auth', 'failed', 'Ces identifiants ne correspondent pas à nos enregistrements', '2019-06-18 05:08:59', '2019-06-18 05:08:59');
INSERT INTO `ltm_translations` VALUES (2530, 1, 'fr', 'auth', 'throttle', 'Trop de tentatives de connexion. Veuillez essayer de nouveau dans :seconds secondes.', '2019-06-18 05:09:00', '2019-06-18 05:09:00');
INSERT INTO `ltm_translations` VALUES (2531, 1, 'fr', 'email', 'newEvent.subject', 'Nouvel événement créé', '2019-06-18 05:09:00', '2019-06-18 05:09:00');
INSERT INTO `ltm_translations` VALUES (2532, 1, 'fr', 'email', 'newEvent.text', 'Un nouvel événement a été créé. Téléchargez la pièce jointe pour ajouter un événement à votre calendrier.', '2019-06-18 05:09:00', '2019-06-18 05:09:00');
INSERT INTO `ltm_translations` VALUES (2533, 1, 'fr', 'email', 'loginDashboard', 'Connexion au tableau de bord', '2019-06-18 05:09:00', '2019-06-18 05:09:00');
INSERT INTO `ltm_translations` VALUES (2534, 1, 'fr', 'email', 'thankyouNote', 'Merci d\'utiliser notre application!', '2019-06-18 05:09:01', '2019-06-18 05:09:01');
INSERT INTO `ltm_translations` VALUES (2535, 1, 'fr', 'email', 'hello', 'Bonjour', '2019-06-18 05:09:01', '2019-06-18 05:09:01');
INSERT INTO `ltm_translations` VALUES (2536, 1, 'fr', 'email', 'regards', 'meilleurs souvenirs', '2019-06-18 05:09:01', '2019-06-18 05:09:01');
INSERT INTO `ltm_translations` VALUES (2537, 1, 'fr', 'email', 'newExpense.subject', 'Nouvelle dépense ajoutée', '2019-06-18 05:09:01', '2019-06-18 05:09:01');
INSERT INTO `ltm_translations` VALUES (2538, 1, 'fr', 'email', 'expenseStatus.subject', 'État des dépenses mis à jour', '2019-06-18 05:09:01', '2019-06-18 05:09:01');
INSERT INTO `ltm_translations` VALUES (2539, 1, 'fr', 'email', 'expenseStatus.text', 'Votre statut de dépenses mis à jour à', '2019-06-18 05:09:02', '2019-06-18 05:09:02');
INSERT INTO `ltm_translations` VALUES (2540, 1, 'fr', 'email', 'newNotice.subject', 'Nouvel avis publié', '2019-06-18 05:09:02', '2019-06-18 05:09:02');
INSERT INTO `ltm_translations` VALUES (2541, 1, 'fr', 'email', 'newNotice.text', 'Un nouvel avis a été publié. Connectez-vous pour voir l\'avis.', '2019-06-18 05:09:02', '2019-06-18 05:09:02');
INSERT INTO `ltm_translations` VALUES (2542, 1, 'fr', 'email', 'newProjectMember.subject', 'Nouveau projet assigné', '2019-06-18 05:09:02', '2019-06-18 05:09:02');
INSERT INTO `ltm_translations` VALUES (2543, 1, 'fr', 'email', 'newProjectMember.text', 'Vous avez été ajouté en tant que membre au projet', '2019-06-18 05:09:02', '2019-06-18 05:09:02');
INSERT INTO `ltm_translations` VALUES (2544, 1, 'fr', 'email', 'newTask.subject', 'Nouvelle tâche assignée à vous', '2019-06-18 05:09:03', '2019-06-18 05:09:03');
INSERT INTO `ltm_translations` VALUES (2545, 1, 'fr', 'email', 'newTicket.subject', 'Nouveau ticket de support demandé', '2019-06-18 05:09:03', '2019-06-18 05:09:03');
INSERT INTO `ltm_translations` VALUES (2546, 1, 'fr', 'email', 'newTicket.text', 'Un nouveau ticket de support est demandé. Connectez-vous pour voir le ticket.', '2019-06-18 05:09:03', '2019-06-18 05:09:03');
INSERT INTO `ltm_translations` VALUES (2547, 1, 'fr', 'email', 'newUser.subject', 'Bienvenue à', '2019-06-18 05:09:03', '2019-06-18 05:09:03');
INSERT INTO `ltm_translations` VALUES (2548, 1, 'fr', 'email', 'newUser.text', 'Votre compte a été créé avec succès.', '2019-06-18 05:09:03', '2019-06-18 05:09:03');
INSERT INTO `ltm_translations` VALUES (2549, 1, 'fr', 'email', 'leaves.subject', 'Nouvelle demande de congé reçue', '2019-06-18 05:09:03', '2019-06-18 05:09:03');
INSERT INTO `ltm_translations` VALUES (2550, 1, 'fr', 'email', 'leaves.statusSubject', 'Laisser le statut de la demande', '2019-06-18 05:09:03', '2019-06-18 05:09:03');
INSERT INTO `ltm_translations` VALUES (2551, 1, 'fr', 'email', 'taskComplete.subject', 'Tâche marquée comme complète', '2019-06-18 05:09:04', '2019-06-18 05:09:04');
INSERT INTO `ltm_translations` VALUES (2552, 1, 'fr', 'email', 'leave.approve', 'Laisser la demande approuvée.', '2019-06-18 05:09:04', '2019-06-18 05:09:04');
INSERT INTO `ltm_translations` VALUES (2553, 1, 'fr', 'email', 'leave.reject', 'Laisser la demande rejetée.', '2019-06-18 05:09:04', '2019-06-18 05:09:04');
INSERT INTO `ltm_translations` VALUES (2554, 1, 'fr', 'email', 'leave.applied', 'Laisser l\'application appliquée.', '2019-06-18 05:09:04', '2019-06-18 05:09:04');
INSERT INTO `ltm_translations` VALUES (2555, 1, 'fr', 'installer_messages', 'title', 'Installateur de Laravel', '2019-06-18 05:09:04', '2019-06-18 05:09:04');
INSERT INTO `ltm_translations` VALUES (2556, 1, 'fr', 'installer_messages', 'next', 'Suivant', '2019-06-18 05:09:04', '2019-06-18 05:09:04');
INSERT INTO `ltm_translations` VALUES (2557, 1, 'fr', 'installer_messages', 'welcome.title', 'Bienvenue dans l’installateur...', '2019-06-18 05:09:04', '2019-06-18 05:09:04');
INSERT INTO `ltm_translations` VALUES (2558, 1, 'fr', 'installer_messages', 'welcome.message', 'Bienvenue dans le programme d’installation.', '2019-06-18 05:09:04', '2019-06-18 05:09:04');
INSERT INTO `ltm_translations` VALUES (2559, 1, 'fr', 'installer_messages', 'requirements.title', 'Prérequis', '2019-06-18 05:09:04', '2019-06-18 05:09:04');
INSERT INTO `ltm_translations` VALUES (2560, 1, 'fr', 'installer_messages', 'permissions.title', 'Permissions', '2019-06-18 05:09:05', '2019-06-18 05:09:05');
INSERT INTO `ltm_translations` VALUES (2561, 1, 'fr', 'installer_messages', 'environment.title', 'Paramètres d’environment', '2019-06-18 05:09:05', '2019-06-18 05:09:05');
INSERT INTO `ltm_translations` VALUES (2562, 1, 'fr', 'installer_messages', 'environment.save', 'Enregistrer .env', '2019-06-18 05:09:05', '2019-06-18 05:09:05');
INSERT INTO `ltm_translations` VALUES (2563, 1, 'fr', 'installer_messages', 'environment.success', 'Votre fichier .env a été sauvegardé.', '2019-06-18 05:09:05', '2019-06-18 05:09:05');
INSERT INTO `ltm_translations` VALUES (2564, 1, 'fr', 'installer_messages', 'environment.errors', 'Impossible d’enregistrer le fichier .env, il faut que vous le créiez manuellement.', '2019-06-18 05:09:05', '2019-06-18 05:09:05');
INSERT INTO `ltm_translations` VALUES (2565, 1, 'fr', 'installer_messages', 'final.title', 'Terminé', '2019-06-18 05:09:05', '2019-06-18 05:09:05');
INSERT INTO `ltm_translations` VALUES (2566, 1, 'fr', 'installer_messages', 'final.finished', 'L’application a été installée avec succès.', '2019-06-18 05:09:05', '2019-06-18 05:09:05');
INSERT INTO `ltm_translations` VALUES (2567, 1, 'fr', 'installer_messages', 'final.exit', 'Cliquez ici pour quitter', '2019-06-18 05:09:06', '2019-06-18 05:09:06');
INSERT INTO `ltm_translations` VALUES (2568, 1, 'fr', 'messages', 'title', 'Installateur de Laravel', '2019-06-18 05:09:06', '2019-06-18 05:09:06');
INSERT INTO `ltm_translations` VALUES (2569, 1, 'fr', 'messages', 'next', 'Suivant', '2019-06-18 05:09:06', '2019-06-18 05:09:06');
INSERT INTO `ltm_translations` VALUES (2570, 1, 'fr', 'messages', 'welcome.title', 'Bienvenue dans l’installateur...', '2019-06-18 05:09:06', '2019-06-18 05:09:06');
INSERT INTO `ltm_translations` VALUES (2571, 1, 'fr', 'messages', 'welcome.message', 'Bienvenue dans le programme d’installation.', '2019-06-18 05:09:06', '2019-06-18 05:09:06');
INSERT INTO `ltm_translations` VALUES (2572, 1, 'fr', 'messages', 'requirements.title', 'Prérequis', '2019-06-18 05:09:06', '2019-06-18 05:09:06');
INSERT INTO `ltm_translations` VALUES (2573, 1, 'fr', 'messages', 'permissions.title', 'autorisation', '2019-06-18 05:09:06', '2019-06-18 05:09:06');
INSERT INTO `ltm_translations` VALUES (2574, 1, 'fr', 'messages', 'environment.title', 'Paramètres d’environment', '2019-06-18 05:09:06', '2019-06-18 05:09:06');
INSERT INTO `ltm_translations` VALUES (2575, 1, 'fr', 'messages', 'environment.save', 'Enregistrer .env', '2019-06-18 05:09:07', '2019-06-18 05:09:07');
INSERT INTO `ltm_translations` VALUES (2576, 1, 'fr', 'messages', 'environment.success', 'Votre fichier .env a été sauvegardé.', '2019-06-18 05:09:07', '2019-06-18 05:09:07');
INSERT INTO `ltm_translations` VALUES (2577, 1, 'fr', 'messages', 'environment.errors', 'Impossible d’enregistrer le fichier .env, il faut que vous le créiez manuellement.', '2019-06-18 05:09:07', '2019-06-18 05:09:07');
INSERT INTO `ltm_translations` VALUES (2578, 1, 'fr', 'messages', 'final.title', 'Terminé', '2019-06-18 05:09:07', '2019-06-18 05:09:07');
INSERT INTO `ltm_translations` VALUES (2579, 1, 'fr', 'messages', 'final.finished', 'L’application a été installée avec succès.', '2019-06-18 05:09:07', '2019-06-18 05:09:07');
INSERT INTO `ltm_translations` VALUES (2580, 1, 'fr', 'messages', 'final.exit', 'Cliquez ici pour quitter', '2019-06-18 05:09:08', '2019-06-18 05:09:08');
INSERT INTO `ltm_translations` VALUES (2581, 1, 'fr', 'messages', 'addedAsNewProject', 'Ajouté en tant que nouveau projet.', '2019-06-18 05:09:08', '2019-06-18 05:09:08');
INSERT INTO `ltm_translations` VALUES (2582, 1, 'fr', 'messages', 'addItem', 'Ajouter au moins 1 élément.', '2019-06-18 05:09:08', '2019-06-18 05:09:08');
INSERT INTO `ltm_translations` VALUES (2583, 1, 'fr', 'messages', 'adminCannotDelete', 'L\'utilisateur administrateur ne peut pas être supprimé.', '2019-06-18 05:09:08', '2019-06-18 05:09:08');
INSERT INTO `ltm_translations` VALUES (2584, 1, 'fr', 'messages', 'amountNumber', 'Le nombre devrait être un nombre.', '2019-06-18 05:09:08', '2019-06-18 05:09:08');
INSERT INTO `ltm_translations` VALUES (2585, 1, 'fr', 'messages', 'categoryAdded', 'Catégorie ajoutée avec succès.', '2019-06-18 05:09:09', '2019-06-18 05:09:09');
INSERT INTO `ltm_translations` VALUES (2586, 1, 'fr', 'messages', 'categoryDeleted', 'Catégorie supprimée avec succès.', '2019-06-18 05:09:09', '2019-06-18 05:09:09');
INSERT INTO `ltm_translations` VALUES (2587, 1, 'fr', 'messages', 'categoryUpdated', 'Catégorie mise à jour avec succès.', '2019-06-18 05:09:09', '2019-06-18 05:09:09');
INSERT INTO `ltm_translations` VALUES (2588, 1, 'fr', 'messages', 'clientDeleted', 'Client supprimé avec succès.', '2019-06-18 05:09:10', '2019-06-18 05:09:10');
INSERT INTO `ltm_translations` VALUES (2589, 1, 'fr', 'messages', 'clientUpdated', 'Les informations client ont été mises à jour avec succès.', '2019-06-18 05:09:10', '2019-06-18 05:09:10');
INSERT INTO `ltm_translations` VALUES (2590, 1, 'fr', 'messages', 'clientUploadedAFileToTheProject', '(Client) a téléchargé un fichier sur le projet.', '2019-06-18 05:09:10', '2019-06-18 05:09:10');
INSERT INTO `ltm_translations` VALUES (2591, 1, 'fr', 'messages', 'contactAdded', 'Contact ajouté avec succès.', '2019-06-18 05:09:10', '2019-06-18 05:09:10');
INSERT INTO `ltm_translations` VALUES (2592, 1, 'fr', 'messages', 'contactDeleted', 'Contact supprimé avec succès.', '2019-06-18 05:09:10', '2019-06-18 05:09:10');
INSERT INTO `ltm_translations` VALUES (2593, 1, 'fr', 'messages', 'contactUpdated', 'Contact mis à jour avec succès.', '2019-06-18 05:09:11', '2019-06-18 05:09:11');
INSERT INTO `ltm_translations` VALUES (2594, 1, 'fr', 'messages', 'currencyAdded', 'La devise a été ajoutée avec succès.', '2019-06-18 05:09:11', '2019-06-18 05:09:11');
INSERT INTO `ltm_translations` VALUES (2595, 1, 'fr', 'messages', 'currencyDeleted', 'Devise supprimée avec succès.', '2019-06-18 05:09:11', '2019-06-18 05:09:11');
INSERT INTO `ltm_translations` VALUES (2596, 1, 'fr', 'messages', 'currencyUpdated', 'Monnaie mise à jour avec succès.', '2019-06-18 05:09:12', '2019-06-18 05:09:12');
INSERT INTO `ltm_translations` VALUES (2597, 1, 'fr', 'messages', 'defaultColorNote', 'Si vous ne choisissez aucune couleur, le bleu sera par défaut', '2019-06-18 05:09:12', '2019-06-18 05:09:12');
INSERT INTO `ltm_translations` VALUES (2598, 1, 'fr', 'messages', 'earningChartNote', 'Les gains sont mentionnés dans votre devise de base. Vous pouvez le modifier ici.', '2019-06-18 05:09:12', '2019-06-18 05:09:12');
INSERT INTO `ltm_translations` VALUES (2599, 1, 'fr', 'messages', 'employeeDeleted', 'L\'employé a été supprimé avec succès.', '2019-06-18 05:09:12', '2019-06-18 05:09:12');
INSERT INTO `ltm_translations` VALUES (2600, 1, 'fr', 'messages', 'employeeUpdated', 'Les informations de l\'employé ont été mises à jour avec succès.', '2019-06-18 05:09:12', '2019-06-18 05:09:12');
INSERT INTO `ltm_translations` VALUES (2601, 1, 'fr', 'messages', 'fetchChat', 'Obtenir les détails du chat.', '2019-06-18 05:09:12', '2019-06-18 05:09:12');
INSERT INTO `ltm_translations` VALUES (2602, 1, 'fr', 'messages', 'fileDeleted', 'Fichier supprimé avec succès.', '2019-06-18 05:09:12', '2019-06-18 05:09:12');
INSERT INTO `ltm_translations` VALUES (2603, 1, 'fr', 'messages', 'fileUploaded', 'Fichier téléchargé avec succès.', '2019-06-18 05:09:13', '2019-06-18 05:09:13');
INSERT INTO `ltm_translations` VALUES (2604, 1, 'fr', 'messages', 'fileUploadedSuccessfully', 'Fichier téléchargé avec succès.', '2019-06-18 05:09:13', '2019-06-18 05:09:13');
INSERT INTO `ltm_translations` VALUES (2605, 1, 'fr', 'messages', 'finish', 'Installer', '2019-06-18 05:09:13', '2019-06-18 05:09:13');
INSERT INTO `ltm_translations` VALUES (2606, 1, 'fr', 'messages', 'invoiceCreated', 'Facture créée avec succès.', '2019-06-18 05:09:13', '2019-06-18 05:09:13');
INSERT INTO `ltm_translations` VALUES (2607, 1, 'fr', 'messages', 'invoiceDeleted', 'Facture supprimée avec succès.', '2019-06-18 05:09:13', '2019-06-18 05:09:13');
INSERT INTO `ltm_translations` VALUES (2608, 1, 'fr', 'messages', 'invoiceUpdated', 'La facture a été mise à jour avec succès.', '2019-06-18 05:09:14', '2019-06-18 05:09:14');
INSERT INTO `ltm_translations` VALUES (2609, 1, 'fr', 'messages', 'isAddedAsProjectMember', 'Est ajouté en tant que membre du projet.', '2019-06-18 05:09:14', '2019-06-18 05:09:14');
INSERT INTO `ltm_translations` VALUES (2610, 1, 'fr', 'messages', 'issueCreated', 'Problème créé avec succès.', '2019-06-18 05:09:14', '2019-06-18 05:09:14');
INSERT INTO `ltm_translations` VALUES (2611, 1, 'fr', 'messages', 'issueDeleted', 'Problème supprimé avec succès.', '2019-06-18 05:09:14', '2019-06-18 05:09:14');
INSERT INTO `ltm_translations` VALUES (2612, 1, 'fr', 'messages', 'issueStatusChanged', 'L\'état du problème a changé avec succès.', '2019-06-18 05:09:14', '2019-06-18 05:09:14');
INSERT INTO `ltm_translations` VALUES (2613, 1, 'fr', 'messages', 'issueUpdated', 'Problème mis à jour avec succès.', '2019-06-18 05:09:14', '2019-06-18 05:09:14');
INSERT INTO `ltm_translations` VALUES (2614, 1, 'fr', 'messages', 'itemBlank', 'Le nom de l\'élément ne peut pas être vide.', '2019-06-18 05:09:14', '2019-06-18 05:09:14');
INSERT INTO `ltm_translations` VALUES (2615, 1, 'fr', 'messages', 'Login As Employee', 'Connectez-vous en tant qu\'employé', '2019-06-18 05:09:14', '2019-06-18 05:09:14');
INSERT INTO `ltm_translations` VALUES (2616, 1, 'fr', 'messages', 'memberRemovedFromProject', 'Membre supprimé du projet avec succès.', '2019-06-18 05:09:15', '2019-06-18 05:09:15');
INSERT INTO `ltm_translations` VALUES (2617, 1, 'fr', 'messages', 'membersAddedSuccessfully', 'Les membres ont été ajoutés avec succès.', '2019-06-18 05:09:15', '2019-06-18 05:09:15');
INSERT INTO `ltm_translations` VALUES (2618, 1, 'fr', 'messages', 'newFileUploadedToTheProject', 'Nouveau fichier téléchargé sur le projet.', '2019-06-18 05:09:15', '2019-06-18 05:09:15');
INSERT INTO `ltm_translations` VALUES (2619, 1, 'fr', 'messages', 'newMemberAddedToTheProject', 'Nouveau membre ajouté au projet.', '2019-06-18 05:09:15', '2019-06-18 05:09:15');
INSERT INTO `ltm_translations` VALUES (2620, 1, 'fr', 'messages', 'newTaskAddedToTheProject', 'Nouvelle tâche ajoutée au projet.', '2019-06-18 05:09:15', '2019-06-18 05:09:15');
INSERT INTO `ltm_translations` VALUES (2621, 1, 'fr', 'messages', 'noActiveTimer', 'Pas de minuterie active.', '2019-06-18 05:09:15', '2019-06-18 05:09:15');
INSERT INTO `ltm_translations` VALUES (2622, 1, 'fr', 'messages', 'noActivityByThisUser', 'Aucune activité de l\'utilisateur.', '2019-06-18 05:09:15', '2019-06-18 05:09:15');
INSERT INTO `ltm_translations` VALUES (2623, 1, 'fr', 'messages', 'noClientAdded', 'Aucun client n\'a été ajouté.', '2019-06-18 05:09:15', '2019-06-18 05:09:15');
INSERT INTO `ltm_translations` VALUES (2624, 1, 'fr', 'messages', 'noConversation', 'Aucune conversation n\'a été trouvée.', '2019-06-18 05:09:15', '2019-06-18 05:09:15');
INSERT INTO `ltm_translations` VALUES (2625, 1, 'fr', 'messages', 'noFileUploaded', 'Vous n\'avez téléchargé aucun fichier.', '2019-06-18 05:09:16', '2019-06-18 05:09:16');
INSERT INTO `ltm_translations` VALUES (2626, 1, 'fr', 'messages', 'noInvoice', 'Aucune facture n\'a été créée.', '2019-06-18 05:09:16', '2019-06-18 05:09:16');
INSERT INTO `ltm_translations` VALUES (2627, 1, 'fr', 'messages', 'noIssue', 'Aucun problème trouvé.', '2019-06-18 05:09:16', '2019-06-18 05:09:16');
INSERT INTO `ltm_translations` VALUES (2628, 1, 'fr', 'messages', 'noMemberAddedToProject', 'Aucun membre n\'a été ajouté à ce projet.', '2019-06-18 05:09:16', '2019-06-18 05:09:16');
INSERT INTO `ltm_translations` VALUES (2629, 1, 'fr', 'messages', 'noMessage', 'Aucun message trouvé.', '2019-06-18 05:09:16', '2019-06-18 05:09:16');
INSERT INTO `ltm_translations` VALUES (2630, 1, 'fr', 'messages', 'noNotice', 'Aucun avis publié.', '2019-06-18 05:09:16', '2019-06-18 05:09:16');
INSERT INTO `ltm_translations` VALUES (2631, 1, 'fr', 'messages', 'noOpenIssues', 'Aucun problème ouvert.', '2019-06-18 05:09:16', '2019-06-18 05:09:16');
INSERT INTO `ltm_translations` VALUES (2632, 1, 'fr', 'messages', 'noOpenTasks', 'Pas de tâches ouvertes.', '2019-06-18 05:09:16', '2019-06-18 05:09:16');
INSERT INTO `ltm_translations` VALUES (2633, 1, 'fr', 'messages', 'noProjectAssigned', 'Aucun projet ne vous est attribué.', '2019-06-18 05:09:17', '2019-06-18 05:09:17');
INSERT INTO `ltm_translations` VALUES (2634, 1, 'fr', 'messages', 'noProjectCategoryAdded', 'Aucune catégorie de projet n\'a été ajoutée.', '2019-06-18 05:09:17', '2019-06-18 05:09:17');
INSERT INTO `ltm_translations` VALUES (2635, 1, 'fr', 'messages', 'noProjectFound', 'Aucun projet trouvé.', '2019-06-18 05:09:17', '2019-06-18 05:09:17');
INSERT INTO `ltm_translations` VALUES (2636, 1, 'fr', 'messages', 'noteCreated', 'Note créée avec succès.', '2019-06-18 05:09:17', '2019-06-18 05:09:17');
INSERT INTO `ltm_translations` VALUES (2637, 1, 'fr', 'messages', 'noteDeleted', 'Note supprimée avec succès.', '2019-06-18 05:09:17', '2019-06-18 05:09:17');
INSERT INTO `ltm_translations` VALUES (2638, 1, 'fr', 'messages', 'noteUpdated', 'Note mise à jour avec succès.', '2019-06-18 05:09:17', '2019-06-18 05:09:17');
INSERT INTO `ltm_translations` VALUES (2639, 1, 'fr', 'messages', 'noticeAdded', 'Avis ajouté avec succès.', '2019-06-18 05:09:18', '2019-06-18 05:09:18');
INSERT INTO `ltm_translations` VALUES (2640, 1, 'fr', 'messages', 'noticeDeleted', 'Avis supprimé avec succès.', '2019-06-18 05:09:18', '2019-06-18 05:09:18');
INSERT INTO `ltm_translations` VALUES (2641, 1, 'fr', 'messages', 'noticeUpdated', 'Avis mis à jour avec succès.', '2019-06-18 05:09:18', '2019-06-18 05:09:18');
INSERT INTO `ltm_translations` VALUES (2642, 1, 'fr', 'messages', 'noUser', 'Aucun utilisateur trouvé.', '2019-06-18 05:09:19', '2019-06-18 05:09:19');
INSERT INTO `ltm_translations` VALUES (2643, 1, 'fr', 'messages', 'profileUpdated', 'Mise à jour du profil réussie.', '2019-06-18 05:09:19', '2019-06-18 05:09:19');
INSERT INTO `ltm_translations` VALUES (2644, 1, 'fr', 'messages', 'projectDeleted', 'Projet supprimé avec succès.', '2019-06-18 05:09:19', '2019-06-18 05:09:19');
INSERT INTO `ltm_translations` VALUES (2645, 1, 'fr', 'messages', 'projectUpdated', 'Projet mis à jour avec succès.', '2019-06-18 05:09:20', '2019-06-18 05:09:20');
INSERT INTO `ltm_translations` VALUES (2646, 1, 'fr', 'messages', 'quantityNumber', 'La quantité doit être un nombre', '2019-06-18 05:09:20', '2019-06-18 05:09:20');
INSERT INTO `ltm_translations` VALUES (2647, 1, 'fr', 'messages', 'reportGenerated', 'Rapport généré avec succès.', '2019-06-18 05:09:20', '2019-06-18 05:09:20');
INSERT INTO `ltm_translations` VALUES (2648, 1, 'fr', 'messages', 'settingsUpdated', 'Paramètres mis à jour avec succès.', '2019-06-18 05:09:20', '2019-06-18 05:09:20');
INSERT INTO `ltm_translations` VALUES (2649, 1, 'fr', 'messages', 'taskCreatedSuccessfully', 'Tâche créée avec succès.', '2019-06-18 05:09:20', '2019-06-18 05:09:20');
INSERT INTO `ltm_translations` VALUES (2650, 1, 'fr', 'messages', 'taskDeletedSuccessfully', 'Tâche supprimée avec succès.', '2019-06-18 05:09:20', '2019-06-18 05:09:20');
INSERT INTO `ltm_translations` VALUES (2651, 1, 'fr', 'messages', 'taskUpdated', 'Marqué la tâche comme', '2019-06-18 05:09:21', '2019-06-18 05:09:21');
INSERT INTO `ltm_translations` VALUES (2652, 1, 'fr', 'messages', 'taskUpdatedSuccessfully', 'Tâche mise à jour avec succès.', '2019-06-18 05:09:21', '2019-06-18 05:09:21');
INSERT INTO `ltm_translations` VALUES (2653, 1, 'fr', 'messages', 'timeLogAdded', 'Heure enregistrée avec succès.', '2019-06-18 05:09:21', '2019-06-18 05:09:21');
INSERT INTO `ltm_translations` VALUES (2654, 1, 'fr', 'messages', 'timeLogDeleted', 'Journal de temps supprimé avec succès.', '2019-06-18 05:09:21', '2019-06-18 05:09:21');
INSERT INTO `ltm_translations` VALUES (2655, 1, 'fr', 'messages', 'timeLogUpdated', 'Journal de temps mis à jour avec succès.', '2019-06-18 05:09:21', '2019-06-18 05:09:21');
INSERT INTO `ltm_translations` VALUES (2656, 1, 'fr', 'messages', 'timerStartedBy', 'Timer commencé par', '2019-06-18 05:09:21', '2019-06-18 05:09:21');
INSERT INTO `ltm_translations` VALUES (2657, 1, 'fr', 'messages', 'timerStartedProject', 'Démarrage de la minuterie pour le projet', '2019-06-18 05:09:21', '2019-06-18 05:09:21');
INSERT INTO `ltm_translations` VALUES (2658, 1, 'fr', 'messages', 'timerStartedSuccessfully', 'La minuterie a débuté avec succès.', '2019-06-18 05:09:21', '2019-06-18 05:09:21');
INSERT INTO `ltm_translations` VALUES (2659, 1, 'fr', 'messages', 'timerStoppedBy', 'Temporisateur arrêté par', '2019-06-18 05:09:22', '2019-06-18 05:09:22');
INSERT INTO `ltm_translations` VALUES (2660, 1, 'fr', 'messages', 'timerStoppedSuccessfully', 'La minuterie s\'est arrêtée avec succès.', '2019-06-18 05:09:22', '2019-06-18 05:09:22');
INSERT INTO `ltm_translations` VALUES (2661, 1, 'fr', 'messages', 'unAuthorisedUser', 'Vous n\'êtes pas un utilisateur autorisé.', '2019-06-18 05:09:22', '2019-06-18 05:09:22');
INSERT INTO `ltm_translations` VALUES (2662, 1, 'fr', 'messages', 'unitPriceNumber', 'Le prix unitaire devrait être un nombre', '2019-06-18 05:09:22', '2019-06-18 05:09:22');
INSERT INTO `ltm_translations` VALUES (2663, 1, 'fr', 'messages', 'updatedProfile', 'Profil mis à jour.', '2019-06-18 05:09:22', '2019-06-18 05:09:22');
INSERT INTO `ltm_translations` VALUES (2664, 1, 'fr', 'messages', 'noProjectCategory', 'Aucune catégorie de projet n\'a été trouvée.', '2019-06-18 05:09:22', '2019-06-18 05:09:22');
INSERT INTO `ltm_translations` VALUES (2665, 1, 'fr', 'messages', 'roleAssigned', 'Rôles attribués avec succès.', '2019-06-18 05:09:22', '2019-06-18 05:09:22');
INSERT INTO `ltm_translations` VALUES (2666, 1, 'fr', 'messages', 'roleCannotChange', 'Le rôle de cet utilisateur ne peut pas être modifié.', '2019-06-18 05:09:23', '2019-06-18 05:09:23');
INSERT INTO `ltm_translations` VALUES (2667, 1, 'fr', 'messages', 'estimateCreated', 'Estimation créée avec succès.', '2019-06-18 05:09:23', '2019-06-18 05:09:23');
INSERT INTO `ltm_translations` VALUES (2668, 1, 'fr', 'messages', 'estimateUpdated', 'Estimation mise à jour avec succès.', '2019-06-18 05:09:23', '2019-06-18 05:09:23');
INSERT INTO `ltm_translations` VALUES (2669, 1, 'fr', 'messages', 'estimateDeleted', 'Estimation supprimée avec succès.', '2019-06-18 05:09:23', '2019-06-18 05:09:23');
INSERT INTO `ltm_translations` VALUES (2670, 1, 'fr', 'messages', 'paymentSuccess', 'Paiement ajouté avec succès.', '2019-06-18 05:09:23', '2019-06-18 05:09:23');
INSERT INTO `ltm_translations` VALUES (2671, 1, 'fr', 'messages', 'paymentDeleted', 'Paiement supprimé avec succès.', '2019-06-18 05:09:23', '2019-06-18 05:09:23');
INSERT INTO `ltm_translations` VALUES (2672, 1, 'fr', 'messages', 'expenseSuccess', 'Dépenses ajoutées avec succès.', '2019-06-18 05:09:23', '2019-06-18 05:09:23');
INSERT INTO `ltm_translations` VALUES (2673, 1, 'fr', 'messages', 'expenseUpdateSuccess', 'Dépenses mises à jour avec succès.', '2019-06-18 05:09:23', '2019-06-18 05:09:23');
INSERT INTO `ltm_translations` VALUES (2674, 1, 'fr', 'messages', 'expenseDeleted', 'Dépenses supprimées avec succès.', '2019-06-18 05:09:23', '2019-06-18 05:09:23');
INSERT INTO `ltm_translations` VALUES (2675, 1, 'fr', 'messages', 'exchangeRateNote', 'Le taux de change est calculé à partir de votre devise par défaut. Modifier la devise par défaut dans les paramètres de l\'entreprise', '2019-06-18 05:09:24', '2019-06-18 05:09:24');
INSERT INTO `ltm_translations` VALUES (2676, 1, 'fr', 'messages', 'exchangeRateUpdateSuccess', 'Taux de change mis à jour avec succès.', '2019-06-18 05:09:24', '2019-06-18 05:09:24');
INSERT INTO `ltm_translations` VALUES (2677, 1, 'fr', 'messages', 'invalidRequest', 'requête invalide', '2019-06-18 05:09:24', '2019-06-18 05:09:24');
INSERT INTO `ltm_translations` VALUES (2678, 1, 'fr', 'messages', 'employeeAdded', 'Employee ajouté avec succès.', '2019-06-18 05:09:24', '2019-06-18 05:09:24');
INSERT INTO `ltm_translations` VALUES (2679, 1, 'fr', 'messages', 'databaseUpdated', 'Mise à jour de base de données avec succès.', '2019-06-18 05:09:24', '2019-06-18 05:09:24');
INSERT INTO `ltm_translations` VALUES (2680, 1, 'fr', 'messages', 'noAgentAdded', 'Aucun agent n\'a été ajouté.', '2019-06-18 05:09:24', '2019-06-18 05:09:24');
INSERT INTO `ltm_translations` VALUES (2681, 1, 'fr', 'messages', 'noGroupAdded', 'Aucun groupe n\'a été ajouté.', '2019-06-18 05:09:25', '2019-06-18 05:09:25');
INSERT INTO `ltm_translations` VALUES (2682, 1, 'fr', 'messages', 'agentAddedSuccessfully', 'Agent ajouté avec succès.', '2019-06-18 05:09:25', '2019-06-18 05:09:25');
INSERT INTO `ltm_translations` VALUES (2683, 1, 'fr', 'messages', 'statusUpdatedSuccessfully', 'État mis à jour avec succès.', '2019-06-18 05:09:25', '2019-06-18 05:09:25');
INSERT INTO `ltm_translations` VALUES (2684, 1, 'fr', 'messages', 'groupUpdatedSuccessfully', 'Groupe mis à jour avec succès.', '2019-06-18 05:09:25', '2019-06-18 05:09:25');
INSERT INTO `ltm_translations` VALUES (2685, 1, 'fr', 'messages', 'agentRemoveSuccess', 'Agent supprimé avec succès.', '2019-06-18 05:09:25', '2019-06-18 05:09:25');
INSERT INTO `ltm_translations` VALUES (2686, 1, 'fr', 'messages', 'groupAddedSuccess', 'Groupe ajouté avec succès.', '2019-06-18 05:09:25', '2019-06-18 05:09:25');
INSERT INTO `ltm_translations` VALUES (2687, 1, 'fr', 'messages', 'groupDeleteSuccess', 'Groupe supprimé avec succès.', '2019-06-18 05:09:26', '2019-06-18 05:09:26');
INSERT INTO `ltm_translations` VALUES (2688, 1, 'fr', 'messages', 'noTicketTypeAdded', 'Aucun type de ticket n\'a été ajouté.', '2019-06-18 05:09:26', '2019-06-18 05:09:26');
INSERT INTO `ltm_translations` VALUES (2689, 1, 'fr', 'messages', 'ticketTypeAddSuccess', 'Type de ticket ajouté avec succès.', '2019-06-18 05:09:26', '2019-06-18 05:09:26');
INSERT INTO `ltm_translations` VALUES (2690, 1, 'fr', 'messages', 'ticketTypeUpdateSuccess', 'Type de ticket mis à jour avec succès.', '2019-06-18 05:09:26', '2019-06-18 05:09:26');
INSERT INTO `ltm_translations` VALUES (2691, 1, 'fr', 'messages', 'ticketTypeDeleteSuccess', 'Type de ticket supprimé avec succès.', '2019-06-18 05:09:26', '2019-06-18 05:09:26');
INSERT INTO `ltm_translations` VALUES (2692, 1, 'fr', 'messages', 'ticketChannelAddSuccess', 'Chaîne de tickets ajoutée avec succès.', '2019-06-18 05:09:26', '2019-06-18 05:09:26');
INSERT INTO `ltm_translations` VALUES (2693, 1, 'fr', 'messages', 'ticketChannelUpdateSuccess', 'La chaîne de tickets a été mise à jour avec succès.', '2019-06-18 05:09:26', '2019-06-18 05:09:26');
INSERT INTO `ltm_translations` VALUES (2694, 1, 'fr', 'messages', 'noTemplateFound', 'Aucun modèle trouvé.', '2019-06-18 05:09:26', '2019-06-18 05:09:26');
INSERT INTO `ltm_translations` VALUES (2695, 1, 'fr', 'messages', 'templateAddSuccess', 'Modèle ajouté avec succès.', '2019-06-18 05:09:26', '2019-06-18 05:09:26');
INSERT INTO `ltm_translations` VALUES (2696, 1, 'fr', 'messages', 'templateUpdateSuccess', 'Le succès de la mise à jour des modèles.', '2019-06-18 05:09:27', '2019-06-18 05:09:27');
INSERT INTO `ltm_translations` VALUES (2697, 1, 'fr', 'messages', 'templateDeleteSuccess', 'Modèle supprimé avec succès.', '2019-06-18 05:09:27', '2019-06-18 05:09:27');
INSERT INTO `ltm_translations` VALUES (2698, 1, 'fr', 'messages', 'ticketAddSuccess', 'Billet créé avec succès.', '2019-06-18 05:09:27', '2019-06-18 05:09:27');
INSERT INTO `ltm_translations` VALUES (2699, 1, 'fr', 'messages', 'ticketChannelDeleteSuccess', 'La chaîne de tickets a été supprimée avec succès.', '2019-06-18 05:09:27', '2019-06-18 05:09:27');
INSERT INTO `ltm_translations` VALUES (2700, 1, 'fr', 'messages', 'ticketReplySuccess', 'Réponse envoyée avec succès.', '2019-06-18 05:09:27', '2019-06-18 05:09:27');
INSERT INTO `ltm_translations` VALUES (2701, 1, 'fr', 'messages', 'ticketDeleteSuccess', 'Billet supprimé avec succès.', '2019-06-18 05:09:27', '2019-06-18 05:09:27');
INSERT INTO `ltm_translations` VALUES (2702, 1, 'fr', 'messages', 'noFeedbackReceived', 'Aucun commentaire reçu.', '2019-06-18 05:09:27', '2019-06-18 05:09:27');
INSERT INTO `ltm_translations` VALUES (2703, 1, 'fr', 'messages', 'noClientAddedToProject', 'Aucun client affecté au projet.', '2019-06-18 05:09:27', '2019-06-18 05:09:27');
INSERT INTO `ltm_translations` VALUES (2704, 1, 'fr', 'messages', 'attendanceSaveSuccess', 'Présence sauvegardée avec succès.', '2019-06-18 05:09:27', '2019-06-18 05:09:27');
INSERT INTO `ltm_translations` VALUES (2705, 1, 'fr', 'messages', 'boardColumnSaved', 'La colonne du forum a été enregistrée avec succès.', '2019-06-18 05:09:28', '2019-06-18 05:09:28');
INSERT INTO `ltm_translations` VALUES (2706, 1, 'fr', 'messages', 'customFieldCreateSuccess', 'Champ personnalisé créé avec succès.', '2019-06-18 05:09:28', '2019-06-18 05:09:28');
INSERT INTO `ltm_translations` VALUES (2707, 1, 'fr', 'messages', 'deleteSuccess', 'Supprimé avec succès.', '2019-06-18 05:09:28', '2019-06-18 05:09:28');
INSERT INTO `ltm_translations` VALUES (2708, 1, 'fr', 'messages', 'eventCreateSuccess', 'Événement créé avec succès', '2019-06-18 05:09:28', '2019-06-18 05:09:28');
INSERT INTO `ltm_translations` VALUES (2709, 1, 'fr', 'messages', 'eventDeleteSuccess', 'Événement supprimé avec succès.', '2019-06-18 05:09:28', '2019-06-18 05:09:28');
INSERT INTO `ltm_translations` VALUES (2710, 1, 'fr', 'messages', 'permissionUpdated', 'Autorisation mise à jour avec succès.', '2019-06-18 05:09:28', '2019-06-18 05:09:28');
INSERT INTO `ltm_translations` VALUES (2711, 1, 'fr', 'messages', 'noRoleMemberFound', 'Aucun membre n\'est affecté à ce rôle.', '2019-06-18 05:09:28', '2019-06-18 05:09:28');
INSERT INTO `ltm_translations` VALUES (2712, 1, 'fr', 'messages', 'roleCreated', 'Rôle créé avec succès.', '2019-06-18 05:09:28', '2019-06-18 05:09:28');
INSERT INTO `ltm_translations` VALUES (2713, 1, 'fr', 'messages', 'noRoleFound', 'Aucun rôle trouvé.', '2019-06-18 05:09:28', '2019-06-18 05:09:28');
INSERT INTO `ltm_translations` VALUES (2714, 1, 'fr', 'messages', 'noTicketFound', 'Aucun ticket trouvé.', '2019-06-18 05:09:29', '2019-06-18 05:09:29');
INSERT INTO `ltm_translations` VALUES (2715, 1, 'fr', 'messages', 'noLeaveTypeAdded', 'Aucun type de congé ajouté.', '2019-06-18 05:09:29', '2019-06-18 05:09:29');
INSERT INTO `ltm_translations` VALUES (2716, 1, 'fr', 'messages', 'leaveTypeAdded', 'Laissez le type enregistré.', '2019-06-18 05:09:29', '2019-06-18 05:09:29');
INSERT INTO `ltm_translations` VALUES (2717, 1, 'fr', 'messages', 'leaveTypeDeleted', 'Laissez le type supprimé.', '2019-06-18 05:09:29', '2019-06-18 05:09:29');
INSERT INTO `ltm_translations` VALUES (2718, 1, 'fr', 'messages', 'selectMultipleDates', 'Vous pouvez sélectionner plusieurs dates.', '2019-06-18 05:09:29', '2019-06-18 05:09:29');
INSERT INTO `ltm_translations` VALUES (2719, 1, 'fr', 'messages', 'leaveAssignSuccess', 'Laissez assigné avec succès.', '2019-06-18 05:09:29', '2019-06-18 05:09:29');
INSERT INTO `ltm_translations` VALUES (2720, 1, 'fr', 'messages', 'leaveDeleteSuccess', 'Laissez supprimé avec succès.', '2019-06-18 05:09:29', '2019-06-18 05:09:29');
INSERT INTO `ltm_translations` VALUES (2721, 1, 'fr', 'messages', 'leaveStatusUpdate', 'Laisser le statut mis à jour avec succès.', '2019-06-18 05:09:29', '2019-06-18 05:09:29');
INSERT INTO `ltm_translations` VALUES (2722, 1, 'fr', 'messages', 'noPendingLeaves', 'Aucune feuille en attente restante.', '2019-06-18 05:09:30', '2019-06-18 05:09:30');
INSERT INTO `ltm_translations` VALUES (2723, 1, 'fr', 'messages', 'updateAlert', 'Ne cliquez pas sur le bouton Mettre à jour maintenant si l\'application est personnalisée. Vos changements seront perdus.', '2019-06-18 05:09:30', '2019-06-18 05:09:30');
INSERT INTO `ltm_translations` VALUES (2724, 1, 'fr', 'messages', 'updateBackupNotice', 'Prenez la sauvegarde des fichiers et de la base de données avant la mise à jour.', '2019-06-18 05:09:30', '2019-06-18 05:09:30');
INSERT INTO `ltm_translations` VALUES (2725, 1, 'fr', 'messages', 'noRecordFound', 'Aucun Enregistrement Trouvé.', '2019-06-18 05:09:30', '2019-06-18 05:09:30');
INSERT INTO `ltm_translations` VALUES (2726, 1, 'fr', 'messages', 'atleastOneValidation', 'Choisissez au moins 1', '2019-06-18 05:09:30', '2019-06-18 05:09:30');
INSERT INTO `ltm_translations` VALUES (2727, 1, 'fr', 'messages', 'notificationRead', 'Notification marquée comme lue.', '2019-06-18 05:09:31', '2019-06-18 05:09:31');
INSERT INTO `ltm_translations` VALUES (2728, 1, 'fr', 'messages', 'chooseProject', 'Choisissez un projet', '2019-06-18 05:09:31', '2019-06-18 05:09:31');
INSERT INTO `ltm_translations` VALUES (2729, 1, 'fr', 'messages', 'fieldBlank', 'Le champ ne peut pas être vide.', '2019-06-18 05:09:31', '2019-06-18 05:09:31');
INSERT INTO `ltm_translations` VALUES (2730, 1, 'fr', 'messages', 'defaultRoleCantDelete', 'La función predeterminada no se puede eliminar.', '2019-06-18 05:09:31', '2019-06-18 05:09:31');
INSERT INTO `ltm_translations` VALUES (2731, 1, 'fr', 'messages', 'taxAdded', 'taxe ajoutée avec succès', '2019-06-18 05:09:31', '2019-06-18 05:09:31');
INSERT INTO `ltm_translations` VALUES (2732, 1, 'fr', 'messages', 'productAdded', 'Produit ajouté avec succès.', '2019-06-18 05:09:31', '2019-06-18 05:09:31');
INSERT INTO `ltm_translations` VALUES (2733, 1, 'fr', 'messages', 'productUpdated', 'Produit mis à jour avec succès.', '2019-06-18 05:09:31', '2019-06-18 05:09:31');
INSERT INTO `ltm_translations` VALUES (2734, 1, 'fr', 'messages', 'productDeleted', 'Produit supprimé avec succès.', '2019-06-18 05:09:32', '2019-06-18 05:09:32');
INSERT INTO `ltm_translations` VALUES (2735, 1, 'fr', 'modules', 'accountSettings.changeLanguage', 'Changer de langue', '2019-06-18 05:09:32', '2019-06-18 05:09:32');
INSERT INTO `ltm_translations` VALUES (2736, 1, 'fr', 'modules', 'accountSettings.companyAddress', 'Adresse de la société', '2019-06-18 05:09:32', '2019-06-18 05:09:32');
INSERT INTO `ltm_translations` VALUES (2737, 1, 'fr', 'modules', 'accountSettings.companyEmail', 'Email de la société', '2019-06-18 05:09:32', '2019-06-18 05:09:32');
INSERT INTO `ltm_translations` VALUES (2738, 1, 'fr', 'modules', 'accountSettings.companyLogo', 'Logo d\'entreprise', '2019-06-18 05:09:32', '2019-06-18 05:09:32');
INSERT INTO `ltm_translations` VALUES (2739, 1, 'fr', 'modules', 'accountSettings.companyName', 'Nom de la compagnie', '2019-06-18 05:09:32', '2019-06-18 05:09:32');
INSERT INTO `ltm_translations` VALUES (2740, 1, 'fr', 'modules', 'accountSettings.companyPhone', 'Téléphone de l\'entreprise', '2019-06-18 05:09:32', '2019-06-18 05:09:32');
INSERT INTO `ltm_translations` VALUES (2741, 1, 'fr', 'modules', 'accountSettings.companyWebsite', 'site Web d\'entreprise', '2019-06-18 05:09:32', '2019-06-18 05:09:32');
INSERT INTO `ltm_translations` VALUES (2742, 1, 'fr', 'modules', 'accountSettings.defaultCurrency', 'devise par défaut', '2019-06-18 05:09:33', '2019-06-18 05:09:33');
INSERT INTO `ltm_translations` VALUES (2743, 1, 'fr', 'modules', 'accountSettings.defaultTimezone', 'Fuseau horaire par défaut', '2019-06-18 05:09:33', '2019-06-18 05:09:33');
INSERT INTO `ltm_translations` VALUES (2744, 1, 'fr', 'modules', 'accountSettings.updateTitle', 'Paramètres d\'organisation de mise à jour', '2019-06-18 05:09:33', '2019-06-18 05:09:33');
INSERT INTO `ltm_translations` VALUES (2745, 1, 'fr', 'modules', 'accountSettings.uploadLogo', 'Téléchargez votre logo', '2019-06-18 05:09:33', '2019-06-18 05:09:33');
INSERT INTO `ltm_translations` VALUES (2746, 1, 'fr', 'modules', 'accountSettings.getLocation', 'Définir l\'emplacement actuel', '2019-06-18 05:09:33', '2019-06-18 05:09:33');
INSERT INTO `ltm_translations` VALUES (2747, 1, 'fr', 'modules', 'client.addNewClient', 'Ajouter un nouveau client', '2019-06-18 05:09:33', '2019-06-18 05:09:33');
INSERT INTO `ltm_translations` VALUES (2748, 1, 'fr', 'modules', 'client.address', 'Adresse', '2019-06-18 05:09:33', '2019-06-18 05:09:33');
INSERT INTO `ltm_translations` VALUES (2749, 1, 'fr', 'modules', 'client.clientDetails', 'Détails du client', '2019-06-18 05:09:33', '2019-06-18 05:09:33');
INSERT INTO `ltm_translations` VALUES (2750, 1, 'fr', 'modules', 'client.clientEmail', 'Email du client', '2019-06-18 05:09:33', '2019-06-18 05:09:33');
INSERT INTO `ltm_translations` VALUES (2751, 1, 'fr', 'modules', 'client.clientName', 'Nom du client', '2019-06-18 05:09:33', '2019-06-18 05:09:33');
INSERT INTO `ltm_translations` VALUES (2752, 1, 'fr', 'modules', 'client.companyDetails', 'Détails de la société', '2019-06-18 05:09:34', '2019-06-18 05:09:34');
INSERT INTO `ltm_translations` VALUES (2753, 1, 'fr', 'modules', 'client.companyName', 'Nom de la compagnie', '2019-06-18 05:09:34', '2019-06-18 05:09:34');
INSERT INTO `ltm_translations` VALUES (2754, 1, 'fr', 'modules', 'client.createTitle', 'Ajouter des informations sur le client', '2019-06-18 05:09:34', '2019-06-18 05:09:34');
INSERT INTO `ltm_translations` VALUES (2755, 1, 'fr', 'modules', 'client.deadline', 'Date limite', '2019-06-18 05:09:34', '2019-06-18 05:09:34');
INSERT INTO `ltm_translations` VALUES (2756, 1, 'fr', 'modules', 'client.emailNote', 'Le client se connectera en utilisant ce courrier électronique.', '2019-06-18 05:09:34', '2019-06-18 05:09:34');
INSERT INTO `ltm_translations` VALUES (2757, 1, 'fr', 'modules', 'client.mobile', 'Mobile', '2019-06-18 05:09:34', '2019-06-18 05:09:34');
INSERT INTO `ltm_translations` VALUES (2758, 1, 'fr', 'modules', 'client.password', 'Mot de passe', '2019-06-18 05:09:35', '2019-06-18 05:09:35');
INSERT INTO `ltm_translations` VALUES (2759, 1, 'fr', 'modules', 'client.passwordNote', 'Le client se connecte en utilisant ce mot de passe.', '2019-06-18 05:09:35', '2019-06-18 05:09:35');
INSERT INTO `ltm_translations` VALUES (2760, 1, 'fr', 'modules', 'client.passwordUpdateNote', 'Le client se connecte en utilisant ce mot de passe. (Laissez vide pour conserver le mot de passe actuel)', '2019-06-18 05:09:35', '2019-06-18 05:09:35');
INSERT INTO `ltm_translations` VALUES (2761, 1, 'fr', 'modules', 'client.projectName', 'nom du projet', '2019-06-18 05:09:36', '2019-06-18 05:09:36');
INSERT INTO `ltm_translations` VALUES (2762, 1, 'fr', 'modules', 'client.startedOn', 'Commencé le', '2019-06-18 05:09:36', '2019-06-18 05:09:36');
INSERT INTO `ltm_translations` VALUES (2763, 1, 'fr', 'modules', 'client.updateTitle', 'Mettre à jour l\'information du client', '2019-06-18 05:09:36', '2019-06-18 05:09:36');
INSERT INTO `ltm_translations` VALUES (2764, 1, 'fr', 'modules', 'client.viewDetails', 'Voir les détails', '2019-06-18 05:09:36', '2019-06-18 05:09:36');
INSERT INTO `ltm_translations` VALUES (2765, 1, 'fr', 'modules', 'client.website', 'Site Internet', '2019-06-18 05:09:36', '2019-06-18 05:09:36');
INSERT INTO `ltm_translations` VALUES (2766, 1, 'fr', 'modules', 'contacts.addContact', 'Ajouter le contact', '2019-06-18 05:09:37', '2019-06-18 05:09:37');
INSERT INTO `ltm_translations` VALUES (2767, 1, 'fr', 'modules', 'contacts.contactName', 'Nom du contact', '2019-06-18 05:09:37', '2019-06-18 05:09:37');
INSERT INTO `ltm_translations` VALUES (2768, 1, 'fr', 'modules', 'currencySettings.addNewCurrency', 'Ajouter une nouvelle devise', '2019-06-18 05:09:37', '2019-06-18 05:09:37');
INSERT INTO `ltm_translations` VALUES (2769, 1, 'fr', 'modules', 'currencySettings.currencies', 'Devises', '2019-06-18 05:09:37', '2019-06-18 05:09:37');
INSERT INTO `ltm_translations` VALUES (2770, 1, 'fr', 'modules', 'currencySettings.currencyCode', 'Code de devise', '2019-06-18 05:09:37', '2019-06-18 05:09:37');
INSERT INTO `ltm_translations` VALUES (2771, 1, 'fr', 'modules', 'currencySettings.currencyName', 'Nom de la monnaie', '2019-06-18 05:09:37', '2019-06-18 05:09:37');
INSERT INTO `ltm_translations` VALUES (2772, 1, 'fr', 'modules', 'currencySettings.currencySymbol', 'Symbole de la monnaie', '2019-06-18 05:09:38', '2019-06-18 05:09:38');
INSERT INTO `ltm_translations` VALUES (2773, 1, 'fr', 'modules', 'currencySettings.updateTitle', 'Mettre à jour la monnaie', '2019-06-18 05:09:38', '2019-06-18 05:09:38');
INSERT INTO `ltm_translations` VALUES (2774, 1, 'fr', 'modules', 'currencySettings.exchangeRate', 'Taux de change', '2019-06-18 05:09:38', '2019-06-18 05:09:38');
INSERT INTO `ltm_translations` VALUES (2775, 1, 'fr', 'modules', 'currencySettings.cantDeleteDefault', 'Impossible de supprimer la devise par défaut.', '2019-06-18 05:09:38', '2019-06-18 05:09:38');
INSERT INTO `ltm_translations` VALUES (2776, 1, 'fr', 'modules', 'currencySettings.isCryptoCurrency', 'Est la Cryptocurrency', '2019-06-18 05:09:38', '2019-06-18 05:09:38');
INSERT INTO `ltm_translations` VALUES (2777, 1, 'fr', 'modules', 'currencySettings.usdPrice', 'Usd Prix', '2019-06-18 05:09:38', '2019-06-18 05:09:38');
INSERT INTO `ltm_translations` VALUES (2778, 1, 'fr', 'modules', 'currencySettings.usdPriceInfo', 'Obligatoire pour calculer les revenus.', '2019-06-18 05:09:38', '2019-06-18 05:09:38');
INSERT INTO `ltm_translations` VALUES (2779, 1, 'fr', 'modules', 'dashboard.dueDate', 'Date d\'échéance', '2019-06-18 05:09:38', '2019-06-18 05:09:38');
INSERT INTO `ltm_translations` VALUES (2780, 1, 'fr', 'modules', 'dashboard.overdueTasks', 'Tâches en retard', '2019-06-18 05:09:38', '2019-06-18 05:09:38');
INSERT INTO `ltm_translations` VALUES (2781, 1, 'fr', 'modules', 'dashboard.pendingClientIssues', 'Questions en suspens', '2019-06-18 05:09:38', '2019-06-18 05:09:38');
INSERT INTO `ltm_translations` VALUES (2782, 1, 'fr', 'modules', 'dashboard.projectActivityTimeline', 'Chronologie de l\'activité de projet', '2019-06-18 05:09:39', '2019-06-18 05:09:39');
INSERT INTO `ltm_translations` VALUES (2783, 1, 'fr', 'modules', 'dashboard.recentEarnings', 'Gains récents', '2019-06-18 05:09:39', '2019-06-18 05:09:39');
INSERT INTO `ltm_translations` VALUES (2784, 1, 'fr', 'modules', 'dashboard.totalClients', 'Total des clients', '2019-06-18 05:09:39', '2019-06-18 05:09:39');
INSERT INTO `ltm_translations` VALUES (2785, 1, 'fr', 'modules', 'dashboard.totalCompletedTasks', 'Total des tâches terminées', '2019-06-18 05:09:39', '2019-06-18 05:09:39');
INSERT INTO `ltm_translations` VALUES (2786, 1, 'fr', 'modules', 'dashboard.totalEmployees', 'Total des employés', '2019-06-18 05:09:39', '2019-06-18 05:09:39');
INSERT INTO `ltm_translations` VALUES (2787, 1, 'fr', 'modules', 'dashboard.totalHoursLogged', 'Total des heures enregistrées', '2019-06-18 05:09:39', '2019-06-18 05:09:39');
INSERT INTO `ltm_translations` VALUES (2788, 1, 'fr', 'modules', 'dashboard.totalOutstandingAmount', 'Montant total en souffrance', '2019-06-18 05:09:40', '2019-06-18 05:09:40');
INSERT INTO `ltm_translations` VALUES (2789, 1, 'fr', 'modules', 'dashboard.totalPaidAmount', 'Montant total payé', '2019-06-18 05:09:40', '2019-06-18 05:09:40');
INSERT INTO `ltm_translations` VALUES (2790, 1, 'fr', 'modules', 'dashboard.totalPaidInvoices', 'Total des factures payées', '2019-06-18 05:09:40', '2019-06-18 05:09:40');
INSERT INTO `ltm_translations` VALUES (2791, 1, 'fr', 'modules', 'dashboard.totalPendingIssues', 'Total des problèmes en attente', '2019-06-18 05:09:40', '2019-06-18 05:09:40');
INSERT INTO `ltm_translations` VALUES (2792, 1, 'fr', 'modules', 'dashboard.totalPendingTasks', 'Total des tâches en attente', '2019-06-18 05:09:40', '2019-06-18 05:09:40');
INSERT INTO `ltm_translations` VALUES (2793, 1, 'fr', 'modules', 'dashboard.totalProjects', 'Projets totaux', '2019-06-18 05:09:40', '2019-06-18 05:09:40');
INSERT INTO `ltm_translations` VALUES (2794, 1, 'fr', 'modules', 'dashboard.userActivityTimeline', 'Chronologie de l\'activité utilisateur', '2019-06-18 05:09:40', '2019-06-18 05:09:40');
INSERT INTO `ltm_translations` VALUES (2795, 1, 'fr', 'modules', 'dashboard.weatherSetLocation', 'Définir l\'emplacement actuel pour voir la météo', '2019-06-18 05:09:40', '2019-06-18 05:09:40');
INSERT INTO `ltm_translations` VALUES (2796, 1, 'fr', 'modules', 'dashboard.totalTodayAttendance', 'Présence aujourd\'hui', '2019-06-18 05:09:40', '2019-06-18 05:09:40');
INSERT INTO `ltm_translations` VALUES (2797, 1, 'fr', 'modules', 'dashboard.newTickets', 'Nouveaux billets', '2019-06-18 05:09:40', '2019-06-18 05:09:40');
INSERT INTO `ltm_translations` VALUES (2798, 1, 'fr', 'modules', 'emailSettings.configTitle', 'Configuration du courrier', '2019-06-18 05:09:41', '2019-06-18 05:09:41');
INSERT INTO `ltm_translations` VALUES (2799, 1, 'fr', 'modules', 'emailSettings.mailDriver', 'Conducteur de courrier', '2019-06-18 05:09:41', '2019-06-18 05:09:41');
INSERT INTO `ltm_translations` VALUES (2800, 1, 'fr', 'modules', 'emailSettings.mailEncryption', 'Cryptage du courrier', '2019-06-18 05:09:41', '2019-06-18 05:09:41');
INSERT INTO `ltm_translations` VALUES (2801, 1, 'fr', 'modules', 'emailSettings.mailFrom', 'Courrier du nom', '2019-06-18 05:09:42', '2019-06-18 05:09:42');
INSERT INTO `ltm_translations` VALUES (2802, 1, 'fr', 'modules', 'emailSettings.mailHost', 'Hôte du courrier', '2019-06-18 05:09:42', '2019-06-18 05:09:42');
INSERT INTO `ltm_translations` VALUES (2803, 1, 'fr', 'modules', 'emailSettings.mailPassword', 'Mot de passe du courrier électronique', '2019-06-18 05:09:42', '2019-06-18 05:09:42');
INSERT INTO `ltm_translations` VALUES (2804, 1, 'fr', 'modules', 'emailSettings.mailPort', 'Mail Port', '2019-06-18 05:09:42', '2019-06-18 05:09:42');
INSERT INTO `ltm_translations` VALUES (2805, 1, 'fr', 'modules', 'emailSettings.mailUsername', 'Nom d\'utilisateur du courrier électronique', '2019-06-18 05:09:42', '2019-06-18 05:09:42');
INSERT INTO `ltm_translations` VALUES (2806, 1, 'fr', 'modules', 'emailSettings.notificationSubtitle', 'Sélectionnez les événements pour lesquels un courrier électronique doit être envoyé à l\'utilisateur.', '2019-06-18 05:09:43', '2019-06-18 05:09:43');
INSERT INTO `ltm_translations` VALUES (2807, 1, 'fr', 'modules', 'emailSettings.notificationTitle', 'Définir les paramètres de notification par courrier électronique', '2019-06-18 05:09:43', '2019-06-18 05:09:43');
INSERT INTO `ltm_translations` VALUES (2808, 1, 'fr', 'modules', 'emailSettings.userRegistration', 'Enregistrement d\'utilisateur / Ajouté par Admin', '2019-06-18 05:09:43', '2019-06-18 05:09:43');
INSERT INTO `ltm_translations` VALUES (2809, 1, 'fr', 'modules', 'emailSettings.employeeAssign', 'Employee Assign to Project', '2019-06-18 05:09:43', '2019-06-18 05:09:43');
INSERT INTO `ltm_translations` VALUES (2810, 1, 'fr', 'modules', 'emailSettings.newNotice', 'Nouveau avis publié', '2019-06-18 05:09:43', '2019-06-18 05:09:43');
INSERT INTO `ltm_translations` VALUES (2811, 1, 'fr', 'modules', 'emailSettings.expenseAdded', 'Nouvelle dépense (ajoutée par l\'administrateur)', '2019-06-18 05:09:43', '2019-06-18 05:09:43');
INSERT INTO `ltm_translations` VALUES (2812, 1, 'fr', 'modules', 'emailSettings.expenseMember', 'Nouvelle dépense (ajoutée par le membre)', '2019-06-18 05:09:43', '2019-06-18 05:09:43');
INSERT INTO `ltm_translations` VALUES (2813, 1, 'fr', 'modules', 'emailSettings.expenseStatus', 'État des dépenses changé', '2019-06-18 05:09:43', '2019-06-18 05:09:43');
INSERT INTO `ltm_translations` VALUES (2814, 1, 'fr', 'modules', 'emailSettings.ticketRequest', 'Nouvelle demande de ticket de support', '2019-06-18 05:09:43', '2019-06-18 05:09:43');
INSERT INTO `ltm_translations` VALUES (2815, 1, 'fr', 'modules', 'emailSettings.taskAssign', 'Affectation utilisateur à la tâche', '2019-06-18 05:09:43', '2019-06-18 05:09:43');
INSERT INTO `ltm_translations` VALUES (2816, 1, 'fr', 'modules', 'emailSettings.mailFromEmail', 'Courrier électronique', '2019-06-18 05:09:44', '2019-06-18 05:09:44');
INSERT INTO `ltm_translations` VALUES (2817, 1, 'fr', 'modules', 'emailSettings.leaveRequest', 'Laisser la demande reçue', '2019-06-18 05:09:44', '2019-06-18 05:09:44');
INSERT INTO `ltm_translations` VALUES (2818, 1, 'fr', 'modules', 'emailSettings.taskComplete', 'Tâche terminée', '2019-06-18 05:09:44', '2019-06-18 05:09:44');
INSERT INTO `ltm_translations` VALUES (2819, 1, 'fr', 'modules', 'employees.activity', 'Activité', '2019-06-18 05:09:44', '2019-06-18 05:09:44');
INSERT INTO `ltm_translations` VALUES (2820, 1, 'fr', 'modules', 'employees.addNewEmployee', 'Ajouter un nouvel employé', '2019-06-18 05:09:44', '2019-06-18 05:09:44');
INSERT INTO `ltm_translations` VALUES (2821, 1, 'fr', 'modules', 'employees.createTitle', 'Ajouter des informations sur l\'employé', '2019-06-18 05:09:44', '2019-06-18 05:09:44');
INSERT INTO `ltm_translations` VALUES (2822, 1, 'fr', 'modules', 'employees.emailNote', 'L\'employé se connectera en utilisant ce courrier électronique.', '2019-06-18 05:09:44', '2019-06-18 05:09:44');
INSERT INTO `ltm_translations` VALUES (2823, 1, 'fr', 'modules', 'employees.employeeEmail', 'Courriel de l\'employé', '2019-06-18 05:09:44', '2019-06-18 05:09:44');
INSERT INTO `ltm_translations` VALUES (2824, 1, 'fr', 'modules', 'employees.employeeName', 'Nom de l\'employé', '2019-06-18 05:09:44', '2019-06-18 05:09:44');

-- ----------------------------
-- Table structure for message_settings
-- ----------------------------
DROP TABLE IF EXISTS `message_settings`;
CREATE TABLE `message_settings`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `company_id` int(10) UNSIGNED NULL DEFAULT NULL,
  `allow_client_admin` enum('yes','no') CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT 'no',
  `allow_client_employee` enum('yes','no') CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT 'no',
  `created_at` timestamp(0) NULL DEFAULT NULL,
  `updated_at` timestamp(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `message_settings_company_id_foreign`(`company_id`) USING BTREE,
  CONSTRAINT `message_settings_company_id_foreign` FOREIGN KEY (`company_id`) REFERENCES `companies` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8 COLLATE = utf8_unicode_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of message_settings
-- ----------------------------
INSERT INTO `message_settings` VALUES (1, NULL, 'no', 'no', '2019-06-16 06:25:42', '2019-06-16 06:25:42');
INSERT INTO `message_settings` VALUES (2, 1, 'yes', 'yes', '2019-06-16 06:34:23', '2019-06-22 05:38:48');

-- ----------------------------
-- Table structure for migrations
-- ----------------------------
DROP TABLE IF EXISTS `migrations`;
CREATE TABLE `migrations`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `migration` varchar(191) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `batch` int(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 298 CHARACTER SET = utf8 COLLATE = utf8_unicode_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of migrations
-- ----------------------------
INSERT INTO `migrations` VALUES (1, '2014_04_02_193003_create_countries_table', 1);
INSERT INTO `migrations` VALUES (2, '2014_04_02_193005_create_translations_table', 1);
INSERT INTO `migrations` VALUES (3, '2014_10_12_000000_create_users_table', 1);
INSERT INTO `migrations` VALUES (4, '2014_10_12_100000_create_password_resets_table', 1);
INSERT INTO `migrations` VALUES (5, '2016_06_20_112951_create_user_chat_table', 1);
INSERT INTO `migrations` VALUES (6, '2017_03_23_110416_add_column_users_table', 1);
INSERT INTO `migrations` VALUES (7, '2017_03_23_111036_create_client_details_table', 1);
INSERT INTO `migrations` VALUES (8, '2017_03_23_112028_create_client_contacts_table', 1);
INSERT INTO `migrations` VALUES (9, '2017_03_23_112353_create_employee_details_table', 1);
INSERT INTO `migrations` VALUES (10, '2017_03_23_114438_create_organisation_settings_table', 1);
INSERT INTO `migrations` VALUES (11, '2017_03_23_122646_create_project_category_table', 1);
INSERT INTO `migrations` VALUES (12, '2017_03_23_123601_create_projects_table', 1);
INSERT INTO `migrations` VALUES (13, '2017_03_23_125424_create_project_members_table', 1);
INSERT INTO `migrations` VALUES (14, '2017_03_23_125625_create_project_time_logs_table', 1);
INSERT INTO `migrations` VALUES (15, '2017_03_23_130413_create_project_files_table', 1);
INSERT INTO `migrations` VALUES (16, '2017_03_24_051800_create_tasks_table', 1);
INSERT INTO `migrations` VALUES (17, '2017_03_24_054355_create_notices_table', 1);
INSERT INTO `migrations` VALUES (18, '2017_03_24_055005_create_conversation_table', 1);
INSERT INTO `migrations` VALUES (19, '2017_03_24_055539_create_conversation_reply_table', 1);
INSERT INTO `migrations` VALUES (20, '2017_03_24_055859_create_invoices_table', 1);
INSERT INTO `migrations` VALUES (21, '2017_03_24_060421_create_invoice_items_table', 1);
INSERT INTO `migrations` VALUES (22, '2017_03_24_060751_create_quotations_table', 1);
INSERT INTO `migrations` VALUES (23, '2017_03_24_061241_create_quotation_items_table', 1);
INSERT INTO `migrations` VALUES (24, '2017_03_24_061505_create_sticky_notes_table', 1);
INSERT INTO `migrations` VALUES (25, '2017_03_24_064541_create_issues_table', 1);
INSERT INTO `migrations` VALUES (26, '2017_03_29_123858_entrust_setup_tables', 1);
INSERT INTO `migrations` VALUES (27, '2017_04_04_193158_AddColumnsProjectFilesTable', 1);
INSERT INTO `migrations` VALUES (28, '2017_04_05_063103_change_clientid_projectid_invoice_table', 1);
INSERT INTO `migrations` VALUES (29, '2017_04_06_051401_add_discount_column_invoice_table', 1);
INSERT INTO `migrations` VALUES (30, '2017_04_06_054728_add_status_column_issues_table', 1);
INSERT INTO `migrations` VALUES (31, '2017_04_08_152902_add_total_hours_column_time_log_table', 1);
INSERT INTO `migrations` VALUES (32, '2017_04_18_095809_create_project_activity_table', 1);
INSERT INTO `migrations` VALUES (33, '2017_04_18_103815_create_user_activities_table', 1);
INSERT INTO `migrations` VALUES (34, '2017_04_19_101519_create_email_notification_settings_table', 1);
INSERT INTO `migrations` VALUES (35, '2017_04_20_185211_add_colour_column_sticky_notes_table', 1);
INSERT INTO `migrations` VALUES (36, '2017_04_28_114154_create_notifications_table', 1);
INSERT INTO `migrations` VALUES (37, '2017_05_03_131016_add_project_completion_field_projects', 1);
INSERT INTO `migrations` VALUES (38, '2017_05_03_174333_create_currencies_table', 1);
INSERT INTO `migrations` VALUES (39, '2017_05_05_124330_create_module_settings_table', 1);
INSERT INTO `migrations` VALUES (40, '2017_05_05_233111_add_status_column_invoices', 1);
INSERT INTO `migrations` VALUES (41, '2017_05_11_140502_add_currency_symbol_column_invoices', 1);
INSERT INTO `migrations` VALUES (42, '2017_05_11_170244_add_currency_id_column_organisation_settings_table', 1);
INSERT INTO `migrations` VALUES (43, '2017_05_22_172748_add_timezone_column_settings_table', 1);
INSERT INTO `migrations` VALUES (44, '2017_05_24_120216_create_smtp_settings_table', 1);
INSERT INTO `migrations` VALUES (45, '2017_05_31_112158_create_universal_search_table', 1);
INSERT INTO `migrations` VALUES (46, '2017_06_22_131112_add_locale_organisation_settings_table', 1);
INSERT INTO `migrations` VALUES (47, '2017_07_13_091922_add_calculate_task_progress_column_project_table', 1);
INSERT INTO `migrations` VALUES (48, '2017_07_20_093528_on_delete_setnull_timelog', 1);
INSERT INTO `migrations` VALUES (49, '2017_07_21_120958_create_theme_settings_table', 1);
INSERT INTO `migrations` VALUES (50, '2017_07_24_113657_add_link_color_column_theme_settings_table', 1);
INSERT INTO `migrations` VALUES (51, '2017_07_24_123050_add_login_background_organisation_settings_table', 1);
INSERT INTO `migrations` VALUES (52, '2017_07_27_101351_add_column_type_invoice_items_table', 1);
INSERT INTO `migrations` VALUES (53, '2017_07_28_102010_create_estimates_table', 1);
INSERT INTO `migrations` VALUES (54, '2017_07_28_103230_create_estimate_items_table', 1);
INSERT INTO `migrations` VALUES (55, '2017_08_04_064431_create_payments_table', 1);
INSERT INTO `migrations` VALUES (56, '2017_08_05_103940_create_payment_gateway_credential_table', 1);
INSERT INTO `migrations` VALUES (57, '2017_08_08_055908_add_enable_paypal_column_payment_gateway_table', 1);
INSERT INTO `migrations` VALUES (58, '2017_08_09_054230_create_expenses_table', 1);
INSERT INTO `migrations` VALUES (59, '2017_08_21_065430_add_exchange_rate_column_currency_table', 1);
INSERT INTO `migrations` VALUES (60, '2017_08_21_131318_create_invoice_setting_table', 1);
INSERT INTO `migrations` VALUES (61, '2017_08_22_055908_add_expense_email_setting_to_email_notification_setting_table', 1);
INSERT INTO `migrations` VALUES (62, '2017_08_28_110759_add_recurring_columns_in_invoice_table', 1);
INSERT INTO `migrations` VALUES (63, '2017_08_30_061016_add_plan_id_to_payments_table', 1);
INSERT INTO `migrations` VALUES (64, '2017_08_30_093400_create_settings_table', 1);
INSERT INTO `migrations` VALUES (65, '2017_08_30_123956_add_slack_username_column_employee_details_table', 1);
INSERT INTO `migrations` VALUES (66, '2017_08_30_133725_add_send_slack_column_email_notification_settings_table', 1);
INSERT INTO `migrations` VALUES (67, '2017_09_01_060715_add_stipe_column_to_payment_credentials_table', 1);
INSERT INTO `migrations` VALUES (68, '2017_09_01_090124_add_customer_id_column_to_payments_table', 1);
INSERT INTO `migrations` VALUES (69, '2017_09_02_084049_add_locale_column_users_table', 1);
INSERT INTO `migrations` VALUES (70, '2017_09_14_095429_create_ticket_reply_templates_table', 1);
INSERT INTO `migrations` VALUES (71, '2017_09_14_095815_create_ticket_types_table', 1);
INSERT INTO `migrations` VALUES (72, '2017_09_14_100400_create_ticket_groups_table', 1);
INSERT INTO `migrations` VALUES (73, '2017_09_14_100530_create_ticket_tag_list_table', 1);
INSERT INTO `migrations` VALUES (74, '2017_09_14_114900_create_ticket_channels_table', 1);
INSERT INTO `migrations` VALUES (75, '2017_09_14_115003_create_ticket_agent_groups_table', 1);
INSERT INTO `migrations` VALUES (76, '2017_09_14_115004_create_tickets_table', 1);
INSERT INTO `migrations` VALUES (77, '2017_09_14_115005_create_ticket_tags_table', 1);
INSERT INTO `migrations` VALUES (78, '2017_09_18_064917_add_status_column_ticket_agent_group_table', 1);
INSERT INTO `migrations` VALUES (79, '2017_09_24_101700_create_ticket_replies_table', 1);
INSERT INTO `migrations` VALUES (80, '2017_09_25_060229_drop_description_column_ticket_table', 1);
INSERT INTO `migrations` VALUES (81, '2017_09_25_072611_add_deleted_at_column_tickets', 1);
INSERT INTO `migrations` VALUES (82, '2017_09_25_072627_add_deleted_at_column_ticket_reply', 1);
INSERT INTO `migrations` VALUES (83, '2017_10_03_094922_ticket_notification_migration', 1);
INSERT INTO `migrations` VALUES (84, '2017_10_03_134003_add_latitude_longitude_column', 1);
INSERT INTO `migrations` VALUES (85, '2017_10_12_111741_create_attendance_setting_table', 1);
INSERT INTO `migrations` VALUES (86, '2017_10_13_051909_create_attendance_table', 1);
INSERT INTO `migrations` VALUES (87, '2017_10_26_051335_add_mail_from_email_column_smtp_settings_table', 1);
INSERT INTO `migrations` VALUES (88, '2017_10_26_112253_add_office_open_days_column_attendance_settings_table', 1);
INSERT INTO `migrations` VALUES (89, '2017_11_01_054603_add_columns_to_client_details', 1);
INSERT INTO `migrations` VALUES (90, '2017_11_02_045542_change_on_cascade_project_members', 1);
INSERT INTO `migrations` VALUES (91, '2017_11_07_054438_add_project_admin_column_project_table', 1);
INSERT INTO `migrations` VALUES (92, '2017_11_07_125619_remove_project_admin_role', 1);
INSERT INTO `migrations` VALUES (93, '2017_11_08_045549_make_project_id_nullable_tasks_table', 1);
INSERT INTO `migrations` VALUES (94, '2017_11_09_071318_create_taskboard_columns_table', 1);
INSERT INTO `migrations` VALUES (95, '2017_11_09_092817_add_column_tasks_table', 1);
INSERT INTO `migrations` VALUES (96, '2017_11_20_070830_create_custom_fields_table', 1);
INSERT INTO `migrations` VALUES (97, '2017_11_20_071758_create_custom_fields__data_table', 1);
INSERT INTO `migrations` VALUES (98, '2017_11_22_071535_create_events_table', 1);
INSERT INTO `migrations` VALUES (99, '2017_11_23_065323_add_cryptocurrency_columns', 1);
INSERT INTO `migrations` VALUES (100, '2017_11_24_103957_create_event_attendees_table', 1);
INSERT INTO `migrations` VALUES (101, '2017_12_07_034433_change cascade users in time log table', 1);
INSERT INTO `migrations` VALUES (102, '2017_12_12_071823_create_modules_table', 1);
INSERT INTO `migrations` VALUES (103, '2017_12_12_073501_add_module_id_column_permissions_table', 1);
INSERT INTO `migrations` VALUES (104, '2017_12_21_114839_change_upload_folder', 1);
INSERT INTO `migrations` VALUES (105, '2017_12_28_112910_create_leave_types_table', 1);
INSERT INTO `migrations` VALUES (106, '2017_12_30_184422_create_leaves_table', 1);
INSERT INTO `migrations` VALUES (107, '2018_01_02_122442_add_leaves_notification_setting', 1);
INSERT INTO `migrations` VALUES (108, '2018_01_05_062543_add_user_css_column_theme_settings', 1);
INSERT INTO `migrations` VALUES (109, '2018_01_09_180937_add_task_completed_notification_setting', 1);
INSERT INTO `migrations` VALUES (110, '2018_01_29_073527_create_message_setting_table', 1);
INSERT INTO `migrations` VALUES (111, '2018_04_12_100452_add_dropbox_link_column_project_files_table', 1);
INSERT INTO `migrations` VALUES (112, '2018_04_12_123243_create_file_storage_table', 1);
INSERT INTO `migrations` VALUES (113, '2018_04_13_072732_create_groups_table', 1);
INSERT INTO `migrations` VALUES (114, '2018_04_13_092757_create_employee_groups_table', 1);
INSERT INTO `migrations` VALUES (115, '2018_04_17_113657_set_attendance_late_column_default', 1);
INSERT INTO `migrations` VALUES (116, '2018_05_07_065407_alter_invoice_id_null_payments', 1);
INSERT INTO `migrations` VALUES (117, '2018_05_07_065557_add_currency_id_column_payments_table', 1);
INSERT INTO `migrations` VALUES (118, '2018_05_08_064539_add_note_column_invoices', 1);
INSERT INTO `migrations` VALUES (119, '2018_05_15_072536_add_project_id_column_payments', 1);
INSERT INTO `migrations` VALUES (120, '2018_05_28_094515_set_gateway_column_null_payments_table', 1);
INSERT INTO `migrations` VALUES (121, '2018_05_29_070343_change_completed_on_column_to_datetime', 1);
INSERT INTO `migrations` VALUES (122, '2018_05_29_114402_populate_file_storage_settings_table', 1);
INSERT INTO `migrations` VALUES (123, '2018_05_30_051128_add_google_url_to_project_files_table', 1);
INSERT INTO `migrations` VALUES (124, '2018_06_05_092136_create_sub_tasks_table', 1);
INSERT INTO `migrations` VALUES (125, '2018_06_06_091511_create_task_comments_table', 1);
INSERT INTO `migrations` VALUES (126, '2018_06_11_054204_create_push_subscriptions_table', 1);
INSERT INTO `migrations` VALUES (127, '2018_06_14_094059_create_taxes_table', 1);
INSERT INTO `migrations` VALUES (128, '2018_06_18_065034_add_tax_id_column_invoice_items_table', 1);
INSERT INTO `migrations` VALUES (129, '2018_06_18_071442_add_discount_column_invoice_items_table', 1);
INSERT INTO `migrations` VALUES (130, '2018_06_21_052408_change_default_taskboard_columns', 1);
INSERT INTO `migrations` VALUES (131, '2018_06_26_160023_add_leave_count_column_leave_types_table', 1);
INSERT INTO `migrations` VALUES (132, '2018_06_27_072813_add_leaves_start_from_column', 1);
INSERT INTO `migrations` VALUES (133, '2018_06_27_075233_add_joining_date_column', 1);
INSERT INTO `migrations` VALUES (134, '2018_06_27_113713_add_gender_column_users_table', 1);
INSERT INTO `migrations` VALUES (135, '2018_06_28_054604_add_client_view_task_column_project_table', 1);
INSERT INTO `migrations` VALUES (136, '2018_06_28_191256_create_language_settings_table', 1);
INSERT INTO `migrations` VALUES (137, '2018_06_29_060331_add_active_theme_column_settings', 1);
INSERT INTO `migrations` VALUES (138, '2018_06_29_081128_add_manual_timelog_column_project_timelog', 1);
INSERT INTO `migrations` VALUES (139, '2018_06_29_104709_seed_languages', 1);
INSERT INTO `migrations` VALUES (140, '2018_08_02_121259_add_minutes_column_time_log_table', 1);
INSERT INTO `migrations` VALUES (141, '2018_08_22_103829_add_leaves_module', 1);
INSERT INTO `migrations` VALUES (142, '2018_08_22_104302_add_leaves_permissions', 1);
INSERT INTO `migrations` VALUES (143, '2018_08_27_114329_add_module_list_in_module_settings', 1);
INSERT INTO `migrations` VALUES (144, '2018_08_30_065158_add_status_column_users_table', 1);
INSERT INTO `migrations` VALUES (145, '2018_08_31_095814_create_lead_table', 1);
INSERT INTO `migrations` VALUES (146, '2018_08_31_095815_create_lead_source_table', 1);
INSERT INTO `migrations` VALUES (147, '2018_08_31_095815_create_lead_status_table', 1);
INSERT INTO `migrations` VALUES (148, '2018_08_31_095816_create_lead_follow_up_table', 1);
INSERT INTO `migrations` VALUES (149, '2018_09_04_095158_alter_lead_table', 1);
INSERT INTO `migrations` VALUES (150, '2018_09_04_095816_add_lead_module', 1);
INSERT INTO `migrations` VALUES (151, '2018_09_05_102010_create_proposal_table', 1);
INSERT INTO `migrations` VALUES (152, '2018_09_05_113230_create_proposal_items_table', 1);
INSERT INTO `migrations` VALUES (153, '2018_09_07_051239_alter_lead_website_table', 1);
INSERT INTO `migrations` VALUES (154, '2018_09_15_174026_add_default_lead_settings', 1);
INSERT INTO `migrations` VALUES (155, '2018_09_17_045718_add_leads_permission', 1);
INSERT INTO `migrations` VALUES (156, '2018_09_19_091643_add_remarks_to_payments_table', 1);
INSERT INTO `migrations` VALUES (157, '2018_09_19_100708_create_products_table', 1);
INSERT INTO `migrations` VALUES (158, '2018_09_21_095816_create_offline_payment_method_table', 1);
INSERT INTO `migrations` VALUES (159, '2018_09_25_065158_alter_payment_table', 1);
INSERT INTO `migrations` VALUES (160, '2018_09_28_110029_create_log_time_for_table', 1);
INSERT INTO `migrations` VALUES (161, '2018_09_28_965158_alter_project_time_log_table', 1);
INSERT INTO `migrations` VALUES (162, '2018_10_03_121901_create_packages_table', 1);
INSERT INTO `migrations` VALUES (163, '2018_10_03_121902_alter_organisation_settings_table', 1);
INSERT INTO `migrations` VALUES (164, '2018_10_04_042418_create_licences_table', 1);
INSERT INTO `migrations` VALUES (165, '2018_10_04_082754_add_super_admin_column_in_users_table', 1);
INSERT INTO `migrations` VALUES (166, '2018_10_08_091643_alter_project_table', 1);
INSERT INTO `migrations` VALUES (167, '2018_10_08_095950_create_subscriptions_table', 1);
INSERT INTO `migrations` VALUES (168, '2018_10_08_110029_create_lead_files_table', 1);
INSERT INTO `migrations` VALUES (169, '2018_10_08_120639_add_company_id_in_users_table', 1);
INSERT INTO `migrations` VALUES (170, '2018_10_10_110029_create_holidays_table', 1);
INSERT INTO `migrations` VALUES (171, '2018_10_10_114514_add_company_id_in_teams_table', 1);
INSERT INTO `migrations` VALUES (172, '2018_10_10_120621_add_company_id_in_leads_table', 1);
INSERT INTO `migrations` VALUES (173, '2018_10_10_123601_create_project_templates_table', 1);
INSERT INTO `migrations` VALUES (174, '2018_10_10_125424_create_project_template_members_table', 1);
INSERT INTO `migrations` VALUES (175, '2018_10_10_135816_add_holiday_module', 1);
INSERT INTO `migrations` VALUES (176, '2018_10_10_251800_create_project_template_tasks_table', 1);
INSERT INTO `migrations` VALUES (177, '2018_10_11_044355_add_company_id_in_attendances_table', 1);
INSERT INTO `migrations` VALUES (178, '2018_10_11_055814_add_company_id_in_holidays_table', 1);
INSERT INTO `migrations` VALUES (179, '2018_10_11_061029_add_company_id_in_projects_table', 1);
INSERT INTO `migrations` VALUES (180, '2018_10_11_061955_add_company_id_in_project_category_table', 1);
INSERT INTO `migrations` VALUES (181, '2018_10_11_063520_add_company_id_in_project_members_table', 1);
INSERT INTO `migrations` VALUES (182, '2018_10_11_065229_add_company_id_in_invoices_table', 1);
INSERT INTO `migrations` VALUES (183, '2018_10_11_070557_add_company_id_in_project_activity_table', 1);
INSERT INTO `migrations` VALUES (184, '2018_10_11_071656_add_company_id_in_products_table', 1);
INSERT INTO `migrations` VALUES (185, '2018_10_11_072547_add_company_id_in_taxes_table', 1);
INSERT INTO `migrations` VALUES (186, '2018_10_11_081816_add_company_id_in_tasks_table', 1);
INSERT INTO `migrations` VALUES (187, '2018_10_11_083600_add_company_id_in_taskboard_columns_table', 1);
INSERT INTO `migrations` VALUES (188, '2018_10_11_100425_add_company_id_in_estimates_table', 1);
INSERT INTO `migrations` VALUES (189, '2018_10_11_101701_add_company_id_in_payments_table', 1);
INSERT INTO `migrations` VALUES (190, '2018_10_11_102047_add_company_id_in_expenses_table', 1);
INSERT INTO `migrations` VALUES (191, '2018_10_11_110008_add_company_id_in_employee_details_table', 1);
INSERT INTO `migrations` VALUES (192, '2018_10_11_115208_add_company_id_in_project_time_logs_table', 1);
INSERT INTO `migrations` VALUES (193, '2018_10_11_115805_add_company_id_in_user_activities_table', 1);
INSERT INTO `migrations` VALUES (194, '2018_10_12_045341_add_company_id_in_tickets_table', 1);
INSERT INTO `migrations` VALUES (195, '2018_10_12_051409_add_company_id_in_ticket_channels_table', 1);
INSERT INTO `migrations` VALUES (196, '2018_10_12_052646_add_company_id_in_ticket_types_table', 1);
INSERT INTO `migrations` VALUES (197, '2018_10_12_060038_add_company_id_in_ticket_groups_table', 1);
INSERT INTO `migrations` VALUES (198, '2018_10_12_061136_add_company_id_in_ticket_agent_groups_table', 1);
INSERT INTO `migrations` VALUES (199, '2018_10_12_061807_add_company_id_in_ticket_reply_templates_table', 1);
INSERT INTO `migrations` VALUES (200, '2018_10_12_072321_add_company_id_in_events_table', 1);
INSERT INTO `migrations` VALUES (201, '2018_10_12_090132_add_company_id_in_leave_types_table', 1);
INSERT INTO `migrations` VALUES (202, '2018_10_12_090146_add_company_id_in_leaves_table', 1);
INSERT INTO `migrations` VALUES (203, '2018_10_12_093431_add_company_id_in_notices_table', 1);
INSERT INTO `migrations` VALUES (204, '2018_10_12_110433_add_company_id_in_email_notification_settings_table', 1);
INSERT INTO `migrations` VALUES (205, '2018_10_12_110842_add_company_id_in_smtp_settings_table', 1);
INSERT INTO `migrations` VALUES (206, '2018_10_15_051607_add_company_id_in_currencies_table', 1);
INSERT INTO `migrations` VALUES (207, '2018_10_15_052819_create_global_settings_table', 1);
INSERT INTO `migrations` VALUES (208, '2018_10_15_065737_add_company_id_in_theme_settings_table', 1);
INSERT INTO `migrations` VALUES (209, '2018_10_15_070856_alter_currency_id_in_companies_table', 1);
INSERT INTO `migrations` VALUES (210, '2018_10_15_083914_add_company_id_in_payment_gateway_credentials_table', 1);
INSERT INTO `migrations` VALUES (211, '2018_10_15_093625_add_company_id_in_invoice_settings_table', 1);
INSERT INTO `migrations` VALUES (212, '2018_10_15_094709_add_company_id_in_slack_settings_table', 1);
INSERT INTO `migrations` VALUES (213, '2018_10_15_105445_add_company_id_in_attendance_settings_table', 1);
INSERT INTO `migrations` VALUES (214, '2018_10_15_115927_add_company_id_in_custom_field_groups_table', 1);
INSERT INTO `migrations` VALUES (215, '2018_10_16_045235_add_company_id_in_module_settings_table', 1);
INSERT INTO `migrations` VALUES (216, '2018_10_16_071301_add_company_id_in_roles_table', 1);
INSERT INTO `migrations` VALUES (217, '2018_10_16_095816_add_holiday_module_detail', 1);
INSERT INTO `migrations` VALUES (218, '2018_10_17_043749_add_company_id_in_message_settings_table', 1);
INSERT INTO `migrations` VALUES (219, '2018_10_17_052214_add_company_id_in_file_storage_settings_table', 1);
INSERT INTO `migrations` VALUES (220, '2018_10_17_063334_add_company_id_in_lead_sources_table', 1);
INSERT INTO `migrations` VALUES (221, '2018_10_17_063359_add_company_id_in_lead_status_table', 1);
INSERT INTO `migrations` VALUES (222, '2018_10_17_081757_remove_config_datatable_file', 1);
INSERT INTO `migrations` VALUES (223, '2018_10_17_965158_alter_leads_address_table', 1);
INSERT INTO `migrations` VALUES (224, '2018_10_17_965168_alter_leads_phone_table', 1);
INSERT INTO `migrations` VALUES (225, '2018_10_18_034518_create_stripe_invoices_table', 1);
INSERT INTO `migrations` VALUES (226, '2018_10_18_075228_add_column_in_global_settings_table', 1);
INSERT INTO `migrations` VALUES (227, '2018_10_18_091643_alter_attendance_setting_table', 1);
INSERT INTO `migrations` VALUES (228, '2018_10_19_045718_add_holidays_permission', 1);
INSERT INTO `migrations` VALUES (229, '2018_10_20_094413_add_products_module', 1);
INSERT INTO `migrations` VALUES (230, '2018_10_20_094504_add_products_permissions', 1);
INSERT INTO `migrations` VALUES (231, '2018_10_21_051239_alter_holiday_website_table', 1);
INSERT INTO `migrations` VALUES (232, '2018_10_22_050933_alter_state_column_companies_table', 1);
INSERT INTO `migrations` VALUES (233, '2018_10_23_071525_remove_company_id_column_smtp_settings_table', 1);
INSERT INTO `migrations` VALUES (234, '2018_10_24_041117_add_column_email_verification_code_in_users_table', 1);
INSERT INTO `migrations` VALUES (235, '2018_10_24_071300_add_file_column_to_invoices_table', 1);
INSERT INTO `migrations` VALUES (236, '2018_10_24_965158_alter_employee_detail_table', 1);
INSERT INTO `migrations` VALUES (237, '2018_10_29_965158_alter_attendance_setting_default_table', 1);
INSERT INTO `migrations` VALUES (238, '2018_11_02_061629_add_column_in_proposals_table', 1);
INSERT INTO `migrations` VALUES (239, '2018_11_10_071300_alter_user_table', 1);
INSERT INTO `migrations` VALUES (240, '2018_11_10_122646_create_task_category_table', 1);
INSERT INTO `migrations` VALUES (241, '2018_11_15_105021_alter_stripe_invoices_table', 1);
INSERT INTO `migrations` VALUES (242, '2018_11_16_072246_add_company_id_in_client_details_table', 1);
INSERT INTO `migrations` VALUES (243, '2018_11_16_104747_add_column_in_estimate_items_table', 1);
INSERT INTO `migrations` VALUES (244, '2018_11_16_112847_add_column_in_proposals_items_table', 1);
INSERT INTO `migrations` VALUES (245, '2018_11_22_044348_add_estimate_number_column_in_estimates_table', 1);
INSERT INTO `migrations` VALUES (246, '2018_11_30_965158_alter_invoice_item_table', 1);
INSERT INTO `migrations` VALUES (247, '2018_12_12_965158_alter_invoice_estimate_response_table', 1);
INSERT INTO `migrations` VALUES (248, '2018_12_14_094504_add_expenses_permissions', 1);
INSERT INTO `migrations` VALUES (249, '2018_12_14_194504_add_expenses_permissions_detail', 1);
INSERT INTO `migrations` VALUES (250, '2018_12_20_1065158_alter_company_setting_table', 1);
INSERT INTO `migrations` VALUES (251, '2018_12_20_965158_alter_estimate_quantity_table', 1);
INSERT INTO `migrations` VALUES (252, '2018_12_27_074504_check_verify_purchase_file', 2);
INSERT INTO `migrations` VALUES (253, '2018_12_28_075730_create_push_notification_settings_table', 2);
INSERT INTO `migrations` VALUES (254, '2018_12_28_082056_add_send_push_column_email_notification_table', 2);
INSERT INTO `migrations` VALUES (255, '2018_12_28_123245_add_onesignal_player_id_column_users_table', 2);
INSERT INTO `migrations` VALUES (256, '2019_01_02_1065158_alter_module_setting_table', 2);
INSERT INTO `migrations` VALUES (257, '2019_01_02_2065158_insert_module_setting_client_table', 2);
INSERT INTO `migrations` VALUES (258, '2019_01_04_110029_create_employee_docs_table', 2);
INSERT INTO `migrations` VALUES (259, '2019_01_10_063520_add_company_id_in_lead_files_table', 2);
INSERT INTO `migrations` VALUES (260, '2019_01_17_045235_add_company_id_in_project_template_table', 2);
INSERT INTO `migrations` VALUES (261, '2019_01_17_055235_add_company_id_in_task_category_table', 2);
INSERT INTO `migrations` VALUES (262, '2019_01_17_065235_add_company_id_in_employee_docs_table', 2);
INSERT INTO `migrations` VALUES (263, '2019_01_17_075235_add_company_id_in_log_time_for_table', 2);
INSERT INTO `migrations` VALUES (264, '2019_01_21_1065158_alter_task_creator_table', 2);
INSERT INTO `migrations` VALUES (265, '2019_02_06_1065158_alter_attendance_check_table', 2);
INSERT INTO `migrations` VALUES (266, '2019_02_08_174333_create_global_currencies_table', 2);
INSERT INTO `migrations` VALUES (267, '2019_02_08_275235_add_currency_id_in_global_setting_table', 2);
INSERT INTO `migrations` VALUES (268, '2019_02_11_1065158_alter_log_time_for_table', 2);
INSERT INTO `migrations` VALUES (269, '2019_02_12_2065158_insert_module_setting_client_task_table', 2);
INSERT INTO `migrations` VALUES (270, '2019_02_13_110029_create_skills_table', 2);
INSERT INTO `migrations` VALUES (271, '2019_02_13_130029_create_employee_skills_table', 2);
INSERT INTO `migrations` VALUES (272, '2019_02_15_1065158_alter_employee_end_date_table', 2);
INSERT INTO `migrations` VALUES (273, '2019_02_15_1165158_alter_custom_status_table', 2);
INSERT INTO `migrations` VALUES (274, '2019_02_20_074848_create_jobs_table', 2);
INSERT INTO `migrations` VALUES (275, '2019_02_22_1165158_add_company_currency_api_google_api', 2);
INSERT INTO `migrations` VALUES (276, '2019_02_22_1165158_add_currency_api_google_api', 2);
INSERT INTO `migrations` VALUES (277, '2019_02_25_965158_alter_package_max_size_table', 2);
INSERT INTO `migrations` VALUES (278, '2019_02_28_965158_alter_package_sort_billing_cycle_table', 2);
INSERT INTO `migrations` VALUES (279, '2019_03_04_073501_change_module_id_notice_permissions_table', 2);
INSERT INTO `migrations` VALUES (280, '2019_03_05_110029_create_front_detail_table', 2);
INSERT INTO `migrations` VALUES (281, '2019_03_05_110039_create_feature_table', 2);
INSERT INTO `migrations` VALUES (282, '2019_03_08_1165158_create_stripe_table', 2);
INSERT INTO `migrations` VALUES (283, '2019_03_08_965158_alter_invoice_project_id_null_table', 2);
INSERT INTO `migrations` VALUES (284, '2019_03_11_132024_seed_front_end_data', 2);
INSERT INTO `migrations` VALUES (285, '2019_03_18_1165158_alter_stripe_setting_table', 2);
INSERT INTO `migrations` VALUES (286, '2019_03_19_061905_add_google_recaptcha_key_column_global_settings', 2);
INSERT INTO `migrations` VALUES (287, '2019_03_19_1265158_paypal_invoice_table', 2);
INSERT INTO `migrations` VALUES (288, '2019_04_03_965158_alter_project_deadline_table', 2);
INSERT INTO `migrations` VALUES (289, '2019_04_04_074848_alter_invoice_setting_table', 2);
INSERT INTO `migrations` VALUES (290, '2019_04_04_075848_alter_client_Details_table', 2);
INSERT INTO `migrations` VALUES (291, '2019_04_04_1165158_alter_package_default_table', 2);
INSERT INTO `migrations` VALUES (292, '2019_04_10_075848_alter_company_task_table', 2);
INSERT INTO `migrations` VALUES (293, '2019_04_17_1165158_create_package_setting_table', 2);
INSERT INTO `migrations` VALUES (294, '2019_04_22_075848_alter_package_setting_table', 2);
INSERT INTO `migrations` VALUES (295, '2019_08_22_055908_add_invoice_email_setting_to_email_notification_setting_table', 2);
INSERT INTO `migrations` VALUES (296, '2019_06_05_163256_add_timezone_column_global_settings_table', 3);
INSERT INTO `migrations` VALUES (297, '2019_06_05_180258_add_locale_column_global_settings_table', 3);

-- ----------------------------
-- Table structure for module_settings
-- ----------------------------
DROP TABLE IF EXISTS `module_settings`;
CREATE TABLE `module_settings`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `company_id` int(10) UNSIGNED NULL DEFAULT NULL,
  `module_name` varchar(191) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `status` enum('active','deactive') CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `type` enum('admin','employee','client') CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT 'admin',
  `created_at` timestamp(0) NULL DEFAULT NULL,
  `updated_at` timestamp(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `module_settings_company_id_foreign`(`company_id`) USING BTREE,
  CONSTRAINT `module_settings_company_id_foreign` FOREIGN KEY (`company_id`) REFERENCES `companies` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 151 CHARACTER SET = utf8 COLLATE = utf8_unicode_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of module_settings
-- ----------------------------
INSERT INTO `module_settings` VALUES (122, 1, 'clients', 'active', 'employee', '2019-06-18 11:12:38', '2019-06-18 11:12:38');
INSERT INTO `module_settings` VALUES (123, 1, 'clients', 'active', 'admin', '2019-06-18 11:12:38', '2019-06-18 11:12:38');
INSERT INTO `module_settings` VALUES (124, 1, 'employees', 'active', 'employee', '2019-06-18 11:12:38', '2019-06-18 11:12:38');
INSERT INTO `module_settings` VALUES (125, 1, 'employees', 'active', 'admin', '2019-06-18 11:12:38', '2019-06-18 11:12:38');
INSERT INTO `module_settings` VALUES (126, 1, 'projects', 'active', 'client', '2019-06-18 11:12:38', '2019-06-18 11:12:38');
INSERT INTO `module_settings` VALUES (127, 1, 'projects', 'active', 'employee', '2019-06-18 11:12:38', '2019-06-18 11:12:38');
INSERT INTO `module_settings` VALUES (128, 1, 'projects', 'active', 'admin', '2019-06-18 11:12:39', '2019-06-18 11:12:39');
INSERT INTO `module_settings` VALUES (129, 1, 'attendance', 'active', 'employee', '2019-06-18 11:12:39', '2019-06-18 11:12:39');
INSERT INTO `module_settings` VALUES (130, 1, 'attendance', 'active', 'admin', '2019-06-18 11:12:39', '2019-06-18 11:12:39');
INSERT INTO `module_settings` VALUES (131, 1, 'tasks', 'active', 'client', '2019-06-18 11:12:39', '2019-06-18 11:12:39');
INSERT INTO `module_settings` VALUES (132, 1, 'tasks', 'active', 'employee', '2019-06-18 11:12:39', '2019-06-18 11:12:39');
INSERT INTO `module_settings` VALUES (133, 1, 'tasks', 'active', 'admin', '2019-06-18 11:12:39', '2019-06-18 11:12:39');
INSERT INTO `module_settings` VALUES (134, 1, 'timelogs', 'active', 'employee', '2019-06-18 11:12:39', '2019-06-18 11:12:39');
INSERT INTO `module_settings` VALUES (135, 1, 'timelogs', 'active', 'admin', '2019-06-18 11:12:39', '2019-06-18 11:12:39');
INSERT INTO `module_settings` VALUES (136, 1, 'tickets', 'active', 'client', '2019-06-18 11:12:39', '2019-06-18 11:12:39');
INSERT INTO `module_settings` VALUES (137, 1, 'tickets', 'active', 'employee', '2019-06-18 11:12:39', '2019-06-18 11:12:39');
INSERT INTO `module_settings` VALUES (138, 1, 'tickets', 'active', 'admin', '2019-06-18 11:12:39', '2019-06-18 11:12:39');
INSERT INTO `module_settings` VALUES (139, 1, 'events', 'active', 'client', '2019-06-18 11:12:39', '2019-06-18 11:12:39');
INSERT INTO `module_settings` VALUES (140, 1, 'events', 'active', 'employee', '2019-06-18 11:12:39', '2019-06-18 11:12:39');
INSERT INTO `module_settings` VALUES (141, 1, 'events', 'active', 'admin', '2019-06-18 11:12:39', '2019-06-18 11:12:39');
INSERT INTO `module_settings` VALUES (142, 1, 'messages', 'active', 'client', '2019-06-18 11:12:40', '2019-06-18 11:12:40');
INSERT INTO `module_settings` VALUES (143, 1, 'messages', 'active', 'employee', '2019-06-18 11:12:40', '2019-06-18 11:12:40');
INSERT INTO `module_settings` VALUES (144, 1, 'messages', 'active', 'admin', '2019-06-18 11:12:40', '2019-06-18 11:12:40');
INSERT INTO `module_settings` VALUES (145, 1, 'notices', 'active', 'employee', '2019-06-18 11:12:40', '2019-06-18 11:12:40');
INSERT INTO `module_settings` VALUES (146, 1, 'notices', 'active', 'admin', '2019-06-18 11:12:40', '2019-06-18 11:12:40');
INSERT INTO `module_settings` VALUES (147, 1, 'leaves', 'active', 'employee', '2019-06-18 11:12:40', '2019-06-18 11:12:40');
INSERT INTO `module_settings` VALUES (148, 1, 'leaves', 'active', 'admin', '2019-06-18 11:12:40', '2019-06-18 11:12:40');
INSERT INTO `module_settings` VALUES (149, 1, 'holidays', 'active', 'employee', '2019-06-18 11:12:40', '2019-06-18 11:12:40');
INSERT INTO `module_settings` VALUES (150, 1, 'holidays', 'active', 'admin', '2019-06-18 11:12:40', '2019-06-18 11:12:40');

-- ----------------------------
-- Table structure for modules
-- ----------------------------
DROP TABLE IF EXISTS `modules`;
CREATE TABLE `modules`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `module_name` varchar(191) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `description` varchar(191) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT NULL,
  `created_at` timestamp(0) NULL DEFAULT NULL,
  `updated_at` timestamp(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 19 CHARACTER SET = utf8 COLLATE = utf8_unicode_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of modules
-- ----------------------------
INSERT INTO `modules` VALUES (1, 'clients', '', NULL, NULL);
INSERT INTO `modules` VALUES (2, 'employees', '', NULL, NULL);
INSERT INTO `modules` VALUES (3, 'projects', 'User can view the basic details of projects assigned to him even without any permission.', NULL, NULL);
INSERT INTO `modules` VALUES (4, 'attendance', 'User can view his own attendance even without any permission.', NULL, NULL);
INSERT INTO `modules` VALUES (5, 'tasks', 'User can view the tasks assigned to him even without any permission.', NULL, NULL);
INSERT INTO `modules` VALUES (6, 'estimates', '', NULL, NULL);
INSERT INTO `modules` VALUES (7, 'invoices', '', NULL, NULL);
INSERT INTO `modules` VALUES (8, 'payments', '', NULL, NULL);
INSERT INTO `modules` VALUES (9, 'timelogs', '', NULL, NULL);
INSERT INTO `modules` VALUES (10, 'tickets', 'User can view the tickets generated by him as default even without any permission.', NULL, NULL);
INSERT INTO `modules` VALUES (11, 'events', 'User can view the events to be attended by him as default even without any permission.', NULL, NULL);
INSERT INTO `modules` VALUES (12, 'messages', '', NULL, NULL);
INSERT INTO `modules` VALUES (13, 'notices', '', NULL, NULL);
INSERT INTO `modules` VALUES (14, 'leaves', 'User can view the leaves applied by him as default even without any permission.', NULL, NULL);
INSERT INTO `modules` VALUES (15, 'leads', NULL, NULL, NULL);
INSERT INTO `modules` VALUES (16, 'holidays', NULL, '2019-06-16 06:29:34', '2019-06-16 06:29:34');
INSERT INTO `modules` VALUES (17, 'products', NULL, '2019-06-16 06:29:34', '2019-06-16 06:29:34');
INSERT INTO `modules` VALUES (18, 'expenses', 'User can view and add(self expenses) the expenses as default even without any permission.', '2019-06-16 06:30:04', '2019-06-16 06:30:05');

-- ----------------------------
-- Table structure for notices
-- ----------------------------
DROP TABLE IF EXISTS `notices`;
CREATE TABLE `notices`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `company_id` int(10) UNSIGNED NULL DEFAULT NULL,
  `heading` varchar(191) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `description` mediumtext CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL,
  `created_at` timestamp(0) NULL DEFAULT NULL,
  `updated_at` timestamp(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `notices_company_id_foreign`(`company_id`) USING BTREE,
  CONSTRAINT `notices_company_id_foreign` FOREIGN KEY (`company_id`) REFERENCES `companies` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8 COLLATE = utf8_unicode_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of notices
-- ----------------------------
INSERT INTO `notices` VALUES (1, 1, 'Eid Holiday', 'Eid-Ul-Azha Holiday from 4th June to 7th June', '2019-06-20 08:35:52', '2019-06-20 08:35:52');

-- ----------------------------
-- Table structure for notifications
-- ----------------------------
DROP TABLE IF EXISTS `notifications`;
CREATE TABLE `notifications`  (
  `id` char(36) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `type` varchar(191) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `notifiable_type` varchar(191) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `notifiable_id` bigint(20) UNSIGNED NOT NULL,
  `data` text CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `read_at` timestamp(0) NULL DEFAULT NULL,
  `created_at` timestamp(0) NULL DEFAULT NULL,
  `updated_at` timestamp(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `notifications_notifiable_type_notifiable_id_index`(`notifiable_type`, `notifiable_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_unicode_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of notifications
-- ----------------------------
INSERT INTO `notifications` VALUES ('14ea2d8a-f0c4-44f0-aef4-e7b6c9b8d901', 'App\\Notifications\\TaskCompleted', 'App\\User', 9, '{\"id\":9,\"company_id\":1,\"heading\":\"Design System Architecture\",\"description\":\"<p>Design System Architecture<br><\\/p>\",\"due_date\":\"2019-06-27 00:00:00\",\"start_date\":\"2019-06-21 00:00:00\",\"user_id\":9,\"project_id\":2,\"task_category_id\":4,\"priority\":\"high\",\"status\":\"incomplete\",\"board_column_id\":4,\"column_priority\":0,\"completed_on\":\"2019-06-21 00:00:00\",\"created_by\":1,\"created_at\":\"2019-06-21 03:37:11\",\"updated_at\":\"2019-06-21 03:39:17\",\"due_on\":\"27 Jun, 19\",\"create_on\":\"21 Jun, 19\",\"project\":{\"id\":2,\"company_id\":1,\"project_name\":\"TBL Sales\",\"project_summary\":\"<p>New application for transcom babarage sales analysis<\\/p>\",\"project_admin\":5,\"start_date\":\"2019-06-21 00:00:00\",\"deadline\":null,\"notes\":null,\"category_id\":5,\"client_id\":11,\"feedback\":null,\"manual_timelog\":\"disable\",\"client_view_task\":\"disable\",\"allow_client_notification\":\"disable\",\"completion_percent\":0,\"calculate_task_progress\":\"true\",\"created_at\":\"2019-06-21 03:29:19\",\"updated_at\":\"2019-06-21 03:31:41\",\"deleted_at\":null,\"isProjectAdmin\":false}}', NULL, '2019-06-21 03:39:17', '2019-06-21 03:39:17');
INSERT INTO `notifications` VALUES ('17472158-bcd1-4a98-a0b4-2eba56637c2a', 'App\\Notifications\\NewTask', 'App\\User', 5, '{\"id\":4,\"company_id\":1,\"heading\":\"asdasd\",\"description\":\"<p>asdasd<\\/p>\",\"due_date\":\"2019-06-21 00:00:00\",\"start_date\":\"2019-06-21 00:00:00\",\"user_id\":5,\"project_id\":1,\"task_category_id\":3,\"priority\":\"high\",\"status\":\"incomplete\",\"board_column_id\":3,\"column_priority\":0,\"completed_on\":null,\"created_by\":1,\"created_at\":\"2019-06-20 09:31:42\",\"updated_at\":\"2019-06-20 09:31:42\",\"due_on\":\"21 Jun, 19\",\"create_on\":\"21 Jun, 19\"}', '2019-06-20 09:31:58', '2019-06-20 09:31:42', '2019-06-20 09:31:58');
INSERT INTO `notifications` VALUES ('20705e19-74f8-4c34-abcd-b796c0dbb8a8', 'App\\Notifications\\TaskCompleted', 'App\\User', 1, '{\"id\":2,\"company_id\":1,\"heading\":\"Database Generate\",\"description\":\"<p>Database Generate<br><\\/p>\",\"due_date\":\"2019-06-18 00:00:00\",\"start_date\":\"2019-06-18 00:00:00\",\"user_id\":1,\"project_id\":null,\"task_category_id\":3,\"priority\":\"medium\",\"status\":\"incomplete\",\"board_column_id\":4,\"column_priority\":0,\"completed_on\":\"2019-06-18 00:00:00\",\"created_by\":1,\"created_at\":\"2019-06-18 06:37:24\",\"updated_at\":\"2019-06-18 06:39:08\",\"due_on\":\"18 Jun, 19\",\"create_on\":\"18 Jun, 19\"}', '2019-06-18 11:18:09', '2019-06-18 06:39:09', '2019-06-18 11:18:09');
INSERT INTO `notifications` VALUES ('232422bc-ea5b-449d-9998-ed68fc2ab75b', 'App\\Notifications\\NewUser', 'App\\User', 6, '{\"id\":6,\"company_id\":1,\"name\":\"Transcom\",\"email\":\"transcom@example.com\",\"image\":null,\"mobile\":null,\"gender\":\"male\",\"locale\":\"en\",\"status\":\"active\",\"login\":\"enable\",\"onesignal_player_id\":null,\"created_at\":\"2019-06-19 05:20:54\",\"updated_at\":\"2019-06-19 05:20:54\",\"super_admin\":\"0\",\"email_verification_code\":null}', '2019-06-20 09:36:10', '2019-06-19 05:20:54', '2019-06-20 09:36:10');
INSERT INTO `notifications` VALUES ('27e4c2fa-c8a6-427e-9cc4-4fa9206da5a9', 'App\\Notifications\\NewNotice', 'App\\User', 1, '{\"id\":1,\"company_id\":1,\"heading\":\"Eid Holiday\",\"description\":\"Eid-Ul-Azha Holiday from 4th June to 7th June\",\"created_at\":\"2019-06-20 08:35:52\",\"updated_at\":\"2019-06-20 08:35:52\",\"notice_date\":\"20 June, 2019\"}', '2019-06-20 08:39:02', '2019-06-20 08:35:52', '2019-06-20 08:39:02');
INSERT INTO `notifications` VALUES ('296331f7-b6da-4b55-96b6-d31376cc71c8', 'App\\Notifications\\NewTask', 'App\\User', 5, '{\"id\":3,\"company_id\":1,\"heading\":\"User Module Created\",\"description\":null,\"due_date\":\"2019-06-20 00:00:00\",\"start_date\":\"2019-06-20 00:00:00\",\"user_id\":5,\"project_id\":1,\"task_category_id\":2,\"priority\":\"high\",\"status\":\"incomplete\",\"board_column_id\":3,\"column_priority\":0,\"completed_on\":null,\"created_by\":1,\"created_at\":\"2019-06-20 09:22:11\",\"updated_at\":\"2019-06-20 09:22:11\",\"due_on\":\"20 Jun, 19\",\"create_on\":\"20 Jun, 19\"}', '2019-06-20 09:31:58', '2019-06-20 09:22:11', '2019-06-20 09:31:58');
INSERT INTO `notifications` VALUES ('2a160d50-a364-42e3-88dc-e07a0afc3459', 'App\\Notifications\\NewUser', 'App\\User', 4, '{\"id\":4,\"company_id\":1,\"name\":\"ju\",\"email\":\"ju@example.com\",\"image\":null,\"mobile\":null,\"gender\":\"male\",\"locale\":\"en\",\"status\":\"active\",\"login\":\"enable\",\"onesignal_player_id\":null,\"created_at\":\"2019-06-18 06:41:48\",\"updated_at\":\"2019-06-18 06:41:48\",\"super_admin\":\"0\",\"email_verification_code\":null}', NULL, '2019-06-18 06:41:48', '2019-06-18 06:41:48');
INSERT INTO `notifications` VALUES ('32e1b915-0da9-4042-8ee1-619308d98b26', 'App\\Notifications\\TaskCompleted', 'App\\User', 1, '{\"id\":9,\"company_id\":1,\"heading\":\"Design System Architecture\",\"description\":\"<p>Design System Architecture<br><\\/p>\",\"due_date\":\"2019-06-27 00:00:00\",\"start_date\":\"2019-06-21 00:00:00\",\"user_id\":9,\"project_id\":2,\"task_category_id\":4,\"priority\":\"high\",\"status\":\"incomplete\",\"board_column_id\":4,\"column_priority\":0,\"completed_on\":\"2019-06-21 00:00:00\",\"created_by\":1,\"created_at\":\"2019-06-21 03:37:11\",\"updated_at\":\"2019-06-21 03:42:03\",\"due_on\":\"27 Jun, 19\",\"create_on\":\"21 Jun, 19\",\"project\":{\"id\":2,\"company_id\":1,\"project_name\":\"TBL Sales\",\"project_summary\":\"<p>New application for transcom babarage sales analysis<\\/p>\",\"project_admin\":5,\"start_date\":\"2019-06-21 00:00:00\",\"deadline\":null,\"notes\":null,\"category_id\":5,\"client_id\":11,\"feedback\":null,\"manual_timelog\":\"disable\",\"client_view_task\":\"disable\",\"allow_client_notification\":\"disable\",\"completion_percent\":0,\"calculate_task_progress\":\"true\",\"created_at\":\"2019-06-21 03:29:19\",\"updated_at\":\"2019-06-21 03:31:41\",\"deleted_at\":null,\"isProjectAdmin\":false}}', '2019-06-22 05:09:23', '2019-06-21 03:42:03', '2019-06-22 05:09:23');
INSERT INTO `notifications` VALUES ('3585e2e3-9661-469a-a326-38c443f568a0', 'App\\Notifications\\TaskUpdated', 'App\\User', 9, '{\"id\":9,\"company_id\":1,\"heading\":\"Design System Architecture\",\"description\":\"<p>Design System Architecture<br><\\/p>\",\"due_date\":\"2019-06-27 00:00:00\",\"start_date\":\"2019-06-21 00:00:00\",\"user_id\":9,\"project_id\":2,\"task_category_id\":4,\"priority\":\"high\",\"status\":\"incomplete\",\"board_column_id\":3,\"column_priority\":0,\"completed_on\":null,\"created_by\":1,\"created_at\":\"2019-06-21 03:37:11\",\"updated_at\":\"2019-06-21 03:38:43\",\"due_on\":\"27 Jun, 19\",\"create_on\":\"21 Jun, 19\"}', NULL, '2019-06-21 03:38:44', '2019-06-21 03:38:44');
INSERT INTO `notifications` VALUES ('36c06ee5-1a30-416c-b305-d6b54ae749e2', 'App\\Notifications\\TaskCompleted', 'App\\User', 1, '{\"id\":9,\"company_id\":1,\"heading\":\"Design System Architecture\",\"description\":\"<p>Design System Architecture<br><\\/p>\",\"due_date\":\"2019-06-27 00:00:00\",\"start_date\":\"2019-06-21 00:00:00\",\"user_id\":9,\"project_id\":2,\"task_category_id\":4,\"priority\":\"high\",\"status\":\"incomplete\",\"board_column_id\":4,\"column_priority\":0,\"completed_on\":\"2019-06-21 00:00:00\",\"created_by\":1,\"created_at\":\"2019-06-21 03:37:11\",\"updated_at\":\"2019-06-21 03:43:26\",\"due_on\":\"27 Jun, 19\",\"create_on\":\"21 Jun, 19\",\"project\":{\"id\":2,\"company_id\":1,\"project_name\":\"TBL Sales\",\"project_summary\":\"<p>New application for transcom babarage sales analysis<\\/p>\",\"project_admin\":5,\"start_date\":\"2019-06-21 00:00:00\",\"deadline\":null,\"notes\":null,\"category_id\":5,\"client_id\":11,\"feedback\":null,\"manual_timelog\":\"disable\",\"client_view_task\":\"disable\",\"allow_client_notification\":\"disable\",\"completion_percent\":0,\"calculate_task_progress\":\"true\",\"created_at\":\"2019-06-21 03:29:19\",\"updated_at\":\"2019-06-21 03:31:41\",\"deleted_at\":null,\"isProjectAdmin\":false}}', '2019-06-22 05:09:23', '2019-06-21 03:43:27', '2019-06-22 05:09:23');
INSERT INTO `notifications` VALUES ('375fca29-b954-4e72-9918-a659a0a6682d', 'App\\Notifications\\NewProjectMember', 'App\\User', 7, '{\"id\":2,\"company_id\":1,\"user_id\":7,\"project_id\":1,\"created_at\":\"2019-06-20 09:20:58\",\"updated_at\":\"2019-06-20 09:20:58\"}', NULL, '2019-06-20 09:20:58', '2019-06-20 09:20:58');
INSERT INTO `notifications` VALUES ('39b6b8a8-a46b-4620-857d-6504162eb407', 'App\\Notifications\\TaskCompleted', 'App\\User', 9, '{\"id\":9,\"company_id\":1,\"heading\":\"Design System Architecture\",\"description\":\"<p>Design System Architecture<br><\\/p>\",\"due_date\":\"2019-06-27 00:00:00\",\"start_date\":\"2019-06-21 00:00:00\",\"user_id\":9,\"project_id\":2,\"task_category_id\":4,\"priority\":\"medium\",\"status\":\"incomplete\",\"board_column_id\":4,\"column_priority\":0,\"completed_on\":\"2019-06-21 00:00:00\",\"created_by\":1,\"created_at\":\"2019-06-21 03:37:11\",\"updated_at\":\"2019-06-21 03:37:38\",\"due_on\":\"27 Jun, 19\",\"create_on\":\"21 Jun, 19\",\"project\":{\"id\":2,\"company_id\":1,\"project_name\":\"TBL Sales\",\"project_summary\":\"<p>New application for transcom babarage sales analysis<\\/p>\",\"project_admin\":5,\"start_date\":\"2019-06-21 00:00:00\",\"deadline\":null,\"notes\":null,\"category_id\":5,\"client_id\":11,\"feedback\":null,\"manual_timelog\":\"disable\",\"client_view_task\":\"disable\",\"allow_client_notification\":\"disable\",\"completion_percent\":0,\"calculate_task_progress\":\"true\",\"created_at\":\"2019-06-21 03:29:19\",\"updated_at\":\"2019-06-21 03:31:41\",\"deleted_at\":null,\"isProjectAdmin\":false}}', NULL, '2019-06-21 03:37:38', '2019-06-21 03:37:38');
INSERT INTO `notifications` VALUES ('4037f107-fc06-4677-8d61-22d9977441f5', 'App\\Notifications\\TaskCompleted', 'App\\User', 5, '{\"id\":4,\"company_id\":1,\"heading\":\"asdasd\",\"description\":\"<p>asdasd<\\/p>\",\"due_date\":\"2019-06-21 00:00:00\",\"start_date\":\"2019-06-21 00:00:00\",\"user_id\":5,\"project_id\":1,\"task_category_id\":3,\"priority\":\"high\",\"status\":\"incomplete\",\"board_column_id\":4,\"column_priority\":0,\"completed_on\":\"2019-06-20 00:00:00\",\"created_by\":1,\"created_at\":\"2019-06-20 09:31:42\",\"updated_at\":\"2019-06-20 09:32:57\",\"due_on\":\"21 Jun, 19\",\"create_on\":\"21 Jun, 19\"}', '2019-06-22 05:29:47', '2019-06-20 09:32:57', '2019-06-22 05:29:47');
INSERT INTO `notifications` VALUES ('4abf4894-6b9d-4a5c-a23a-cb6fce1bca2f', 'App\\Notifications\\TaskCompleted', 'App\\User', 1, '{\"id\":9,\"company_id\":1,\"heading\":\"Design System Architecture\",\"description\":\"<p>Design System Architecture<br><\\/p>\",\"due_date\":\"2019-06-27 00:00:00\",\"start_date\":\"2019-06-21 00:00:00\",\"user_id\":9,\"project_id\":2,\"task_category_id\":4,\"priority\":\"high\",\"status\":\"incomplete\",\"board_column_id\":4,\"column_priority\":0,\"completed_on\":\"2019-06-21 00:00:00\",\"created_by\":1,\"created_at\":\"2019-06-21 03:37:11\",\"updated_at\":\"2019-06-21 03:39:59\",\"due_on\":\"27 Jun, 19\",\"create_on\":\"21 Jun, 19\",\"project\":{\"id\":2,\"company_id\":1,\"project_name\":\"TBL Sales\",\"project_summary\":\"<p>New application for transcom babarage sales analysis<\\/p>\",\"project_admin\":5,\"start_date\":\"2019-06-21 00:00:00\",\"deadline\":null,\"notes\":null,\"category_id\":5,\"client_id\":11,\"feedback\":null,\"manual_timelog\":\"disable\",\"client_view_task\":\"disable\",\"allow_client_notification\":\"disable\",\"completion_percent\":0,\"calculate_task_progress\":\"true\",\"created_at\":\"2019-06-21 03:29:19\",\"updated_at\":\"2019-06-21 03:31:41\",\"deleted_at\":null,\"isProjectAdmin\":false}}', '2019-06-22 05:09:23', '2019-06-21 03:40:00', '2019-06-22 05:09:23');
INSERT INTO `notifications` VALUES ('526f050d-c3bd-4122-88d3-054571136a4c', 'App\\Notifications\\TaskCompleted', 'App\\User', 5, '{\"id\":3,\"company_id\":1,\"heading\":\"User Module Created\",\"description\":null,\"due_date\":\"2019-06-20 00:00:00\",\"start_date\":\"2019-06-20 00:00:00\",\"user_id\":5,\"project_id\":1,\"task_category_id\":2,\"priority\":\"high\",\"status\":\"incomplete\",\"board_column_id\":4,\"column_priority\":0,\"completed_on\":\"2019-06-20 00:00:00\",\"created_by\":1,\"created_at\":\"2019-06-20 09:22:11\",\"updated_at\":\"2019-06-20 09:22:45\",\"due_on\":\"20 Jun, 19\",\"create_on\":\"20 Jun, 19\"}', '2019-06-20 09:31:58', '2019-06-20 09:22:45', '2019-06-20 09:31:58');
INSERT INTO `notifications` VALUES ('5fa5c267-d77b-415b-a2d9-a57ca6b72c41', 'App\\Notifications\\NewNotice', 'App\\User', 7, '{\"id\":1,\"company_id\":1,\"heading\":\"Eid Holiday\",\"description\":\"Eid-Ul-Azha Holiday from 4th June to 7th June\",\"created_at\":\"2019-06-20 08:35:52\",\"updated_at\":\"2019-06-20 08:35:52\",\"notice_date\":\"20 June, 2019\"}', NULL, '2019-06-20 08:35:52', '2019-06-20 08:35:52');
INSERT INTO `notifications` VALUES ('62f87113-d465-4cc1-8242-cd71d18a02ef', 'App\\Notifications\\LeaveStatusApprove', 'App\\User', 5, '{\"id\":4,\"company_id\":1,\"user_id\":5,\"leave_type_id\":4,\"duration\":\"single\",\"leave_date\":\"2019-06-22 00:00:00\",\"reason\":\"Family Affairs\",\"status\":\"approved\",\"reject_reason\":null,\"created_at\":\"2019-06-22 05:28:15\",\"updated_at\":\"2019-06-22 05:30:38\",\"date\":\"2019-06-22\"}', NULL, '2019-06-22 05:30:38', '2019-06-22 05:30:38');
INSERT INTO `notifications` VALUES ('6942eccb-aceb-4923-87ff-67664d289b29', 'App\\Notifications\\LeaveStatusApprove', 'App\\User', 5, '{\"id\":1,\"company_id\":1,\"user_id\":5,\"leave_type_id\":5,\"duration\":\"single\",\"leave_date\":\"2019-06-22 00:00:00\",\"reason\":\"Food Poison\",\"status\":\"approved\",\"reject_reason\":null,\"created_at\":\"2019-06-22 05:24:37\",\"updated_at\":\"2019-06-22 05:30:35\",\"date\":\"2019-06-22\"}', NULL, '2019-06-22 05:30:35', '2019-06-22 05:30:35');
INSERT INTO `notifications` VALUES ('6c0c18e0-0f5e-4cb9-9450-875c26fcd3e5', 'App\\Notifications\\NewTask', 'App\\User', 9, '{\"id\":9,\"company_id\":1,\"heading\":\"Design System Architecture\",\"description\":\"<p>Design System Architecture<br><\\/p>\",\"due_date\":\"2019-06-27 00:00:00\",\"start_date\":\"2019-06-21 00:00:00\",\"user_id\":9,\"project_id\":2,\"task_category_id\":4,\"priority\":\"medium\",\"status\":\"incomplete\",\"board_column_id\":3,\"column_priority\":0,\"completed_on\":null,\"created_by\":1,\"created_at\":\"2019-06-21 03:37:11\",\"updated_at\":\"2019-06-21 03:37:11\",\"due_on\":\"27 Jun, 19\",\"create_on\":\"21 Jun, 19\"}', NULL, '2019-06-21 03:37:11', '2019-06-21 03:37:11');
INSERT INTO `notifications` VALUES ('771981b7-b1f4-4e7b-872f-9e436d73e8ee', 'App\\Notifications\\NewNotice', 'App\\User', 5, '{\"id\":1,\"company_id\":1,\"heading\":\"Eid Holiday\",\"description\":\"Eid-Ul-Azha Holiday from 4th June to 7th June\",\"created_at\":\"2019-06-20 08:35:52\",\"updated_at\":\"2019-06-20 08:35:52\",\"notice_date\":\"20 June, 2019\"}', '2019-06-20 09:31:58', '2019-06-20 08:35:52', '2019-06-20 09:31:58');
INSERT INTO `notifications` VALUES ('811a9afd-e0a9-44d0-add3-18564b308cd3', 'App\\Notifications\\NewProjectMember', 'App\\User', 5, '{\"id\":3,\"company_id\":1,\"user_id\":5,\"project_id\":2,\"created_at\":\"2019-06-21 03:29:53\",\"updated_at\":\"2019-06-21 03:29:53\"}', '2019-06-22 05:29:47', '2019-06-21 03:29:54', '2019-06-22 05:29:47');
INSERT INTO `notifications` VALUES ('85797ca7-3892-4ee7-ba9d-11f73df0ced9', 'App\\Notifications\\NewUser', 'App\\User', 8, '{\"id\":8,\"company_id\":1,\"name\":\"Nokib\",\"email\":\"nokib@gmail.com\",\"image\":null,\"mobile\":null,\"gender\":\"male\",\"locale\":\"en\",\"status\":\"active\",\"login\":\"enable\",\"onesignal_player_id\":null,\"created_at\":\"2019-06-20 15:16:18\",\"updated_at\":\"2019-06-20 15:16:18\",\"super_admin\":\"0\",\"email_verification_code\":null}', NULL, '2019-06-20 15:16:19', '2019-06-20 15:16:19');
INSERT INTO `notifications` VALUES ('930ad051-6da1-4df5-b169-65961f4db75a', 'App\\Notifications\\NewTask', 'App\\User', 1, '{\"id\":2,\"company_id\":1,\"heading\":\"Database Generate\",\"description\":\"<p>Database Generate<br><\\/p>\",\"due_date\":\"2019-06-18 00:00:00\",\"start_date\":\"2019-06-18 00:00:00\",\"user_id\":1,\"project_id\":null,\"task_category_id\":3,\"priority\":\"medium\",\"status\":\"incomplete\",\"board_column_id\":3,\"column_priority\":0,\"completed_on\":null,\"created_by\":1,\"created_at\":\"2019-06-18 06:37:24\",\"updated_at\":\"2019-06-18 06:37:24\",\"due_on\":\"18 Jun, 19\",\"create_on\":\"18 Jun, 19\"}', '2019-06-18 06:38:05', '2019-06-18 06:37:24', '2019-06-18 06:38:05');
INSERT INTO `notifications` VALUES ('9e028992-052b-4519-9f84-143bc6b0b901', 'App\\Notifications\\NewTicket', 'App\\User', 1, '{\"id\":1,\"company_id\":1,\"user_id\":5,\"subject\":\"Notification create problem\",\"status\":\"open\",\"priority\":\"medium\",\"agent_id\":null,\"channel_id\":null,\"type_id\":null,\"created_at\":\"2019-06-20 09:14:03\",\"updated_at\":\"2019-06-20 09:14:03\",\"deleted_at\":null,\"created_on\":\"20 Jun 2019 09:14\"}', '2019-06-21 03:27:11', '2019-06-20 09:14:04', '2019-06-21 03:27:11');
INSERT INTO `notifications` VALUES ('a4fd8f13-e735-4337-a659-4b01ba47af0e', 'App\\Notifications\\NewTask', 'App\\User', 1, '{\"id\":1,\"company_id\":1,\"heading\":\"Database Generate\",\"description\":\"<p>Database Generate<br><\\/p>\",\"due_date\":\"2019-06-18 00:00:00\",\"start_date\":\"2019-06-18 00:00:00\",\"user_id\":1,\"project_id\":null,\"task_category_id\":3,\"priority\":\"medium\",\"status\":\"incomplete\",\"board_column_id\":3,\"column_priority\":0,\"completed_on\":null,\"created_by\":1,\"created_at\":\"2019-06-18 06:37:04\",\"updated_at\":\"2019-06-18 06:37:04\",\"due_on\":\"18 Jun, 19\",\"create_on\":\"18 Jun, 19\"}', '2019-06-18 06:38:05', '2019-06-18 06:37:06', '2019-06-18 06:38:05');
INSERT INTO `notifications` VALUES ('b697d084-50d5-4b1e-8524-37f5c41517d0', 'App\\Notifications\\NewTicket', 'App\\User', 1, '{\"id\":2,\"company_id\":1,\"user_id\":5,\"subject\":\"Notification create problem\",\"status\":\"open\",\"priority\":\"medium\",\"agent_id\":null,\"channel_id\":null,\"type_id\":null,\"created_at\":\"2019-06-20 09:14:09\",\"updated_at\":\"2019-06-20 09:14:09\",\"deleted_at\":null,\"created_on\":\"20 Jun 2019 09:14\"}', '2019-06-21 03:27:11', '2019-06-20 09:14:10', '2019-06-21 03:27:11');
INSERT INTO `notifications` VALUES ('bc266213-056f-4320-a07d-cf92441796d4', 'App\\Notifications\\TaskCompleted', 'App\\User', 1, '{\"id\":9,\"company_id\":1,\"heading\":\"Design System Architecture\",\"description\":\"<p>Design System Architecture<br><\\/p>\",\"due_date\":\"2019-06-27 00:00:00\",\"start_date\":\"2019-06-21 00:00:00\",\"user_id\":9,\"project_id\":2,\"task_category_id\":4,\"priority\":\"high\",\"status\":\"incomplete\",\"board_column_id\":4,\"column_priority\":0,\"completed_on\":\"2019-06-21 00:00:00\",\"created_by\":1,\"created_at\":\"2019-06-21 03:37:11\",\"updated_at\":\"2019-06-21 03:39:41\",\"due_on\":\"27 Jun, 19\",\"create_on\":\"21 Jun, 19\",\"project\":{\"id\":2,\"company_id\":1,\"project_name\":\"TBL Sales\",\"project_summary\":\"<p>New application for transcom babarage sales analysis<\\/p>\",\"project_admin\":5,\"start_date\":\"2019-06-21 00:00:00\",\"deadline\":null,\"notes\":null,\"category_id\":5,\"client_id\":11,\"feedback\":null,\"manual_timelog\":\"disable\",\"client_view_task\":\"disable\",\"allow_client_notification\":\"disable\",\"completion_percent\":0,\"calculate_task_progress\":\"true\",\"created_at\":\"2019-06-21 03:29:19\",\"updated_at\":\"2019-06-21 03:31:41\",\"deleted_at\":null,\"isProjectAdmin\":false}}', '2019-06-22 05:09:23', '2019-06-21 03:39:41', '2019-06-22 05:09:23');
INSERT INTO `notifications` VALUES ('d4860b17-8a9b-4f96-9371-8939244aa1f2', 'App\\Notifications\\NewTicket', 'App\\User', 1, '{\"id\":3,\"company_id\":1,\"user_id\":6,\"subject\":\"Notification cretaing problem\",\"status\":\"open\",\"priority\":\"medium\",\"agent_id\":null,\"channel_id\":null,\"type_id\":null,\"created_at\":\"2019-06-20 09:15:33\",\"updated_at\":\"2019-06-20 09:15:33\",\"deleted_at\":null,\"created_on\":\"20 Jun 2019 09:15\"}', '2019-06-21 03:27:10', '2019-06-20 09:15:34', '2019-06-21 03:27:10');
INSERT INTO `notifications` VALUES ('e123f03b-bf79-4bac-bf7a-640199179f8d', 'App\\Notifications\\NewProjectMember', 'App\\User', 5, '{\"id\":1,\"company_id\":1,\"user_id\":5,\"project_id\":1,\"created_at\":\"2019-06-20 09:19:59\",\"updated_at\":\"2019-06-20 09:19:59\"}', '2019-06-20 09:31:58', '2019-06-20 09:20:01', '2019-06-20 09:31:58');
INSERT INTO `notifications` VALUES ('e8208fad-5e60-4431-b830-f924edd97983', 'App\\Notifications\\LeaveApplication', 'App\\User', 5, '{\"id\":3,\"company_id\":1,\"user_id\":5,\"leave_type_id\":4,\"duration\":\"single\",\"leave_date\":\"2019-06-25 00:00:00\",\"reason\":\"Family Affairs\",\"status\":\"pending\",\"reject_reason\":null,\"created_at\":\"2019-06-22 05:27:27\",\"updated_at\":\"2019-06-22 05:27:27\",\"date\":\"2019-06-25\"}', '2019-06-22 05:29:47', '2019-06-22 05:27:27', '2019-06-22 05:29:47');
INSERT INTO `notifications` VALUES ('ef240ecd-2bde-41fe-b63b-ede6e2f77264', 'App\\Notifications\\NewUser', 'App\\User', 11, '{\"id\":11,\"company_id\":1,\"name\":\"Transcom Babarage\",\"email\":\"pepsi@example.com\",\"image\":null,\"mobile\":null,\"gender\":\"male\",\"locale\":\"en\",\"status\":\"active\",\"login\":\"enable\",\"onesignal_player_id\":null,\"created_at\":\"2019-06-20 15:32:44\",\"updated_at\":\"2019-06-20 15:32:44\",\"super_admin\":\"0\",\"email_verification_code\":null}', NULL, '2019-06-20 15:32:44', '2019-06-20 15:32:44');
INSERT INTO `notifications` VALUES ('efd04e1c-282b-45f6-8b37-4287f4031bb8', 'App\\Notifications\\NewUser', 'App\\User', 5, '{\"id\":5,\"company_id\":1,\"name\":\"Ashik\",\"email\":\"ashik@gmail.com\",\"image\":null,\"mobile\":null,\"gender\":\"male\",\"locale\":\"en\",\"status\":\"active\",\"login\":\"enable\",\"onesignal_player_id\":null,\"created_at\":\"2019-06-18 06:45:54\",\"updated_at\":\"2019-06-18 06:45:54\",\"super_admin\":\"0\",\"email_verification_code\":null}', '2019-06-18 07:03:44', '2019-06-18 06:45:54', '2019-06-18 07:03:44');
INSERT INTO `notifications` VALUES ('fadc80cc-ba6e-4177-bd3d-15f7f0306dfa', 'App\\Notifications\\NewUser', 'App\\User', 7, '{\"id\":7,\"company_id\":1,\"name\":\"Sagir Ahmed\",\"email\":\"sagir@gmail.com\",\"image\":null,\"mobile\":null,\"gender\":\"male\",\"locale\":\"en\",\"status\":\"active\",\"login\":\"enable\",\"onesignal_player_id\":null,\"created_at\":\"2019-06-20 08:31:09\",\"updated_at\":\"2019-06-20 08:31:09\",\"super_admin\":\"0\",\"email_verification_code\":null}', NULL, '2019-06-20 08:31:10', '2019-06-20 08:31:10');
INSERT INTO `notifications` VALUES ('fc726329-7b70-4779-abe1-c8ef907aaeee', 'App\\Notifications\\TaskCompleted', 'App\\User', 1, '{\"id\":9,\"company_id\":1,\"heading\":\"Design System Architecture\",\"description\":\"<p>Design System Architecture<br><\\/p>\",\"due_date\":\"2019-06-27 00:00:00\",\"start_date\":\"2019-06-21 00:00:00\",\"user_id\":9,\"project_id\":2,\"task_category_id\":4,\"priority\":\"high\",\"status\":\"incomplete\",\"board_column_id\":4,\"column_priority\":0,\"completed_on\":\"2019-06-21 00:00:00\",\"created_by\":1,\"created_at\":\"2019-06-21 03:37:11\",\"updated_at\":\"2019-06-21 03:44:02\",\"due_on\":\"27 Jun, 19\",\"create_on\":\"21 Jun, 19\",\"project\":{\"id\":2,\"company_id\":1,\"project_name\":\"TBL Sales\",\"project_summary\":\"<p>New application for transcom babarage sales analysis<\\/p>\",\"project_admin\":5,\"start_date\":\"2019-06-21 00:00:00\",\"deadline\":null,\"notes\":null,\"category_id\":5,\"client_id\":11,\"feedback\":null,\"manual_timelog\":\"disable\",\"client_view_task\":\"disable\",\"allow_client_notification\":\"disable\",\"completion_percent\":0,\"calculate_task_progress\":\"true\",\"created_at\":\"2019-06-21 03:29:19\",\"updated_at\":\"2019-06-21 03:31:41\",\"deleted_at\":null,\"isProjectAdmin\":false}}', '2019-06-22 05:09:23', '2019-06-21 03:44:02', '2019-06-22 05:09:23');
INSERT INTO `notifications` VALUES ('fd0ab7bc-ac28-4895-8e1f-f1ee67b0a4c3', 'App\\Notifications\\NewLeaveRequest', 'App\\User', 1, '{\"id\":1,\"company_id\":1,\"user_id\":5,\"leave_type_id\":5,\"duration\":\"single\",\"leave_date\":\"2019-06-22 00:00:00\",\"reason\":\"Food Poison\",\"status\":\"pending\",\"reject_reason\":null,\"created_at\":\"2019-06-22 05:24:37\",\"updated_at\":\"2019-06-22 05:24:37\",\"date\":\"2019-06-22\"}', '2019-06-22 05:30:48', '2019-06-22 05:24:38', '2019-06-22 05:30:48');

-- ----------------------------
-- Table structure for offline_payment_methods
-- ----------------------------
DROP TABLE IF EXISTS `offline_payment_methods`;
CREATE TABLE `offline_payment_methods`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `company_id` int(10) UNSIGNED NULL DEFAULT NULL,
  `name` varchar(191) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `description` longtext CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL,
  `status` enum('yes','no') CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT 'yes',
  `created_at` timestamp(0) NULL DEFAULT NULL,
  `updated_at` timestamp(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `offline_payment_methods_company_id_foreign`(`company_id`) USING BTREE,
  CONSTRAINT `offline_payment_methods_company_id_foreign` FOREIGN KEY (`company_id`) REFERENCES `companies` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_unicode_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for package_settings
-- ----------------------------
DROP TABLE IF EXISTS `package_settings`;
CREATE TABLE `package_settings`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `status` enum('active','inactive') CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT 'inactive',
  `no_of_days` int(11) NULL DEFAULT 30,
  `modules` varchar(1000) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT NULL,
  `notification_before` int(11) NULL DEFAULT NULL,
  `created_at` timestamp(0) NULL DEFAULT NULL,
  `updated_at` timestamp(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8 COLLATE = utf8_unicode_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of package_settings
-- ----------------------------
INSERT INTO `package_settings` VALUES (1, 'inactive', 30, NULL, NULL, '2019-06-16 06:33:57', '2019-06-16 06:33:57');

-- ----------------------------
-- Table structure for packages
-- ----------------------------
DROP TABLE IF EXISTS `packages`;
CREATE TABLE `packages`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `currency_id` int(10) UNSIGNED NULL DEFAULT NULL,
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `description` varchar(1000) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT NULL,
  `max_storage_size` int(10) UNSIGNED NULL DEFAULT NULL,
  `max_file_size` int(10) UNSIGNED NULL DEFAULT NULL,
  `annual_price` decimal(8, 2) UNSIGNED NOT NULL DEFAULT 0.00,
  `monthly_price` decimal(8, 2) UNSIGNED NOT NULL DEFAULT 0.00,
  `billing_cycle` tinyint(3) UNSIGNED NULL DEFAULT NULL,
  `max_employees` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `sort` varchar(191) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT NULL,
  `module_in_package` varchar(1000) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `stripe_annual_plan_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `stripe_monthly_plan_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `default` enum('yes','no','trial') CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT 'no',
  `created_at` timestamp(0) NULL DEFAULT NULL,
  `updated_at` timestamp(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `packages_currency_id_foreign`(`currency_id`) USING BTREE,
  CONSTRAINT `packages_currency_id_foreign` FOREIGN KEY (`currency_id`) REFERENCES `global_currencies` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = utf8 COLLATE = utf8_unicode_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of packages
-- ----------------------------
INSERT INTO `packages` VALUES (1, 5, 'Default', 'Its a default package and cannot be deleted', NULL, NULL, 0.00, 0.00, NULL, 1000, NULL, 'null', 'default_plan', 'default_plan', 'yes', '2019-06-16 06:33:54', '2019-06-18 06:24:09');
INSERT INTO `packages` VALUES (2, NULL, 'Trial', 'Its a trial package', NULL, NULL, 0.00, 0.00, NULL, 20, NULL, '', 'trial_plan', 'trial_plan', 'trial', '2019-06-16 06:33:57', '2019-06-16 06:33:57');
INSERT INTO `packages` VALUES (3, 1, 'Free', 'It\'s a free package.', 500, 10, 0.00, 0.00, NULL, 20, NULL, '{\"1\":\"clients\",\"2\":\"employees\",\"3\":\"attendance\",\"4\":\"projects\",\"5\":\"tasks\",\"6\":\"estimates\",\"7\":\"invoices\",\"8\":\"payments\",\"9\":\"expenses\",\"10\":\"timelogs\",\"11\":\"tickets\",\"12\":\"messages\",\"13\":\"events\",\"14\":\"leaves\",\"15\":\"notices\",\"16\":\"leads\",\"17\":\"holidays\",\"18\":\"products\"}', '', '', 'no', '2019-06-16 06:34:18', '2019-06-16 06:34:18');
INSERT INTO `packages` VALUES (4, 5, 'Starter', 'Starter', 1024, 30, 12000.00, 1000.00, NULL, 50, NULL, '{\"1\":\"clients\",\"2\":\"employees\",\"3\":\"projects\",\"4\":\"attendance\",\"5\":\"tasks\",\"6\":\"estimates\",\"7\":\"invoices\",\"8\":\"payments\",\"9\":\"timelogs\",\"10\":\"tickets\",\"16\":\"holidays\",\"18\":\"expenses\"}', 'starter_annual', 'starter_monthly', 'no', '2019-06-16 06:34:18', '2019-06-18 06:26:29');
INSERT INTO `packages` VALUES (5, 5, 'Medium', 'Medium', 3072, 50, 24000.00, 2000.00, NULL, 100, NULL, '{\"1\":\"clients\",\"2\":\"employees\",\"3\":\"projects\",\"4\":\"attendance\",\"5\":\"tasks\",\"6\":\"estimates\",\"7\":\"invoices\",\"8\":\"payments\",\"9\":\"timelogs\",\"10\":\"tickets\",\"11\":\"events\",\"12\":\"messages\",\"13\":\"notices\",\"14\":\"leaves\",\"15\":\"leads\",\"16\":\"holidays\",\"18\":\"expenses\"}', 'medium_annual', 'medium_monthly', 'no', '2019-06-16 06:34:18', '2019-06-18 06:25:59');
INSERT INTO `packages` VALUES (6, 5, 'Larger', 'Larger', 10240, 100, 60000.00, 5000.00, NULL, 1000, NULL, '{\"1\":\"clients\",\"2\":\"employees\",\"3\":\"projects\",\"4\":\"attendance\",\"5\":\"tasks\",\"9\":\"timelogs\",\"10\":\"tickets\",\"11\":\"events\",\"12\":\"messages\",\"13\":\"notices\",\"14\":\"leaves\",\"16\":\"holidays\"}', 'larger_annual', 'larger_monthly', 'no', '2019-06-16 06:34:18', '2019-06-18 11:12:38');

-- ----------------------------
-- Table structure for password_resets
-- ----------------------------
DROP TABLE IF EXISTS `password_resets`;
CREATE TABLE `password_resets`  (
  `email` varchar(191) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `token` varchar(191) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `created_at` timestamp(0) NULL DEFAULT NULL,
  INDEX `password_resets_email_index`(`email`) USING BTREE,
  INDEX `password_resets_token_index`(`token`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_unicode_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for payment_gateway_credentials
-- ----------------------------
DROP TABLE IF EXISTS `payment_gateway_credentials`;
CREATE TABLE `payment_gateway_credentials`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `company_id` int(10) UNSIGNED NULL DEFAULT NULL,
  `paypal_client_id` varchar(191) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT NULL,
  `paypal_secret` varchar(191) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT NULL,
  `paypal_status` enum('active','deactive') CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT 'active',
  `stripe_client_id` varchar(191) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT NULL,
  `stripe_secret` varchar(191) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT NULL,
  `stripe_webhook_secret` varchar(191) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT NULL,
  `stripe_status` enum('active','deactive') CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT 'active',
  `created_at` timestamp(0) NULL DEFAULT NULL,
  `updated_at` timestamp(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `payment_gateway_credentials_company_id_foreign`(`company_id`) USING BTREE,
  CONSTRAINT `payment_gateway_credentials_company_id_foreign` FOREIGN KEY (`company_id`) REFERENCES `companies` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8 COLLATE = utf8_unicode_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of payment_gateway_credentials
-- ----------------------------
INSERT INTO `payment_gateway_credentials` VALUES (1, NULL, NULL, NULL, 'active', NULL, NULL, NULL, 'active', '2019-06-16 06:24:38', '2019-06-16 06:24:38');
INSERT INTO `payment_gateway_credentials` VALUES (2, 1, NULL, NULL, 'active', NULL, NULL, NULL, 'active', '2019-06-16 06:34:22', '2019-06-16 06:34:22');

-- ----------------------------
-- Table structure for payments
-- ----------------------------
DROP TABLE IF EXISTS `payments`;
CREATE TABLE `payments`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `company_id` int(10) UNSIGNED NULL DEFAULT NULL,
  `project_id` int(10) UNSIGNED NULL DEFAULT NULL,
  `invoice_id` int(10) UNSIGNED NULL DEFAULT NULL,
  `amount` double NOT NULL,
  `gateway` varchar(191) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT NULL,
  `transaction_id` varchar(191) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT NULL,
  `currency_id` int(10) UNSIGNED NULL DEFAULT NULL,
  `plan_id` varchar(191) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT NULL,
  `customer_id` varchar(191) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT NULL,
  `event_id` varchar(191) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT NULL,
  `status` enum('complete','pending') CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT 'complete',
  `paid_on` datetime(0) NULL DEFAULT NULL,
  `remarks` text CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL,
  `created_at` timestamp(0) NULL DEFAULT NULL,
  `updated_at` timestamp(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `payments_transaction_id_unique`(`transaction_id`) USING BTREE,
  UNIQUE INDEX `payments_plan_id_unique`(`plan_id`) USING BTREE,
  UNIQUE INDEX `payments_event_id_unique`(`event_id`) USING BTREE,
  INDEX `payments_currency_id_foreign`(`currency_id`) USING BTREE,
  INDEX `payments_project_id_foreign`(`project_id`) USING BTREE,
  INDEX `payments_invoice_id_foreign`(`invoice_id`) USING BTREE,
  INDEX `payments_company_id_foreign`(`company_id`) USING BTREE,
  CONSTRAINT `payments_company_id_foreign` FOREIGN KEY (`company_id`) REFERENCES `companies` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `payments_currency_id_foreign` FOREIGN KEY (`currency_id`) REFERENCES `currencies` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `payments_invoice_id_foreign` FOREIGN KEY (`invoice_id`) REFERENCES `invoices` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `payments_project_id_foreign` FOREIGN KEY (`project_id`) REFERENCES `projects` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_unicode_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for paypal_invoices
-- ----------------------------
DROP TABLE IF EXISTS `paypal_invoices`;
CREATE TABLE `paypal_invoices`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `company_id` int(10) UNSIGNED NULL DEFAULT NULL,
  `currency_id` int(10) UNSIGNED NULL DEFAULT NULL,
  `package_id` int(10) UNSIGNED NULL DEFAULT NULL,
  `sub_total` double NULL DEFAULT NULL,
  `total` double NULL DEFAULT NULL,
  `transaction_id` varchar(191) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT NULL,
  `remarks` varchar(191) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT NULL,
  `billing_frequency` varchar(191) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT NULL,
  `billing_interval` int(11) NULL DEFAULT NULL,
  `paid_on` datetime(0) NULL DEFAULT NULL,
  `next_pay_date` datetime(0) NULL DEFAULT NULL,
  `recurring` enum('yes','no') CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT 'no',
  `status` enum('paid','unpaid','pending') CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT 'pending',
  `plan_id` varchar(191) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT NULL,
  `event_id` varchar(191) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT NULL,
  `end_on` datetime(0) NULL DEFAULT NULL,
  `created_at` timestamp(0) NULL DEFAULT NULL,
  `updated_at` timestamp(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `paypal_invoices_company_id_foreign`(`company_id`) USING BTREE,
  INDEX `paypal_invoices_currency_id_foreign`(`currency_id`) USING BTREE,
  INDEX `paypal_invoices_package_id_foreign`(`package_id`) USING BTREE,
  CONSTRAINT `paypal_invoices_company_id_foreign` FOREIGN KEY (`company_id`) REFERENCES `companies` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `paypal_invoices_currency_id_foreign` FOREIGN KEY (`currency_id`) REFERENCES `currencies` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `paypal_invoices_package_id_foreign` FOREIGN KEY (`package_id`) REFERENCES `packages` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_unicode_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for permission_role
-- ----------------------------
DROP TABLE IF EXISTS `permission_role`;
CREATE TABLE `permission_role`  (
  `permission_id` int(10) UNSIGNED NOT NULL,
  `role_id` int(10) UNSIGNED NOT NULL,
  PRIMARY KEY (`permission_id`, `role_id`) USING BTREE,
  INDEX `permission_role_role_id_foreign`(`role_id`) USING BTREE,
  CONSTRAINT `permission_role_permission_id_foreign` FOREIGN KEY (`permission_id`) REFERENCES `permissions` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `permission_role_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_unicode_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for permissions
-- ----------------------------
DROP TABLE IF EXISTS `permissions`;
CREATE TABLE `permissions`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(191) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `display_name` varchar(191) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT NULL,
  `description` varchar(191) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT NULL,
  `module_id` int(10) UNSIGNED NOT NULL,
  `created_at` timestamp(0) NULL DEFAULT NULL,
  `updated_at` timestamp(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `permissions_name_unique`(`name`) USING BTREE,
  INDEX `permissions_module_id_foreign`(`module_id`) USING BTREE,
  CONSTRAINT `permissions_module_id_foreign` FOREIGN KEY (`module_id`) REFERENCES `modules` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 67 CHARACTER SET = utf8 COLLATE = utf8_unicode_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of permissions
-- ----------------------------
INSERT INTO `permissions` VALUES (1, 'add_clients', 'Add Clients', NULL, 1, NULL, NULL);
INSERT INTO `permissions` VALUES (2, 'view_clients', 'View Clients', NULL, 1, NULL, NULL);
INSERT INTO `permissions` VALUES (3, 'edit_clients', 'Edit Clients', NULL, 1, NULL, NULL);
INSERT INTO `permissions` VALUES (4, 'delete_clients', 'Delete Clients', NULL, 1, NULL, NULL);
INSERT INTO `permissions` VALUES (5, 'add_employees', 'Add Employees', NULL, 2, NULL, NULL);
INSERT INTO `permissions` VALUES (6, 'view_employees', 'View Employees', NULL, 2, NULL, NULL);
INSERT INTO `permissions` VALUES (7, 'edit_employees', 'Edit Employees', NULL, 2, NULL, NULL);
INSERT INTO `permissions` VALUES (8, 'delete_employees', 'Delete Employees', NULL, 2, NULL, NULL);
INSERT INTO `permissions` VALUES (9, 'add_projects', 'Add Project', NULL, 3, NULL, NULL);
INSERT INTO `permissions` VALUES (10, 'view_projects', 'View Project', NULL, 3, NULL, NULL);
INSERT INTO `permissions` VALUES (11, 'edit_projects', 'Edit Project', NULL, 3, NULL, NULL);
INSERT INTO `permissions` VALUES (12, 'delete_projects', 'Delete Project', NULL, 3, NULL, NULL);
INSERT INTO `permissions` VALUES (13, 'add_attendance', 'Add Attendance', NULL, 4, NULL, NULL);
INSERT INTO `permissions` VALUES (14, 'view_attendance', 'View Attendance', NULL, 4, NULL, NULL);
INSERT INTO `permissions` VALUES (15, 'add_tasks', 'Add Tasks', NULL, 5, NULL, NULL);
INSERT INTO `permissions` VALUES (16, 'view_tasks', 'View Tasks', NULL, 5, NULL, NULL);
INSERT INTO `permissions` VALUES (17, 'edit_tasks', 'Edit Tasks', NULL, 5, NULL, NULL);
INSERT INTO `permissions` VALUES (18, 'delete_tasks', 'Delete Tasks', NULL, 5, NULL, NULL);
INSERT INTO `permissions` VALUES (19, 'add_estimates', 'Add Estimates', NULL, 6, NULL, NULL);
INSERT INTO `permissions` VALUES (20, 'view_estimates', 'View Estimates', NULL, 6, NULL, NULL);
INSERT INTO `permissions` VALUES (21, 'edit_estimates', 'Edit Estimates', NULL, 6, NULL, NULL);
INSERT INTO `permissions` VALUES (22, 'delete_estimates', 'Delete Estimates', NULL, 6, NULL, NULL);
INSERT INTO `permissions` VALUES (23, 'add_invoices', 'Add Invoices', NULL, 7, NULL, NULL);
INSERT INTO `permissions` VALUES (24, 'view_invoices', 'View Invoices', NULL, 7, NULL, NULL);
INSERT INTO `permissions` VALUES (25, 'edit_invoices', 'Edit Invoices', NULL, 7, NULL, NULL);
INSERT INTO `permissions` VALUES (26, 'delete_invoices', 'Delete Invoices', NULL, 7, NULL, NULL);
INSERT INTO `permissions` VALUES (27, 'add_payments', 'Add Payments', NULL, 8, NULL, NULL);
INSERT INTO `permissions` VALUES (28, 'view_payments', 'View Payments', NULL, 8, NULL, NULL);
INSERT INTO `permissions` VALUES (29, 'edit_payments', 'Edit Payments', NULL, 8, NULL, NULL);
INSERT INTO `permissions` VALUES (30, 'delete_payments', 'Delete Payments', NULL, 8, NULL, NULL);
INSERT INTO `permissions` VALUES (31, 'add_timelogs', 'Add Timelogs', NULL, 9, NULL, NULL);
INSERT INTO `permissions` VALUES (32, 'view_timelogs', 'View Timelogs', NULL, 9, NULL, NULL);
INSERT INTO `permissions` VALUES (33, 'edit_timelogs', 'Edit Timelogs', NULL, 9, NULL, NULL);
INSERT INTO `permissions` VALUES (34, 'delete_timelogs', 'Delete Timelogs', NULL, 9, NULL, NULL);
INSERT INTO `permissions` VALUES (35, 'add_tickets', 'Add Tickets', NULL, 10, NULL, NULL);
INSERT INTO `permissions` VALUES (36, 'view_tickets', 'View Tickets', NULL, 10, NULL, NULL);
INSERT INTO `permissions` VALUES (37, 'edit_tickets', 'Edit Tickets', NULL, 10, NULL, NULL);
INSERT INTO `permissions` VALUES (38, 'delete_tickets', 'Delete Tickets', NULL, 10, NULL, NULL);
INSERT INTO `permissions` VALUES (39, 'add_events', 'Add Events', NULL, 11, NULL, NULL);
INSERT INTO `permissions` VALUES (40, 'view_events', 'View Events', NULL, 11, NULL, NULL);
INSERT INTO `permissions` VALUES (41, 'edit_events', 'Edit Events', NULL, 11, NULL, NULL);
INSERT INTO `permissions` VALUES (42, 'delete_events', 'Delete Events', NULL, 11, NULL, NULL);
INSERT INTO `permissions` VALUES (43, 'add_notice', 'Add Notice', NULL, 13, NULL, '2019-06-16 06:33:43');
INSERT INTO `permissions` VALUES (44, 'view_notice', 'View Notice', NULL, 13, NULL, '2019-06-16 06:33:43');
INSERT INTO `permissions` VALUES (45, 'edit_notice', 'Edit Notice', NULL, 13, NULL, '2019-06-16 06:33:43');
INSERT INTO `permissions` VALUES (46, 'delete_notice', 'Delete Notice', NULL, 13, NULL, '2019-06-16 06:33:43');
INSERT INTO `permissions` VALUES (47, 'add_leave', 'Add Leave', NULL, 14, NULL, NULL);
INSERT INTO `permissions` VALUES (48, 'view_leave', 'View Leave', NULL, 14, NULL, NULL);
INSERT INTO `permissions` VALUES (49, 'edit_leave', 'Edit Leave', NULL, 14, NULL, NULL);
INSERT INTO `permissions` VALUES (50, 'delete_leave', 'Delete Leave', NULL, 14, NULL, NULL);
INSERT INTO `permissions` VALUES (51, 'add_lead', 'Add Lead', NULL, 15, NULL, NULL);
INSERT INTO `permissions` VALUES (52, 'view_lead', 'View Lead', NULL, 15, NULL, NULL);
INSERT INTO `permissions` VALUES (53, 'edit_lead', 'Edit Lead', NULL, 15, NULL, NULL);
INSERT INTO `permissions` VALUES (54, 'delete_lead', 'Delete Lead', NULL, 15, NULL, NULL);
INSERT INTO `permissions` VALUES (55, 'add_holiday', 'Add Holiday', NULL, 16, NULL, NULL);
INSERT INTO `permissions` VALUES (56, 'view_holiday', 'View Holiday', NULL, 16, NULL, NULL);
INSERT INTO `permissions` VALUES (57, 'edit_holiday', 'Edit Holiday', NULL, 16, NULL, NULL);
INSERT INTO `permissions` VALUES (58, 'delete_holiday', 'Delete Holiday', NULL, 16, NULL, NULL);
INSERT INTO `permissions` VALUES (59, 'add_product', 'Add Product', NULL, 17, NULL, NULL);
INSERT INTO `permissions` VALUES (60, 'view_product', 'View Product', NULL, 17, NULL, NULL);
INSERT INTO `permissions` VALUES (61, 'edit_product', 'Edit Product', NULL, 17, NULL, NULL);
INSERT INTO `permissions` VALUES (62, 'delete_product', 'Delete Product', NULL, 17, NULL, NULL);
INSERT INTO `permissions` VALUES (63, 'add_expenses', 'Add Expenses', NULL, 18, NULL, NULL);
INSERT INTO `permissions` VALUES (64, 'view_expenses', 'View Expenses', NULL, 18, NULL, NULL);
INSERT INTO `permissions` VALUES (65, 'edit_expenses', 'Edit Expenses', NULL, 18, NULL, NULL);
INSERT INTO `permissions` VALUES (66, 'delete_expenses', 'Delete Expenses', NULL, 18, NULL, NULL);

-- ----------------------------
-- Table structure for products
-- ----------------------------
DROP TABLE IF EXISTS `products`;
CREATE TABLE `products`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `company_id` int(10) UNSIGNED NULL DEFAULT NULL,
  `name` varchar(191) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `price` varchar(191) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `tax_id` int(10) UNSIGNED NULL DEFAULT NULL,
  `created_at` timestamp(0) NULL DEFAULT NULL,
  `updated_at` timestamp(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `products_tax_id_foreign`(`tax_id`) USING BTREE,
  INDEX `products_company_id_foreign`(`company_id`) USING BTREE,
  CONSTRAINT `products_company_id_foreign` FOREIGN KEY (`company_id`) REFERENCES `companies` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `products_tax_id_foreign` FOREIGN KEY (`tax_id`) REFERENCES `taxes` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_unicode_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for project_activity
-- ----------------------------
DROP TABLE IF EXISTS `project_activity`;
CREATE TABLE `project_activity`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `company_id` int(10) UNSIGNED NULL DEFAULT NULL,
  `project_id` int(10) UNSIGNED NOT NULL,
  `activity` text CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `created_at` timestamp(0) NULL DEFAULT NULL,
  `updated_at` timestamp(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `project_activity_project_id_foreign`(`project_id`) USING BTREE,
  INDEX `project_activity_company_id_foreign`(`company_id`) USING BTREE,
  CONSTRAINT `project_activity_company_id_foreign` FOREIGN KEY (`company_id`) REFERENCES `companies` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `project_activity_project_id_foreign` FOREIGN KEY (`project_id`) REFERENCES `projects` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8 COLLATE = utf8_unicode_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of project_activity
-- ----------------------------
INSERT INTO `project_activity` VALUES (1, 1, 1, 'JU Student System added as new project.', '2019-06-19 05:22:29', '2019-06-19 05:22:29');
INSERT INTO `project_activity` VALUES (2, 1, 1, 'JU Student System project details updated.', '2019-06-20 09:20:37', '2019-06-20 09:20:37');
INSERT INTO `project_activity` VALUES (3, 1, 2, 'TBL Sales added as new project.', '2019-06-21 03:29:19', '2019-06-21 03:29:19');
INSERT INTO `project_activity` VALUES (4, 1, 2, 'Fahim is added as project member.', '2019-06-21 03:31:19', '2019-06-21 03:31:19');
INSERT INTO `project_activity` VALUES (5, 1, 2, 'TBL Sales project details updated.', '2019-06-22 05:12:21', '2019-06-22 05:12:21');

-- ----------------------------
-- Table structure for project_category
-- ----------------------------
DROP TABLE IF EXISTS `project_category`;
CREATE TABLE `project_category`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `company_id` int(10) UNSIGNED NULL DEFAULT NULL,
  `category_name` varchar(191) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `created_at` timestamp(0) NULL DEFAULT NULL,
  `updated_at` timestamp(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `project_category_company_id_foreign`(`company_id`) USING BTREE,
  CONSTRAINT `project_category_company_id_foreign` FOREIGN KEY (`company_id`) REFERENCES `companies` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8 COLLATE = utf8_unicode_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of project_category
-- ----------------------------
INSERT INTO `project_category` VALUES (1, 1, 'Laravel', '2019-06-16 06:34:24', '2019-06-16 06:34:24');
INSERT INTO `project_category` VALUES (2, 1, 'Java', '2019-06-16 06:34:24', '2019-06-16 06:34:24');
INSERT INTO `project_category` VALUES (3, 1, 'Android', '2019-06-21 03:27:37', '2019-06-21 03:27:37');
INSERT INTO `project_category` VALUES (4, 1, 'Data Science', '2019-06-21 03:27:49', '2019-06-21 03:27:49');
INSERT INTO `project_category` VALUES (5, 1, 'Web Applications', '2019-06-21 03:28:02', '2019-06-21 03:28:02');

-- ----------------------------
-- Table structure for project_files
-- ----------------------------
DROP TABLE IF EXISTS `project_files`;
CREATE TABLE `project_files`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `company_id` int(10) UNSIGNED NULL DEFAULT NULL,
  `user_id` int(10) UNSIGNED NOT NULL,
  `project_id` int(10) UNSIGNED NOT NULL,
  `filename` varchar(191) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `hashname` varchar(191) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT NULL,
  `size` varchar(191) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT NULL,
  `description` text CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL,
  `google_url` varchar(191) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT NULL,
  `dropbox_link` varchar(191) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT NULL,
  `created_at` timestamp(0) NULL DEFAULT NULL,
  `updated_at` timestamp(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `project_files_user_id_foreign`(`user_id`) USING BTREE,
  INDEX `project_files_project_id_foreign`(`project_id`) USING BTREE,
  INDEX `project_files_company_id_foreign`(`company_id`) USING BTREE,
  CONSTRAINT `project_files_company_id_foreign` FOREIGN KEY (`company_id`) REFERENCES `companies` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `project_files_project_id_foreign` FOREIGN KEY (`project_id`) REFERENCES `projects` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `project_files_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_unicode_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for project_members
-- ----------------------------
DROP TABLE IF EXISTS `project_members`;
CREATE TABLE `project_members`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `company_id` int(10) UNSIGNED NULL DEFAULT NULL,
  `user_id` int(10) UNSIGNED NOT NULL,
  `project_id` int(10) UNSIGNED NOT NULL,
  `created_at` timestamp(0) NULL DEFAULT NULL,
  `updated_at` timestamp(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `project_members_project_id_foreign`(`project_id`) USING BTREE,
  INDEX `project_members_user_id_foreign`(`user_id`) USING BTREE,
  INDEX `project_members_company_id_foreign`(`company_id`) USING BTREE,
  CONSTRAINT `project_members_company_id_foreign` FOREIGN KEY (`company_id`) REFERENCES `companies` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `project_members_project_id_foreign` FOREIGN KEY (`project_id`) REFERENCES `projects` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `project_members_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 8 CHARACTER SET = utf8 COLLATE = utf8_unicode_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of project_members
-- ----------------------------
INSERT INTO `project_members` VALUES (1, 1, 5, 1, '2019-06-20 09:19:59', '2019-06-20 09:19:59');
INSERT INTO `project_members` VALUES (2, 1, 7, 1, '2019-06-20 09:20:58', '2019-06-20 09:20:58');
INSERT INTO `project_members` VALUES (3, 1, 5, 2, '2019-06-21 03:29:53', '2019-06-21 03:29:53');
INSERT INTO `project_members` VALUES (4, 1, 9, 2, '2019-06-21 03:31:19', '2019-06-21 03:31:19');
INSERT INTO `project_members` VALUES (5, 1, 7, 2, '2019-06-21 03:33:20', '2019-06-21 03:33:20');
INSERT INTO `project_members` VALUES (6, 1, 8, 2, '2019-06-21 03:33:20', '2019-06-21 03:33:20');
INSERT INTO `project_members` VALUES (7, 1, 10, 2, '2019-06-21 03:33:20', '2019-06-21 03:33:20');

-- ----------------------------
-- Table structure for project_template_members
-- ----------------------------
DROP TABLE IF EXISTS `project_template_members`;
CREATE TABLE `project_template_members`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` int(10) UNSIGNED NOT NULL,
  `project_template_id` int(10) UNSIGNED NOT NULL,
  `created_at` timestamp(0) NULL DEFAULT NULL,
  `updated_at` timestamp(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `project_template_members_user_id_foreign`(`user_id`) USING BTREE,
  INDEX `project_template_members_project_template_id_foreign`(`project_template_id`) USING BTREE,
  CONSTRAINT `project_template_members_project_template_id_foreign` FOREIGN KEY (`project_template_id`) REFERENCES `project_templates` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `project_template_members_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_unicode_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for project_template_tasks
-- ----------------------------
DROP TABLE IF EXISTS `project_template_tasks`;
CREATE TABLE `project_template_tasks`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `heading` varchar(191) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `description` mediumtext CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL,
  `user_id` int(10) UNSIGNED NOT NULL,
  `project_template_id` int(10) UNSIGNED NOT NULL,
  `priority` enum('low','medium','high') CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT 'medium',
  `created_at` timestamp(0) NULL DEFAULT NULL,
  `updated_at` timestamp(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `project_template_tasks_user_id_foreign`(`user_id`) USING BTREE,
  INDEX `project_template_tasks_project_template_id_foreign`(`project_template_id`) USING BTREE,
  CONSTRAINT `project_template_tasks_project_template_id_foreign` FOREIGN KEY (`project_template_id`) REFERENCES `project_templates` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `project_template_tasks_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_unicode_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for project_templates
-- ----------------------------
DROP TABLE IF EXISTS `project_templates`;
CREATE TABLE `project_templates`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `company_id` int(10) UNSIGNED NULL DEFAULT NULL,
  `project_name` varchar(191) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `category_id` int(10) UNSIGNED NULL DEFAULT NULL,
  `client_id` int(10) UNSIGNED NULL DEFAULT NULL,
  `project_summary` mediumtext CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL,
  `notes` longtext CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL,
  `feedback` mediumtext CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL,
  `client_view_task` enum('enable','disable') CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT 'disable',
  `allow_client_notification` enum('enable','disable') CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT 'disable',
  `manual_timelog` enum('enable','disable') CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT 'disable',
  `created_at` timestamp(0) NULL DEFAULT NULL,
  `updated_at` timestamp(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `project_templates_category_id_foreign`(`category_id`) USING BTREE,
  INDEX `project_templates_client_id_foreign`(`client_id`) USING BTREE,
  INDEX `project_templates_company_id_foreign`(`company_id`) USING BTREE,
  CONSTRAINT `project_templates_category_id_foreign` FOREIGN KEY (`category_id`) REFERENCES `project_category` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `project_templates_client_id_foreign` FOREIGN KEY (`client_id`) REFERENCES `users` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `project_templates_company_id_foreign` FOREIGN KEY (`company_id`) REFERENCES `companies` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_unicode_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for project_time_logs
-- ----------------------------
DROP TABLE IF EXISTS `project_time_logs`;
CREATE TABLE `project_time_logs`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `company_id` int(10) UNSIGNED NULL DEFAULT NULL,
  `project_id` int(10) UNSIGNED NULL DEFAULT NULL,
  `task_id` int(10) UNSIGNED NULL DEFAULT NULL,
  `user_id` int(10) UNSIGNED NOT NULL,
  `start_time` datetime(0) NOT NULL,
  `end_time` datetime(0) NULL DEFAULT NULL,
  `memo` text CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `total_hours` varchar(191) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT NULL,
  `total_minutes` varchar(191) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT NULL,
  `edited_by_user` int(10) UNSIGNED NULL DEFAULT NULL,
  `created_at` timestamp(0) NULL DEFAULT NULL,
  `updated_at` timestamp(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `project_time_logs_edited_by_user_foreign`(`edited_by_user`) USING BTREE,
  INDEX `project_time_logs_project_id_foreign`(`project_id`) USING BTREE,
  INDEX `project_time_logs_user_id_foreign`(`user_id`) USING BTREE,
  INDEX `project_time_logs_task_id_foreign`(`task_id`) USING BTREE,
  INDEX `project_time_logs_company_id_foreign`(`company_id`) USING BTREE,
  CONSTRAINT `project_time_logs_company_id_foreign` FOREIGN KEY (`company_id`) REFERENCES `companies` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `project_time_logs_edited_by_user_foreign` FOREIGN KEY (`edited_by_user`) REFERENCES `users` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `project_time_logs_project_id_foreign` FOREIGN KEY (`project_id`) REFERENCES `projects` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `project_time_logs_task_id_foreign` FOREIGN KEY (`task_id`) REFERENCES `tasks` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `project_time_logs_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8 COLLATE = utf8_unicode_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of project_time_logs
-- ----------------------------
INSERT INTO `project_time_logs` VALUES (1, 1, 2, NULL, 5, '2019-06-21 03:00:00', '2019-06-21 14:00:00', 'Work on System Architecture', '11', '660', 1, '2019-06-22 05:11:51', '2019-06-22 05:11:51');

-- ----------------------------
-- Table structure for projects
-- ----------------------------
DROP TABLE IF EXISTS `projects`;
CREATE TABLE `projects`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `company_id` int(10) UNSIGNED NULL DEFAULT NULL,
  `project_name` varchar(191) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `project_summary` mediumtext CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL,
  `project_admin` int(10) UNSIGNED NULL DEFAULT NULL,
  `start_date` date NOT NULL,
  `deadline` date NULL DEFAULT NULL,
  `notes` longtext CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL,
  `category_id` int(10) UNSIGNED NULL DEFAULT NULL,
  `client_id` int(10) UNSIGNED NULL DEFAULT NULL,
  `feedback` mediumtext CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL,
  `manual_timelog` enum('enable','disable') CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT 'disable',
  `client_view_task` enum('enable','disable') CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT 'disable',
  `allow_client_notification` enum('enable','disable') CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT 'disable',
  `completion_percent` tinyint(4) NOT NULL,
  `calculate_task_progress` enum('true','false') CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT 'true',
  `created_at` timestamp(0) NULL DEFAULT NULL,
  `updated_at` timestamp(0) NULL DEFAULT NULL,
  `deleted_at` timestamp(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `projects_category_id_foreign`(`category_id`) USING BTREE,
  INDEX `projects_client_id_foreign`(`client_id`) USING BTREE,
  INDEX `projects_project_admin_foreign`(`project_admin`) USING BTREE,
  INDEX `projects_company_id_foreign`(`company_id`) USING BTREE,
  CONSTRAINT `projects_category_id_foreign` FOREIGN KEY (`category_id`) REFERENCES `project_category` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `projects_client_id_foreign` FOREIGN KEY (`client_id`) REFERENCES `users` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `projects_company_id_foreign` FOREIGN KEY (`company_id`) REFERENCES `companies` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `projects_project_admin_foreign` FOREIGN KEY (`project_admin`) REFERENCES `users` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8 COLLATE = utf8_unicode_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of projects
-- ----------------------------
INSERT INTO `projects` VALUES (1, 1, 'JU Student System', NULL, NULL, '2019-06-19', NULL, NULL, 2, 4, NULL, 'disable', 'disable', 'disable', 0, 'true', '2019-06-19 05:22:29', '2019-06-19 05:22:29', NULL);
INSERT INTO `projects` VALUES (2, 1, 'TBL Sales', '<p>New application for transcom babarage sales analysis</p>', 5, '2019-06-21', '2019-08-31', NULL, 5, 11, NULL, 'disable', 'disable', 'disable', 100, 'true', '2019-06-21 03:29:19', '2019-06-22 05:12:21', NULL);

-- ----------------------------
-- Table structure for proposal_items
-- ----------------------------
DROP TABLE IF EXISTS `proposal_items`;
CREATE TABLE `proposal_items`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `tax_id` int(10) UNSIGNED NULL DEFAULT NULL,
  `proposal_id` int(10) UNSIGNED NOT NULL,
  `item_name` varchar(191) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `type` enum('item','discount','tax') CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT 'item',
  `quantity` double(8, 2) NOT NULL,
  `unit_price` double(8, 2) NOT NULL,
  `amount` double NOT NULL,
  `created_at` timestamp(0) NULL DEFAULT NULL,
  `updated_at` timestamp(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `proposal_items_proposal_id_foreign`(`proposal_id`) USING BTREE,
  INDEX `proposal_items_tax_id_foreign`(`tax_id`) USING BTREE,
  CONSTRAINT `proposal_items_proposal_id_foreign` FOREIGN KEY (`proposal_id`) REFERENCES `proposals` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `proposal_items_tax_id_foreign` FOREIGN KEY (`tax_id`) REFERENCES `taxes` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_unicode_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for proposals
-- ----------------------------
DROP TABLE IF EXISTS `proposals`;
CREATE TABLE `proposals`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `company_id` int(10) UNSIGNED NULL DEFAULT NULL,
  `lead_id` int(10) UNSIGNED NOT NULL,
  `valid_till` date NOT NULL,
  `sub_total` double(8, 2) NOT NULL,
  `total` double(8, 2) NOT NULL,
  `currency_id` int(10) UNSIGNED NULL DEFAULT NULL,
  `status` enum('declined','accepted','waiting') CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT 'waiting',
  `note` mediumtext CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL,
  `created_at` timestamp(0) NULL DEFAULT NULL,
  `updated_at` timestamp(0) NULL DEFAULT NULL,
  `discount` varchar(191) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `discount_type` varchar(191) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `proposals_lead_id_foreign`(`lead_id`) USING BTREE,
  INDEX `proposals_currency_id_foreign`(`currency_id`) USING BTREE,
  INDEX `proposals_company_id_foreign`(`company_id`) USING BTREE,
  CONSTRAINT `proposals_company_id_foreign` FOREIGN KEY (`company_id`) REFERENCES `companies` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `proposals_currency_id_foreign` FOREIGN KEY (`currency_id`) REFERENCES `currencies` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `proposals_lead_id_foreign` FOREIGN KEY (`lead_id`) REFERENCES `leads` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_unicode_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for push_notification_settings
-- ----------------------------
DROP TABLE IF EXISTS `push_notification_settings`;
CREATE TABLE `push_notification_settings`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `onesignal_app_id` text CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL,
  `onesignal_rest_api_key` text CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL,
  `notification_logo` varchar(191) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT NULL,
  `status` enum('active','inactive') CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT 'inactive',
  `created_at` timestamp(0) NULL DEFAULT NULL,
  `updated_at` timestamp(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8 COLLATE = utf8_unicode_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of push_notification_settings
-- ----------------------------
INSERT INTO `push_notification_settings` VALUES (1, NULL, NULL, NULL, 'inactive', '2019-06-16 06:33:10', '2019-06-16 06:33:10');

-- ----------------------------
-- Table structure for push_subscriptions
-- ----------------------------
DROP TABLE IF EXISTS `push_subscriptions`;
CREATE TABLE `push_subscriptions`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` int(10) UNSIGNED NOT NULL,
  `endpoint` varchar(191) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `public_key` varchar(191) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT NULL,
  `auth_token` varchar(191) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT NULL,
  `created_at` timestamp(0) NULL DEFAULT NULL,
  `updated_at` timestamp(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `push_subscriptions_endpoint_unique`(`endpoint`) USING BTREE,
  INDEX `push_subscriptions_user_id_index`(`user_id`) USING BTREE,
  CONSTRAINT `push_subscriptions_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_unicode_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for quotation_items
-- ----------------------------
DROP TABLE IF EXISTS `quotation_items`;
CREATE TABLE `quotation_items`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `quotation_id` int(10) UNSIGNED NOT NULL,
  `item_name` varchar(191) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `quantity` int(11) NOT NULL,
  `unit_price` int(11) NOT NULL,
  `amount` double(8, 2) NOT NULL,
  `created_at` timestamp(0) NULL DEFAULT NULL,
  `updated_at` timestamp(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `quotation_items_quotation_id_foreign`(`quotation_id`) USING BTREE,
  CONSTRAINT `quotation_items_quotation_id_foreign` FOREIGN KEY (`quotation_id`) REFERENCES `quotations` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_unicode_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for quotations
-- ----------------------------
DROP TABLE IF EXISTS `quotations`;
CREATE TABLE `quotations`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `business_name` varchar(191) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `client_name` varchar(191) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `client_email` varchar(191) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `phone` varchar(191) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT NULL,
  `address` text CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL,
  `sub_total` double(8, 2) NOT NULL,
  `total` double(8, 2) NOT NULL,
  `created_at` timestamp(0) NULL DEFAULT NULL,
  `updated_at` timestamp(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_unicode_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for role_user
-- ----------------------------
DROP TABLE IF EXISTS `role_user`;
CREATE TABLE `role_user`  (
  `user_id` int(10) UNSIGNED NOT NULL,
  `role_id` int(10) UNSIGNED NOT NULL,
  PRIMARY KEY (`user_id`, `role_id`) USING BTREE,
  INDEX `role_user_role_id_foreign`(`role_id`) USING BTREE,
  CONSTRAINT `role_user_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `role_user_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_unicode_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of role_user
-- ----------------------------
INSERT INTO `role_user` VALUES (1, 1);
INSERT INTO `role_user` VALUES (1, 2);
INSERT INTO `role_user` VALUES (4, 3);
INSERT INTO `role_user` VALUES (5, 2);
INSERT INTO `role_user` VALUES (6, 3);
INSERT INTO `role_user` VALUES (7, 2);
INSERT INTO `role_user` VALUES (8, 2);
INSERT INTO `role_user` VALUES (9, 2);
INSERT INTO `role_user` VALUES (10, 2);
INSERT INTO `role_user` VALUES (11, 3);
INSERT INTO `role_user` VALUES (12, 3);

-- ----------------------------
-- Table structure for roles
-- ----------------------------
DROP TABLE IF EXISTS `roles`;
CREATE TABLE `roles`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `company_id` int(10) UNSIGNED NULL DEFAULT NULL,
  `name` varchar(191) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `display_name` varchar(191) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT NULL,
  `description` varchar(191) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT NULL,
  `created_at` timestamp(0) NULL DEFAULT NULL,
  `updated_at` timestamp(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `roles_company_id_foreign`(`company_id`) USING BTREE,
  CONSTRAINT `roles_company_id_foreign` FOREIGN KEY (`company_id`) REFERENCES `companies` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8 COLLATE = utf8_unicode_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of roles
-- ----------------------------
INSERT INTO `roles` VALUES (1, 1, 'admin', 'App Administrator', 'Admin is allowed to manage everything of the app.', '2019-06-16 06:34:22', '2019-06-16 06:34:22');
INSERT INTO `roles` VALUES (2, 1, 'employee', 'Employee', 'Employee can see tasks and projects assigned to him.', '2019-06-16 06:34:23', '2019-06-16 06:34:23');
INSERT INTO `roles` VALUES (3, 1, 'client', 'Client', 'Client can see own tasks and projects.', '2019-06-16 06:34:23', '2019-06-16 06:34:23');

-- ----------------------------
-- Table structure for skills
-- ----------------------------
DROP TABLE IF EXISTS `skills`;
CREATE TABLE `skills`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(200) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `created_at` timestamp(0) NULL DEFAULT NULL,
  `updated_at` timestamp(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_unicode_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for slack_settings
-- ----------------------------
DROP TABLE IF EXISTS `slack_settings`;
CREATE TABLE `slack_settings`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `company_id` int(10) UNSIGNED NULL DEFAULT NULL,
  `slack_webhook` text CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL,
  `slack_logo` varchar(191) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT NULL,
  `created_at` timestamp(0) NULL DEFAULT NULL,
  `updated_at` timestamp(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `slack_settings_company_id_foreign`(`company_id`) USING BTREE,
  CONSTRAINT `slack_settings_company_id_foreign` FOREIGN KEY (`company_id`) REFERENCES `companies` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8 COLLATE = utf8_unicode_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of slack_settings
-- ----------------------------
INSERT INTO `slack_settings` VALUES (1, NULL, NULL, NULL, '2019-06-16 06:24:44', '2019-06-16 06:24:44');
INSERT INTO `slack_settings` VALUES (2, 1, NULL, NULL, '2019-06-16 06:34:22', '2019-06-16 06:34:22');

-- ----------------------------
-- Table structure for smtp_settings
-- ----------------------------
DROP TABLE IF EXISTS `smtp_settings`;
CREATE TABLE `smtp_settings`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `mail_driver` varchar(191) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT 'smtp',
  `mail_host` varchar(191) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT 'smtp.gmail.com',
  `mail_port` varchar(191) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT '587',
  `mail_username` varchar(191) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT 'youremail@gmail.com',
  `mail_password` varchar(191) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT 'your password',
  `mail_from_name` varchar(191) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT 'your name',
  `mail_from_email` varchar(191) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT 'from@email.com',
  `mail_encryption` enum('tls','ssl') CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT 'tls',
  `created_at` timestamp(0) NULL DEFAULT NULL,
  `updated_at` timestamp(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8 COLLATE = utf8_unicode_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of smtp_settings
-- ----------------------------
INSERT INTO `smtp_settings` VALUES (1, 'mail', 'smtp.gmail.com', '587', 'myemail@gmail.com', 'mypassword', 'froiden', 'from@email.com', 'tls', '2019-06-16 06:29:37', '2019-06-16 06:29:37');

-- ----------------------------
-- Table structure for sticky_notes
-- ----------------------------
DROP TABLE IF EXISTS `sticky_notes`;
CREATE TABLE `sticky_notes`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` int(10) UNSIGNED NOT NULL,
  `note_text` mediumtext CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `colour` enum('blue','yellow','red','gray','purple','green') CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT 'blue',
  `created_at` timestamp(0) NULL DEFAULT NULL,
  `updated_at` timestamp(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `sticky_notes_user_id_foreign`(`user_id`) USING BTREE,
  CONSTRAINT `sticky_notes_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8 COLLATE = utf8_unicode_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of sticky_notes
-- ----------------------------
INSERT INTO `sticky_notes` VALUES (1, 1, 'dfghjkl;\'', 'red', '2019-06-22 05:08:34', '2019-06-22 05:08:34');

-- ----------------------------
-- Table structure for stripe_invoices
-- ----------------------------
DROP TABLE IF EXISTS `stripe_invoices`;
CREATE TABLE `stripe_invoices`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `company_id` int(10) UNSIGNED NOT NULL,
  `invoice_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT NULL,
  `package_id` int(10) UNSIGNED NOT NULL,
  `transaction_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT NULL,
  `amount` decimal(12, 2) UNSIGNED NOT NULL,
  `pay_date` date NOT NULL,
  `next_pay_date` date NULL DEFAULT NULL,
  `created_at` timestamp(0) NULL DEFAULT NULL,
  `updated_at` timestamp(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `stripe_invoices_company_id_foreign`(`company_id`) USING BTREE,
  INDEX `stripe_invoices_package_id_foreign`(`package_id`) USING BTREE,
  CONSTRAINT `stripe_invoices_company_id_foreign` FOREIGN KEY (`company_id`) REFERENCES `companies` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `stripe_invoices_package_id_foreign` FOREIGN KEY (`package_id`) REFERENCES `packages` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8 COLLATE = utf8_unicode_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of stripe_invoices
-- ----------------------------
INSERT INTO `stripe_invoices` VALUES (1, 1, NULL, 6, NULL, 60000.00, '2019-06-18', '2020-06-01', '2019-06-18 06:27:29', '2019-06-18 06:27:29');

-- ----------------------------
-- Table structure for stripe_setting
-- ----------------------------
DROP TABLE IF EXISTS `stripe_setting`;
CREATE TABLE `stripe_setting`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `api_key` varchar(191) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT NULL,
  `api_secret` varchar(191) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT NULL,
  `webhook_key` varchar(191) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT NULL,
  `paypal_client_id` varchar(191) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT NULL,
  `paypal_secret` varchar(191) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT NULL,
  `paypal_status` enum('active','inactive') CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT 'inactive',
  `stripe_status` enum('active','inactive') CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT 'inactive',
  `created_at` timestamp(0) NULL DEFAULT NULL,
  `updated_at` timestamp(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8 COLLATE = utf8_unicode_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of stripe_setting
-- ----------------------------
INSERT INTO `stripe_setting` VALUES (1, NULL, NULL, NULL, NULL, NULL, 'inactive', 'inactive', '2019-06-16 06:33:45', '2019-06-16 06:33:45');

-- ----------------------------
-- Table structure for sub_tasks
-- ----------------------------
DROP TABLE IF EXISTS `sub_tasks`;
CREATE TABLE `sub_tasks`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `task_id` int(10) UNSIGNED NOT NULL,
  `title` text CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `due_date` datetime(0) NULL DEFAULT NULL,
  `start_date` date NULL DEFAULT NULL,
  `status` enum('incomplete','complete') CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT 'incomplete',
  `created_at` timestamp(0) NULL DEFAULT NULL,
  `updated_at` timestamp(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `sub_tasks_task_id_foreign`(`task_id`) USING BTREE,
  CONSTRAINT `sub_tasks_task_id_foreign` FOREIGN KEY (`task_id`) REFERENCES `tasks` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_unicode_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for subscriptions
-- ----------------------------
DROP TABLE IF EXISTS `subscriptions`;
CREATE TABLE `subscriptions`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `company_id` int(10) UNSIGNED NOT NULL,
  `name` varchar(191) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `stripe_id` varchar(191) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `stripe_plan` varchar(191) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `quantity` int(11) NOT NULL,
  `trial_ends_at` timestamp(0) NULL DEFAULT NULL,
  `ends_at` timestamp(0) NULL DEFAULT NULL,
  `created_at` timestamp(0) NULL DEFAULT NULL,
  `updated_at` timestamp(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_unicode_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for task_category
-- ----------------------------
DROP TABLE IF EXISTS `task_category`;
CREATE TABLE `task_category`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `company_id` int(10) UNSIGNED NULL DEFAULT NULL,
  `category_name` varchar(191) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `created_at` timestamp(0) NULL DEFAULT NULL,
  `updated_at` timestamp(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `task_category_company_id_foreign`(`company_id`) USING BTREE,
  CONSTRAINT `task_category_company_id_foreign` FOREIGN KEY (`company_id`) REFERENCES `companies` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8 COLLATE = utf8_unicode_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of task_category
-- ----------------------------
INSERT INTO `task_category` VALUES (2, 1, 'Database', '2019-06-18 06:36:03', '2019-06-18 06:36:03');
INSERT INTO `task_category` VALUES (3, 1, 'Web Development', '2019-06-18 06:36:21', '2019-06-18 06:36:21');
INSERT INTO `task_category` VALUES (4, 1, 'Design System Architecture', '2019-06-21 03:35:34', '2019-06-21 03:35:34');

-- ----------------------------
-- Table structure for task_comments
-- ----------------------------
DROP TABLE IF EXISTS `task_comments`;
CREATE TABLE `task_comments`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `comment` text CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `user_id` int(10) UNSIGNED NOT NULL,
  `task_id` int(10) UNSIGNED NOT NULL,
  `created_at` timestamp(0) NULL DEFAULT NULL,
  `updated_at` timestamp(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `task_comments_user_id_foreign`(`user_id`) USING BTREE,
  INDEX `task_comments_task_id_foreign`(`task_id`) USING BTREE,
  CONSTRAINT `task_comments_task_id_foreign` FOREIGN KEY (`task_id`) REFERENCES `tasks` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `task_comments_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8 COLLATE = utf8_unicode_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of task_comments
-- ----------------------------
INSERT INTO `task_comments` VALUES (1, '<p>job has been doe&nbsp;</p>', 5, 4, '2019-06-20 09:33:17', '2019-06-20 09:33:17');

-- ----------------------------
-- Table structure for taskboard_columns
-- ----------------------------
DROP TABLE IF EXISTS `taskboard_columns`;
CREATE TABLE `taskboard_columns`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `company_id` int(10) UNSIGNED NULL DEFAULT NULL,
  `column_name` varchar(191) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `slug` varchar(191) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT NULL,
  `label_color` varchar(191) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `priority` int(11) NOT NULL,
  `created_at` timestamp(0) NULL DEFAULT NULL,
  `updated_at` timestamp(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `taskboard_columns_company_id_foreign`(`company_id`) USING BTREE,
  CONSTRAINT `taskboard_columns_company_id_foreign` FOREIGN KEY (`company_id`) REFERENCES `companies` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8 COLLATE = utf8_unicode_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of taskboard_columns
-- ----------------------------
INSERT INTO `taskboard_columns` VALUES (3, 1, 'Incomplete', 'incomplete', '#d21010', 1, '2019-06-16 06:34:19', '2019-06-16 06:34:19');
INSERT INTO `taskboard_columns` VALUES (4, 1, 'Completed', 'completed', '#679c0d', 2, '2019-06-16 06:34:19', '2019-06-16 06:34:19');

-- ----------------------------
-- Table structure for tasks
-- ----------------------------
DROP TABLE IF EXISTS `tasks`;
CREATE TABLE `tasks`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `company_id` int(10) UNSIGNED NULL DEFAULT NULL,
  `heading` varchar(191) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `description` mediumtext CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL,
  `due_date` date NOT NULL,
  `start_date` date NULL DEFAULT NULL,
  `user_id` int(10) UNSIGNED NOT NULL,
  `project_id` int(10) UNSIGNED NULL DEFAULT NULL,
  `task_category_id` int(10) UNSIGNED NULL DEFAULT NULL,
  `priority` enum('low','medium','high') CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT 'medium',
  `status` enum('incomplete','completed') CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT 'incomplete',
  `board_column_id` int(10) UNSIGNED NULL DEFAULT 1,
  `column_priority` int(11) NOT NULL,
  `completed_on` datetime(0) NULL DEFAULT NULL,
  `created_by` int(10) UNSIGNED NULL DEFAULT NULL,
  `created_at` timestamp(0) NULL DEFAULT NULL,
  `updated_at` timestamp(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `tasks_user_id_foreign`(`user_id`) USING BTREE,
  INDEX `tasks_project_id_foreign`(`project_id`) USING BTREE,
  INDEX `tasks_board_column_id_foreign`(`board_column_id`) USING BTREE,
  INDEX `tasks_company_id_foreign`(`company_id`) USING BTREE,
  INDEX `tasks_task_category_id_foreign`(`task_category_id`) USING BTREE,
  INDEX `tasks_created_by_foreign`(`created_by`) USING BTREE,
  CONSTRAINT `tasks_board_column_id_foreign` FOREIGN KEY (`board_column_id`) REFERENCES `taskboard_columns` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `tasks_company_id_foreign` FOREIGN KEY (`company_id`) REFERENCES `companies` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `tasks_created_by_foreign` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `tasks_project_id_foreign` FOREIGN KEY (`project_id`) REFERENCES `projects` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `tasks_task_category_id_foreign` FOREIGN KEY (`task_category_id`) REFERENCES `task_category` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `tasks_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 10 CHARACTER SET = utf8 COLLATE = utf8_unicode_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of tasks
-- ----------------------------
INSERT INTO `tasks` VALUES (2, 1, 'Database Generate', '<p>Database Generate<br></p>', '2019-06-18', '2019-06-18', 1, NULL, 3, 'medium', 'incomplete', 4, 0, '2019-06-18 00:00:00', 1, '2019-06-18 06:37:24', '2019-06-18 06:39:08');
INSERT INTO `tasks` VALUES (3, 1, 'User Module Created', NULL, '2019-06-20', '2019-06-20', 5, 1, 2, 'high', 'incomplete', 4, 0, '2019-06-20 00:00:00', 1, '2019-06-20 09:22:11', '2019-06-20 09:22:45');
INSERT INTO `tasks` VALUES (4, 1, 'asdasd', '<p>asdasd</p>', '2019-06-21', '2019-06-21', 5, 1, 3, 'high', 'incomplete', 4, 0, '2019-06-20 00:00:00', 1, '2019-06-20 09:31:42', '2019-06-20 09:32:57');
INSERT INTO `tasks` VALUES (9, 1, 'Design System Architecture', '<p>Design System Architecture<br></p>', '2019-06-27', '2019-06-21', 9, 2, 4, 'high', 'incomplete', 4, 0, '2019-06-22 00:00:00', 1, '2019-06-21 03:37:11', '2019-06-22 05:10:08');

-- ----------------------------
-- Table structure for taxes
-- ----------------------------
DROP TABLE IF EXISTS `taxes`;
CREATE TABLE `taxes`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `company_id` int(10) UNSIGNED NULL DEFAULT NULL,
  `tax_name` varchar(191) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `rate_percent` varchar(191) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `created_at` timestamp(0) NULL DEFAULT NULL,
  `updated_at` timestamp(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `taxes_company_id_foreign`(`company_id`) USING BTREE,
  CONSTRAINT `taxes_company_id_foreign` FOREIGN KEY (`company_id`) REFERENCES `companies` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_unicode_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for teams
-- ----------------------------
DROP TABLE IF EXISTS `teams`;
CREATE TABLE `teams`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `company_id` int(10) UNSIGNED NULL DEFAULT NULL,
  `team_name` varchar(191) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `created_at` timestamp(0) NULL DEFAULT NULL,
  `updated_at` timestamp(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `teams_company_id_foreign`(`company_id`) USING BTREE,
  CONSTRAINT `teams_company_id_foreign` FOREIGN KEY (`company_id`) REFERENCES `companies` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8 COLLATE = utf8_unicode_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of teams
-- ----------------------------
INSERT INTO `teams` VALUES (1, 1, 'TBL Project Team', '2019-06-21 03:32:39', '2019-06-21 03:32:39');

-- ----------------------------
-- Table structure for theme_settings
-- ----------------------------
DROP TABLE IF EXISTS `theme_settings`;
CREATE TABLE `theme_settings`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `company_id` int(10) UNSIGNED NULL DEFAULT NULL,
  `panel` varchar(191) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `header_color` varchar(191) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `sidebar_color` varchar(191) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `sidebar_text_color` varchar(191) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `link_color` varchar(191) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT '#ffffff',
  `user_css` longtext CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL,
  `created_at` timestamp(0) NULL DEFAULT NULL,
  `updated_at` timestamp(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `theme_settings_company_id_foreign`(`company_id`) USING BTREE,
  CONSTRAINT `theme_settings_company_id_foreign` FOREIGN KEY (`company_id`) REFERENCES `companies` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8 COLLATE = utf8_unicode_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of theme_settings
-- ----------------------------
INSERT INTO `theme_settings` VALUES (1, 1, 'admin', '#d35656', '#d6d6d6', '#000000', '#ffffff', '/*Enter your custom css after this line*/', '2019-06-16 06:34:21', '2019-06-22 05:45:33');
INSERT INTO `theme_settings` VALUES (2, 1, 'project_admin', '#5475ed', '#292929', '#cbcbcb', '#ffffff', NULL, '2019-06-16 06:34:22', '2019-06-16 06:34:22');
INSERT INTO `theme_settings` VALUES (3, 1, 'employee', '#f7c80c', '#757575', '#f8f8f8', '#ffffff', '/*Enter your custom css after this line*/', '2019-06-16 06:34:22', '2019-06-22 05:47:21');
INSERT INTO `theme_settings` VALUES (4, 1, 'client', '#00c292', '#292929', '#cbcbcb', '#ffffff', '/*Enter your custom css after this line*/', '2019-06-16 06:34:22', '2019-06-22 05:42:14');

-- ----------------------------
-- Table structure for ticket_agent_groups
-- ----------------------------
DROP TABLE IF EXISTS `ticket_agent_groups`;
CREATE TABLE `ticket_agent_groups`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `company_id` int(10) UNSIGNED NULL DEFAULT NULL,
  `agent_id` int(10) UNSIGNED NOT NULL,
  `group_id` int(10) UNSIGNED NULL DEFAULT NULL,
  `status` enum('enabled','disabled') CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT 'enabled',
  `created_at` timestamp(0) NULL DEFAULT NULL,
  `updated_at` timestamp(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `ticket_agent_groups_agent_id_foreign`(`agent_id`) USING BTREE,
  INDEX `ticket_agent_groups_group_id_foreign`(`group_id`) USING BTREE,
  INDEX `ticket_agent_groups_company_id_foreign`(`company_id`) USING BTREE,
  CONSTRAINT `ticket_agent_groups_agent_id_foreign` FOREIGN KEY (`agent_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `ticket_agent_groups_company_id_foreign` FOREIGN KEY (`company_id`) REFERENCES `companies` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `ticket_agent_groups_group_id_foreign` FOREIGN KEY (`group_id`) REFERENCES `ticket_groups` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_unicode_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for ticket_channels
-- ----------------------------
DROP TABLE IF EXISTS `ticket_channels`;
CREATE TABLE `ticket_channels`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `company_id` int(10) UNSIGNED NULL DEFAULT NULL,
  `channel_name` varchar(191) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `created_at` timestamp(0) NULL DEFAULT NULL,
  `updated_at` timestamp(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `ticket_channels_company_id_foreign`(`company_id`) USING BTREE,
  CONSTRAINT `ticket_channels_company_id_foreign` FOREIGN KEY (`company_id`) REFERENCES `companies` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 9 CHARACTER SET = utf8 COLLATE = utf8_unicode_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of ticket_channels
-- ----------------------------
INSERT INTO `ticket_channels` VALUES (1, NULL, 'Email', '2019-06-16 06:24:50', '2019-06-16 06:24:50');
INSERT INTO `ticket_channels` VALUES (2, NULL, 'Phone', '2019-06-16 06:24:50', '2019-06-16 06:24:50');
INSERT INTO `ticket_channels` VALUES (3, NULL, 'Twitter', '2019-06-16 06:24:51', '2019-06-16 06:24:51');
INSERT INTO `ticket_channels` VALUES (4, NULL, 'Facebook', '2019-06-16 06:24:51', '2019-06-16 06:24:51');
INSERT INTO `ticket_channels` VALUES (5, 1, 'Email', '2019-06-16 06:34:19', '2019-06-16 06:34:19');
INSERT INTO `ticket_channels` VALUES (6, 1, 'Phone', '2019-06-16 06:34:19', '2019-06-16 06:34:19');
INSERT INTO `ticket_channels` VALUES (7, 1, 'Twitter', '2019-06-16 06:34:19', '2019-06-16 06:34:19');
INSERT INTO `ticket_channels` VALUES (8, 1, 'Facebook', '2019-06-16 06:34:19', '2019-06-16 06:34:19');

-- ----------------------------
-- Table structure for ticket_groups
-- ----------------------------
DROP TABLE IF EXISTS `ticket_groups`;
CREATE TABLE `ticket_groups`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `company_id` int(10) UNSIGNED NULL DEFAULT NULL,
  `group_name` varchar(191) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `created_at` timestamp(0) NULL DEFAULT NULL,
  `updated_at` timestamp(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `ticket_groups_company_id_foreign`(`company_id`) USING BTREE,
  CONSTRAINT `ticket_groups_company_id_foreign` FOREIGN KEY (`company_id`) REFERENCES `companies` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = utf8 COLLATE = utf8_unicode_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of ticket_groups
-- ----------------------------
INSERT INTO `ticket_groups` VALUES (1, NULL, 'Sales', '2019-06-16 06:24:49', '2019-06-16 06:24:49');
INSERT INTO `ticket_groups` VALUES (2, NULL, 'Code', '2019-06-16 06:24:49', '2019-06-16 06:24:49');
INSERT INTO `ticket_groups` VALUES (3, NULL, 'Management', '2019-06-16 06:24:49', '2019-06-16 06:24:49');
INSERT INTO `ticket_groups` VALUES (4, 1, 'Sales', '2019-06-16 06:34:20', '2019-06-16 06:34:20');
INSERT INTO `ticket_groups` VALUES (5, 1, 'Code', '2019-06-16 06:34:20', '2019-06-16 06:34:20');
INSERT INTO `ticket_groups` VALUES (6, 1, 'Management', '2019-06-16 06:34:20', '2019-06-16 06:34:20');

-- ----------------------------
-- Table structure for ticket_replies
-- ----------------------------
DROP TABLE IF EXISTS `ticket_replies`;
CREATE TABLE `ticket_replies`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `ticket_id` int(10) UNSIGNED NOT NULL,
  `user_id` int(10) UNSIGNED NOT NULL,
  `message` mediumtext CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `created_at` timestamp(0) NULL DEFAULT NULL,
  `updated_at` timestamp(0) NULL DEFAULT NULL,
  `deleted_at` timestamp(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `ticket_replies_ticket_id_foreign`(`ticket_id`) USING BTREE,
  INDEX `ticket_replies_user_id_foreign`(`user_id`) USING BTREE,
  CONSTRAINT `ticket_replies_ticket_id_foreign` FOREIGN KEY (`ticket_id`) REFERENCES `tickets` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `ticket_replies_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = utf8 COLLATE = utf8_unicode_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of ticket_replies
-- ----------------------------
INSERT INTO `ticket_replies` VALUES (1, 1, 5, 'asdaads', '2019-06-20 09:14:04', '2019-06-20 09:14:04', NULL);
INSERT INTO `ticket_replies` VALUES (2, 2, 5, 'asdaads', '2019-06-20 09:14:09', '2019-06-20 09:14:09', NULL);
INSERT INTO `ticket_replies` VALUES (3, 3, 6, 'asdasdasdasd', '2019-06-20 09:15:33', '2019-06-20 09:15:33', NULL);
INSERT INTO `ticket_replies` VALUES (4, 2, 1, 'wasdadaddsdasd', '2019-06-20 09:18:12', '2019-06-20 09:18:12', NULL);
INSERT INTO `ticket_replies` VALUES (5, 3, 6, 'Ticket <strong>closed</strong> by Transcom', '2019-06-20 09:36:02', '2019-06-20 09:36:02', NULL);
INSERT INTO `ticket_replies` VALUES (6, 2, 5, 'ASDF', '2019-06-21 03:57:25', '2019-06-21 03:57:25', NULL);

-- ----------------------------
-- Table structure for ticket_reply_templates
-- ----------------------------
DROP TABLE IF EXISTS `ticket_reply_templates`;
CREATE TABLE `ticket_reply_templates`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `company_id` int(10) UNSIGNED NULL DEFAULT NULL,
  `reply_heading` mediumtext CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `reply_text` mediumtext CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `created_at` timestamp(0) NULL DEFAULT NULL,
  `updated_at` timestamp(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `ticket_reply_templates_company_id_foreign`(`company_id`) USING BTREE,
  CONSTRAINT `ticket_reply_templates_company_id_foreign` FOREIGN KEY (`company_id`) REFERENCES `companies` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_unicode_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for ticket_tag_list
-- ----------------------------
DROP TABLE IF EXISTS `ticket_tag_list`;
CREATE TABLE `ticket_tag_list`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `tag_name` varchar(191) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `created_at` timestamp(0) NULL DEFAULT NULL,
  `updated_at` timestamp(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_unicode_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for ticket_tags
-- ----------------------------
DROP TABLE IF EXISTS `ticket_tags`;
CREATE TABLE `ticket_tags`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `tag_id` int(10) UNSIGNED NOT NULL,
  `ticket_id` int(10) UNSIGNED NOT NULL,
  `created_at` timestamp(0) NULL DEFAULT NULL,
  `updated_at` timestamp(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `ticket_tags_tag_id_foreign`(`tag_id`) USING BTREE,
  INDEX `ticket_tags_ticket_id_foreign`(`ticket_id`) USING BTREE,
  CONSTRAINT `ticket_tags_tag_id_foreign` FOREIGN KEY (`tag_id`) REFERENCES `ticket_tag_list` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `ticket_tags_ticket_id_foreign` FOREIGN KEY (`ticket_id`) REFERENCES `tickets` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_unicode_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for ticket_types
-- ----------------------------
DROP TABLE IF EXISTS `ticket_types`;
CREATE TABLE `ticket_types`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `company_id` int(10) UNSIGNED NULL DEFAULT NULL,
  `type` varchar(191) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `created_at` timestamp(0) NULL DEFAULT NULL,
  `updated_at` timestamp(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `ticket_types_company_id_foreign`(`company_id`) USING BTREE,
  CONSTRAINT `ticket_types_company_id_foreign` FOREIGN KEY (`company_id`) REFERENCES `companies` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 9 CHARACTER SET = utf8 COLLATE = utf8_unicode_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of ticket_types
-- ----------------------------
INSERT INTO `ticket_types` VALUES (1, NULL, 'Question', '2019-06-16 06:24:48', '2019-06-16 06:24:48');
INSERT INTO `ticket_types` VALUES (2, NULL, 'Problem', '2019-06-16 06:24:48', '2019-06-16 06:24:48');
INSERT INTO `ticket_types` VALUES (3, NULL, 'Incident', '2019-06-16 06:24:48', '2019-06-16 06:24:48');
INSERT INTO `ticket_types` VALUES (4, NULL, 'Feature Request', '2019-06-16 06:24:49', '2019-06-16 06:24:49');
INSERT INTO `ticket_types` VALUES (5, 1, 'Question', '2019-06-16 06:34:20', '2019-06-16 06:34:20');
INSERT INTO `ticket_types` VALUES (6, 1, 'Problem', '2019-06-16 06:34:20', '2019-06-16 06:34:20');
INSERT INTO `ticket_types` VALUES (7, 1, 'Incident', '2019-06-16 06:34:20', '2019-06-16 06:34:20');
INSERT INTO `ticket_types` VALUES (8, 1, 'Feature Request', '2019-06-16 06:34:20', '2019-06-16 06:34:20');

-- ----------------------------
-- Table structure for tickets
-- ----------------------------
DROP TABLE IF EXISTS `tickets`;
CREATE TABLE `tickets`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `company_id` int(10) UNSIGNED NULL DEFAULT NULL,
  `user_id` int(10) UNSIGNED NOT NULL,
  `subject` text CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `status` enum('open','pending','resolved','closed') CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT 'open',
  `priority` enum('low','medium','high','urgent') CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT 'medium',
  `agent_id` int(10) UNSIGNED NULL DEFAULT NULL,
  `channel_id` int(10) UNSIGNED NULL DEFAULT NULL,
  `type_id` int(10) UNSIGNED NULL DEFAULT NULL,
  `created_at` timestamp(0) NULL DEFAULT NULL,
  `updated_at` timestamp(0) NULL DEFAULT NULL,
  `deleted_at` timestamp(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `tickets_user_id_foreign`(`user_id`) USING BTREE,
  INDEX `tickets_agent_id_foreign`(`agent_id`) USING BTREE,
  INDEX `tickets_channel_id_foreign`(`channel_id`) USING BTREE,
  INDEX `tickets_type_id_foreign`(`type_id`) USING BTREE,
  INDEX `tickets_company_id_foreign`(`company_id`) USING BTREE,
  CONSTRAINT `tickets_agent_id_foreign` FOREIGN KEY (`agent_id`) REFERENCES `users` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `tickets_channel_id_foreign` FOREIGN KEY (`channel_id`) REFERENCES `ticket_channels` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `tickets_company_id_foreign` FOREIGN KEY (`company_id`) REFERENCES `companies` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `tickets_type_id_foreign` FOREIGN KEY (`type_id`) REFERENCES `ticket_types` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `tickets_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8 COLLATE = utf8_unicode_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of tickets
-- ----------------------------
INSERT INTO `tickets` VALUES (1, 1, 5, 'Notification create problem', 'open', 'medium', NULL, NULL, NULL, '2019-06-20 09:14:03', '2019-06-20 09:14:03', NULL);
INSERT INTO `tickets` VALUES (2, 1, 5, 'Notification create problem', 'open', 'medium', NULL, 5, 5, '2019-06-20 09:14:09', '2019-06-20 09:18:12', NULL);
INSERT INTO `tickets` VALUES (3, 1, 6, 'Notification cretaing problem', 'closed', 'medium', NULL, NULL, NULL, '2019-06-20 09:15:33', '2019-06-20 09:36:02', NULL);

-- ----------------------------
-- Table structure for universal_search
-- ----------------------------
DROP TABLE IF EXISTS `universal_search`;
CREATE TABLE `universal_search`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `searchable_id` int(11) NOT NULL,
  `title` varchar(191) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `route_name` varchar(191) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `created_at` timestamp(0) NULL DEFAULT NULL,
  `updated_at` timestamp(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 11 CHARACTER SET = utf8 COLLATE = utf8_unicode_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of universal_search
-- ----------------------------
INSERT INTO `universal_search` VALUES (1, 1, 'Admin Name', 'admin.employees.show', '2019-06-16 06:34:25', '2019-06-16 06:34:25');
INSERT INTO `universal_search` VALUES (2, 2, 'Pablo Klocko', 'admin.employees.show', '2019-06-16 06:34:25', '2019-06-16 06:34:25');
INSERT INTO `universal_search` VALUES (3, 1, 'Project: JU Student System', 'admin.projects.show', '2019-06-19 05:22:29', '2019-06-19 05:22:29');
INSERT INTO `universal_search` VALUES (4, 1, 'Notice: Eid Holiday', 'admin.notices.edit', '2019-06-20 08:35:52', '2019-06-20 08:35:52');
INSERT INTO `universal_search` VALUES (5, 9, 'fahim', 'admin.employees.show', '2019-06-20 15:23:29', '2019-06-20 15:23:29');
INSERT INTO `universal_search` VALUES (6, 10, 'Forhad Hossain', 'admin.employees.show', '2019-06-20 15:29:58', '2019-06-20 15:29:58');
INSERT INTO `universal_search` VALUES (7, 12, 'Transcom Electronics', 'admin.clients.edit', '2019-06-20 15:36:25', '2019-06-20 15:36:25');
INSERT INTO `universal_search` VALUES (8, 12, 'tel@example.com', 'admin.clients.edit', '2019-06-20 15:36:25', '2019-06-20 15:36:25');
INSERT INTO `universal_search` VALUES (9, 12, 'Pepsi Bangladesh', 'admin.clients.edit', '2019-06-20 15:36:25', '2019-06-20 15:36:25');
INSERT INTO `universal_search` VALUES (10, 2, 'Project: TBL Sales', 'admin.projects.show', '2019-06-21 03:29:19', '2019-06-21 03:29:19');

-- ----------------------------
-- Table structure for user_activities
-- ----------------------------
DROP TABLE IF EXISTS `user_activities`;
CREATE TABLE `user_activities`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `company_id` int(10) UNSIGNED NULL DEFAULT NULL,
  `user_id` int(10) UNSIGNED NOT NULL,
  `activity` text CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `created_at` timestamp(0) NULL DEFAULT NULL,
  `updated_at` timestamp(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `user_activities_user_id_foreign`(`user_id`) USING BTREE,
  INDEX `user_activities_company_id_foreign`(`company_id`) USING BTREE,
  CONSTRAINT `user_activities_company_id_foreign` FOREIGN KEY (`company_id`) REFERENCES `companies` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `user_activities_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_unicode_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for users
-- ----------------------------
DROP TABLE IF EXISTS `users`;
CREATE TABLE `users`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `company_id` int(10) UNSIGNED NULL DEFAULT NULL,
  `name` varchar(191) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `email` varchar(191) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `password` varchar(191) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `remember_token` varchar(100) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT NULL,
  `image` varchar(191) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT NULL,
  `mobile` varchar(191) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT NULL,
  `gender` enum('male','female','others') CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT 'male',
  `locale` varchar(191) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT 'en',
  `status` enum('active','deactive') CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT 'active',
  `login` enum('enable','disable') CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT 'enable',
  `onesignal_player_id` text CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL,
  `created_at` timestamp(0) NULL DEFAULT NULL,
  `updated_at` timestamp(0) NULL DEFAULT NULL,
  `super_admin` enum('0','1') CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  `email_verification_code` varchar(40) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `users_email_unique`(`email`) USING BTREE,
  INDEX `users_company_id_foreign`(`company_id`) USING BTREE,
  CONSTRAINT `users_company_id_foreign` FOREIGN KEY (`company_id`) REFERENCES `companies` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 13 CHARACTER SET = utf8 COLLATE = utf8_unicode_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of users
-- ----------------------------
INSERT INTO `users` VALUES (1, 1, 'Admin Name', 'admin@example.com', '$2y$10$XeIAbG.f9vKmfhoHTJJkcOoqjSARUowPUl9vzGjkg1N90PEbHtyqy', 'RXYI8BF2uKEGifRfRDeL6lmjCuDuvhdFrs4lIyrHCfs5sL8edhEhaxoAYzhD', NULL, NULL, 'male', 'en', 'active', 'enable', NULL, '2019-06-16 06:34:25', '2019-06-16 06:34:25', '0', NULL);
INSERT INTO `users` VALUES (3, NULL, 'Super Admin', 'superadmin@example.com', '$2y$10$EGshVHpMwUmjRkOlz8/kS.KbinfiFkP4snti9ZPGmCW1qq38tN5pm', 'dmwtiY0sFRXIoUZnaqE1VFOkH00PGwTj63SvoSy4hCOlPABKBCJCtbShNOM6', NULL, NULL, 'male', 'en', 'active', 'enable', NULL, '2019-06-16 06:34:25', '2019-06-16 06:34:25', '1', NULL);
INSERT INTO `users` VALUES (4, 1, 'ju', 'ju@example.com', '$2y$10$AJQhr1qvFxM3.wXokEZv5.O7x7xvx4pMxoPvI1gsgvr/xCMZ0q8Gm', 'HlssrEHbOWlUroH5CBvCDr11wHUo5p9iIfo3VXDAutuK6KBsjNXb5bfpAJpF', NULL, NULL, 'male', 'en', 'active', 'enable', NULL, '2019-06-18 06:41:48', '2019-06-18 06:41:48', '0', NULL);
INSERT INTO `users` VALUES (5, 1, 'Ashik', 'ashik@gmail.com', '$2y$10$8gS/Mq097YJusaQAdu5bnu8d.EhblgnFudWlDQQkb12PZTQO1vBKe', '3RKLKBq1C7qu0eqTK3NHlkUtVizwLnTf6wR4eBnWuBTHhXZl7rBJHyAndarv', NULL, NULL, 'male', 'en', 'active', 'enable', NULL, '2019-06-18 06:45:54', '2019-06-18 06:45:54', '0', NULL);
INSERT INTO `users` VALUES (6, 1, 'Transcom', 'transcom@example.com', '$2y$10$8iwRPP3U76sjb52vUfogKO0wT4M4tvNjh6EOutCAcgrRkgJWTEgYW', 'e0sDicdjB99svVkQ76UgnGQla1YGp1lj6tdms1MCL49rAB2YaEIYqUtQ1Rj7', NULL, NULL, 'male', 'en', 'active', 'enable', NULL, '2019-06-19 05:20:54', '2019-06-19 05:20:54', '0', NULL);
INSERT INTO `users` VALUES (7, 1, 'Sagir Ahmed', 'sagir@gmail.com', '$2y$10$M3Pan.lE3WzOZwjBK9vFQ.zzEPsuXH02qpF8Byw5.o71UoFRcoeSq', NULL, NULL, NULL, 'male', 'en', 'active', 'enable', NULL, '2019-06-20 08:31:09', '2019-06-20 08:31:09', '0', NULL);
INSERT INTO `users` VALUES (8, 1, 'Nokib', 'nokib@gmail.com', '$2y$10$m6aiRd4JtNT/CFMHtNgPNOtLOM.2ArMWYSRh7G8zYGqC9hUv1vxCC', NULL, NULL, NULL, 'male', 'en', 'active', 'enable', NULL, '2019-06-20 15:16:18', '2019-06-20 15:16:18', '0', NULL);
INSERT INTO `users` VALUES (9, 1, 'fahim', 'fahim@gmail.com', '$2y$10$AEgGfe219NvCaE4FBhunH.qjTGKvGDwV8sAmU.5d0Cip1JOtaXm5K', NULL, NULL, NULL, 'male', 'en', 'active', 'enable', NULL, '2019-06-20 15:23:29', '2019-06-20 15:23:29', '0', NULL);
INSERT INTO `users` VALUES (10, 1, 'Forhad Hossain', 'forhad@gmail.com', '$2y$10$g3Og06eyPy6laX4LjMzr1eUSlm2Ojbe22ZIImPjOykLgbX3jNoe8m', NULL, 'V04EXQTj4GUsYWIpN80M166RJlYdkOSqcxjvI0Rs.jpeg', NULL, 'male', 'en', 'active', 'enable', NULL, '2019-06-20 15:29:57', '2019-06-20 15:29:57', '0', NULL);
INSERT INTO `users` VALUES (11, 1, 'Transcom Babarage', 'pepsi@example.com', '$2y$10$ieExxsIMnPqvXMPLQ27jIuoKVbT8m/ftdZKHGFxY.QOPNiDP7EDj6', NULL, NULL, NULL, 'male', 'en', 'active', 'enable', NULL, '2019-06-20 15:32:44', '2019-06-20 15:32:44', '0', NULL);
INSERT INTO `users` VALUES (12, 1, 'Transcom Electronics', 'tel@example.com', '$2y$10$4UW8biQPN7NcOrXeXbj76ueT6gDAGoLMODWFvnrrEr2hR/08C2ERy', NULL, NULL, NULL, 'male', 'en', 'active', 'enable', NULL, '2019-06-20 15:36:25', '2019-06-20 15:36:25', '0', NULL);

-- ----------------------------
-- Table structure for users_chat
-- ----------------------------
DROP TABLE IF EXISTS `users_chat`;
CREATE TABLE `users_chat`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_one` int(10) UNSIGNED NOT NULL,
  `user_id` int(10) UNSIGNED NOT NULL,
  `message` varchar(191) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `from` int(10) UNSIGNED NULL DEFAULT NULL,
  `to` int(10) UNSIGNED NULL DEFAULT NULL,
  `message_seen` enum('yes','no') CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT 'no',
  `created_at` timestamp(0) NULL DEFAULT NULL,
  `updated_at` timestamp(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `users_chat_user_one_foreign`(`user_one`) USING BTREE,
  INDEX `users_chat_user_id_foreign`(`user_id`) USING BTREE,
  INDEX `users_chat_from_foreign`(`from`) USING BTREE,
  INDEX `users_chat_to_foreign`(`to`) USING BTREE,
  CONSTRAINT `users_chat_from_foreign` FOREIGN KEY (`from`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `users_chat_to_foreign` FOREIGN KEY (`to`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `users_chat_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `users_chat_user_one_foreign` FOREIGN KEY (`user_one`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_unicode_ci ROW_FORMAT = Compact;

SET FOREIGN_KEY_CHECKS = 1;

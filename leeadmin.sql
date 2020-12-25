/*
 Navicat Premium Data Transfer

 Source Server         : dnmp-mysql
 Source Server Type    : MySQL
 Source Server Version : 50728
 Source Host           : 127.0.0.1:3306
 Source Schema         : leeadmin

 Target Server Type    : MySQL
 Target Server Version : 50728
 File Encoding         : 65001

 Date: 25/12/2020 16:16:51
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for lee_admin
-- ----------------------------
DROP TABLE IF EXISTS `lee_admin`;
CREATE TABLE `lee_admin`  (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `username` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `pwd` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `salt` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `status` int(1) NOT NULL DEFAULT 1 COMMENT '1正常-1禁止登陆',
  `create_time` int(11) NOT NULL DEFAULT 0,
  `update_time` int(11) NOT NULL DEFAULT 0,
  `last_login_time` int(11) NOT NULL DEFAULT 0,
  `last_login_ip` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `nickname` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT '',
  `desc` text CHARACTER SET utf8 COLLATE utf8_general_ci COMMENT '备注',
  `thumb` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `groups` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '权限组,隔开',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `username`(`id`, `username`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '管理员' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of lee_admin
-- ----------------------------
INSERT INTO `lee_admin` VALUES (1, 'admin', 'd36ad0d7d762dcee1e1867566f168e1a', '61rv3iLXpHouZAdk0RIY', 1, 1588728578, 1589273418, 1608882423, '172.20.0.1', 'Admin', NULL, 'http://ky-1255304035.cos.ap-beijing.myqcloud.com/storage/20200512/67117c45f31240798232138827c31290.jpg', '');
INSERT INTO `lee_admin` VALUES (2, 'test', '6bf79bc01d73bb3dba758cbadd18c657', 'ZksDMAg2pWJ5QrqTFaC0', 1, 1591775293, 1608882248, 1608882455, '172.20.0.1', 'test', '', '/storage/topic/20200610\\cfefb2d076cea3c11cb0a30ae8b779de.jpg', '1');

-- ----------------------------
-- Table structure for lee_admin_group
-- ----------------------------
DROP TABLE IF EXISTS `lee_admin_group`;
CREATE TABLE `lee_admin_group`  (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `title` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `status` int(1) NOT NULL DEFAULT 1,
  `rules` text CHARACTER SET utf8 COLLATE utf8_general_ci COMMENT '用户组拥有的规则id， 多个规则\",\"隔开',
  `desc` text CHARACTER SET utf8 COLLATE utf8_general_ci COMMENT '备注',
  `create_time` int(11) NOT NULL DEFAULT 0,
  `update_time` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `id`(`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '权限分组' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of lee_admin_group
-- ----------------------------
INSERT INTO `lee_admin_group` VALUES (1, '超级管理员', 1, '1,2,3,4,5,14,6,7,8,9,10,11,12,13,15,16,26,27,28,29,55,17,18,19,20,21,22,23,24,25,31,34,35,36,37,38,39,40,32,41,42,43,44,45,46,47,48,49,50,51,52,53,54,56,57,156,157', '', 1590565054, 1608882439);

-- ----------------------------
-- Table structure for lee_admin_rule
-- ----------------------------
DROP TABLE IF EXISTS `lee_admin_rule`;
CREATE TABLE `lee_admin_rule`  (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `pid` int(11) UNSIGNED NOT NULL DEFAULT 0,
  `src` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '规则',
  `title` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `is_menu` int(1) NOT NULL DEFAULT 1 COMMENT '1是菜单2不是',
  `font_family` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT '' COMMENT '图标来源',
  `icon` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '图标',
  `sort` int(11) NOT NULL DEFAULT 0 COMMENT '排序，越大越靠前',
  `create_time` int(11) NOT NULL DEFAULT 0,
  `update_time` int(11) DEFAULT NULL COMMENT '0',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `name`(`src`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 158 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '权限节点' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of lee_admin_rule
-- ----------------------------
INSERT INTO `lee_admin_rule` VALUES (1, 0, '', '系统', 1, '', '', -1, 0, 0);
INSERT INTO `lee_admin_rule` VALUES (2, 1, 'system.menu/index', '菜单', 1, '', 'fa fa-bars', 0, 0, 0);
INSERT INTO `lee_admin_rule` VALUES (3, 2, 'system.menu/add', '添加菜单', 0, '', '', 0, 0, 0);
INSERT INTO `lee_admin_rule` VALUES (4, 2, 'system.menu/edit', '修改菜单', 0, '', '', 0, 0, 0);
INSERT INTO `lee_admin_rule` VALUES (5, 2, 'system.menu/delete', '删除菜单', 0, '', '', 0, 0, 0);
INSERT INTO `lee_admin_rule` VALUES (6, 14, 'system.admin/index', '管理员', 1, '', 'fa fa-user', 0, 0, 0);
INSERT INTO `lee_admin_rule` VALUES (7, 6, 'system.admin/add', '添加管理员', 0, '', '', 0, 0, 0);
INSERT INTO `lee_admin_rule` VALUES (8, 6, 'system.admin/edit', '修改管理员', 0, '', '', 0, 0, 0);
INSERT INTO `lee_admin_rule` VALUES (9, 6, 'system.admin/delete', '删除管理员', 0, '', '', 0, 0, 0);
INSERT INTO `lee_admin_rule` VALUES (10, 14, 'system.group/index', '管理组', 1, '', 'fa fa-users', 0, 0, 0);
INSERT INTO `lee_admin_rule` VALUES (11, 10, 'system.group/add', '添加权限组', 0, '', '', 0, 0, 0);
INSERT INTO `lee_admin_rule` VALUES (12, 10, 'system.group/edit', '修改权限组', 0, '', '', 0, 0, 0);
INSERT INTO `lee_admin_rule` VALUES (13, 10, 'system.group/delete', '删除权限组', 0, '', '', 0, 0, 0);
INSERT INTO `lee_admin_rule` VALUES (14, 1, '', '安全', 1, '', 'fa fa-shield', -1, 0, 0);
INSERT INTO `lee_admin_rule` VALUES (15, 1, 'system.conf/index', '配置', 1, '', 'fa fa-gear', 0, 0, 0);
INSERT INTO `lee_admin_rule` VALUES (16, 15, 'system.conf/confsubmit', '提交配置', 0, '', '', 0, 0, 0);
INSERT INTO `lee_admin_rule` VALUES (17, 0, '', '应用', 1, '', 'fa fa-cube', -2, 0, 0);
INSERT INTO `lee_admin_rule` VALUES (18, 17, 'system.nav/index', '导航', 1, '', 'fa fa-navicon', 0, 0, 0);
INSERT INTO `lee_admin_rule` VALUES (19, 18, 'system.nav/addgroup', '添加导航组', 0, '', '', 0, 0, 0);
INSERT INTO `lee_admin_rule` VALUES (20, 18, 'system.nav/editgroup', '修改导航组', 0, '', '', 0, 0, 0);
INSERT INTO `lee_admin_rule` VALUES (21, 18, 'system.nav/deletegroup', '删除导航组', 0, '', '', 0, 0, 0);
INSERT INTO `lee_admin_rule` VALUES (22, 18, 'system.nav/navindex', '导航集', 0, '', '', 0, 0, 0);
INSERT INTO `lee_admin_rule` VALUES (23, 18, 'system.nav/addnav', '添加导航', 0, '', '', 0, 0, 0);
INSERT INTO `lee_admin_rule` VALUES (24, 18, 'system.nav/editnav', '修改导航', 0, '', '', 0, 0, 0);
INSERT INTO `lee_admin_rule` VALUES (25, 18, 'system.nav/deletenav', '删除导航', 0, '', '', 0, 0, 0);
INSERT INTO `lee_admin_rule` VALUES (26, 1, 'system.route/index', '路由', 1, '', 'fa fa-flag', 0, 0, 0);
INSERT INTO `lee_admin_rule` VALUES (27, 26, 'system.route/add', '添加美化', 0, '', '', 0, 0, 0);
INSERT INTO `lee_admin_rule` VALUES (28, 26, 'system.route/edit', '修改美化', 0, '', '', 0, 0, 0);
INSERT INTO `lee_admin_rule` VALUES (29, 26, 'system.route/delete', '删除美化', 0, '', '', 0, 0, 0);
INSERT INTO `lee_admin_rule` VALUES (31, 17, 'system.slide/index', '轮播', 1, '', 'fa fa-laptop', 0, 0, 0);
INSERT INTO `lee_admin_rule` VALUES (32, 17, 'system.cate/index', '分类', 1, '', 'fa fa-tag', 0, 0, 0);
INSERT INTO `lee_admin_rule` VALUES (34, 31, 'system.slide/addgroup', '添加轮播组', 0, '', '', 0, 0, 0);
INSERT INTO `lee_admin_rule` VALUES (35, 31, 'system.slide/editgroup', '修改轮播组', 0, '', '', 0, 0, 0);
INSERT INTO `lee_admin_rule` VALUES (36, 31, 'system.slide/deletegroup', '删除轮播组', 0, '', '', 0, 0, 0);
INSERT INTO `lee_admin_rule` VALUES (37, 31, 'system.slide/slideindex', '轮播集', 0, '', '', 0, 0, 0);
INSERT INTO `lee_admin_rule` VALUES (38, 31, 'system.slide/addslide', '添加轮播图', 0, '', '', 0, 0, 0);
INSERT INTO `lee_admin_rule` VALUES (39, 31, 'system.slide/editslide', '修改轮播图', 0, '', '', 0, 0, 0);
INSERT INTO `lee_admin_rule` VALUES (40, 31, 'system.slide/deleteslide', '删除轮播图', 0, '', '', 0, 0, 0);
INSERT INTO `lee_admin_rule` VALUES (41, 32, 'system.cate/addgroup', '添加分类组', 0, '', '', 0, 0, 0);
INSERT INTO `lee_admin_rule` VALUES (42, 32, 'system.cate/editgroup', '修改分类组', 0, '', '', 0, 0, 0);
INSERT INTO `lee_admin_rule` VALUES (43, 32, 'system.cate/deletegroup', '删除分类组', 0, '', '', 0, 0, 0);
INSERT INTO `lee_admin_rule` VALUES (44, 32, 'system.cate/cateindex', '分类集', 0, '', '', 0, 0, 0);
INSERT INTO `lee_admin_rule` VALUES (45, 32, 'system.cate/addcate', '添加分类', 0, '', '', 0, 0, 0);
INSERT INTO `lee_admin_rule` VALUES (46, 32, 'system.cate/editcate', '修改分类', 0, '', '', 0, 0, 0);
INSERT INTO `lee_admin_rule` VALUES (47, 32, 'system.cate/deletecate', '删除分类', 0, '', '', 0, 0, 0);
INSERT INTO `lee_admin_rule` VALUES (48, 17, 'system.content/index', '内容', 1, '', 'fa fa-shield', 0, 0, 0);
INSERT INTO `lee_admin_rule` VALUES (49, 48, 'system.content/addgroup', '添加内容组', 0, '', '', 0, 0, 0);
INSERT INTO `lee_admin_rule` VALUES (50, 48, 'system.content/editgroup', '修改内容组', 0, '', '', 0, 0, 0);
INSERT INTO `lee_admin_rule` VALUES (51, 48, 'system.content/deletegroup', '删除内容组', 0, '', '', 0, 0, 0);
INSERT INTO `lee_admin_rule` VALUES (52, 48, 'system.content/addcontent', '添加内容', 0, '', '', 0, 0, 0);
INSERT INTO `lee_admin_rule` VALUES (53, 48, 'system.content/editcontent', '修改内容', 0, '', '', 0, 0, 0);
INSERT INTO `lee_admin_rule` VALUES (54, 48, 'system.content/deletecontent', '删除内容', 0, '', '', 0, 0, 0);
INSERT INTO `lee_admin_rule` VALUES (55, 1, 'system.AdminUserAction/index', '操作日志', 1, '', 'fa fa-book', 0, 0, 0);
INSERT INTO `lee_admin_rule` VALUES (56, 0, '', '微信管理', 1, '', 'fa fa-weixin', 0, 0, NULL);
INSERT INTO `lee_admin_rule` VALUES (57, 56, 'system.user/index', '用户管理', 1, '', '', 0, 0, NULL);
INSERT INTO `lee_admin_rule` VALUES (156, 0, 'system.index/index', '首页', 0, '', '', 0, 0, NULL);
INSERT INTO `lee_admin_rule` VALUES (157, 0, 'system.index/getadminmenulist', 'system.index/getadminmenulist', 0, '', '', 0, 0, NULL);

-- ----------------------------
-- Table structure for lee_admin_user_action
-- ----------------------------
DROP TABLE IF EXISTS `lee_admin_user_action`;
CREATE TABLE `lee_admin_user_action`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` int(11) DEFAULT 0 COMMENT '操作用户ID',
  `nickname` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '用户昵称',
  `add_time` int(11) DEFAULT 0 COMMENT '操作时间',
  `data` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci COMMENT '用户提交的数据',
  `url` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '0' COMMENT '操作URL',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `uid`(`uid`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 359 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '用户操作日志' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of lee_admin_user_action
-- ----------------------------
INSERT INTO `lee_admin_user_action` VALUES (1, 1, 'Admin', 1591840892, '{\"username\":\"admin\",\"password\":\"123456\"}', 'system.Publicer/adminloginsubmit');
INSERT INTO `lee_admin_user_action` VALUES (2, 1, 'Admin', 1591840894, '[]', 'system.Index/index');
INSERT INTO `lee_admin_user_action` VALUES (3, 1, 'Admin', 1591840895, '[]', 'system.Index/getadminmenulist');
INSERT INTO `lee_admin_user_action` VALUES (4, 1, 'Admin', 1591840895, '[]', 'system.Index/console');
INSERT INTO `lee_admin_user_action` VALUES (5, 1, 'Admin', 1591840900, '[]', 'system.AdminUserAction/index');
INSERT INTO `lee_admin_user_action` VALUES (6, 1, 'Admin', 1591840900, '{\"page\":\"1\",\"limit\":\"10\"}', 'system.AdminUserAction/index');
INSERT INTO `lee_admin_user_action` VALUES (7, 1, 'Admin', 1591840903, '[]', 'system.Menu/index');
INSERT INTO `lee_admin_user_action` VALUES (8, 1, 'Admin', 1591840903, '[]', 'system.Menu/index');
INSERT INTO `lee_admin_user_action` VALUES (9, 1, 'Admin', 1591840907, '[]', 'system.AdminUserAction/index');
INSERT INTO `lee_admin_user_action` VALUES (10, 1, 'Admin', 1591840908, '{\"page\":\"1\",\"limit\":\"10\"}', 'system.AdminUserAction/index');
INSERT INTO `lee_admin_user_action` VALUES (11, 1, 'Admin', 1591840915, '[]', 'system.AdminUserAction/index');
INSERT INTO `lee_admin_user_action` VALUES (12, 1, 'Admin', 1591840915, '{\"page\":\"1\",\"limit\":\"10\"}', 'system.AdminUserAction/index');
INSERT INTO `lee_admin_user_action` VALUES (13, 1, 'Admin', 1591840919, '[]', 'system.Nav/index');
INSERT INTO `lee_admin_user_action` VALUES (14, 1, 'Admin', 1591840919, '{\"page\":\"1\",\"limit\":\"10\"}', 'system.Nav/index');
INSERT INTO `lee_admin_user_action` VALUES (15, 1, 'Admin', 1591840924, '[]', 'system.AdminUserAction/index');
INSERT INTO `lee_admin_user_action` VALUES (16, 1, 'Admin', 1591840924, '{\"page\":\"1\",\"limit\":\"10\"}', 'system.AdminUserAction/index');
INSERT INTO `lee_admin_user_action` VALUES (17, 1, 'Admin', 1591840928, '{\"page\":\"2\",\"limit\":\"10\"}', 'system.AdminUserAction/index');
INSERT INTO `lee_admin_user_action` VALUES (18, 1, 'Admin', 1591840930, '{\"page\":\"1\",\"limit\":\"10\"}', 'system.AdminUserAction/index');
INSERT INTO `lee_admin_user_action` VALUES (19, 1, 'Admin', 1591840931, '{\"page\":\"2\",\"limit\":\"10\"}', 'system.AdminUserAction/index');
INSERT INTO `lee_admin_user_action` VALUES (20, 1, 'Admin', 1591840934, '{\"page\":\"1\",\"limit\":\"10\"}', 'system.AdminUserAction/index');
INSERT INTO `lee_admin_user_action` VALUES (21, 1, 'Admin', 1591840936, '[]', 'system.Conf/index');
INSERT INTO `lee_admin_user_action` VALUES (22, 1, 'Admin', 1591840939, '[]', 'system.Slide/index');
INSERT INTO `lee_admin_user_action` VALUES (23, 1, 'Admin', 1591840939, '{\"page\":\"1\",\"limit\":\"10\"}', 'system.Slide/index');
INSERT INTO `lee_admin_user_action` VALUES (24, 1, 'Admin', 1591840940, '[]', 'system.Cate/index');
INSERT INTO `lee_admin_user_action` VALUES (25, 1, 'Admin', 1591840940, '{\"page\":\"1\",\"limit\":\"10\"}', 'system.Cate/index');
INSERT INTO `lee_admin_user_action` VALUES (26, 1, 'Admin', 1591840941, '[]', 'system.Content/index');
INSERT INTO `lee_admin_user_action` VALUES (27, 1, 'Admin', 1591840942, '{\"page\":\"1\",\"limit\":\"10\"}', 'system.Content/index');
INSERT INTO `lee_admin_user_action` VALUES (28, 1, 'Admin', 1591840945, '[]', 'system.Cate/addgroup');
INSERT INTO `lee_admin_user_action` VALUES (29, 1, 'Admin', 1591840948, '{\"page\":\"1\",\"limit\":\"10\"}', 'system.Cate/index');
INSERT INTO `lee_admin_user_action` VALUES (30, 1, 'Admin', 1591840950, '[]', 'system.Cate/addgroup');
INSERT INTO `lee_admin_user_action` VALUES (31, 1, 'Admin', 1591840954, '{\"page\":\"1\",\"limit\":\"10\"}', 'system.Cate/index');
INSERT INTO `lee_admin_user_action` VALUES (32, 1, 'Admin', 1591840961, '[]', 'system.Route/index');
INSERT INTO `lee_admin_user_action` VALUES (33, 1, 'Admin', 1591840961, '{\"page\":\"1\",\"limit\":\"15\"}', 'system.Route/index');
INSERT INTO `lee_admin_user_action` VALUES (34, 1, 'Admin', 1591840982, '[]', 'system.Index/editadmininfo');
INSERT INTO `lee_admin_user_action` VALUES (35, 1, 'Admin', 1591840991, '[]', 'system.Index/editadmininfo');
INSERT INTO `lee_admin_user_action` VALUES (36, 1, 'Admin', 1591840996, '[]', 'system.Index/index');
INSERT INTO `lee_admin_user_action` VALUES (37, 1, 'Admin', 1591840996, '[]', 'system.Index/getadminmenulist');
INSERT INTO `lee_admin_user_action` VALUES (38, 1, 'Admin', 1591840996, '[]', 'system.Index/console');
INSERT INTO `lee_admin_user_action` VALUES (39, 1, 'Admin', 1591841000, '[]', 'system.Index/index');
INSERT INTO `lee_admin_user_action` VALUES (40, 1, 'Admin', 1591841001, '[]', 'system.Index/getadminmenulist');
INSERT INTO `lee_admin_user_action` VALUES (41, 1, 'Admin', 1591841001, '[]', 'system.Index/console');
INSERT INTO `lee_admin_user_action` VALUES (42, 1, 'Admin', 1591843795, '{\"username\":\"admin\",\"password\":\"123456\"}', 'system.Publicer/adminloginsubmit');
INSERT INTO `lee_admin_user_action` VALUES (43, 1, 'Admin', 1591843796, '[]', 'system.Index/index');
INSERT INTO `lee_admin_user_action` VALUES (44, 1, 'Admin', 1591843796, '[]', 'system.Index/getadminmenulist');
INSERT INTO `lee_admin_user_action` VALUES (45, 1, 'Admin', 1591843797, '[]', 'system.Index/console');
INSERT INTO `lee_admin_user_action` VALUES (46, 1, 'Admin', 1591843800, '[]', 'system.Menu/index');
INSERT INTO `lee_admin_user_action` VALUES (47, 1, 'Admin', 1591843800, '[]', 'system.Menu/index');
INSERT INTO `lee_admin_user_action` VALUES (48, 1, 'Admin', 1591843833, '[]', 'system.Menu/add');
INSERT INTO `lee_admin_user_action` VALUES (49, 1, 'Admin', 1591843900, '{\"pid\":\"0\",\"title\":\"\\u5fae\\u4fe1\\u7ba1\\u7406\",\"src\":\"\",\"is_menu\":\"1\",\"icon\":\"fa fa-weixin\"}', 'system.Menu/add');
INSERT INTO `lee_admin_user_action` VALUES (50, 1, 'Admin', 1591843902, '[]', 'system.Menu/index');
INSERT INTO `lee_admin_user_action` VALUES (51, 1, 'Admin', 1591843902, '[]', 'system.Menu/index');
INSERT INTO `lee_admin_user_action` VALUES (52, 1, 'Admin', 1591843904, '[]', 'system.Menu/add');
INSERT INTO `lee_admin_user_action` VALUES (53, 1, 'Admin', 1591843917, '{\"pid\":\"154\",\"title\":\"\\u7528\\u6237\\u7ba1\\u7406\",\"src\":\"\",\"is_menu\":\"1\",\"icon\":\"\"}', 'system.Menu/add');
INSERT INTO `lee_admin_user_action` VALUES (54, 1, 'Admin', 1591843919, '[]', 'system.Menu/index');
INSERT INTO `lee_admin_user_action` VALUES (55, 1, 'Admin', 1591843919, '[]', 'system.Menu/index');
INSERT INTO `lee_admin_user_action` VALUES (56, 1, 'Admin', 1591844009, '[]', 'system.Menu/index');
INSERT INTO `lee_admin_user_action` VALUES (57, 1, 'Admin', 1591844009, '[]', 'system.Menu/index');
INSERT INTO `lee_admin_user_action` VALUES (58, 1, 'Admin', 1591844010, '[]', 'system.Index/cacheclear');
INSERT INTO `lee_admin_user_action` VALUES (59, 1, 'Admin', 1591844011, '[]', 'system.Index/index');
INSERT INTO `lee_admin_user_action` VALUES (60, 1, 'Admin', 1591844011, '[]', 'system.Index/getadminmenulist');
INSERT INTO `lee_admin_user_action` VALUES (61, 1, 'Admin', 1591844012, '[]', 'system.Menu/index');
INSERT INTO `lee_admin_user_action` VALUES (62, 1, 'Admin', 1591844012, '[]', 'system.Index/console');
INSERT INTO `lee_admin_user_action` VALUES (63, 1, 'Admin', 1591844012, '[]', 'system.Menu/index');
INSERT INTO `lee_admin_user_action` VALUES (64, 1, 'Admin', 1591844016, '[]', 'system.Usert/index');
INSERT INTO `lee_admin_user_action` VALUES (65, 1, 'Admin', 1591844038, '[]', 'system.Index/cacheclear');
INSERT INTO `lee_admin_user_action` VALUES (66, 1, 'Admin', 1591844041, '[]', 'system.Index/index');
INSERT INTO `lee_admin_user_action` VALUES (67, 1, 'Admin', 1591844041, '[]', 'system.Index/getadminmenulist');
INSERT INTO `lee_admin_user_action` VALUES (68, 1, 'Admin', 1591844041, '[]', 'system.Index/console');
INSERT INTO `lee_admin_user_action` VALUES (69, 1, 'Admin', 1591844041, '[]', 'system.Menu/index');
INSERT INTO `lee_admin_user_action` VALUES (70, 1, 'Admin', 1591844041, '[]', 'system.Menu/index');
INSERT INTO `lee_admin_user_action` VALUES (71, 1, 'Admin', 1591844044, '[]', 'system.User/index');
INSERT INTO `lee_admin_user_action` VALUES (72, 1, 'Admin', 1591844045, '{\"page\":\"1\",\"limit\":\"10\"}', 'system.User/index');
INSERT INTO `lee_admin_user_action` VALUES (73, 1, 'Admin', 1591844148, '[]', 'system.Index/index');
INSERT INTO `lee_admin_user_action` VALUES (74, 1, 'Admin', 1591844148, '[]', 'system.Index/getadminmenulist');
INSERT INTO `lee_admin_user_action` VALUES (75, 1, 'Admin', 1591844148, '[]', 'system.Index/console');
INSERT INTO `lee_admin_user_action` VALUES (76, 1, 'Admin', 1591844148, '[]', 'system.User/index');
INSERT INTO `lee_admin_user_action` VALUES (77, 1, 'Admin', 1591844149, '{\"page\":\"1\",\"limit\":\"10\"}', 'system.User/index');
INSERT INTO `lee_admin_user_action` VALUES (78, 1, 'Admin', 1591844149, '[]', 'system.User/{{d.avatar} }}');
INSERT INTO `lee_admin_user_action` VALUES (79, 1, 'Admin', 1591844197, '[]', 'system.User/index');
INSERT INTO `lee_admin_user_action` VALUES (80, 1, 'Admin', 1591844197, '{\"page\":\"1\",\"limit\":\"10\"}', 'system.User/index');
INSERT INTO `lee_admin_user_action` VALUES (81, 1, 'Admin', 1591844312, '[]', 'system.User/index');
INSERT INTO `lee_admin_user_action` VALUES (82, 1, 'Admin', 1591844312, '{\"page\":\"1\",\"limit\":\"10\"}', 'system.User/index');
INSERT INTO `lee_admin_user_action` VALUES (83, 1, 'Admin', 1591844344, '[]', 'system.User/index');
INSERT INTO `lee_admin_user_action` VALUES (84, 1, 'Admin', 1591844345, '{\"page\":\"1\",\"limit\":\"10\"}', 'system.User/index');
INSERT INTO `lee_admin_user_action` VALUES (85, 1, 'Admin', 1591844364, '[]', 'system.User/index');
INSERT INTO `lee_admin_user_action` VALUES (86, 1, 'Admin', 1591844364, '{\"page\":\"1\",\"limit\":\"10\"}', 'system.User/index');
INSERT INTO `lee_admin_user_action` VALUES (87, 1, 'Admin', 1591844381, '[]', 'system.User/index');
INSERT INTO `lee_admin_user_action` VALUES (88, 1, 'Admin', 1591844381, '{\"page\":\"1\",\"limit\":\"10\"}', 'system.User/index');
INSERT INTO `lee_admin_user_action` VALUES (89, 1, 'Admin', 1591844390, '{\"page\":\"1\",\"limit\":\"10\",\"keywords\":\"List\"}', 'system.User/index');
INSERT INTO `lee_admin_user_action` VALUES (90, 1, 'Admin', 1591844392, '{\"page\":\"1\",\"limit\":\"10\",\"keywords\":\"List111\"}', 'system.User/index');
INSERT INTO `lee_admin_user_action` VALUES (91, 1, 'Admin', 1591844414, '[]', 'system.User/index');
INSERT INTO `lee_admin_user_action` VALUES (92, 1, 'Admin', 1591844414, '{\"page\":\"1\",\"limit\":\"10\"}', 'system.User/index');
INSERT INTO `lee_admin_user_action` VALUES (93, 1, 'Admin', 1591844564, '[]', 'system.User/index');
INSERT INTO `lee_admin_user_action` VALUES (94, 1, 'Admin', 1591844564, '{\"page\":\"1\",\"limit\":\"10\"}', 'system.User/index');
INSERT INTO `lee_admin_user_action` VALUES (95, 1, 'Admin', 1591844573, '[]', 'system.Index/index');
INSERT INTO `lee_admin_user_action` VALUES (96, 1, 'Admin', 1591844573, '[]', 'system.Index/getadminmenulist');
INSERT INTO `lee_admin_user_action` VALUES (97, 1, 'Admin', 1591844573, '[]', 'system.Index/console');
INSERT INTO `lee_admin_user_action` VALUES (98, 1, 'Admin', 1591844573, '[]', 'system.User/index');
INSERT INTO `lee_admin_user_action` VALUES (99, 1, 'Admin', 1591844574, '{\"page\":\"1\",\"limit\":\"10\"}', 'system.User/index');
INSERT INTO `lee_admin_user_action` VALUES (100, 1, 'Admin', 1591844577, '[]', 'system.Nav/index');
INSERT INTO `lee_admin_user_action` VALUES (101, 1, 'Admin', 1591844577, '{\"page\":\"1\",\"limit\":\"10\"}', 'system.Nav/index');
INSERT INTO `lee_admin_user_action` VALUES (102, 1, 'Admin', 1591844579, '[]', 'system.Slide/index');
INSERT INTO `lee_admin_user_action` VALUES (103, 1, 'Admin', 1591844579, '{\"page\":\"1\",\"limit\":\"10\"}', 'system.Slide/index');
INSERT INTO `lee_admin_user_action` VALUES (104, 1, 'Admin', 1591844580, '[]', 'system.Cate/index');
INSERT INTO `lee_admin_user_action` VALUES (105, 1, 'Admin', 1591844580, '{\"page\":\"1\",\"limit\":\"10\"}', 'system.Cate/index');
INSERT INTO `lee_admin_user_action` VALUES (106, 1, 'Admin', 1591844581, '[]', 'system.Content/index');
INSERT INTO `lee_admin_user_action` VALUES (107, 1, 'Admin', 1591844581, '{\"page\":\"1\",\"limit\":\"10\"}', 'system.Content/index');
INSERT INTO `lee_admin_user_action` VALUES (108, 1, 'Admin', 1591844583, '[]', 'system.Content/addgroup');
INSERT INTO `lee_admin_user_action` VALUES (109, 1, 'Admin', 1591844586, '{\"page\":\"1\",\"limit\":\"10\"}', 'system.Content/index');
INSERT INTO `lee_admin_user_action` VALUES (110, 1, 'Admin', 1591844588, '[]', 'system.Slide/addgroup');
INSERT INTO `lee_admin_user_action` VALUES (111, 1, 'Admin', 1591844592, '{\"page\":\"1\",\"limit\":\"10\"}', 'system.Slide/index');
INSERT INTO `lee_admin_user_action` VALUES (112, 1, 'Admin', 1591844597, '[]', 'system.Nav/index');
INSERT INTO `lee_admin_user_action` VALUES (113, 1, 'Admin', 1591844597, '{\"page\":\"1\",\"limit\":\"10\"}', 'system.Nav/index');
INSERT INTO `lee_admin_user_action` VALUES (114, 1, 'Admin', 1591844601, '[]', 'system.Index/index');
INSERT INTO `lee_admin_user_action` VALUES (115, 1, 'Admin', 1591844602, '[]', 'system.Index/getadminmenulist');
INSERT INTO `lee_admin_user_action` VALUES (116, 1, 'Admin', 1591844602, '[]', 'system.Index/console');
INSERT INTO `lee_admin_user_action` VALUES (117, 1, 'Admin', 1591844602, '[]', 'system.Nav/index');
INSERT INTO `lee_admin_user_action` VALUES (118, 1, 'Admin', 1591844602, '{\"page\":\"1\",\"limit\":\"10\"}', 'system.Nav/index');
INSERT INTO `lee_admin_user_action` VALUES (119, 1, 'Admin', 1591844612, '[]', 'system.Admin/index');
INSERT INTO `lee_admin_user_action` VALUES (120, 1, 'Admin', 1591844613, '{\"page\":\"1\",\"limit\":\"10\"}', 'system.Admin/index');
INSERT INTO `lee_admin_user_action` VALUES (121, 1, 'Admin', 1591844618, '[]', 'system.Group/index');
INSERT INTO `lee_admin_user_action` VALUES (122, 1, 'Admin', 1591844618, '{\"page\":\"1\",\"limit\":\"15\"}', 'system.Group/index');
INSERT INTO `lee_admin_user_action` VALUES (123, 1, 'Admin', 1591844622, '[]', 'system.Slide/index');
INSERT INTO `lee_admin_user_action` VALUES (124, 1, 'Admin', 1591844623, '{\"page\":\"1\",\"limit\":\"10\"}', 'system.Slide/index');
INSERT INTO `lee_admin_user_action` VALUES (125, 1, 'Admin', 1591844626, '[]', 'system.Nav/index');
INSERT INTO `lee_admin_user_action` VALUES (126, 1, 'Admin', 1591844626, '{\"page\":\"1\",\"limit\":\"10\"}', 'system.Nav/index');
INSERT INTO `lee_admin_user_action` VALUES (127, 1, 'Admin', 1591844632, '[]', 'system.Menu/index');
INSERT INTO `lee_admin_user_action` VALUES (128, 1, 'Admin', 1591844632, '[]', 'system.Menu/index');
INSERT INTO `lee_admin_user_action` VALUES (129, 1, 'Admin', 1591844677, '[]', 'system.Menu/index');
INSERT INTO `lee_admin_user_action` VALUES (130, 1, 'Admin', 1591844677, '[]', 'system.Menu/index');
INSERT INTO `lee_admin_user_action` VALUES (131, 1, 'Admin', 1591844694, '[]', 'system.Menu/index');
INSERT INTO `lee_admin_user_action` VALUES (132, 1, 'Admin', 1591844694, '[]', 'system.Menu/index');
INSERT INTO `lee_admin_user_action` VALUES (133, 1, 'Admin', 1591844753, '[]', 'system.Index/index');
INSERT INTO `lee_admin_user_action` VALUES (134, 1, 'Admin', 1591844753, '[]', 'system.Index/getadminmenulist');
INSERT INTO `lee_admin_user_action` VALUES (135, 1, 'Admin', 1591844753, '[]', 'system.Index/console');
INSERT INTO `lee_admin_user_action` VALUES (136, 1, 'Admin', 1591844753, '[]', 'system.Menu/index');
INSERT INTO `lee_admin_user_action` VALUES (137, 1, 'Admin', 1591844753, '[]', 'system.Menu/index');
INSERT INTO `lee_admin_user_action` VALUES (138, 1, 'Admin', 1591844766, '[]', 'system.Conf/index');
INSERT INTO `lee_admin_user_action` VALUES (139, 1, 'Admin', 1591844767, '[]', 'system.Route/index');
INSERT INTO `lee_admin_user_action` VALUES (140, 1, 'Admin', 1591844767, '{\"page\":\"1\",\"limit\":\"15\"}', 'system.Route/index');
INSERT INTO `lee_admin_user_action` VALUES (141, 1, 'Admin', 1591844811, '[]', 'system.Index/index');
INSERT INTO `lee_admin_user_action` VALUES (142, 1, 'Admin', 1591844812, '[]', 'system.Index/getadminmenulist');
INSERT INTO `lee_admin_user_action` VALUES (143, 1, 'Admin', 1591844812, '[]', 'system.Index/console');
INSERT INTO `lee_admin_user_action` VALUES (144, 1, 'Admin', 1591844812, '[]', 'system.Route/index');
INSERT INTO `lee_admin_user_action` VALUES (145, 1, 'Admin', 1591844812, '{\"page\":\"1\",\"limit\":\"15\"}', 'system.Route/index');
INSERT INTO `lee_admin_user_action` VALUES (146, 1, 'Admin', 1591844821, '[]', 'system.AdminUserAction/index');
INSERT INTO `lee_admin_user_action` VALUES (147, 1, 'Admin', 1591844821, '{\"page\":\"1\",\"limit\":\"10\"}', 'system.AdminUserAction/index');
INSERT INTO `lee_admin_user_action` VALUES (148, 1, 'Admin', 1591844824, '[]', 'system.Conf/index');
INSERT INTO `lee_admin_user_action` VALUES (149, 1, 'Admin', 1591844826, '[]', 'system.Menu/index');
INSERT INTO `lee_admin_user_action` VALUES (150, 1, 'Admin', 1591844826, '[]', 'system.Menu/index');
INSERT INTO `lee_admin_user_action` VALUES (151, 1, 'Admin', 1591844854, '[]', 'system.AdminUserAction/index');
INSERT INTO `lee_admin_user_action` VALUES (152, 1, 'Admin', 1591844855, '{\"page\":\"1\",\"limit\":\"10\"}', 'system.AdminUserAction/index');
INSERT INTO `lee_admin_user_action` VALUES (153, 1, 'Admin', 1591844914, '[]', 'system.Index/index');
INSERT INTO `lee_admin_user_action` VALUES (154, 1, 'Admin', 1591844915, '[]', 'system.Index/getadminmenulist');
INSERT INTO `lee_admin_user_action` VALUES (155, 1, 'Admin', 1591844915, '[]', 'system.Index/console');
INSERT INTO `lee_admin_user_action` VALUES (156, 1, 'Admin', 1591844915, '[]', 'system.AdminUserAction/index');
INSERT INTO `lee_admin_user_action` VALUES (157, 1, 'Admin', 1591844915, '{\"page\":\"1\",\"limit\":\"10\"}', 'system.AdminUserAction/index');
INSERT INTO `lee_admin_user_action` VALUES (158, 1, 'Admin', 1591844931, '[]', 'system.Index/index');
INSERT INTO `lee_admin_user_action` VALUES (159, 1, 'Admin', 1591844932, '[]', 'system.Index/getadminmenulist');
INSERT INTO `lee_admin_user_action` VALUES (160, 1, 'Admin', 1591844932, '[]', 'system.Index/console');
INSERT INTO `lee_admin_user_action` VALUES (161, 1, 'Admin', 1591844932, '[]', 'system.AdminUserAction/index');
INSERT INTO `lee_admin_user_action` VALUES (162, 1, 'Admin', 1591844933, '{\"page\":\"1\",\"limit\":\"10\"}', 'system.AdminUserAction/index');
INSERT INTO `lee_admin_user_action` VALUES (163, 1, 'Admin', 1591844956, '[]', 'system.AdminUserAction/index');
INSERT INTO `lee_admin_user_action` VALUES (164, 1, 'Admin', 1591844957, '{\"page\":\"1\",\"limit\":\"10\"}', 'system.AdminUserAction/index');
INSERT INTO `lee_admin_user_action` VALUES (165, 1, 'Admin', 1591844958, '[]', 'system.Route/index');
INSERT INTO `lee_admin_user_action` VALUES (166, 1, 'Admin', 1591844958, '{\"page\":\"1\",\"limit\":\"15\"}', 'system.Route/index');
INSERT INTO `lee_admin_user_action` VALUES (167, 1, 'Admin', 1591844961, '[]', 'system.Conf/index');
INSERT INTO `lee_admin_user_action` VALUES (168, 1, 'Admin', 1591844962, '[]', 'system.Menu/index');
INSERT INTO `lee_admin_user_action` VALUES (169, 1, 'Admin', 1591844962, '[]', 'system.Menu/index');
INSERT INTO `lee_admin_user_action` VALUES (170, 1, 'Admin', 1591844967, '[]', 'system.Admin/index');
INSERT INTO `lee_admin_user_action` VALUES (171, 1, 'Admin', 1591844968, '{\"page\":\"1\",\"limit\":\"10\"}', 'system.Admin/index');
INSERT INTO `lee_admin_user_action` VALUES (172, 1, 'Admin', 1591845133, '[]', 'system.Group/index');
INSERT INTO `lee_admin_user_action` VALUES (173, 1, 'Admin', 1591845134, '{\"page\":\"1\",\"limit\":\"15\"}', 'system.Group/index');
INSERT INTO `lee_admin_user_action` VALUES (174, 1, 'Admin', 1591845137, '[]', 'system.Admin/index');
INSERT INTO `lee_admin_user_action` VALUES (175, 1, 'Admin', 1591845138, '{\"page\":\"1\",\"limit\":\"10\"}', 'system.Admin/index');
INSERT INTO `lee_admin_user_action` VALUES (176, 1, 'Admin', 1591845147, '[]', 'system.Nav/index');
INSERT INTO `lee_admin_user_action` VALUES (177, 1, 'Admin', 1591845147, '{\"page\":\"1\",\"limit\":\"10\"}', 'system.Nav/index');
INSERT INTO `lee_admin_user_action` VALUES (178, 1, 'Admin', 1591845149, '[]', 'system.Nav/index');
INSERT INTO `lee_admin_user_action` VALUES (179, 1, 'Admin', 1591845150, '{\"page\":\"1\",\"limit\":\"10\"}', 'system.Nav/index');
INSERT INTO `lee_admin_user_action` VALUES (180, 1, 'Admin', 1591845152, '[]', 'system.Slide/index');
INSERT INTO `lee_admin_user_action` VALUES (181, 1, 'Admin', 1591845153, '{\"page\":\"1\",\"limit\":\"10\"}', 'system.Slide/index');
INSERT INTO `lee_admin_user_action` VALUES (182, 1, 'Admin', 1591845154, '[]', 'system.Slide/index');
INSERT INTO `lee_admin_user_action` VALUES (183, 1, 'Admin', 1591845154, '{\"page\":\"1\",\"limit\":\"10\"}', 'system.Slide/index');
INSERT INTO `lee_admin_user_action` VALUES (184, 1, 'Admin', 1591845155, '[]', 'system.Cate/index');
INSERT INTO `lee_admin_user_action` VALUES (185, 1, 'Admin', 1591845155, '{\"page\":\"1\",\"limit\":\"10\"}', 'system.Cate/index');
INSERT INTO `lee_admin_user_action` VALUES (186, 1, 'Admin', 1591845157, '[]', 'system.Content/index');
INSERT INTO `lee_admin_user_action` VALUES (187, 1, 'Admin', 1591845157, '{\"page\":\"1\",\"limit\":\"10\"}', 'system.Content/index');
INSERT INTO `lee_admin_user_action` VALUES (188, 1, 'Admin', 1591845274, '[]', 'system.Index/index');
INSERT INTO `lee_admin_user_action` VALUES (189, 1, 'Admin', 1591845275, '[]', 'system.Index/getadminmenulist');
INSERT INTO `lee_admin_user_action` VALUES (190, 1, 'Admin', 1591845275, '[]', 'system.Index/console');
INSERT INTO `lee_admin_user_action` VALUES (191, 1, 'Admin', 1591845275, '[]', 'system.Nav/index');
INSERT INTO `lee_admin_user_action` VALUES (192, 1, 'Admin', 1591845276, '{\"page\":\"1\",\"limit\":\"10\"}', 'system.Nav/index');
INSERT INTO `lee_admin_user_action` VALUES (193, 1, 'Admin', 1591845279, '[]', 'system.Slide/index');
INSERT INTO `lee_admin_user_action` VALUES (194, 1, 'Admin', 1591845279, '{\"page\":\"1\",\"limit\":\"10\"}', 'system.Slide/index');
INSERT INTO `lee_admin_user_action` VALUES (195, 1, 'Admin', 1591845280, '[]', 'system.Cate/index');
INSERT INTO `lee_admin_user_action` VALUES (196, 1, 'Admin', 1591845281, '{\"page\":\"1\",\"limit\":\"10\"}', 'system.Cate/index');
INSERT INTO `lee_admin_user_action` VALUES (197, 1, 'Admin', 1591845357, '[]', 'system.Index/index');
INSERT INTO `lee_admin_user_action` VALUES (198, 1, 'Admin', 1591845357, '[]', 'system.Index/getadminmenulist');
INSERT INTO `lee_admin_user_action` VALUES (199, 1, 'Admin', 1591845357, '[]', 'system.Index/console');
INSERT INTO `lee_admin_user_action` VALUES (200, 1, 'Admin', 1591845357, '[]', 'system.Cate/index');
INSERT INTO `lee_admin_user_action` VALUES (201, 1, 'Admin', 1591845358, '{\"page\":\"1\",\"limit\":\"10\"}', 'system.Cate/index');
INSERT INTO `lee_admin_user_action` VALUES (202, 1, 'Admin', 1591845390, '[]', 'system.Index/index');
INSERT INTO `lee_admin_user_action` VALUES (203, 1, 'Admin', 1591845391, '[]', 'system.Index/getadminmenulist');
INSERT INTO `lee_admin_user_action` VALUES (204, 1, 'Admin', 1591845391, '[]', 'system.Index/console');
INSERT INTO `lee_admin_user_action` VALUES (205, 1, 'Admin', 1591845391, '[]', 'system.Cate/index');
INSERT INTO `lee_admin_user_action` VALUES (206, 1, 'Admin', 1591845391, '{\"page\":\"1\",\"limit\":\"10\"}', 'system.Cate/index');
INSERT INTO `lee_admin_user_action` VALUES (207, 1, 'Admin', 1591845397, '[]', 'system.User/index');
INSERT INTO `lee_admin_user_action` VALUES (208, 1, 'Admin', 1591845397, '{\"page\":\"1\",\"limit\":\"10\"}', 'system.User/index');
INSERT INTO `lee_admin_user_action` VALUES (209, 1, 'Admin', 1591845403, '[]', 'system.Menu/index');
INSERT INTO `lee_admin_user_action` VALUES (210, 1, 'Admin', 1591845404, '[]', 'system.Menu/index');
INSERT INTO `lee_admin_user_action` VALUES (211, 1, 'Admin', 1591845404, '[]', 'system.Conf/index');
INSERT INTO `lee_admin_user_action` VALUES (212, 1, 'Admin', 1591845404, '[]', 'system.Route/index');
INSERT INTO `lee_admin_user_action` VALUES (213, 1, 'Admin', 1591845405, '{\"page\":\"1\",\"limit\":\"15\"}', 'system.Route/index');
INSERT INTO `lee_admin_user_action` VALUES (214, 1, 'Admin', 1591845406, '[]', 'system.AdminUserAction/index');
INSERT INTO `lee_admin_user_action` VALUES (215, 1, 'Admin', 1591845406, '{\"page\":\"1\",\"limit\":\"10\"}', 'system.AdminUserAction/index');
INSERT INTO `lee_admin_user_action` VALUES (216, 1, 'Admin', 1591845407, '[]', 'system.Admin/index');
INSERT INTO `lee_admin_user_action` VALUES (217, 1, 'Admin', 1591845407, '{\"page\":\"1\",\"limit\":\"10\"}', 'system.Admin/index');
INSERT INTO `lee_admin_user_action` VALUES (218, 1, 'Admin', 1591845408, '[]', 'system.Group/index');
INSERT INTO `lee_admin_user_action` VALUES (219, 1, 'Admin', 1591845408, '{\"page\":\"1\",\"limit\":\"15\"}', 'system.Group/index');
INSERT INTO `lee_admin_user_action` VALUES (220, 1, 'Admin', 1591845419, '[]', 'system.Group/add');
INSERT INTO `lee_admin_user_action` VALUES (221, 1, 'Admin', 1591845419, '[]', 'system.Index/getrulelist');
INSERT INTO `lee_admin_user_action` VALUES (222, 1, 'Admin', 1591845426, '{\"page\":\"1\",\"limit\":\"15\"}', 'system.Group/index');
INSERT INTO `lee_admin_user_action` VALUES (223, 1, 'Admin', 1591845433, '{\"id\":\"1\"}', 'system.Group/edit');
INSERT INTO `lee_admin_user_action` VALUES (224, 1, 'Admin', 1591845434, '[]', 'system.Index/getrulelist');
INSERT INTO `lee_admin_user_action` VALUES (225, 1, 'Admin', 1591845447, '{\"page\":\"1\",\"limit\":\"15\"}', 'system.Group/index');
INSERT INTO `lee_admin_user_action` VALUES (226, 1, 'Admin', 1608879297, '{\"username\":\"admin\",\"password\":\"123456\"}', 'system.Publicer/adminloginsubmit');
INSERT INTO `lee_admin_user_action` VALUES (227, 1, 'Admin', 1608879299, '[]', 'system.Index/index');
INSERT INTO `lee_admin_user_action` VALUES (228, 1, 'Admin', 1608879814, '[]', 'system.Index/getadminmenulist');
INSERT INTO `lee_admin_user_action` VALUES (229, 1, 'Admin', 1608880099, '[]', 'system.Index/getadminmenulist');
INSERT INTO `lee_admin_user_action` VALUES (230, 1, 'Admin', 1608880388, '[]', 'system.Publicer/adminlogin');
INSERT INTO `lee_admin_user_action` VALUES (231, 1, 'Admin', 1608880388, '[]', 'system.Index/index');
INSERT INTO `lee_admin_user_action` VALUES (232, 1, 'Admin', 1608880394, '[]', 'system.Index/index');
INSERT INTO `lee_admin_user_action` VALUES (233, 1, 'Admin', 1608880639, '[]', 'system.Publicer/adminlogin');
INSERT INTO `lee_admin_user_action` VALUES (234, 1, 'Admin', 1608880639, '[]', 'system.Index/index');
INSERT INTO `lee_admin_user_action` VALUES (235, 1, 'Admin', 1608880694, '[]', 'system.Publicer/adminlogin');
INSERT INTO `lee_admin_user_action` VALUES (236, 1, 'Admin', 1608880694, '[]', 'system.Index/index');
INSERT INTO `lee_admin_user_action` VALUES (237, 1, 'Admin', 1608880701, '[]', 'system.Index/index');
INSERT INTO `lee_admin_user_action` VALUES (238, 1, 'Admin', 1608881025, '[]', 'system.Index/getadminmenulist');
INSERT INTO `lee_admin_user_action` VALUES (239, 1, 'Admin', 1608881193, '{\"username\":\"admin\",\"password\":\"123456\"}', 'system.Publicer/adminloginsubmit');
INSERT INTO `lee_admin_user_action` VALUES (240, 1, 'Admin', 1608881195, '[]', 'system.Index/index');
INSERT INTO `lee_admin_user_action` VALUES (241, 1, 'Admin', 1608881200, '[]', 'system.Index/index');
INSERT INTO `lee_admin_user_action` VALUES (242, 1, 'Admin', 1608881242, '[]', 'system.Index/index');
INSERT INTO `lee_admin_user_action` VALUES (243, 1, 'Admin', 1608881242, '[]', 'system.Index/getadminmenulist');
INSERT INTO `lee_admin_user_action` VALUES (244, 1, 'Admin', 1608881242, '[]', 'system.Index/console');
INSERT INTO `lee_admin_user_action` VALUES (245, 1, 'Admin', 1608881254, '[]', 'system.User/index');
INSERT INTO `lee_admin_user_action` VALUES (246, 1, 'Admin', 1608881254, '{\"page\":\"1\",\"limit\":\"10\"}', 'system.User/index');
INSERT INTO `lee_admin_user_action` VALUES (247, 1, 'Admin', 1608881269, '[]', 'system.Admin/index');
INSERT INTO `lee_admin_user_action` VALUES (248, 1, 'Admin', 1608881269, '{\"page\":\"1\",\"limit\":\"10\"}', 'system.Admin/index');
INSERT INTO `lee_admin_user_action` VALUES (249, 1, 'Admin', 1608881272, '{\"id\":\"2\"}', 'system.Admin/edit');
INSERT INTO `lee_admin_user_action` VALUES (250, 1, 'Admin', 1608881279, '{\"password\":\"111111\",\"password_confirm\":\"111111\",\"nickname\":\"test\",\"file\":\"\",\"thumb\":\"\\/storage\\/topic\\/20200610\\\\cfefb2d076cea3c11cb0a30ae8b779de.jpg\",\"group_id\":[\"1\"],\"desc\":\"\",\"status\":\"1\",\"id\":\"2\"}', 'system.Admin/edit');
INSERT INTO `lee_admin_user_action` VALUES (251, 1, 'Admin', 1608881280, '{\"page\":\"1\",\"limit\":\"10\"}', 'system.Admin/index');
INSERT INTO `lee_admin_user_action` VALUES (252, 2, 'test', 1608881302, '{\"username\":\"test\",\"password\":\"111111\"}', 'system.Publicer/adminloginsubmit');
INSERT INTO `lee_admin_user_action` VALUES (253, 2, 'test', 1608881359, '{\"username\":\"admin\",\"password\":\"123456\"}', 'system.Publicer/adminloginsubmit');
INSERT INTO `lee_admin_user_action` VALUES (254, 2, 'test', 1608881362, '{\"username\":\"admin\",\"password\":\"123456\"}', 'system.Publicer/adminloginsubmit');
INSERT INTO `lee_admin_user_action` VALUES (255, 2, 'test', 1608881363, '[]', 'system.Publicer/adminlogin');
INSERT INTO `lee_admin_user_action` VALUES (256, 1, 'Admin', 1608881466, '{\"username\":\"admin\",\"password\":\"123456\"}', 'system.Publicer/adminloginsubmit');
INSERT INTO `lee_admin_user_action` VALUES (257, 1, 'Admin', 1608881468, '[]', 'system.Index/index');
INSERT INTO `lee_admin_user_action` VALUES (258, 1, 'Admin', 1608881468, '[]', 'system.Index/getadminmenulist');
INSERT INTO `lee_admin_user_action` VALUES (259, 1, 'Admin', 1608881468, '[]', 'system.Index/console');
INSERT INTO `lee_admin_user_action` VALUES (260, 2, 'test', 1608881490, '{\"username\":\"test\",\"password\":\"111111\"}', 'system.Publicer/adminloginsubmit');
INSERT INTO `lee_admin_user_action` VALUES (261, 2, 'test', 1608881597, '{\"username\":\"admin\",\"password\":\"123456\"}', 'system.Publicer/adminloginsubmit');
INSERT INTO `lee_admin_user_action` VALUES (262, 2, 'test', 1608881599, '[]', 'system.Publicer/adminlogin');
INSERT INTO `lee_admin_user_action` VALUES (263, 1, 'Admin', 1608881657, '{\"username\":\"admin\",\"password\":\"123456\"}', 'system.Publicer/adminloginsubmit');
INSERT INTO `lee_admin_user_action` VALUES (264, 1, 'Admin', 1608881658, '[]', 'system.Index/index');
INSERT INTO `lee_admin_user_action` VALUES (265, 1, 'Admin', 1608881658, '[]', 'system.Index/getadminmenulist');
INSERT INTO `lee_admin_user_action` VALUES (266, 1, 'Admin', 1608881659, '[]', 'system.Index/console');
INSERT INTO `lee_admin_user_action` VALUES (267, 1, 'Admin', 1608881663, '[]', 'system.Admin/index');
INSERT INTO `lee_admin_user_action` VALUES (268, 1, 'Admin', 1608881663, '{\"page\":\"1\",\"limit\":\"10\"}', 'system.Admin/index');
INSERT INTO `lee_admin_user_action` VALUES (269, 1, 'Admin', 1608881665, '{\"id\":\"2\"}', 'system.Admin/edit');
INSERT INTO `lee_admin_user_action` VALUES (270, 1, 'Admin', 1608881669, '{\"password\":\"\",\"password_confirm\":\"\",\"nickname\":\"test\",\"file\":\"\",\"thumb\":\"\\/storage\\/topic\\/20200610\\\\cfefb2d076cea3c11cb0a30ae8b779de.jpg\",\"group_id\":[\"1\"],\"desc\":\"\",\"status\":\"1\",\"id\":\"2\"}', 'system.Admin/edit');
INSERT INTO `lee_admin_user_action` VALUES (271, 1, 'Admin', 1608881671, '{\"page\":\"1\",\"limit\":\"10\"}', 'system.Admin/index');
INSERT INTO `lee_admin_user_action` VALUES (272, 2, 'test', 1608881782, '{\"username\":\"test\",\"password\":\"111111\"}', 'system.Publicer/adminloginsubmit');
INSERT INTO `lee_admin_user_action` VALUES (273, 1, 'Admin', 1608882143, '{\"username\":\"admin\",\"password\":\"123456\"}', 'system.Publicer/adminloginsubmit');
INSERT INTO `lee_admin_user_action` VALUES (274, 1, 'Admin', 1608882145, '[]', 'system.Index/index');
INSERT INTO `lee_admin_user_action` VALUES (275, 1, 'Admin', 1608882145, '[]', 'system.Index/getadminmenulist');
INSERT INTO `lee_admin_user_action` VALUES (276, 1, 'Admin', 1608882145, '[]', 'system.Index/console');
INSERT INTO `lee_admin_user_action` VALUES (277, 1, 'Admin', 1608882150, '[]', 'system.Menu/index');
INSERT INTO `lee_admin_user_action` VALUES (278, 1, 'Admin', 1608882150, '[]', 'system.Menu/index');
INSERT INTO `lee_admin_user_action` VALUES (279, 1, 'Admin', 1608882152, '[]', 'system.Menu/add');
INSERT INTO `lee_admin_user_action` VALUES (280, 1, 'Admin', 1608882165, '{\"pid\":\"0\",\"title\":\"\\u9996\\u9875\",\"src\":\"system.index\\/index\",\"icon\":\"\"}', 'system.Menu/add');
INSERT INTO `lee_admin_user_action` VALUES (281, 1, 'Admin', 1608882167, '[]', 'system.Menu/index');
INSERT INTO `lee_admin_user_action` VALUES (282, 1, 'Admin', 1608882167, '[]', 'system.Menu/index');
INSERT INTO `lee_admin_user_action` VALUES (283, 1, 'Admin', 1608882172, '[]', 'system.Admin/index');
INSERT INTO `lee_admin_user_action` VALUES (284, 1, 'Admin', 1608882172, '{\"page\":\"1\",\"limit\":\"10\"}', 'system.Admin/index');
INSERT INTO `lee_admin_user_action` VALUES (285, 1, 'Admin', 1608882173, '[]', 'system.Group/index');
INSERT INTO `lee_admin_user_action` VALUES (286, 1, 'Admin', 1608882173, '{\"page\":\"1\",\"limit\":\"15\"}', 'system.Group/index');
INSERT INTO `lee_admin_user_action` VALUES (287, 1, 'Admin', 1608882174, '{\"id\":\"1\"}', 'system.Group/edit');
INSERT INTO `lee_admin_user_action` VALUES (288, 1, 'Admin', 1608882174, '[]', 'system.Index/getrulelist');
INSERT INTO `lee_admin_user_action` VALUES (289, 1, 'Admin', 1608882177, '{\"title\":\"\\u8d85\\u7ea7\\u7ba1\\u7406\\u5458\",\"layuiTreeCheck_1\":\"1\",\"layuiTreeCheck_2\":\"2\",\"layuiTreeCheck_3\":\"3\",\"layuiTreeCheck_4\":\"4\",\"layuiTreeCheck_5\":\"5\",\"layuiTreeCheck_14\":\"14\",\"layuiTreeCheck_6\":\"6\",\"layuiTreeCheck_7\":\"7\",\"layuiTreeCheck_8\":\"8\",\"layuiTreeCheck_9\":\"9\",\"layuiTreeCheck_10\":\"10\",\"layuiTreeCheck_11\":\"11\",\"layuiTreeCheck_12\":\"12\",\"layuiTreeCheck_13\":\"13\",\"layuiTreeCheck_15\":\"15\",\"layuiTreeCheck_16\":\"16\",\"layuiTreeCheck_26\":\"26\",\"layuiTreeCheck_27\":\"27\",\"layuiTreeCheck_28\":\"28\",\"layuiTreeCheck_29\":\"29\",\"layuiTreeCheck_55\":\"55\",\"layuiTreeCheck_17\":\"17\",\"layuiTreeCheck_18\":\"18\",\"layuiTreeCheck_19\":\"19\",\"layuiTreeCheck_20\":\"20\",\"layuiTreeCheck_21\":\"21\",\"layuiTreeCheck_22\":\"22\",\"layuiTreeCheck_23\":\"23\",\"layuiTreeCheck_24\":\"24\",\"layuiTreeCheck_25\":\"25\",\"layuiTreeCheck_31\":\"31\",\"layuiTreeCheck_34\":\"34\",\"layuiTreeCheck_35\":\"35\",\"layuiTreeCheck_36\":\"36\",\"layuiTreeCheck_37\":\"37\",\"layuiTreeCheck_38\":\"38\",\"layuiTreeCheck_39\":\"39\",\"layuiTreeCheck_40\":\"40\",\"layuiTreeCheck_32\":\"32\",\"layuiTreeCheck_41\":\"41\",\"layuiTreeCheck_42\":\"42\",\"layuiTreeCheck_43\":\"43\",\"layuiTreeCheck_44\":\"44\",\"layuiTreeCheck_45\":\"45\",\"layuiTreeCheck_46\":\"46\",\"layuiTreeCheck_47\":\"47\",\"layuiTreeCheck_48\":\"48\",\"layuiTreeCheck_49\":\"49\",\"layuiTreeCheck_50\":\"50\",\"layuiTreeCheck_51\":\"51\",\"layuiTreeCheck_52\":\"52\",\"layuiTreeCheck_53\":\"53\",\"layuiTreeCheck_54\":\"54\",\"layuiTreeCheck_56\":\"56\",\"layuiTreeCheck_57\":\"57\",\"layuiTreeCheck_156\":\"156\",\"desc\":\"\",\"status\":\"1\",\"id\":\"1\",\"rules\":[\"1\",\"2\",\"3\",\"4\",\"5\",\"14\",\"6\",\"7\",\"8\",\"9\",\"10\",\"11\",\"12\",\"13\",\"15\",\"16\",\"26\",\"27\",\"28\",\"29\",\"55\",\"17\",\"18\",\"19\",\"20\",\"21\",\"22\",\"23\",\"24\",\"25\",\"31\",\"34\",\"35\",\"36\",\"37\",\"38\",\"39\",\"40\",\"32\",\"41\",\"42\",\"43\",\"44\",\"45\",\"46\",\"47\",\"48\",\"49\",\"50\",\"51\",\"52\",\"53\",\"54\",\"56\",\"57\",\"156\"]}', 'system.Group/edit');
INSERT INTO `lee_admin_user_action` VALUES (290, 1, 'Admin', 1608882179, '{\"page\":\"1\",\"limit\":\"15\"}', 'system.Group/index');
INSERT INTO `lee_admin_user_action` VALUES (291, 2, 'test', 1608882199, '{\"username\":\"test\",\"password\":\"111111\"}', 'system.Publicer/adminloginsubmit');
INSERT INTO `lee_admin_user_action` VALUES (292, 2, 'test', 1608882201, '[]', 'system.Index/index');
INSERT INTO `lee_admin_user_action` VALUES (293, 2, 'test', 1608882209, '[]', 'system.Index/index');
INSERT INTO `lee_admin_user_action` VALUES (294, 2, 'test', 1608882220, '{\"username\":\"admin\",\"password\":\"123456\"}', 'system.Publicer/adminloginsubmit');
INSERT INTO `lee_admin_user_action` VALUES (295, 2, 'test', 1608882222, '[]', 'system.Publicer/adminlogin');
INSERT INTO `lee_admin_user_action` VALUES (296, 2, 'test', 1608882222, '[]', 'system.Index/index');
INSERT INTO `lee_admin_user_action` VALUES (297, 1, 'Admin', 1608882233, '{\"username\":\"admin\",\"password\":\"123456\"}', 'system.Publicer/adminloginsubmit');
INSERT INTO `lee_admin_user_action` VALUES (298, 1, 'Admin', 1608882235, '[]', 'system.Index/index');
INSERT INTO `lee_admin_user_action` VALUES (299, 1, 'Admin', 1608882235, '[]', 'system.Index/getadminmenulist');
INSERT INTO `lee_admin_user_action` VALUES (300, 1, 'Admin', 1608882235, '[]', 'system.Index/console');
INSERT INTO `lee_admin_user_action` VALUES (301, 1, 'Admin', 1608882242, '[]', 'system.Admin/index');
INSERT INTO `lee_admin_user_action` VALUES (302, 1, 'Admin', 1608882243, '{\"page\":\"1\",\"limit\":\"10\"}', 'system.Admin/index');
INSERT INTO `lee_admin_user_action` VALUES (303, 1, 'Admin', 1608882244, '{\"id\":\"2\"}', 'system.Admin/edit');
INSERT INTO `lee_admin_user_action` VALUES (304, 1, 'Admin', 1608882248, '{\"password\":\"\",\"password_confirm\":\"\",\"nickname\":\"test\",\"file\":\"\",\"thumb\":\"\\/storage\\/topic\\/20200610\\\\cfefb2d076cea3c11cb0a30ae8b779de.jpg\",\"group_id\":[\"1\"],\"desc\":\"\",\"status\":\"1\",\"id\":\"2\"}', 'system.Admin/edit');
INSERT INTO `lee_admin_user_action` VALUES (305, 1, 'Admin', 1608882249, '[]', 'system.Group/index');
INSERT INTO `lee_admin_user_action` VALUES (306, 1, 'Admin', 1608882249, '{\"page\":\"1\",\"limit\":\"15\"}', 'system.Group/index');
INSERT INTO `lee_admin_user_action` VALUES (307, 1, 'Admin', 1608882249, '{\"page\":\"1\",\"limit\":\"10\"}', 'system.Admin/index');
INSERT INTO `lee_admin_user_action` VALUES (308, 1, 'Admin', 1608882250, '{\"id\":\"1\"}', 'system.Group/edit');
INSERT INTO `lee_admin_user_action` VALUES (309, 1, 'Admin', 1608882251, '[]', 'system.Index/getrulelist');
INSERT INTO `lee_admin_user_action` VALUES (310, 1, 'Admin', 1608882256, '[]', 'system.Conf/index');
INSERT INTO `lee_admin_user_action` VALUES (311, 1, 'Admin', 1608882256, '[]', 'system.Menu/index');
INSERT INTO `lee_admin_user_action` VALUES (312, 1, 'Admin', 1608882256, '[]', 'system.Menu/index');
INSERT INTO `lee_admin_user_action` VALUES (313, 1, 'Admin', 1608882264, '{\"id\":\"2\"}', 'system.Admin/edit');
INSERT INTO `lee_admin_user_action` VALUES (314, 2, 'test', 1608882282, '{\"username\":\"test\",\"password\":\"111111\"}', 'system.Publicer/adminloginsubmit');
INSERT INTO `lee_admin_user_action` VALUES (315, 2, 'test', 1608882283, '[]', 'system.Index/index');
INSERT INTO `lee_admin_user_action` VALUES (316, 1, 'Admin', 1608882368, '{\"username\":\"admin\",\"password\":\"123456\"}', 'system.Publicer/adminloginsubmit');
INSERT INTO `lee_admin_user_action` VALUES (317, 1, 'Admin', 1608882369, '[]', 'system.Index/index');
INSERT INTO `lee_admin_user_action` VALUES (318, 1, 'Admin', 1608882369, '[]', 'system.Index/getadminmenulist');
INSERT INTO `lee_admin_user_action` VALUES (319, 1, 'Admin', 1608882369, '[]', 'system.Index/console');
INSERT INTO `lee_admin_user_action` VALUES (320, 1, 'Admin', 1608882375, '[]', 'system.Admin/index');
INSERT INTO `lee_admin_user_action` VALUES (321, 1, 'Admin', 1608882375, '{\"page\":\"1\",\"limit\":\"10\"}', 'system.Admin/index');
INSERT INTO `lee_admin_user_action` VALUES (322, 1, 'Admin', 1608882376, '[]', 'system.Group/index');
INSERT INTO `lee_admin_user_action` VALUES (323, 1, 'Admin', 1608882376, '{\"page\":\"1\",\"limit\":\"15\"}', 'system.Group/index');
INSERT INTO `lee_admin_user_action` VALUES (324, 1, 'Admin', 1608882376, '[]', 'system.Menu/index');
INSERT INTO `lee_admin_user_action` VALUES (325, 1, 'Admin', 1608882376, '[]', 'system.Menu/index');
INSERT INTO `lee_admin_user_action` VALUES (326, 1, 'Admin', 1608882379, '[]', 'system.Menu/add');
INSERT INTO `lee_admin_user_action` VALUES (327, 1, 'Admin', 1608882387, '{\"pid\":\"0\",\"title\":\"system.index\\/getadminmenulist\",\"src\":\"system.index\\/getadminmenulist\",\"icon\":\"\"}', 'system.Menu/add');
INSERT INTO `lee_admin_user_action` VALUES (328, 1, 'Admin', 1608882389, '[]', 'system.Menu/index');
INSERT INTO `lee_admin_user_action` VALUES (329, 1, 'Admin', 1608882389, '[]', 'system.Menu/index');
INSERT INTO `lee_admin_user_action` VALUES (330, 2, 'test', 1608882403, '{\"username\":\"test\",\"password\":\"111111\"}', 'system.Publicer/adminloginsubmit');
INSERT INTO `lee_admin_user_action` VALUES (331, 2, 'test', 1608882404, '[]', 'system.Index/index');
INSERT INTO `lee_admin_user_action` VALUES (332, 2, 'test', 1608882413, '[]', 'system.Publicer/adminlogin');
INSERT INTO `lee_admin_user_action` VALUES (333, 2, 'test', 1608882413, '[]', 'system.Index/index');
INSERT INTO `lee_admin_user_action` VALUES (334, 1, 'Admin', 1608882423, '{\"username\":\"admin\",\"password\":\"123456\"}', 'system.Publicer/adminloginsubmit');
INSERT INTO `lee_admin_user_action` VALUES (335, 1, 'Admin', 1608882424, '[]', 'system.Index/index');
INSERT INTO `lee_admin_user_action` VALUES (336, 1, 'Admin', 1608882424, '[]', 'system.Index/getadminmenulist');
INSERT INTO `lee_admin_user_action` VALUES (337, 1, 'Admin', 1608882424, '[]', 'system.Index/console');
INSERT INTO `lee_admin_user_action` VALUES (338, 1, 'Admin', 1608882428, '[]', 'system.Menu/index');
INSERT INTO `lee_admin_user_action` VALUES (339, 1, 'Admin', 1608882428, '[]', 'system.Menu/index');
INSERT INTO `lee_admin_user_action` VALUES (340, 1, 'Admin', 1608882430, '[]', 'system.Admin/index');
INSERT INTO `lee_admin_user_action` VALUES (341, 1, 'Admin', 1608882431, '{\"page\":\"1\",\"limit\":\"10\"}', 'system.Admin/index');
INSERT INTO `lee_admin_user_action` VALUES (342, 1, 'Admin', 1608882433, '{\"id\":\"2\"}', 'system.Admin/edit');
INSERT INTO `lee_admin_user_action` VALUES (343, 1, 'Admin', 1608882435, '[]', 'system.Group/index');
INSERT INTO `lee_admin_user_action` VALUES (344, 1, 'Admin', 1608882435, '{\"page\":\"1\",\"limit\":\"15\"}', 'system.Group/index');
INSERT INTO `lee_admin_user_action` VALUES (345, 1, 'Admin', 1608882437, '{\"id\":\"1\"}', 'system.Group/edit');
INSERT INTO `lee_admin_user_action` VALUES (346, 1, 'Admin', 1608882437, '[]', 'system.Index/getrulelist');
INSERT INTO `lee_admin_user_action` VALUES (347, 1, 'Admin', 1608882439, '{\"title\":\"\\u8d85\\u7ea7\\u7ba1\\u7406\\u5458\",\"layuiTreeCheck_1\":\"1\",\"layuiTreeCheck_2\":\"2\",\"layuiTreeCheck_3\":\"3\",\"layuiTreeCheck_4\":\"4\",\"layuiTreeCheck_5\":\"5\",\"layuiTreeCheck_14\":\"14\",\"layuiTreeCheck_6\":\"6\",\"layuiTreeCheck_7\":\"7\",\"layuiTreeCheck_8\":\"8\",\"layuiTreeCheck_9\":\"9\",\"layuiTreeCheck_10\":\"10\",\"layuiTreeCheck_11\":\"11\",\"layuiTreeCheck_12\":\"12\",\"layuiTreeCheck_13\":\"13\",\"layuiTreeCheck_15\":\"15\",\"layuiTreeCheck_16\":\"16\",\"layuiTreeCheck_26\":\"26\",\"layuiTreeCheck_27\":\"27\",\"layuiTreeCheck_28\":\"28\",\"layuiTreeCheck_29\":\"29\",\"layuiTreeCheck_55\":\"55\",\"layuiTreeCheck_17\":\"17\",\"layuiTreeCheck_18\":\"18\",\"layuiTreeCheck_19\":\"19\",\"layuiTreeCheck_20\":\"20\",\"layuiTreeCheck_21\":\"21\",\"layuiTreeCheck_22\":\"22\",\"layuiTreeCheck_23\":\"23\",\"layuiTreeCheck_24\":\"24\",\"layuiTreeCheck_25\":\"25\",\"layuiTreeCheck_31\":\"31\",\"layuiTreeCheck_34\":\"34\",\"layuiTreeCheck_35\":\"35\",\"layuiTreeCheck_36\":\"36\",\"layuiTreeCheck_37\":\"37\",\"layuiTreeCheck_38\":\"38\",\"layuiTreeCheck_39\":\"39\",\"layuiTreeCheck_40\":\"40\",\"layuiTreeCheck_32\":\"32\",\"layuiTreeCheck_41\":\"41\",\"layuiTreeCheck_42\":\"42\",\"layuiTreeCheck_43\":\"43\",\"layuiTreeCheck_44\":\"44\",\"layuiTreeCheck_45\":\"45\",\"layuiTreeCheck_46\":\"46\",\"layuiTreeCheck_47\":\"47\",\"layuiTreeCheck_48\":\"48\",\"layuiTreeCheck_49\":\"49\",\"layuiTreeCheck_50\":\"50\",\"layuiTreeCheck_51\":\"51\",\"layuiTreeCheck_52\":\"52\",\"layuiTreeCheck_53\":\"53\",\"layuiTreeCheck_54\":\"54\",\"layuiTreeCheck_56\":\"56\",\"layuiTreeCheck_57\":\"57\",\"layuiTreeCheck_156\":\"156\",\"layuiTreeCheck_157\":\"157\",\"desc\":\"\",\"status\":\"1\",\"id\":\"1\",\"rules\":[\"1\",\"2\",\"3\",\"4\",\"5\",\"14\",\"6\",\"7\",\"8\",\"9\",\"10\",\"11\",\"12\",\"13\",\"15\",\"16\",\"26\",\"27\",\"28\",\"29\",\"55\",\"17\",\"18\",\"19\",\"20\",\"21\",\"22\",\"23\",\"24\",\"25\",\"31\",\"34\",\"35\",\"36\",\"37\",\"38\",\"39\",\"40\",\"32\",\"41\",\"42\",\"43\",\"44\",\"45\",\"46\",\"47\",\"48\",\"49\",\"50\",\"51\",\"52\",\"53\",\"54\",\"56\",\"57\",\"156\",\"157\"]}', 'system.Group/edit');
INSERT INTO `lee_admin_user_action` VALUES (348, 1, 'Admin', 1608882441, '{\"page\":\"1\",\"limit\":\"15\"}', 'system.Group/index');
INSERT INTO `lee_admin_user_action` VALUES (349, 2, 'test', 1608882455, '{\"username\":\"test\",\"password\":\"111111\"}', 'system.Publicer/adminloginsubmit');
INSERT INTO `lee_admin_user_action` VALUES (350, 2, 'test', 1608882456, '[]', 'system.Index/index');
INSERT INTO `lee_admin_user_action` VALUES (351, 2, 'test', 1608882457, '[]', 'system.Index/getadminmenulist');
INSERT INTO `lee_admin_user_action` VALUES (352, 2, 'test', 1608882465, '[]', 'system.Route/index');
INSERT INTO `lee_admin_user_action` VALUES (353, 2, 'test', 1608882465, '{\"page\":\"1\",\"limit\":\"15\"}', 'system.Route/index');
INSERT INTO `lee_admin_user_action` VALUES (354, 2, 'test', 1608882465, '[]', 'system.Conf/index');
INSERT INTO `lee_admin_user_action` VALUES (355, 2, 'test', 1608882466, '[]', 'system.Menu/index');
INSERT INTO `lee_admin_user_action` VALUES (356, 2, 'test', 1608882466, '[]', 'system.Menu/index');
INSERT INTO `lee_admin_user_action` VALUES (357, 2, 'test', 1608882475, '[]', 'system.Nav/index');
INSERT INTO `lee_admin_user_action` VALUES (358, 2, 'test', 1608882475, '{\"page\":\"1\",\"limit\":\"10\"}', 'system.Nav/index');

-- ----------------------------
-- Table structure for lee_cate
-- ----------------------------
DROP TABLE IF EXISTS `lee_cate`;
CREATE TABLE `lee_cate`  (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `title` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `icon` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `pid` int(11) NOT NULL DEFAULT 0,
  `status` int(1) NOT NULL DEFAULT 1 COMMENT '1正常0下架',
  `sort` int(11) NOT NULL DEFAULT 0 COMMENT '排序，值越大越靠前',
  `cate_group_id` int(11) NOT NULL DEFAULT 0,
  `create_time` int(11) NOT NULL DEFAULT 0,
  `update_time` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '分类' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for lee_cate_group
-- ----------------------------
DROP TABLE IF EXISTS `lee_cate_group`;
CREATE TABLE `lee_cate_group`  (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `key` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `desc` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '分类分组' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for lee_content
-- ----------------------------
DROP TABLE IF EXISTS `lee_content`;
CREATE TABLE `lee_content`  (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `apartment_id` int(11) DEFAULT NULL,
  `img` text CHARACTER SET utf8 COLLATE utf8_general_ci COMMENT '图片，多图用,隔开',
  `status` int(1) NOT NULL DEFAULT 1 COMMENT '1正常0下架',
  `title` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `desc` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '概要',
  `content` text CHARACTER SET utf8 COLLATE utf8_general_ci COMMENT '详情',
  `sort` int(11) NOT NULL DEFAULT 0 COMMENT '排序，值越大越靠前',
  `content_group_id` int(11) NOT NULL DEFAULT 0,
  `cate_id` int(11) NOT NULL DEFAULT 0,
  `create_time` int(11) NOT NULL DEFAULT 0,
  `delete_time` int(11) DEFAULT 0,
  `update_time` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '内容' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for lee_content_group
-- ----------------------------
DROP TABLE IF EXISTS `lee_content_group`;
CREATE TABLE `lee_content_group`  (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `key` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `cate_group_id` int(11) NOT NULL DEFAULT 0 COMMENT '分类组id',
  `desc` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '内容分组' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for lee_nav
-- ----------------------------
DROP TABLE IF EXISTS `lee_nav`;
CREATE TABLE `lee_nav`  (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `title` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `icon` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `src` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `status` int(1) NOT NULL DEFAULT 1 COMMENT '1正常0下架',
  `sort` int(11) NOT NULL DEFAULT 0 COMMENT '排序，值越大越靠前',
  `nav_group_id` int(11) NOT NULL DEFAULT 0,
  `create_time` int(11) NOT NULL DEFAULT 0,
  `update_time` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '导航' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for lee_nav_group
-- ----------------------------
DROP TABLE IF EXISTS `lee_nav_group`;
CREATE TABLE `lee_nav_group`  (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `key` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `desc` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '导航分组' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for lee_route
-- ----------------------------
DROP TABLE IF EXISTS `lee_route`;
CREATE TABLE `lee_route`  (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `module` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '应用名',
  `full_url` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `url` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `status` int(1) NOT NULL DEFAULT 1 COMMENT '1启用-1禁用',
  `create_time` int(11) NOT NULL DEFAULT 0,
  `update_time` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '路由设置' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for lee_slide
-- ----------------------------
DROP TABLE IF EXISTS `lee_slide`;
CREATE TABLE `lee_slide`  (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `icon` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `status` int(1) NOT NULL DEFAULT 1 COMMENT '1正常0下架',
  `src` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `sort` int(11) NOT NULL DEFAULT 0 COMMENT '排序，值越大越靠前',
  `slide_group_id` int(11) NOT NULL DEFAULT 0,
  `create_time` int(11) NOT NULL DEFAULT 0,
  `update_time` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '轮播' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for lee_slide_group
-- ----------------------------
DROP TABLE IF EXISTS `lee_slide_group`;
CREATE TABLE `lee_slide_group`  (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `key` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `desc` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '轮播分组' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for lee_user
-- ----------------------------
DROP TABLE IF EXISTS `lee_user`;
CREATE TABLE `lee_user`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `unionid` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `openid` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '微信ID',
  `owner_id` int(11) NOT NULL DEFAULT 0 COMMENT '默认业主',
  `nickname` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '姓名',
  `sex` tinyint(1) NOT NULL DEFAULT 0 COMMENT '性别:0:未知;1:男;2:女;',
  `mobile` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '电话',
  `avatar` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '头像',
  `auth_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '认证姓名',
  `auth_idcard` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '认证身份证',
  `auth_data` text CHARACTER SET utf8 COLLATE utf8_general_ci COMMENT '认证数据',
  `auth_status` tinyint(1) NOT NULL DEFAULT 0 COMMENT '认证状态:0:未认证;1:已认证;',
  `auth_time` int(11) NOT NULL DEFAULT 0 COMMENT '认证时间',
  `create_time` int(11) NOT NULL DEFAULT 0,
  `update_time` int(11) NOT NULL DEFAULT 0,
  `delete_time` int(11) DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '用户表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of lee_user
-- ----------------------------
INSERT INTO `lee_user` VALUES (1, '', 'o-T7q0GaktE4k5L6msOG6Jg12fhY', 1, '#List', 1, '', 'https://wx.qlogo.cn/mmopen/vi_32/PiajxSqBRaEJvoHUEuoK3K2w2ibgBoicqCF8u7ibAqaOHG8CqIucojbJEMWxUo6puLzpuaJh3kG5cUUXExaLuMC8AA/132', '', '', NULL, 0, 0, 1589013062, 1591597580, 0);

SET FOREIGN_KEY_CHECKS = 1;

/*
Navicat MySQL Data Transfer

Source Server         : gresr
Source Server Version : 50717
Source Host           : localhost:3306
Source Database       : exam_project

Target Server Type    : MYSQL
Target Server Version : 50717
File Encoding         : 65001

Date: 2017-12-08 17:22:09
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for admin
-- ----------------------------
DROP TABLE IF EXISTS `admin`;
CREATE TABLE `admin` (
  `id` int(225) NOT NULL AUTO_INCREMENT,
  `aname` varchar(21) DEFAULT NULL,
  `apass` varchar(40) DEFAULT NULL,
  `afullname` varchar(21) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of admin
-- ----------------------------
INSERT INTO `admin` VALUES ('1', 'admin', '21232f297a57a5a743894a0e4a801fc3', 'admin');

-- ----------------------------
-- Table structure for binding
-- ----------------------------
DROP TABLE IF EXISTS `binding`;
CREATE TABLE `binding` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sid` int(11) NOT NULL,
  `eid` int(11) NOT NULL,
  `ip` varchar(40) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of binding
-- ----------------------------

-- ----------------------------
-- Table structure for exam
-- ----------------------------
DROP TABLE IF EXISTS `exam`;
CREATE TABLE `exam` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `ename` varchar(40) NOT NULL,
  `etime` datetime NOT NULL,
  `eautostart` tinyint(1) NOT NULL DEFAULT '0',
  `eactive` tinyint(1) DEFAULT NULL,
  `efinish` tinyint(1) DEFAULT NULL,
  `earchived` tinyint(1) DEFAULT NULL,
  `ecleared` tinyint(1) DEFAULT NULL,
  `ecreator` int(11) NOT NULL,
  `epaper` varchar(255) DEFAULT NULL,
  `etype` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of exam
-- ----------------------------
INSERT INTO `exam` VALUES ('2', 'xn阿三', '2017-12-01 14:47:06', '1', null, null, null, null, '1', null, null);
INSERT INTO `exam` VALUES ('4', 'xn', '2017-11-17 13:18:00', '0', null, null, null, null, '1', null, null);
INSERT INTO `exam` VALUES ('15', 'as', '2017-11-24 18:06:04', '0', null, null, null, null, '1', null, null);
INSERT INTO `exam` VALUES ('16', '阿三', '2017-12-01 14:26:32', '1', null, null, null, null, '1', null, null);

-- ----------------------------
-- Table structure for student
-- ----------------------------
DROP TABLE IF EXISTS `student`;
CREATE TABLE `student` (
  `id` int(225) NOT NULL AUTO_INCREMENT,
  `sno` varchar(12) NOT NULL,
  `sname` varchar(12) NOT NULL,
  `sclass` varchar(20) DEFAULT NULL,
  `eid` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of student
-- ----------------------------
INSERT INTO `student` VALUES ('1', '1510121137', '徐', '15-3', '1');

-- ----------------------------
-- Table structure for submit
-- ----------------------------
DROP TABLE IF EXISTS `submit`;
CREATE TABLE `submit` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sid` int(11) NOT NULL,
  `eid` int(11) NOT NULL,
  `stime` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of submit
-- ----------------------------

-- ----------------------------
-- Table structure for teacher
-- ----------------------------
DROP TABLE IF EXISTS `teacher`;
CREATE TABLE `teacher` (
  `id` int(225) NOT NULL AUTO_INCREMENT,
  `tname` varchar(20) NOT NULL,
  `tpass` varchar(40) NOT NULL,
  `tfullname` varchar(12) DEFAULT NULL,
  `tadmin` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=85 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of teacher
-- ----------------------------
INSERT INTO `teacher` VALUES ('84', '2', 'c81e728d9d4c2f636f067f89cc14862c', '2', '2');
SET FOREIGN_KEY_CHECKS=1;

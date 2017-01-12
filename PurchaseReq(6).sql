-- phpMyAdmin SQL Dump
-- version 2.11.5
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Aug 20, 2009 at 02:39 PM
-- Server version: 5.0.45
-- PHP Version: 5.1.6

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";

--
-- Database: `PurchaseReq`
--

-- --------------------------------------------------------

--
-- Stand-in structure for view `avprview`
--
CREATE TABLE `avprview` (
`purchase_req_id` int(10) unsigned
,`username` varchar(50)
,`date` datetime
,`shipping` enum('standard','rush','overnight')
,`date_submitted` datetime
,`reason` text
,`comments` text
,`approved` tinyint(1) unsigned
);
-- --------------------------------------------------------

--
-- Table structure for table `departments`
--

CREATE TABLE `departments` (
  `department_id` smallint(5) unsigned NOT NULL auto_increment,
  `name` varchar(50) character set utf8 collate utf8_bin NOT NULL,
  `qb_code` varchar(50) character set utf8 collate utf8_bin NOT NULL,
  PRIMARY KEY  (`department_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=3 ;

--
-- Dumping data for table `departments`
--

INSERT INTO `departments` VALUES(1, 'IT', '000-01-53');
INSERT INTO `departments` VALUES(2, 'R&D', '0-054-889');

-- --------------------------------------------------------

--
-- Table structure for table `line_items`
--

CREATE TABLE `line_items` (
  `line_item_id` int(10) unsigned NOT NULL auto_increment,
  `purchase_req_id` int(10) unsigned NOT NULL,
  `purchase_order_id` int(10) unsigned default NULL,
  `av_session_id` int(10) unsigned NOT NULL,
  `product_num` varchar(50) character set utf8 collate utf8_bin NOT NULL,
  `quantity` smallint(5) unsigned NOT NULL,
  `item_cost` float NOT NULL,
  `total_cost` float NOT NULL,
  `description` varchar(200) character set utf8 collate utf8_bin NOT NULL,
  PRIMARY KEY  (`line_item_id`),
  KEY `purchase_req_id` (`purchase_req_id`),
  KEY `av_session_id` (`av_session_id`),
  KEY `purchase_order_id` (`purchase_order_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=41 ;

--
-- Dumping data for table `line_items`
--

INSERT INTO `line_items` VALUES(1, 1, 1, 0, 'APPL-53', 1, 1546, 1546, '15&quot; MacBook Pro');
INSERT INTO `line_items` VALUES(2, 2, 2, 0, '7tiugkj', 56, 300.23, 16812.9, 'oiblbo9yi7y 8yviuyt, uylb8y8li');
INSERT INTO `line_items` VALUES(3, 3, 2, 0, 'thcrhcr', 34, 467, 15878, 'fchyhtxybgstyt');
INSERT INTO `line_items` VALUES(7, 5, 2, 0, 'iuyKIV6vki8', 1, 1000, 1000, 'bl*y *IoiU iBY&amp;lt; uIYv uH');
INSERT INTO `line_items` VALUES(6, 5, 2, 0, 'nihkw83by', 54, 780, 42120, 'b hc elwyf 4y4e8lvyfo.');
INSERT INTO `line_items` VALUES(10, 9, 5, 0, 'kn uerh i4ey', 20, 1456, 29120, 'rb duifheru hei iuehrfiuherub');
INSERT INTO `line_items` VALUES(11, 10, 9, 0, '4 lk98n', 1, 1457, 1457, 'oihnkjnbg8ho91');
INSERT INTO `line_items` VALUES(13, 10, 9, 0, '4 b787g789', 2, 7643, 15286, '57 giougo 87g 8ogvuy87g ouybv');
INSERT INTO `line_items` VALUES(21, 18, 2, 0, 'iu hiu', 2, 2, 4, 'h iuniu h98');
INSERT INTO `line_items` VALUES(22, 19, 2, 0, 'hiu hbik', 1, 1, 1, 'i ubiu giugiu ho');
INSERT INTO `line_items` VALUES(20, 18, 2, 0, 'iuhn h', 1, 1, 1, 'hiuhniun');
INSERT INTO `line_items` VALUES(25, 10, 9, 0, '78g7u', 10, 88, 880, 'ghoiuhn8ghn887 giugiu');
INSERT INTO `line_items` VALUES(26, 10, 9, 0, 'iuiu', 1, 1, 1, 'giugiu');
INSERT INTO `line_items` VALUES(27, 20, 7, 0, 'test', 5, 100, 500, 'testtttt');
INSERT INTO `line_items` VALUES(28, 21, 10, 0, 'ertg', 10, 500, 5000, 'hedrth');
INSERT INTO `line_items` VALUES(29, 22, 9, 0, 'uiiyugk', 1, 50, 50, 'iubeksjvbnrou');
INSERT INTO `line_items` VALUES(30, 23, 8, 0, 'uiiyugk', 1, 50, 50, 'iubeksjvbnrou');
INSERT INTO `line_items` VALUES(31, 24, 8, 0, 'uiiyugk', 1, 50, 50, 'iubeksjvbnrou');
INSERT INTO `line_items` VALUES(32, 25, 8, 0, 'uiiyugk', 1, 50, 50, 'iubeksjvbnrou');
INSERT INTO `line_items` VALUES(33, 26, 11, 0, 'APPL-53', 1, 1500, 1500, '15&quot; MacBook Pro');
INSERT INTO `line_items` VALUES(34, 27, 11, 0, 'APPL-53', 5, 1500, 7500, '15&quot; MacBook Pro');
INSERT INTO `line_items` VALUES(36, 29, 12, 0, 'APPL-53', 1, 1500, 1500, '15&quot; MacBook Pro');
INSERT INTO `line_items` VALUES(37, 30, 12, 0, 'APPL-53', 5, 1500, 7500, '15&quot; MacBook Pro');
INSERT INTO `line_items` VALUES(38, 31, NULL, 0, 'test', 1, 50, 50, 'testtttt');
INSERT INTO `line_items` VALUES(39, 32, 13, 0, 'APPL-53', 1, 1500, 1500, '15&quot; MacBook Pro');
INSERT INTO `line_items` VALUES(40, 33, NULL, 0, 'APPL-53', 5, 1500, 7500, '15&quot; MacBook Pro');

-- --------------------------------------------------------

--
-- Table structure for table `line_items_received`
--

CREATE TABLE `line_items_received` (
  `line_item_id` int(10) unsigned NOT NULL,
  `user_id` smallint(5) unsigned NOT NULL,
  `date_received` datetime NOT NULL,
  `quantity_received` smallint(5) unsigned NOT NULL,
  KEY `line_item_id` (`line_item_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

--
-- Dumping data for table `line_items_received`
--


-- --------------------------------------------------------

--
-- Table structure for table `pr_approvals`
--

CREATE TABLE `pr_approvals` (
  `pr_approval_id` int(10) unsigned NOT NULL auto_increment,
  `purchase_req_id` int(10) unsigned NOT NULL,
  `user_id` smallint(5) unsigned NOT NULL,
  `date_approved` datetime NOT NULL,
  `user_ip_addr` varchar(15) collate utf8_bin NOT NULL,
  PRIMARY KEY  (`pr_approval_id`),
  KEY `purchase_req_id` (`purchase_req_id`),
  KEY `user_id` (`user_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_bin AUTO_INCREMENT=15 ;

--
-- Dumping data for table `pr_approvals`
--

INSERT INTO `pr_approvals` VALUES(1, 19, 1, '2009-06-26 01:41:17', '192.168.8.30');
INSERT INTO `pr_approvals` VALUES(2, 20, 1, '2009-06-26 01:44:18', '192.168.8.30');
INSERT INTO `pr_approvals` VALUES(3, 25, 1, '2009-06-26 12:16:00', '192.168.8.103');
INSERT INTO `pr_approvals` VALUES(4, 24, 1, '2009-06-26 12:18:09', '192.168.8.103');
INSERT INTO `pr_approvals` VALUES(5, 23, 1, '2009-06-26 12:27:42', '192.168.8.103');
INSERT INTO `pr_approvals` VALUES(6, 26, 1, '2009-06-26 13:16:43', '192.168.8.103');
INSERT INTO `pr_approvals` VALUES(7, 27, 1, '2009-06-26 13:16:59', '192.168.8.103');
INSERT INTO `pr_approvals` VALUES(8, 27, 3, '2009-06-26 13:17:25', '192.168.8.103');
INSERT INTO `pr_approvals` VALUES(9, 29, 1, '2009-06-26 13:21:44', '192.168.8.103');
INSERT INTO `pr_approvals` VALUES(10, 30, 1, '2009-06-26 13:21:47', '192.168.8.103');
INSERT INTO `pr_approvals` VALUES(11, 30, 3, '2009-06-26 13:21:57', '192.168.8.103');
INSERT INTO `pr_approvals` VALUES(12, 32, 1, '2009-06-26 13:48:03', '192.168.8.103');
INSERT INTO `pr_approvals` VALUES(13, 33, 1, '2009-06-26 13:48:31', '192.168.8.103');
INSERT INTO `pr_approvals` VALUES(14, 33, 3, '2009-06-26 13:55:26', '192.168.8.103');

-- --------------------------------------------------------

--
-- Table structure for table `pr_approval_rules`
--

CREATE TABLE `pr_approval_rules` (
  `pr_approval_rule_id` smallint(5) unsigned NOT NULL auto_increment,
  `user_id` smallint(5) unsigned default NULL,
  `department_id` smallint(5) unsigned default NULL,
  `priority` smallint(5) unsigned NOT NULL,
  `trigger_value` int(10) unsigned NOT NULL,
  `trigger_operator` varchar(2) collate utf8_bin NOT NULL,
  `destination_user_id` smallint(5) unsigned NOT NULL,
  PRIMARY KEY  (`pr_approval_rule_id`),
  KEY `user_id` (`user_id`),
  KEY `trigger_value` (`trigger_value`),
  KEY `department_id` (`department_id`),
  KEY `priority` (`priority`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_bin AUTO_INCREMENT=2 ;

--
-- Dumping data for table `pr_approval_rules`
--

INSERT INTO `pr_approval_rules` VALUES(1, NULL, 1, 1, 5000, '>=', 3);

-- --------------------------------------------------------

--
-- Table structure for table `purchase_orders`
--

CREATE TABLE `purchase_orders` (
  `purchase_order_id` int(10) unsigned NOT NULL auto_increment,
  `purchase_order_name` varchar(20) collate utf8_bin NOT NULL,
  `av_session_id` int(10) unsigned NOT NULL,
  `user_id` smallint(5) unsigned NOT NULL,
  `vendor_id` int(10) unsigned NOT NULL,
  `date_submit` datetime NOT NULL,
  `total_cost_po` float NOT NULL,
  `exported` tinyint(1) unsigned NOT NULL default '0',
  PRIMARY KEY  (`purchase_order_id`),
  UNIQUE KEY `purchase_order_name` (`purchase_order_name`),
  KEY `vendor_id` (`vendor_id`),
  KEY `av_session_id` (`av_session_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_bin AUTO_INCREMENT=14 ;

--
-- Dumping data for table `purchase_orders`
--

INSERT INTO `purchase_orders` VALUES(1, 'PO2009-00001', 0, 1, 2, '2009-06-24 20:26:39', 1546, 0);
INSERT INTO `purchase_orders` VALUES(2, 'PO2009-00002', 0, 1, 1, '2009-06-24 21:17:49', 75816.9, 0);
INSERT INTO `purchase_orders` VALUES(5, 'PO2009-00003', 0, 1, 2, '2009-06-25 00:48:14', 29120, 0);
INSERT INTO `purchase_orders` VALUES(7, 'PO2009-00004', 0, 3, 1, '2009-06-26 01:49:37', 500, 0);
INSERT INTO `purchase_orders` VALUES(8, 'PO2009-00005', 0, 4, 2, '2009-06-26 12:31:52', 150, 0);
INSERT INTO `purchase_orders` VALUES(9, 'PO2009-00006', 0, 4, 2, '2009-06-26 13:18:08', 17674, 0);
INSERT INTO `purchase_orders` VALUES(10, 'PO2009-00007', 0, 4, 1, '2009-06-26 13:18:16', 5000, 0);
INSERT INTO `purchase_orders` VALUES(11, 'PO2009-00008', 0, 4, 2, '2009-06-26 13:20:48', 9000, 0);
INSERT INTO `purchase_orders` VALUES(12, 'PO2009-00009', 0, 4, 2, '2009-06-26 13:23:09', 9000, 0);
INSERT INTO `purchase_orders` VALUES(13, 'PO2009-00010', 0, 4, 2, '2009-06-26 13:56:40', 1500, 0);

-- --------------------------------------------------------

--
-- Table structure for table `purchase_reqs`
--

CREATE TABLE `purchase_reqs` (
  `purchase_req_id` int(10) unsigned NOT NULL auto_increment,
  `purchase_req_name` varchar(20) character set utf8 collate utf8_bin NOT NULL,
  `av_session_id` int(10) unsigned NOT NULL,
  `user_id` smallint(5) unsigned NOT NULL,
  `department_id` smallint(5) unsigned NOT NULL,
  `vendor_id` int(10) unsigned NOT NULL,
  `date_req` datetime NOT NULL,
  `shipping` enum('standard','rush','overnight') character set utf8 collate utf8_bin NOT NULL,
  `date_submit` datetime NOT NULL,
  `date_ordered` datetime NOT NULL,
  `date_complete` datetime NOT NULL,
  `total_quant_pr` int(10) unsigned NOT NULL,
  `total_cost_pr` float NOT NULL,
  `approved` tinyint(1) unsigned NOT NULL default '0',
  `reason` text character set utf8 collate utf8_bin NOT NULL,
  `comments` text character set utf8 collate utf8_bin NOT NULL,
  PRIMARY KEY  (`purchase_req_id`),
  UNIQUE KEY `purchase_req_name` (`purchase_req_name`),
  KEY `vendor_id` (`vendor_id`),
  KEY `av_session_id` (`av_session_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 DATA DIRECTORY='./purchasereq/' INDEX DIRECTORY='./purchasereq/' AUTO_INCREMENT=34 ;

--
-- Dumping data for table `purchase_reqs`
--

INSERT INTO `purchase_reqs` VALUES(1, 'PR2009-00567-MB', 0, 2, 1, 2, '2009-06-19 00:00:00', 'rush', '2009-06-19 14:42:36', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 1, 1546, 1, 0x54657374696e67, 0x74657374696e672e2e2e);
INSERT INTO `purchase_reqs` VALUES(2, 'PR2009-00557-MB', 0, 1, 1, 1, '2009-06-19 00:00:00', 'standard', '2009-06-19 14:59:49', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 56, 16812.9, 1, 0x7465737420616761696e, 0x6e6f7769656b74762077696f68776b6a7662);
INSERT INTO `purchase_reqs` VALUES(3, 'PR2009-00559-MB', 0, 1, 1, 1, '2009-06-19 00:00:00', 'standard', '2009-06-19 15:09:45', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 34, 15878, 1, 0x7579727566, 0x63757437756a6a7574);
INSERT INTO `purchase_reqs` VALUES(5, 'PR2009-00560-MB', 0, 1, 1, 1, '2009-06-22 00:00:00', 'standard', '2009-06-22 14:35:33', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 55, 43120, 1, 0x616e6f746865722074657374, 0x66756f776e20663468206c343377796668736b6a646376646d2c73);
INSERT INTO `purchase_reqs` VALUES(9, 'PR2009-00561-MB', 0, 2, 1, 2, '2009-06-23 00:00:00', 'rush', '2009-06-23 01:30:03', '2009-06-25 00:48:14', '0000-00-00 00:00:00', 20, 29120, 1, 0x6672736c676e72206f696572686e6b64736a, 0x6e2069766472626e20696c7265756865696720756568726975766466206a6b626776642c6a2062692075726564767266);
INSERT INTO `purchase_reqs` VALUES(10, 'PR2009-00556-MB', 0, 2, 1, 2, '2009-06-24 00:00:00', 'rush', '2009-06-23 01:31:09', '2009-06-26 13:18:08', '0000-00-00 00:00:00', 14, 17624, 1, 0x3720626c6b6e, 0x37206975624955474937676955424b206e2069766472626e20696c7265756865696720756568726975766466206a6b626776642c6a2062692075726564767266);
INSERT INTO `purchase_reqs` VALUES(19, 'PR2009-00562-MB', 0, 2, 1, 1, '2009-06-23 00:00:00', 'overnight', '2009-06-23 03:06:27', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 1, 1, 1, 0x63776e66206a206365772042, 0x686263722066626572697566206269657262766965722067686975);
INSERT INTO `purchase_reqs` VALUES(18, 'PR2009-00563-MB', 0, 2, 1, 1, '2009-06-23 00:00:00', 'standard', '2009-06-23 03:05:44', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 3, 5, 1, 0x6e6c3420663438336968666b6a6e, 0x626a20697568206e6c206b686e6b6a6e);
INSERT INTO `purchase_reqs` VALUES(20, 'PR2009-00568-AG', 0, 2, 1, 1, '2009-06-26 00:00:00', 'standard', '2009-06-26 01:42:29', '2009-06-26 01:49:37', '0000-00-00 00:00:00', 5, 500, 1, 0x74657374696e67, 0x746573742074657374);
INSERT INTO `purchase_reqs` VALUES(21, 'PR2009-00569-AG', 0, 2, 1, 1, '2009-06-26 00:00:00', 'standard', '2009-06-26 02:17:27', '2009-06-26 13:18:16', '0000-00-00 00:00:00', 10, 5000, 1, 0x74776772, 0x7274686568);
INSERT INTO `purchase_reqs` VALUES(22, 'PR2009-00570-AG', 0, 2, 1, 2, '2009-06-26 00:00:00', 'standard', '2009-06-26 12:13:07', '2009-06-26 13:18:08', '0000-00-00 00:00:00', 1, 50, 1, 0x7567666b776a6b656a77, 0x75696266776569756762656b6a);
INSERT INTO `purchase_reqs` VALUES(23, 'PR2009-00571-AG', 0, 2, 1, 2, '2009-06-26 00:00:00', 'standard', '2009-06-26 12:14:15', '2009-06-26 12:31:52', '0000-00-00 00:00:00', 1, 50, 1, 0x7567666b776a6b656a77, 0x75696266776569756762656b6a);
INSERT INTO `purchase_reqs` VALUES(24, 'PR2009-00572-AG', 0, 2, 1, 2, '2009-06-26 00:00:00', 'standard', '2009-06-26 12:14:28', '2009-06-26 12:31:52', '0000-00-00 00:00:00', 1, 50, 1, 0x7567666b776a6b656a77, 0x75696266776569756762656b6a);
INSERT INTO `purchase_reqs` VALUES(25, 'PR2009-00573-AG', 0, 2, 1, 2, '2009-06-26 00:00:00', 'standard', '2009-06-26 12:15:07', '2009-06-26 12:31:52', '0000-00-00 00:00:00', 1, 50, 1, 0x7567666b776a6b656a77, 0x75696266776569756762656b6a);
INSERT INTO `purchase_reqs` VALUES(26, 'PR2009-00574-AG', 0, 2, 1, 2, '2009-06-26 00:00:00', 'standard', '2009-06-26 13:11:10', '2009-06-26 13:20:48', '0000-00-00 00:00:00', 1, 1500, 1, 0x436861726c69652077616e74732061204d6163426f6f6b, 0x45742074752c20436861726c69653f);
INSERT INTO `purchase_reqs` VALUES(27, 'PR2009-00575-AG', 0, 2, 1, 2, '2009-06-26 00:00:00', 'standard', '2009-06-26 13:11:36', '2009-06-26 13:20:48', '0000-00-00 00:00:00', 5, 7500, 1, 0x436861726c69652077616e74732035204d6163426f6f6b73, '');
INSERT INTO `purchase_reqs` VALUES(29, 'PR2009-00576-AG', 0, 2, 1, 2, '2009-06-26 00:00:00', 'standard', '2009-06-26 13:21:15', '2009-06-26 13:23:09', '0000-00-00 00:00:00', 1, 1500, 1, 0x436861726c69652077616e74732061204d6163426f6f6b, '');
INSERT INTO `purchase_reqs` VALUES(30, 'PR2009-00577-AG', 0, 2, 1, 2, '2009-06-26 00:00:00', 'standard', '2009-06-26 13:21:31', '2009-06-26 13:23:09', '0000-00-00 00:00:00', 5, 7500, 1, 0x436861726c69652077616e74732035204d6163426f6f6b73, '');
INSERT INTO `purchase_reqs` VALUES(31, 'PR2009-00578-AG', 0, 2, 1, 1, '2009-06-26 00:00:00', 'standard', '2009-06-26 13:26:15', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 1, 50, 0, 0x54455354696e67, 0x74657374);
INSERT INTO `purchase_reqs` VALUES(32, 'PR2009-00579-AG', 0, 2, 1, 2, '2009-06-26 00:00:00', 'standard', '2009-06-26 13:46:14', '2009-06-26 13:56:40', '0000-00-00 00:00:00', 1, 1500, 1, 0x436861726c69652077616e74732061204d6163426f6f6b, 0x457420747520436861726c69653f);
INSERT INTO `purchase_reqs` VALUES(33, 'PR2009-00580-AG', 0, 2, 1, 1, '2009-06-26 00:00:00', 'standard', '2009-06-26 13:46:56', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 5, 7500, 1, 0x436861726c69652077616e74732035204d6163426f6f6b73, '');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `user_id` smallint(5) unsigned NOT NULL auto_increment,
  `username` varchar(50) character set utf8 collate utf8_bin NOT NULL,
  `usertype` tinyint(3) unsigned NOT NULL default '0',
  `fullname` varchar(50) character set utf8 collate utf8_bin NOT NULL,
  `email` varchar(50) character set utf8 collate utf8_bin NOT NULL,
  `manager_id` smallint(5) unsigned NOT NULL,
  `self_approval` float unsigned default NULL,
  `password` varchar(100) NOT NULL,
  PRIMARY KEY  (`user_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 DATA DIRECTORY='./purchasereq/' INDEX DIRECTORY='./purchasereq/' AUTO_INCREMENT=6 ;

--
-- Dumping data for table `users`
--

INSERT INTO `users` VALUES(1, 'mbeck', 0, 'Michael Beck', 'mbeck@solazyme.com', 3, NULL, '54cdfb30e78a144cdd3d4367ea890be8');
INSERT INTO `users` VALUES(2, 'agerrits', 0, 'Ari Gerrits', 'agerrits@solazyme.com', 1, NULL, '54cdfb30e78a144cdd3d4367ea890be8');
INSERT INTO `users` VALUES(3, 'tpainter', 0, 'Tyler Painter', 'tpainter@solazyme.com', 0, NULL, '54cdfb30e78a144cdd3d4367ea890be8');
INSERT INTO `users` VALUES(4, 'jacena', 2, 'Jocelyn Acena', 'jacena@solazyme.com', 5, NULL, '54cdfb30e78a144cdd3d4367ea890be8');
INSERT INTO `users` VALUES(5, 'oromero', 0, 'Orlando Romero', 'oromero@solazyme.com', 3, NULL, '54cdfb30e78a144cdd3d4367ea890be8');

-- --------------------------------------------------------

--
-- Table structure for table `users_departments`
--

CREATE TABLE `users_departments` (
  `user_id` smallint(5) unsigned NOT NULL,
  `department_id` smallint(5) unsigned NOT NULL,
  PRIMARY KEY  (`user_id`,`department_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `users_departments`
--

INSERT INTO `users_departments` VALUES(1, 1);
INSERT INTO `users_departments` VALUES(2, 1);

-- --------------------------------------------------------

--
-- Table structure for table `vendors`
--

CREATE TABLE `vendors` (
  `vendor_id` int(10) unsigned NOT NULL auto_increment,
  `name` varchar(100) character set utf8 collate utf8_bin NOT NULL,
  `qb_code` varchar(50) NOT NULL,
  PRIMARY KEY  (`vendor_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=3 ;

--
-- Dumping data for table `vendors`
--

INSERT INTO `vendors` VALUES(1, 'PC Connection', '');
INSERT INTO `vendors` VALUES(2, 'Apple Computer', '');

-- --------------------------------------------------------

--
-- Stand-in structure for view `view_approval_rules`
--
CREATE TABLE `view_approval_rules` (
`priority` bigint(20) unsigned
,`trigger_value` bigint(20) unsigned
,`trigger_operator` varchar(2)
,`destination_user_id` smallint(6) unsigned
,`purchase_req_id` int(11) unsigned
,`purchase_req_name` varchar(20)
,`user_id` smallint(6) unsigned
,`user_name` varchar(50)
,`department_id` smallint(6) unsigned
,`department_name` varchar(50)
,`vendor_id` int(11) unsigned
,`vendor_name` varchar(100)
,`date_req` varchar(10)
,`shipping` varchar(9)
,`total_cost_pr` float
,`total_cost_pr_format` varchar(6)
,`approved` tinyint(4) unsigned
,`reason` text
,`comments` text
);
-- --------------------------------------------------------

--
-- Stand-in structure for view `view_purchasing`
--
CREATE TABLE `view_purchasing` (
`line_item_id` int(10) unsigned
,`purchase_req_id` int(10) unsigned
,`purchase_req_name` varchar(20)
,`purchase_order_id` int(10) unsigned
,`purchase_order_name` varchar(20)
,`product_num` varchar(50)
,`quantity` smallint(5) unsigned
,`item_cost` float
,`total_cost` float
,`description` varchar(200)
,`user_id` smallint(5) unsigned
,`user_name` varchar(50)
,`department_id` smallint(5) unsigned
,`department_name` varchar(50)
,`vendor_id` int(10) unsigned
,`vendor_name` varchar(100)
,`date_req` varchar(10)
,`shipping` enum('standard','rush','overnight')
,`total_cost_pr` varchar(6)
,`approved` tinyint(1) unsigned
,`reason` text
,`comments` text
);
-- --------------------------------------------------------

--
-- Structure for view `avprview`
--
DROP TABLE IF EXISTS `avprview`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `PurchaseReq`.`avprview` AS select `purchasereq`.`purchase_reqs`.`purchase_req_id` AS `purchase_req_id`,`purchasereq`.`users`.`username` AS `username`,`purchasereq`.`purchase_reqs`.`date_req` AS `date`,`purchasereq`.`purchase_reqs`.`shipping` AS `shipping`,`purchasereq`.`purchase_reqs`.`date_submit` AS `date_submitted`,`purchasereq`.`purchase_reqs`.`reason` AS `reason`,`purchasereq`.`purchase_reqs`.`comments` AS `comments`,`purchasereq`.`purchase_reqs`.`approved` AS `approved` from (`purchasereq`.`purchase_reqs` join `purchasereq`.`users` on((`purchasereq`.`purchase_reqs`.`user_id` = `purchasereq`.`users`.`user_id`)));

-- --------------------------------------------------------

--
-- Structure for view `view_approval_rules`
--
DROP TABLE IF EXISTS `view_approval_rules`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `PurchaseReq`.`view_approval_rules` AS (select `PurchaseReq`.`pr_approval_rules`.`priority` AS `priority`,`PurchaseReq`.`pr_approval_rules`.`trigger_value` AS `trigger_value`,`PurchaseReq`.`pr_approval_rules`.`trigger_operator` AS `trigger_operator`,`PurchaseReq`.`pr_approval_rules`.`destination_user_id` AS `destination_user_id`,`PurchaseReq`.`purchase_reqs`.`purchase_req_id` AS `purchase_req_id`,`PurchaseReq`.`purchase_reqs`.`purchase_req_name` AS `purchase_req_name`,`PurchaseReq`.`purchase_reqs`.`user_id` AS `user_id`,`PurchaseReq`.`users`.`fullname` AS `user_name`,`PurchaseReq`.`purchase_reqs`.`department_id` AS `department_id`,`PurchaseReq`.`departments`.`name` AS `department_name`,`PurchaseReq`.`purchase_reqs`.`vendor_id` AS `vendor_id`,`PurchaseReq`.`vendors`.`name` AS `vendor_name`,date_format(`PurchaseReq`.`purchase_reqs`.`date_req`,_latin1'%m/%d/%Y') AS `date_req`,`PurchaseReq`.`purchase_reqs`.`shipping` AS `shipping`,`PurchaseReq`.`purchase_reqs`.`total_cost_pr` AS `total_cost_pr`,concat(_utf8'$',format(`PurchaseReq`.`purchase_reqs`.`total_cost_pr`,2)) AS `total_cost_pr_format`,`PurchaseReq`.`purchase_reqs`.`approved` AS `approved`,`PurchaseReq`.`purchase_reqs`.`reason` AS `reason`,`PurchaseReq`.`purchase_reqs`.`comments` AS `comments` from ((((`PurchaseReq`.`purchase_reqs` join `PurchaseReq`.`users` on((`PurchaseReq`.`purchase_reqs`.`user_id` = `PurchaseReq`.`users`.`user_id`))) join `PurchaseReq`.`departments` on((`PurchaseReq`.`purchase_reqs`.`department_id` = `PurchaseReq`.`departments`.`department_id`))) join `PurchaseReq`.`vendors` on((`PurchaseReq`.`purchase_reqs`.`vendor_id` = `PurchaseReq`.`vendors`.`vendor_id`))) join `PurchaseReq`.`pr_approval_rules` on(((`PurchaseReq`.`purchase_reqs`.`user_id` = `PurchaseReq`.`pr_approval_rules`.`user_id`) or (`PurchaseReq`.`purchase_reqs`.`department_id` = `PurchaseReq`.`pr_approval_rules`.`department_id`)))) where (`PurchaseReq`.`purchase_reqs`.`total_cost_pr` >= `PurchaseReq`.`pr_approval_rules`.`trigger_value`)) union (select 0 AS `priority`,0 AS `trigger_value`,_latin1'>=' AS `trigger_operator`,`PurchaseReq`.`users`.`manager_id` AS `destination_user_id`,`PurchaseReq`.`purchase_reqs`.`purchase_req_id` AS `purchase_req_id`,`PurchaseReq`.`purchase_reqs`.`purchase_req_name` AS `purchase_req_name`,`PurchaseReq`.`purchase_reqs`.`user_id` AS `user_id`,`PurchaseReq`.`users`.`fullname` AS `user_name`,`PurchaseReq`.`purchase_reqs`.`department_id` AS `department_id`,`PurchaseReq`.`departments`.`name` AS `department_name`,`PurchaseReq`.`purchase_reqs`.`vendor_id` AS `vendor_id`,`PurchaseReq`.`vendors`.`name` AS `vendor_name`,date_format(`PurchaseReq`.`purchase_reqs`.`date_req`,_latin1'%m/%d/%Y') AS `date_req`,`PurchaseReq`.`purchase_reqs`.`shipping` AS `shipping`,`PurchaseReq`.`purchase_reqs`.`total_cost_pr` AS `total_cost_pr`,concat(_utf8'$',format(`PurchaseReq`.`purchase_reqs`.`total_cost_pr`,2)) AS `total_cost_pr_format`,`PurchaseReq`.`purchase_reqs`.`approved` AS `approved`,`PurchaseReq`.`purchase_reqs`.`reason` AS `reason`,`PurchaseReq`.`purchase_reqs`.`comments` AS `comments` from (((`PurchaseReq`.`purchase_reqs` join `PurchaseReq`.`users` on((`PurchaseReq`.`purchase_reqs`.`user_id` = `PurchaseReq`.`users`.`user_id`))) join `PurchaseReq`.`departments` on((`PurchaseReq`.`purchase_reqs`.`department_id` = `PurchaseReq`.`departments`.`department_id`))) join `PurchaseReq`.`vendors` on((`PurchaseReq`.`purchase_reqs`.`vendor_id` = `PurchaseReq`.`vendors`.`vendor_id`))));

-- --------------------------------------------------------

--
-- Structure for view `view_purchasing`
--
DROP TABLE IF EXISTS `view_purchasing`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `PurchaseReq`.`view_purchasing` AS select `PurchaseReq`.`line_items`.`line_item_id` AS `line_item_id`,`PurchaseReq`.`purchase_reqs`.`purchase_req_id` AS `purchase_req_id`,`PurchaseReq`.`purchase_reqs`.`purchase_req_name` AS `purchase_req_name`,`PurchaseReq`.`purchase_orders`.`purchase_order_id` AS `purchase_order_id`,`PurchaseReq`.`purchase_orders`.`purchase_order_name` AS `purchase_order_name`,`PurchaseReq`.`line_items`.`product_num` AS `product_num`,`PurchaseReq`.`line_items`.`quantity` AS `quantity`,`PurchaseReq`.`line_items`.`item_cost` AS `item_cost`,`PurchaseReq`.`line_items`.`total_cost` AS `total_cost`,`PurchaseReq`.`line_items`.`description` AS `description`,`PurchaseReq`.`users`.`user_id` AS `user_id`,`PurchaseReq`.`users`.`fullname` AS `user_name`,`PurchaseReq`.`departments`.`department_id` AS `department_id`,`PurchaseReq`.`departments`.`name` AS `department_name`,`PurchaseReq`.`vendors`.`vendor_id` AS `vendor_id`,`PurchaseReq`.`vendors`.`name` AS `vendor_name`,date_format(`PurchaseReq`.`purchase_reqs`.`date_req`,_latin1'%m/%d/%Y') AS `date_req`,`PurchaseReq`.`purchase_reqs`.`shipping` AS `shipping`,concat(_utf8'$',format(`PurchaseReq`.`purchase_reqs`.`total_cost_pr`,2)) AS `total_cost_pr`,`PurchaseReq`.`purchase_reqs`.`approved` AS `approved`,`PurchaseReq`.`purchase_reqs`.`reason` AS `reason`,`PurchaseReq`.`purchase_reqs`.`comments` AS `comments` from (((((`PurchaseReq`.`line_items` join `PurchaseReq`.`purchase_reqs`) left join `PurchaseReq`.`purchase_orders` on((`PurchaseReq`.`line_items`.`purchase_order_id` = `PurchaseReq`.`purchase_orders`.`purchase_order_id`))) join `PurchaseReq`.`users` on((`PurchaseReq`.`purchase_reqs`.`user_id` = `PurchaseReq`.`users`.`user_id`))) join `PurchaseReq`.`departments` on((`PurchaseReq`.`purchase_reqs`.`department_id` = `PurchaseReq`.`departments`.`department_id`))) join `PurchaseReq`.`vendors` on((`PurchaseReq`.`purchase_reqs`.`vendor_id` = `PurchaseReq`.`vendors`.`vendor_id`))) where (`PurchaseReq`.`line_items`.`purchase_req_id` = `PurchaseReq`.`purchase_reqs`.`purchase_req_id`);

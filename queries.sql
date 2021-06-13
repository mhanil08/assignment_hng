CREATE TABLE `USER_LOGIN` (
`USER_ID` int(20) NOT NULL AUTO_INCREMENT,
`USER_LOGIN_ID` varchar(250) COLLATE latin1_general_cs NOT NULL DEFAULT '',
`CURRENT_PASSWORD` varchar(64) COLLATE latin1_general_cs DEFAULT NULL,
`USER_MOBILE` varchar(10) COLLATE latin1_general_cs DEFAULT NULL,
`USER_AUTH_TOKEN` varchar(32) COLLATE latin1_general_cs DEFAULT NULL,
`USER_STATUS` varchar(20) COLLATE latin1_general_cs DEFAULT NULL,
`CREATED_STAMP` datetime DEFAULT CURRENT_TIMESTAMP,
`LAST_UPDATED_STAMP` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
PRIMARY KEY (`USER_ID`),
UNIQUE KEY `USER_LOGIN_ID` (`USER_LOGIN_ID`),
UNIQUE KEY `USER_MOBILE` (`USER_MOBILE`)
) ENGINE=InnoDB AUTO_INCREMENT=262169 DEFAULT CHARSET=latin1 COLLATE=latin1_general_cs;

--------------------------------------------------------------------------------------------

CREATE TABLE `HNG_PRODUCT_MASTER` (
`PRODUCT_ID` varchar(20) COLLATE latin1_general_cs NOT NULL,
`CATEGORY_ID` smallint(7) NOT NULL DEFAULT '-1',
`CATEGORY_NAME` varchar(63) COLLATE latin1_general_cs DEFAULT NULL,
`PARENT_CATEGORY_LINK` varchar(127) COLLATE latin1_general_cs DEFAULT NULL,
`BRAND_ID` smallint(7) NOT NULL DEFAULT '-1',
`BRAND_NAME` varchar(63) CHARACTER SET latin1 DEFAULT NULL,
`PRODUCT_TITLE` varchar(255) COLLATE latin1_general_cs DEFAULT NULL,
`CREATED_STAMP` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
`LAST_UPDATED_STAMP` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
`MRP_PRICE` float(7,2) DEFAULT '0.00',
`LIST_PRICE` float(7,2) DEFAULT '0.00',
PRIMARY KEY (`PRODUCT_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_general_cs;

-------------------------------------------------------------------------------------------------
CREATE TABLE `HNG_BASKET` (
`ID` int(11) NOT NULL AUTO_INCREMENT,
`USER_ID` int(20) DEFAULT NULL,
`NO_OF_ITEMS` smallint(2) DEFAULT '1',
`GRAND_TOTAL` float(7,2) DEFAULT '0.00',
`DELIVERY_CHARGE` float(7,2) DEFAULT '0.00',
`APPLIED_COUPON_CODE` varchar(64) COLLATE latin1_general_cs DEFAULT NULL,
`COUPON_AMOUNT` float(7,2) DEFAULT '0.00',
`LAST_UPDATED_STAMP` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
`CREATED_STAMP` datetime DEFAULT CURRENT_TIMESTAMP,
PRIMARY KEY (`ID`),
KEY `HNG_BASKET_FK1` (`USER_ID`),
CONSTRAINT `HNG_BASKET_FK1` FOREIGN KEY (`USER_ID`) REFERENCES `USER_LOGIN` (`USER_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_general_cs;
-----------------------------------------------------------------------------------------
CREATE TABLE `HNG_BASKET_ITEM` (
`BASKET_ID` int(11) NOT NULL,
`PRODUCT_ID` varchar(20) COLLATE latin1_general_cs NOT NULL,
`QUANTITY` smallint(2) DEFAULT '1',
`MRP_PRICE` float(7,2) DEFAULT '0.00',
`LIST_PRICE` float(7,2) DEFAULT '0.00',
`PRODUCT_NAME` varchar(255) COLLATE latin1_general_cs DEFAULT NULL,
`LAST_UPDATED_STAMP` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
`CREATED_STAMP` datetime DEFAULT CURRENT_TIMESTAMP,
PRIMARY KEY (`BASKET_ID`,`PRODUCT_ID`),
KEY `HNG_BASKET_ITEM_FK1` (`BASKET_ID`),
KEY `HNG_BASKET_ITEM_FK2` (`PRODUCT_ID`),
CONSTRAINT `HNG_BASKET_ITEM_FK1` FOREIGN KEY (`BASKET_ID`) REFERENCES `HNG_BASKET` (`ID`) ON DELETE
CASCADE,
CONSTRAINT `HNG_BASKET_ITEM_FK2` FOREIGN KEY (`PRODUCT_ID`) REFERENCES `HNG_PRODUCT_MASTER`
(`PRODUCT_ID`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_general_cs;
--------------------------------------------------------------------------------------------------

	Add user to USER_LOGIN table
-------------------------------------
insert into user_login (user_login_id, current_password,user_mobile, user_auth_token,user_status, created_stamp,last_updated_stamp)
values ('user1','thanks','8100012890','','VALID',CURRENT_TIMESTAMP(),CURRENT_TIMESTAMP())

//////////////////////////////////////

	Create product list
--------------------------------------
insert into hng_product_master (PRODUCT_ID,CATEGORY_ID,CATEGORY_NAME,PARENT_CATEGORY_LINK,BRAND_ID,BRAND_NAME,PRODUCT_TITLE,CREATED_STAMP,LAST_UPDATED_STAMP,MRP_PRICE,LIST_PRICE) VALUES ('HNG0001',1,'Moisturisers', 'Skin', 1, 'POND\'S ', 'POND\'S Super Light Gel Oil Free Moisturiser 147gm ', CURRENT_TIMESTAMP(), CURRENT_TIMESTAMP(), 299,224);
insert into hng_product_master (PRODUCT_ID,CATEGORY_ID,CATEGORY_NAME,PARENT_CATEGORY_LINK,BRAND_ID,BRAND_NAME,PRODUCT_TITLE,CREATED_STAMP,LAST_UPDATED_STAMP,MRP_PRICE,LIST_PRICE) VALUES ('HNG0002',2,'Handwash', 'Wash & Cleaners', 2, 'Skin Cottage', 'Skin Cottage Handwash Lemon Extract 500ml', CURRENT_TIMESTAMP(), CURRENT_TIMESTAMP(), 225,158);
insert into hng_product_master (PRODUCT_ID,CATEGORY_ID,CATEGORY_NAME,PARENT_CATEGORY_LINK,BRAND_ID,BRAND_NAME,PRODUCT_TITLE,CREATED_STAMP,LAST_UPDATED_STAMP,MRP_PRICE,LIST_PRICE) VALUES ('HNG0003',3,'Face Mask', 'Protection Gear', 3, 'Silverpro', 'Silverpro Anti-Viral & Anti-Bacterial Reusable Face Mask With 4-Ply Organic Cotton Medium Pack Of 3', CURRENT_TIMESTAMP(), CURRENT_TIMESTAMP(), 999,699);
insert into hng_product_master (PRODUCT_ID,CATEGORY_ID,CATEGORY_NAME,PARENT_CATEGORY_LINK,BRAND_ID,BRAND_NAME,PRODUCT_TITLE,CREATED_STAMP,LAST_UPDATED_STAMP,MRP_PRICE,LIST_PRICE) VALUES ('HNG0004',4,'Lipstick', 'Makeup', 4, 'Maybelline', 'Maybelline New York Superstay Matte Ink Liquid Lip Colour Ruler 80 5ml', CURRENT_TIMESTAMP(), CURRENT_TIMESTAMP(), 650,520);
insert into hng_product_master (PRODUCT_ID,CATEGORY_ID,CATEGORY_NAME,PARENT_CATEGORY_LINK,BRAND_ID,BRAND_NAME,PRODUCT_TITLE,CREATED_STAMP,LAST_UPDATED_STAMP,MRP_PRICE,LIST_PRICE) VALUES ('HNG0005',5,'Shower Gel', 'Bath', 5, 'Fruiser', 'Fruiser Moisturising Shower Gel Cherry Vanilla 800ml', CURRENT_TIMESTAMP(), CURRENT_TIMESTAMP(), 399,319);
insert into hng_product_master (PRODUCT_ID,CATEGORY_ID,CATEGORY_NAME,PARENT_CATEGORY_LINK,BRAND_ID,BRAND_NAME,PRODUCT_TITLE,CREATED_STAMP,LAST_UPDATED_STAMP,MRP_PRICE,LIST_PRICE) VALUES ('HNG0006',6,'Perfumes', 'Fragrance', 6, 'Skinn By Titan', 'Skinn By Titan Sheer Eau De Parfum For Women 20ml', CURRENT_TIMESTAMP(), CURRENT_TIMESTAMP(), 595,595);
insert into hng_product_master (PRODUCT_ID,CATEGORY_ID,CATEGORY_NAME,PARENT_CATEGORY_LINK,BRAND_ID,BRAND_NAME,PRODUCT_TITLE,CREATED_STAMP,LAST_UPDATED_STAMP,MRP_PRICE,LIST_PRICE) VALUES ('HNG0007',7,'Deodorants', 'Fragrance', 7, 'Nivea', 'Nivea Fresh Flower Deodorant 150ml', CURRENT_TIMESTAMP(), CURRENT_TIMESTAMP(), 199,199);
insert into hng_product_master (PRODUCT_ID,CATEGORY_ID,CATEGORY_NAME,PARENT_CATEGORY_LINK,BRAND_ID,BRAND_NAME,PRODUCT_TITLE,CREATED_STAMP,LAST_UPDATED_STAMP,MRP_PRICE,LIST_PRICE) VALUES ('HNG0008',8,'Soaps', 'Bath', 8, 'Fuschia', 'Fuschia Natural Handmade Glycerine Soap, Aloe Vera 100gm', CURRENT_TIMESTAMP(), CURRENT_TIMESTAMP(), 250,225);
/////////////////////////////////////////////////////////////////////////////////////////////////


	Create bucket
-----------------------
SELECT USER_ID into @UID FROM USER_LOGIN where USER_LOGIN_ID='user1';
INSERT INTO hng_basket(ID,USER_ID,No_OF_ITEMS,GRAND_TOTAL,DELIVERY_CHARGE,APPLIED_COUPON_CODE,COUPON_AMOUNT,LAST_UPDATED_STAMP,CREATED_STAMP)
VALUES (1, @UID,0,0,0,'',0,CURRENT_TIMESTAMP(),CURRENT_TIMESTAMP());

///////////////////////////////////////////////////////////////////

	Add Item into bucket
-----------------------------
SELECT ID into @ID FROM hng_basket WHERE USER_ID='add user id';
SELECT * FROM hng_product_master as p WHERE p.PRODUCT_ID='add product id';
INSERT INTO hng_basket_item (BASKET_ID,PRODUCT_ID,QUANTITY,MRP_PRICE,LIST_PRICE,PRODUCT_NAME,LAST_UPDATED_STAMP,CREATED_STAMP) 
VALUES (@ID, p.PRODUCT_ID,1,p.MRP_PRICE,p.LIST_PRICE,p.PRODUCT_TITLE,CURRENT_TIMESTAMP(),CURRENT_TIMESTAMP());

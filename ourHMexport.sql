--------------------------------------------------------
--  파일이 생성됨 - 금요일-10월-21-2022   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Sequence BBS_SEQ
--------------------------------------------------------

   CREATE SEQUENCE  "OURHM"."BBS_SEQ"  MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 11 NOCACHE  NOORDER  NOCYCLE ;
--------------------------------------------------------
--  DDL for Sequence CART_NO_SEQ
--------------------------------------------------------

   CREATE SEQUENCE  "OURHM"."CART_NO_SEQ"  MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 21 CACHE 20 NOORDER  NOCYCLE ;
--------------------------------------------------------
--  DDL for Sequence CATEGORY_SEQ
--------------------------------------------------------

   CREATE SEQUENCE  "OURHM"."CATEGORY_SEQ"  MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 21 CACHE 20 NOORDER  NOCYCLE ;
--------------------------------------------------------
--  DDL for Sequence COMMENT_SEQ
--------------------------------------------------------

   CREATE SEQUENCE  "OURHM"."COMMENT_SEQ"  MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 4 NOCACHE  NOORDER  NOCYCLE ;
--------------------------------------------------------
--  DDL for Sequence LIKE_NO_SEQ
--------------------------------------------------------

   CREATE SEQUENCE  "OURHM"."LIKE_NO_SEQ"  MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 21 CACHE 20 NOORDER  NOCYCLE ;
--------------------------------------------------------
--  DDL for Sequence NO_VAL
--------------------------------------------------------

   CREATE SEQUENCE  "OURHM"."NO_VAL"  MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 161 CACHE 20 NOORDER  NOCYCLE ;
--------------------------------------------------------
--  DDL for Sequence ORDER_DETAIL_KEY_SEQ
--------------------------------------------------------

   CREATE SEQUENCE  "OURHM"."ORDER_DETAIL_KEY_SEQ"  MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 1 CACHE 20 NOORDER  NOCYCLE ;
--------------------------------------------------------
--  DDL for Sequence ORDER_NO_SEQ
--------------------------------------------------------

   CREATE SEQUENCE  "OURHM"."ORDER_NO_SEQ"  MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 1 CACHE 20 NOORDER  NOCYCLE ;
--------------------------------------------------------
--  DDL for Sequence PRODUCTNO_SEQ
--------------------------------------------------------

   CREATE SEQUENCE  "OURHM"."PRODUCTNO_SEQ"  MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 41 CACHE 20 NOORDER  NOCYCLE ;
--------------------------------------------------------
--  DDL for Sequence PRODUCT_OPTION_SEQ
--------------------------------------------------------

   CREATE SEQUENCE  "OURHM"."PRODUCT_OPTION_SEQ"  MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 21 CACHE 20 NOORDER  NOCYCLE ;
--------------------------------------------------------
--  DDL for Sequence QNA_NO_SEQ
--------------------------------------------------------

   CREATE SEQUENCE  "OURHM"."QNA_NO_SEQ"  MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 21 CACHE 20 NOORDER  NOCYCLE ;
--------------------------------------------------------
--  DDL for Sequence REVIEW_NO_SEQ
--------------------------------------------------------

   CREATE SEQUENCE  "OURHM"."REVIEW_NO_SEQ"  MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 21 CACHE 20 NOORDER  NOCYCLE ;
--------------------------------------------------------
--  DDL for Sequence USER_NO_SEQ
--------------------------------------------------------

   CREATE SEQUENCE  "OURHM"."USER_NO_SEQ"  MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 1 CACHE 20 NOORDER  NOCYCLE ;
--------------------------------------------------------
--  DDL for Table BBS
--------------------------------------------------------

  CREATE TABLE "OURHM"."BBS" 
   (	"BBS_IDX" NUMBER(6,0), 
	"SUBJECT" VARCHAR2(150 BYTE), 
	"WRITER" VARCHAR2(30 BYTE), 
	"CONTENT" VARCHAR2(4000 BYTE), 
	"FILE_NAME" VARCHAR2(100 BYTE), 
	"ORI_NAME" VARCHAR2(100 BYTE), 
	"PWD" VARCHAR2(20 BYTE), 
	"WRITE_DATE" DATE DEFAULT SYSDATE, 
	"IP" VARCHAR2(15 BYTE), 
	"HIT" NUMBER(5,0)
   ) ;
--------------------------------------------------------
--  DDL for Table CART
--------------------------------------------------------

  CREATE TABLE "OURHM"."CART" 
   (	"CART_NO" NUMBER, 
	"OPTION_NO" NUMBER, 
	"USER_ID" VARCHAR2(30 BYTE), 
	"QTY" NUMBER
   ) ;
--------------------------------------------------------
--  DDL for Table CATEGORY
--------------------------------------------------------

  CREATE TABLE "OURHM"."CATEGORY" 
   (	"CATEGORY_NO" NUMBER, 
	"CATEGORY_NAME" VARCHAR2(20 BYTE)
   ) ;
--------------------------------------------------------
--  DDL for Table COMMENTS
--------------------------------------------------------

  CREATE TABLE "OURHM"."COMMENTS" 
   (	"COMMENT_IDX" NUMBER(6,0), 
	"WRITER" VARCHAR2(30 BYTE), 
	"CONTENT" VARCHAR2(4000 BYTE), 
	"PWD" VARCHAR2(20 BYTE), 
	"WRITE_DATE" DATE DEFAULT SYSDATE, 
	"IP" VARCHAR2(15 BYTE), 
	"BBS_IDX" NUMBER(6,0)
   ) ;
--------------------------------------------------------
--  DDL for Table DELADDR
--------------------------------------------------------

  CREATE TABLE "OURHM"."DELADDR" 
   (	"DEL_NO" NUMBER, 
	"DEL_NAME" VARCHAR2(30 BYTE), 
	"DEL_GETTER" VARCHAR2(30 BYTE), 
	"DEL_PHONE" VARCHAR2(30 BYTE), 
	"DEL_ADDR" VARCHAR2(30 BYTE), 
	"USER_NO" NUMBER
   ) ;
--------------------------------------------------------
--  DDL for Table LIKE_PRODUCT
--------------------------------------------------------

  CREATE TABLE "OURHM"."LIKE_PRODUCT" 
   (	"LIKE_NO" NUMBER, 
	"PRODUCT_NO" NUMBER, 
	"USER_ID" VARCHAR2(30 BYTE), 
	"LDATE" DATE DEFAULT SYSDATE
   ) ;
--------------------------------------------------------
--  DDL for Table ORDER_DETAIL
--------------------------------------------------------

  CREATE TABLE "OURHM"."ORDER_DETAIL" 
   (	"ORDER_DETAIL_KEY" VARCHAR2(30 BYTE), 
	"ORDER_NO" NUMBER(10,0), 
	"PRODUCT_NUMBER" NUMBER(30,0), 
	"AMOUNT" NUMBER, 
	"TOTAL_PRICE" NUMBER, 
	"ORDER_STATUS" VARCHAR2(20 BYTE), 
	"ORDER_DATE" VARCHAR2(20 BYTE)
   ) ;
--------------------------------------------------------
--  DDL for Table ORDER_MAIN
--------------------------------------------------------

  CREATE TABLE "OURHM"."ORDER_MAIN" 
   (	"ORDER_NO" NUMBER(10,0), 
	"USER_ID" VARCHAR2(30 BYTE)
   ) ;
--------------------------------------------------------
--  DDL for Table PRODUCT
--------------------------------------------------------

  CREATE TABLE "OURHM"."PRODUCT" 
   (	"PRODUCT_NO" NUMBER, 
	"PRODUCT_NAME" VARCHAR2(300 BYTE), 
	"PRICE" NUMBER, 
	"CATEGORY_NO" NUMBER, 
	"THUMNAIL" VARCHAR2(30 BYTE), 
	"ORIGINAL_IMG" VARCHAR2(30 BYTE), 
	"RATE" NUMBER, 
	"CONTENT" VARCHAR2(3000 BYTE)
   ) ;
--------------------------------------------------------
--  DDL for Table PRODUCT_OPTION
--------------------------------------------------------

  CREATE TABLE "OURHM"."PRODUCT_OPTION" 
   (	"OPTION_NO" NUMBER, 
	"PRODUCT_NO" NUMBER, 
	"OPTION_SIZE" VARCHAR2(10 BYTE), 
	"OPTION_COUNT" NUMBER(10,0)
   ) ;
--------------------------------------------------------
--  DDL for Table QA
--------------------------------------------------------

  CREATE TABLE "OURHM"."QA" 
   (	"QNA_NO" NUMBER(20,0), 
	"TITLE" VARCHAR2(20 BYTE), 
	"CONTENT" VARCHAR2(2000 BYTE), 
	"USER_ID" VARCHAR2(20 BYTE), 
	"USER_NAME" VARCHAR2(20 BYTE), 
	"WDATE" DATE DEFAULT SYSDATE
   ) ;
--------------------------------------------------------
--  DDL for Table REVIEW
--------------------------------------------------------

  CREATE TABLE "OURHM"."REVIEW" 
   (	"REVIEW_NO" NUMBER(20,0), 
	"TITLE" VARCHAR2(20 BYTE), 
	"CONTENT" VARCHAR2(200 BYTE), 
	"USER_ID" VARCHAR2(20 BYTE), 
	"USER_NAME" VARCHAR2(20 BYTE), 
	"WDATE" DATE DEFAULT SYSDATE, 
	"PRODUCT_NO" NUMBER, 
	"HIT" NUMBER
   ) ;
--------------------------------------------------------
--  DDL for Table USERS
--------------------------------------------------------

  CREATE TABLE "OURHM"."USERS" 
   (	"USER_NO" NUMBER, 
	"USER_ID" VARCHAR2(30 BYTE), 
	"PWD" VARCHAR2(30 BYTE), 
	"NAME" VARCHAR2(30 BYTE), 
	"PHONE" VARCHAR2(30 BYTE), 
	"EMAIL" VARCHAR2(30 BYTE), 
	"ADDRESS" VARCHAR2(30 BYTE), 
	"DEL_NO" NUMBER
   ) ;
REM INSERTING into OURHM.BBS
SET DEFINE OFF;
Insert into OURHM.BBS (BBS_IDX,SUBJECT,WRITER,CONTENT,FILE_NAME,ORI_NAME,PWD,WRITE_DATE,IP,HIT) values (1,'테스트1','테스터','테스트1-내용',null,null,'1234',to_date('2022/10/19','YYYY/MM/DD'),'127.0.0.1',0);
Insert into OURHM.BBS (BBS_IDX,SUBJECT,WRITER,CONTENT,FILE_NAME,ORI_NAME,PWD,WRITE_DATE,IP,HIT) values (2,'테스트2','테스터','테스트2-내용',null,null,'1234',to_date('2022/10/19','YYYY/MM/DD'),'127.0.0.1',0);
Insert into OURHM.BBS (BBS_IDX,SUBJECT,WRITER,CONTENT,FILE_NAME,ORI_NAME,PWD,WRITE_DATE,IP,HIT) values (3,'테스트3','테스터','테스트3-내용',null,null,'1234',to_date('2022/10/19','YYYY/MM/DD'),'127.0.0.1',0);
Insert into OURHM.BBS (BBS_IDX,SUBJECT,WRITER,CONTENT,FILE_NAME,ORI_NAME,PWD,WRITE_DATE,IP,HIT) values (4,'테스트4','테스터','테스트4-내용',null,null,'1234',to_date('2022/10/19','YYYY/MM/DD'),'127.0.0.1',0);
Insert into OURHM.BBS (BBS_IDX,SUBJECT,WRITER,CONTENT,FILE_NAME,ORI_NAME,PWD,WRITE_DATE,IP,HIT) values (5,'테스트5','테스터','테스트5-내용',null,null,'1234',to_date('2022/10/19','YYYY/MM/DD'),'127.0.0.1',0);
Insert into OURHM.BBS (BBS_IDX,SUBJECT,WRITER,CONTENT,FILE_NAME,ORI_NAME,PWD,WRITE_DATE,IP,HIT) values (6,'테스트6','테스터','테스트6-내용',null,null,'1234',to_date('2022/10/19','YYYY/MM/DD'),'127.0.0.1',0);
Insert into OURHM.BBS (BBS_IDX,SUBJECT,WRITER,CONTENT,FILE_NAME,ORI_NAME,PWD,WRITE_DATE,IP,HIT) values (7,'테스트7','테스터','테스트7-내용',null,null,'1234',to_date('2022/10/19','YYYY/MM/DD'),'127.0.0.1',0);
Insert into OURHM.BBS (BBS_IDX,SUBJECT,WRITER,CONTENT,FILE_NAME,ORI_NAME,PWD,WRITE_DATE,IP,HIT) values (8,'테스트8','테스터','테스트8-내용',null,null,'1234',to_date('2022/10/19','YYYY/MM/DD'),'127.0.0.1',0);
Insert into OURHM.BBS (BBS_IDX,SUBJECT,WRITER,CONTENT,FILE_NAME,ORI_NAME,PWD,WRITE_DATE,IP,HIT) values (9,'테스트9','테스터','테스트9-내용',null,null,'1234',to_date('2022/10/19','YYYY/MM/DD'),'127.0.0.1',0);
Insert into OURHM.BBS (BBS_IDX,SUBJECT,WRITER,CONTENT,FILE_NAME,ORI_NAME,PWD,WRITE_DATE,IP,HIT) values (10,'테스트10','테스터','테스트10-내용',null,null,'1234',to_date('2022/10/19','YYYY/MM/DD'),'127.0.0.1',0);
REM INSERTING into OURHM.CART
SET DEFINE OFF;
Insert into OURHM.CART (CART_NO,OPTION_NO,USER_ID,QTY) values (1,1,'ff',3);
Insert into OURHM.CART (CART_NO,OPTION_NO,USER_ID,QTY) values (2,1,'ff',1);
Insert into OURHM.CART (CART_NO,OPTION_NO,USER_ID,QTY) values (3,3,'ff',100);
Insert into OURHM.CART (CART_NO,OPTION_NO,USER_ID,QTY) values (4,null,'ff',null);
Insert into OURHM.CART (CART_NO,OPTION_NO,USER_ID,QTY) values (5,null,'ff',1);
REM INSERTING into OURHM.CATEGORY
SET DEFINE OFF;
Insert into OURHM.CATEGORY (CATEGORY_NO,CATEGORY_NAME) values (2,'NEW');
Insert into OURHM.CATEGORY (CATEGORY_NO,CATEGORY_NAME) values (1,'BESTITEM');
REM INSERTING into OURHM.COMMENTS
SET DEFINE OFF;
Insert into OURHM.COMMENTS (COMMENT_IDX,WRITER,CONTENT,PWD,WRITE_DATE,IP,BBS_IDX) values (1,'C테스터','C-내용1','1234',to_date('2022/10/19','YYYY/MM/DD'),'127.0.0.1',10);
Insert into OURHM.COMMENTS (COMMENT_IDX,WRITER,CONTENT,PWD,WRITE_DATE,IP,BBS_IDX) values (2,'C테스터','C-내용2','1234',to_date('2022/10/19','YYYY/MM/DD'),'127.0.0.1',10);
Insert into OURHM.COMMENTS (COMMENT_IDX,WRITER,CONTENT,PWD,WRITE_DATE,IP,BBS_IDX) values (3,'C테스터','C-내용3','1234',to_date('2022/10/19','YYYY/MM/DD'),'127.0.0.1',10);
REM INSERTING into OURHM.DELADDR
SET DEFINE OFF;
REM INSERTING into OURHM.LIKE_PRODUCT
SET DEFINE OFF;
Insert into OURHM.LIKE_PRODUCT (LIKE_NO,PRODUCT_NO,USER_ID,LDATE) values (3,3,'ff',to_date('2022/10/21','YYYY/MM/DD'));
Insert into OURHM.LIKE_PRODUCT (LIKE_NO,PRODUCT_NO,USER_ID,LDATE) values (4,1,'ff',to_date('2022/10/21','YYYY/MM/DD'));
Insert into OURHM.LIKE_PRODUCT (LIKE_NO,PRODUCT_NO,USER_ID,LDATE) values (5,1,'ff',to_date('2022/10/21','YYYY/MM/DD'));
Insert into OURHM.LIKE_PRODUCT (LIKE_NO,PRODUCT_NO,USER_ID,LDATE) values (6,28,'ff',to_date('2022/10/21','YYYY/MM/DD'));
REM INSERTING into OURHM.ORDER_DETAIL
SET DEFINE OFF;
REM INSERTING into OURHM.ORDER_MAIN
SET DEFINE OFF;
REM INSERTING into OURHM.PRODUCT
SET DEFINE OFF;
Insert into OURHM.PRODUCT (PRODUCT_NO,PRODUCT_NAME,PRICE,CATEGORY_NO,THUMNAIL,ORIGINAL_IMG,RATE,CONTENT) values (3,'[뉴진스 다니엘 SET] CROP SHERPA FLEECE JACKET&TUCK WIDE DENIM PANTS',263000,1,'product_2.jpg','product_2.jpg',null,null);
Insert into OURHM.PRODUCT (PRODUCT_NO,PRODUCT_NAME,PRICE,CATEGORY_NO,THUMNAIL,ORIGINAL_IMG,RATE,CONTENT) values (4,'[뉴진스 해린 SET] CROP VARSITY JACKET&PLAID PLEATS MINI SKIRT',377000,1,'product_3.jpg','product_3.jpg',null,null);
Insert into OURHM.PRODUCT (PRODUCT_NO,PRODUCT_NAME,PRICE,CATEGORY_NO,THUMNAIL,ORIGINAL_IMG,RATE,CONTENT) values (1,'멜루드 1+1 무지티',30000,1,'product_0.jpg','product_0.jpg',null,null);
Insert into OURHM.PRODUCT (PRODUCT_NO,PRODUCT_NAME,PRICE,CATEGORY_NO,THUMNAIL,ORIGINAL_IMG,RATE,CONTENT) values (2,'[뉴진스 혜인 SET] BOUCLE SHORT PADDING&BASIC PLEATED MINI SKIRT',337000,1,'product_1.jpg','product_1.jpg',null,null);
Insert into OURHM.PRODUCT (PRODUCT_NO,PRODUCT_NAME,PRICE,CATEGORY_NO,THUMNAIL,ORIGINAL_IMG,RATE,CONTENT) values (5,'[뉴진스 민지 SET] WAVE LOGO CORDUROY JACKET&WOOL CHECK MINI SKIRT',358000,1,'product_4.jpg','product_4.jpg',null,null);
Insert into OURHM.PRODUCT (PRODUCT_NO,PRODUCT_NAME,PRICE,CATEGORY_NO,THUMNAIL,ORIGINAL_IMG,RATE,CONTENT) values (6,'[뉴진스 민지 SET] SIGNATURE SWEATSHIRTS&A DAY OF US SWEATPANTS',148000,1,'product_5.jpg','product_5.jpg',null,null);
Insert into OURHM.PRODUCT (PRODUCT_NO,PRODUCT_NAME,PRICE,CATEGORY_NO,THUMNAIL,ORIGINAL_IMG,RATE,CONTENT) values (7,'[뉴진스 하니 SET] SIGNATURE HOODIE&A DAY OF US SWEATPANTS',168000,1,'product_6.jpg','product_6.jpg',null,null);
Insert into OURHM.PRODUCT (PRODUCT_NO,PRODUCT_NAME,PRICE,CATEGORY_NO,THUMNAIL,ORIGINAL_IMG,RATE,CONTENT) values (8,'[뉴진스 해린 SET] SIGNATURE SWEATSHIRTS&FIVETWO STAMP KNIT PANTS',188000,1,'product_7.jpg','product_7.jpg',null,null);
Insert into OURHM.PRODUCT (PRODUCT_NO,PRODUCT_NAME,PRICE,CATEGORY_NO,THUMNAIL,ORIGINAL_IMG,RATE,CONTENT) values (9,'[뉴진스 다니엘 SET] SIGNATURE SWEATSHIRTS&A DAY OF US SWEATPANTS',148000,1,'product_8.jpg','product_8.jpg',null,null);
Insert into OURHM.PRODUCT (PRODUCT_NO,PRODUCT_NAME,PRICE,CATEGORY_NO,THUMNAIL,ORIGINAL_IMG,RATE,CONTENT) values (10,'[뉴진스 혜인 SET] SIGNATURE HOODIE&FIVETWO STAMP KNIT PANTS',208000,1,'product_9.jpg','product_9.jpg',null,null);
Insert into OURHM.PRODUCT (PRODUCT_NO,PRODUCT_NAME,PRICE,CATEGORY_NO,THUMNAIL,ORIGINAL_IMG,RATE,CONTENT) values (11,'[뉴진스 혜인 SET] SIGNATURE HOODIE&FIVETWO STAMP KNIT PANTS',208000,1,'product_10.jpg','product_10.jpg',null,null);
Insert into OURHM.PRODUCT (PRODUCT_NO,PRODUCT_NAME,PRICE,CATEGORY_NO,THUMNAIL,ORIGINAL_IMG,RATE,CONTENT) values (12,'LEATHER DOWN PUFFER JACKET',328000,1,'product_11.jpg','product_11.jpg',null,null);
Insert into OURHM.PRODUCT (PRODUCT_NO,PRODUCT_NAME,PRICE,CATEGORY_NO,THUMNAIL,ORIGINAL_IMG,RATE,CONTENT) values (13,'[뉴진스 혜인 SET] BOUCLE SHORT PADDING&BASIC PLEATED MINI SKIRT',337000,1,'product_1.jpg','product_1.jpg',null,null);
Insert into OURHM.PRODUCT (PRODUCT_NO,PRODUCT_NAME,PRICE,CATEGORY_NO,THUMNAIL,ORIGINAL_IMG,RATE,CONTENT) values (14,'[뉴진스 다니엘 SET] CROP SHERPA FLEECE JACKET&TUCK WIDE DENIM PANTS',263000,1,'product_2.jpg','product_2.jpg',null,null);
Insert into OURHM.PRODUCT (PRODUCT_NO,PRODUCT_NAME,PRICE,CATEGORY_NO,THUMNAIL,ORIGINAL_IMG,RATE,CONTENT) values (15,'[뉴진스 해린 SET] CROP VARSITY JACKET&PLAID PLEATS MINI SKIRT',377000,1,'product_3.jpg','product_3.jpg',null,null);
Insert into OURHM.PRODUCT (PRODUCT_NO,PRODUCT_NAME,PRICE,CATEGORY_NO,THUMNAIL,ORIGINAL_IMG,RATE,CONTENT) values (16,'[뉴진스 민지 SET] WAVE LOGO CORDUROY JACKET&WOOL CHECK MINI SKIRT',358000,1,'product_4.jpg','product_4.jpg',null,null);
Insert into OURHM.PRODUCT (PRODUCT_NO,PRODUCT_NAME,PRICE,CATEGORY_NO,THUMNAIL,ORIGINAL_IMG,RATE,CONTENT) values (17,'[뉴진스 민지 SET] SIGNATURE SWEATSHIRTS&A DAY OF US SWEATPANTS',148000,1,'product_5.jpg','product_5.jpg',null,null);
Insert into OURHM.PRODUCT (PRODUCT_NO,PRODUCT_NAME,PRICE,CATEGORY_NO,THUMNAIL,ORIGINAL_IMG,RATE,CONTENT) values (18,'[뉴진스 하니 SET] SIGNATURE HOODIE&A DAY OF US SWEATPANTS',168000,1,'product_6.jpg','product_6.jpg',null,null);
Insert into OURHM.PRODUCT (PRODUCT_NO,PRODUCT_NAME,PRICE,CATEGORY_NO,THUMNAIL,ORIGINAL_IMG,RATE,CONTENT) values (19,'[뉴진스 해린 SET] SIGNATURE SWEATSHIRTS&FIVETWO STAMP KNIT PANTS',188000,1,'product_7.jpg','product_7.jpg',null,null);
Insert into OURHM.PRODUCT (PRODUCT_NO,PRODUCT_NAME,PRICE,CATEGORY_NO,THUMNAIL,ORIGINAL_IMG,RATE,CONTENT) values (20,'[뉴진스 다니엘 SET] SIGNATURE SWEATSHIRTS&A DAY OF US SWEATPANTS',148000,1,'product_8.jpg','product_8.jpg',null,null);
Insert into OURHM.PRODUCT (PRODUCT_NO,PRODUCT_NAME,PRICE,CATEGORY_NO,THUMNAIL,ORIGINAL_IMG,RATE,CONTENT) values (21,'[뉴진스 혜인 SET] SIGNATURE HOODIE&FIVETWO STAMP KNIT PANTS',208000,1,'product_9.jpg','product_9.jpg',null,null);
Insert into OURHM.PRODUCT (PRODUCT_NO,PRODUCT_NAME,PRICE,CATEGORY_NO,THUMNAIL,ORIGINAL_IMG,RATE,CONTENT) values (22,'[뉴진스 혜인 SET] SIGNATURE HOODIE&FIVETWO STAMP KNIT PANTS',208000,1,'product_10.jpg','product_10.jpg',null,null);
Insert into OURHM.PRODUCT (PRODUCT_NO,PRODUCT_NAME,PRICE,CATEGORY_NO,THUMNAIL,ORIGINAL_IMG,RATE,CONTENT) values (23,'LEATHER DOWN PUFFER JACKET',328000,1,'product_11.jpg','product_11.jpg',null,null);
Insert into OURHM.PRODUCT (PRODUCT_NO,PRODUCT_NAME,PRICE,CATEGORY_NO,THUMNAIL,ORIGINAL_IMG,RATE,CONTENT) values (24,'[뉴진스 다니엘 SET] CROP SHERPA FLEECE JACKET&TUCK WIDE DENIM PANTS',263000,1,'product_2.jpg','product_2.jpg',null,null);
Insert into OURHM.PRODUCT (PRODUCT_NO,PRODUCT_NAME,PRICE,CATEGORY_NO,THUMNAIL,ORIGINAL_IMG,RATE,CONTENT) values (25,'[뉴진스 해린 SET] CROP VARSITY JACKET&PLAID PLEATS MINI SKIRT',377000,1,'product_3.jpg','product_3.jpg',null,null);
Insert into OURHM.PRODUCT (PRODUCT_NO,PRODUCT_NAME,PRICE,CATEGORY_NO,THUMNAIL,ORIGINAL_IMG,RATE,CONTENT) values (26,'[뉴진스 민지 SET] WAVE LOGO CORDUROY JACKET&WOOL CHECK MINI SKIRT',358000,1,'product_4.jpg','product_4.jpg',null,null);
Insert into OURHM.PRODUCT (PRODUCT_NO,PRODUCT_NAME,PRICE,CATEGORY_NO,THUMNAIL,ORIGINAL_IMG,RATE,CONTENT) values (27,'[뉴진스 민지 SET] SIGNATURE SWEATSHIRTS&A DAY OF US SWEATPANTS',148000,1,'product_5.jpg','product_5.jpg',null,null);
Insert into OURHM.PRODUCT (PRODUCT_NO,PRODUCT_NAME,PRICE,CATEGORY_NO,THUMNAIL,ORIGINAL_IMG,RATE,CONTENT) values (28,'[뉴진스 하니 SET] SIGNATURE HOODIE&A DAY OF US SWEATPANTS',168000,1,'product_6.jpg','product_6.jpg',null,null);
Insert into OURHM.PRODUCT (PRODUCT_NO,PRODUCT_NAME,PRICE,CATEGORY_NO,THUMNAIL,ORIGINAL_IMG,RATE,CONTENT) values (29,'[뉴진스 해린 SET] SIGNATURE SWEATSHIRTS&FIVETWO STAMP KNIT PANTS',188000,1,'product_7.jpg','product_7.jpg',null,null);
Insert into OURHM.PRODUCT (PRODUCT_NO,PRODUCT_NAME,PRICE,CATEGORY_NO,THUMNAIL,ORIGINAL_IMG,RATE,CONTENT) values (30,'[뉴진스 다니엘 SET] SIGNATURE SWEATSHIRTS&A DAY OF US SWEATPANTS',148000,1,'product_8.jpg','product_8.jpg',null,null);
Insert into OURHM.PRODUCT (PRODUCT_NO,PRODUCT_NAME,PRICE,CATEGORY_NO,THUMNAIL,ORIGINAL_IMG,RATE,CONTENT) values (31,'[뉴진스 혜인 SET] SIGNATURE HOODIE&FIVETWO STAMP KNIT PANTS',208000,1,'product_9.jpg','product_9.jpg',null,null);
Insert into OURHM.PRODUCT (PRODUCT_NO,PRODUCT_NAME,PRICE,CATEGORY_NO,THUMNAIL,ORIGINAL_IMG,RATE,CONTENT) values (32,'[뉴진스 혜인 SET] SIGNATURE HOODIE&FIVETWO STAMP KNIT PANTS',208000,1,'product_10.jpg','product_10.jpg',null,null);
Insert into OURHM.PRODUCT (PRODUCT_NO,PRODUCT_NAME,PRICE,CATEGORY_NO,THUMNAIL,ORIGINAL_IMG,RATE,CONTENT) values (33,'LEATHER DOWN PUFFER JACKET',328000,1,'product_11.jpg','product_11.jpg',null,null);
Insert into OURHM.PRODUCT (PRODUCT_NO,PRODUCT_NAME,PRICE,CATEGORY_NO,THUMNAIL,ORIGINAL_IMG,RATE,CONTENT) values (34,'TESTER',199900,1,'product_11.jpg','product_11.jpg',null,'테스트용 상세페이지');
REM INSERTING into OURHM.PRODUCT_OPTION
SET DEFINE OFF;
Insert into OURHM.PRODUCT_OPTION (OPTION_NO,PRODUCT_NO,OPTION_SIZE,OPTION_COUNT) values (1,1,'S',70);
Insert into OURHM.PRODUCT_OPTION (OPTION_NO,PRODUCT_NO,OPTION_SIZE,OPTION_COUNT) values (2,1,'M',70);
Insert into OURHM.PRODUCT_OPTION (OPTION_NO,PRODUCT_NO,OPTION_SIZE,OPTION_COUNT) values (3,2,'L',70);
REM INSERTING into OURHM.QA
SET DEFINE OFF;
Insert into OURHM.QA (QNA_NO,TITLE,CONTENT,USER_ID,USER_NAME,WDATE) values (3,'test','test','test','test',to_date('2022/10/20','YYYY/MM/DD'));
Insert into OURHM.QA (QNA_NO,TITLE,CONTENT,USER_ID,USER_NAME,WDATE) values (2,'2','2','2','2',to_date('2022/10/20','YYYY/MM/DD'));
Insert into OURHM.QA (QNA_NO,TITLE,CONTENT,USER_ID,USER_NAME,WDATE) values (1,'테스트2','테스터','테스트2-내용','2',to_date('2022/10/20','YYYY/MM/DD'));
Insert into OURHM.QA (QNA_NO,TITLE,CONTENT,USER_ID,USER_NAME,WDATE) values (4,'테스트2','테스터','테스트2-내용','2',to_date('2022/10/20','YYYY/MM/DD'));
Insert into OURHM.QA (QNA_NO,TITLE,CONTENT,USER_ID,USER_NAME,WDATE) values (6,null,null,null,null,to_date('2022/10/21','YYYY/MM/DD'));
Insert into OURHM.QA (QNA_NO,TITLE,CONTENT,USER_ID,USER_NAME,WDATE) values (7,null,null,null,null,to_date('2022/10/21','YYYY/MM/DD'));
Insert into OURHM.QA (QNA_NO,TITLE,CONTENT,USER_ID,USER_NAME,WDATE) values (8,null,null,null,null,to_date('2022/10/21','YYYY/MM/DD'));
Insert into OURHM.QA (QNA_NO,TITLE,CONTENT,USER_ID,USER_NAME,WDATE) values (9,null,null,null,null,to_date('2022/10/21','YYYY/MM/DD'));
Insert into OURHM.QA (QNA_NO,TITLE,CONTENT,USER_ID,USER_NAME,WDATE) values (10,null,null,null,null,to_date('2022/10/21','YYYY/MM/DD'));
Insert into OURHM.QA (QNA_NO,TITLE,CONTENT,USER_ID,USER_NAME,WDATE) values (11,null,null,null,null,to_date('2022/10/21','YYYY/MM/DD'));
Insert into OURHM.QA (QNA_NO,TITLE,CONTENT,USER_ID,USER_NAME,WDATE) values (12,'ã´ã',null,null,null,to_date('2022/10/21','YYYY/MM/DD'));
Insert into OURHM.QA (QNA_NO,TITLE,CONTENT,USER_ID,USER_NAME,WDATE) values (13,'타이블',null,null,null,to_date('2022/10/21','YYYY/MM/DD'));
Insert into OURHM.QA (QNA_NO,TITLE,CONTENT,USER_ID,USER_NAME,WDATE) values (14,null,null,null,null,to_date('2022/10/21','YYYY/MM/DD'));
Insert into OURHM.QA (QNA_NO,TITLE,CONTENT,USER_ID,USER_NAME,WDATE) values (15,null,null,null,null,to_date('2022/10/21','YYYY/MM/DD'));
Insert into OURHM.QA (QNA_NO,TITLE,CONTENT,USER_ID,USER_NAME,WDATE) values (16,null,null,null,null,to_date('2022/10/21','YYYY/MM/DD'));
Insert into OURHM.QA (QNA_NO,TITLE,CONTENT,USER_ID,USER_NAME,WDATE) values (17,'ㄴㅇㄴㅇ',null,null,null,to_date('2022/10/21','YYYY/MM/DD'));
Insert into OURHM.QA (QNA_NO,TITLE,CONTENT,USER_ID,USER_NAME,WDATE) values (18,null,null,null,null,to_date('2022/10/21','YYYY/MM/DD'));
Insert into OURHM.QA (QNA_NO,TITLE,CONTENT,USER_ID,USER_NAME,WDATE) values (20,'ㄴㅇㄴ111112121',null,null,null,to_date('2022/10/21','YYYY/MM/DD'));
REM INSERTING into OURHM.REVIEW
SET DEFINE OFF;
Insert into OURHM.REVIEW (REVIEW_NO,TITLE,CONTENT,USER_ID,USER_NAME,WDATE,PRODUCT_NO,HIT) values (2,'TEST용 QA','TEST용 QNA 작성 중','ff','fsaf',to_date('2022/10/20','YYYY/MM/DD'),1,0);
Insert into OURHM.REVIEW (REVIEW_NO,TITLE,CONTENT,USER_ID,USER_NAME,WDATE,PRODUCT_NO,HIT) values (3,'TEST용 REVIEW 2','TEST용 REVIEW 작성 중','ff','fsaf',to_date('2022/10/20','YYYY/MM/DD'),1,0);
Insert into OURHM.REVIEW (REVIEW_NO,TITLE,CONTENT,USER_ID,USER_NAME,WDATE,PRODUCT_NO,HIT) values (4,'TEST용 REVIEW 3','TEST용 REVIEW 작성 중','ff','fsaf',to_date('2022/10/20','YYYY/MM/DD'),1,0);
Insert into OURHM.REVIEW (REVIEW_NO,TITLE,CONTENT,USER_ID,USER_NAME,WDATE,PRODUCT_NO,HIT) values (5,'TEST용 REVIEW 3','TEST용 REVIEW 작성 중','ff','fsaf',to_date('2022/10/20','YYYY/MM/DD'),1,0);
Insert into OURHM.REVIEW (REVIEW_NO,TITLE,CONTENT,USER_ID,USER_NAME,WDATE,PRODUCT_NO,HIT) values (6,'TEST용 REVIEW 3','TEST용 REVIEW 작성 중','ff','fsaf',to_date('2022/10/20','YYYY/MM/DD'),1,0);
Insert into OURHM.REVIEW (REVIEW_NO,TITLE,CONTENT,USER_ID,USER_NAME,WDATE,PRODUCT_NO,HIT) values (7,'TEST용 REVIEW 3','TEST용 REVIEW 작성 중','ff','fsaf',to_date('2022/10/20','YYYY/MM/DD'),1,0);
Insert into OURHM.REVIEW (REVIEW_NO,TITLE,CONTENT,USER_ID,USER_NAME,WDATE,PRODUCT_NO,HIT) values (8,'TEST용 REVIEW 3','TEST용 REVIEW 작성 중','ff','fsaf',to_date('2022/10/20','YYYY/MM/DD'),1,0);
Insert into OURHM.REVIEW (REVIEW_NO,TITLE,CONTENT,USER_ID,USER_NAME,WDATE,PRODUCT_NO,HIT) values (9,'TEST용 REVIEW 3','TEST용 REVIEW 작성 중','ff','fsaf',to_date('2022/10/20','YYYY/MM/DD'),1,0);
Insert into OURHM.REVIEW (REVIEW_NO,TITLE,CONTENT,USER_ID,USER_NAME,WDATE,PRODUCT_NO,HIT) values (10,'TEST용 REVIEW 3','TEST용 REVIEW 작성 중','ff','fsaf',to_date('2022/10/20','YYYY/MM/DD'),1,0);
Insert into OURHM.REVIEW (REVIEW_NO,TITLE,CONTENT,USER_ID,USER_NAME,WDATE,PRODUCT_NO,HIT) values (11,'TEST용 REVIEW 3','TEST용 REVIEW 작성 중','ff','fsaf',to_date('2022/10/20','YYYY/MM/DD'),1,0);
Insert into OURHM.REVIEW (REVIEW_NO,TITLE,CONTENT,USER_ID,USER_NAME,WDATE,PRODUCT_NO,HIT) values (12,'TEST용 REVIEW 3','TEST용 REVIEW 작성 중','ff','fsaf',to_date('2022/10/20','YYYY/MM/DD'),2,0);
Insert into OURHM.REVIEW (REVIEW_NO,TITLE,CONTENT,USER_ID,USER_NAME,WDATE,PRODUCT_NO,HIT) values (13,'TEST용 REVIEW 5','TEST용 REVIEW 작성 중','ff','fsaf',to_date('2022/10/20','YYYY/MM/DD'),2,0);
Insert into OURHM.REVIEW (REVIEW_NO,TITLE,CONTENT,USER_ID,USER_NAME,WDATE,PRODUCT_NO,HIT) values (14,'TEST용 REVIEW 4','TEST용 REVIEW 작성 중','ff','fsaf',to_date('2022/10/20','YYYY/MM/DD'),2,0);
REM INSERTING into OURHM.USERS
SET DEFINE OFF;
Insert into OURHM.USERS (USER_NO,USER_ID,PWD,NAME,PHONE,EMAIL,ADDRESS,DEL_NO) values (111,'ff','dd','dd','dd','dd','dd',null);
Insert into OURHM.USERS (USER_NO,USER_ID,PWD,NAME,PHONE,EMAIL,ADDRESS,DEL_NO) values (156,'test','test','test','test','test','test',null);
Insert into OURHM.USERS (USER_NO,USER_ID,PWD,NAME,PHONE,EMAIL,ADDRESS,DEL_NO) values (157,'test2','test2','test2','test2','test2','test2',null);
--------------------------------------------------------
--  DDL for Index BBS_PK
--------------------------------------------------------

  CREATE UNIQUE INDEX "OURHM"."BBS_PK" ON "OURHM"."BBS" ("BBS_IDX") 
  ;
--------------------------------------------------------
--  DDL for Index COMMENT_PK
--------------------------------------------------------

  CREATE UNIQUE INDEX "OURHM"."COMMENT_PK" ON "OURHM"."COMMENTS" ("COMMENT_IDX") 
  ;
--------------------------------------------------------
--  DDL for Index SYS_C007030
--------------------------------------------------------

  CREATE UNIQUE INDEX "OURHM"."SYS_C007030" ON "OURHM"."USERS" ("USER_NO") 
  ;
--------------------------------------------------------
--  DDL for Index SYS_C007031
--------------------------------------------------------

  CREATE UNIQUE INDEX "OURHM"."SYS_C007031" ON "OURHM"."USERS" ("USER_ID") 
  ;
--------------------------------------------------------
--  DDL for Index SYS_C007033
--------------------------------------------------------

  CREATE UNIQUE INDEX "OURHM"."SYS_C007033" ON "OURHM"."CATEGORY" ("CATEGORY_NO") 
  ;
--------------------------------------------------------
--  DDL for Index SYS_C007036
--------------------------------------------------------

  CREATE UNIQUE INDEX "OURHM"."SYS_C007036" ON "OURHM"."PRODUCT" ("PRODUCT_NO") 
  ;
--------------------------------------------------------
--  DDL for Index SYS_C007037
--------------------------------------------------------

  CREATE UNIQUE INDEX "OURHM"."SYS_C007037" ON "OURHM"."ORDER_DETAIL" ("ORDER_DETAIL_KEY") 
  ;
--------------------------------------------------------
--  DDL for Index SYS_C007039
--------------------------------------------------------

  CREATE UNIQUE INDEX "OURHM"."SYS_C007039" ON "OURHM"."ORDER_MAIN" ("ORDER_NO") 
  ;
--------------------------------------------------------
--  DDL for Index SYS_C007040
--------------------------------------------------------

  CREATE UNIQUE INDEX "OURHM"."SYS_C007040" ON "OURHM"."QA" ("QNA_NO") 
  ;
--------------------------------------------------------
--  DDL for Index SYS_C007041
--------------------------------------------------------

  CREATE UNIQUE INDEX "OURHM"."SYS_C007041" ON "OURHM"."REVIEW" ("REVIEW_NO") 
  ;
--------------------------------------------------------
--  DDL for Index SYS_C007042
--------------------------------------------------------

  CREATE UNIQUE INDEX "OURHM"."SYS_C007042" ON "OURHM"."PRODUCT_OPTION" ("OPTION_NO") 
  ;
--------------------------------------------------------
--  DDL for Index SYS_C007052
--------------------------------------------------------

  CREATE UNIQUE INDEX "OURHM"."SYS_C007052" ON "OURHM"."CART" ("CART_NO") 
  ;
--------------------------------------------------------
--  DDL for Index SYS_C007055
--------------------------------------------------------

  CREATE UNIQUE INDEX "OURHM"."SYS_C007055" ON "OURHM"."LIKE_PRODUCT" ("LIKE_NO") 
  ;
--------------------------------------------------------
--  DDL for Index SYS_C007058
--------------------------------------------------------

  CREATE UNIQUE INDEX "OURHM"."SYS_C007058" ON "OURHM"."DELADDR" ("DEL_NO") 
  ;
--------------------------------------------------------
--  DDL for Index BBS_PK
--------------------------------------------------------

  CREATE UNIQUE INDEX "OURHM"."BBS_PK" ON "OURHM"."BBS" ("BBS_IDX") 
  ;
--------------------------------------------------------
--  DDL for Index SYS_C007052
--------------------------------------------------------

  CREATE UNIQUE INDEX "OURHM"."SYS_C007052" ON "OURHM"."CART" ("CART_NO") 
  ;
--------------------------------------------------------
--  DDL for Index SYS_C007033
--------------------------------------------------------

  CREATE UNIQUE INDEX "OURHM"."SYS_C007033" ON "OURHM"."CATEGORY" ("CATEGORY_NO") 
  ;
--------------------------------------------------------
--  DDL for Index COMMENT_PK
--------------------------------------------------------

  CREATE UNIQUE INDEX "OURHM"."COMMENT_PK" ON "OURHM"."COMMENTS" ("COMMENT_IDX") 
  ;
--------------------------------------------------------
--  DDL for Index SYS_C007058
--------------------------------------------------------

  CREATE UNIQUE INDEX "OURHM"."SYS_C007058" ON "OURHM"."DELADDR" ("DEL_NO") 
  ;
--------------------------------------------------------
--  DDL for Index SYS_C007055
--------------------------------------------------------

  CREATE UNIQUE INDEX "OURHM"."SYS_C007055" ON "OURHM"."LIKE_PRODUCT" ("LIKE_NO") 
  ;
--------------------------------------------------------
--  DDL for Index SYS_C007037
--------------------------------------------------------

  CREATE UNIQUE INDEX "OURHM"."SYS_C007037" ON "OURHM"."ORDER_DETAIL" ("ORDER_DETAIL_KEY") 
  ;
--------------------------------------------------------
--  DDL for Index SYS_C007039
--------------------------------------------------------

  CREATE UNIQUE INDEX "OURHM"."SYS_C007039" ON "OURHM"."ORDER_MAIN" ("ORDER_NO") 
  ;
--------------------------------------------------------
--  DDL for Index SYS_C007036
--------------------------------------------------------

  CREATE UNIQUE INDEX "OURHM"."SYS_C007036" ON "OURHM"."PRODUCT" ("PRODUCT_NO") 
  ;
--------------------------------------------------------
--  DDL for Index SYS_C007042
--------------------------------------------------------

  CREATE UNIQUE INDEX "OURHM"."SYS_C007042" ON "OURHM"."PRODUCT_OPTION" ("OPTION_NO") 
  ;
--------------------------------------------------------
--  DDL for Index SYS_C007040
--------------------------------------------------------

  CREATE UNIQUE INDEX "OURHM"."SYS_C007040" ON "OURHM"."QA" ("QNA_NO") 
  ;
--------------------------------------------------------
--  DDL for Index SYS_C007041
--------------------------------------------------------

  CREATE UNIQUE INDEX "OURHM"."SYS_C007041" ON "OURHM"."REVIEW" ("REVIEW_NO") 
  ;
--------------------------------------------------------
--  DDL for Index SYS_C007030
--------------------------------------------------------

  CREATE UNIQUE INDEX "OURHM"."SYS_C007030" ON "OURHM"."USERS" ("USER_NO") 
  ;
--------------------------------------------------------
--  DDL for Index SYS_C007031
--------------------------------------------------------

  CREATE UNIQUE INDEX "OURHM"."SYS_C007031" ON "OURHM"."USERS" ("USER_ID") 
  ;
--------------------------------------------------------
--  Constraints for Table BBS
--------------------------------------------------------

  ALTER TABLE "OURHM"."BBS" ADD CONSTRAINT "BBS_PK" PRIMARY KEY ("BBS_IDX") ENABLE;
--------------------------------------------------------
--  Constraints for Table CART
--------------------------------------------------------

  ALTER TABLE "OURHM"."CART" ADD PRIMARY KEY ("CART_NO") ENABLE;
--------------------------------------------------------
--  Constraints for Table CATEGORY
--------------------------------------------------------

  ALTER TABLE "OURHM"."CATEGORY" ADD PRIMARY KEY ("CATEGORY_NO") ENABLE;
  ALTER TABLE "OURHM"."CATEGORY" MODIFY ("CATEGORY_NAME" NOT NULL ENABLE);
--------------------------------------------------------
--  Constraints for Table COMMENTS
--------------------------------------------------------

  ALTER TABLE "OURHM"."COMMENTS" ADD CONSTRAINT "COMMENT_PK" PRIMARY KEY ("COMMENT_IDX") ENABLE;
--------------------------------------------------------
--  Constraints for Table DELADDR
--------------------------------------------------------

  ALTER TABLE "OURHM"."DELADDR" ADD PRIMARY KEY ("DEL_NO") ENABLE;
--------------------------------------------------------
--  Constraints for Table LIKE_PRODUCT
--------------------------------------------------------

  ALTER TABLE "OURHM"."LIKE_PRODUCT" ADD PRIMARY KEY ("LIKE_NO") ENABLE;
--------------------------------------------------------
--  Constraints for Table ORDER_DETAIL
--------------------------------------------------------

  ALTER TABLE "OURHM"."ORDER_DETAIL" ADD PRIMARY KEY ("ORDER_DETAIL_KEY") ENABLE;
--------------------------------------------------------
--  Constraints for Table ORDER_MAIN
--------------------------------------------------------

  ALTER TABLE "OURHM"."ORDER_MAIN" ADD PRIMARY KEY ("ORDER_NO") ENABLE;
--------------------------------------------------------
--  Constraints for Table PRODUCT
--------------------------------------------------------

  ALTER TABLE "OURHM"."PRODUCT" ADD PRIMARY KEY ("PRODUCT_NO") ENABLE;
  ALTER TABLE "OURHM"."PRODUCT" MODIFY ("PRICE" NOT NULL ENABLE);
  ALTER TABLE "OURHM"."PRODUCT" MODIFY ("PRODUCT_NAME" NOT NULL ENABLE);
--------------------------------------------------------
--  Constraints for Table PRODUCT_OPTION
--------------------------------------------------------

  ALTER TABLE "OURHM"."PRODUCT_OPTION" ADD PRIMARY KEY ("OPTION_NO") ENABLE;
--------------------------------------------------------
--  Constraints for Table QA
--------------------------------------------------------

  ALTER TABLE "OURHM"."QA" ADD PRIMARY KEY ("QNA_NO") ENABLE;
--------------------------------------------------------
--  Constraints for Table REVIEW
--------------------------------------------------------

  ALTER TABLE "OURHM"."REVIEW" ADD PRIMARY KEY ("REVIEW_NO") ENABLE;
--------------------------------------------------------
--  Constraints for Table USERS
--------------------------------------------------------

  ALTER TABLE "OURHM"."USERS" ADD UNIQUE ("USER_ID") ENABLE;
  ALTER TABLE "OURHM"."USERS" ADD PRIMARY KEY ("USER_NO") ENABLE;
  ALTER TABLE "OURHM"."USERS" MODIFY ("ADDRESS" NOT NULL ENABLE);
  ALTER TABLE "OURHM"."USERS" MODIFY ("EMAIL" NOT NULL ENABLE);
  ALTER TABLE "OURHM"."USERS" MODIFY ("PHONE" NOT NULL ENABLE);
  ALTER TABLE "OURHM"."USERS" MODIFY ("NAME" NOT NULL ENABLE);
  ALTER TABLE "OURHM"."USERS" MODIFY ("PWD" NOT NULL ENABLE);
--------------------------------------------------------
--  Ref Constraints for Table CART
--------------------------------------------------------

  ALTER TABLE "OURHM"."CART" ADD CONSTRAINT "CART_FK1" FOREIGN KEY ("OPTION_NO")
	  REFERENCES "OURHM"."PRODUCT_OPTION" ("OPTION_NO") ENABLE;
  ALTER TABLE "OURHM"."CART" ADD CONSTRAINT "CART_FK2" FOREIGN KEY ("USER_ID")
	  REFERENCES "OURHM"."USERS" ("USER_ID") ENABLE;
--------------------------------------------------------
--  Ref Constraints for Table COMMENTS
--------------------------------------------------------

  ALTER TABLE "OURHM"."COMMENTS" ADD CONSTRAINT "COMMMENT_FK" FOREIGN KEY ("BBS_IDX")
	  REFERENCES "OURHM"."BBS" ("BBS_IDX") ENABLE;
--------------------------------------------------------
--  Ref Constraints for Table LIKE_PRODUCT
--------------------------------------------------------

  ALTER TABLE "OURHM"."LIKE_PRODUCT" ADD CONSTRAINT "LIKE_PRODUCT_FK1" FOREIGN KEY ("PRODUCT_NO")
	  REFERENCES "OURHM"."PRODUCT" ("PRODUCT_NO") ENABLE;
  ALTER TABLE "OURHM"."LIKE_PRODUCT" ADD CONSTRAINT "LIKE_PRODUCT_FK2" FOREIGN KEY ("USER_ID")
	  REFERENCES "OURHM"."USERS" ("USER_ID") ENABLE;
--------------------------------------------------------
--  Ref Constraints for Table PRODUCT
--------------------------------------------------------

  ALTER TABLE "OURHM"."PRODUCT" ADD CONSTRAINT "CATEGORY_NO" FOREIGN KEY ("CATEGORY_NO")
	  REFERENCES "OURHM"."CATEGORY" ("CATEGORY_NO") ENABLE;
--------------------------------------------------------
--  Ref Constraints for Table PRODUCT_OPTION
--------------------------------------------------------

  ALTER TABLE "OURHM"."PRODUCT_OPTION" ADD FOREIGN KEY ("PRODUCT_NO")
	  REFERENCES "OURHM"."PRODUCT" ("PRODUCT_NO") ENABLE;
--------------------------------------------------------
--  Ref Constraints for Table REVIEW
--------------------------------------------------------

  ALTER TABLE "OURHM"."REVIEW" ADD CONSTRAINT "REVIEW_FK1" FOREIGN KEY ("PRODUCT_NO")
	  REFERENCES "OURHM"."PRODUCT" ("PRODUCT_NO") ENABLE;
  ALTER TABLE "OURHM"."REVIEW" ADD CONSTRAINT "REVIEW_FK2" FOREIGN KEY ("USER_ID")
	  REFERENCES "OURHM"."USERS" ("USER_ID") ENABLE;

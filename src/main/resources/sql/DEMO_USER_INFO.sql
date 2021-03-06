declare
      num   number;
begin
      select count(1) into num from all_tables where TABLE_NAME = 'DEMO_USER_INFO' and OWNER='LESLY';
      if   num=1   then
          execute immediate 'drop table DEMO_USER_INFO';
      end   if;
end;
/

CREATE TABLE DEMO_USER_INFO(
        U_ID NUMBER(4) NOT NULL,
        USERNAME VARCHAR2(10),
        GENDER CHAR(3),
        BIRTHDAY DATE,
        ADDRESS VARCHAR2(100)
);

insert into DEMO_USER_INFO(U_ID, USERNAME, GENDER, BIRTHDAY, ADDRESS) values (1, 'lesly', '男', to_date('1990-11-20', 'YYYY-MM-DD'), 'Hunan');
insert into DEMO_USER_INFO(U_ID, USERNAME, GENDER, BIRTHDAY, ADDRESS) values (2, 'lily', '女', to_date('1991-10-19', 'YYYY-MM-DD'), 'Hunan');
insert into DEMO_USER_INFO(U_ID, USERNAME, GENDER, BIRTHDAY, ADDRESS) values (3, 'lucy', '女', to_date('1992-09-18', 'YYYY-MM-DD'), 'Hunan');
insert into DEMO_USER_INFO(U_ID, USERNAME, GENDER, BIRTHDAY, ADDRESS) values (4, 'poly', '女', to_date('1993-08-17', 'YYYY-MM-DD'), 'Hunan');
insert into DEMO_USER_INFO(U_ID, USERNAME, GENDER, BIRTHDAY, ADDRESS) values (5, 'kevin', '男', to_date('1994-07-16', 'YYYY-MM-DD'), 'Hunan');

CREATE OR REPLACE PACKAGE TESTPACKAGE  AS
 TYPE TEST_CURSOR IS REF CURSOR;
end TESTPACKAGE;
/

CREATE OR REPLACE PROCEDURE LOAD_ALL_USER_INFO(P_CURSOR out TESTPACKAGE.TEST_CURSOR) IS
BEGIN
    OPEN P_CURSOR FOR SELECT * FROM LESLY.DEMO_USER_INFO;
END LOAD_ALL_USER_INFO;


----------------------------------------
--第一次登录
用户名：SYS as SYSDBA
密码：evallesly

查看所有表
select *
from user_tab_columns
where Table_Name='用户表'
order by column_name

创建表空间和用户
CREATE TEMPORARY TABLESPACE MORNING_TEMP
         TEMPFILE 'E:\app\Administrator\oradata\eval\MORNING_TEMP.DBF'
         SIZE 32M
         AUTOEXTEND ON
         NEXT 32M MAXSIZE UNLIMITED
         EXTENT MANAGEMENT LOCAL;

CREATE TABLESPACE MORNING_DATA
         LOGGING
         DATAFILE 'E:\app\Administrator\oradata\eval\MORNING_DATA.DBF'
         SIZE 32M
         AUTOEXTEND ON
         NEXT 32M MAXSIZE UNLIMITED
         EXTENT MANAGEMENT LOCAL;

CREATE USER LESLY IDENTIFIED BY LESLY123
         ACCOUNT UNLOCK
         DEFAULT TABLESPACE MORNING_DATA
         TEMPORARY TABLESPACE MORNING_TEMP;

GRANT CONNECT,RESOURCE TO LESLY;

GRANT DBA TO LESLY;

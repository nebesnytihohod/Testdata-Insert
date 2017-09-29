CREATE OR REPLACE PACKAGE test_insert
 IS
 TYPE link_row_arrType IS TABLE OF number INDEX BY varchar2(50);
 TYPE link_table_arrType IS TABLE OF link_row_arrType INDEX BY varchar2(50);
 
 TYPE config_arrType IS TABLE OF varchar2(50) INDEX BY varchar2(50);
 
 TYPE testdata_arrType IS TABLE OF varchar2(100);
 TYPE testdata_2XarrType IS TABLE OF testdata_arrType;

 PROCEDURE insert_row (
 config_name IN config_arrType,
 table_name IN testdata_2XarrType,
 link_to IN OUT link_table_arrType
);
 
END test_insert;
/
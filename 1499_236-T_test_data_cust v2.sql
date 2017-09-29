/* Scenario 1499 236-T
 * test data for BUSINESS.CUST
**/

DECLARE
 TYPE inn_arr IS TABLE OF  varchar2(20);
 inn inn_arr := inn_arr(    -- array for variable test data
 7743123450,    -- valid for test-case
 7743123470,    -- not valid for test-case
 9932456780     -- not valid for test-case
 );
 element INTEGER := 1;    -- loop counter
 full_nm_const varchar2(2000) := 'test_1499_236-T';
 cust_type_cd_const varchar2(10) := 'ORG';
 prcsng_batch_nm_const varchar2(20) := 'DLY';
 jrsdcn_cd_const varchar2(4) := 'RF';
 bus_dmn_list_tx_const varchar2(65) := 'a';
 cust_stat_cd_const varchar2(1) := 'A';
 row_id number;
BEGIN
 WHILE (element<=inn.COUNT) LOOP    -- loop for insert row
 row_id := STD.aml_tools.get_new_cust_seq_id();   -- generation id for test data row
 INSERT INTO business.cust(
 cust_intrl_id,    -- 1
 cust_seq_id,    -- 3
 data_dump_dt,    -- 2
 FULL_NM,    -- 52
 tax_id,    -- 7
 CUST_TYPE_CD,    -- 5
 PRCSNG_BATCH_NM,    -- 85
 JRSDCN_CD,    -- 86
 BUS_DMN_LIST_TX,    -- 87
 CUST_STAT_CD    -- 95
 )
 VALUES(
 TO_CHAR(row_id),   -- 1
 row_id,    -- 3
 trunc(sysdate),    -- 2
 full_nm_const,    -- 52
 inn(element),    -- 7
 cust_type_cd_const,    -- 5
 prcsng_batch_nm_const,    --85
 jrsdcn_cd_const,    -- 86
 bus_dmn_list_tx_const,    -- 87
 cust_stat_cd_const    -- 95
 );
 element := element + 1;    -- increment of loop counter
 END LOOP;
END;

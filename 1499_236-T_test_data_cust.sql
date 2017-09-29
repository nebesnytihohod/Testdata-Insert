-- Scenario 1499 236-T
-- test data for BUSINESS.CUST

declare
 row_id number;
begin
 row_id := STD.aml_tools.get_new_cust_seq_id();
 INSERT INTO business.cust(
 cust_intrl_id,
 cust_seq_id,
 data_dump_dt,
 full_nm,
 tax_id,
 CUST_TYPE_CD,
 PRCSNG_BATCH_NM,
 JRSDCN_CD,
 BUS_DMN_LIST_TX,
 CUST_STAT_CD)
 VALUES(
 TO_CHAR(row_id),
 row_id,
 trunc(sysdate),
 'test_1499_236-T',
 '7743123450',
 'ORG',
 'DLY',
 'RF',
 'a',
 'A');
end;

declare
 row_id number;
begin
 row_id := STD.aml_tools.get_new_cust_seq_id();
 INSERT INTO business.cust(
 cust_intrl_id,
 cust_seq_id,
 data_dump_dt,
 full_nm,
 tax_id,
 CUST_TYPE_CD,
 PRCSNG_BATCH_NM,
 JRSDCN_CD,
 BUS_DMN_LIST_TX,
 CUST_STAT_CD)
 VALUES(
 TO_CHAR(row_id),
 row_id,
 trunc(sysdate),
 'test_1499_236-T',
 '7743123470',
 'ORG',
 'DLY',
 'RF',
 'a',
 'A');
end;

declare
 row_id number;
begin
 row_id := STD.aml_tools.get_new_cust_seq_id();
 INSERT INTO business.cust(
 cust_intrl_id,
 cust_seq_id,
 data_dump_dt,
 full_nm,
 tax_id,
 CUST_TYPE_CD,
 PRCSNG_BATCH_NM,
 JRSDCN_CD,
 BUS_DMN_LIST_TX,
 CUST_STAT_CD)
 VALUES(
 TO_CHAR(row_id),
 row_id,
 trunc(sysdate),
 'test_1499_236-T',
 '9932456780',
 'ORG',
 'DLY',
 'RF',
 'a',
 'A');
end;
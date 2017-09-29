CREATE OR REPLACE PACKAGE BODY test_insert IS

 PROCEDURE insert_row (
 config_name IN config_arrType,
 table_name IN testdata_2XarrType,
 link_to IN OUT link_table_arrType
) 
IS 
TYPE col_arrType IS TABLE OF number;
col_arr col_arrType := col_arrType();	--! column array for description of the field number in test data block

day_year_const number(4) := 366;

elementX varchar2(30);
elementY varchar2(30);
open_dt date;
date_oper date;

BEGIN
dbms_output.enable;
 CASE config_name('table')

 WHEN 'cust' THEN
  FOR i IN table_name.FIRST..table_name.LAST LOOP	--! < select test data block in common array
   col_arr.DELETE;
   FOR c IN 1..(TO_NUMBER(config_name('num_field'))) LOOP	--! < starting value for calculate position number in array of the test data
    col_arr.EXTEND;
    col_arr(c) := c;	--! < column counter for data block
   END LOOP;
   FOR n IN table_name(i).FIRST..(table_name(i).LAST / TO_NUMBER(config_name('num_field'))) LOOP	--! < select row of the test data in block for insert into table
    elementX := CONCAT(config_name('table'), i);	--! key identificator
    elementY := CONCAT('id', n);	--! key identificator
    link_to(elementX)(elementY) := STD.AML_TOOLS.get_new_cust_seq_id();	--! < generation id for test data row and save into output array
    INSERT INTO business.cust(
     cust_intrl_id,    -- 1
     cust_seq_id,    -- 3
     data_dump_dt,    -- 2
     full_nm,    -- 52
     tax_id,    -- 7
     CUST_TYPE_CD,    -- 5
     PRCSNG_BATCH_NM,    -- 85
     JRSDCN_CD,    -- 86
     BUS_DMN_LIST_TX,    -- 87
     CUST_STAT_CD    -- 95
    )
    VALUES(
	TO_CHAR(link_to(elementX)(elementY)),	-- 1: cust_intrl_id
	link_to(elementX)(elementY),	-- 3: cust_seq_id
	TRUNC(sysdate),	-- 2: data_dump_dt
	table_name(i)(col_arr(1)),	-- 52: full_nm
	table_name(i)(col_arr(2)),	-- 7: tax_id
	table_name(i)(col_arr(3)),	-- 5: CUST_TYPE_CD
	table_name(i)(col_arr(4)),	-- 85: PRCSNG_BATCH_NM
	table_name(i)(col_arr(5)),	-- 86: JRSDCN_CD
	table_name(i)(col_arr(6)),	-- 87: BUS_DMN_LIST_TX
	table_name(i)(col_arr(7))		-- 95: CUST_STAT_CD
    );
	COMMIT;
  
	FOR c IN 1..(TO_NUMBER(config_name('num_field'))) LOOP
	col_arr(c) := col_arr(c) + (TO_NUMBER(config_name('num_field')));	--! increment counter for the next value in columns
    END LOOP;
    
   END LOOP;
  END LOOP;
  
 WHEN 'acct' THEN
  FOR i IN table_name.FIRST..table_name.LAST LOOP
   col_arr.DELETE;
   FOR c IN 1..(TO_NUMBER(config_name('num_field'))) LOOP	--! < starting value for calculate position number in array of the test data
    col_arr.EXTEND;
    col_arr(c) := c;	--! < column counter for data block
   END LOOP;
   FOR n IN table_name(i).FIRST..(table_name(i).LAST / TO_NUMBER(config_name('num_field'))) LOOP
    elementX := CONCAT(config_name('table'), i);
    elementY := CONCAT('id', n);
    link_to(elementX)(elementY) := STD.AML_TOOLS.get_new_acct_seq_id();
    open_dt := TRUNC(sysdate - day_year_const - n);    --! < calculate of the date ~1 years ago
    INSERT INTO business.acct(
    acct_intrl_id,    -- 1
    acct_seq_id,  -- 3
    alt_acct_id,      -- 27
    acct_open_dt,     -- 10
    prmry_cust_intrl_id,      -- 45
    data_dump_dt,    -- 2
    ACCT_EFCTV_RISK_NB,    -- 46
    PRCSNG_BATCH_NM,      -- 72
    MANTAS_ACCT_PURP_CD,   -- 78
    RETRMT_ACCT_FL,    -- 79
    JRSDCN_CD,     -- 80
    BUS_DMN_LIST_TX,    -- 81
    RF_PARTITION_KEY    -- 159
    )
    VALUES(
	TO_CHAR(link_to(elementX)(elementY)),	-- 1: acct_intrl_id
	link_to(elementX)(elementY),	-- 3: acct_seq_id
	table_name(i)(col_arr(3)),	-- 27: alt_acct_id
	TO_DATE(open_dt, 'dd.mm.yyyy'),	-- 10: acct_open_dt
	link_to(table_name(i)(col_arr(1)))(table_name(i)(col_arr(2))),	-- 45: prmry_cust_intrl_id
	TRUNC(sysdate),	-- 2: data_dump_dt
    TO_NUMBER(table_name(i)(col_arr(4))),		-- 46: ACCT_EFCTV_RISK_NB
    table_name(i)(col_arr(5)),	-- 72: PRCSNG_BATCH_NM
    table_name(i)(col_arr(6)),	-- 78: MANTAS_ACCT_PURP_CD
    table_name(i)(col_arr(7)),	-- 79: RETRMT_ACCT_FL
    table_name(i)(col_arr(8)),	-- 80: JRSDCN_CD
    table_name(i)(col_arr(9)),	-- 81: BUS_DMN_LIST_TX
    TO_NUMBER(table_name(i)(col_arr(10)))		-- 159: RF_PARTITION_KEY
    );
	COMMIT;
  
	FOR c IN 1..(TO_NUMBER(config_name('num_field'))) LOOP
	col_arr(c) := col_arr(c) + (TO_NUMBER(config_name('num_field')));	--! increment counter for the next value in columns
    END LOOP;
    
   END LOOP;
  END LOOP;
  
 WHEN 'cash_trxn' THEN 
 FOR i IN table_name.FIRST..table_name.LAST LOOP
  col_arr.DELETE;
  FOR c IN 1..(TO_NUMBER(config_name('num_field'))) LOOP 	--! < starting value for calculate position number in array of the test data
   col_arr.EXTEND;
   col_arr(c) := c;	--! < column counter for data block
  END LOOP;
   FOR n IN table_name(i).FIRST..(table_name(i).LAST / TO_NUMBER(config_name('num_field'))) LOOP
    elementX := CONCAT(config_name('table'), i);
    elementY := CONCAT('id', n);
    link_to(elementX)(elementY) := STD.AML_TOOLS.get_new_trxn_seq();
    date_oper := TRUNC(sysdate - TO_NUMBER(table_name(i)(col_arr(4))));	--! < calculate of the operation date
   INSERT INTO business.cash_trxn(
   fo_trxn_seq_id,	-- 1
   trxn_intrl_ref_id,	-- 2
   data_dump_dt,		-- 3
   trxn_exctn_dt,		-- 11
   rf_credit_cd,		-- 94
   rf_debit_cd,		-- 93
   trxn_base_am,		-- 8
   acct_intrl_id,		-- 9
   desc_tx,			-- 10
   DBT_CDT_CD,		-- 7 D
   PRCSNG_BATCH_NM,	-- 33
   MANTAS_TRXN_ASSET_CLASS_CD,	-- 42
   MANTAS_TRXN_PURP_CD,	-- 43
   MANTAS_TRXN_PRDCT_CD,	-- 44 PHYS
   MANTAS_TRXN_CHANL_CD,	-- 46 UNKNOWN
   RF_ACTIVE_PARTITION_FLAG,	-- 158
   RF_SUBPARTITION_KEY		-- 160
   )
   VALUES(
    link_to(elementX)(elementY),	-- 1: fo_trxn_seq_id
    table_name(i)(col_arr(3)),		-- 2: trxn_intrl_ref_id
    TRUNC(sysdate),		-- 3: data_dump_dt
    TO_DATE(date_oper, 'dd.mm.yyyy'),		-- 11
    table_name(i)(col_arr(6)),		-- 94
    table_name(i)(col_arr(5)),		-- 93
    TO_NUMBER(table_name(i)(col_arr(7))),		-- 8
    link_to(table_name(i)(col_arr(1)))(table_name(i)(col_arr(2))),	-- 9
    table_name(i)(col_arr(8)),	-- 10
    table_name(i)(col_arr(9)),	-- 7 D TODO: Р·Р°Р�?РµРЅРёС‚СЊ Рё РґРѕР±Р°РІРёС‚СЊ РІ Р±Р»РѕРє РґР°РЅРЅС‹С… + РЅРёР¶Рµ
    table_name(i)(col_arr(10)),	-- 33
    table_name(i)(col_arr(11)),	-- 42
    table_name(i)(col_arr(12)),	-- 43
    table_name(i)(col_arr(13)),	-- 44 PHYS
    table_name(i)(col_arr(14)),	-- 46 UNKNOWN
    TO_NUMBER(table_name(i)(col_arr(15))),	-- 158
    TO_NUMBER(table_name(i)(col_arr(16)))	-- 160
   );
   COMMIT;

    FOR c IN 1..(TO_NUMBER(config_name('num_field'))) LOOP
    col_arr(c) := col_arr(c) + (TO_NUMBER(config_name('num_field')));	--! increment counter for the next value in columns
    END LOOP;
    
   END LOOP;
  END LOOP;
  
 --ELSE exception_1	-- РѕРїРёСЃР°С‚СЊ РёСЃРєР»СЋС‡РµРЅРёРµ
 END CASE;

 --EXCEPTION
--exception_1('name of the table?')
END;
 END test_insert;
 /
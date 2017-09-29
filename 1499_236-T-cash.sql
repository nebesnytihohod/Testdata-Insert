/** main block for insert row in CASH_TRXN
 *
 * Author: Stasenkov M.
 * E-mail: MVStasenkov.SBT@sberbank.ru
 * Date: December 2016
 * Purpose: Script inserts rows with "synthetic" test data considering dependences between tables.
 * Scenario: 1499 236-T (data for table BUSINESS.CASH_TRXN)
 *
 * Structure of the script:
 * declaration block
 *     block of constant data
 *     blocks of variable data
 *     block of service data and script variables
 * block for insert data into CASH_TRXN
 *      fo_trxn_seq_id (in var *cash_row_id*) <-- generating in function STD.AML_TOOLS.get_new_trxn_seq()
 */
DECLARE
/* common data for all table and row */
 trxn_intrl_ref_id_const varchar2(50) := 'test_1499_236-T';	-- CASH
 prcsng_batch_nm_const varchar2(20) := 'DLY';		-- CUST, ACCT, WIRE, CASH
 mantas_trxn_asset_class_cd_c varchar2(20) := 'FUNDS'; --WIRE, CASH
 mantas_trxn_purp_cd_const varchar2(20) := 'GENERAL'; --WIRE, CASH
 mantas_trxn_prdct_cd_const varchar2(30) := 'PHYS'; --WIRE, CASH
 mantas_trxn_chanl_cd_const varchar2(20) := 'UNKNOWN'; --WIRE, CASH
 rf_active_partition_flag_const number(38) := 0; -- WIRE, CASH
 rf_subpartition_key_const number(38) := 38064; -- WIRE, CASH
 dbt_cdt_cd_const VARCHAR2(20) := 'D';	-- 7 CASH

/* start test data for BUSINESS.CASH_TRXN */
 /* variable data for specific test case */
 TYPE cash_arrType IS TABLE OF varchar2(70);
 /**sequence of field with test data
    |        1         |      2          |      3         |          4        |       5        |
    +:----------:+:---------:+:---------:+:----------:+:---------:+
    |11:trxn_exctn_dt|94:rf_credit_cd|93:rf_debit_cd|8:trxn_base_am |9:acct_intrl_id|

  - use of field #1: values of delta to calculate action date.
 */
 number_ins_field NUMBER := 5;	-- number of the field in array with test data: cash_arr
 cash_arr_1 cash_arrType := cash_arrType(	--! < array of the test data for CASH_TRXN
 '202','40501810877771200000','40504810877771500000','100000','368825179',
 '26','40704810877770704000','40602810877770900000','4060','368825184',
 '30','40802810877770802000','40702810877770702000','77300','368825183',
 '30','40802810877770802000','40702810877770702000','550000','368825182',
 '23','79901810877776600000','40705810877770705000','2001000','368825181'
 );
 TYPE cash_2XarrType IS TABLE OF cash_arrType;
 cash_arr cash_2XarrType;

/* unique data */
 cash_row_id number;
 open_dt date;
 date_oper date;		--! < operation date for CASH_TRXN. Calculate parameter.
/* service data for SQL-script */
 element_csh INTEGER;	--! < loop counter for CASH
 
 index_csh_field1 INTEGER;	--! < starting value for calculate position number in array (cash_arr_...) of the test data for CASH_TRXN
 index_csh_field2 INTEGER;
 index_csh_field3 INTEGER;
 index_csh_field4 INTEGER;
 index_csh_field5 INTEGER;

BEGIN	--! < block for BUSINESS.CASH_TRXN
 element_csh := 1;	--! < loop counter for CASH
 
 index_csh_field1 := 1;	--! < starting value for calculate position number in array (cash_arr_...) of the test data for CASH_TRXN
 index_csh_field2 := 2;
 index_csh_field3 := 3;
 index_csh_field4 := 4;
 index_csh_field5 := 5;

 cash_arr := cash_2XarrType(
 cash_arr_1
 );

  WHILE (element_csh <= (cash_arr(1).COUNT / number_ins_field)) LOOP
   cash_row_id := STD.AML_TOOLS.get_new_trxn_seq();	--! < generation id for test data row
   date_oper := TRUNC(sysdate - TO_NUMBER(cash_arr(1)(index_csh_field1)));	--! < calculate of the operation date
   
   INSERT INTO business.cash_trxn(
   fo_trxn_seq_id,		-- 1
   TRXN_INTRL_REF_ID,	-- 2
   data_dump_dt,		-- 3
   trxn_exctn_dt,		-- 11
   rf_credit_cd,		-- 94
   rf_debit_cd,		-- 93
   trxn_base_am,		-- 8
   acct_intrl_id,		-- 9
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
    cash_row_id,		-- 1
    trxn_intrl_ref_id_const,		-- 2
    TRUNC(sysdate),		-- 3
    TO_DATE(date_oper, 'dd.mm.yyyy'),		-- 11
    cash_arr(1)(index_csh_field2),		-- 94
    cash_arr(1)(index_csh_field3),		-- 93
    TO_NUMBER(cash_arr(1)(index_csh_field4)),		-- 8
    cash_arr(1)(index_csh_field5),	-- 9
    dbt_cdt_cd_const,	-- 7 D
    prcsng_batch_nm_const,	-- 33
    mantas_trxn_asset_class_cd_c,	-- 42
    mantas_trxn_purp_cd_const,	-- 43
    mantas_trxn_prdct_cd_const,	-- 44 PHYS
    mantas_trxn_chanl_cd_const,	-- 46 UNKNOWN
    rf_active_partition_flag_const,	-- 158
    rf_subpartition_key_const	-- 160
   );
   COMMIT;
   
   element_csh := element_csh + 1;	--! < increment of loop counter for CASH_TRXN loop
   
   index_csh_field1 := index_csh_field1 + number_ins_field;	--! < calculate number of slider position in array (cash_arr_...) of the test data for CASH_TRXN
   index_csh_field2 := index_csh_field2 + number_ins_field;
   index_csh_field3 := index_csh_field3 + number_ins_field;
   index_csh_field4 := index_csh_field4 + number_ins_field;
   index_csh_field5 := index_csh_field5 + number_ins_field;

  END LOOP;
END;	-- end of block for BUSINESS.CASH_TRXN
/

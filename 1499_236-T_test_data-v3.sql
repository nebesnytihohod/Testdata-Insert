/* Scenario 1499 236-T
 * 
 */

/* procedure for insert row in CUST table
 *  declaration
 */
 CREATE OR REPLACE PROCEDURE ins_row_cust
 (cust_id IN varchar2(64),
 benef_acct_id IN varchar2(50)
 )
  IS
  NULL;	--! < TODO: local variable
  BEGIN
  WHILE (element_a <= alt_acct_id_arr.COUNT) LOOP
  acct_row_id := STD.aml_tools.get_new_acct_seq_id();
  open_dt := TRUNC(sysdate - day_year_const - element_a);    --! < calculate of the date ~1 years ago
  INSERT INTO business.acct(
  acct_intrl_id,    --! < 1
  acct_seq_id,  --! < 3
  alt_acct_id,      --! < 27
  acct_open_dt,     --! < 10
  prmry_cust_intrl_id,      --! < 45
  data_dump_dt,    --! < 2
  ACCT_EFCTV_RISK_NB,    --! < 46
  PRCSNG_BATCH_NM,      --! < 72
  MANTAS_ACCT_PURP_CD,   --! < 78
  RETRMT_ACCT_FL,    --! < 79
  JRSDCN_CD,     --! < 80
  BUS_DMN_LIST_TX,    --! < 81
  RF_PARTITION_KEY    --! < 159
  )
  VALUES(
  TO_CHAR(acct_row_id),     --! < 1
  acct_row_id,      --3
  alt_acct_id_arr(element_a),    --! < 27
  TO_DATE(open_dt, 'dd.mm.yyyy'),     --! < 10
  TO_CHAR(cust_row_id),     --! < 45 link to BUSINESS.CUST.CUST_INTRL_ID
  TRUNC(sysdate),    --! < 2
  acct_efctv_risk_nb_const,    --! < 46
  prcsng_batch_nm_const,    --! < 72
  mantas_acct_purp_cd_const,   --! < 78
  retrmt_acct_fl_const,    --! < 79
  jrsdcn_cd_const,     --! < 80
  bus_dmn_list_tx_const,    --! < 81
  rf_partition_key_const    --! < 159
  );
  element_a := element_a + 1;    --! < increment of loop counter
  END LOOP;
  END;
 
/* procedure for insert row in WIRE_TRXN table
 *  declaration
 */
 CREATE OR REPLACE PROCEDURE ins_row_wire
 (acct_id IN varchar2(64),
 benef_acct_id IN varchar2(50)
 )
  IS
  NULL;	--! < TODO: local variable
  BEGIN
   WHILE (element_w <= trxn_intrl_ref_id_arr.COUNT) LOOP
   trxn_row_id := std.AML_TOOLS.get_new_trxn_seq();	--! < generation id for test data row
   INSERT INTO business.wire_trxn(
   FO_TRXN_SEQ_ID,
   TRXN_INTRL_REF_ID,
   TRXN_EXCTN_DT,
   RF_CREDIT_CD,
   RF_DEBIT_CD,
   INTRL_ORIG_ACCT_FL,
   RF_SEND_INSTN_CNTRY_CD,
   RF_ORIG_INN_NB,
   TRXN_BASE_AM,
   orig_nm,
   benef_nm,
   BENEF_ACCT_ID
   )
   VALUES(
   TO_CHAR(trxn_row_id),
   trxn_row_id,
   'test_1',
   TO_DATE('01.04.2016', 'dd.mm.yyyy'),
   '40501810877771200000',
   '40504810877771500000',
   'N',
   'RU',
   '7743121210',
   100000,
   'test_1499_236-T',
   'test_1499_236-T',
   '128371928'
   );
   element_w := element_w + 1;
   END LOOP;
  END;
  
/* main block for insert row in CUST, ACCT, WIRE_TRXN
 *
 */
DECLARE
/* common data for all table and row */
 full_nm_const varchar2(2000) := 'test_1499_236-T';
 cust_type_cd_const varchar2(10) := 'ORG';    --! < CUST
 prcsng_batch_nm_const varchar2(20) := 'DLY';    --! < CUST, ACCT
 jrsdcn_cd_const varchar2(4) := 'RF';    --! < CUST, ACCT
 bus_dmn_list_tx_const varchar2(65) := 'a';     --! < CUST, ACCT
 cust_stat_cd_const varchar2(1) := 'A';     --! < CUST
 acct_efctv_risk_nb_const number(3) := 0;    --! < ACCT
 mantas_acct_purp_cd_const varchar2(20) := 'O';   --! < ACCT
 retrmt_acct_fl_const varchar2(1) := 'N';    --! < ACCT
 rf_partition_key_const number(38) := 38064;     --! < ACCT
 day_year_const number(4) := 366;    --! < ACCT
 
 TYPE arr_index_arrType IS TABLE OF varchar2(20);
 arr_index arr_index_arrType := arr_index_arrType(
 'cust_1_',	--! < prefix of  index name for Customer-1
 'cust_2_',	--! < prefix of index name for Customer-2
 'cust_3_'	--! < prefix of index name for Customer-3
 );
/* start test data for BUSINESS.CUST */
  /* variable data for specific test case */
 TYPE inn_arr_arrType IS TABLE OF  varchar2(20);
 inn_arr inn_arr_arrType := inn_arr_arrType(	--! < indexed array for variable test data
 '7743123450',	--! < valid for test case, Customer-1
 '7743123470',	--! < not valid for test case, Customer-2
 '9932456780'	--! < not valid for test case, Customer-3
 );
/* end test data for BUSINESS.CUST */
/* start test data for BUSINESS.ACCT */
  /* variable data for specific test case */
 TYPE alt_acct_id_arrType IS TABLE OF varchar2(50);
 alt_acct_id_arr_c1 alt_acct_id_arrType := alt_acct_id_arrType(	--idexed array for list of the account number linked to the client (order by prmry_cust_intrl_id)
 '40501810877771200000',	--! < valid for test case, Customer-1
 '40502810877771300000',	--! < valid for test case, Customer-1
 '40503810877771400000',	--! < valid for test case, Customer-1
 '40504810877771500000',	--! < valid for test case, Customer-1
 '40505810877771600000',	--! < valid for test case, Customer-1
 '40605810877770960000',	--! < valid for test case, Customer-1
 '40701810877770701000',	--! < valid for test case, Customer-1
 '40702810877770702000',	--! < valid for test case, Customer-1
 '40703810877770703000',	--! < valid for test case, Customer-1
 '40704810877770704000',	--! < valid for test case, Customer-1
 '40705810877770705000',	--! < valid for test case, Customer-1
 '40802810877770802000'	--! < valid for test case, Customer-1
 );
 alt_acct_id_arr('cust_2_1') := '40503810877771500000';	--not valid for test case, Customer-2
 alt_acct_id_arr('cust_2_2') := '40603810877770940000';	--! < valid for test case, Customer-2
 alt_acct_id_arr('cust_2_3') := '40604810877770950000';	--! < valid for test case, Customer-2
 alt_acct_id_arr('cust_3_1') := '40505810877771700000';	--not valid for test case, Customer-3
 alt_acct_id_arr('cust_3_2') := '40602810877770930000';	--! < valid for test case, Customer-3
 open_dt date;
/* end test data for BUSINESS.ACCT */
/* start test data for BUSINESS.WIRE_TRXN */
  /* variable data for specific test case */
 TYPE trxn_intrl_ref_id_arrType IS TABLE OF varchar2(50);
 trxn_intrl_ref_id_arr trxn_intrl_ref_id_arrType := trxn_intrl_ref_id_arrType(	--! < internal reference id
 
 );
 TYPE rf_credit_cd_arrType IS TABLE OF varchar2(64);
 rf_credit_cd_arr rf_credit_cd_arrType := rf_credit_cd_arrType(	--! < account number group by benef_acct_id
 
 );
/* end test data for BUSINESS.WIRE_TRXN */
/* unique data */
 cust_row_id number;
 acct_row_id number;
 trxn_row_id number;
/* service data for SQL-script */
 element_c INTEGER;    --! < loop counter for CUST
 element_a INTEGER;    --! < loop counter for ACCT
 element_w INTEGER := 1;    --! < loop counter for WIRE_TRXN
 index_c varchar2;	--! < key for CUST
 index_a varchar2;	--! < key for ACCT
 index_w varchar2;	--! < key for WIRE_TRXN
BEGIN    --! < block for BUSINESS.CUST
 element_c := 1;		--! < initial settings of the counter
 WHILE (element_c<=inn_arr.COUNT) LOOP    --! < loop for insert row
 cust_row_id := STD.aml_tools.get_new_cust_seq_id();   --! < generation id for test data row
 index_c := CONCAT(arr_index(element_c), TO_CHAR(element_c));	--! < index definition
 INSERT INTO business.cust(
 cust_intrl_id,    --! < 1
 cust_seq_id,    --! < 3
 data_dump_dt,    --! < 2
 FULL_NM,    --! < 52
 tax_id,    --! < 7
 CUST_TYPE_CD,    --! < 5
 PRCSNG_BATCH_NM,    --! < 85
 JRSDCN_CD,    --! < 86
 BUS_DMN_LIST_TX,    --! < 87
 CUST_STAT_CD    --! < 95
 )
 VALUES(
 TO_CHAR(cust_row_id),   --! < 1
 cust_row_id,    --! < 3
 TRUNC(sysdate),    --! < 2
 full_nm_const,    --! < 52
 inn_arr(index_c),    --! < 7
 cust_type_cd_const,    --! < 5
 prcsng_batch_nm_const,    --85
 jrsdcn_cd_const,    --! < 86
 bus_dmn_list_tx_const,    --! < 87
 cust_stat_cd_const    --! < 95
 );
 BEGIN    --! < block for BUSINESS.ACCT
  id := 1;
  WHILE (id <= 
  element_a := 1;	--! < initial settings of the counter
  
  WHILE (element_a <= alt_acct_id_arr.COUNT) LOOP
  acct_row_id := STD.aml_tools.get_new_acct_seq_id();
  open_dt := TRUNC(sysdate - day_year_const - element_a);    --! < calculate of the date ~1 years ago
  index_a := CONCAT(arr_index(element_c), TO_CHAR(element_a));	--! < index definition
  INSERT INTO business.acct(
  acct_intrl_id,    --! < 1
  acct_seq_id,  --! < 3
  alt_acct_id,      --! < 27
  acct_open_dt,     --! < 10
  prmry_cust_intrl_id,      --! < 45
  data_dump_dt,    --! < 2
  ACCT_EFCTV_RISK_NB,    --! < 46
  PRCSNG_BATCH_NM,      --! < 72
  MANTAS_ACCT_PURP_CD,   --! < 78
  RETRMT_ACCT_FL,    --! < 79
  JRSDCN_CD,     --! < 80
  BUS_DMN_LIST_TX,    --! < 81
  RF_PARTITION_KEY    --! < 159
  )
  VALUES(
  TO_CHAR(acct_row_id),     --! < 1
  acct_row_id,      --3
  alt_acct_id_arr(index_a),    --! < 27
  TO_DATE(open_dt, 'dd.mm.yyyy'),     --! < 10
  TO_CHAR(cust_row_id),     --! < 45 link to BUSINESS.CUST.CUST_INTRL_ID
  TRUNC(sysdate),    --! < 2
  acct_efctv_risk_nb_const,    --! < 46
  prcsng_batch_nm_const,    --! < 72
  mantas_acct_purp_cd_const,   --! < 78
  retrmt_acct_fl_const,    --! < 79
  jrsdcn_cd_const,     --! < 80
  bus_dmn_list_tx_const,    --! < 81
  rf_partition_key_const    --! < 159
  );
  --! < TODO: add procedure <name> for insert row in wire_trxn
  element_a := element_a + 1;    --! < increment of loop counter
  END LOOP;
 END;
 element_c := element_c + 1;    --! < increment of loop counter
 END LOOP;
END;

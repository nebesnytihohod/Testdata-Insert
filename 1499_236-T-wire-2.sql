/** main block for insert row in CUST, ACCT, WIRE_TRXN
 *
 * Author: Stasenkov M.
 * E-mail: MVStasenkov.SBT@sberbank.ru
 * Date: December 2016
 * Purpose: Script inserts rows with "synthetic" test data considering dependences between tables.
 * Scenario: 1499 236-T (data for table BUSINESS.CUST, BUSINESS.ACCT, BUSINESS.WIRE_TRXN)
 *
 * Structure of the script:
 * declaration block
 *     block of constant data
 *     blocks of variable data for each table
 *     block of service data and script variables
 * block (first level) for insert data into CUST
 *  cust_seq_id (in var *cust_row_id*) <-- generating in function STD.AML_TOOLS.get_new_cust_seq_id()
 *   |
 *   | block (second level) for insert data into ACCT
 *   +-->prmry_cust_intrl_id
 *         acct_seq_id (in var *acct_row_id*) <-- generating in function STD.AML_TOOLS.get_new_acct_seq_id()
 *          |
 *          | block (third level) for insert data into WIRE_TRXN
 *          +-->benef_acct_id
 *                fo_trxn_seq_id (in var *trxn_row_id*) <-- generating in function STD.AML_TOOLS.get_new_trxn_seq()
 */
DECLARE
/* common data for all table and row */
 full_nm_const varchar2(2000) := 'test_1499_236-T';		-- CUST
 orig_nm_const varchar2(350) := 'test_1499_236-T';		-- WIRE
 benef_nm_const varchar2(350) := 'test_1499_236-T';		-- WIRE
 cust_type_cd_const varchar2(10) := 'ORG';		-- CUST
 prcsng_batch_nm_const varchar2(20) := 'DLY';		-- CUST, ACCT, WIRE
 jrsdcn_cd_const varchar2(4) := 'RF';		-- CUST, ACCT
 bus_dmn_list_tx_const varchar2(65) := 'a';	-- CUST, ACCT
 cust_stat_cd_const varchar2(1) := 'A';		-- CUST
 acct_efctv_risk_nb_const number(3) := 0;	-- ACCT
 mantas_acct_purp_cd_const varchar2(20) := 'O';		-- ACCT
 retrmt_acct_fl_const varchar2(1) := 'N';		-- ACCT
 rf_partition_key_const number(38) := 38064;	-- ACCT
 day_year_const number(4) := 366;		-- ACCT
 unkwn_orig_fl_const varchar2(1) := 'N';	-- WIRE
 unkwn_benef_fl_const varchar2(1) := 'N';	-- WIRE
 unkwn_scnd_benef_fl_const varchar2(20) := 'N';	-- WIRE
 send_instn_rlshp_cd_const varchar2(1) := 'O';		-- WIRE
 rcv_instn_rlshp_cd_const varchar2(1) := 'O';		-- WIRE
 mantas_trxn_asset_class_cd_c varchar2(20) := 'FUNDS'; --WIRE
 mantas_trxn_purp_cd_const varchar2(20) := 'GENERAL'; --WIRE
 mantas_trxn_prdct_cd_const varchar2(30) := 'EFT-OTHER'; --WIRE
 mantas_trxn_chanl_cd_const varchar2(20) := 'N'; --WIRE
 rf_active_partition_flag_const number(38) := 0; -- WIRE
 rf_subpartition_key_const number(38) := 38064; -- WIRE
 
/* start test data for BUSINESS.CUST */
  /* variable data for specific test case */
 TYPE inn_arr_arrType IS TABLE OF  varchar2(20);
 inn_arr inn_arr_arrType := inn_arr_arrType(	--! < indexed array for variable test data
 '7743123450',	-- valid for test case, Customer-1
 '7743123470',	-- not valid for test case, Customer-2
 '9932456780'	-- not valid for test case, Customer-3
 );
/* end test data for BUSINESS.CUST */
/* start test data for BUSINESS.ACCT */
  /* variable data for specific test case */
 TYPE alt_acct_id_arrType IS TABLE OF varchar2(50);
 alt_acct_id_arr_cust_1 alt_acct_id_arrType := alt_acct_id_arrType(	--! < indexed array for list of the account number linked to the client (order by prmry_cust_intrl_id)
 '40501810877771200000',	-- valid for test case, Customer-1
 '40502810877771300000',	-- valid for test case, Customer-1
 '40503810877771400000',	-- valid for test case, Customer-1
 '40504810877771500000',	-- valid for test case, Customer-1
 '40505810877771600000',	-- valid for test case, Customer-1
 '40605810877770960000',	-- valid for test case, Customer-1
 '40701810877770701000',	-- valid for test case, Customer-1
 '40702810877770702000',	-- valid for test case, Customer-1
 '40703810877770703000',	-- valid for test case, Customer-1
 '40704810877770704000',	-- valid for test case, Customer-1
 '40705810877770705000',	-- valid for test case, Customer-1
 '40802810877770802000'	-- valid for test case, Customer-1
 );
 alt_acct_id_arr_cust_2 alt_acct_id_arrType := alt_acct_id_arrType(	--! < indexed array for list of the account number linked to the client (order by prmry_cust_intrl_id)
 '40503810877771500000',	-- not valid for test case, Customer-2
 '40603810877770940000',	-- valid for test case, Customer-2
 '40604810877770950000'	-- valid for test case, Customer-2
 );
 alt_acct_id_arr_cust_3 alt_acct_id_arrType := alt_acct_id_arrType(	--! < indexed array for list of the account number linked to the client (order by prmry_cust_intrl_id)
 '40505810877771700000',	-- not valid for test case, Customer-3
 '40602810877770930000'	-- valid for test case, Customer-3
 );
 TYPE alt_acct_id_2XarrType IS TABLE OF alt_acct_id_arrType;
 account_id_arr alt_acct_id_2XarrType;
/* end test data for BUSINESS.ACCT */
/* start test data for BUSINESS.WIRE_TRXN */
  /* variable data for specific test case */
 TYPE wire_arrType IS TABLE OF varchar2(70);
 /*sequence of field with test data
           1         \       2       \      3         \      4        \          5          \           6              \       7          \       8      \     9
  3:trxn_intrl_ref_id\7:trxn_exctn_dt\192:rf_credit_cd\191:rf_debit_cd\71:intrl_orig_acct_fl\287:rf_send_instn_cntry_cd\233:rf_orig_inn_nb\8:trxn_base_am\72:intrl_benef_acct_fl
  - use of field #2: values of delta to calculate action date.
 */
 wire_arr_1 wire_arrType := wire_arrType(	--! < array of the test data for wire_trxn (order by benef_acct_id)
'test_1','244','40501810877771200000','40504810877771500000','N','RU','7743121210','100000','Y',
'test_2','16','40501810877771200000','20201810877776600000','N','RU','771102553800','150000','Y',
'test_3','16','40501810877771200000','40504810877771500000','N','RU','7743123450','12000','Y',
'test_4','16','40501810877771200000','40504810877771500000','N','RU','7743123450','15000','Y',
'test_5','16','40501810877771200000','40504810877771500000','N','RU','7743123450','2001000','Y',
'test_6','16','40501810877771200000','40504810877771500000','N','RU','7743123460','545000','Y',
'test_7','16','40501810877771200000','40504810877771500000','N','RU','7743123470','320000','Y',
'test_8','16','40501810877771200000','40504810877771500000','N','RU','7743123480','620000','Y',
'test_9','16','40501810877771200000','40504810877771500000','N','RU','7743123490','65000','Y',
'test_10','15','40501810877771200000','40504810877771500000','N','RU','7743123460','430000','Y',
'test_11','15','40501810877771200000','40504810877771500000','N','RU','7743123470','740000','Y',
'test_12','15','40501810877771200000','40504810877771500000','N','RU','7743111110','7001000','Y',
'test_13','15','40501810877771200000','40504810877771500000','N','RU','7743222220','5000000','Y',
'test_14','15','40501810877771200000','40504810877771500000','N','RU','7743444440','260000','Y',
'test_15','16','40501810877771200000','40504810877771500000','N','RU','7743','100500','Y',
'test_16','16','40501810877771200000','40504810877771500000','Y','RU','7743123460','100500','Y',
'test_17','17','40502810877771300000','44001810877776600000','N','RU','7743123450','100500','Y',
'test_36','13','40605810877770960000','40501810877771200000','Y','RU','7734123450','990000','Y',
'test_37','12','40505810877771600000','40605810877770960000','N','RU','9932888880','280000','Y',
'test_41','10','40505810877771600000','40605810877770960000','N','RU','9932777770','700000','Y',
'test_45','3','40505810877771600000','40605810877770960000','N','RU','9933111110','933000','Y',
'test_50','51','40505810877771600000','40605810877770960000','N','RU','7743123460','100500','Y',
'test_62','31','40605810877770960000','40703810877770703000','N','RU','9932456780','100000','Y',
'test_69','26','40503810877771400000','40501810877771200000','Y','RU','7734123450','5000100','Y',
'test_71','30','40802810877770802000','47901810877776600000','N','RU','7733555550','406000','Y',
'test_75','29','70001810877776600000','40501810877771200000','N','RU','99341','994300','Y',
'test_156','171','40401810877774010000','40501810877771200000','N','RU','7743123450','100000','Y',
'test_157','169','40401810877774010000','40501810877771200000','N','RU','7743123450','15000','Y',
'test_158','168','40402810877774020000','40501810877771200000','N','RU','7743123450','100000','Y',
'test_159','167','40403810877774030000','40501810877771200000','N','RU','7743123450','250000','Y',
'test_160','141','40405810877774050000','40501810877771200000','N','RU','7743123450','158000','Y',
'test_161','141','40411810877776600000','40501810877771200000','N','RU','7743123450','100','Y',
'test_162','140','40407810877774070000','40501810877771200000','N','RU','7743123450','12010','Y',
'test_163','112','40409810877774090000','40501810877771200000','N','RU','7743123450','5000100','Y',
'test_164','111','40410810877774100000','40501810877771200000','N','RU','7743123450','150000','Y',
'test_165','45','40101810877771010000','40501810877771200000','N','RU','7743123450','120000','Y',
'test_166','45','40102810877776600000','40501810877771200000','N','RU','7743123450','100','Y',
'test_167','44','40201810877772010000','40501810877771200000','N','RU','7743123450','100000','Y',
'test_168','17','40405810877774050000','40501810877771200000','N','RU','7743123450','100000','Y',
'test_169','16','40201810877772010000','40501810877771200000','N','RU','7743123450','19000','Y',
'test_170','171','40401810877774010000','40501810877771200000','N','RU','7743123450','700000','Y',
'test_171','169','40401810877776600000','40501810877771200000','N','RU','7743123450','100','Y',
'test_172','168','40501810877771200000','40501810877771200000','N','RU','7743123450','27000000','Y',
'test_173','167','40602810877770900000','40501810877771200000','N','RU','7743123450','150000','Y',
'test_174','141','40405810877776600000','40501810877771200000','N','RU','7743123450','100','Y',
'test_175','141','40411810877774110000','40501810877771200000','N','RU','7743123450','150000000','Y',
'test_176','140','40407810877776600000','40501810877771200000','N','RU','7743123450','100','Y',
'test_177','112','40703810877770703000','40501810877771200000','N','RU','7743123450','190000000','Y',
'test_178','111','40803810877778030000','40501810877771200000','N','RU','7743123450','270000000','Y',
'test_179','45','40101810877776600000','40501810877771200000','N','RU','7743123450','100','Y',
'test_180','45','40102810877771020000','40501810877771200000','N','RU','7743123450','77000000','Y',
'test_181','44','40201810877776600000','40501810877771200000','N','RU','7743123450','100','Y',
'test_182','17','40706810877770706000','40501810877771200000','N','RU','7743123450','120000000','Y',
'test_183','16','40607810877776070000','40501810877771200000','N','RU','7743123450','79496000','Y',
'test_18','18','40503810877771400000','44101810877776600000','N','RU','7743123460','100500','Y',
'test_19','19','40503810877771400000','40604810877770950000','N','RU','7743123470','405000','Y',
'test_20','17','40503810877771400000','40604810877770900000','N','RU','7743123470','40600','Y',
'test_21','17','40503810877771400000','40604810877770900000','N','RU','7734010100','305000','Y',
'test_22','17','40503810877771400000','40604810877770900000','N','RU','7734101010','40600','Y',
'test_23','17','40503810877771400000','40604810877770900000','N','RU','7732888880','77300','Y',
'test_24','17','40503810877771400000','40604810877770900000','N','RU','7733555550','550000','Y',
'test_25','17','40503810877771400000','40604810877770900000','N','RU','9943111110','99430','Y',
'test_26','19','40503810877771400000','40604810877770900000','N','RU','7743123470','100500','Y',
'test_27','19','40503810877771400000','40604810877770900000','N','RU','9909774310','100500','Y',
'test_28','19','40503810877771400000','40604810877770900000','N','US','9909774320','100500','Y',
'test_29','18','40504810877771500000','44201810877776600000','N','RU','7734987650','10050','Y',
'test_30','17','40505810877771600000','44301810877776600000','N','RU','7734987650','100500','Y',
'test_112','49','40501810877771200000','40504810877771500000','N','RU','7743123450','9943000','Y',
'test_113','48','40501810877771200000','40504810877771500000','N','RU','7743123450','100500','Y',
'test_116','45','40501810877771200000','40504810877771500000','N','RU','7743123450','506000','Y',
'test_117','42','40501810877771200000','40504810877771500000','N','RU','7743123450','9000000','Y',
'test_146','42','40501810877771200000','40504810877771500000','N','RU','7743123450','100500','Y',
'test_147','41','40501810877771200000','40504810877771500000','N','RU','7743123450','405000','Y',
'test_152','33','40501810877771200000','40504810877771500000','N','RU','7743123450','405000','Y',
'test_153','32','40501810877771200000','40504810877771500000','N','RU','7743123450','305000','Y',
'test_31','1','40505810877771600000','40605810877770960000','N','RU','9932456780','50500','Y',
'test_32','14','40505810877771600000','40605810877770960000','N','RU','9932456780','605000','Y',
'test_33','14','40505810877771600000','40605810877770960000','N','RU','9932456780','506000','Y',
'test_34','14','40505810877771600000','40605810877770960000','N','RU','9932456780','900000','Y',
'test_35','14','40504810877771500000','40501810877771200000','Y','RU','7743123450','130000','Y',
'test_38','12','40505810877771600000','40605810877770960000','N','RU','9932888880','34000','Y',
'test_39','12','40505810877771600000','40605810877770960000','N','RU','9932888880','32000','Y',
'test_40','12','40705810877770705000','40501810877771200000','Y','RU','7734123450','975000','Y',
'test_42','9','40505810877771600000','40605810877770960000','N','RU','9932666660','405050','Y',
'test_43','8','40505810877771600000','40605810877770960000','N','RU','9932555550','250000','Y',
'test_44','4','40605810877770960000','40501810877771200000','Y','RU','7734123450','99000','Y',
'test_46','2','40505810877771600000','40605810877770960000','N','RU','9933222220','100000','Y',
'test_47','1','40505810877771600000','40605810877770960000','N','RU','9933444440','100000','Y',
'test_48','1','40505810877771600000','40605810877770960000','N','RU','9932456780','100500','Y',
'test_51','51','40601810877770940000','44401810877776600000','N','RU','7743123470','100500','Y',
'test_52','50','40602810877770930000','44501810877776600000','N','RU','7734987650','100500','Y',
'test_56','18','40605810877770960000','40703810877770703000','N','RU','9932456710','400000','Y',
'test_57','18','40605810877770960000','40703810877770703000','N','RU','9932456710','3230000','Y',
'test_58','18','40605810877770960000','40703810877770703000','N','RU','9932456710','99000','Y',
'test_59','18','40605810877770960000','40703810877770703000','N','RU','9932456710','933000','Y',
'test_60','18','40605810877770960000','40703810877770703000','N','RU','773312345600','100000','Y',
'test_61','18','40802810877770802000','40501810877771200000','Y','RU','7734123450','13057000','Y',
'test_63','31','40701810877770701000','47101810877776600000','N','RU','9932456710','100500','Y',
'test_64','18','40702810877770702000','47201810877776600000','N','RU','773312345600','100500','Y',
'test_65','18','40703810877770703000','47301810877776600000','N','RU','7743123470','100500','Y',
'test_66','18','40704810877770704000','47401810877776600000','N','RU','7734987650','100500','Y',
'test_107','54','40605810877770960000','40703810877770703000','N','RU','7743123450','406000','Y',
'test_111','50','40605810877770960000','40703810877770703000','N','RU','7743123450','550000','Y',
'test_115','46','40605810877770960000','40703810877770703000','N','RU','7743123450','605000','Y',
'test_119','35','40605810877770960000','40703810877770703000','N','RU','7743123450','280000','Y',
'test_120','83','40605810877770960000','40703810877770703000','N','RU','7743123450','340000','Y',
'test_122','81','40605810877770960000','40703810877770703000','N','RU','7743123450','550000','Y',
'test_125','78','40605810877770960000','40703810877770703000','N','RU','7743123450','505000','Y',
'test_128','74','40605810877770960000','40703810877770703000','N','RU','7743123450','9000000','Y',
'test_149','38','40605810877770960000','40703810877770703000','N','RU','7743123450','773000','Y',
'test_151','34','40605810877770960000','40703810877770703000','N','RU','7743123450','100500','Y',
'test_155','30','40605810877770960000','40703810877770703000','N','RU','7743123450','773000','Y',
'test_67','27','40704810877770704000','40602810877770900000','N','RU','7734987650','4050','Y',
'test_68','27','40802810877770802000','40501810877771200000','Y','RU','7734123450','4120000','Y',
'test_70','27','40705810877770705000','47501810877776600000','N','RU','7733555550','305000','Y',
'test_118','36','40802810877770802000','40704810877770704000','N','RU','7743123450','990000','Y',
'test_121','82','40802810877770802000','40704810877770704000','N','RU','7743123450','773000','Y',
'test_124','79','40802810877770802000','40704810877770704000','N','RU','9932456780','100500','Y',
'test_127','74','79901810877776600000','40704810877770704000','N','RU','7743123450','506000','Y',
'test_139','57','40604810877770900000','40704810877770704000','N','RU','7743123450','605000','Y',
'test_148','39','40802810877770802000','40704810877770704000','N','RU','7743123450','406000','Y',
'test_72','30','40802810877770802000','40702810877770702000','N','RU','7733555550','77300','Y',
'test_73','30','40602810877770900000','40501810877771200000','Y','RU','7734123450','856900','Y',
'test_74','30','40802810877770802000','40702810877770702000','N','RU','99340','550000','Y',
'test_76','28','70101810877776600000','40505810877771600000','N','RU','9909774320','105000','Y',
'test_77','27','70201810877776600000','40601810877770940000','N','RU','9909774330','150000','Y',
'test_78','26','78001810877776600000','40605810877770960000','N','RU','9932456780','120000','Y',
'test_79','25','78901810877776600000','40701810877770701000','N','RU','9932456710','150000','Y',
'test_80','29','44001810877776600000','40802810877770802000','N','RU','9932456780','5450000','Y',
'test_81','28','44101810877776600000','40504810877771500000','N','RU','9932456780','320000','Y',
'test_82','27','47001810877776600000','40704810877770704000','N','RU','9932456780','620000','Y',
'test_83','26','47901810877776600000','40802810877770802000','N','RU','9932456780','6500000','Y',
'test_84','81','70001810877776600000','40802810877770802000','N','RU','9932456780','430000','Y',
'test_85','81','40802810877770802000','40704810877770704000','N','RU','7743123450','740000','Y',
'test_86','80','40605810877770960000','40703810877770703000','N','RU','7743123450','10500000','Y',
'test_87','79','40605810877770960000','40703810877770703000','N','RU','7743123450','150000','Y',
'test_88','78','40605810877770960000','40703810877770703000','N','RU','7743123450','120000','Y',
'test_89','77','40704810877770704000','40802810877770802000','N','RU','7743123450','150000','Y',
'test_90','76','79901810877776600000','40704810877770704000','N','RU','7743123450','2001000','Y',
'test_92','75','44001810877776600000','40802810877770802000','N','RU','7743123450','320000','Y',
'test_100','63','40604810877770900000','40704810877770704000','N','RU','7743123450','150000','Y',
'test_108','53','40704810877770704000','40802810877770802000','N','RU','7743123450','305000','Y',
'test_123','79','70001810877776600000','40802810877770802000','N','RU','9932456780','9943000','Y',
'test_126','76','40704810877770704000','40802810877770802000','N','RU','7743123450','605000','Y',
'test_130','71','44001810877776600000','40802810877770802000','N','RU','7743123450','406000','Y',
'test_131','71','40704810877770704000','40802810877770802000','N','RU','7743123450','773000','Y'
 );
 wire_arr_2 wire_arrType := wire_arrType(
'test_54','29','40604810877770950000','44701810877776600000','N','RU','9909774330','100500','Y',
'test_55','241','40605810877770960000','47001810877776600000','N','RU','9932456780','100500','Y',
'test_93','75','40503810877771400000','40604810877770950000','N','RU','7743123450','406000','Y',
'test_94','71','40704810877770704000','40604810877770950000','N','RU','7743123450','305000','Y',
'test_95','70','40503810877771400000','40604810877770950000','N','RU','7743123450','406000','Y',
'test_96','69','40503810877771400000','40604810877770950000','N','RU','7743123450','773000','Y',
'test_97','66','40503810877771400000','40604810877770950000','N','RU','7743123450','550000','Y',
'test_98','65','40503810877771400000','40604810877770950000','N','RU','7743123450','9943000','Y',
'test_99','64','40503810877771400000','40604810877770950000','N','RU','7743123450','10500000','Y',
'test_101','59','40503810877771400000','40604810877770950000','N','RU','7743123450','120000','Y',
'test_104','57','40503810877771400000','40604810877770950000','N','RU','7743123450','2001000','Y',
'test_106','55','40503810877771400000','40604810877770950000','N','RU','7743123450','320000','Y',
'test_110','51','40503810877771400000','40604810877770950000','N','RU','7743123450','773000','Y',
'test_114','47','40503810877771400000','40604810877770950000','N','RU','7743123450','505000','Y',
'test_132','70','40503810877771400000','40604810877770950000','N','RU','7743123450','550000','Y',
'test_133','69','40704810877770704000','40604810877770950000','N','RU','7743123450','9943000','Y',
'test_134','66','40503810877771400000','40604810877770950000','N','RU','7743123450','100500','Y',
'test_135','63','40503810877771400000','40604810877770950000','N','RU','7743123450','505000','Y',
'test_136','60','40503810877771400000','40604810877770950000','N','RU','7743123450','9803000','Y',
'test_137','59','40503810877771400000','40604810877770950000','N','RU','7743123450','100500','Y',
'test_138','58','40503810877771400000','40604810877770950000','N','RU','7743123450','505000','Y',
'test_140','52','40503810877771400000','40604810877770900000','N','RU','7743123450','506000','Y',
'test_144','49','40503810877771400000','40604810877770900000','N','RU','7743123450','773000','Y',
'test_150','35','40503810877771400000','40604810877770950000','N','RU','7743123450','550000','Y',
'test_154','31','40503810877771400000','40604810877770950000','N','RU','7743123450','406000','Y'
 );
 wire_arr_3 wire_arrType := wire_arrType(
'test_49','1','40505810877771600000','40501810877771200000','Y','RU','7734123450','3850000','Y',
'test_53','30','40603810877770940000','44601810877776600000','N','RU','9909774320','100500','Y',
'test_91','76','40704810877770704000','40602810877770930000','N','RU','7743123450','5450000','Y',
'test_102','58','73101810877776600000','40602810877770930000','N','RU','7743123450','5450000','Y',
'test_103','58','40704810877770704000','40602810877770930000','N','RU','7743123450','2001000','Y',
'test_105','56','40704810877770704000','40602810877770930000','N','RU','7743123450','2001000','Y',
'test_109','52','40704810877770704000','40602810877770930000','N','RU','7743123450','406000','Y',
'test_129','72','40704810877770704000','40602810877770930000','N','RU','7743123450','406000','Y',
'test_141','51','73101810877776600000','40602810877770930000','N','RU','7743123450','406000','Y',
'test_142','51','40704810877770704000','40602810877770930000','N','RU','7743123450','406000','Y',
'test_143','50','40704810877770704000','40602810877770930000','N','RU','7743123450','406000','Y',
'test_145','43','40704810877770704000','40602810877770930000','N','RU','7743123450','406000','Y'
 );
 TYPE wire_2XarrType IS TABLE OF wire_arrType;
 wire_arr wire_2XarrType;
/* end test data for BUSINESS.WIRE_TRXN */

/* unique data */
 cust_row_id number;
 acct_row_id number;
 trxn_row_id number;
 open_dt date;
 date_oper date;		--! < operation date foe WIRE_TRXN. Calculate parameter.
/* service data for SQL-script */
 element_c INTEGER := 0;	--! < loop counter for CUST
 element_a INTEGER := 0;	--! < loop counter for ACCT
 element_w INTEGER := 0;	--! < loop counter for WIRE_TRXN
 index_w_field1 INTEGER := 1;	--! < starting value for calculate position number in array (wire_arr_...) of the test data for wire_trxn
 index_w_field2 INTEGER := 2;
 index_w_field3 INTEGER := 3;
 index_w_field4 INTEGER := 4;
 index_w_field5 INTEGER := 5;
 index_w_field6 INTEGER := 6;
 index_w_field7 INTEGER := 7;
 index_w_field8 INTEGER := 8;
 index_w_field9 INTEGER := 9;
 
BEGIN		--! < block for BUSINESS.CUST
 element_c := 1;	--! < loop counter for CUST

  account_id_arr := alt_acct_id_2XarrType(
  alt_acct_id_arr_cust_1,
  alt_acct_id_arr_cust_2,
  alt_acct_id_arr_cust_3
  );
  
  wire_arr := wire_2XarrType(
  wire_arr_1,
  wire_arr_2,
  wire_arr_3
  );

 WHILE (element_c<=inn_arr.COUNT) LOOP    --! < loop for insert row
 cust_row_id := STD.aml_tools.get_new_cust_seq_id();   --! < generation id for test data row
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
 TO_CHAR(cust_row_id),   -- 1
 cust_row_id,    -- 3
 TRUNC(sysdate),    -- 2
 full_nm_const,    -- 52
 inn_arr(element_c),    -- 7
 cust_type_cd_const,    -- 5
 prcsng_batch_nm_const,    --85
 jrsdcn_cd_const,    --  86
 bus_dmn_list_tx_const,    -- 87
 cust_stat_cd_const    -- 95
 );
 COMMIT;

 BEGIN    --! < block for BUSINESS.ACCT
  element_a := 1;	--! < loop counter for ACCT

  WHILE (element_a <= account_id_arr(element_a).COUNT) LOOP
  acct_row_id := STD.aml_tools.get_new_acct_seq_id();
  open_dt := TRUNC(sysdate - day_year_const - element_a);    --! < calculate of the date ~1 years ago
  
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
  TO_CHAR(acct_row_id),     -- 1
  acct_row_id,      --3
  account_id_arr(element_c)(element_a),    -- 27
  TO_DATE(open_dt, 'dd.mm.yyyy'),     -- 10
  TO_CHAR(cust_row_id),     --! < 45 link to BUSINESS.CUST.CUST_INTRL_ID
  TRUNC(sysdate),    -- 2
  acct_efctv_risk_nb_const,    -- 46
  prcsng_batch_nm_const,    -- 72
  mantas_acct_purp_cd_const,   -- 78
  retrmt_acct_fl_const,    -- 79
  jrsdcn_cd_const,     -- 80
  bus_dmn_list_tx_const,    -- 81
  rf_partition_key_const    -- 159
  );
  COMMIT;
  
  BEGIN	--! < block for BUSINESS.WIRE_TRXN
 element_w := 1;	--! < loop counter for WIRE_TRXN
 index_w_field1 := 1;	--! < starting value for calculate position number in array (wire_arr_...) of the test data for wire_trxn
 index_w_field2 := 2;
 index_w_field3 := 3;
 index_w_field4 := 4;
 index_w_field5 := 5;
 index_w_field6 := 6;
 index_w_field7 := 7;
 index_w_field8 := 8;
 index_w_field9 := 9;

  WHILE (element_w <= (wire_arr(element_a).COUNT / 9)) LOOP
   trxn_row_id := std.AML_TOOLS.get_new_trxn_seq();	--! < generation id for test data row
   date_oper := TRUNC(sysdate - TO_NUMBER(wire_arr(element_a)(index_w_field2)));	--! < calculate of the operation date
   
   INSERT INTO business.wire_trxn(
   fo_trxn_seq_id,		-- 1
   data_dump_dt,		-- 2
   trxn_intrl_ref_id,		-- 3
   trxn_exctn_dt,		-- 7
   rf_credit_cd,		-- 192
   rf_debit_cd,		-- 191
   intrl_orig_acct_fl,		-- 71
   rf_send_instn_cntry_cd,		-- 287
   rf_orig_inn_nb,		-- 233
   trxn_base_am,		-- 8
   ORIG_NM,		-- 12
   BENEF_NM,		-- 19
   benef_acct_id,		-- 21
   UNKWN_ORIG_FL,		-- 68
   UNKWN_BENEF_FL,		-- 69
   UNKWN_SCND_BENEF_FL,		-- 70
   intrl_benef_acct_fl,		-- 72
   intrl_scnd_benef_acct_fl,		-- 73
   SEND_INSTN_RLSHP_CD,		 -- 74
   RCV_INSTN_RLSHP_CD,		-- 75
   PRCSNG_BATCH_NM, -- 90
   MANTAS_TRXN_ASSET_CLASS_CD, -- 99
   MANTAS_TRXN_PURP_CD, -- 100
   MANTAS_TRXN_PRDCT_CD, -- 101
   MANTAS_TRXN_CHANL_CD, -- 103
   RF_ACTIVE_PARTITION_FLAG, -- 297
   RF_SUBPARTITION_KEY -- 299
   )
   VALUES(
    trxn_row_id,		-- 1
    TRUNC(sysdate),		-- 2
    wire_arr(element_a)(index_w_field1),		-- 3
    TO_DATE(date_oper, 'dd.mm.yyyy'),		-- 7
    wire_arr(element_a)(index_w_field3),		-- 192
    wire_arr(element_a)(index_w_field4),		-- 191
    wire_arr(element_a)(index_w_field5),		-- 71
    wire_arr(element_a)(index_w_field6),		-- 287
    wire_arr(element_a)(index_w_field7),		-- 233
    TO_NUMBER(wire_arr(element_a)(index_w_field8)),		-- 8
    orig_nm_const,		-- 12
    benef_nm_const,		-- 19
    TO_CHAR(acct_row_id),		-- 21
    unkwn_orig_fl_const,		-- 68
    unkwn_benef_fl_const,		-- 69
    unkwn_scnd_benef_fl_const,	-- 70
    wire_arr(element_a)(index_w_field9),	-- 72
    wire_arr(element_a)(index_w_field9),	-- 73
    send_instn_rlshp_cd_const,		-- 74
    rcv_instn_rlshp_cd_const,		-- 75
    prcsng_batch_nm_const, -- 90
    mantas_trxn_asset_class_cd_c, -- 99
    mantas_trxn_purp_cd_const, -- 100
    mantas_trxn_prdct_cd_const, -- 101
    mantas_trxn_chanl_cd_const, -- 103
    rf_active_partition_flag_const, -- 297
    rf_subpartition_key_const -- 299
   );
   COMMIT;
   
   element_w := element_w + 1;	--! < increment of loop counter for WIRE_TRXN loop
   index_w_field1 := index_w_field1 + 9;	--! < calculate number of slider position in array (wire_arr_...) of the test data for wire_trxn
   index_w_field2 := index_w_field2 + 9;
   index_w_field3 := index_w_field3 + 9;
   index_w_field4 := index_w_field4 + 9;
   index_w_field5 := index_w_field5 + 9;
   index_w_field6 := index_w_field6 + 9;
   index_w_field7 := index_w_field7 + 9;
   index_w_field8 := index_w_field8 + 9;
   index_w_field9 := index_w_field9 + 9;
   END LOOP;
  END;	-- end of block for BUSINESS.WIRE_TRXN
  
  element_a := element_a + 1;		--! < increment of loop counter for ACCT loop
  END LOOP;
 END;	-- end of block for BUSINESS.ACCT
 
 element_c := element_c + 1;		--! < increment of loop counter for CUST loop
 END LOOP;
END;	-- end of main block and BUSINESS.CUST
/
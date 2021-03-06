DECLARE
/* common data for all table and row */
 full_nm_const varchar2(2000) := 'test_1499_236-T';		-- CUST
 orig_nm_const varchar2(350) := 'test_1499_236-T';		-- WIRE
 benef_nm_const varchar2(350) := 'test_1499_236-T';		-- WIRE
 cust_type_cd_const varchar2(10) := 'ORG';		-- CUST
 prcsng_batch_nm_const varchar2(20) := 'DLY';		-- CUST, ACCT
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
           1         \       2       \      3         \      4        \          5          \           6              \       7          \       8
  3:trxn_intrl_ref_id\7:trxn_exctn_dt\192:rf_credit_cd\191:rf_debit_cd\71:intrl_orig_acct_fl\287:rf_send_instn_cntry_cd\233:rf_orig_inn_nb\8:trxn_base_am
  - use of field #2: values of delta to calculate action date.
 */
 wire_arr_1 wire_arrType := wire_arrType(	--! < array of the test data for wire_trxn (order by benef_acct_id)
'test_1','244','40501810877771200000','40504810877771500000','N','RU','7743121210','100000',
'test_2','16','40501810877771200000','20201810877776600000','N','RU','771102553800','150000',
'test_3','16','40501810877771200000','40504810877771500000','N','RU','7743123450','12000',
'test_4','16','40501810877771200000','40504810877771500000','N','RU','7743123450','15000',
'test_5','16','40501810877771200000','40504810877771500000','N','RU','7743123450','2001000',
'test_6','16','40501810877771200000','40504810877771500000','N','RU','7743123460','545000',
'test_7','16','40501810877771200000','40504810877771500000','N','RU','7743123470','320000',
'test_8','16','40501810877771200000','40504810877771500000','N','RU','7743123480','620000',
'test_9','16','40501810877771200000','40504810877771500000','N','RU','7743123490','65000',
'test_10','15','40501810877771200000','40504810877771500000','N','RU','7743123460','430000',
'test_11','15','40501810877771200000','40504810877771500000','N','RU','7743123470','740000',
'test_12','15','40501810877771200000','40504810877771500000','N','RU','7743111110','7001000',
'test_13','15','40501810877771200000','40504810877771500000','N','RU','7743222220','5000000',
'test_14','15','40501810877771200000','40504810877771500000','N','RU','7743444440','260000',
'test_15','16','40501810877771200000','40504810877771500000','N','RU','7743','100500',
'test_16','16','40501810877771200000','40504810877771500000','Y','RU','7743123460','100500',
'test_17','17','40502810877771300000','44001810877776600000','N','RU','7743123450','100500',
'test_36','13','40605810877770960000','40501810877771200000','Y','RU','7734123450','990000',
'test_37','12','40505810877771600000','40605810877770960000','N','RU','9932888880','280000',
'test_41','10','40505810877771600000','40605810877770960000','N','RU','9932777770','700000',
'test_45','3','40505810877771600000','40605810877770960000','N','RU','9933111110','933000',
'test_50','51','40505810877771600000','40605810877770960000','N','RU','7743123460','100500',
'test_62','31','40605810877770960000','40703810877770703000','N','RU','9932456780','100000',
'test_69','26','40503810877771400000','40501810877771200000','Y','RU','7734123450','5000100',
'test_71','30','40802810877770802000','47901810877776600000','N','RU','7733555550','406000',
'test_75','29','70001810877776600000','40501810877771200000','N','RU','99341','994300',
'test_156','171','40401810877774010000','40501810877771200000','N','RU','7743123450','100000',
'test_157','169','40401810877774010000','40501810877771200000','N','RU','7743123450','15000',
'test_158','168','40402810877774020000','40501810877771200000','N','RU','7743123450','100000',
'test_159','167','40403810877774030000','40501810877771200000','N','RU','7743123450','250000',
'test_160','141','40405810877774050000','40501810877771200000','N','RU','7743123450','158000',
'test_161','141','40411810877776600000','40501810877771200000','N','RU','7743123450','100',
'test_162','140','40407810877774070000','40501810877771200000','N','RU','7743123450','12010',
'test_163','112','40409810877774090000','40501810877771200000','N','RU','7743123450','5000100',
'test_164','111','40410810877774100000','40501810877771200000','N','RU','7743123450','150000',
'test_165','45','40101810877771010000','40501810877771200000','N','RU','7743123450','120000',
'test_166','45','40102810877776600000','40501810877771200000','N','RU','7743123450','100',
'test_167','44','40201810877772010000','40501810877771200000','N','RU','7743123450','100000',
'test_168','17','40405810877774050000','40501810877771200000','N','RU','7743123450','100000',
'test_169','16','40201810877772010000','40501810877771200000','N','RU','7743123450','19000',
'test_170','171','40401810877774010000','40501810877771200000','N','RU','7743123450','700000',
'test_171','169','40401810877776600000','40501810877771200000','N','RU','7743123450','100',
'test_172','168','40501810877771200000','40501810877771200000','N','RU','7743123450','27000000',
'test_173','167','40602810877770900000','40501810877771200000','N','RU','7743123450','150000',
'test_174','141','40405810877776600000','40501810877771200000','N','RU','7743123450','100',
'test_175','141','40411810877774110000','40501810877771200000','N','RU','7743123450','150000000',
'test_176','140','40407810877776600000','40501810877771200000','N','RU','7743123450','100',
'test_177','112','40703810877770703000','40501810877771200000','N','RU','7743123450','190000000',
'test_178','111','40803810877778030000','40501810877771200000','N','RU','7743123450','270000000',
'test_179','45','40101810877776600000','40501810877771200000','N','RU','7743123450','100',
'test_180','45','40102810877771020000','40501810877771200000','N','RU','7743123450','77000000',
'test_181','44','40201810877776600000','40501810877771200000','N','RU','7743123450','100',
'test_182','17','40706810877770706000','40501810877771200000','N','RU','7743123450','120000000',
'test_183','16','40607810877776070000','40501810877771200000','N','RU','7743123450','79496000',
'test_18','18','40503810877771400000','44101810877776600000','N','RU','7743123460','100500',
'test_19','19','40503810877771400000','40604810877770950000','N','RU','7743123470','405000',
'test_20','17','40503810877771400000','40604810877770900000','N','RU','7743123470','40600',
'test_21','17','40503810877771400000','40604810877770900000','N','RU','7734010100','305000',
'test_22','17','40503810877771400000','40604810877770900000','N','RU','7734101010','40600',
'test_23','17','40503810877771400000','40604810877770900000','N','RU','7732888880','77300',
'test_24','17','40503810877771400000','40604810877770900000','N','RU','7733555550','550000',
'test_25','17','40503810877771400000','40604810877770900000','N','RU','9943111110','99430',
'test_26','19','40503810877771400000','40604810877770900000','N','RU','7743123470','100500',
'test_27','19','40503810877771400000','40604810877770900000','N','RU','9909774310','100500',
'test_28','19','40503810877771400000','40604810877770900000','N','US','9909774320','100500',
'test_29','18','40504810877771500000','44201810877776600000','N','RU','7734987650','10050',
'test_30','17','40505810877771600000','44301810877776600000','N','RU','7734987650','100500',
'test_112','49','40501810877771200000','40504810877771500000','N','RU','7743123450','9943000',
'test_113','48','40501810877771200000','40504810877771500000','N','RU','7743123450','100500',
'test_116','45','40501810877771200000','40504810877771500000','N','RU','7743123450','506000',
'test_117','42','40501810877771200000','40504810877771500000','N','RU','7743123450','9000000',
'test_146','42','40501810877771200000','40504810877771500000','N','RU','7743123450','100500',
'test_147','41','40501810877771200000','40504810877771500000','N','RU','7743123450','405000',
'test_152','33','40501810877771200000','40504810877771500000','N','RU','7743123450','405000',
'test_153','32','40501810877771200000','40504810877771500000','N','RU','7743123450','305000',
'test_31','1','40505810877771600000','40605810877770960000','N','RU','9932456780','50500',
'test_32','14','40505810877771600000','40605810877770960000','N','RU','9932456780','605000',
'test_33','14','40505810877771600000','40605810877770960000','N','RU','9932456780','506000',
'test_34','14','40505810877771600000','40605810877770960000','N','RU','9932456780','900000',
'test_35','14','40504810877771500000','40501810877771200000','Y','RU','7743123450','130000',
'test_38','12','40505810877771600000','40605810877770960000','N','RU','9932888880','34000',
'test_39','12','40505810877771600000','40605810877770960000','N','RU','9932888880','32000',
'test_40','12','40705810877770705000','40501810877771200000','Y','RU','7734123450','975000',
'test_42','9','40505810877771600000','40605810877770960000','N','RU','9932666660','405050',
'test_43','8','40505810877771600000','40605810877770960000','N','RU','9932555550','250000',
'test_44','4','40605810877770960000','40501810877771200000','Y','RU','7734123450','99000',
'test_46','2','40505810877771600000','40605810877770960000','N','RU','9933222220','100000',
'test_47','1','40505810877771600000','40605810877770960000','N','RU','9933444440','100000',
'test_48','1','40505810877771600000','40605810877770960000','N','RU','9932456780','100500',
'test_51','51','40601810877770940000','44401810877776600000','N','RU','7743123470','100500',
'test_52','50','40602810877770930000','44501810877776600000','N','RU','7734987650','100500',
'test_56','18','40605810877770960000','40703810877770703000','N','RU','9932456710','400000',
'test_57','18','40605810877770960000','40703810877770703000','N','RU','9932456710','3230000',
'test_58','18','40605810877770960000','40703810877770703000','N','RU','9932456710','99000',
'test_59','18','40605810877770960000','40703810877770703000','N','RU','9932456710','933000',
'test_60','18','40605810877770960000','40703810877770703000','N','RU','773312345600','100000',
'test_61','18','40802810877770802000','40501810877771200000','Y','RU','7734123450','13057000',
'test_63','31','40701810877770701000','47101810877776600000','N','RU','9932456710','100500',
'test_64','18','40702810877770702000','47201810877776600000','N','RU','773312345600','100500',
'test_65','18','40703810877770703000','47301810877776600000','N','RU','7743123470','100500',
'test_66','18','40704810877770704000','47401810877776600000','N','RU','7734987650','100500',
'test_107','54','40605810877770960000','40703810877770703000','N','RU','7743123450','406000',
'test_111','50','40605810877770960000','40703810877770703000','N','RU','7743123450','550000',
'test_115','46','40605810877770960000','40703810877770703000','N','RU','7743123450','605000',
'test_119','35','40605810877770960000','40703810877770703000','N','RU','7743123450','280000',
'test_120','83','40605810877770960000','40703810877770703000','N','RU','7743123450','340000',
'test_122','81','40605810877770960000','40703810877770703000','N','RU','7743123450','550000',
'test_125','78','40605810877770960000','40703810877770703000','N','RU','7743123450','505000',
'test_128','74','40605810877770960000','40703810877770703000','N','RU','7743123450','9000000',
'test_149','38','40605810877770960000','40703810877770703000','N','RU','7743123450','773000',
'test_151','34','40605810877770960000','40703810877770703000','N','RU','7743123450','100500',
'test_155','30','40605810877770960000','40703810877770703000','N','RU','7743123450','773000',
'test_67','27','40704810877770704000','40602810877770900000','N','RU','7734987650','4050',
'test_68','27','40802810877770802000','40501810877771200000','Y','RU','7734123450','4120000',
'test_70','27','40705810877770705000','47501810877776600000','N','RU','7733555550','305000',
'test_118','36','40802810877770802000','40704810877770704000','N','RU','7743123450','990000',
'test_121','82','40802810877770802000','40704810877770704000','N','RU','7743123450','773000',
'test_124','79','40802810877770802000','40704810877770704000','N','RU','9932456780','100500',
'test_127','74','79901810877776600000','40704810877770704000','N','RU','7743123450','506000',
'test_139','57','40604810877770900000','40704810877770704000','N','RU','7743123450','605000',
'test_148','39','40802810877770802000','40704810877770704000','N','RU','7743123450','406000',
'test_72','30','40802810877770802000','40702810877770702000','N','RU','7733555550','77300',
'test_73','30','40602810877770900000','40501810877771200000','Y','RU','7734123450','856900',
'test_74','30','40802810877770802000','40702810877770702000','N','RU','99340','550000',
'test_76','28','70101810877776600000','40505810877771600000','N','RU','9909774320','105000',
'test_77','27','70201810877776600000','40601810877770940000','N','RU','9909774330','150000',
'test_78','26','78001810877776600000','40605810877770960000','N','RU','9932456780','120000',
'test_79','25','78901810877776600000','40701810877770701000','N','RU','9932456710','150000',
'test_80','29','44001810877776600000','40802810877770802000','N','RU','9932456780','5450000',
'test_81','28','44101810877776600000','40504810877771500000','N','RU','9932456780','320000',
'test_82','27','47001810877776600000','40704810877770704000','N','RU','9932456780','620000',
'test_83','26','47901810877776600000','40802810877770802000','N','RU','9932456780','6500000',
'test_84','81','70001810877776600000','40802810877770802000','N','RU','9932456780','430000',
'test_85','81','40802810877770802000','40704810877770704000','N','RU','7743123450','740000',
'test_86','80','40605810877770960000','40703810877770703000','N','RU','7743123450','10500000',
'test_87','79','40605810877770960000','40703810877770703000','N','RU','7743123450','150000',
'test_88','78','40605810877770960000','40703810877770703000','N','RU','7743123450','120000',
'test_89','77','40704810877770704000','40802810877770802000','N','RU','7743123450','150000',
'test_90','76','79901810877776600000','40704810877770704000','N','RU','7743123450','2001000',
'test_92','75','44001810877776600000','40802810877770802000','N','RU','7743123450','320000',
'test_100','63','40604810877770900000','40704810877770704000','N','RU','7743123450','150000',
'test_108','53','40704810877770704000','40802810877770802000','N','RU','7743123450','305000',
'test_123','79','70001810877776600000','40802810877770802000','N','RU','9932456780','9943000',
'test_126','76','40704810877770704000','40802810877770802000','N','RU','7743123450','605000',
'test_130','71','44001810877776600000','40802810877770802000','N','RU','7743123450','406000',
'test_131','71','40704810877770704000','40802810877770802000','N','RU','7743123450','773000'
 );
 wire_arr_2 wire_arrType := wire_arrType(
'test_54','29','40604810877770950000','44701810877776600000','N','RU','9909774330','100500',
'test_55','241','40605810877770960000','47001810877776600000','N','RU','9932456780','100500',
'test_93','75','40503810877771400000','40604810877770950000','N','RU','7743123450','406000',
'test_94','71','40704810877770704000','40604810877770950000','N','RU','7743123450','305000',
'test_95','70','40503810877771400000','40604810877770950000','N','RU','7743123450','406000',
'test_96','69','40503810877771400000','40604810877770950000','N','RU','7743123450','773000',
'test_97','66','40503810877771400000','40604810877770950000','N','RU','7743123450','550000',
'test_98','65','40503810877771400000','40604810877770950000','N','RU','7743123450','9943000',
'test_99','64','40503810877771400000','40604810877770950000','N','RU','7743123450','10500000',
'test_101','59','40503810877771400000','40604810877770950000','N','RU','7743123450','120000',
'test_104','57','40503810877771400000','40604810877770950000','N','RU','7743123450','2001000',
'test_106','55','40503810877771400000','40604810877770950000','N','RU','7743123450','320000',
'test_110','51','40503810877771400000','40604810877770950000','N','RU','7743123450','773000',
'test_114','47','40503810877771400000','40604810877770950000','N','RU','7743123450','505000',
'test_132','70','40503810877771400000','40604810877770950000','N','RU','7743123450','550000',
'test_133','69','40704810877770704000','40604810877770950000','N','RU','7743123450','9943000',
'test_134','66','40503810877771400000','40604810877770950000','N','RU','7743123450','100500',
'test_135','63','40503810877771400000','40604810877770950000','N','RU','7743123450','505000',
'test_136','60','40503810877771400000','40604810877770950000','N','RU','7743123450','9803000',
'test_137','59','40503810877771400000','40604810877770950000','N','RU','7743123450','100500',
'test_138','58','40503810877771400000','40604810877770950000','N','RU','7743123450','505000',
'test_140','52','40503810877771400000','40604810877770900000','N','RU','7743123450','506000',
'test_144','49','40503810877771400000','40604810877770900000','N','RU','7743123450','773000',
'test_150','35','40503810877771400000','40604810877770950000','N','RU','7743123450','550000',
'test_154','31','40503810877771400000','40604810877770950000','N','RU','7743123450','406000'
 );
 wire_arr_3 wire_arrType := wire_arrType(
'test_49','1','40505810877771600000','40501810877771200000','Y','RU','7734123450','3850000',
'test_53','30','40603810877770940000','44601810877776600000','N','RU','9909774320','100500',
'test_91','76','40704810877770704000','40602810877770930000','N','RU','7743123450','5450000',
'test_102','58','73101810877776600000','40602810877770930000','N','RU','7743123450','5450000',
'test_103','58','40704810877770704000','40602810877770930000','N','RU','7743123450','2001000',
'test_105','56','40704810877770704000','40602810877770930000','N','RU','7743123450','2001000',
'test_109','52','40704810877770704000','40602810877770930000','N','RU','7743123450','406000',
'test_129','72','40704810877770704000','40602810877770930000','N','RU','7743123450','406000',
'test_141','51','73101810877776600000','40602810877770930000','N','RU','7743123450','406000',
'test_142','51','40704810877770704000','40602810877770930000','N','RU','7743123450','406000',
'test_143','50','40704810877770704000','40602810877770930000','N','RU','7743123450','406000',
'test_145','43','40704810877770704000','40602810877770930000','N','RU','7743123450','406000'
 );
 TYPE wire_2XarrType IS TABLE OF wire_arrType;
 wire_arr wire_2XarrType;
/* end test data for BUSINESS.WIRE_TRXN */
 BEGIN
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
 END;
/

CREATE OR REPLACE PROCEDURE insert_wire(
 benef_acct_id_link IN varchar2,		--! < pass the acct row id
 wire_trxn_arr IN varchar2		--! < pass the array with test data
 )
IS
element_w INTEGER := 1;
index_w_field1 INTEGER := 1;	--! < starting value for calculate position number in array (wire_arr_...) of the test data for wire_trxn
index_w_field2 INTEGER := 2;
index_w_field3 INTEGER := 3;
index_w_field4 INTEGER := 4;
index_w_field5 INTEGER := 5;
index_w_field6 INTEGER := 6;
index_w_field7 INTEGER := 7;
index_w_field8 INTEGER := 8;
BEGIN
  WHILE (element_w <= wire_trxn_arr.COUNT) LOOP
   trxn_row_id := std.AML_TOOLS.get_new_trxn_seq();	--! < generation id for test data row
   date_oper := TRUNC(sysdate - TO_NUMBER(wire_trxn_arr(index_w_field2)));	--! < calculate of the operation date
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
   UNKWN_BENEF_FL		-- 69
   )
   VALUES(
    trxn_row_id,		-- 1
    TRUNC(sysdate),		-- 2
    wire_trxn_arr(index_w_field1),		-- 3
    TO_DATE(date_oper, 'dd.mm.yyyy'),		-- 7
    wire_trxn_arr(index_w_field3),		-- 192
    wire_trxn_arr(index_w_field4),		-- 191
    wire_trxn_arr(index_w_field5),		-- 71
    wire_trxn_arr(index_w_field6),		-- 287
    wire_trxn_arr(index_w_field7),		-- 233
    TO_NUMBER(wire_trxn_arr(index_w_field8)),		-- 8
    orig_nm_const,		-- 12
    benef_nm_const,		-- 19
    benef_acct_id_link,		-- 21
    unkwn_orig_fl_const,		-- 68
    unkwn_benef_fl_const		-- 69
   );
   element_w := element_w + 1;
   index_w_field1 := index_w_field1 + 8;	--! < calculate number of slider position in array (wire_arr_...) of the test data for wire_trxn
   index_w_field2 := index_w_field2 + 8;
   index_w_field3 := index_w_field3 + 8;
   index_w_field4 := index_w_field4 + 8;
   index_w_field5 := index_w_field5 + 8;
   index_w_field6 := index_w_field6 + 8;
   index_w_field7 := index_w_field7 + 8;
   index_w_field8 := index_w_field8 + 8;
END LOOP;
END;
/

/* main block for insert row in CUST, ACCT, WIRE_TRXN
 *
 */
DECLARE
/* unique data */
 cust_row_id number;
 acct_row_id number;
 trxn_row_id number;
/* service data for SQL-script */
 element_c INTEGER;    --! < loop counter for CUST
 element_a INTEGER;    --! < loop counter for ACCT
 --element_w INTEGER := 1;    --! < loop counter for WIRE_TRXN
 --index_c varchar2;	--! < key for CUST
 --index_a varchar2;	--! < key for ACCT
 --index_w varchar2;	--! < key for WIRE_TRXN
BEGIN    --! < block for BUSINESS.CUST
 element_c := 1;		--! < initial settings of the counter
 WHILE (element_c<=inn_arr.COUNT) LOOP    --! < loop for insert row
 cust_row_id := STD.aml_tools.get_new_cust_seq_id();   --! < generation id for test data row
 --index_c := CONCAT(arr_index(element_c), TO_CHAR(element_c));	--! < index definition
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
 BEGIN    --! < block for BUSINESS.ACCT
  element_a := 1;	--! < initial settings of the counter
  WHILE (element_a <= account_id_arr(element_c).COUNT) LOOP
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
  insert_wire(	--! < call the procedure **insert_wire** for insert row in wire_trxn
  TO_CHAR(acct_row_id),	--! < pass into procedure value
  wire_arr(element_a)		--! < pass into procedure of the test data array
  );
  element_a := element_a + 1;    --! < increment of loop counter for ACCT loop
  END LOOP;
 END;
 element_c := element_c + 1;    --! < increment of loop counter for CUST loop
 END LOOP;
END;
/
DECLARE

link_to_table SYS.TEST_INSERT.link_table_arrType;

config_arr_cust SYS.TEST_INSERT.config_arrType;
config_arr_acct SYS.TEST_INSERT.config_arrType;
config_arr_cash SYS.TEST_INSERT.config_arrType;
 
cust_name1 SYS.TEST_INSERT.testdata_arrType;
cust_name2 SYS.TEST_INSERT.testdata_arrType;
cust_name3 SYS.TEST_INSERT.testdata_arrType;

cust_arr SYS.TEST_INSERT.testdata_2XarrType;

acct_name1 SYS.TEST_INSERT.testdata_arrType;
acct_name2 SYS.TEST_INSERT.testdata_arrType;
acct_name3 SYS.TEST_INSERT.testdata_arrType;

acct_arr SYS.TEST_INSERT.testdata_2XarrType;

cash_name1 SYS.TEST_INSERT.testdata_arrType;
cash_name2 SYS.TEST_INSERT.testdata_arrType;
cash_name3 SYS.TEST_INSERT.testdata_arrType;

cash_arr SYS.TEST_INSERT.testdata_2XarrType;

BEGIN

DBMS_OUTPUT.enable;

config_arr_cust('table') := 'cust';
config_arr_cust('num_field') := '7';
config_arr_acct('table') := 'acct';
config_arr_acct('num_field') := '10';
config_arr_cash('table') := 'cash_trxn';
config_arr_cash('num_field') := '16';

/** Structure of the variable test data block
 * sequence of field with test data for INSERT INTO statement
 *|52:full_nm|7:tax_id|5:CUST_TYPE_CD|85:PRCSNG_BATCH_NM|86:JRSDCN_CD|87:BUS_DMN_LIST_TX|95:CUST_STAT_CD|
 *|-------+------+-----------+---------------+---------+---------------+------------|
 *|     1     |    2    |        3         |           4            |       5      |           6            |        7          |
 *
 * - attribute of config_arr 'num_field' = number of columns in test data structure above
 */
cust_name1 := SYS.TEST_INSERT.testdata_arrType(	--! test data block for the CUST table
'test_1499_47-T','7744123450','ORG','DLY','RF','a','A'
);
cust_name2 := SYS.TEST_INSERT.testdata_arrType(	--! test data block for the CUST table
'test_1499_47-T','9932456780','ORG','DLY','RF','a','A'
);
cust_name3 := SYS.TEST_INSERT.testdata_arrType(	--! test data block for the CUST table
'test_1499_47-T','7743123470','ORG','DLY','RF','a','A'
);

cust_arr := SYS.TEST_INSERT.testdata_2XarrType(
cust_name1,
cust_name2,
cust_name3
);

/** Structure of the variable test data block
 * sequence of field with test data for INSERT INTO statement
 *|27:alt_acct_id|46:ACCT_EFCTV_RISK_NB|72:PRCSNG_BATCH_NM|78:MANTAS_ACCT_PURP_CD|79:RETRMT_ACCT_FL|80:JRSDCN_CD|81:BUS_DMN_LIST_TX|159:RF_PARTITION_KEY|
 *|----------+-----------------+---------------+------------------+-------------+----------+---------------+---------------|
 *|       1        |    2                      |        3              |           4                 |       5             |       6       |        7               |        8               |
 *
 * - attribute of config_arr 'num_field' = number of columns in test data structure above
 */
acct_name1 := SYS.TEST_INSERT.testdata_arrType(
'cust1','id1','40501810877771112210','0','DLY','O','N','RF','a','38064',
'cust1','id1','40503810877771112230','0','DLY','O','N','RF','a','38064',
'cust1','id1','40505810877771112250','0','DLY','O','N','RF','a','38064',
'cust1','id1','40506810877771112260','0','DLY','O','N','RF','a','38064',
'cust1','id1','40508810877771112280','0','DLY','O','N','RF','a','38064',
'cust1','id1','40821810577770000111','0','DLY','O','N','RF','a','38064',
'cust1','id1','40701810877771112210','0','DLY','O','N','RF','a','38064',
'cust1','id1','40703810877771112230','0','DLY','O','N','RF','a','38064',
'cust1','id1','40705810877771112250','0','DLY','O','N','RF','a','38064',
'cust1','id1','40706810877771112260','0','DLY','O','N','RF','a','38064',
'cust1','id1','40821810577770000111','0','DLY','O','N','RF','a','38064',
'cust1','id1','40802810877771112220','0','DLY','O','N','RF','a','38064',
'cust1','id1','40821810577770000111','0','DLY','O','N','RF','a','38064',
'cust1','id1','40803810877771112230','0','DLY','O','N','RF','a','38064'
);
acct_name2 := SYS.TEST_INSERT.testdata_arrType(
'cust2','id1','40601810877771112210','0','DLY','O','N','RF','a','38064',
'cust2','id1','40603810877771112230','0','DLY','O','N','RF','a','38064',
'cust2','id1','40605810877771112250','0','DLY','O','N','RF','a','38064',
'cust2','id1','40606810877771112260','0','DLY','O','N','RF','a','38064',
'cust2','id1','40608810877771112280','0','DLY','O','N','RF','a','38064',
'cust2','id1','40821810577770000222','0','DLY','O','N','RF','a','38064',
'cust2','id1','40708810877771112280','0','DLY','O','N','RF','a','38064',
'cust2','id1','40801810877771112210','0','DLY','O','N','RF','a','38064',
'cust2','id1','40821810577770000222','0','DLY','O','N','RF','a','38064',
'cust2','id1','40821810577770000222','0','DLY','O','N','RF','a','38064'
);
acct_name3 := SYS.TEST_INSERT.testdata_arrType(
'cust3','id1','40831810577770000031','0','DLY','O','N','RF','a','38064',
'cust3','id1','40820810577770000020','0','DLY','O','N','RF','a','38064',
'cust3','id1','40817810577770000017','0','DLY','O','N','RF','a','38064'
);

acct_arr := SYS.TEST_INSERT.testdata_2XarrType(
acct_name1,
acct_name2,
acct_name3
);

/** Structure of the variable test data block
 * sequence of field with test data for INSERT INTO statement
 *|2:trxn_intrl_ref_id|d_trxn_exctn_dt|93:rf_debit_cd|94:rf_credit_cd|8:trxn_base_am|10:desc_tx|7:DBT_CDT_CD|33:PRCSNG_BATCH_NM|42:MANTAS_TRXN_ASSET_CLASS_CD|43:MANTAS_TRXN_PURP_CD|44:MANTAS_TRXN_PRDCT_CD|46:MANTAS_TRXN_CHANL_CD|158:RF_ACTIVE_PARTITION_FLAG|160:RF_SUBPARTITION_KEY|
 *|-------------+-----------+-----------+----------+-----------+-------+----------+---------------+------------------------+------------------+------------------+-------------------+----------------------+------------------|
 *|       1             |    2            |       3         |     4           |       5         |    6      |       7        |        8              |               9                     |           10                |            11               |              12             |                 13                |            14              |
 *
 * - attribute of config_arr 'num_field' = number of columns in test data structure above
 */
cash_name1 := SYS.TEST_INSERT.testdata_arrType(
'acct1','id1',	'test_1499_47-T',	'-1',	'20202810277773800002',	'40501810877771112210',	 '300000', 	'оплата',	'D','DLY','FUNDS','GENERAL','PHYS','UNKNOWN','0','38064',
'acct1','id2',	'test_1499_47-T',	'0',	'20202810277773800002',	'40503810877771112230',	 '4000000', 	'ставка на победу сборной РФ',	'D','DLY','FUNDS','GENERAL','PHYS','UNKNOWN','0','38064',
'acct1','id2',	'test_1499_47-T',	'0',	'20202810277773800002',	'40503810877771112230',	 '4000000', 	'уставный капитал',	'D','DLY','FUNDS','GENERAL','PHYS','UNKNOWN','0','38064',
'acct1','id3',	'test_1499_47-T',	'1',	'40817810877771112217',	'40505810877771112250',	 '300000', 	'мобильная связь',	'D','DLY','FUNDS','GENERAL','PHYS','UNKNOWN','0','38064',
'acct1','id3',	'test_1499_47-T',	'1',	'40817810877771112217',	'40505810877771112250',	 '300000', 	'взнос в УК',	'D','DLY','FUNDS','GENERAL','PHYS','UNKNOWN','0','38064',
'acct1','id4',	'test_1499_47-T',	'2',	'40820810877771113320',	'40506810877771112260',	 '150000', 	'прием денег в дар',	'D','DLY','FUNDS','GENERAL','PHYS','UNKNOWN','0','38064',
'acct1','id5',	'test_1499_47-T',	'2',	'42301810877771112210',	'40508810877771112280',	 '150000', 	'за услуги оплата',	'D','DLY','FUNDS','GENERAL','PHYS','UNKNOWN','0','38064',
'acct1','id7',	'test_1499_47-T',	'8',	'42615810877771112215',	'40701810877771112210',	 '100', 	'за въезд в город',	'D','DLY','FUNDS','GENERAL','PHYS','UNKNOWN','0','38064',
'acct1','id7',	'test_1499_47-T',	'8',	'42615810877771112215',	'40701810877771112210',	 '100', 	'беспроцентный займ',	'D','DLY','FUNDS','GENERAL','PHYS','UNKNOWN','0','38064',
'acct1','id8',	'test_1499_47-T',	'8',	'20202810277773800002',	'40703810877771112230',	 '151000', 	'за воздух',	'D','DLY','FUNDS','GENERAL','PHYS','UNKNOWN','0','38064',
'acct1','id8',	'test_1499_47-T',	'8',	'20202810277773800002',	'40703810877771112230',	 '151000', 	'целевое финансирование',	'D','DLY','FUNDS','GENERAL','PHYS','UNKNOWN','0','38064',
'acct1','id9',	'test_1499_47-T',	'9',	'20202810277773800002',	'40705810877771112250',	 '151000', 	'по договору №666',	'D','DLY','FUNDS','GENERAL','PHYS','UNKNOWN','0','38064',
'acct1','id10',	'test_1499_47-T',	'10',	'40817810877771112217',	'40706810877771112260',	 '100', 	'по договору №999',	'D','DLY','FUNDS','GENERAL','PHYS','UNKNOWN','0','38064',
'acct1','id10',	'test_1499_47-T',	'10',	'40817810877771112217',	'40706810877771112260',	 '100', 	'заем безвозмездный',	'D','DLY','FUNDS','GENERAL','PHYS','UNKNOWN','0','38064',
'acct1','id12',	'test_1499_47-T',	'12',	'42305810877771112250',	'40802810877771112220',	 '151000', 	'штраф',	'D','DLY','FUNDS','GENERAL','PHYS','UNKNOWN','0','38064',
'acct1','id14',	'test_1499_47-T',	'13',	'42315810877771112215',	'40803810877771112230',	 '151000', 	'штраф',	'D','DLY','FUNDS','GENERAL','PHYS','UNKNOWN','0','38064',
'acct1','id1',	'test_1499_47-T',	'14',	'42601810877771112210',	'40501810877771112210',	 '233000', 	'проценты',	'D','DLY','FUNDS','GENERAL','PHYS','UNKNOWN','0','38064',
'acct1','id1',	'test_1499_47-T',	'14',	'42601810877771112210',	'40501810877771112210',	 '233000', 	'уставняк',	'D','DLY','FUNDS','GENERAL','PHYS','UNKNOWN','0','38064',
'acct1','id2',	'test_1499_47-T',	'15',	'42615810877771112215',	'40503810877771112230',	 '232000', 	'пени',	'D','DLY','FUNDS','GENERAL','PHYS','UNKNOWN','0','38064',
'acct1','id3',	'test_1499_47-T',	'15',	'40821',	'40505810877771112250',	 '232000', 	'уговор',	'D','DLY','FUNDS','GENERAL','PHYS','UNKNOWN','0','38064',
'acct1','id4',	'test_1499_47-T',	'16',	'42601810877771112210',	'40506810877771112260',	 '232000', 	'уговор',	'D','DLY','FUNDS','GENERAL','PHYS','UNKNOWN','0','38064',
'acct1','id7',	'test_1499_47-T',	'22',	'40817810877771112217',	'40701810877771112210',	 '232000', 	'страховка',	'D','DLY','FUNDS','GENERAL','PHYS','UNKNOWN','0','38064',
'acct1','id7',	'test_1499_47-T',	'22',	'40817810877771112217',	'40701810877771112210',	 '232000', 	'финансирование беспроцентное',	'D','DLY','FUNDS','GENERAL','PHYS','UNKNOWN','0','38064',
'acct1','id8',	'test_1499_47-T',	'23',	'40820810877771113320',	'40703810877771112230',	 '232000', 	'вз.на рем.провала',	'D','DLY','FUNDS','GENERAL','PHYS','UNKNOWN','0','38064',
'acct1','id9',	'test_1499_47-T',	'24',	'42301810877771112210',	'40705810877771112250',	 '232000', 	'вз.на рем.провала',	'D','DLY','FUNDS','GENERAL','PHYS','UNKNOWN','0','38064',
'acct1','id9',	'test_1499_47-T',	'24',	'42301810877771112210',	'40705810877771112250',	 '232000', 	'заем целевой',	'D','DLY','FUNDS','GENERAL','PHYS','UNKNOWN','0','38064',
'acct1','id10',	'test_1499_47-T',	'25',	'42305810877771112250',	'40706810877771112260',	 '232000', 	'услуги Снегурочки',	'D','DLY','FUNDS','GENERAL','PHYS','UNKNOWN','0','38064',
'acct1','id10',	'test_1499_47-T',	'25',	'42305810877771112250',	'40706810877771112260',	 '232000', 	'уставной капитал',	'D','DLY','FUNDS','GENERAL','PHYS','UNKNOWN','0','38064',
'acct1','id12',	'test_1499_47-T',	'26',	'42315810877771112215',	'40802810877771112220',	 '232000', 	'Дед Мороз для',	'D','DLY','FUNDS','GENERAL','PHYS','UNKNOWN','0','38064',
'acct1','id1',	'test_1499_47-T',	'27',	'42315810877771112215',	'40501810877771112210',	 '150000', 	'расплата',	'D','DLY','FUNDS','GENERAL','PHYS','UNKNOWN','0','38064',
'acct1','id12',	'test_1499_47-T',	'29',	'42615810877771112215',	'40802810877771112220',	 '150000', 	'поставка мусора по договору №',	'D','DLY','FUNDS','GENERAL','PHYS','UNKNOWN','0','38064',
'acct1','id13',	'test_1499_47-T',	'-1',	'20202810277773800001',	'40821810577770000111',	 '300000', 	'поставка мусора по договору №',	'D','DLY','FUNDS','GENERAL','PHYS','UNKNOWN','0','38064',
'acct1','id13',	'test_1499_47-T',	'0',	'20202810277773800001',	'40821810577770000111',	 '210000', 	'поставка мусора по договору №',	'D','DLY','FUNDS','GENERAL','PHYS','UNKNOWN','0','38064',
'acct1','id13',	'test_1499_47-T',	'1',	'20202810277773800001',	'40821810577770000111',	 '30000', 	'ставка на спор',	'D','DLY','FUNDS','GENERAL','PHYS','UNKNOWN','0','38064',
'acct1','id13',	'test_1499_47-T',	'28',	'20202810277773800001',	'40821810577770000111',	 '300000', 	'возврат НДС',	'D','DLY','FUNDS','GENERAL','PHYS','UNKNOWN','0','38064'
);
cash_name2 := SYS.TEST_INSERT.testdata_arrType(
'acct2','id1',	'test_1499_47-T',	'3',	'42305810877771112250',	'40601810877771112210',	 '4010000', 	'страховка',	'D','DLY','FUNDS','GENERAL','PHYS','UNKNOWN','0','38064',
'acct2','id2',	'test_1499_47-T',	'4',	'42315810877771112215',	'40603810877771112230',	 '6200000', 	'по договору №666',	'D','DLY','FUNDS','GENERAL','PHYS','UNKNOWN','0','38064',
'acct2','id2',	'test_1499_47-T',	'4',	'42315810877771112215',	'40603810877771112230',	 '6200000', 	'безвозмездная помощь',	'D','DLY','FUNDS','GENERAL','PHYS','UNKNOWN','0','38064',
'acct2','id2',	'test_1499_47-T',	'4',	'42316810877771112215',	'40603810877771112230',	 '700000', 	'где деньги',	'D','DLY','FUNDS','GENERAL','PHYS','UNKNOWN','0','38064',
'acct2','id3',	'test_1499_47-T',	'5',	'42600810877771112200',	'40605810877771112250',	 '151000', 	'плата за красивые глаза',	'D','DLY','FUNDS','GENERAL','PHYS','UNKNOWN','0','38064',
'acct2','id4',	'test_1499_47-T',	'6',	'42601810877771112210',	'40606810877771112260',	 '1510000', 	'парковка',	'D','DLY','FUNDS','GENERAL','PHYS','UNKNOWN','0','38064',
'acct2','id5',	'test_1499_47-T',	'7',	'42615810877771112215',	'40608810877771112280',	 '151000', 	'проезд по дороге',	'D','DLY','FUNDS','GENERAL','PHYS','UNKNOWN','0','38064',
'acct2','id7',	'test_1499_47-T',	'11',	'40820810877771113320',	'40708810877771112280',	 '151000', 	'ежемесячный платеж',	'D','DLY','FUNDS','GENERAL','PHYS','UNKNOWN','0','38064',
'acct2','id8',	'test_1499_47-T',	'11',	'42301810877771112210',	'40801810877771112210',	 '151000', 	'штраф',	'D','DLY','FUNDS','GENERAL','PHYS','UNKNOWN','0','38064',
'acct2','id1',	'test_1499_47-T',	'17',	'42615810877771112215',	'40601810877771112210',	 '4320000', 	'уговор',	'D','DLY','FUNDS','GENERAL','PHYS','UNKNOWN','0','38064',
'acct2','id1',	'test_1499_47-T',	'17',	'42615810877771112215',	'40601810877771112210',	 '4320000', 	'капиталовложения',	'D','DLY','FUNDS','GENERAL','PHYS','UNKNOWN','0','38064',
'acct2','id2',	'test_1499_47-T',	'18',	'42615810877771112215',	'40603810877771112230',	 '3320000', 	'оплата за услуги',	'D','DLY','FUNDS','GENERAL','PHYS','UNKNOWN','0','38064',
'acct2','id2',	'test_1499_47-T',	'19',	'40821',	'40603810877771112230',	 '232000', 	'оплата за услуги',	'D','DLY','FUNDS','GENERAL','PHYS','UNKNOWN','0','38064',
'acct2','id3',	'test_1499_47-T',	'20',	'20202810277773800002',	'40605810877771112250',	 '5320000', 	'оплата за услуги',	'D','DLY','FUNDS','GENERAL','PHYS','UNKNOWN','0','38064',
'acct2','id3',	'test_1499_47-T',	'20',	'20202810277773800002',	'40605810877771112250',	 '5320000', 	'финансы уставные',	'D','DLY','FUNDS','GENERAL','PHYS','UNKNOWN','0','38064',
'acct2','id4',	'test_1499_47-T',	'21',	'20202810277773800002',	'40606810877771112260',	 '6320000', 	'страховка',	'D','DLY','FUNDS','GENERAL','PHYS','UNKNOWN','0','38064',
'acct2','id1',	'test_1499_47-T',	'28',	'42601810877771112210',	'40601810877771112210',	 '300000', 	'плата за все',	'D','DLY','FUNDS','GENERAL','PHYS','UNKNOWN','0','38064',
'acct2','id6',	'test_1499_47-T',	'2',	'20202810277773800002',	'40821810577770000222',	 '150000', 	'взятка',	'D','DLY','FUNDS','GENERAL','PHYS','UNKNOWN','0','38064',
'acct2','id6',	'test_1499_47-T',	'2',	'20203810277773800003',	'40821810577770000222',	 '150000', 	'откат',	'D','DLY','FUNDS','GENERAL','PHYS','UNKNOWN','0','38064',
'acct2','id6',	'test_1499_47-T',	'4',	'20202810277773800002',	'40821810577770000222',	 '62000', 	'налог',	'D','DLY','FUNDS','GENERAL','PHYS','UNKNOWN','0','38064',
'acct2','id6',	'test_1499_47-T',	'5',	'20202810277773800002',	'40821810577770000222',	 '70000', 	'налог',	'D','DLY','FUNDS','GENERAL','PHYS','UNKNOWN','0','38064',
'acct2','id6',	'test_1499_47-T',	'6',	'20202810277773800002',	'40821810577770000222',	 '15100', 	'налог',	'D','DLY','FUNDS','GENERAL','PHYS','UNKNOWN','0','38064',
'acct2','id6',	'test_1499_47-T',	'7',	'20202810277773800002',	'40821810577770000222',	 '15100', 	'налог',	'D','DLY','FUNDS','GENERAL','PHYS','UNKNOWN','0','38064',
'acct2','id6',	'test_1499_47-T',	'8',	'20202810277773800002',	'40821810577770000222',	 '51000', 	'налог',	'D','DLY','FUNDS','GENERAL','PHYS','UNKNOWN','0','38064',
'acct2','id6',	'test_1499_47-T',	'8',	'20202810277773800002',	'40821810577770000222',	 '100', 	'плата за дело',	'D','DLY','FUNDS','GENERAL','PHYS','UNKNOWN','0','38064',
'acct2','id6',	'test_1499_47-T',	'9',	'20202810277773800002',	'40821810577770000222',	 '15000', 	'плата за дело',	'D','DLY','FUNDS','GENERAL','PHYS','UNKNOWN','0','38064',
'acct2','id6',	'test_1499_47-T',	'10',	'20202810277773800002',	'40821810577770000222',	 '11000', 	'плата за дело',	'D','DLY','FUNDS','GENERAL','PHYS','UNKNOWN','0','38064',
'acct2','id6',	'test_1499_47-T',	'11',	'20202810277773800002',	'40821810577770000222',	 '100', 	'плата за дело',	'D','DLY','FUNDS','GENERAL','PHYS','UNKNOWN','0','38064',
'acct2','id6',	'test_1499_47-T',	'11',	'20202810277773800002',	'40821810577770000222',	 '15100', 	'плата за дело',	'D','DLY','FUNDS','GENERAL','PHYS','UNKNOWN','0','38064',
'acct2','id6',	'test_1499_47-T',	'12',	'20202810277773800002',	'40821810577770000222',	 '1510', 	'премия',	'D','DLY','FUNDS','GENERAL','PHYS','UNKNOWN','0','38064',
'acct2','id6',	'test_1499_47-T',	'13',	'20202810277773800002',	'40821810577770000222',	 '1510', 	'премия',	'D','DLY','FUNDS','GENERAL','PHYS','UNKNOWN','0','38064',
'acct2','id6',	'test_1499_47-T',	'14',	'20202810277773800002',	'40821810577770000222',	 '1100', 	'премия',	'D','DLY','FUNDS','GENERAL','PHYS','UNKNOWN','0','38064',
'acct2','id6',	'test_1499_47-T',	'15',	'20211810277773800011',	'40821810577770000222',	 '233000', 	'премия',	'D','DLY','FUNDS','GENERAL','PHYS','UNKNOWN','0','38064',
'acct2','id6',	'test_1499_47-T',	'15',	'20202810277773800002',	'40821810577770000222',	 '23200', 	'премия',	'D','DLY','FUNDS','GENERAL','PHYS','UNKNOWN','0','38064',
'acct2','id6',	'test_1499_47-T',	'16',	'20202810277773800002',	'40821810577770000222',	 '22000', 	'поставка по Контракту №ПС-322',	'D','DLY','FUNDS','GENERAL','PHYS','UNKNOWN','0','38064',
'acct2','id6',	'test_1499_47-T',	'17',	'20202810277773800002',	'40821810577770000222',	 '32000', 	'поставка по Контракту №ПС-323',	'D','DLY','FUNDS','GENERAL','PHYS','UNKNOWN','0','38064',
'acct2','id6',	'test_1499_47-T',	'18',	'20202810277773800002',	'40821810577770000222',	 '2320', 	'поставка по Контракту №ПС-324',	'D','DLY','FUNDS','GENERAL','PHYS','UNKNOWN','0','38064',
'acct2','id6',	'test_1499_47-T',	'19',	'20202810277773800002',	'40821810577770000222',	 '2200', 	'поставка по Контракту №ПС-325',	'D','DLY','FUNDS','GENERAL','PHYS','UNKNOWN','0','38064',
'acct2','id6',	'test_1499_47-T',	'20',	'20202810277773800002',	'40821810577770000222',	 '23200', 	'просроченный платеж',	'D','DLY','FUNDS','GENERAL','PHYS','UNKNOWN','0','38064',
'acct2','id6',	'test_1499_47-T',	'21',	'20202810277773800002',	'40821810577770000222',	 '232000', 	'просроченный платеж',	'D','DLY','FUNDS','GENERAL','PHYS','UNKNOWN','0','38064',
'acct2','id6',	'test_1499_47-T',	'24',	'20202810277773800002',	'40821810577770000222',	 '232000', 	'долг',	'D','DLY','FUNDS','GENERAL','PHYS','UNKNOWN','0','38064',
'acct2','id6',	'test_1499_47-T',	'25',	'20202810277773800002',	'40821810577770000222',	 '232000', 	'услуги консультанта',	'D','DLY','FUNDS','GENERAL','PHYS','UNKNOWN','0','38064',
'acct2','id6',	'test_1499_47-T',	'26',	'20202810277773800002',	'40821810577770000222',	 '232000', 	'услуги консультанта',	'D','DLY','FUNDS','GENERAL','PHYS','UNKNOWN','0','38064',
'acct2','id6',	'test_1499_47-T',	'27',	'20202810277773800002',	'40821810577770000222',	 '232000', 	'услуги консультанта',	'D','DLY','FUNDS','GENERAL','PHYS','UNKNOWN','0','38064',
'acct2','id6',	'test_1499_47-T',	'29',	'20202810277773800002',	'40821810577770000222',	 '150000', 	'оплата НДС',	'D','DLY','FUNDS','GENERAL','PHYS','UNKNOWN','0','38064'
);
cash_name3 := SYS.TEST_INSERT.testdata_arrType(
'acct3','id1',	'test_1499_47-T',	'3',	'20202810277773800002',	'40831810577770000031',	 '401000', 	'налог',	'D','DLY','FUNDS','GENERAL','PHYS','UNKNOWN','0','38064',
'acct3','id2',	'test_1499_47-T',	'22',	'20202810277773800002',	'40820810577770000020',	 '232000', 	'просроченный платеж',	'D','DLY','FUNDS','GENERAL','PHYS','UNKNOWN','0','38064',
'acct3','id3',	'test_1499_47-T',	'23',	'20202810277773800002',	'40817810577770000017',	 '232000', 	'долг',	'D','DLY','FUNDS','GENERAL','PHYS','UNKNOWN','0','38064'
);

cash_arr := SYS.TEST_INSERT.testdata_2XarrType(
cash_name1,
cash_name2,
cash_name3
);

SYS.TEST_INSERT.insert_row(config_arr_cust,cust_arr,link_to_table);
SYS.TEST_INSERT.insert_row(config_arr_acct,acct_arr,link_to_table);
SYS.TEST_INSERT.insert_row(config_arr_cash,cash_arr,link_to_table);

END;
/
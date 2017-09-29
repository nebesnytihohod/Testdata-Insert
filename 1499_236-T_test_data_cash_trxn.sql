-- Scenario 1499 236-T
-- test data for BUSINESS.CASH_TRXN

INSERT INTO business.cash_trxn(
 FO_TRXN_SEQ_ID,
 TRXN_INTRL_REF_ID,
 TRXN_EXCTN_DT,
 RF_CREDIT_CD,
 RF_DEBIT_CD,
 TRXN_BASE_AM)
 VALUES(
 (select std.AML_TOOLS.get_new_trxn_seq()  from dual),
 'test_1499_236-T',
 TO_DATE('13.05.2016', 'dd.mm.yyyy'),
 '40501810877771200000',
 '40504810877771500000',
 100000);

INSERT INTO business.cash_trxn(
 FO_TRXN_SEQ_ID,
 TRXN_INTRL_REF_ID,
 TRXN_EXCTN_DT,
 RF_CREDIT_CD,
 RF_DEBIT_CD,
 TRXN_BASE_AM)
 VALUES(
 (select std.AML_TOOLS.get_new_trxn_seq()  from dual),
 'test_1499_236-T',
 TO_DATE('05.11.2016', 'dd.mm.yyyy'),
 '40704810877770704000',
 '40602810877770900000',
 4060);

INSERT INTO business.cash_trxn(
  FO_TRXN_SEQ_ID,
  TRXN_INTRL_REF_ID,
  TRXN_EXCTN_DT,
  RF_CREDIT_CD,
  RF_DEBIT_CD,
  TRXN_BASE_AM)
  VALUES(
  (select std.AML_TOOLS.get_new_trxn_seq()  from dual),
  'test_1499_236-T',
  TO_DATE('01.11.2016', 'dd.mm.yyyy'),
  '40802810877770802000',
  '40702810877770702000',
  77300);
  
INSERT INTO business.cash_trxn(
  FO_TRXN_SEQ_ID,
  TRXN_INTRL_REF_ID,
  TRXN_EXCTN_DT,
  RF_CREDIT_CD, 
  RF_DEBIT_CD, 
  TRXN_BASE_AM) 
  VALUES(
  (select std.AML_TOOLS.get_new_trxn_seq()  from dual), 
  'test_1499_236-T', 
  TO_DATE('01.11.2016', 'dd.mm.yyyy'), 
  '40802810877770802000', 
  '40702810877770702000', 
  550000);
  
INSERT INTO business.cash_trxn(
 FO_TRXN_SEQ_ID, 
 TRXN_INTRL_REF_ID, 
 TRXN_EXCTN_DT, 
 RF_CREDIT_CD, 
 RF_DEBIT_CD, 
 TRXN_BASE_AM) 
 VALUES(
 (select std.AML_TOOLS.get_new_trxn_seq()  from dual), 
 'test_1499_236-T', 
 TO_DATE('08.11.2016', 'dd.mm.yyyy'), 
 '79901810877776600000', 
 '40705810877770705000', 
 2001000);
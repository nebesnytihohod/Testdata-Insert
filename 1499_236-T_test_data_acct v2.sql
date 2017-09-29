/* Scenario 1499 236-T
 * test data for BUSINESS.ACCT
**/

DECLARE

BEGIN
INSERT INTO business.acct(
 acct_intrl_id, 
 acct_seq_id, 
 alt_acct_id, 
 acct_open_dt, 
 prmry_cust_intrl_id
 ) 
 VALUES(
 '128371928',
 128371928,
 '40501810877771200000',
 TO_DATE('02.11.2015', 'dd.mm.yyyy'),
 '136318970'
 );
END:
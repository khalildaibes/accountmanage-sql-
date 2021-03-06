CREATE TRIGGER DEPOSITE_TRIGGER ON ACTIONS AFTER INSERT
AS
DECLARE @ACCOUNTNUMBER INT/*����� �����*/
DECLARE @AC_CODE INT /*��� ������*/
DECLARE @MONEY INT /*���� ���� �� ������*/
DECLARE @MONEY_PER_ACTION INT /*����� ������ �� ������*/

SET @ACCOUNTNUMBER = (SELECT ACCOUNT_NUM FROM ACTIONS WHERE ACTION_CODE = @@IDENTITY)
SET @AC_CODE = (SELECT ACTION_TYPE FROM ACTIONS WHERE ACTION_CODE = @@IDENTITY)
SET @MONEY = (SELECT AMOUNT FROM ACTIONS WHERE ACTION_CODE = @@IDENTITY)
SET @MONEY_PER_ACTION = (SELECT ACTION_COST FROM ACTIONS_TYPE WHERE @AC_CODE = ACTION_CODE)
										   /*DEPOSIT*/
IF(@AC_CODE = 1)
BEGIN 
UPDATE ACCOUNTS SET BALANCE = BALANCE + @MONEY - @MONEY_PER_ACTION WHERE @ACCOUNTNUMBER = ACCOUNT_NUM
UPDATE ACCOUNTS SET ACCOUNT_ACTIONS_NUM = ACCOUNT_ACTIONS_NUM + 1 WHERE @ACCOUNTNUMBER = ACCOUNT_NUM
END

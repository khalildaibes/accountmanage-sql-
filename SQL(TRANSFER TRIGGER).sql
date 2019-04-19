CREATE TRIGGER TR1_TRAMSFER ON ACTIONS AFTER INSERT
AS
DECLARE @ACCOUNTNUMBER INT/*����� �����*/
DECLARE @AC_CODE INT /*��� ������*/
DECLARE @MONEY INT /*���� ���� �� ������*/
DECLARE @MONEY_PER_ACTION INT /*����� ������ �� ������*/
DECLARE @FRAME INT /*�����*/
DECLARE @YTRA INT /*���� ������*/
DECLARE @DEST INT 

SET @AC_CODE = (SELECT ACTION_TYPE FROM ACTIONS WHERE ACTION_CODE = @@IDENTITY)
SET @ACCOUNTNUMBER = (SELECT ACCOUNT_NUM FROM ACTIONS WHERE ACTION_CODE = @@IDENTITY)
SET @MONEY = (SELECT AMOUNT FROM ACTIONS WHERE ACTION_CODE = @@IDENTITY)
SET @DEST = (SELECT DESTENATION�_ACCOUNT_NUM FROM ACTIONS WHERE ACTION_CODE = @@IDENTITY)
SET @FRAME = (SELECT MSGERT FROM ACCOUNTS WHERE @ACCOUNTNUMBER = ACCOUNT_NUM)
SET @YTRA = (SELECT BALANCE FROM ACCOUNTS WHERE @ACCOUNTNUMBER = ACCOUNT_NUM)
SET @MONEY_PER_ACTION =(SELECT ACTION_COST FROM ACTIONS_TYPE WHERE @AC_CODE = ACTION_CODE)

IF(@AC_CODE = 3)
BEGIN
		IF(@MONEY < (@YTRA + @FRAME + @MONEY_PER_ACTION))
		BEGIN
		UPDATE ACCOUNTS SET BALANCE = BALANCE - @MONEY - @MONEY_PER_ACTION WHERE @ACCOUNTNUMBER = ACCOUNT_NUM /*����� ���� ����� + �����*/
		UPDATE ACCOUNTS SET BALANCE = BALANCE + @MONEY WHERE @DEST = ACCOUNT_NUM   /*����� ���� ����*/
		UPDATE ACCOUNTS SET ACCOUNT_ACTIONS_NUM = ACCOUNT_ACTIONS_NUM + 1 WHERE @ACCOUNTNUMBER = ACCOUNT_NUM /* ����� ���� ������ �����*/
		END
		ELSE BEGIN PRINT 'AMIGOO YOU CANNOT TRANSFER MOENY!!!' END
END

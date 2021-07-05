/***
 * Add Amount without Tax #435
 * 
 ***/

IF COL_LENGTH('[dbo].[Expense]', 'expAmountWOTax') IS NULL
BEGIN
    ALTER TABLE [dbo].[Expense]
    ADD 
	[expAmountWOTax] [decimal](6, 2) NOT NULL DEFAULT 0;

END

/***
 * Add CostAccount for Company Tax #454
 * 
 ***/

IF COL_LENGTH('[dbo].[CostAccount]', 'csaFlagCompany') IS NULL
BEGIN
    ALTER TABLE [dbo].[CostAccount]
    ADD 
	[csaFlagCompany] [bit] NOT NULL DEFAULT 0;

END
GO

IF COL_LENGTH('[dbo].[Expense]', 'expcsaIdCompany') IS NULL
BEGIN
    ALTER TABLE [dbo].[Expense]
    ADD 
	[expcsaIdCompany] [bigint] NULL;
	
	ALTER TABLE [dbo].[Expense]  WITH CHECK ADD  CONSTRAINT [FK_Expense_CstCompany] FOREIGN KEY([expcsaIdCompany])
	REFERENCES [dbo].[CostAccount] ([csaId])

	ALTER TABLE [dbo].[Expense] CHECK CONSTRAINT [FK_Expense_CstCompany]	
END
GO


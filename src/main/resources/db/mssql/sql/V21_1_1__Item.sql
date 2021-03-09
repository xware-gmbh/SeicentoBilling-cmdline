/***
 * Add PriceLevel
 * 
 ***/

IF COL_LENGTH('[dbo].[Item]', 'itmPriceLevel') IS NULL
BEGIN
    ALTER TABLE [dbo].[Item]
    ADD 
	itmPriceLevel [smallint] NOT NULL DEFAULT 0;

END
GO

update [dbo].[Item] set itmPriceLevel = 1 where itmitgid = 2;

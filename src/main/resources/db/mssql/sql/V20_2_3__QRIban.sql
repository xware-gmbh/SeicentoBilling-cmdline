/***
 * Add QR Values to Bank
 * 
 ***/

IF COL_LENGTH('[dbo].[Bank]', 'bnkQriban') IS NULL
BEGIN
    ALTER TABLE [dbo].[Bank]
    ADD 
	bnkQriban  nvarchar(60) NULL;

END

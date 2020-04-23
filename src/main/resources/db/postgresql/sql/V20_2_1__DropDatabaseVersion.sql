
/****** Object: ProjectLine : Zeit von/bis ***/
IF COL_LENGTH('dbo.RowObject', 'objdbvId') IS NOT NULL
BEGIN
    ALTER TABLE dbo.RowObject DROP CONSTRAINT DatabaseVersion_RowObject;
    ALTER TABLE dbo.RowObject DROP Column objdbvId;
	DROP TABLE DatabaseVersion; 	
END

/*** City ***" */

alter table dbo.City alter column ctyGeoCoordinates nvarchar(40);

/*** StateCode was never used ***" */
IF OBJECT_ID('StateCode') IS NOT NULL DROP TABLE dbo.StateCode
IF OBJECT_ID('RowSecurity') IS NOT NULL DROP TABLE dbo.RowSecurity
IF OBJECT_ID('RowLabel') IS NOT NULL DROP TABLE dbo.RowLabel
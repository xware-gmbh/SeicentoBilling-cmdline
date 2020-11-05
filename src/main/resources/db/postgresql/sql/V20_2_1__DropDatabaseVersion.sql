/****** Object: ProjectLine : Zeit von/bis ***/
    ALTER TABLE dbo.RowObject DROP CONSTRAINT DatabaseVersion_RowObject;
    ALTER TABLE dbo.RowObject DROP Column objdbvId;
	DROP TABLE DatabaseVersion; 	

/*** City ***" */

alter table dbo.City alter column ctyGeoCoordinates TYPE character(40);

/*** StateCode was never used ***" */
DROP TABLE dbo.StateCode
DROP TABLE dbo.RowSecurity
DROP TABLE dbo.RowLabel


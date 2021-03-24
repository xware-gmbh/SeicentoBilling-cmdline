/***
 * TFS#423 Drittleistungen in Conversion
 * 
 ***/

IF NOT EXISTS (SELECT 1 FROM [dbo].[Conversion] WHERE [cnvValueIn] = 'a.Drittleistungen')  
BEGIN 
    INSERT INTO [dbo].[Conversion]   
        ([cnvGroup]  
        ,[cnvSubGroup]  
        ,[cnvValueIn]
        ,[cnvValueOut]
        ,[cnvRemark]
        ,[cnvDataType]
        ,[cnvState])  
    VALUES 
        ('account', 'abacus', 'a.Drittleistungen', '4400','#423' ,1,1)
 
END 


/****** Object:  Table [dbo].[ProjectAllocation]  #292 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = N'ProjectAllocation')
BEGIN
	CREATE TABLE [dbo].[ProjectAllocation](
	[praId] [bigint] IDENTITY(1,1) NOT NULL,
	[pracsaId] [bigint] NOT NULL,
	[praproId] [bigint] NOT NULL,
	[praStartDate] [date] NOT NULL,
	[praEndDate] [date] NOT NULL,
	[praHours] [int] NOT NULL,
	[praIntensityPercent] [int] NOT NULL,
	[praRate] [decimal](6,2) NOT NULL,	
	[praRemark] [nvarchar](50) NULL,
	[praState] [smallint] NOT NULL,
 CONSTRAINT [PK_ProjectAllocation] PRIMARY KEY CLUSTERED 
(
	[praId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

ALTER TABLE [dbo].[ProjectAllocation]  WITH CHECK ADD  CONSTRAINT [FK_ProjectAllocation_Csa] FOREIGN KEY([pracsaId])
REFERENCES [dbo].[CostAccount] ([csaId])

ALTER TABLE [dbo].[ProjectAllocation]  WITH CHECK ADD  CONSTRAINT [FK_ProjectAllocation_Pro] FOREIGN KEY([praproId])
REFERENCES [dbo].[Project] ([proId])

ALTER TABLE [dbo].[ProjectAllocation] CHECK CONSTRAINT [FK_ProjectAllocation_Csa]
	
END
GO



/****** Add to Entity ****/            
IF NOT EXISTS (SELECT 1 FROM [dbo].[Entity] WHERE [entname] = 'ProjectAllocation')  
BEGIN 
    INSERT INTO [dbo].[Entity]   
        ([entName]  
        ,[entAbbreviation]  
        ,[entHasrowobject]
        ,[entState])  
    VALUES 
        ('ProjectAllocation', 'pra' ,1,1)
 
END

IF COL_LENGTH('[dbo].[Project]', 'proOrdergenerationStrategy') IS NULL
BEGIN
    ALTER TABLE [dbo].[Project]
    ADD proOrdergenerationStrategy smallint NOT NULL DEFAULT 0
	
END

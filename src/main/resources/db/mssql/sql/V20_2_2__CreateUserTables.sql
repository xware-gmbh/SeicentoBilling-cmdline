
/****** Object:  Table [dbo].[User]  ******/
CREATE TABLE [dbo].[AppUser](
	[usrId] [bigint] IDENTITY(1,1) NOT NULL,
	[username] [nvarchar](50) NULL,
	[usrFullName] [nvarchar](50) NULL,
	[usrThemeDesktop] [smallint] NULL,
	[usrThemeMobile] [smallint] NULL,
	[usrcsaId] [bigint] NULL,
	[usrcusid] [bigint] NULL,
	[usrLanguage] [nvarchar](10) NULL,
	[usrTimeZone] [nvarchar](50) NULL,
	[usrCountry] [nvarchar](10) NULL,
	[usrValidFrom] [datetime] NULL,
	[usrValidTo] [datetime] NULL,
	[usrRoles] [nvarchar](128) NULL,
	[usrState] [smallint] NULL,
	[password] [varbinary](256) NULL,
 CONSTRAINT [PK_AppUser] PRIMARY KEY CLUSTERED 
(
	[usrId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[AppUser]  WITH CHECK ADD  CONSTRAINT [FK_AppUser_CostAccount] FOREIGN KEY([usrcsaId])
REFERENCES [dbo].[CostAccount] ([csaId])
GO

ALTER TABLE [dbo].[AppUser] CHECK CONSTRAINT [FK_AppUser_CostAccount]
GO

ALTER TABLE [dbo].[AppUser]  WITH CHECK ADD  CONSTRAINT [FK_AppUser_Customer] FOREIGN KEY([usrcusid])
REFERENCES [dbo].[Customer] ([cusId])
GO

create unique index IX_username on [dbo].[AppUser] (username asc)
GO

/****** Add to Entity ****/            
IF NOT EXISTS (SELECT 1 FROM [dbo].[Entity] WHERE [entname] = 'AppUser')  
BEGIN 
    INSERT INTO [dbo].[Entity]   
        ([entName]  
        ,[entAbbreviation]  
        ,[entHasrowobject]
        ,[entState])  
    VALUES 
        ('AppUser', 'usr' ,1,1)
 
END             


/****** Insert admin User ****/            
IF NOT EXISTS (SELECT 1 FROM [dbo].[AppUser] WHERE [username] = 'admin')  
BEGIN 
    INSERT INTO [dbo].[AppUser]   
        ([username]  
        ,[usrFullName]  
        ,[usrThemeDesktop]
        ,[usrRoles]
        ,[usrState]
        ,[password])  
    VALUES 
        ('admin', 'Lokaler Admin' ,0, 'BillingAdmin', 1, 0x057BA03D6C44104863DC7361FE4578965D1887360F90A0895882E58A6248FC86),
        ('demo', 'Demo User' ,0, 'BillingUser', 1, 0x057BA03D6C44104863DC7361FE4578965D1887360F90A0895882E58A6248FC86)
END             

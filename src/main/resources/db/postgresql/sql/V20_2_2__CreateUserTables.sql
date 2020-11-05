
/****** Object:  Table dbo.User  ******/
CREATE TABLE dbo.AppUser(
	usrId bigserial NOT NULL,
	username character(50) NULL,
	usrFullName character(50) NULL,
	usrThemeDesktop smallint NULL,
	usrThemeMobile smallint NULL,
	usrcsaId bigint NULL,
	usrcusid bigint NULL,
	usrLanguage character(10) NULL,
	usrTimeZone character(50) NULL,
	usrCountry character(10) NULL,
	usrValidFrom date NULL,
	usrValidTo date NULL,
	usrRoles character(128) NULL,
	usrState smallint NULL,
	password bytea NULL
)WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE dbo.AppUser
    OWNER to postgres;

/****** Add to Entity ****/            
INSERT INTO dbo.Entity (entName,entAbbreviation,entHasrowobject,entState)  
    SELECT 'AppUser', 'usr' ,true,1
    WHERE NOT EXISTS (
        SELECT 1 FROM dbo.Entity WHERE entname = 'AppUser'
    );

    
/****** Insert admin User ****/            

INSERT INTO dbo.AppUser   
    (username  
    ,usrFullName  
    ,usrThemeDesktop
    ,usrRoles
    ,usrState
    ,password)  
SELECT 'admin', 'Lokaler Admin' ,0, 'BillingAdmin', 1, (E'0x057BA03D6C44104863DC7361FE4578965D1887360F90A0895882E58A6248FC86')
    WHERE NOT EXISTS (
        SELECT 1 FROM dbo.AppUser WHERE username = 'admin'
    );
    

INSERT INTO dbo.AppUser   
    (username  
    ,usrFullName  
    ,usrThemeDesktop
    ,usrRoles
    ,usrState
    ,password)  
SELECT ('demo', 'Demo User' ,0, 'BillingUser', 1, (E'0x057BA03D6C44104863DC7361FE4578965D1887360F90A0895882E58A6248FC86')
    WHERE NOT EXISTS (
        SELECT 1 FROM dbo.AppUser WHERE username = 'demo'
    );

    
    

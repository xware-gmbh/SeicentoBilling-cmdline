/** set Scheam first **/

CREATE SCHEMA IF NOT EXISTS dbo;
SET search_path TO dbo;

/***** originally exported from mssql and adapted. See: https://wiki.postgresql.org/wiki/Microsoft_SQL_Server_to_PostgreSQL_Migration_by_Ian_Harding ****/

/****** Object:  Table Vat    Script Date: 16.03.2020 12:56:57 ******/

-- Table: dbo.vat

-- DROP TABLE dbo.vat;

CREATE TABLE dbo.vat
(
    vatid bigserial NOT NULL,
    vatname character(40) COLLATE pg_catalog."default",
    vatrate numeric(6,4),
    vatsign character(5) COLLATE pg_catalog."default",
    vatinclude boolean DEFAULT false,
    vatstate smallint,
    vatextref character(20) COLLATE pg_catalog."default",
    vatextref1 character(20) COLLATE pg_catalog."default",
    CONSTRAINT pk__vat__id PRIMARY KEY (vatid),
    CONSTRAINT "ByVatSign" UNIQUE (vatsign)
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE dbo.vat
    OWNER to postgres;
    
/****** Object:  Table VatLine    Script Date: 16.03.2020 12:56:57 ******/

-- Table: dbo.vatline

-- DROP TABLE dbo.vatline;

CREATE TABLE dbo.vatline
(
    vanid bigserial NOT NULL,
    vanvalidfrom date NOT NULL,
    vanvatid bigint NOT NULL,
    vanrate numeric(6,4) NOT NULL,
    vanremark character(50) COLLATE pg_catalog."default",
    vanstate smallint NOT NULL,
    CONSTRAINT pk_vatline PRIMARY KEY (vanid),
    CONSTRAINT "FK_Vat" FOREIGN KEY (vanvatid)
        REFERENCES dbo.vat (vatid) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE dbo.vatline
    OWNER to postgres;

/****** Object:  Table Entity    Script Date: 16.03.2020 12:56:56 ******/

CREATE TABLE dbo.Entity(
	entId bigserial NOT NULL,
	entName character(40) NULL,
	entAbbreviation character(6) NULL,
	entDataclass character(256) NULL,
	entHasrowobject boolean NULL,
	entReadonly boolean NULL,
	entExport2sdf boolean NULL,
	entSdfOrdinal smallint NULL,
	entAuditHistory smallint NULL,
	entType int NULL,
	entState smallint NULL,
	CONSTRAINT PK_Entity PRIMARY KEY (entId),
    CONSTRAINT "ByEntName" UNIQUE (entname)
 )WITH(OIDS = false) 
 
TABLESPACE pg_default;

ALTER TABLE dbo.Entity
    OWNER to postgres; 
;
    
/****** Object:  Table PaymentCondition    Script Date: 16.03.2020 12:56:57 ******/

-- Table: dbo.paymentcondition

-- DROP TABLE dbo.paymentcondition;

CREATE TABLE dbo.paymentcondition
(
    pacid bigserial NOT NULL,
    paccode character(5) COLLATE pg_catalog."default",
    pacname character(50) COLLATE pg_catalog."default",
    pacnbrofdays integer NOT NULL DEFAULT 0,
    pacstate smallint,
    pacextref1 character(20) COLLATE pg_catalog."default",
    CONSTRAINT pk_paymentconditi PRIMARY KEY (pacid),
    CONSTRAINT "ByPCode" UNIQUE (paccode)
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE dbo.paymentcondition
    OWNER to postgres;

/****** Object:  Table Company    Script Date: 16.03.2020 12:56:56 ******/

;

;
CREATE TABLE dbo.Company(
	cmpId bigserial NOT NULL,
	cmpName character(40) NULL,
	cmpAddress character(40) NULL,
	cmpZip int NULL,
	cmpPlace character(40) NULL,
	cmpVatcode character(50) NULL,
	cmpCurrency character(5) NULL,
	cmpUid character(50) NULL,
	cmpPhone character(50) NULL,
	cmpMail character(50) NULL,
	cmpComm1 character(50) NULL,
	cmpBusiness character(50) NULL,
	cmpLogo bytea NULL,
	cmpJasperUri nchar(256) NULL,
	cmpBookingYear int NULL DEFAULT 2020,
	cmpLastOrderNbr int NULL DEFAULT 1,
	cmpLastItemNbr int NULL DEFAULT 1,
	cmpLastCustomerNbr int NULL DEFAULT 1,
	cmpReportUsr character(20) NULL,
	cmpReportPwd character(50) NULL,
	cmpState smallint NULL,
	cmpAbaActive boolean NULL,
	cmpAbaEndpointCus character(256) NULL,
	cmpAbaEndpointDoc character(256) NULL,
	cmpAbaUser character(20) NULL,
	cmpAbaMandator int NULL,
	cmpAbaMaxDays int NULL,
	cmpAbaEndpointCre character(256) NULL,
	cmpAbaEndpointCreDoc character(256) NULL,
	cmpAbaEndpointPay character(256) NULL,
 CONSTRAINT PK__Company__Id PRIMARY KEY  
(
	cmpId
))WITH(OIDS = false) 

;
    
/****** Object:  Table City    Script Date: 16.03.2020 12:56:56 ******/

-- Table: dbo.city

-- DROP TABLE dbo.city;

CREATE TABLE dbo.city
(
    ctyid bigserial NOT NULL,
    ctyname character(40) COLLATE pg_catalog."default" NOT NULL,
    ctycountry character(12) COLLATE pg_catalog."default",
    ctyregion character(20) COLLATE pg_catalog."default",
    ctygeocoordinates character(20) COLLATE pg_catalog."default",
    ctyzip integer,
    ctystate smallint,
    CONSTRAINT pk__city__id5 PRIMARY KEY (ctyid),
    CONSTRAINT "ByCtyName" UNIQUE (ctyname),
    CONSTRAINT "ByZip" UNIQUE (ctyzip)
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE dbo.city
    OWNER to postgres;
;
/****** Object:  Table Bank    Script Date: 16.03.2020 12:56:56 ******/
-- Table: dbo.bank

-- DROP TABLE dbo.bank;

CREATE TABLE dbo.bank
(
    bnkid bigserial NOT NULL,
    bnkname character(40) COLLATE pg_catalog."default",
    bnkaddress character(60) COLLATE pg_catalog."default",
    bnkctyid bigint,
    bnkaccount character(60) COLLATE pg_catalog."default",
    bnkiban character(60) COLLATE pg_catalog."default",
    bnkstate smallint,
    bnkesrtn character(20) COLLATE pg_catalog."default",
    bnkcustomernbr bigint,
    CONSTRAINT pk__bank__c1edfd34108b795b PRIMARY KEY (bnkid),
    CONSTRAINT "FK_City" FOREIGN KEY (bnkctyid)
        REFERENCES dbo.city (ctyid) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE dbo.bank
    OWNER to postgres;
    
/****** Object:  Table Customer    Script Date: 16.03.2020 12:56:56 ******/
-- Table: dbo.customer

-- DROP TABLE dbo.customer;

CREATE TABLE dbo.customer
(
    cusid bigserial NOT NULL,
    cusnumber integer NOT NULL,
    cusname character(40) COLLATE pg_catalog."default" NOT NULL,
    cusfirstname character(40) COLLATE pg_catalog."default",
    cuscompany character(40) COLLATE pg_catalog."default",
    cusaddress character(40) COLLATE pg_catalog."default",
    cuslastcontact timestamp without time zone,
    cusinfo text COLLATE pg_catalog."default",
    cusctyid bigint,
    cuspacid bigint NOT NULL,
    cusstate smallint,
    cuslastbill date,
    cusaccountmanager character(40) COLLATE pg_catalog."default",
    cusaccounttype smallint,
    cussalutation smallint,
    cusbirthdate timestamp without time zone,
    cusbillingtarget smallint,
    cusbillingreport smallint,
    cussinglepdf boolean,
    cusextref1 character(36) COLLATE pg_catalog."default",
    cusextref2 character(36) COLLATE pg_catalog."default",
    CONSTRAINT pk__customer__ba9897f31de57479 PRIMARY KEY (cusid),
    CONSTRAINT "ByNumber" UNIQUE (cusnumber),
    CONSTRAINT "FK_City" FOREIGN KEY (cusctyid)
        REFERENCES dbo.city (ctyid) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID,
    CONSTRAINT "FK_PaymentCondition" FOREIGN KEY (cuspacid)
        REFERENCES dbo.paymentcondition (pacid) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE dbo.customer
    OWNER to postgres;

/****** Object:  Table CostAccount    Script Date: 16.03.2020 12:56:56 ******/

-- Table: dbo.costaccount

-- DROP TABLE dbo.costaccount;

CREATE TABLE dbo.costaccount
(
    csaid bigserial NOT NULL,
    csacode character(5) COLLATE pg_catalog."default",
    csaname character(50) COLLATE pg_catalog."default",
    csacsaid bigint,
    csastate smallint,
    csaextref character(20) COLLATE pg_catalog."default",
    CONSTRAINT pk_costaccount PRIMARY KEY (csaid),
    CONSTRAINT "ByCode" UNIQUE (csacode),
    CONSTRAINT "FK_CostAccount_Parent" FOREIGN KEY (csacsaid)
        REFERENCES dbo.costaccount (csaid) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE dbo.costaccount
    OWNER to postgres;

/****** Object:  Table Periode    Script Date: 16.03.2020 12:56:57 ******/

-- Table: dbo.periode

-- DROP TABLE dbo.periode;

CREATE TABLE dbo.periode
(
    perid bigserial NOT NULL,
    pername character(80) COLLATE pg_catalog."default",
    peryear integer,
    permonth integer,
    percsaid bigint NOT NULL,
    perbookedexpense smallint,
    perbookedproject smallint,
    perstate smallint,
    persignoffexpense boolean,
    CONSTRAINT pk_periode PRIMARY KEY (perid),
    CONSTRAINT "ByPeriodeCst" UNIQUE (peryear, permonth, percsaid),
    CONSTRAINT "FK_CostAccount" FOREIGN KEY (percsaid)
        REFERENCES dbo.costaccount (csaid) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE dbo.periode
    OWNER to postgres;

/****** Object:  Table Address    Script Date: 16.03.2020 12:56:56 ******/

-- Table: dbo.address

-- DROP TABLE dbo.address;

CREATE TABLE dbo.address
(
    adrid bigserial NOT NULL,
    adrcusid bigint NOT NULL,
    adrindex smallint NOT NULL,
    adrtype smallint NOT NULL,
    adrline0 character(50) COLLATE pg_catalog."default",
    adrline1 character(50) COLLATE pg_catalog."default",
    adrzip character(50) COLLATE pg_catalog."default",
    adrcity character(50) COLLATE pg_catalog."default",
    adrvalidfrom date,
    adrregion character(50) COLLATE pg_catalog."default",
    adrcountry character(50) COLLATE pg_catalog."default",
    adrremark character(50) COLLATE pg_catalog."default",
    adrname character(50) COLLATE pg_catalog."default",
    adraddon character(50) COLLATE pg_catalog."default",
    adrsalutation smallint,
    adrstate smallint NOT NULL,
    CONSTRAINT pk_address PRIMARY KEY (adrid),
    CONSTRAINT "FK_Customer" FOREIGN KEY (adrcusid)
        REFERENCES dbo.customer (cusid) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE dbo.address
    OWNER to postgres; 

    
    
/****** Object:  Table Project    Script Date: 16.03.2020 12:56:57 ******/

-- Table: dbo.project

-- DROP TABLE dbo.project;

CREATE TABLE dbo.project
(
    proid bigserial NOT NULL,
    proname character(50) COLLATE pg_catalog."default" NOT NULL,
    proextreference character(50) COLLATE pg_catalog."default",
    prostartdate date NOT NULL,
    proenddate date,
    prohours integer,
    prointensitypercent integer,
    procusid bigint NOT NULL,
    procsaid bigint,
    prolastbill date,
    prorate numeric(6,2) NOT NULL,
    promodel smallint,
    provatid bigint,
    prostate smallint,
    proproid bigint,
    prodescription text COLLATE pg_catalog."default",
    proremark text COLLATE pg_catalog."default",
    proprojectstate smallint,
    procontact character(40) COLLATE pg_catalog."default",
    proadrid bigint,
    prointernal boolean,
    prohourseffective numeric(18,2),
    CONSTRAINT pk_project PRIMARY KEY (proid),
    CONSTRAINT "ByProName" UNIQUE (proname),
    CONSTRAINT "FK_Address" FOREIGN KEY (proadrid)
        REFERENCES dbo.address (adrid) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID,
    CONSTRAINT "FK_CostAccount" FOREIGN KEY (procsaid)
        REFERENCES dbo.costaccount (csaid) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID,
    CONSTRAINT "FK_Customer" FOREIGN KEY (procusid)
        REFERENCES dbo.customer (cusid) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID,
    CONSTRAINT "FK_ParentProject" FOREIGN KEY (proproid)
        REFERENCES dbo.project (proid) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID,
    CONSTRAINT "FK_Vat" FOREIGN KEY (provatid)
        REFERENCES dbo.vat (vatid) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE dbo.project
    OWNER to postgres;
    
/****** Object:  Table Expense    Script Date: 16.03.2020 12:56:56 ******/
-- Table: dbo.expense

-- DROP TABLE dbo.expense;

CREATE TABLE dbo.expense
(
    expid bigserial NOT NULL,
    expperid bigint NOT NULL,
    expproid bigint NOT NULL,
    expaccount character(50) COLLATE pg_catalog."default",
    expflagcostaccount boolean,
    expflaggeneric smallint,
    expvatid bigint,
    expdate date NOT NULL,
    exptext character(128) COLLATE pg_catalog."default",
    expunit smallint,
    expquantity numeric(6,2),
    expamount numeric(6,2) NOT NULL,
    expbooked date,
    expstate smallint,
    CONSTRAINT pk_expense PRIMARY KEY (expid),
    CONSTRAINT "FK_Periode" FOREIGN KEY (expperid)
        REFERENCES dbo.periode (perid) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID,
    CONSTRAINT "FK_Project" FOREIGN KEY (expproid)
        REFERENCES dbo.project (proid) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID,
    CONSTRAINT "FK_Vat" FOREIGN KEY (expvatid)
        REFERENCES dbo.vat (vatid) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE dbo.expense
    OWNER to postgres;
    
/****** Object:  Table ItemGroup    Script Date: 16.03.2020 12:56:56 ******/

-- Table: dbo.itemgroup

-- DROP TABLE dbo.itemgroup;

CREATE TABLE dbo.itemgroup
(
    itgid bigserial NOT NULL,
    itgnumber integer,
    itgname character(40) COLLATE pg_catalog."default",
    itgitgparent bigint,
    itgstate smallint,
    CONSTRAINT pk__itemgrou__1 PRIMARY KEY (itgid),
    CONSTRAINT "ByItgNumber" UNIQUE (itgnumber),
    CONSTRAINT "FK_ParentGroup" FOREIGN KEY (itgitgparent)
        REFERENCES dbo.itemgroup (itgid) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE dbo.itemgroup
    OWNER to postgres;

/****** Object:  Table Item    Script Date: 16.03.2020 12:56:56 ******/
-- Table: dbo.item

-- DROP TABLE dbo.item;

CREATE TABLE dbo.item
(
    itmid bigserial NOT NULL,
    itmident character(40) COLLATE pg_catalog."default" NOT NULL,
    itmname character(60) COLLATE pg_catalog."default",
    itmvatid bigint,
    itmprice1 numeric(10,3),
    itmprice2 numeric(10,3),
    itmunit integer,
    itmitgid bigint,
    itmstate smallint,
    itmaccount numeric(10,3),
    CONSTRAINT pk__item__1 PRIMARY KEY (itmid),
    CONSTRAINT "ByIdent" UNIQUE (itmident),
    CONSTRAINT "FK_ItemGroup" FOREIGN KEY (itmitgid)
        REFERENCES dbo.itemgroup (itgid) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID,
    CONSTRAINT "FK_Vat" FOREIGN KEY (itmvatid)
        REFERENCES dbo.vat (vatid) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE dbo.item
    OWNER to postgres;
    
/****** Object:  Table Language    Script Date: 16.03.2020 12:56:57 ******/

CREATE TABLE dbo.Language(
	lngId bigserial NOT NULL,
	lngCode int NOT NULL,
	lngName character(40) NOT NULL,
	lngIsocode character(4) NULL,
	lngKeyboard character(40) NULL,
	lngDefault boolean NULL,
	lngState smallint NULL,
 CONSTRAINT PK_Language PRIMARY KEY (lngId)
 )WITH(OIDS = false)
 
 TABLESPACE pg_default;
 ;
/****** Object:  Table Order    Script Date: 16.03.2020 12:56:57 ******/

-- Table: dbo."order"

-- DROP TABLE dbo."order";

CREATE TABLE dbo."Order"
(
    ordid bigserial NOT NULL,
    ordnumber integer NOT NULL,
    ordstate smallint,
    ordcreated timestamp without time zone,
    ordcreatedby character(20) COLLATE pg_catalog."default",
    ordorderdate timestamp without time zone,
    ordbilldate timestamp without time zone,
    ordcusid bigint NOT NULL,
    ordamountbrut numeric(10,3),
    ordamountnet numeric(10,3),
    ordpaydate timestamp without time zone,
    ordtext character(256) COLLATE pg_catalog."default",
    ordduedate timestamp without time zone,
    ordpacid bigint NOT NULL,
    ordbookedon timestamp without time zone,
    ordproid bigint,
    CONSTRAINT pk__order__1 PRIMARY KEY (ordid),
    CONSTRAINT "ByOrdNumber" UNIQUE (ordnumber),
    CONSTRAINT "FK_Customer" FOREIGN KEY (ordcusid)
        REFERENCES dbo.customer (cusid) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID,
    CONSTRAINT "FK_PaymentCondition" FOREIGN KEY (ordpacid)
        REFERENCES dbo.paymentcondition (pacid) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID,
    CONSTRAINT "FK_Project" FOREIGN KEY (ordproid)
        REFERENCES dbo.project (proid) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE dbo."Order"
    OWNER to postgres;
    
    
/****** Object:  Table OrderLine    Script Date: 16.03.2020 12:56:57 ******/

-- Table: dbo.orderline

-- DROP TABLE dbo.orderline;

CREATE TABLE dbo.orderline
(
    odlid bigserial NOT NULL,
    odlnumber integer NOT NULL,
    odlordid bigint,
    odlitmid bigint NOT NULL,
    odlquantity numeric(10,4) NOT NULL,
    odlprice numeric(10,3),
    odlvatid bigint NOT NULL,
    odlamountbrut numeric(10,3),
    odlamountnet numeric(10,3),
    odltext character(80) COLLATE pg_catalog."default",
    odlvatamount numeric(10,3),
    odldiscount numeric(10,3),
    odlcsaid bigint NOT NULL,
    odlstate smallint,
    CONSTRAINT pk__orderlin__fe6ac41d2f10007b PRIMARY KEY (odlid),
    CONSTRAINT "FK_CostAccount" FOREIGN KEY (odlcsaid)
        REFERENCES dbo.costaccount (csaid) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID,
    CONSTRAINT "FK_Item" FOREIGN KEY (odlitmid)
        REFERENCES dbo.item (itmid) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID,
    CONSTRAINT "FK_OrderHeader" FOREIGN KEY (odlordid)
        REFERENCES dbo."Order" (ordid) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID,
    CONSTRAINT "FK_Vat" FOREIGN KEY (odlvatid)
        REFERENCES dbo.vat (vatid) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE dbo.orderline
    OWNER to postgres;
    
/****** Object:  Table ProjectLine    Script Date: 16.03.2020 12:56:57 ******/
-- Table: dbo.projectline

-- DROP TABLE dbo.projectline;

CREATE TABLE dbo.projectline
(
    prlid bigserial NOT NULL,
    prlperid bigint NOT NULL,
    prlproid bigint NOT NULL,
    prlreportdate timestamp without time zone NOT NULL,
    prlhours numeric(6,2),
    prltext character(384) COLLATE pg_catalog."default",
    prlitmid bigint,
    prlworktype smallint,
    prlrate numeric(6,2),
    prlstate smallint,
    prltimefrom timestamp without time zone,
    prltimeto timestamp without time zone,
    CONSTRAINT pk_projectline PRIMARY KEY (prlid),
    CONSTRAINT "FK_Periode" FOREIGN KEY (prlperid)
        REFERENCES dbo.periode (perid) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID,
    CONSTRAINT "FK_Project" FOREIGN KEY (prlproid)
        REFERENCES dbo.project (proid) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE dbo.projectline
    OWNER to postgres;

/****** Object:  Table ProjectLineTemplate    Script Date: 16.03.2020 12:56:57 ******/

-- Table: dbo.projectlinetemplate

-- DROP TABLE dbo.projectlinetemplate;

CREATE TABLE dbo.projectlinetemplate
(
    prtid bigserial NOT NULL,
    prtcsaid bigint NOT NULL,
    prtkeynumber integer NOT NULL,
    prtproid bigint,
    prthours numeric(6,2),
    prttext character(384) COLLATE pg_catalog."default",
    prtrate numeric(6,2),
    prtworktype smallint,
    prtstate smallint NOT NULL,
    CONSTRAINT pk_projectlinetemplate PRIMARY KEY (prtid),
    CONSTRAINT "FK_CostAccount" FOREIGN KEY (prtcsaid)
        REFERENCES dbo.costaccount (csaid) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID,
    CONSTRAINT "FK_Project" FOREIGN KEY (prtproid)
        REFERENCES dbo.project (proid) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE dbo.projectlinetemplate
    OWNER to postgres;
    
    
/****** Object:  Table ResPlanning    Script Date: 16.03.2020 12:56:57 ******/

-- Table: dbo.resplanning

-- DROP TABLE dbo.resplanning;

CREATE TABLE dbo.resplanning
(
    rspid bigserial NOT NULL,
    rspplandate date NOT NULL,
    rspmode smallint NOT NULL,
    rspproid bigint,
    rspcsaid bigint NOT NULL,
    rsppercent integer NOT NULL,
    rsphours numeric(10,2) NOT NULL DEFAULT 0,
    rspstate smallint NOT NULL,
    CONSTRAINT pk_resplanning PRIMARY KEY (rspid),
    CONSTRAINT "FK_CostAccount" FOREIGN KEY (rspcsaid)
        REFERENCES dbo.costaccount (csaid) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID,
    CONSTRAINT "FK_Project" FOREIGN KEY (rspproid)
        REFERENCES dbo.project (proid) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE dbo.resplanning
    OWNER to postgres;
;    
    
/****** Object:  Table DatabaseVersion    Script Date: 16.03.2020 12:56:56 ******/

CREATE TABLE dbo.DatabaseVersion(
	dbvId bigserial NOT NULL,
	dbvMajor int NULL,
	dbvMinor int NULL,
	dbvMicro character(40) NULL,
	dbvReleased timestamp NULL,
	dbvDescription text NULL,
	dbvState smallint NULL,
 CONSTRAINT PK_DatabaseVersi PRIMARY KEY  
(
	dbvId
))WITH(OIDS = false) 
;

/****** Object:  Table ExpenseTemplate    Script Date: 16.03.2020 12:56:56 ******/

-- Table: dbo.expensetemplate

-- DROP TABLE dbo.expensetemplate;

CREATE TABLE dbo.expensetemplate
(
    extid bigserial NOT NULL,
    extkeynumber integer NOT NULL,
    extcsaid bigint NOT NULL,
    extproid bigint NOT NULL,
    extaccount character(50) COLLATE pg_catalog."default",
    extflagcostaccount boolean,
    extflaggeneric smallint,
    extvatid bigint,
    exttext character(128) COLLATE pg_catalog."default",
    extunit smallint,
    extquantity numeric(6,2),
    extamount numeric(6,2) NOT NULL,
    extstate smallint,
    CONSTRAINT pk_expensetemplate PRIMARY KEY (extid),
    CONSTRAINT "FK_CostAccount" FOREIGN KEY (extcsaid)
        REFERENCES dbo.costaccount (csaid) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID,
    CONSTRAINT "FK_Vat" FOREIGN KEY (extvatid)
        REFERENCES dbo.vat (vatid) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE dbo.expensetemplate
    OWNER to postgres;

/****** Object:  Table RowObject    Script Date: 16.03.2020 12:56:57 ******/

-- Table: dbo.rowobject

-- DROP TABLE dbo.rowobject;

CREATE TABLE dbo.rowobject
(
    objid bigserial NOT NULL,
    objentid bigint NOT NULL,
    objrowid bigint NOT NULL,
    objchngcnt bigint,
    objstate smallint,
    objadded timestamp without time zone,
    objaddedby character(30) COLLATE pg_catalog."default",
    objchanged timestamp without time zone,
    objchangedby character(30) COLLATE pg_catalog."default",
    objdeleted timestamp without time zone,
    objdeletedby character(30) COLLATE pg_catalog."default",
    objdbvid bigint,
    CONSTRAINT pk_rowobject PRIMARY KEY (objid),
    CONSTRAINT "ByEntityAndId" UNIQUE (objentid, objrowid),
    CONSTRAINT "FK_DBVersion" FOREIGN KEY (objdbvid)
        REFERENCES dbo.databaseversion (dbvid) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID,
    CONSTRAINT "FK_Entity" FOREIGN KEY (objentid)
        REFERENCES dbo.entity (entid) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE dbo.rowobject
    OWNER to postgres;
    
/****** Object:  Table Activity    Script Date: 16.03.2020 12:56:56 ******/
-- Table: dbo.activity

-- DROP TABLE dbo.activity;

CREATE TABLE dbo.activity
(
    actid bigserial NOT NULL,
    actdate timestamp without time zone NOT NULL,
    acttype smallint NOT NULL,
    actcusid bigint NOT NULL,
    acttext character(256) COLLATE pg_catalog."default",
    actfollowingupdate date,
    actcsaid bigint,
    actlink character(256) COLLATE pg_catalog."default",
    actstate smallint,
    CONSTRAINT pk_activity PRIMARY KEY (actid),
    CONSTRAINT "FK_CostAccount" FOREIGN KEY (actcusid)
        REFERENCES dbo.costaccount (csaid) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID,
    CONSTRAINT "FK_Customer" FOREIGN KEY (actcusid)
        REFERENCES dbo.customer (cusid) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE dbo.activity
    OWNER to postgres;



/****** Object:  Table ContactRelation    Script Date: 16.03.2020 12:56:56 ******/

-- Table: dbo.contactrelation

-- DROP TABLE dbo.contactrelation;

CREATE TABLE dbo.contactrelation
(
    corid bigserial NOT NULL,
    cortypeone smallint,
    corcusidtypeone bigint,
    cortypetwo smallint,
    corcusidtypetwo bigint,
    corremark character(50) COLLATE pg_catalog."default",
    CONSTRAINT pk_contactrelati PRIMARY KEY (corid),
    CONSTRAINT "FK_Customer_one" FOREIGN KEY (corcusidtypeone)
        REFERENCES dbo.customer (cusid) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID,
    CONSTRAINT "FK_Customer_two" FOREIGN KEY (corcusidtypetwo)
        REFERENCES dbo.customer (cusid) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE dbo.contactrelation
    OWNER to postgres;
/****** Object:  Table Conversion    Script Date: 16.03.2020 12:56:56 ******/


CREATE TABLE dbo.Conversion(
	cnvId bigserial NOT NULL,
	cnvGroup character(40) NOT NULL,
	cnvSubGroup character(40) NOT NULL,
	cnvValueIn character(80) NOT NULL,
	cnvValueOut character(80) NULL,
	cnvRemark character(80) NOT NULL,
	cnvDataType smallint NOT NULL,
	cnvState smallint NOT NULL,
 CONSTRAINT PK_Conversi PRIMARY KEY  
(
	cnvId
))WITH(OIDS = false) 

;
    
/****** Object:  Table CustomerLink    Script Date: 16.03.2020 12:56:56 ******/

-- Table: dbo.customerlink

-- DROP TABLE dbo.customerlink;

CREATE TABLE dbo.customerlink
(
    cnkid bigserial NOT NULL,
    cnkcusid bigint NOT NULL,
    cnkindex smallint NOT NULL,
    cnktype smallint NOT NULL,
    cnklink character(256) COLLATE pg_catalog."default" NOT NULL,
    cnkremark character(50) COLLATE pg_catalog."default",
    cnkvalidfrom timestamp without time zone,
    cnkdepartment smallint,
    cnkstate smallint NOT NULL,
    CONSTRAINT pk_customerlinks PRIMARY KEY (cnkid),
    CONSTRAINT "FK_Customer" FOREIGN KEY (cnkcusid)
        REFERENCES dbo.customer (cusid) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE dbo.customerlink
    OWNER to postgres;

/****** Object:  Table LabelDefinition    Script Date: 16.03.2020 12:56:57 ******/

;

;
CREATE TABLE dbo.LabelDefinition(
	cldId bigserial NOT NULL,
	cldType smallint NOT NULL,
	cldText character(50) NOT NULL,
	cldState smallint NOT NULL,
 CONSTRAINT PK_Label PRIMARY KEY (cldId)
 )WITH(OIDS = false) 
 
;
      

/****** Object:  Table LabelAssignment    Script Date: 16.03.2020 12:56:56 ******/

-- Table: dbo.labelassignment

-- DROP TABLE dbo.labelassignment;

CREATE TABLE dbo.labelassignment
(
    claid bigserial NOT NULL,
    clacusid bigint NOT NULL,
    clacldid bigint NOT NULL,
    claindex smallint,
    CONSTRAINT pk_labelassignment PRIMARY KEY (claid),
    CONSTRAINT "FK_Customer" FOREIGN KEY (clacusid)
        REFERENCES dbo.customer (cusid) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID,
    CONSTRAINT "FK_LabelDefinition" FOREIGN KEY (clacldid)
        REFERENCES dbo.labeldefinition (cldid) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE dbo.labelassignment
    OWNER to postgres;
    
    

/****** Object:  Table RowImage    Script Date: 16.03.2020 12:56:57 ******/

-- Table: dbo.rowimage

-- DROP TABLE dbo.rowimage;

CREATE TABLE dbo.rowimage
(
    rimid bigserial NOT NULL,
    rimobjid bigint NOT NULL,
    rimname character(128) COLLATE pg_catalog."default",
    rimicon bytea,
    rimimage bytea,
    rimstate smallint,
    rimmimetype character(60) COLLATE pg_catalog."default",
    rimnumber integer NOT NULL DEFAULT 1,
    rimtype smallint NOT NULL DEFAULT 0,
    rimsize character(10) COLLATE pg_catalog."default",
    CONSTRAINT pk_rowimage PRIMARY KEY (rimid),
    CONSTRAINT "FK_RowObject" FOREIGN KEY (rimobjid)
        REFERENCES dbo.rowobject (objid) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE dbo.rowimage
    OWNER to postgres;
;
/****** Object:  Table RowLabel    Script Date: 16.03.2020 12:56:57 ******/

-- Table: dbo.rowlabel

-- DROP TABLE dbo.rowlabel;

CREATE TABLE dbo.rowlabel
(
    lblid bigserial NOT NULL,
    lblobjid bigint NOT NULL,
    lbllngid bigint NOT NULL,
    lbllabelshort character(10) COLLATE pg_catalog."default",
    lbllabellong character(40) COLLATE pg_catalog."default",
    lblstate smallint,
    CONSTRAINT pk_rowlabel PRIMARY KEY (lblid),
    CONSTRAINT "FK_Language" FOREIGN KEY (lbllngid)
        REFERENCES dbo.language (lngid) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID,
    CONSTRAINT "FK_RowObject" FOREIGN KEY (lblobjid)
        REFERENCES dbo.rowobject (objid) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE dbo.rowlabel
    OWNER to postgres;



/****** Object:  Table RowParameter    Script Date: 16.03.2020 12:56:57 ******/

-- Table: dbo.rowparameter

-- DROP TABLE dbo.rowparameter;

CREATE TABLE dbo.rowparameter
(
    prmid bigserial NOT NULL,
    prmobjid bigint NOT NULL,
    prmgroup character(40) COLLATE pg_catalog."default",
    prmsubgroup character(40) COLLATE pg_catalog."default",
    prmkey character(20) COLLATE pg_catalog."default",
    prmvalue character(128) COLLATE pg_catalog."default",
    prmvaluetype smallint,
    prmstate smallint,
    prmparamtype smallint,
    prmlookuptable character(40) COLLATE pg_catalog."default",
    prmvisible boolean,
    CONSTRAINT pk_rowparameter PRIMARY KEY (prmid),
    CONSTRAINT "ByKeys" UNIQUE (prmobjid, prmgroup, prmsubgroup, prmkey),
    CONSTRAINT "FK_RowObject" FOREIGN KEY (prmobjid)
        REFERENCES dbo.rowobject (objid) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE dbo.rowparameter
    OWNER to postgres;
;
/****** Object:  Table RowRelation    Script Date: 16.03.2020 12:56:57 ******/

-- Table: dbo.rowrelation

-- DROP TABLE dbo.rowrelation;

CREATE TABLE dbo.rowrelation
(
    relid bigserial NOT NULL,
    relname character(40) COLLATE pg_catalog."default" NOT NULL,
    relorder integer,
    reldescription character(80) COLLATE pg_catalog."default",
    relobjid_source bigint NOT NULL,
    relobjid_target bigint NOT NULL,
    relstate smallint,
    CONSTRAINT pk_rowrelati PRIMARY KEY (relid),
    CONSTRAINT "FK_Source" FOREIGN KEY (relobjid_source)
        REFERENCES dbo.rowobject (objid) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID,
    CONSTRAINT "FK_Target" FOREIGN KEY (relobjid_target)
        REFERENCES dbo.rowobject (objid) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE dbo.rowrelation
    OWNER to postgres;

/****** Object:  Table RowSecurity    Script Date: 16.03.2020 12:56:57 ******/

-- Table: dbo.rowsecurity

-- DROP TABLE dbo.rowsecurity;

CREATE TABLE dbo.rowsecurity
(
    secid bigserial NOT NULL,
    secobjid bigint NOT NULL,
    sectype integer NOT NULL DEFAULT 0,
    secvalidfrom timestamp without time zone,
    secvalidto character(40) COLLATE pg_catalog."default",
    secstate smallint NOT NULL DEFAULT 0,
    secpermissionkey character(40) COLLATE pg_catalog."default",
    CONSTRAINT pk_rowsecurity PRIMARY KEY (secid),
    CONSTRAINT "FK_RowObject" FOREIGN KEY (secobjid)
        REFERENCES dbo.rowobject (objid) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE dbo.rowsecurity
    OWNER to postgres;

/****** Object:  Table RowText    Script Date: 16.03.2020 12:56:57 ******/

-- Table: dbo.rowtext

-- DROP TABLE dbo.rowtext;

CREATE TABLE dbo.rowtext
(
    txtid bigserial NOT NULL,
    txtobjid bigint NOT NULL,
    txtlngid bigint NOT NULL,
    txtnumber integer,
    txtfreetext text COLLATE pg_catalog."default",
    txtstate smallint,
    CONSTRAINT pk_rowtext PRIMARY KEY (txtid),
    CONSTRAINT "ByTxtNumber" UNIQUE (txtobjid, txtlngid, txtnumber),
    CONSTRAINT "FK_Language" FOREIGN KEY (txtlngid)
        REFERENCES dbo.language (lngid) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID,
    CONSTRAINT "FK_RowObject" FOREIGN KEY (txtobjid)
        REFERENCES dbo.rowobject (objid) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE dbo.rowtext
    OWNER to postgres;
    
/****** Object:  Table StateCode    Script Date: 16.03.2020 12:56:57 ******/

-- Table: dbo.statecode

-- DROP TABLE dbo.statecode;

CREATE TABLE dbo.statecode
(
    stcid bigserial NOT NULL,
    stcentid bigint NOT NULL,
    stcfieldname character(40) COLLATE pg_catalog."default",
    stccode integer,
    stccodename character(40) COLLATE pg_catalog."default",
    stcstate smallint,
    CONSTRAINT pk_statecode PRIMARY KEY (stcid),
    CONSTRAINT "FK_Entity" FOREIGN KEY (stcentid)
        REFERENCES dbo.entity (entid) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE dbo.statecode
    OWNER to postgres;
    

/****** Entity ****/            
    INSERT INTO dbo.Entity   
        (entName  
        ,entAbbreviation  
        ,entHasrowobject
        ,entState)  
    VALUES 
        ('Bank', 'bnk' ,true,1),
        ('City', 'cty' ,true,1),
        ('Company', 'cmp' ,true,1),
        ('Customer', 'cus' ,true,1),
        ('DatabaseVersion', 'dbv' ,true,1),
        ('Entity', 'ent' ,true,1),
        ('Item', 'itm' ,true,1),
        ('ItemGroup', 'itg' ,true,1),
        ('Language', 'lng' ,true,1),
        ('Order', 'ord' ,true,1),
        ('OrderLine', 'odl' ,true,1),
        ('RowImage', '' ,true,1),
        ('RowLabel', '' ,true,1),
        ('RowObject', '' ,false,1),
        ('RowParameter', '' ,true,1),
        ('RowRelation', '' ,true,1),
        ('RowSecurity', '' ,true,1),
        ('RowText', '' ,true,1),
        ('StateCode', '' ,true,1),
        ('Vat', 'vat' ,true,1),
        ('VatLine', 'van' ,true,1),        
        ('Expense', 'exp' ,true,1),
        ('Project', 'pro' ,true,1),
        ('ProjectLine', 'prl' ,true,1),
        ('Periode', 'per' ,true,1),
        ('PaymentCondition', 'pac' ,true,1),
        ('ResPlanning', 'rsp' ,true,1),
        ('CostAccount', 'csa' ,true,1),
        ('Activity', 'act' ,true,1),
        ('Address', 'adr' ,true,1),
        ('CustomerLink', 'cnk' ,true,1),
        ('LabelAssignment', 'cla' ,true,1),
        ('LabelDefinition', 'cld' ,true,1),
        ('ContactRelation', 'cor' ,true,1),
        ('ProjectLineTemplate', 'prt' ,true,1),
        ('ExpenseTemplate', 'ext' ,true,1),
        ('Activity', 'act' ,true,1),
        ('Address', 'adr' ,true,1),
        ('CustomerLink', 'cnk' ,true,1),
        ('LabelAssignment', 'cla' ,true,1),
        ('LabelDefinition', 'cld' ,true,1),
        ('ContactRelation', 'cor' ,true,1),
        ('Conversion', 'cnv' ,false,1)

        
  	ON CONFLICT DO NOTHING
;

/****** Language ****/            
    INSERT INTO dbo.Language   
        (lngCode  
        ,lngName  
        ,lngIsocode  
        ,lngKeyboard  
        ,lngDefault  
        ,lngState)  
    SELECT 1, 'Deutsch', 'CH', 'de_ch', true ,1
     WHERE NOT EXISTS (
        SELECT 1 FROM Language WHERE lngCode=1
    );



/****** Company ****/            
    INSERT INTO dbo.Company(cmpName,cmpState)  
    SELECT 'Demo Firma PG', 1
    WHERE NOT EXISTS (
        SELECT 1 FROM Company WHERE cmpState=1
    );
 
    
    INSERT INTO dbo.RowObject(objentId,objRowId,objState)
	select entId, (select cmpId from dbo.Company where cmpState =1), 1
	FROM dbo.Entity WHERE entName = 'Company'
	ON CONFLICT DO NOTHING;

	
/****** Initial Value für Bank ******/
    INSERT INTO dbo.Bank (bnkName,bnkAddress,bnkState)  
    SELECT 'Demo', 'Gartenweg' ,1
    WHERE NOT EXISTS (
        SELECT 1 FROM Bank WHERE bnkName='Demo'
    );
 
/****** Initial Value für Conversion ******/    
    INSERT INTO dbo.Conversion   
        (cnvGroup  
        ,cnvSubGroup  
        ,cnvValueIn
        ,cnvValueOut
        ,cnvRemark
        ,cnvDataType
        ,cnvState)  
    VALUES 
        ('account', 'abacus' ,'a.Spesen', '5830', '', 1,1),
        ('account', 'abacus' ,'a.Weiterbildung', '5810', '', 1,1),
        ('account', 'abacus' ,'a.Büroaufwand', '6500', '', 1,1),
        ('account', 'abacus' ,'a.Reisespesen', '6640', '', 1,1),
        ('account', 'abacus' ,'a.Repräsentation', '6640', '', 1,1),
        ('account', 'abacus' ,'a.Werbung / Marketing', '6600', '', 1,1),
        ('account', 'abacus' ,'a.Mietaufwand', '6000', '', 1,1),
        ('account', 'abacus' ,'a.EDV Unterhalt', '6120', '', 1,1)
;
/****** Initial Value für Label ******/    

    INSERT INTO dbo.LabelDefinition (cldType,cldText,cldState)  
    VALUES 
     (1, 'Weihnachtskarte' ,1),
     (1, 'Mitarbeiter' ,1),
     (1, 'Lieferant' ,1),
     (1, 'Lead' ,1),
     (1, 'Kunde' ,1)
 ;       

 
/****** Vat ****/
INSERT INTO dbo.Vat(vatName, vatRate, vatSign, vatInclude,vatState) 
    SELECT 'MwSt Normal inkl.', 7.7, 'N1', true, 1
    WHERE NOT EXISTS (
        SELECT 1 FROM Vat WHERE vatSign='N1'
    );
    
INSERT INTO dbo.VatLine(vanValidFrom,vanvatId,vanRate, vanState)
	select '2019-01-01', (select vatId from dbo.Vat where vatState =1), 7.7, 1
	ON CONFLICT DO NOTHING;
	
/****** Parameter on Company for Billing ****/	
    INSERT INTO dbo.rowparameter(prmobjid, prmGroup,prmSubGroup,prmKey,prmValue,prmValueType,prmState)
	select objid, 'billing', 'generator' , 'headerText', 'Gemäss Projektauftrag {proExtReference}  Name: {proName}', 0,1
		from dbo.RowObject, dbo.Entity where objentId  = entId and entName = 'Company'
	ON CONFLICT DO NOTHING;

    INSERT INTO dbo.rowparameter(prmobjid, prmGroup,prmSubGroup,prmKey,prmValue,prmValueType,prmState)
	select objid, 'billing', 'generator' , 'lineTextProject', 'Dienstleistung {csaCode} gemäss beigelegtem Rapport', 0,1
		from dbo.RowObject, dbo.Entity where objentId  = entId and entName = 'Company'
	ON CONFLICT DO NOTHING;
	
    INSERT INTO dbo.rowparameter(prmobjid, prmGroup,prmSubGroup,prmKey,prmValue,prmValueType,prmState)
	select objid, 'billing', 'generator' , 'itemIdentProject', '2000', 0,1
		from dbo.RowObject, dbo.Entity where objentId  = entId and entName = 'Company'
	ON CONFLICT DO NOTHING;
	
    INSERT INTO dbo.rowparameter(prmobjid, prmGroup,prmSubGroup,prmKey,prmValue,prmValueType,prmState)
	select objid, 'billing', 'generator' , 'lineTextExpense', 'Spesen {csaName}', 0,1
		from dbo.RowObject, dbo.Entity where objentId  = entId and entName = 'Company'
	ON CONFLICT DO NOTHING;
	
    INSERT INTO dbo.rowparameter(prmobjid, prmGroup,prmSubGroup,prmKey,prmValue,prmValueType,prmState)
	select objid, 'billing', 'generator' , 'itemIdentExpense', '2102', 0,1
		from dbo.RowObject, dbo.Entity where objentId  = entId and entName = 'Company'
	ON CONFLICT DO NOTHING;
	
    INSERT INTO dbo.rowparameter(prmobjid, prmGroup,prmSubGroup,prmKey,prmValue,prmValueType,prmState)
	select objid, 'billing', 'generator' , 'lineTextJourney', 'Reisezeit {csaName} gemäss Rapport', 0,1
		from dbo.RowObject, dbo.Entity where objentId  = entId and entName = 'Company'
	ON CONFLICT DO NOTHING;
	
    INSERT INTO dbo.rowparameter(prmobjid, prmGroup,prmSubGroup,prmKey,prmValue,prmValueType,prmState)
	select objid, 'billing', 'generator' , 'itemIdentJourney', '2100', 0,1
		from dbo.RowObject, dbo.Entity where objentId  = entId and entName = 'Company'
	ON CONFLICT DO NOTHING;
	
/*** Abacus Params **/
    INSERT INTO dbo.rowparameter(prmobjid, prmGroup,prmSubGroup,prmKey,prmValue,prmValueType,prmState)
	select objid, 'abacus' ,'soap', 'defcreditaccount', '3400', 1,1
		from dbo.RowObject, dbo.Entity where objentId  = entId and entName = 'Company'
	ON CONFLICT DO NOTHING;
	
    INSERT INTO dbo.rowparameter(prmobjid, prmGroup,prmSubGroup,prmKey,prmValue,prmValueType,prmState)
	select objid, 'abacus' ,'soap', 'drymode', 'true', 3,1
		from dbo.RowObject, dbo.Entity where objentId  = entId and entName = 'Company'
	ON CONFLICT DO NOTHING;
	
    INSERT INTO dbo.rowparameter(prmobjid, prmGroup,prmSubGroup,prmKey,prmValue,prmValueType,prmState)
	select objid, 'abacus' ,'soap', 'defcostaccount', '100', 1,1
		from dbo.RowObject, dbo.Entity where objentId  = entId and entName = 'Company'
	ON CONFLICT DO NOTHING;
	
    INSERT INTO dbo.rowparameter(prmobjid, prmGroup,prmSubGroup,prmKey,prmValue,prmValueType,prmState)
	select objid, 'abacus', 'soap' ,'maxdaysperiode', '30', 1,1
		from dbo.RowObject, dbo.Entity where objentId  = entId and entName = 'Company'
	ON CONFLICT DO NOTHING;

    INSERT INTO dbo.rowparameter(prmobjid, prmGroup,prmSubGroup,prmKey,prmValue,prmValueType,prmState)
	select objid, 'abacus' ,'soap', 'maxrecords', '3', 1,1
		from dbo.RowObject, dbo.Entity where objentId  = entId and entName = 'Company'
	ON CONFLICT DO NOTHING;
		
/****** ItemGroup ****/            
    INSERT INTO dbo.ItemGroup   
        (itgNumber  
        ,itgName  
        ,itgState)  
    VALUES 
        (1, 'Hauptartikelgrupp', 1),
        (10, 'Dienstleistungen', 1),
        (20, 'Produkte', 1),
        (200, 'Nebenprodukte', 1),
        (100, 'Dienstleitungen Dritte', 1),
        (101, 'Projekte', 1)
 ON CONFLICT DO NOTHING
; 
	
/****** Item ****/
INSERT INTO dbo.Item(itmIdent, itmName, itmitgid, itmPrice1, itmState) 
    SELECT '2000', 'Dienstlseitung',1, 100, 1
    WHERE NOT EXISTS (
        SELECT 1 FROM dbo.Item WHERE itmIdent='2000'
    );	

INSERT INTO dbo.Item(itmIdent, itmName, itmitgid, itmPrice1, itmState) 
    SELECT '2100', 'Reisezeit',1, 100, 1
    WHERE NOT EXISTS (
        SELECT 1 FROM dbo.Item WHERE itmIdent='2100'
    );
    
INSERT INTO dbo.Item(itmIdent, itmName, itmitgid, itmPrice1, itmState) 
    SELECT '2102', 'Spesen',1, 100, 1
    WHERE NOT EXISTS (
        SELECT 1 FROM dbo.Item WHERE itmIdent='2102'
    );	
    
/****** City ****/            
INSERT INTO dbo.City   
    (ctyName  
    ,ctyCountry  
    ,ctyRegion  
    ,ctyGeoCoordinates  
    ,ctyZIP  
    ,ctyState)  
VALUES 
    ('Sursee', 'CH', 'LU', '47.1780497:8.0710555', '6210', 1),
    ('Luzern', 'CH', 'LU', '47.1780497:8.0710555', '6000', 1),
    ('Oberhausen', 'DE', '', '47.1780497:8.0710555', '46047', 1),
    ('Oberkirch', 'CH', 'LU', '47.1780497:8.0710555', '6208', 1)
 	ON CONFLICT DO NOTHING
 	
;
 	
/****** PaymentCondition ****/            
INSERT INTO dbo.PaymentCondition   
        (pacCode  
        ,pacName  
        ,pacNbrOfDays  
        ,pacState)  
    VALUES 
        ('30N', 'Zahlbar netto innert 30 Tagen', 30, 1),
        ('1N', 'Zahlbar netto bei Erhalt', 1, 1),
        ('10N', 'Zahlbar netto innert 10 Tagen', 10, 1),
        ('20N', 'Zahlbar netto innert 20 Tagen', 20, 1),
        ('60N', 'Zahlbar netto innert 60 Tagen', 60, 1)
 ON CONFLICT DO NOTHING
             
;
    
/****** Customer ****/
INSERT INTO dbo.Customer(cusNumber, cusName, cusFirstName, cusctyId, cuspacId, cusState) 
    SELECT 1, 'Muster', 'Hans', 1, 1, 1
    WHERE NOT EXISTS (
        SELECT 1 FROM dbo.Customer WHERE cusNumber=1
    );	
	    
	

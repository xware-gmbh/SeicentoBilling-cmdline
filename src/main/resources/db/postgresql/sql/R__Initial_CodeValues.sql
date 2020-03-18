/** set Scheam first **/
SET search_path TO dbo;

/****** CostAccount ****/
INSERT INTO dbo.CostAccount(csaCode, csaName, csaState) 
    SELECT 'admin', 'local admin', 1
    WHERE NOT EXISTS (
        SELECT 1 FROM CostAccount WHERE csaCode='admin'
    );



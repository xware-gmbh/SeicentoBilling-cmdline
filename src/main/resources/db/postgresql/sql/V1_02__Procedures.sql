
/****** Dummy ******/
--CREATE PROCEDURE insert_mydata(a integer, b integer)
--LANGUAGE SQL
--AS $$
--INSERT INTO dbo.language(
--	lngid, lngcode, lngname, lngisocode, lngkeyboard, lngdefault, lngstate)
--	VALUES (a, 3, 'deutsch', '', '', 0::bit, 1);
--$$;

--CALL insert_mydata(1, 2);


/****** seicento_Calculate_ProjectHours ******/
CREATE OR REPLACE PROCEDURE dbo."seicento_Calculate_ProjectHours"(pid bigint)
LANGUAGE 'plpgsql'
AS $$
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	-- SET NOCOUNT ON;
 DECLARE
    ret    NUMERIC(18,2) := 0.0;
 BEGIN
 	SELECT SUM(p.prlHours) INTO ret 
		FROM dbo.ProjectLine p 
        WHERE p.prlproId = pid
           AND p.prlState = 1 and p.prlWorkType < 4;

    --CASE WHEN (ret IS NULL) THEN 
		--SET ret = 0.00;
	--END

	--DISABLE TRIGGER tr_seicento_postSaveProject ON Project;

	update dbo.Project set proHoursEffective = ret where proId = pid;

	--ENABLE TRIGGER tr_seicento_postSaveProject ON Project;  
END
$$;

COMMENT ON PROCEDURE dbo."seicento_Calculate_ProjectHours"
    IS 'Berechnen Stunden pro Projekt';
    
    
/****** seicento_CalculateAll_ProjectHours ******/
CREATE OR REPLACE PROCEDURE dbo."seicento_CalculateAll_ProjectHours"()
LANGUAGE 'plpgsql'
AS $$
 --DECLARE
--    field    INTEGER := 0;
--    cur	     CURSOR LOCAL for select proId from Project
 BEGIN
	 
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	--SET NOCOUNT ON;

    -- Insert statements for procedure here
	
--	open cur
	
--	fetch next from cur into field1

--	while @@FETCH_STATUS = 0 BEGIN

    	--execute your sproc on each row
--		EXEC [dbo].[seicento_Calculate_ProjectHours] @field1

--    	fetch next from cur into @field1
--	END

--	close cur
--	deallocate cur    
END
$$;

COMMENT ON PROCEDURE dbo."seicento_CalculateAll_ProjectHours"
    IS 'Berechnen Stunden für alle Projekte';
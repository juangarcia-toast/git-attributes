/*
	This Source Code is owned completely by Our Alter Ego Software (OAESoftware.com).
	Any use of this source code is explicitly prohibited unless authorized specifically and in writing by OAE Software.
	Copyright 2011-2016(c) OAE Software, LLC.
*/

/*
	$Author: juanm-mb $
	$Id: skinnyTemplate.sql 42285 2017-08-08 16:47:48Z juanmg $
	$Rev: 42286 $
  $URL: test.sql $: //www.perfecttrax.com/eStratEx/trunk/crmsql/scripts/skinnyTemplate.sql $
	$Date: Tue Feb 12 18:13:34 EST 2019 $
*/

DELIMITER $$

DROP PROCEDURE IF EXISTS `sp_Upgrade_Script` $$
CREATE PROCEDURE sp_Upgrade_Script()
BEGIN

  DECLARE _scriptName varchar(255);
	declare _rev varchar(255);

	DECLARE CONTINUE HANDLER FOR 1062
	BEGIN
     SET @upgradeMessage:=concat(@upgradeMessage,' Duplicate Key Warning. ');
	END;

	DECLARE CONTINUE HANDLER FOR 1061
	BEGIN
     SET @upgradeMessage:=concat(@upgradeMessage,' Duplicate Key Name Warning. ');
	END;

	DECLARE CONTINUE HANDLER FOR 1216
	BEGIN
     SET @upgradeMessage:=concat(@upgradeMessage,' Foreign Key Violated. ');
	END;

	DECLARE CONTINUE HANDLER FOR 1048
	BEGIN
     SET @upgradeMessage:=concat(@upgradeMessage,' Attempted to insert null value. ');
	END;

	DECLARE CONTINUE HANDLER FOR NOT FOUND
	BEGIN
     SET @upgradeMessage:=concat(@upgradeMessage,' No record found. ');
	END;


	set _scriptName: test.sql $:  svn: //www.perfecttrax.com/eStratEx/trunk/crmsql/scripts/skinnyTemplate.sql $';

	if locate('/',_scriptName)>0 then
		set _scriptName:=substring(_scriptName, 1+-1*locate('/' , reverse(_scriptName)));
	end if;

	set _scriptName:=trim(trailing '$' from _scriptName);
	if exists (select * from st_upgradehistory where
				scriptName like concat(_scriptName, '%') ) then
		set @upgradeMessage:=concat('This script already executed: ', _scriptName);
	else
		set @upgradeMessage:= _scriptName;
		set _rev: 1 $:  42285 $';
		if instr(_rev,'$Rev: ')>0 then
				set _rev:=trim(trailing '$' from substring(_rev,7));
		end if;
 		insert into st_upgradehistory (scriptName, runDate, author, runBy,revision)
		select _scriptName, now(), '$Author: juanm-mb $:  juanmg $',_rev;
		-- Do The script Work here.
		
		-- End Script work.
		call sp_updateschemaversion(1, 1798, 1798,'$Rev: 1 $
	end if;

END $$

DELIMITER ;

	set @upgradeMessage:='';
	call sp_Upgrade_Script();
	select @upgradeMessage as message from dual;
	set @upgradeMessage:='';

DROP PROCEDURE IF EXISTS `sp_Upgrade_Script` ;

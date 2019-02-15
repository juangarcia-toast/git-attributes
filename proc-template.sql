/*
	This Source Code is owned completely by Our Alter Ego Software (OAESoftware.com).
	Any use of this source code is explicitly prohibited unless authorized specifically and in writing by OAE Software.
	Copyright 2011(c) OAE Software, LLC.
*/

/*
	$Author: juanmg $
	$Id: SkinnyTemplate.sql 50221 2018-02-23 16:57:47Z juanmg $
	$Rev: 50221 $
	$URL: svn://www.perfecttrax.com/eStratEx/trunk/crmsql/procs/SkinnyTemplate.sql $
	$Date: 2018-02-23 11:57:47 -0500 (Fri, 23 Feb 2018) $
*/


DELIMITER $$
drop procedure if exists SkinnyTemplate $$

create procedure SkinnyTemplate(in _userId int, in _customerId int, in _viewcustomerId int, in _ipAddress varchar(255)) deterministic
main: begin
	/* declare variables */
	declare _revision varchar(255) default '$Rev: 50221 $';
	declare _roleID int default 0;
	declare _myEmployeeID int default 0;

	/* declare handlers */
	declare continue handler for not found begin  end;
	declare continue handler for sqlWarning begin end;
	/* set up some useful settings */

	if not af_allowcustomerAccess(_viewCustomerID, _userID) then
		leave main;
	end if;

	set _roleID:=fn_myRoleByIP(_userId , _customerId , _viewcustomerId , _ipAddress,fn_security_getUserRole(_userID)) ;
	
	

	
	/* code goes here */


end main $$

DELIMITER ;

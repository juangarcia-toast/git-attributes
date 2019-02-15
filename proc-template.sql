/*
	This Source Code is owned completely by Our Alter Ego Software (OAESoftware.com).
	Any use of this source code is explicitly prohibited unless authorized specifically and in writing by OAE Software.
	Copyright 2011(c) OAE Software, LLC.
*/

/*
	$Author: juanm-mb $
	$Id: proc-template.sql 1c1457cfb55694ae175661abefa245211b54021f Fri Feb 15 13:02:23 EST 2019 juanm-mb $
	$Rev: 1c1457cfb55694ae175661abefa245211b54021f $
	$URL: proc-template.sql $
	$Date: Fri Feb 15 13:02:23 EST 2019 $
*/


DELIMITER $$
drop procedure if exists SkinnyTemplate $$

create procedure SkinnyTemplate(in _userId int, in _customerId int, in _viewcustomerId int, in _ipAddress varchar(255)) deterministic
main: begin
	/* declare variables */
	declare _revision varchar(255) default '$Rev: 1c1457cfb55694ae175661abefa245211b54021f $';
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

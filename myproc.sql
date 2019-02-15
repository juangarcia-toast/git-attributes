/*
	This Source Code is owned completely by Our Alter Ego Software (OAESoftware.com).
	Any use of this source code is explicitly prohibited unless authorized specifically and in writing by OAE Software.
	Copyright 2011(c) OAE Software, LLC.
*/

/*
	$Author: juanmg-test $
	$Id: myproc.sql 052a6682d1adc87b609265be101a9d94d9221cc8 Fri Feb 15 13:09:48 EST 2019 juanmg-test $
	$Rev: 052a6682d1adc87b609265be101a9d94d9221cc8 $
	$URL: myproc.sql $
	$Date: Fri Feb 15 13:09:48 EST 2019 $
    $Notes: adding proc $
*/


DELIMITER $$
drop procedure if exists SkinnyTemplate $$

create procedure SkinnyTemplate(in _userId int, in _customerId int, in _viewcustomerId int, in _ipAddress varchar(255)) deterministic
main: begin
	/* declare variables */
	declare _revision varchar(255) default '$Rev: 052a6682d1adc87b609265be101a9d94d9221cc8 $';
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

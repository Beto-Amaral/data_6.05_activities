drop procedure if exists average_loss_proc;

delimiter //
create procedure average_loss_proc ()
begin
  declare avg_loss float default 0.0; -- Declaring a variable inside the procedure. With default we set the default value.
  select round((sum(amount) - sum(payments))/count(*), 2) into avg_loss
  from bank.loan
  where status = "B";
  select avg_loss;
  set avg_loss = 0.0; -- Reseting the value
end;
//
delimiter ;

call average_loss_proc();

show procedure status;
show function status;

show procedure status where Db = 'bank';
-- Compute the average balance left unpaid for every customer in status 'B'.
select round(avg(amount - payments),2) as Avg_left_unpaid from bank.loan
where status = "B";

-- Use the previous query inside a stored procedure
drop procedure if exists average_loss_proc;

delimiter //
create procedure average_loss_proc (out param1 float)
begin
  select round(avg(amount - payments),2) into param1 from bank.loan
  where status = "B";
end;
//
delimiter ;

call average_loss_proc(@x);
select round(@x,2) as Average_loss_per_customer;

-- Another example:
drop procedure if exists return_query_rows_proc;

delimiter //
create procedure return_query_rows_proc()
begin
  select * from bank.loan
  where status = "B";
end;
//
delimiter ;

call return_query_rows_proc();
-- Deleting the old procedure and creating a new one which will accept the customer status
drop procedure if exists average_loss_proc;

delimiter //
create procedure average_loss_proc (in param varchar(10)) -- Modifiying the arguments to INPUT parameters.
begin
  declare avg_loss float default 0.0;
  select round((sum(amount) - sum(payments))/count(*), 2) into avg_loss
  from bank.loan
  where status COLLATE utf8mb4_general_ci = param; -- This is needed to specify the character set.
  select avg_loss;
end;
//
delimiter ;

call average_loss_proc("A");

-- A query using a subquery to know the same based on the region and status:
select round((sum(amount) - sum(payments))/count(*), 2) as Avg_debt
from (
  select a.account_id, d.A2 as district, d.A3 as region, l.amount, l.payments, l.status
  from bank.account a
  join bank.district d
  on a.district_id = d.A1
  join bank.loan l
  on l.account_id = a.account_id
  where l.status = "B" and d.A3 = 'Prague'
) sub1;

-- We will see how to use two parameters in the next lesson.
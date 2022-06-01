-- 1. Crear un evento que  todos los días 1 de enero aumente el sueldo un 1%. (1,5p)
DELIMITER $$
drop event if exists sueldo1 $$
create event sueldo1 on
schedule every 1 year starts timestamp('2023-01-01') do
begin
	update salaries set salary=salary * 0.01 + salary;
end $$

delimiter ;
select * from salaries;

-- 2. Crear un procedimiento que cuando pase como parámetro el número de un trabajador (emp_no) me retorne 
-- su nombre y apellido, el código de empleado de su manager y el nombre de su departamento. (2p)
DELIMITER $$
drop procedure if exists num_trabajador $$
create procedure num_trabajador(in cod int, out nom_tr varchar(50), out ap_tr varchar(50), out cod_mgr char(20), out nom_dep varchar(50))
begin
	select first_name, last_name into @nom_tr, @ap_tr 
    from employees where emp_no = cod;

	select dm.emp_no into @cod_mgr
    from dept_manager dm, departments d, employees e, dept_emp de
    where e.emp_no = de.emp_no and de.dept_no = d.dept_no and d.dept_no = dm.dept_no and e.emp_no = cod;

	select d.dept_name into @nom_dep 
    from departments d, dept_emp de, employees e
    where e.emp_no = de.emp_no and de.dept_no = d.dept_no and e.emp_no = cod;
    
    select @nom_tr, @ap_tr, @cod_mgr, @nom_dep;
end$$

delimiter ;
call num_trabajador(1001, @nom_tr, @ap_tr, @cod_mgr, @nom_dep);
select * from employees;
select @nom_tr, @ap_tr, @cod_mgr, @nom_dep;

-- 3. Crear un trigger que para cada vez que cambiamos el salario de un trabajador no deje aumentarle 
-- o disminuirle más de un 20%. (Cuidado al ejecutar el evento del apartado 1 con este trigger activo.) (1,5p)

delimiter $$
drop trigger if exists disminuir $$
create trigger disminuir before update on salaries for each row
begin
	if new.salary > old.salary * 0.2 + old.salary then
		set new.salary = old.salary * 0.2 + old.salary;
	elseif new.salary < old.salary - (old.salary * 0.2) then
		set new.salary = old.salary - (old.salary * 0.2 );
    end if;
end $$

-- 4. Una tabla que contenga los siguientes campos: código de trabajador (cod_trab), salario_viejo, salario_nuevo, fecha (0,25p)
delimiter ;
drop table change_salaries;
create table change_salaries(
	cod_trab int not null,
    salario_viejo int,
    salario_nuevo int,
    fecha date
);

-- 5. Un trigger que registre el cambio de salario en la tabla anterior. (1,75p)
delimiter $$
drop trigger if exists guarda_salarios $$
create trigger guarda_salarios before update on salaries for each row
begin
	declare fecha_act date;
    set fecha_act = current_date();
	insert into change_salaries(cod_trab, salario_viejo, salario_nuevo, fecha) values(new.emp_no, old.salary, new.salary, fecha_act);
end $$

delimiter ;
select * from change_salaries;
update salaries set salary=6100 where emp_no=1000;
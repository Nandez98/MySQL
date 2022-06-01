CREATE TABLE notas_asgbd (
	numero_clase	INT,
	nombre			VARCHAR(30),
	apellido1		VARCHAR(30),
	apellido2		VARCHAR(30),
	nota			FLOAT(10,3)
	);
    
    CREATE TABLE notas_asgbd2 (
	numero_clase	INT,
	nombre			VARCHAR(30),
	apellido1		VARCHAR(30),
	apellido2		VARCHAR(30),
	nota			FLOAT(10,3)
	);

drop table notas_asgbd2;

INSERT INTO notas_asgbd VALUES (1, 'Breogan', 'Alicea', 'Rascón', 5.769);
INSERT INTO notas_asgbd VALUES (2, 'Aurea', 'Meza', 'Vega', 2.789);
INSERT INTO notas_asgbd VALUES (3, 'Adelma', 'Maestas', 'Velázquez', 7.365);

select * from notas_asgbd;

delimiter $$
drop procedure if exists cal $$
create procedure cal(in calf int)
begin
	declare control boolean default true;
	declare num_clase int;
    declare nom varchar(30);
    declare ap1 varchar(30);
    declare ap2 varchar(30);
    declare nota2 float;
    
    declare corte cursor for select numero_clase,nombre,apellido1,apellido2,nota from notas_asgbd;
    declare continue handler for not found set control=false;
    open corte;
		loop1:loop
        
        fetch corte into num_clase,nom,ap1,ap2,nota2;
        
			if control=false then
				leave loop1;
            end if;
        
			if nota2 >= calf then
				insert into notas_asgbd2 values(num_clase,nom,ap1,ap2,nota2);
			end if;
            
        end loop;
        select * from notas_asgbd2;
    close corte;
end $$

delimiter ;
call cal(5);
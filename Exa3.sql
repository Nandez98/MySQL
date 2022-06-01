delimiter $$
drop procedure if exists puntuacion_clase $$
create procedure puntuacion_clase()
begin
	declare clase_var char(3);
    declare puntos_var smallint;
    declare var_control int;
    declare i int;
	
    select sum(tantos_marcados), clase from Jugadores group by clase;
    
    set i=0;
    select count(clase) into var_control from Jugadores;
    
    loop1:loop
		SELECT clase, SUM(tantos_marcados) INTO clase_var, puntos_var FROM Jugadores 
        GROUP BY clase 
        ORDER BY puntos_var DESC LIMIT i,1;
        
        if i=0 then
			update Clases set puntuacion=puntuacion+2 where codigo=clase_var;
        elseif i=1 then
			update Clases set puntuacion=puntuacion+1 where codigo=clase_var;
        else
			update Clases set puntuacion=puntuacion where codigo=clase_var;
		end if;
        
        if i=var_control then
			leave loop1;
		end if;
	set i=i+1;
    end loop;
end $$

delimiter $$
drop event if exists act_puntuacion $$
create event act_puntuacion on schedule
every 1 week starts current_timestamp()
do
begin
	call puntuacion_clase;
end $$

-- ------------------------------------------------------------------

delimiter ;
show events from Baloncesto;
call puntuacion_clase();
select sum(tantos_marcados), clase from Jugadores group by clase;
select * from Clases;

-- ---------------------------------------------------------------------

create table capitanes(
	id int primary key not null auto_increment,
    ncapant varchar(50),
    acapant varchar(50),
    ncapact varchar(50),
    acapact varchar(50),
    clase char(3),
    fecambio date
);

delimiter $$
drop trigger if exists capitanes $$
create trigger capitanes after update on Clases for each row
begin
	SELECT nombre, apellido INTO @nombreold, @apellidosold FROM Jugadores WHERE codalumno=OLD.capitan; 
    SELECT nombre, apellido INTO @nombrenew, @apellidosnew FROM Jugadores WHERE codalumno=new.capitan; 
    
	insert into capitanes(ncapant,acapant,ncapact,acapact,clase,fecambio) values (@nombreold,@apellidosold,@nombrenew,@apellidosnew,new.codigo,current_date());
end $$

delimiter ;
update Clases set capitan='E1A777' where capitan='E1B996';
select * from capitanes;
select * from Clases;
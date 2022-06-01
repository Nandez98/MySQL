create database instituto;
use instituto;

create table notas_asgbd(
	numero_clase int,
    nombre varchar(50),
    apellido1 varchar(50),
    apellido2 varchar(50),
    nota float(3)
);

delimiter $$
drop trigger if exists comprobar_nota_insert $$
create trigger comprobar_nota_insert before insert on notas_asgbd for each
row
begin
if new.nota < 0 then set new.nota = 0;
elseif new.nota > 10 then set new.nota = 10;
end if;
end $$

delimiter ;
insert into notas_asgbd(numero_clase,nombre,apellido1,apellido2,nota) values(1,'Pablo','Martinez','Almeida',5.769);
insert into notas_asgbd values(2,'Juan','Pitis','Boris',-3.104);
insert into notas_asgbd values(3,'Jose','Pirri','Porris',13.859);

select * from notas_asgbd;

delimiter $$
drop trigger if exists comprobar_nota_update $$
create trigger comprobar_nota_update before update on notas_asgbd for each
row
begin
if new.nota < 0 then set new.nota = 0;
elseif new.nota > 10 then set new.nota = 10;
end if;
end $$

update notas_asgbd set nota= 5.769 where numero_clase = 1;
update notas_asgbd set nota=-3.104 where numero_clase=2;
update notas_asgbd set nota=13.859 where numero_clase=3;

select * from notas_asgbd;

-- 2.

create table datos_alumnos(
	DNI int,
	nombre varchar(50),
    apellido1 varchar(50),
    apellido2 varchar(50),
    email varchar(50)
);
drop table datos_alumnos;

delimiter $$
drop procedure if exists crear_email $$
create procedure crear_email(in dni int, in nombre varchar(50), in apellido1 varchar(50), in apellido2 varchar(50),out email varchar(50))
begin
    set email=concat(substring(dni,-3),substring(nombre,1,1),apellido1,substring(apellido2,1,1),"@educantabria.es");
end$$

delimiter $$
drop trigger if exists email_alumno $$
create trigger email_alumno before insert on datos_alumnos for each row
begin
	if new.email is null then
		call crear_email(new.dni,new.nombre,new.apellido1,new.apellido2,new.email);
	end if;
end$$

delimiter ;
insert into datos_alumnos values('13456689','Ramiro','Piadoso','Martinez','ramiroelpiadoso@educamesta.org');
insert into datos_alumnos(DNI,nombre,apellido1,apellido2) values('12442129','Dolores','Piedad','Ramira');
select * from datos_alumnos;

-- 3 HASTA AQUÍ BIEN

create table registro_cambio_email(
	id int primary key auto_increment,
    dni int,
    fecha date,
    correo_viejo varchar(50),
    correo_nuevo varchar(50)
);


delimiter $$
drop trigger if exists guarda_cambio_email $$
create trigger guarda_cambio_email after update on datos_alumnos for each row
begin
	if new.email!=old.email then
		insert into registro_cambio_email values(old.dni,date,old.email,new.email);
    end if;
end$$

update datos_alumnos set email="rampiadoso000@iesalisal.es" where dni='13456689';
update datos_alumnos set email="dolpiedad000@iesalisal.es" where dni='12442129'; 
select * from registro_cambio_email;
select * from datos_alumnos;

-- 4

create table alumnos_borrados(
	id int auto_increment primary key,
    fecha date,
    nombre varchar(50),
    apellido1 varchar(50),
	apellido2 varchar(50),
    email varchar(50)
);

delimiter $$
drop trigger if exists guarda_alumnos_borrados $$
create trigger guarda_alumnos_borrados after delete on datos_alumnos for each row
begin
	insert into alumnos_borrados values(old.DNI,old.nombre,old.apellido1,old.apellido2,old.email);
end$$

delete from datos_alumnos where nombre='Ramiro';
select * from datos_alumnos;
select * from alumnos_borrados;
delimiter $$
drop procedure if exists crea_usuario_administracion $$
create procedure crea_usuario_administracion(IN usuario varchar(20), IN contraseña varchar(20))
BEGIN
select usuario into @usuario;
select contraseña into @pass;
create user '@usuario'@'%' identified by '@pass';
grant select on empresa.trabajadores to '@usuario'@'%';
grant select on empresa.salarios to '@usuario'@'%';
grant select on empresa.vacaciones to '@usuario'@'%';
grant select on empresa.datos_empleados to '@usuario'@'%';
grant update(correo_electronico) on empresa.datos_empleados to '@usuario'@'%';
END$$

call crea_usuario_administracion(usuario1,Monitor*2)$$

-- Sin procedimiento
delimiter ;
create user 'usuario2'@'%' identified by 'Monitor?2';
grant select on empresa.trabajadores to 'usuario2'@'%';
grant select on empresa.salarios to 'usuario2'@'%';
grant select on empresa.vacaciones to 'usuario2'@'%';
grant select on empresa.datos_empleados to 'usuario2'@'%';
grant update(correo_electronico) on empresa.datos_empleados to 'usuario2'@'%';

create database if not exists Baloncesto;
use Baloncesto;

drop table if exists Jugadores;
create table Jugadores(
codalumno char(6) primary key not null, /* Formado por el código de Clase y 3 números. */
nombre varchar(20) not null,
apellido varchar(20) not null,
tantos_marcados smallint unsigned default 0, /* Puntos que va marcando el jugador en el campeonato. */
puesto tinyint unsigned not null,  /* Puesto que ocupa en el campo. El valor debe existir en tabla Puestos. */
clase char(3) not null
) engine = innodb;

drop table if exists Clases;
create table Clases(
codigo char(3) primary key not null, /* Está formado por 3 caracteres: Nivel, Curso y Grupo. */
grupo varchar(8) not null, 
nombre_tutor varchar(40), 
puntuacion int unsigned, /* Puntos que obtiene el equipo en el campeonato. Dos puntos por cada partido ganado. */
capitan char(7)  /* codalumno del jugador que ocupa este cargo. El valor debe existir en tabla Jugadores. */
) engine = innodb;

drop table if exists Puestos;
create table Puestos( /* Los únicos registros que puede tener la tabla son los que se han dado de alta. */
codigo tinyint(3) primary key not null auto_increment, 
nombre varchar(10) not null,
descripcion text null
) engine = innodb;

/* Las casas no pueden tener otro valor que no esté en esta relación */

insert into Clases VALUES ("E1A","1 ESO A","FEDERICO PEREZ",6,"E1A777"),
                         ("E1B","1 ESO B","TERESA CANO",2,"E1B996"),
						 ("E2A","2 ESO A","JAVIER GONZALEZ",0,"E2A655"),
						 ("E2B","2 ESO B","PATRICIA SANCHEZ",4,"E2B676");

/* Las casas no pueden tener otro valor que no esté en esta relación */

insert into Puestos set nombre = "BASE";   -- SON 1
insert into Puestos set nombre = "ALERO";    -- SON 2
insert into Puestos set nombre = "ALA-PIVOT";  -- SON 2
insert into Puestos set nombre = "PIVOT";   -- SON 1
insert into Puestos set nombre = "ESCOLTA";   -- SON 1

INSERT INTO Jugadores VALUES ("E2A666","MEPHISTO","ROZCO",12,3,"E2A"),
                             ("E2A766","MERLIN","WIZARD",16,3,"E2A"),
                             ("E2A655","MORGANA","PENDRAGON",7,1,"E2A"),
                             ("E2A676","MELQUIADES","BUHO",20,2,"E2A"),
							               ("E2A686","GIOVANNI","BERTUCCIO",10,5,"E2A"),
							               ("E2A606","ANNA","KARENINA",13,1,"E2A"),
							               ("E2A696","AL","DEGEA",22,4,"E2A"),
                             ("E1A777","ALEPH","ONSO",5,3,"E1A"),
                             ("E1A666","OLGA","SCOTT",15,3,"E1A"),
                             ("E1A888","PAUVAR","ELA",9,1,"E1A"),
                             ("E1A776","MELVIN","SQUIRRELS",22,1,"E1A"),
							               ("E1A689","JOHNNY","BERTO",26,5,"E1A"),
							               ("E1A603","ENRIQUE","ALFARERO",3,2,"E1A"),
							               ("E1A016","ALBUS","DEKA",14,4,"E1A"),							               
							               ("E2B666","EMMET","BROWN",17,3,"E2B"),
                             ("E2B626","PHIL","LIP",6,3,"E2B"),
                             ("E2B636","LINUS","STROMBERG",31,1,"E2B"),
                             ("E2B676","PAUL","FONTOFTHE",14,2,"E2B"),
							               ("E2B686","ANGEL","BIGTABLES",3,5,"E2B"),
							               ("E2B606","OSKAR","KRUM",9,1,"E2B"),
							               ("E2B696","TITTO","LOPEZ",18,4,"E2B"),
							               ("E1B777","RUCH","WORTH",8,3,"E1B"),
                             ("E1B666","ALF","MELMAC",16,3,"E1B"),
                             ("E1B996","NAZARIUS","FLINT",14,1,"E1B"),
                             ("E1B776","MELVIN","MCFLY",19,2,"E1B"),
							               ("E1B689","LORDDARTH","VADER",23,1,"E1B"),
							               ("E1B603","DRACO","MALFOY",4,1,"E1B"),
							               ("E1B016","SEVERIUS","STUKA",19,4,"E1B");								 

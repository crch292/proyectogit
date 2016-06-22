-- Database: cooperachadb

-- DROP DATABASE cooperachadb;

CREATE DATABASE cooperachadb
  WITH OWNER = postgres
       ENCODING = 'UTF8'
       TABLESPACE = pg_default
       LC_COLLATE = 'Spanish_Guatemala.1252'
       LC_CTYPE = 'Spanish_Guatemala.1252'
       CONNECTION LIMIT = -1;

 create table Ruta(
	cod_ruta serial,
	nombre varchar(20),
	primary key(cod_ruta) 
 )

 create table Rol(
	cod_rol serial primary key,
	nombre varchar(20)
 )

create table Formapago(
	cod_formapago serial primary key,
	nombre varchar(20)
)

create table Usuario(
	cod_usuario serial primary key,
	nickname varchar(30) not null unique,
	contraseña varchar(30) not null,
	nombre varchar(80) not null,
	fecha_nac date not null,
	direccion varchar(90),
	telefono int,
	estado boolean default true,
	cod_rol int references Rol(cod_rol) on delete cascade on update cascade,
	cod_formapago int references Formapago(cod_formapago) on delete cascade on update cascade
)

create table Categoria(
	cod_categoria serial primary key,
	nombre varchar(30) not null,
	descripcion varchar(90)
)

create table Subcategoria(
	cod_subcategoria serial primary key,
	nombre varchar(30) not null,
	descripcion varchar(90),
	cod_categoria int references Categoria(cod_categoria) on delete cascade on update cascade
)

create table Iniciativa(
	cod_iniciativa serial primary key,
	nombre varchar(50) not null,
	descripcion varchar(500) not null,
	meta decimal(7,2) not null,
	tiempo timestamp not null,
	cod_categoria int references Categoria(cod_categoria) on delete cascade on update cascade,
	cod_usuario int references Usuario(cod_usuario) on delete cascade on update cascade,
	estado boolean default true
)

create table Donacion(
	cod_donacion serial primary key,
	fecha date not null,
	cod_usuario int references Usuario(cod_usuario) on delete cascade on update cascade,
	cod_iniciativa int references Iniciativa(cod_iniciativa) on delete cascade on update cascade
)

create table Recompensa(
	cod_recompensa serial primary key,
	stock int ,
	precio_unidad decimal(6,2) not null,
	descripcion varchar(300),
	estado boolean default true,
	tipo varchar(30),
	cod_iniciativa int references Iniciativa(cod_iniciativa) on delete cascade on update cascade,
	cod_donacion int references Donacion(cod_donacion) on delete cascade on update cascade
)

alter table Recompensa
add entregado boolean default false;

create table Moderador(
	cod_moderador serial,
	cod_iniciativa int references Iniciativa(cod_iniciativa) on delete cascade on update cascade,
	cod_usuario int references Usuario(cod_usuario) on delete cascade on update cascade,
	primary key(cod_moderador,cod_iniciativa,cod_usuario)
	
)

create table Envio(
	cod_envio serial primary key,
	fecha date not null,
	precio decimal(6,2) not null,
	destino varchar(100) not null,
	fecha_entrega date,
	estado varchar(40) default 'transito',
	cod_recompensa int references Recompensa(cod_recompensa) on delete cascade on update cascade,
	cod_ruta int references Ruta(cod_ruta) on delete cascade on update cascade
)

create table Denuncia(
	cod_denuncia serial primary key,
	descripcion varchar(500) not null,
	cod_iniciativa int references Iniciativa(cod_iniciativa) on delete cascade on update cascade,
	cod_usuario int references Usuario(cod_usuario) on delete cascade on update cascade
)


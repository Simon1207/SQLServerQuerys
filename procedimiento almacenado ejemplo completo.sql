use test /* usa la BD test */

/* crea la tabla  usuario*/
create table usuario
(
id_usuario int primary key auto_increment not null,
nombre varchar(150) not null,
apellido varchar(150) not null,
fecha_reg timestamp default current_timestamp
)

desc usuario /* permite ver las caracteristicas de la tabla*/

/* procedimiento almacenado */
delimiter $
create procedure insertar(in nom varchar(150), in ape varchar(150)) /*los parametros agregados son variables creadas que van a resivir los datos  */
begin
	insert into usuario(nombre,apellido)values(nom,ape); /* inserte en los campos nombre y apellido, los valores que estan en las variables nom y ape*/

end $

delimiter $
create procedure borrar(in id int)
begin
	DELETE FROM usuario where id_usuario=id; /* id usuario sea igual al parametro que se esta enviando en el procedimiento almacenado */
end$

delimiter $
create procedure actualizar(in id int,in nom varchar(150),in ape varchar(150))
begin 
	UPDATE usuario
    set nombre=nom,apellido=ape where id_usuario=id;
end$

select * from usuario /* a este punto se comprueba que no hay datos en la tabla usuario de tenerlos es necesario borrarlos para comprobar el funcionamiento del procedimiento almacenadpo */

call insertar('simon','pintado')
call insertar('luis','angel')

call actualizar(2,'tefa','lopez');

call borrar(1); /* se manda el parametro del id usuario*/

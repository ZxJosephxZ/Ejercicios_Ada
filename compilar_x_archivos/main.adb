--Los archivos ads tienen la funcionalidad de hacer de encabezados (misma funcion que en c con los .h)
--gnatmake se encarga de compilar todo lo que necesite el archivo en cuestion
--Este es un ejemplo de lo util que pueden ser los paquetes.
with matematicas;
procedure main is
begin
   matematicas.MostrarCuadrado(5);
end Main;
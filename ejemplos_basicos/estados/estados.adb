with estados1;
with Ada.Text_IO;
use Ada.Text_IO;
use estados1;
--In y out son especificaciones de parametros que nos permite solo leer (in) y modificar (out) y los dos a la vez.
--Visibilidad (limited) y restricciones (public, private, protected)
--El publico esta por defecto
procedure estados is
Prueba:estados1.Cuenta;
begin
--Como se puede apreciar al compilar te dira que ocurrio un error al intentar manipular variables privadas
--Prueba.Saldo:=10;
--Pero si podemos implementar funciones que nos permitan obtener su valor o modificarlo
Put_Line(Integer'Image(devolver(Prueba)));
--En caso de no querer que un dato se duplique añadimos limited al private;
end estados;
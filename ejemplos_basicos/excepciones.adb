with Ada.Text_IO;
use Ada.Text_IO;
procedure excepciones is
begin
--declare nos permite declarar una variable dentro de un begin
declare
X:Integer;
--implementamos otro begin para tener separado por bloques el codigo
   begin
      X:=-10;
      Put_Line (Integer'Image(X));
   --Crear propias excepciones
   if X < 0 then
      raise Constraint_Error with "ERROR: El numero no puede ser negativo";
   end if;
   --Capturando excepciones
   exception
      when Constraint_Error => Put_Line ("Se capturo el error");
   end;
end excepciones;
--En caso de querer ver la excepcion en concreto debemos usar Ada.Exceptions.
--when E: Constraint_error ... podra usar la funcion Exception_Message(E) para mostrar el detalle
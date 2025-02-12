with Ada.Text_IO;
use Ada.Text_IO;
--Ada no usa punteros como en c sino usa accesos que son mas seguros
procedure punteros is 
type Horario_t is record
Nombre:String(1..5);
end record;
type Puntero_t is access Horario_t;
begin
--Reservacion de memoria mediante new
Prueba:Puntero_t:= new Horario_t'(Nombre => "juann");
Put_Line (Prueba.Nombre);
--Liberar memoria aunque Ada no tiene fugas de memoria como en c
--Free(Prueba);
end punteros;
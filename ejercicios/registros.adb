with Ada.Text_IO;
with Ada.Strings.Unbounded;
with Ada.Text_IO.Unbounded_IO;
with Ada.Text_IO.Enumeration_IO;
with Ada.Text_IO.Fixed_IO;
use Ada.Text_IO;
use Ada.Strings.Unbounded;

procedure registros is
type Mes_Tipo is (enero, febrero, marzo, abril, mayo, junio, julio, agosto, septiembre, octubre, noviembre, diciembre);
package Mes_IO is new Ada.Text_IO.Enumeration_IO(Mes_Tipo);
type Fecha is record
   Dia: Positive range 1..31;
   Mes: Mes_Tipo;
   Anio: Positive range 2000..2024;
end record;
begin
end;
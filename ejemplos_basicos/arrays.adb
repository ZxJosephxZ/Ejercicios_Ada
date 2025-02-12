with Ada.Text_IO;
--En caso de querer declarar un array sin importar la longitud
with Ada.Strings.Unbounded;
use Ada.Text_IO;
use Ada.Strings.Unbounded;
--Array estatico (dependiendo del tipo de dato se debe introducir exacto)
procedure arrays is
type Dias_t is (Lunes, Martes, Miercoles, Jueves, Viernes);
type Horas_t is range 0 .. 23;
type Horario_t is array (Dias_t, Horas_t) of String(1..20);
type Prueba is array (Dias_t, Horas_t) of String(1..3);
--array sin definir longitud
type Sin is array (Dias_t, Horas_t) of Unbounded_String;
Agenda:Horario_t;
Nulo:Sin;
begin
--En caso de querer inicializar el array lleno
Espacios: Prueba:= (others => (others => "000"));

Agenda(Lunes,10) := "01234567890123456789";
Nulo(Lunes,1):= To_Unbounded_String("Reunion");
Put_Line(Agenda(Lunes,10));
Put_Line (Espacios(Lunes,0));
Put_Line (To_String(Nulo(Lunes,0)));
Put_Line (To_String(Nulo(Lunes,1)));
end arrays;
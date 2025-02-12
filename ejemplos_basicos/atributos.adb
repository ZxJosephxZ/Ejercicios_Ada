with Ada.Text_IO;
use Ada.Text_IO;
--Ada cuenta con atributos como first,last,succ,pred.... que nos ayudan a trabajar con tipos de dato de manera segura
procedure atributos is
type Dias_t is (Lunes,Martes,Miercoles,Jueves,Viernes);
begin
Put_Line (Dias_t'Image(Dias_t'First));
Put_Line (Dias_t'Image(Dias_t'Last));
Put_Line (Dias_t'Image(Dias_t'Succ(Martes)));
Put_Line (Dias_t'Image(Dias_t'Pred(Miercoles)));
end atributos;
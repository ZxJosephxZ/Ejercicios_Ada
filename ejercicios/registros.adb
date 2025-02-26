--Librerias necesarias
with Ada.Text_IO; use Ada.Text_IO;
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
with Ada.Text_IO.Unbounded_IO;


procedure registros is
--Declaramos los nuevos tipos con su correspondiente restriccion, ademas de lo paquetes para poder leer datos
type Mes_Tipo is (enero, febrero, marzo, abril, mayo, junio, julio, agosto, septiembre, octubre, noviembre, diciembre);
package Mes_IO is new Ada.Text_IO.Enumeration_IO(Mes_Tipo);
type Fecha_Tipo is record
   Dia: Positive range 1..31;
   Mes: Mes_Tipo;
   Anio: Positive range 2000..2024;
end record;

type Nota_Tipo is delta 0.01 range 0.0 .. 10.0;
package Nota_IO is new Ada.Text_IO.Fixed_IO(Nota_Tipo);
--Registros
type Pelicula_Tipo is record
   Fecha:Fecha_Tipo;
   Titulo:Unbounded_String;
   Nota:Nota_Tipo;
end record;
--Delimitar a 100, el numero de peliculas
Max_Peliculas : constant := 100;
type Peliculas_Array is array(1..Max_Peliculas) of Pelicula_Tipo;
Peliculas : Peliculas_Array;
Num_peliculas : Natural := 0;
--Procedimiento para ordenar las peliculas por fecha
procedure Ordenar_Fecha is
begin
   for I in 2 .. Num_peliculas loop
      declare
         Temp:Pelicula_Tipo:=Peliculas(I);
         J : Integer := I - 1;
      begin
         while (J > 0) and then
            ((Peliculas(J).Fecha.Anio > Temp.Fecha.Anio) or ((Peliculas(J).Fecha.Anio = Temp.Fecha.Anio) and
            (Peliculas(J).Fecha.Mes > Temp.Fecha.Mes)) or ((Peliculas(J).Fecha.Anio = Temp.Fecha.Anio) and 
            (Peliculas(J).Fecha.Mes = Temp.Fecha.Mes) and (Peliculas(J).Fecha.Dia > Temp.Fecha.Dia))) loop
            Peliculas(J+1) := Peliculas(J);
            J := J-1;
            end loop;
            Peliculas(J+1) := Temp;  
      end;
   end loop;
end Ordenar_Fecha;
--Procesamiento para recibir fechas correctas por parte del usuario
procedure Leer_Numero (Mensaje : String; Num : out Integer) is
   Line : String(1..20);
   Last : Natural;
begin
   Put(Mensaje);
   --Flush(Standard_Output); -- Asegura que el mensaje se muestre antes de la entrada del usuario
   Get_Line(Line, Last);
   Num := Integer'Value(Line(1..Last));
exception
   when others =>
      Put_Line("Entrada no válida. Intente de nuevo.");
      Leer_Numero(Mensaje, Num); -- Llamada recursiva hasta que el usuario ingrese un número válido
end Leer_Numero;

begin

Leer_Numero("Ingrese el número de registros de películas: ", Num_peliculas);
New_Line;

if Num_peliculas > Max_Peliculas then
   Put_Line ("Numero maximo de registros superado. Se ajustara a " & Integer'Image(Max_Peliculas));
   Num_peliculas := Max_Peliculas;
end if;
--Lectura de los datos
for I in 1..Num_peliculas loop
   
   Put_Line("Registro " & Integer'Image(I));
   Put("Titulo: ");
   Peliculas(I).Titulo := Ada.Text_IO.Unbounded_IO.Get_Line;
   Leer_Numero("Día(1-31): ", Peliculas(I).Fecha.Dia);
   Put("Mes: "); Mes_IO.Get(Peliculas(I).Fecha.Mes);
   Skip_Line ;
   Leer_Numero("Año(2000-2024): ", Peliculas(I).Fecha.Anio);
   Put("Nota (0.0 - 10.0): ");Nota_IO.Get(Peliculas(I).Nota);
   Skip_Line;
end loop;

declare
   Nota_Min, Nota_Max : Nota_Tipo := Peliculas(1).Nota;
   Suma_Notas : Float:= FLoat(Peliculas(1).Nota);
   Pelicula_Min, Pelicula_Max : Pelicula_Tipo := Peliculas(1);
begin
   for I in 2 .. Num_Peliculas loop
      Suma_Notas:= Suma_Notas + Float(Peliculas(I).Nota);
      if Peliculas(I).Nota < Nota_Min then
         Nota_Min := Peliculas(I).Nota;
         Pelicula_Min := Peliculas(I);
      end if;
      if Peliculas(I).Nota > Nota_Max then
         Nota_Max := Peliculas(I).Nota;
         Pelicula_Max := Peliculas(I);
      end if;
   end loop;
--Mostrar por pantalla los datos del array
   Put_Line("Numero de registros: " & Integer'Image(Num_Peliculas));
   for I in 1 .. Num_Peliculas loop
      Put_Line("Registro Nº" & Integer'Image(I));
      Put_Line("Titulo: " & To_String(Peliculas(I).Titulo));
      Put_Line("Fecha. Dia: " & Integer'Image(Peliculas(I).fecha.Dia));
      Put_Line("Mes: " & Mes_Tipo'Image(Peliculas(I).fecha.Mes));
      Put_Line("Año: " & Integer'Image(Peliculas(I).fecha.Anio));
      Put_Line("Nota: "); Nota_IO.Put(Peliculas(I).Nota);
      New_Line;
   end loop;
--Calculo de la nota minima, maxima y media
   Put("Nota minima: "); Nota_IO.Put(Nota_Min);
   Put_Line(" Pelicula:" & To_String(Pelicula_Min.Titulo) & " alquilada el " & Integer'Image(Pelicula_Min.Fecha.Dia) &
      " de " & Mes_Tipo'Image(Pelicula_Min.Fecha.Mes) & " de " & Integer'Image(Pelicula_Min.Fecha.Anio));

   Put("Nota Maxima: ");Nota_IO.Put(Nota_Max);
   Put_Line(" Pelicula:" & To_String(Pelicula_Max.Titulo) & " alquilada el " & Integer'Image(Pelicula_Max.Fecha.Dia) &
      " de " & Mes_Tipo'Image(Pelicula_Max.Fecha.Mes) & " de " & Integer'Image(Pelicula_Max.Fecha.Anio));

   Put("La nota media del periodo " & Integer'Image(Peliculas(1).Fecha.Dia) &
      " de " & Mes_Tipo'Image(Peliculas(1).Fecha.Mes) & " de " & Integer'Image(Peliculas(1).Fecha.Anio) & " a " & Integer'Image(Peliculas(Num_Peliculas).Fecha.Dia) &
      " de " & Mes_Tipo'Image(Peliculas(Num_Peliculas).Fecha.Mes) & " de " & Integer'Image(Peliculas(NUm_Peliculas).Fecha.Anio) & " ha sido de");
      Nota_IO.Put(Nota_Tipo(Suma_Notas / Float(Nota_Tipo(NUm_Peliculas))));
      New_Line;
   end;
end registros;

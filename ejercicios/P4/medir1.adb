
-- Programa Medir1
with Ada.Text_IO, Ada.Real_Time, Sensor, Calefactor;
use Ada.Text_IO, Ada.Real_Time, Sensor, Calefactor;

procedure Medir1 is
   package Float_IO is new Ada.Text_IO.Float_IO(Float);
   Te, T_Inicial, T_Final: Temperaturas;
   L: Time_Span;
   Cp: Float;
   T_Start, T_End: Time;
begin
   -- Medir Te (Temperatura ambiente)
   Sensor.Leer(Te);
   --Put_Line("Temperatura ambiente (Te): " & Float'Image(Float(Te)));
   Put("Temperatura ambiente (Te): ");
   Float_IO.Put(Float(Te), Aft => 2, Exp => 0);
   new_line;
   -- Aplicar una potencia de 1000 W y medir el retardo L
   Calefactor.Escribir(1000.0);
   T_Start := Clock;
   loop
      Sensor.Leer(T_Inicial);
      exit when T_Inicial > Te;
   end loop;
   T_End := Clock;
   L := T_End - T_Start;
   Put_Line("Retardo (L): " & Duration'Image(To_Duration(L)) & " segundos");

   -- Esperar hasta régimen permanente
   delay 10.0;
   Sensor.Leer(T_Final);
   Cp := 1000.0 / Float((T_Final - Te));
   --Put_Line("Coeficiente de pérdidas (Cp): " & Float'Image(Cp) & " W/K");
   Put("Coeficiente de pèrdidas (Cp): ");
   Float_IO.Put(Float(Cp), Aft => 2, Exp => 0);
   -- Apagar el horno
   Calefactor.Escribir(0.0);
end Medir1;

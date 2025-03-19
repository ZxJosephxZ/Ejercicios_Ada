with Ada.Text_IO, Ada.Real_Time, Sensor, Calefactor;
use Ada.Text_IO, Ada.Real_Time, Sensor, Calefactor;

procedure Medir2 is
   package Float_IO is new Ada.Text_IO.Float_IO(Float);
   Te, T1, T2: Temperaturas;
   P: Potencias := 1000.0;
   Cp, Ct, Delta_T, Delta_Tiempo: Float;
   T_Start, T_End: Time;
begin
   -- Leer valores previos de Medir1
   Sensor.Leer(Te);
   Sensor.Leer(T1);
   Calefactor.Escribir(P);
   T_Start := Clock;
   delay 5.0;
   T_End := Clock;
   Sensor.Leer(T2);
   
   -- Calcular diferencias
   Delta_T := Float(T2 - T1);
   Delta_Tiempo := Float(To_Duration(T_End - T_Start));

   -- Depuración: Mostrar valores antes de cálculo
   --Put_Line("T1: " & Float'Image(Float(T1)) & " C");
   --Put_Line("T2: " & Float'Image(Float(T2)) & " C");
   --Put_Line("Delta_T: " & Float'Image(Delta_T));
   --Put_Line("Delta_Tiempo: " & Float'Image(Delta_Tiempo));
   Put("T1: ");
   Float_IO.Put(Float(T1), Aft => 2, Exp => 0);
   New_Line;

   Put("T2: ");
   Float_IO.Put(Float(T2), Aft => 2, Exp => 0);
   New_Line;

   Put("Delta_T: ");
   Float_IO.Put(Delta_T, Aft => 2, Exp => 0);
   New_Line;

   Put("Delta_Tiempo: ");
   Float_IO.Put(Delta_Tiempo, Aft => 2, Exp => 0);
   New_Line;
   -- Validar para evitar división por cero
if T2 = Te then
   Put_Line("Error: T1 es igual a Te, no se puede calcular Cp.");
else
   Cp := 1000.0 / Float(T2 - Te);
   Ct := (Float(P) - (Cp * Float(T2 - Te))) / (Delta_Tiempo / Delta_T);
   Put("Capacidad térmica (Ct): ");
   Float_IO.Put(Ct, Aft => 2, Exp => 0);
   New_Line;
end if;


   -- Apagar el horno
   Calefactor.Escribir(0.0);
end Medir2;


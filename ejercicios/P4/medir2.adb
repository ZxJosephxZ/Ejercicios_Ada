with Ada.Text_Io, Ada.Real_Time, Sensor, Calefactor;
use Ada.Text_Io, Ada.Real_Time, Sensor, Calefactor;

procedure Medir2 is
   Te, T1, T2: Temperaturas;
   P: Potencias := 1000.0;
   Cp, Ct, Delta_T, Delta_t: Float;
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
   Delta_T := Float(T2 - T1);
   Delta_t := Float(To_Duration(T_End - T_Start));
   Cp := 1000.0 / (T1 - Te);
   Ct := (P - Cp * (T1 - Te)) / (Delta_T / Delta_t);
   Put_Line("Capacidad térmica (Ct): " & Float'Image(Ct) & " J/K");
   
   -- Apagar el horno
   Calefactor.Escribir(0.0);
end Medir2;

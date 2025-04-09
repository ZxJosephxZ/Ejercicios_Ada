with Ada.Real_Time; use Ada.Real_Time;
with Retardadores;

package body Horno is
   -- Variable que almacena la temperatura interna del horno
   Temp_Interna : Temperaturas := 22.0;
   -- Variable que almacena la última potencia aplicada al calefactor
   Ultima_Potencia : Potencias := 0.0;

   -- Procedimiento para escribir la potencia al calefactor
   procedure Escribir(P: Potencias) is
   begin
      -- Actualiza la potencia aplicada
      Ultima_Potencia := P;
   end Escribir;

   -- Procedimiento para leer la temperatura interna del horno
   procedure Leer(T: out Temperaturas) is
   begin
      -- Si hay potencia, la temperatura aumenta
      if Ultima_Potencia > 0.0 then
         Temp_Interna := Temp_Interna + Temperaturas(Float(Ultima_Potencia) / 500.0);
      else
         -- Si no hay potencia, la temperatura disminuye lentamente
         Temp_Interna := Temp_Interna - 0.05;
      end if;

      -- Asegura que la temperatura no baje de 20°C
      if Temp_Interna < 20.0 then
         Temp_Interna := 20.0;
      end if;

      -- Retorna la temperatura actual
      T := Temp_Interna;
   end Leer;
end Horno;

with Ada.Real_Time;
use Ada.Real_Time;
package body Plan is
 -- Medir tiempo de ejecución de cada procedimiento
   procedure Medir (Procedimientos: array_ref_Procedimiento_t; Tiempos: out array_Tiempos_t) is
      T_Inicio, T_Fin: Time;
      Duracion: Time_Span;
   begin
      for I in Procedimientos'Range loop
         T_Inicio := Clock;
         Procedimientos(I).all;
         T_Fin := Clock;
         Duracion := T_Fin - T_Inicio;
         Tiempos(I) := Integer(To_Duration(Duracion) * 1000.0); -- en ms
      end loop;
   end Medir;
   -- Planificación según DMS
      procedure Planificar (Tareas: in out array_reg_Planificacion_t) is
      -- Ordenar por deadline ascendente, asignar prioridades
      procedure Ordenar is
      begin
         -- Ordena las tareas por D ascendente, asigna prioridad inversa
         for I in Tareas'Range loop
            for J in I + 1 .. Tareas'Last loop
               if Tareas(J).D < Tareas(I).D then
                  declare
                     Temp: reg_Planificacion_t := Tareas(I);
                  begin
                     Tareas(I) := Tareas(J);
                     Tareas(J) := Temp;
                  end;
               end if;
            end loop;
         end loop;
         -- Asignar prioridad inversa al orden (menor D → mayor P)
         for I in Tareas'Range loop
            Tareas(I).P := Tareas'Last - I + 1; -- menor D → mayor prioridad
         end loop;
      end Ordenar;
-- Cálculo del tiempo de respuesta Ri
      function Calcular_Ri (Idx: Integer) return Natural is
         R, R_Previous: Natural := Tareas(Idx).C;
      begin
         loop
            R_Previous := R;
            R := Tareas(Idx).C;
            for J in 1 .. Idx - 1 loop
               R := R + Integer(Float'Ceiling(Float(R_Previous) / Float(Tareas(J).T))) * Tareas(J).C;
            end loop;
            exit when R = R_Previous or R > Tareas(Idx).D;
         end loop;
         return R;
      end Calcular_Ri;

   begin
      Ordenar;
      for I in Tareas'Range loop
         Tareas(I).R := Calcular_Ri(I);
         Tareas(I).Planificable := Tareas(I).R <= Tareas(I).D;
      end loop;
   end Planificar;
end Plan;

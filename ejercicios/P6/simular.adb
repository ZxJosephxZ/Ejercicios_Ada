with Ada.Text_Io, Ada.Real_Time, Plan, Proc;
use Ada.Text_Io, Ada.Real_Time, Plan, Proc;

procedure Simular is
   -- Acceso a procedimientos
   Procedimientos: array_ref_Procedimiento_t := (P1'Access, P2'Access, P3'Access, P4'Access);

   -- Tabla de tareas planificadas (similares a las de Medir o Prueba)
   Tareas: constant array_reg_Planificacion_t := (
     (1, 2400, 600, 400, 4, 0, True),
     (2, 3200, 1200, 600, 3, 0, True),
     (3, 3600, 2000, 800, 2, 0, True),
     (4, 4000, 3200, 800, 1, 0, True)
   );

   -- Tipo de tarea periódica
   task type Tarea_Periodica (Id: Positive; Periodo: Natural; Ref: ref_Procedimiento_t);
   task body Tarea_Periodica is
      Next: Time := Clock;
      Iteraciones: constant := 5; -- ejecutar 5 veces
   begin
      for I in 1 .. Iteraciones loop
         Ref.all;
         Next := Next + Milliseconds(Periodo);
         delay until Next;
      end loop;
   end Tarea_Periodica;

   -- Arreglo dinámico de tareas lanzadas
   type Acceso_Tarea is access Tarea_Periodica;
   Tareas_Activas: array (Positive range <>) of Acceso_Tarea :=
     (1 => new Tarea_Periodica(1, 2400, P1'Access),
      2 => new Tarea_Periodica(2, 3200, P2'Access),
      3 => new Tarea_Periodica(3, 3600, P3'Access),
      4 => new Tarea_Periodica(4, 4000, P4'Access));
begin
   Put_Line("Simulación iniciada. Ejecutando tareas periódicas planificadas...");
   delay 30.0; -- esperar a que terminen todas (30s total aprox)
   Put_Line("Simulación finalizada.");
end Simular;

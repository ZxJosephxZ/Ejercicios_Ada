with Ada.Text_Io, Plan, Proc;
use Ada.Text_Io, Plan, Proc;

procedure Medir is
   package Integer_Es is new Integer_Io (Integer);
   use Integer_Es;

   Procedimientos: array_ref_Procedimiento_t := (P1'Access, P2'Access, P3'Access, P4'Access);
   Tiempos: array_Tiempos_t (Procedimientos'Range);

   Tareas: array_reg_Planificacion_t := (
      (1, 2400, 600, 0, 1, 0, False),
      (2, 3200, 1200, 0, 1, 0, False),
      (3, 3600, 2000, 0, 1, 0, False),
      (4, 4000, 3200, 0, 1, 0, False)
   );
begin
   Medir (Procedimientos, Tiempos);

   Put_line ("+--------------------------+");
   Put_Line ("| Procedimiento T.computo |");
   Put_line ("|--------------------------|");
   for I in Tiempos'Range loop
      Put ("| "); Put (I, Width => 13); Put (" ");
      Put (Tiempos(I), Width => 9); Put_Line (" |");
      Tareas(I).C := Tiempos(I);
   end loop;
   Put_line ("+--------------------------+");

   Planificar (Tareas);

   Put_line ("+--------------------------------------------------------+");
   Put_Line ("| Tarea     T     D     C     P     R  Planificable |");
   Put_line ("|--------------------------------------------------------|");
   for I in Tareas'Range loop
      Put ("| ");
      Put (Tareas(I).Nombre, Width=>5); Put ("  ");
      Put (Tareas(I).T, Width=>4); Put ("  ");
      Put (Tareas(I).D, Width=>4); Put ("  ");
      Put (Tareas(I).C, Width=>4); Put ("  ");
      Put (Tareas(I).P, Width=>4); Put ("  ");
      Put (Tareas(I).R, Width=>4); Put ("  ");
      if Tareas(I).Planificable then
         Put_Line ("          SI |");
      else
         Put_Line ("          NO |");
      end if;
   end loop;
   Put_line ("+--------------------------------------------------------+");
end Medir;

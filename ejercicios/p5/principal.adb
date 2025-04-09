with Ada.Text_IO, Ada.Real_Time, Sensor, Calefactor, PID;
use Ada.Text_IO, Ada.Real_Time, Sensor, Calefactor;

procedure Principal is
   package Float_IO is new Ada.Text_IO.Float_IO(Float);
   -- Declaración de variables para las temperaturas y parámetros
   Te, T1, T2: Temperaturas;
   Cp, Ct, Delta_T, Delta_Tiempo: Float;
   T_Start, T_End: Time;
   T_Referencia: Float;
   T_Actual: Temperaturas;
   P: Float;
   Tiempo_Inicio, Tiempo_Actual: Time;
begin
   -- Caracterización térmica del horno
   Sensor.Leer(Te); -- Lee la temperatura inicial
   Sensor.Leer(T1); -- Lee una segunda temperatura
   Calefactor.Escribir(Potencias(1000.0)); -- Aplica potencia al calefactor
   T_Start := Clock; -- Marca el inicio del proceso
   delay 5.0; -- Espera 5 segundos
   T_End := Clock; -- Marca el final del proceso
   Sensor.Leer(T2); -- Lee la temperatura después de aplicar potencia

   -- Cálculos para el modelo térmico del horno
   Delta_T := Float(T2 - T1);
   Delta_Tiempo := Float(To_Duration(T_End - T_Start));

   -- Verifica que las temperaturas no sean iguales (evita error en cálculos)
   if T2 = Te then
      Put_Line("Error: T2 es igual a Te, no se puede calcular Cp.");
      return;
   end if;

   -- Calcula el coeficiente Cp (calor específico)
   Cp := 1000.0 / Float(T2 - Te);
   -- Calcula el coeficiente Ct (constante térmica)
   Ct := (1000.0 - (Cp * Float(T2 - Te))) / (Delta_Tiempo / Delta_T);

   -- Imprime los resultados del modelo térmico
   Put_Line("Modelo térmico caracterizado:");
   Put("Cp: "); Float_IO.Put(Cp, Aft => 2, Exp => 0); New_Line;
   Put("Ct: "); Float_IO.Put(Ct, Aft => 2, Exp => 0); New_Line;

   -- Detiene el calefactor
   Calefactor.Escribir(Potencias(0.0));
   delay 5.0; -- Espera 5 segundos para estabilizar

   -- Control PID
   Put_Line("Ingrese la temperatura de referencia:");
   Float_IO.Get(T_Referencia); -- Lee la temperatura deseada
   PID.Programar(Kp => 2.0, Ki => 0.5, Kd => 1.0); -- Configura el controlador PID

   -- Inicia el control en un bucle de 10 minutos
   Tiempo_Inicio := Clock;
   loop
      Tiempo_Actual := Clock;
      -- Sale del bucle después de 600 segundos
      exit when To_Duration(Tiempo_Actual - Tiempo_Inicio) > 600.0;

      -- Lee la temperatura actual
      Sensor.Leer(T_Actual);
      -- Calcula la potencia requerida usando el controlador PID
      P := PID.Controlar(T_Referencia, Float(T_Actual));
      -- Limita la potencia entre 0 y 1000
      P := Float'Max(0.0, Float'Min(P, 1000.0));
      -- Aplica la potencia al calefactor
      Calefactor.Escribir(Potencias(P));

      -- Imprime la temperatura y la potencia aplicada
      Put("T: "); Float_IO.Put(Float(T_Actual), Aft => 2, Exp => 0);
      Put(" | P: "); Float_IO.Put(P, Aft => 2, Exp => 0);
      New_Line;

      -- Espera 1 segundo antes de la siguiente iteración
      delay 1.0;
   end loop;

   -- Apaga el calefactor al finalizar
   Calefactor.Escribir(Potencias(0.0));
end Principal;

-- pid.adb
with Ada.Real_Time;
use Ada.Real_Time;

package body PID is
   -- Declaración de los parámetros PID
   Kp, Ki, Kd: Float := 0.0;
   -- Variables para almacenar el valor acumulado de la integral y el error previo
   Integral, Previo_Error: Float := 0.0;
   -- Tiempo de la última ejecución
   Tiempo_Anterior : Time := Clock;

   -- Procedimiento para configurar los parámetros PID
   procedure Programar(Kp, Ki, Kd: Float) is
   begin
      -- Asignación de los parámetros PID
      PID.Kp := Kp;
      PID.Ki := Ki;
      PID.Kd := Kd;
      
      -- Inicialización de las variables de estado
      Integral := 0.0;
      Previo_Error := 0.0;
      Tiempo_Anterior := Clock; -- Almacena el tiempo de inicio
   end Programar;

   -- Función que calcula la salida del controlador PID
   function Controlar(Referencia, Actual: Float) return Float is
      -- Variables locales
      Error, Derivativo, Salida: Float;
      Tiempo_Actual: Time := Clock;
      -- Calcula el tiempo transcurrido desde la última ejecución
      Delta_T: Float := Float(To_Duration(Tiempo_Actual - Tiempo_Anterior));
   begin
      -- Evita la división por cero en el cálculo de la derivada
      if Delta_T = 0.0 then
         Delta_T := 0.1; -- Valor mínimo para evitar error
      end if;

      -- Cálculo del error (diferencia entre referencia y temperatura actual)
      Error := Referencia - Actual;
      -- Acumulación de la integral
      Integral := Integral + (Error * Delta_T);
      -- Cálculo del término derivativo (cambio del error respecto al tiempo)
      Derivativo := (Error - Previo_Error) / Delta_T;
      -- Cálculo de la salida del controlador PID
      Salida := (Kp * Error) + (Ki * Integral) + (Kd * Derivativo);
      -- Actualiza el error previo para la siguiente iteración
      Previo_Error := Error;
      -- Almacena el tiempo actual para la próxima ejecución
      Tiempo_Anterior := Tiempo_Actual;
      
      -- Retorna la salida calculada del controlador
      return Salida;
   end Controlar;
end PID;

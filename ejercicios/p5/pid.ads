package PID is
   -- Procedimiento para configurar los parámetros PID
   procedure Programar(Kp, Ki, Kd: Float);

   -- Función para calcular la salida del controlador PID basado en la referencia y la temperatura actual
   function Controlar(Referencia, Actual: Float) return Float;
end PID;


with Horno;

package body Sensor is
   -- Procedimiento para leer la temperatura desde el sensor
   procedure Leer (T: out Temperaturas) is
   begin
      -- Llama al procedimiento de Horno para obtener la temperatura interna
      Horno.Leer(Horno.Temperaturas(T));
   end Leer;
end Sensor;

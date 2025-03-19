-- Paquete Sensor
with Horno;
package body Sensor is
   procedure Leer (la_Temperatura: out Temperaturas) is
   begin
      Horno.Leer(la_Temperatura);
   end Leer;
end Sensor;

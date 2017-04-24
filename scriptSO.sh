#!/bin/bash

#Uso CPU Usuario
export usoCpuUsuario=$(top -n1 | grep CPU | tr -s ' ' | cut -d ' ' -f 2 | tr -s ',' '.' | cut -d '%' -f 1) 
echo "Uso cpu usuario: "
echo $usoCpuUsuario

#Uso CPU Sistema
export usoCpuSistema=$(top -n1 | grep CPU | tr -s ' ' | cut -d ' ' -f 4 | tr -s ',' '.' | cut -d '%' -f 1)
echo "Uso cpu sistema: "
echo $usoCpuSistema

#Uso CPU
export usoCPU=$(echo $usoCpuSistema + $usoCpuUsuario |bc)
echo "Uso cpu:"
echo $usoCPU

#Carga del sistema cada 5 minutos
export cargaSistema=$(cat /proc/loadavg | cut -d ' ' -f 2)
echo "Carga del sistema: "
echo $cargaSistema


#Uso de memoria Ram en megabytes
export usoRAM=$(free -m| grep Mem | tr -s ' ' | cut -d ' ' -f 3)
echo "Uso memoria RAM:"
echo $usoRAM


#Almacenamiento disponible en megabytes
export almacenamientoDisp=$(df -m | grep root | tr -s ' ' | cut -d ' ' -f 4)
echo "Almacenamiento disponible:"
echo $almacenamientoDisp

#Obtenemos prueba velocidad
echo -n > pruebaVelocidad
./speedtest-cli >> pruebaVelocidad

#Velocidad Descarga
export velDescarga=$(cat pruebaVelocidad | grep Download | cut -d ' ' -f 2)
echo "Velocidad Descarga:"
echo $velDescarga

#Velocidad Carga
export velCarga=$(cat pruebaVelocidad | grep Upload | cut -d ' ' -f 2)
echo "Velocidad carga:"
echo $velCarga

#Thing Speak
curl --silent "http://api.thingspeak.com/update?key=PN4YHO499TVL22D1&field1=$usoCpuUsuario&field2=$usoCpuSistema&field3=$cargaSistema&field4=$usoRAM&field5=$almacenamientoDisp&field6=$velDescarga&field7=$velCarga"

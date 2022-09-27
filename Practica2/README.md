Sistemas de Comunicación I
# PRÁCTICA 2 - Detección Digital en Banda Base

Autores:
* *David Cocero Quintanilla*  
* *David Egea Hernández*

---

## 1. Introducción


!["Esquema completo del sistema"](Practica2/../images/1_esquema.png)

Los archivos desarrollados en esta práctica:
- `Modulador.m`



## 2. Modulador

El bloque correspondiente al demodulador digital en banda base se encarga de construir señales moduladas que varían en el tiempo en función de ciertos símbolos de entrada. Los símbolos de entrada se combinan linealmente con ciertas bases ortogonales para dar lugar a las señales moduladas.

!["Señales moduladas a utilizar"](Practica2/../images/2_signals.png)




Para las bases ortonormales phi1 y phi2 los coeficientes de las bases son: 
s1= [1 0]  s2=[0 1] s3=[-1 0] s4= [0 -1]


# Ejercicio 2.1

!["Secuencia de símbolos modulados"](Practica2/../images/2_1_simbolos_modulados.png)

# Ejercicio 3.1

!["Coeficientes demodulados"](Practica2/../images/3_1_coeficientes_demodulados.png)

# Ejercicio 4.1

!["Coeficientes detectados"](Practica2/../images/4_1_coeficientes_detectados.png)

# Ejercicio 5.1

!["Gráfica PE - SNR"](Practica2/../images/5_1_pe_snr.png)
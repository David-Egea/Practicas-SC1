Sistemas de Comunicación I
# PRÁCTICA 2 - Detección Digital en Banda Base

Autores:
* *David Cocero Quintanilla*  
* *David Egea Hernández*

---

# 1. Respuesta impulsional y en frecuencia de varios filtros 

En este apartado se analiza el comportamiento de cuatro filtros paso bajo diferentes.

**1. Comente la bondad relativa de los cuatro filtros para la transmisión en banda base en función de los criterios que estime conveniente.**

La respuesta impulsional de todos y cada uno de los filtros puede expresarse como un función de seno cardinal o *sinc*:

$sinc(x)=\frac {sin(\pi*x)}{\pi x}$

La propiedad principal de esta expresión matemática es que la función toma valor cero en los instantes $n*T$, siendo *n* es un número entero y *T* el período. 

!["Respuesta impulsional 4 filtros"](Practica3/../images/1_1_resp_imp_filtros.jpg "Respuesta impulsional de los 4 filtros")

La primera observación que se extrae de la gráfica anterior es que cuanto mayor es el valor de **α** de un filtro, mayor es también la velocidad a la que decaen las colas de su respuesta impulsional. Esto queda demostrado en el caso del filtro con α=1 (filtro de coseno alzado), cuyas colas son de menor magnitud. 

Por otro lado, es posible determinar si un filtro causa ISI o no en base de su respuesta impulsional, identificando si su función asociada vale cero en todos los puntos k*T, siendo *k* números enteros. En caso de un filtro no tome un valor nulo en alguno de estos instantes mencionados, es posible afirmar que este producirá distorsión. 

!["Respuesta f 4 filtros"](Practica3/../images/1_1_resp_frec_filtros.jpg "Respuesta en frecuencia de los 4 filtros")

En el caso de la respuesta en frecuencia, se observa como los cuatro filtros poseen comportamientos muy diferentes entre sí. Analizando individualmente cada uno de los filtros, comenzando por la **banda de paso** de cada uno de ellos: 
- Filtro α=0 (ideal): Posee una banda de paso marcada por el rizado, producto de la inviabilidad de recrear un filtro perfectamente ideal en MATLAB (irrealizable). 
- Filtro α=0.5: La banda de paso es estable 
- Filtro α=1 (coseno alzado perfecto): El problema de este filtro es que la banda de paso es muy pequeña, pudiendo afectar a la señal de entrada

Sobre la **banda de transición**: 
- Filtro α=0 (ideal): Como la pendiente de la banda de transición es la más pronunciada, este filtro posee la banda de rechazo más cercana en frecuencia. En un filtro completamente ideal (irrealizable), esta pendiende sería completamente vertical. La frecuecia límite de este filtro se encuentra en 0.4 Hz. 
- Filtro α=0.5: La pendiente en este caso es menor que la del filtro ideal, pero sigue siendo mejor que la del α=1
- Filtro α=1 (coseno alzado perfecto): A pesar de que esta banda empieza pronto, la pendiente es menos acusada

Sobre la **banda de rechazo**:
- Filtro α=0 (ideal): La banda de rechazo se encuentra a partir de 0.6 Hz. 
- Filtro α=0.5: la banda de 
- Filtro α=1 (coseno alzado perfecto): 

**2. Comente los resultados de las gráficas 1 y 2. A la vista de lo que está programado, ¿qué es el ancho de banda equivalente de ruido de los filtros?**

El ancho de banda equivalente de ruido es el ancho de banda de un filtro ideal rectangular que daría el mismo valor de ruido cuadrático medio (la misma potencia normalizada de ruido) en la salida frente a un ruido blanco en la entrada.

Se calcula haciendo la integral de la respuesta en frequencia del filtro al cuadrado entre 2 y despues se normaliza. 
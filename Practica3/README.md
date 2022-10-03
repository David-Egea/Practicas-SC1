Sistemas de Comunicación I
# PRÁCTICA 2 - Detección Digital en Banda Base

Autores:
* *David Cocero Quintanilla*  
* *David Egea Hernández*

---

# 1. Respuesta impulsional y en frecuencia de varios filtros 

En este apartado se analiza el comportamiento de cuatro filtros paso bajo diferentes.

### **1. Comente la bondad relativa de los cuatro filtros para la transmisión en banda base en función de los criterios que estime conveniente.**

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
- Filtro α=0.5: la banda de #TODO: Terminar la explicacion
- Filtro α=1 (coseno alzado perfecto): 

### **2. Comente los resultados de las gráficas 1 y 2. A la vista de lo que está programado, ¿qué es el ancho de banda equivalente de ruido de los filtros?**

El ancho de banda equivalente de ruido es el ancho de banda de un filtro ideal rectangular que daría el mismo valor de ruido cuadrático medio (la misma potencia normalizada de ruido) en la salida frente a un ruido blanco en la entrada.

Se calcula haciendo la integral de la respuesta en frequencia del filtro al cuadrado entre 2 y despues se normaliza. 

# 2.	Estudio del ISI sin ruido por medio de diagramas de ojo

### **3.	Comente las Figuras 3, 4 y 5.**

En la primera Figura 3 se observa un vector de muestras generadas aleatoriamente, que ha sido centrado en su propia secuencia. 

!["Figura 3: Vector de muestras eleatorias"](Practica3/../images/3_figura_3.jpg "Vector de muestras eleatorias")

La Figura 4 muestra la salida de los cuatro filtros al vector de muestras de la anterior figura. Se puede comprobar como, por efecto de la convolución, los primeros valores reflejados se encuentran retardos 50 muestras (la mitad de longitud del filtro). 

Cuando se produce un único valor, es decir, no se transmite el mismo valor de forma consecutiva durante varias muestras, el filtro de ISI reacciona con un sobreimpulso a dicho valor, superando la amplitud del pulso original introducido. En caso de que sean varias las muestras del mismo valor transmitidas consecutivamente, el filtro de ISI reacciona de forma opuesta. Este efecto contrario se traduce en valores de salida significativamente inferiores a los valores de entrada.  

Con respecto al resto de filtros, el efecto de la sobretensión se manifiesta claramente cuando se envía el mismo símbolo de forma consecutiva, siendo más pronunciado cuanto menor sea el factor de *roll-off* del filtro.

!["Figura 4: Respuesta temporal retardada de los 4 filtros"](Practica3/../images/3_figura_4.jpg "Respuesta temporal retardada de los 4 filtros")

En la Figura 5, se puede ver con mayor claridad el comportamiento analizado, al haber eliminado el retardo introducido por el filtro al inicio y al final de la secuencia. Además se muestra en la figura el vector de entrada utilizado. #Coment: comparacion con las muestras...

!["Figura 5: Respuesta temporal ajustada de los 4 filtros"](Practica3/../images/3_figura_5.jpg "Respuesta temporal ajustada de los 4 filtros")


### **4.	Relacione los sobreimpulsos con el valor de α. A nivel cualitativo, ¿qué impacto puede tener el sobreimpulso sobre la BER, cuando en lo filtros entra no solamente señal, sino también ruido?**

En el caso que concierne, el efecto del sobreimpulso no supone un peligro ni tiene un afectación directa sobre el BER, al ser un sistema de dos posibles símbolos. En este caso, como la sobretensión añade más amplitud a la señal, es incluso menor probable que se cometa un identificación errónea de un símbolo. 

Sin embargo, para alfabetos mayores, es decir, con una mayor cantidad de símbolos, este efecto si tiene afectación negativa sobre el BER. Al aumentar el nivel de la señal, esta puede llegar a ser confundida como el símbolo siguiente, de modo que la tasa de error aumentará. 

Por otro lado, la existencia de ruido agravará el error cometido por el filtro.

### **5.	¿Cómo se generan los diagramas de ojo?**

!["Diagrama de ojo "](Practica3/../images/5_ojo_alpha_1.jpg "Respuesta temporal ajustada de los 4 filtros")



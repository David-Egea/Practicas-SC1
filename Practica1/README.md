Sistemas de Comunicación I
# PRÁCTICA 1 - Demodulación Digital en Banda Base

Autores:
* *David Cocero Quintanilla*  
* *David Egea Hernández*


---
El objetivo de esta primera práctica es diferentes técnicas de demodulación de señales digitales estudiadas en teoría. Además se analizará el efecto de la presencia de ruido en el canal. 

En nuestro caso, hemos optado por desarrollar un demodulador por correlación. 

Las señales `s1` y `s2` que utilizadas en esta práctica son las siguientes:

!["Símbolos"](Practica1/../images/1_simbolos.jpg)

Para codificar estos simbolos, hemos utilizado las siguientes bases ortonormales:

$$ϕ_1 (t)={(s1 (t)) \over √T}$$

$$ϕ_2 (t)={(s2 (t)) \over √T}$$

Teniendo en cuenta estas bases, los coeficientes para los simbolos s1 y s2 son:

$$s1= $\sqrt T$ [1 0]$$       
$$s2= $\sqrt T$ [0 1]$$ 

## 2. Demodulador de un símbolo

Esta parte se centra en la implementación del demodulador por correlación. 

> Esta parte se desarrolla en la sección `2. Demodulador de un símbolo - Ejercicio 2.1` del *script** principal `main.m`. Adicionalmente, se ha generado la función del demodulador por correlación en `correlatorType.m`.

### Ejercicio 2.1
---
Representación temporal del vector de salida de ambos correladores para los dos posibles símbolos recibidos (i.e. s1 y s2). Es decir, los valores de y_n (t) para n = 1,¿Son los resultados lógicos? Coméntelos. Quizá sea una buena idea utilizar la función subplot para presentar los resultados. Asegúrese de que todas las gráficas tienen los mismos ejes para facilitar la comparación.
   
Para el simbolo s1, la salida del demodulador de phi1 subirá de forma constante hasta llegar a su valor final de 0.1 y la salida del demodulador de phi2 sube hasta la mitad del periodo y desde ahí baja hasta el cero. Este resultado tiene sentido ya que como hemos comentado, los coeficientes de s1 son $\sqrt T= \sqrt 0.01=0.1$ y 0 respectivamente, que se corresponden con los valores finales de los demoduladores.

!["Correlacion Demodulador s1"](Practica1/../images/2_1_s1.jpg "Correlacion Demodulador s1")

Analogamente, para el simbolo s2, la salida del demodulador de phi1 subirá hasta T/2 para despues bajar a cero y la salida del demodulador de phi2 subirá durante todo el periodo hasta 0.1. También es un resultado lógico ya que los coeficientes de s2 son 0 y $\sqrt T= \sqrt 0.01=0.1$ , idénticos a la muestra final de las salidas de los demoduladores.

!["Correlacion Demodulador s2"](Practica1/../images/2_1_s2.jpg "Correlacion Demodulador s2")


¿Cuál sería el instante temporal idóneo para hacer el muestreo y enviar la señal al detector?

Lo mejor sería hacer el muestreo en el punto final, ya que en este punto se hace la integral durante todo el periodo. Si vemos las salidas de los demoduladores, estas  suben o bajan hasta llegar al coeficiente real en la última muestra.  

---
### Ejercicio 2.2

> Este ejercio se encuentra en la sección `2. Demodulador de un símbolo - Ejercicio 2.2` en el script principal `main.m`

En este segundo ejercicio se introduce ruido blanco gaussiano a la señal. Recordemos que este tipo de ruido se caractiza por la distribución uniforme de su potencia en todo el espectro de frecuencias. 

Para añadir el ruido a la señal hemos empleado la función `awgn` que ofrece la [*Communications Toolbox*](https://es.mathworks.com/products/communications.html) de MATLAB <img src="https://logos-marcas.com/wp-content/uploads/2020/12/MATLAB-Logo.png" alt="drawing" width="30"/>

Aquí vemos una comparación de cómo el ruido afecta a los simbolos s1 y s2 para distintos valores de SNR. En este caso veremos qué sucede en el caso de usar 5,10 y 15 dB de SNR.


!["Comparativa de la señal entrada con y sin ruido"](Practica1/../images/2_2_compartiva_con_y_sin_ruido.jpg "Comparativa de la señal entrada con y sin ruido")

En la primera imagen se ve s1 original junto con sus modificaciones por el ruido y en la segunda aparece s2 con sus variantes. Se puede apreciar como 10 y 15 dB no afectan tanto pero con 5 dB la señal se distorsiona considerablemente. Aún así los picos de la señal no varian lo suficiente para que el detector  tenga problemas confundiéndose de simbolo entre s1 y s2. Por ello en este apartado seleccionaremos 5dB de SNR, ya que será el modo de transmisión más barato que sigue siendo correcto.

Abajo aparecen representadas las salidas de los 2 demoduladores para s1 (primera columna) y s2 (segunda columna)

!["Salida demodulador"](Practica1/../images/2_2_salida_demodulador.jpg "Salida demodulador")

Vemos que ahora el ruido hace que los coeficientes a la salida de los demoduladores no sean enteros. Para s1, y1 estará entorno a 1.3 mientras que y2 está sobre el 0.85. Con s2 ocurrirá lo mismo, aunque se desvían menos; con y1 situandose en 0.88 y y2 en 1.13
De todas formas, aunque los coeficientes no salgan enteros, el detector aproximará al simbolo más cercano por lo que la transmisión será correcta.


## 3. Salida del demodulador 

> Este ejercio se encuentra en la sección `3. Salida del demodulador - Ejercicio 3.1` en el script principal `main.m`

En este caso seguiremos con el mismo nivel de 5dB SNR para el ruido blanco que añadimos. Este se debe a que es el minimo SNR que se permite sin que haya errores de transmisión.

Además elegiremos un valor de Nsymb de 1000 para poder representar bien los histogramas.

Generamos los histogramas de la figura de abajo, con la salida de los demoduladores para s1 en la primera columna y para s2 en la segunda.

!["Histogramas"](Practica1/../images/3_histogramas.jpg "Histogramas")

Los cuatro histogramas parecen tener una distribución gausiana, con media en el valor real de los coeficientes: [1 1] para s1 y [1 -1] para s2. Estos resultados parecen correctos ya que el ruido blanco gausiano tiene distribución gausiana, así que a partir de un numero de muestras adecuado (1000 en nuestro caso), los histogramas tendrán una distribución similar.

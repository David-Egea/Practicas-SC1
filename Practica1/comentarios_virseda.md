Por favor, repetid la práctica con los comentarios que vienen a continuación. Hay errores importantes que es necesario que corrijáis y sobretodo que lo entendáis.

No realizáis bien el muestreo de la señal. El período de muestreo debe ser T/20. En vuestro caso al representarlo con la expresión t=linspace(0,T,T/Ts); no os coincide con ese valor pues genera 20 puntos (T/Ts) entre 0 y T.

Las bases elegidas son ortogonales pero no ortonormales. Chequeadlo por favor.

En la función correlatorType no tenéis en cuenta el período de muestreo para hacer las integrales ni para normalizar las bases. Hay que tenerlo en cuenta para obtener resultados coherentes pues estamos representando o discretizando integrales.
No se calcula bien la integral y eso hace que los resultados a la salida de los correladores no sea correcto. ¿Qué coeficientes deberían salir para s1 y s2? ¿Cuáles os están saliendo?
Las salidas del correlador debería ser el valor de la integral en cada instante de muestreo, no un número multiplicado por la base. Por eso luego se pregunta cual es el instante óptimo de muestro de esa salida.

2.1.a) Explicáis las gráficas pero no justificáis por qué son lógicos o no los resultados. En vuestro caso como he explicado más arriba los resultados no son lógicos.
De nuevo al no haber ruido los coeficientes para s2 serán -1 y 1.....aunque ponéis este comentario, el resultado de los correladores es 1 y 0!!

2.1.b) El instante óptimo y la explicación no son correctas. ¿Cuál es el objetivo del banco de coreladores? ¿En que punto se consigue?


3. En este caso seguiremos con el mismo nivel de 5dB SNR para el ruido blanco que añadimos. Este se debe a
que es el mínimo SNR que se permite sin que haya errores de transmisión....¿por qué? ¿habéis probado con menos ruido? ¿habéis comprobado que con 5 dB no se comente ningún error?

Sería más visual si en lugar de subplot en los histogramas hubieseis pintado las salidas de los dos demoduladores para cada caso en una misma gráfica usando el comando hold on.
¿Qué pasa cuando el valor de SNR es muy bajo y se cruzan las colas de los histogramas?
¿Por qué los histogramas están centrados en 1 y 1 o 1 y -1?
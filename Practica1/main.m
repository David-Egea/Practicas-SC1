%% LABORATORIO 1: DEMODULACIÓN DIGITAL EN BANDA BASE

    % Sistemas de Comunicaciones I
    % David Cocero Quintanilla
    % David Egea Hernández
    % 15/09/2022
    
    fprintf("\n\n\n---------------------------------------------------------------------------\n");
    fprintf("\n     LABORATORIO 1: DEMODULACIÓN DIGITAL EN BANDA BASE\n");
    fprintf("\n     *    Sistemas de Comunicaciones I");
    fprintf("\n     *    15/09/2022");
    fprintf("\n     *    David Cocero Quintanilla");
    fprintf("\n     *    David Egea Hernández");
    fprintf("\n\n---------------------------------------------------------------------------");


%% 2. Demodulador de un símbolo - Ejercicio 2.1 

% a. Representación temporal del vector de salida de ambos correladores para 
% los dos posibles símbolos recibidos (i.e. s1 y s2). Es decir, los valores 
% de y_n (t) para n = 1,2. ¿Son los resultados lógicos?

T = 10;
Ts = T/20;

% Se genera el vector de tiempo
t = linspace(0,T,T/Ts);
% Primera señal
s1 = ones(1,length(t));
% Primera señal
s2 = [ones(1,length(t)/2) -ones(1,length(t)/2)];
phi1 = [ones(1,length(t)/2) zeros(1,length(t)/2)];
phi2 = [zeros(1,length(t)/2) ones(1,length(t)/2)];

% Llamada a la función de correlación
[y1_s1,y2_s1] = correlatorType(T,Ts,s1);
[y1_s2,y2_s2] = correlatorType(T,Ts,s2);
% Representación de las señales
figure;
subplot(3,1,1);
plot(t,s1,"b");
xlabel("t (ms)");   
ylim([-1 1])
title("señal de entrada s1(t)");
subplot(3,1,2);
plot(t,y1_s1*phi1,"r*-");
ylim([-1 1])
title(" y1(t) salida del correlador 1");
subplot(3,1,3);
plot(t,y2_s1*phi2,"g-o");
xlabel("t (ms)");
ylim([-1 1])
title("y2(t) salida del correlador 2 ");

figure;
subplot(3,1,1);
plot(t,s2);
xlabel("t (ms)");
ylim([-1 1])
title("señal de entrada s2(t)");
subplot(3,1,2);
plot(t,y1_s2*phi1,"r*-");
ylim([-1 1])
title(" y1(t) salida del correlador 1");
subplot(3,1,3);
plot(t,y2_s2*phi2,"g-o");
xlabel("t (ms)");
ylim([-1 1])
title("y2(t) salida del correlador 2 ");


%% 2. Demodulador de un símbolo - Ejercicio 2.2

clear; close all;

% Valores
T = 10;
Ts = T/20;

% Se genera el vector de tiempo
t = linspace(0,T,T/Ts);

% Simbolos s1 y s2
s1.o = ones(1,length(t));
s2.i = [ones(1,length(t)/2) -ones(1,length(t)/2)];

phi1 = [ones(1,length(t)/2) zeros(1,length(t)/2)];
phi2 = [zeros(1,length(t)/2) ones(1,length(t)/2)];

% Generamos el ruido blanco de distintas potencias
s1.snr_5dB = awgn(s1.o,5);
s2.snr_5dB = awgn(s2.i,5);
s1.snr_10dB = awgn(s1.o,10);
s2.snr_10dB = awgn(s2.i,10);
s1.snr_15dB = awgn(s1.o,15);
s2.snr_15dB = awgn(s2.i,15);

% Llamada a la función de correlación
[y1.s1.snr_5dB,y2.s1.snr_5dB] = correlatorType(T,Ts,s1.snr_5dB);
[y1.s2.snr_5dB,y2.s2.snr_5dB] = correlatorType(T,Ts,s2.snr_5dB);
[y1.s1.snr_10dB,y2.s1.snr_10dB] = correlatorType(T,Ts,s1.snr_10dB);
[y1.s2.snr_10dB,y2.s2.snr_10dB] = correlatorType(T,Ts,s2.snr_10dB);
[y1.s1.snr_15dB,y2.s1.snr_15dB] = correlatorType(T,Ts,s1.snr_15dB);
[y1.s2.snr_15dB,y2.s2.snr_15dB] = correlatorType(T,Ts,s2.snr_15dB);

% Comparación entre la señal con y sin ruido
figure;
% Simbolo s1
subplot(2,1,1);
plot(t,s1.o,"b");
hold on;
plot(t,s1.snr_5dB);
plot(t,s1.snr_10dB);
plot(t,s1.snr_15dB);
xlabel("t (ms)");   
title("Señal de s1 con y sin ruido");
legend(["original","SNR=5dB", "SNR=10dB", "SNR=15dB"],'Location','southeast');
% Simbolo s2
subplot(2,1,2);
plot(t,s2.i,"b");
hold on;
plot(t,s2.snr_5dB);
plot(t,s2.snr_10dB);
plot(t,s2.snr_15dB);
xlabel("t (ms)");   
title("Señal de s2 con y sin ruido");
legend(["original","SNR=5dB", "SNR=10dB", "SNR=15dB"],'Location','southeast');
sgtitle("Comparativa señales con y sin ruido");

% Representación de los resultados con ruido (para 5dB)
figure;
% Simbolo s1
subplot(3,2,1);
plot(t,s1.o);
hold on;
plot(t,s1.snr_5dB);
xlabel("t (ms)");   
ylim([-2 2]);
legend(["original","SNR=5dB"],'Location','southeast');
title("señal de entrada s1(t) con ruido (SNR=5dB)");
subplot(3,2,3);
plot(t,y1.s1.snr_5dB*phi1,"r*-");
ylim([-2 2])
title("y1(t) salida del correlador 1");
subplot(3,2,5);
plot(t,y2.s1.snr_5dB*phi2,"g-o");
xlabel("t (ms)");
ylim([-2 2])
title("y2(t) salida del correlador 2 ");
% Simbolo s2
subplot(3,2,2);
plot(t,s2.i,"b");
hold on;
plot(t,s2.snr_5dB);
xlabel("t (ms)");   
ylim([-2 2]);
legend(["original","SNR=5dB"],'Location','southeast');
title("señal de entrada s2(t) con ruido (SNR=5dB)");
subplot(3,2,4);
plot(t,y1.s2.snr_5dB*phi1,"r*-");
ylim([-2 2])
title("y1(t) salida del correlador 1");
subplot(3,2,6);
plot(t,y2.s2.snr_5dB*phi2,"g-o");
xlabel("t (ms)");
ylim([-2 2])
title("y2(t) salida del correlador 2 ");
sgtitle("Salidas demodulador (y1, y2) para señales s1 y s2");

%% 3. Salida del demodulador - Ejercicio 3.1

clear; close all;

% Parametros
T = 10;
Ts = T/20;
M = T/Ts; % Numero de muestras por simbolo
Nsymb = 10000;
SNR = 10;

% Se genera el vector de tiempo
t = linspace(0,T,T/Ts);

% Primera señal
s1 = ones(1,length(t));
s2 = [ones(1,length(t)/2) -ones(1,length(t)/2)];

% Generamos la señal r(t) de simbolos s1(t) y s2(t)
r.s1 = [];
r.s2 = [];
for i=1:Nsymb
    r.s1 = [r.s1 s1];
    r.s2 = [r.s2 s2];
end

% Añadir ruido blanco a la señal s1
r.s1_noise = awgn(r.s1,SNR);
% Añadir ruido blanco a la señal s2
r.s2_noise = awgn(r.s2,SNR);

% Llamada de forma iterativa a correlatorType
r1.s1 = [];
r2.s1 = [];
r1.s2 = [];
r2.s2 = [];
for i=1:Nsymb
    % Llamada a la función de correlación
    [y1_s1,y2_s1] = correlatorType(T,Ts,r.s1_noise((i-1)*M+1:i*M));
    r1.s1 = [r1.s1 y1_s1];
    r2.s1 = [r2.s1 y2_s1];
    % Llamada a la función de correlación
    [y1_s2,y2_s2] = correlatorType(T,Ts,r.s2_noise((i-1)*M+1:i*M));
    r1.s2 = [r1.s2 y1_s2];
    r2.s2 = [r2.s2 y2_s2];
end

% Histograma
figure;
subplot(2,2,1);
histogram(r1.s1);
title("Histograma r1");
xlabel("Valores r1 s1");
subplot(2,2,2);
histogram(r2.s1)
title("Histograma r2")
xlabel("Valores r2 s1")
subplot(2,2,3);
histogram(r1.s2);
title("Histograma r1");
xlabel("Valores r1 s2");
subplot(2,2,4);
histogram(r2.s2)
title("Histograma r2 s2")
xlabel("Valores r2")
sgtitle("Histogramas r(t)");

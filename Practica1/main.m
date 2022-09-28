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

clear; close all;

% a. Representación temporal del vector de salida de ambos correladores para 
% los dos posibles símbolos recibidos (i.e. s1 y s2). Es decir, los valores 
% de y_n (t) para n = 1,2. ¿Son los resultados lógicos?

T = 0.01;
Ts = T/20;

A = 1;
% Se genera el vector de tiempo
t = 0:Ts:T-Ts;

% Generamos las señales s1(t) y s2(t)
s1.o = ones(1,length(t));
s2.o = [ones(1,length(t)/2) -ones(1,length(t)/2)];

% Bases ortonormales phi1(t) y phi2(t)
phi1 = s1.o/(A*sqrt(T));
phi2 = s2.o/(A*sqrt(T));

% Llamada a la función de correlación
[y1_s1,y2_s1] = correlatorType(phi1,phi2,Ts,s1.o);
[y1_s2,y2_s2] = correlatorType(phi1,phi2,Ts,s2.o);

% Representación de las señales s1(t) y s2(t)
figure;
subplot(3,2,1);
plot(t,s1.o,'lineWidth',2);
grid minor;
xlabel("t (s)");   
xlim([0 T-Ts]);
ylim([0 1.1]);
title("señal de entrada s1(t)");
subplot(3,2,[3,5]);
plot(t,y1_s1,"r-o",'lineWidth',2);
hold on;
plot(t,y2_s1,"g-*",'lineWidth',2);
grid minor;
xlim([0 T-Ts]);
ylim([0 0.1]);
xlabel("t (s)");
title("Salida del demodulador");
legend("y1(t)","y2(t)",'location','northwest');
subplot(3,2,2);
plot(t,s2.o,'lineWidth',2);
grid minor;
xlabel("t (s)");
xlim([0 T-Ts]);
ylim([-1 1]);
title("señal de entrada s2(t)");
subplot(3,2,[4,6]);
plot(t,y1_s2,"r-o",'lineWidth',2);
hold on;
plot(t,y2_s2,"g-*",'lineWidth',2);
grid minor;
xlim([0 T-Ts]);
ylim([0 0.1]);
xlabel("t (s)");
title("Salida del demodulador");
legend("y1(t)","y2(t)",'location','northwest');
sgtitle("Demodulación de las señales s1(t) y s2(t)");

%% 2. Demodulador de un símbolo - Ejercicio 2.2

% Generamos el ruido blanco de distintas potencias
s1.snr_5dB = awgn(s1.o,5);
s2.snr_5dB = awgn(s2.o,5);
s1.snr_10dB = awgn(s1.o,10);
s2.snr_10dB = awgn(s2.o,10);
s1.snr_15dB = awgn(s1.o,15);
s2.snr_15dB = awgn(s2.o,15);

% Llamada a la función de correlación
[y1.s1.snr_5dB,y2.s1.snr_5dB] = correlatorType(phi1,phi2,Ts,s1.snr_5dB);
[y1.s2.snr_5dB,y2.s2.snr_5dB] = correlatorType(phi1,phi2,Ts,s2.snr_5dB);
[y1.s1.snr_10dB,y2.s1.snr_10dB] = correlatorType(phi1,phi2,Ts,s1.snr_10dB);
[y1.s2.snr_10dB,y2.s2.snr_10dB] = correlatorType(phi1,phi2,Ts,s2.snr_10dB);
[y1.s1.snr_15dB,y2.s1.snr_15dB] = correlatorType(phi1,phi2,Ts,s1.snr_15dB);
[y1.s2.snr_15dB,y2.s2.snr_15dB] = correlatorType(phi1,phi2,Ts,s2.snr_15dB);

% Comparación entre la señal con y sin ruido
figure;
% Simbolo s1
subplot(2,1,1);
plot(t,s1.o,'lineWidth',2);
hold on;
plot(t,s1.snr_5dB,'lineWidth',2);
plot(t,s1.snr_10dB,'lineWidth',2);
plot(t,s1.snr_15dB,'lineWidth',2);
grid minor;
xlim([0 T-Ts]);
xlabel("t (s)");   
title("Señal de s1 con y sin ruido");
legend(["original","SNR=5dB", "SNR=10dB", "SNR=15dB"],'Location','northeast');
subplot(2,1,2);
plot(t,s2.o,'lineWidth',2);
hold on;
plot(t,s2.snr_5dB,'lineWidth',2);
plot(t,s2.snr_10dB,'lineWidth',2);
plot(t,s2.snr_15dB,'lineWidth',2);
grid minor;
xlabel("t (s)");   
xlim([0 T-Ts]);
title("Señal de s2 con y sin ruido");
legend(["original","SNR=5dB", "SNR=10dB", "SNR=15dB"],'Location','northeast');
sgtitle("Comparativa señales con y sin ruido");

% Representación de la demodulación para una señal con SNR=5dB
figure;
subplot(3,2,1);
plot(t,s1.o,'lineWidth',2);
hold on;
plot(t,s1.snr_5dB,'lineWidth',2);
grid minor;
xlabel("t (s)");   
xlim([0 T-Ts]);
legend(["Sin ruido","SNR=5dB"],'Location','northeast');
title("Señal de entrada s1(t) con ruido (SNR=5dB)");
subplot(3,2,[3,5]);
plot(t,y1_s1,"r--",'lineWidth',1);
hold on;
plot(t,y1.s1.snr_5dB,"r-o",'lineWidth',2);
plot(t,y2_s1,"g--",'lineWidth',1);
plot(t,y2.s1.snr_5dB,"g-*",'lineWidth',2);
grid minor;
xlim([0 T-Ts]);
xlabel("t (s)");
title("Salida del demodulador para s1(t) con ruido");
legend("y1(t) Sin Ruido","y1(t) SNR=5dB","y2(t) Sin Ruido","y2(t) SNR=5dB",'location','northwest');
subplot(3,2,2);
plot(t,s2.o,'lineWidth',2);
hold on;
plot(t,s2.snr_5dB,'lineWidth',2);
grid minor;
xlabel("t (s)");
xlim([0 T-Ts]);
legend(["Sin ruido","SNR=5dB"],'Location','northeast');
title("Señal de entrada s2(t) con ruido (SNR=5dB)");
subplot(3,2,[4,6]);
plot(t,y1_s2,"r--",'lineWidth',1);
hold on;
plot(t,y1.s2.snr_5dB,"r-o",'lineWidth',2);
plot(t,y2_s2,"g--",'lineWidth',1);
plot(t,y2.s2.snr_5dB,"g-*",'lineWidth',2);
grid minor;
xlim([0 T-Ts]);
xlabel("t (s)");
title("Salida del demodulador para s2(t) con ruido");
legend("y1(t) Sin Ruido","y1(t) SNR=5dB","y2(t) Sin Ruido","y2(t) SNR=5dB",'location','northwest');
sgtitle("Demodulación de las señales s1(t) y s2(t) con ruido (SNR=5dB)");

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

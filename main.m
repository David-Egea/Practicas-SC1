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

%% 2. Demodulador de un símbolo

%% Ejercicio 2.1 

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
plot(t,s1);
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


%% Ejercicio 2.2

clear; close all;

% Valores
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

% Generamos el ruido blanco de distintas potencias
s1_noise_5dB = awgn(s1,5);
s2_noise_5dB = awgn(s1,5);


% Llamada a la función de correlación
[y1_s1_10,y2_s1_10] = correlatorType(T,Ts,s1_noise_5dB);
[y1_s2_10,y2_s2_10] = correlatorType(T,Ts,s2_noise_5dB);
% Comparación entre la señal con y sin ruido
figure;
plot(t,s1,"b");
hold on;
plot(t,s1_noise_5dB,"r");
xlabel("t (ms)");   
title("Comparativa señal con y sin ruido");
legend("s1(t)","s1_noise(t)(SNR=10dB)")

% Representación de los resultados con ruido
figure;
subplot(3,1,1);
plot(t,s1_noise_5dB);
xlabel("t (ms)");   
ylim([-2 2])
title("señal de entrada s1(t) con ruido");
subplot(3,1,2);
plot(t,y1_s1_10*phi1,"r*-");
ylim([-2 2])
title(" y1(t) salida del correlador 1");
subplot(3,1,3);
plot(t,y2_s1_10*phi2,"g-o");
xlabel("t (ms)");
ylim([-2 2])
title("y2(t) salida del correlador 2 ");
%%

%% LABORATORIO 3: MODULACIONES DIGITALES
fprintf("\n\n\n---------------------------------------------------------------------------\n");
fprintf("\n     LABORATORIO 3: MODULACIONES DIGITALES\n");
fprintf("\n     *    Sistemas de Comunicaciones I");
fprintf("\n     *    06/10/2022");
fprintf("\n     *    David Cocero Quintanilla");
fprintf("\n     *    David Egea Hernández");
fprintf("\n\n---------------------------------------------------------------------------\n");

%% 2. Modulación Digital por Desplazamiento de Fase

clear all; close all;

%% Ejercicio 2.1 : Modulación QPSK

% Secuencias binarias
txBits = [1 1 1 0 0 1 0 0];

% Modulación QPSK
s1 = moduladorQPSK(txBits);

% Representación de los símbolos modulados QPSK
scatterplot(s1);

%% Ejercicio 2.2 : Modulación QPSK con ruido

% Vector de bits aleatorios
N = 2000;
bitsrandom = randi([0,1],N,1);

% Modulación de los símbolos
srand = moduladorQPSK(bitsrandom);

% Se añade ruido blanco gaussiano de distintos niveles de potencia 
s_SNR_5 = awgn(srand,5); % 5dB
s_SNR_10 = awgn(srand,10); % 10dB
s_SNR_15 = awgn(srand,15); % 15 dB

% Representación de los símbolos modulados QPSK
scatterplot(s_SNR_5);
title("Modulación QPSK SNR 5dB");
scatterplot(s_SNR_10);
title("Modulación QPSK SNR 10dB");
scatterplot(s_SNR_15);
title("Modulación QPSK SNR 15dB");

%% Ejercicio 2.3: cadena de modulación-demodulación QPSK y DQPSK

close all;

% Demodulación QPSK de los distintos símbolos QPSK (sin ruido)
rxBits = demoduladorQPSK(s1);

[number, ber] = biterr(txBits,rxBits);
disp("BER QPSK: " + num2str(ber));

% Demodulación
s1_dqpsk = moduladorDQPSK(txBits);
rxBits = demoduladorDQPSK(s1_dqpsk);

[number, ber] = biterr(txBits,rxBits);
disp("BER DQPSK: " + num2str(ber));

%% Ejercicio 2.4:curvas de BER frente a EbN0_dB para QPSK y DQPSK

M = 4; % Alfabeto de 4 símbolos de 2 bits cada uno
EbN0_dB = -5:2:10; % Niveles de ruido
k = log2(M); % Número de bits por símbolo

Nsimb = 20000; % Número de símbolos

BERSim = zeros(1,length(EbN0_dB));

% Generamos el vector de símbolos
txBits = randi([0,1],1,Nsimb*k);

% ----- QPSK -------

% Modulate symbols
s_t = moduladorQPSK(txBits);

for iter_EbN0_dB = 1:length(EbN0_dB)

    % SNR
    SNR_dB = EbN0_dB(iter_EbN0_dB) + 10*log10(k); 

    % ---- Canal ----
    r_t = awgn(s_t,SNR_dB,'measured'); % Añadir ruido blanco

    % ---- Recepción ----
    rxBits = demoduladorQPSK(r_t);

    [number,BERSim(iter_EbN0_dB)] = biterr(txBits,rxBits);
end
 
% En QPSK la probabilidad teórica
BERTheo = qfunc(sqrt(2*10.^(EbN0_dB/10)));
BERTheo(BERTheo<1e-5) = NaN;

% Representacion BER
figure;
semilogy(EbN0_dB,BERTheo,'-*', "lineWidth",2);
hold on;
semilogy(EbN0_dB,BERSim,"-o", "lineWidth",2);
xlabel('SNR [dB]');
ylabel('BER');
grid minor;
title("Comparación BER Teórica y Simulada QPSK");
legend('Teorica','Simulada');

% ----- DQPSK -------

s_t = moduladorDQPSK(txBits);
for iter_EbN0_dB = 1:length(EbN0_dB)

    % SNR
    SNR_dB = EbN0_dB(iter_EbN0_dB) + 10*log10(k); 

    % ---- Canal ----
    r_t = awgn(s_t,SNR_dB,'measured'); % Añadir ruido

    % ---- Recepción ----
    rxBits = demoduladorDQPSK(r_t);

    [number,BERSim(iter_EbN0_dB)] = biterr(txBits,rxBits) ;
end
 
% En QPSK la probabilidad teórica
BERTheo = 1.13*qfunc(sqrt(1.2*10.^(EbN0_dB/10)));
BERTheo(BERTheo<1e-5) = NaN;

% Representacion BER
figure;
semilogy(EbN0_dB,BERTheo,'-*', "lineWidth",2);
hold on;
semilogy(EbN0_dB,BERSim,"-o", "lineWidth",2);
xlabel('SNR [dB]');
ylabel('BER');
grid minor;
title("Comparación BER Teórica y Simulada DQPSK");
legend('Teorica','Simulada');

%% Ejercicio 2.5: influencia de la rotación de la fase o error de fase en recepción

% Cambio de fase
% ----- QPSK -------

% Modulate symbols
s_t = moduladorQPSK(txBits);

for iter_EbN0_dB = 1:length(EbN0_dB)

    % SNR
    SNR_dB = EbN0_dB(iter_EbN0_dB) + 10*log10(k); 

    % ---- Canal ----
    r_t = awgn(s_t,SNR_dB,'measured'); % Añadir ruido blanco

    % ---- Recepción ----
    rxBits = demoduladorQPSK(r_t);

    [number,BERSim(iter_EbN0_dB)] = biterr(txBits,rxBits);
end
 
% En QPSK la probabilidad teórica
BERTheo = qfunc(sqrt(2*10.^(EbN0_dB/10)));
BERTheo(BERTheo<1e-5) = NaN;

% Representacion BER
figure;
semilogy(EbN0_dB,BERTheo,'-*', "lineWidth",2);
hold on;
semilogy(EbN0_dB,BERSim,"-o", "lineWidth",2);
xlabel('SNR [dB]');
ylabel('BER');
grid minor;
title("Comparación BER Teórica y Simulada QPSK");
legend('Teorica','Simulada');

% ----- DQPSK -------

s_t = moduladorDQPSK(txBits);
for iter_EbN0_dB = 1:length(EbN0_dB)

    % SNR
    SNR_dB = EbN0_dB(iter_EbN0_dB) + 10*log10(k); 

    % ---- Canal ----
    r_t = awgn(s_t,SNR_dB,'measured'); % Añadir ruido

    % ---- Recepción ----
    rxBits = demoduladorDQPSK(r_t);

    [number,BERSim(iter_EbN0_dB)] = biterr(txBits,rxBits) ;
end
 
% En QPSK la probabilidad teórica
BERTheo = 1.13*qfunc(sqrt(1.2*10.^(EbN0_dB/10)));
BERTheo(BERTheo<1e-5) = NaN;

% Representacion BER
figure;
semilogy(EbN0_dB,BERTheo,'-*', "lineWidth",2);
hold on;
semilogy(EbN0_dB,BERSim,"-o", "lineWidth",2);
xlabel('SNR [dB]');
ylabel('BER');
grid minor;
title("Comparación BER Teórica y Simulada DQPSK");
legend('Teorica','Simulada');


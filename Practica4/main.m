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
title("Modulación QPSK Ideal");

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

[~, ber] = biterr(txBits,rxBits);
disp("Secuencia de bits enviados: "+ num2str(txBits))
disp("Secuencia de bits recibidos: "+ num2str(rxBits))
disp("BER QPSK: " + num2str(ber));

% Demodulación
s1_dqpsk = moduladorDQPSK(txBits);
rxBits = demoduladorDQPSK(s1_dqpsk);

[~, ber] = biterr(txBits,rxBits);
disp("Secuencia de bits enviados: "+ num2str(txBits))
disp("Secuencia de bits recibidos: "+ num2str(rxBits))
disp("BER DQPSK: " + num2str(ber));

%% Ejercicio 2.4:curvas de BER frente a EbN0_dB para QPSK y DQPSK

M = 4; % Alfabeto de 4 símbolos de 2 bits cada uno
EbN0_dB = -5:2:12; % Niveles de ruido
k = log2(M); % Número de bits por símbolo

Nsimb = 20000; % Número de símbolos

BERSimQPSK = zeros(1,length(EbN0_dB));

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

    [~,BERSimQPSK(iter_EbN0_dB)] = biterr(txBits,rxBits);
end
 
% En QPSK la probabilidad teórica
BERTheoQPSK = qfunc(sqrt(2*10.^(EbN0_dB/10)));
BERTheoQPSK(BERTheoQPSK<1e-5) = NaN;

% Representacion BER
figure;
semilogy(EbN0_dB,BERTheoQPSK,'-*', "lineWidth",2);
hold on;
semilogy(EbN0_dB,BERSimQPSK,"-o", "lineWidth",2);
xlabel('SNR [dB]');
ylabel('BER');
grid minor;
title("Comparación BER Teórica y Simulada QPSK");
legend('Teorica','Simulada');

% ----- DQPSK -------
BERSimDQPSK = zeros(1,length(EbN0_dB));

s_t = moduladorDQPSK(txBits);
for iter_EbN0_dB = 1:length(EbN0_dB)

    % SNR
    SNR_dB = EbN0_dB(iter_EbN0_dB) + 10*log10(k); 

    % ---- Canal ----
    r_t = awgn(s_t,SNR_dB,'measured'); % Añadir ruido

    % ---- Recepción ----
    rxBits = demoduladorDQPSK(r_t);

    [~,BERSimDQPSK(iter_EbN0_dB)] = biterr(txBits,rxBits) ;
end
 
% En QPSK la probabilidad teórica
BERTheoDQPSK = 1.13*qfunc(sqrt(1.2*10.^(EbN0_dB/10)));
BERTheoDQPSK(BERTheoDQPSK<1e-5) = NaN;

% Representacion BER
figure;
semilogy(EbN0_dB,BERTheoDQPSK,'-*', "lineWidth",2);
hold on;
semilogy(EbN0_dB,BERSimDQPSK,"-o", "lineWidth",2);
xlabel('SNR [dB]');
ylabel('BER');
grid minor;
title("Comparación BER Teórica y Simulada DQPSK");
legend('Teorica','Simulada');

% Comparacion QPSK y DQPSK
% ---------------------------
figure;
semilogy(EbN0_dB,BERTheoQPSK,'-*', "lineWidth",2);
hold on;
semilogy(EbN0_dB,BERSimQPSK,"-o", "lineWidth",2);
semilogy(EbN0_dB,BERTheoDQPSK,'-*', "lineWidth",2);
semilogy(EbN0_dB,BERSimDQPSK,"-o", "lineWidth",2);
xlabel('SNR [dB]');
ylabel('BER');
grid minor;
title("Comparación BER Teórica y Simulada para QPSK y DQPSK");
legend('QPSK Teo.','QPSK Sim.','DQPSK Teo.','DQPSK Sim.');

%% Ejercicio 2.5: influencia de la rotación de la fase o error de fase en recepción

% ----- QPSK -------
% Calcular la BER para QPSK con un error de fase de 10º
[BERSimQPSKerr10,BERTheoQPSK] = calculateBER_QPSK_fase(txBits,10);

% Calcular la BER para QPSK con error de fase de 20º
[BERSimQPSKerr20,~] = calculateBER_QPSK_fase(txBits,20);

% Calcular la BER para QPSK con error de fase de 30º
[BERSimQPSKerr30,~] = calculateBER_QPSK_fase(txBits,30);

% Representacion BER
figure;
semilogy(EbN0_dB,BERTheoQPSK,'-o', "lineWidth",2);
hold on;
semilogy(EbN0_dB,BERSimQPSKerr10,"-*", "lineWidth",2);
semilogy(EbN0_dB,BERSimQPSKerr20,"-*", "lineWidth",2);
semilogy(EbN0_dB,BERSimQPSKerr30,"-*", "lineWidth",2);
xlabel('SNR [dB]');
ylabel('BER');
grid minor;
title("Comparación BER QPSK para distintos cambios de fase");
legend('QPSK Teo.','QPSK Sim. err. 10º','QPSK Sim. err. 20º','QPSK Sim. err. 30º');

% ----- DQPSK -------
% Calcular la BER para DQPSK con un error de fase de 10º
[BERSimDQPSKerr10,BERTheoDQPSK] = calculateBER_DQPSK_fase(txBits,10);

% Calcular la BER para DQPSK con error de fase de 20º
[BERSimDQPSKerr20,~] = calculateBER_DQPSK_fase(txBits,20);

% Calcular la BER para DQPSK con error de fase de 30º
[BERSimDQPSKerr30,~] = calculateBER_DQPSK_fase(txBits,30);

% Representacion BER
figure;
semilogy(EbN0_dB,BERTheoDQPSK,'-o', "lineWidth",2);
hold on;
semilogy(EbN0_dB,BERSimDQPSKerr10,"-*", "lineWidth",2);
semilogy(EbN0_dB,BERSimDQPSKerr20,"-*", "lineWidth",2);
semilogy(EbN0_dB,BERSimDQPSKerr30,"-*", "lineWidth",2);
xlabel('SNR [dB]');
ylabel('BER');
grid minor;
title("Comparación BER DQPSK para distintos cambios de fase");
legend('DQPSK Teo.','DQPSK Sim. err. 10º','DQPSK Sim. err. 20º','DQPSK Sim. err. 30º');

%% 3.	Modulación Digital en Amplitud y Cuadratura, n-QAM y Amplitude Phase Shift Keying, APSK
% Ejercicio 3.1: : curvas de BER frente a EbNo_dB para QAM y APSK

% ------------------- n-QAM -------------------
[BERSim4QAM,BERTheo4QAM] = BER_m_ary_QAM(4,EbN0_dB); % 4-QAM
[BERSim16QAM,BERTheo16QAM] = BER_m_ary_QAM(16,EbN0_dB); % 16-QAM
[BERSim64QAM,BERTheo64QAM] = BER_m_ary_QAM(64,EbN0_dB); % 64-QAM
[BERSim256QAM,BERTheo256QAM] = BER_m_ary_QAM(256,EbN0_dB); % 256-QAM

figure;
subplot(2,2,1);
semilogy(EbN0_dB,BERTheo4QAM,"-o", "lineWidth",2);
hold on;
semilogy(EbN0_dB,BERSim4QAM,"-*", "lineWidth",2);
xlabel('SNR [dB]');
ylabel('BER');
grid minor;
title('Comparación BER 4-QAM');
legend("BER Teo. 4-QAM","BER Sim. 4-QAM");
subplot(2,2,2);
semilogy(EbN0_dB,BERTheo16QAM,"-o", "lineWidth",2);
hold on;
semilogy(EbN0_dB,BERSim16QAM,"-*", "lineWidth",2);
xlabel('SNR [dB]');
ylabel('BER');
grid minor;
title('Comparación BER 16-QAM');
legend("BER Teo. 16-QAM","BER Sim. 16-QAM");
subplot(2,2,3);
semilogy(EbN0_dB,BERTheo64QAM,"-o", "lineWidth",2);
hold on;
semilogy(EbN0_dB,BERSim64QAM,"-*", "lineWidth",2);
xlabel('SNR [dB]');
ylabel('BER');
grid minor;
title('Comparación BER 64-QAM');
legend("BER Teo. 64-QAM","BER Sim. 64-QAM");
subplot(2,2,4);
semilogy(EbN0_dB,BERTheo256QAM,"-o", "lineWidth",2);
hold on;
semilogy(EbN0_dB,BERSim256QAM,"-*", "lineWidth",2);
xlabel('SNR [dB]');
ylabel('BER');
grid minor;
title('Comparación BER 256-QAM');
legend("BER Teo. 256-QAM","BER Sim. 256-QAM");
sgtitle('Comparación BER para n-QAM');

% ------------------- n-APSK -------------------
% ----- 16-APSK -------
M = [4 12];
R = [1 2.5];
[BER16APSK] = BER_APSK(M,R,EbN0_dB);

% ----- 32-APSK -------
M = [4 12 16];
R = [1 2.5 4.3];
[BER32APSK] = BER_APSK(M,R,EbN0_dB);

figure;
semilogy(EbN0_dB,BER16APSK,"-o", "lineWidth",2);
hold on;
semilogy(EbN0_dB,BER32APSK,"-*", "lineWidth",2);
xlabel('SNR [dB]');
ylabel('BER');
grid minor;
title("Comparación BER para n-APSK");
legend("BER Sim. 16-APSK","BER Sim. 32-APSK");

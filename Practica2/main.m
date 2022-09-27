%% LABORATORIO 2: DEMODULACIÓN DIGITAL EN BANDA BASE

    fprintf("\n\n\n---------------------------------------------------------------------------\n");
    fprintf("\n     LABORATORIO 2: DEMODULACIÓN DIGITAL EN BANDA BASE\n");
    fprintf("\n     *    Sistemas de Comunicaciones I");
    fprintf("\n     *    22/09/2022");
    fprintf("\n     *    David Cocero Quintanilla");
    fprintf("\n     *    David Egea Hernández");
    fprintf("\n\n---------------------------------------------------------------------------\n");

%% 2. Modulador

clear all; close all;

% Parametros
T = 0.01; % Periodo de un simbolo en ms
Ts = T/20; % Tiempo de muestreo
M = T/Ts; % Numero de muestras por simbolo

% Funciones s1(t) y s2(t) usadas en la práctica anterior
A = 1; % Amplitud
s1 = A*ones(1,M); % Señal s1(t)
s2 = A*[ones(1,M/2) -ones(1,M/2)]; % Señal s2(t)
s3 = -A*ones(1,M); % Señal s3(t)
s4 = A*[-ones(1,M/2) ones(1,M/2)]; % Señal s4(t)

% Se definen las funciones base ortonormales phi1(t) y phi2(t)
phi1 = s1/(A*sqrt(T));
phi2 = s2/(A*sqrt(T));

% Los coeficientes cij de las bases asociados a los símbolos si. Un símbolo
% si se puede expresar como la combinación lineal tal que
%   si(t) = ci1 * phi1(t) + ci2 * phi2(t)

c1 = coefs(s1,phi1,phi2,Ts); % Coeficientes de s1
c2 = coefs(s2,phi1,phi2,Ts); % Coeficientes de s2
c3 = coefs(s3,phi1,phi2,Ts); % Coeficientes de s3
c4 = coefs(s4,phi1,phi2,Ts); % Coeficientes de s4

% - Ejercicio 2.1 - 

% Modulamos una señal de N simbolos
N = 10; % Numero de simbolos

% Generamos un vector aleatorio de los códigos de los simbolos [1,4]
r = randi([0,1],1,2*N);
s = modulador(r,T,Ts,A); 

% Generamos un vector de tiempos para la nueva señal
t = [0:Ts:T*N-Ts];

% Representación de la señal generada
figure;
plot(t,s,'Linewidth',2);
ylim([-1.1 1.1]);
xlabel("t(s)");
title('Representación simbolos concatenados');
subtitle("Vector de símbolos: " + strjoin(string(r)));
grid on;

%% 3. Demodulador

% - Ejercicio 3.1 - 
 
% Demodulación para obtener los coeficientes
[y1, y2] = demodulador(s, T, Ts, A);
n=1:N;
figure;
subplot(2,1,1)
stem(n,y1,'Linewidth',2);
ylim([-0.12 0.12]);
xlabel("t(s)");
title('Salida y1');
subplot(2,1,2);
stem(n,y2,'Linewidth',2);
ylim([-0.12 0.12]);
xlabel("t(s)");
title('Salida y2');
sgtitle('Representación salida demoduladores');
grid on;

%% 4. Detector

% - Ejercicio 4.1 - 

s_hat = detector(y1,y2,T,Ts,A);
t_hat = 0:N*Ts:N*(T-Ts);

figure;
stem(t_hat,s_hat,'Linewidth',2);
ylim([-1.1 1.1]);
xlabel("t(s)");
title('Representación salida detector');
subtitle("Vector de símbolos original: " + strjoin(string(s_hat)));
grid on;

%% 5. Probabilidad de Error

clear; close all, format compact;

T = 0.01; % Periodo de un simbolo en s
Ts = T/20; % Tiempo de muestreo
A = 1; % Amplitud máxima 
M = 4; % 4-symbol alphabet
EsN0_dB = 0:2:20; % Vector to simulate
esn0_lin = 10.^(EsN0_dB/10); 
ebn0_lin = esn0_lin/log2(M);
EbN0_dB = 10*log10(ebn0_lin);
Nsymb = 10000; % Number of symbols
numErr = zeros(1,length(EsN0_dB)); % Pre-allocation
 
% Compute Pe for every SNR value
% ---- Tx ----
% Generate Nsymb random equiprobable symbols
s = randi([0,1],1,2*Nsymb);
% Modulate symbols
  s_t = modulador(s,T,Ts,A);

for iter_EsN0= 1:length(EsN0_dB)
    
    % ---- Channel ----
    % Compute symbols' power
     SNR_awgn_dB=EsN0_dB(iter_EsN0)-10*log10(0.5*T/Ts); % Compute corresponding SNR for the signal
        r_t = awgn(s_t,SNR_awgn_dB,'measured'); % Add noise
 
    
    % ---- Rx ----
    [y1,y2] = demodulador(r_t,T,Ts,A);  % Or correlationType
    
    s_hat = detector(y1,y2,T,Ts,A); % Decided symbols
    
    % Compute number of wrong symbols comparing s_hat with s
    
   numErr(iter_EsN0) = biterr(s,s_hat) ;
    
end
% Compute Error Probability
Pe = numErr/Nsymb;
 
% Plot performance
 
% Show simulated performance
figure
semilogy(EbN0_dB,Pe,'o-')
grid on
xlabel('SNR [dB]')
ylabel('P_e')
 
% Compute theoretical performance
PeTheo = 2*qfunc(sqrt(2*log2(M)*ebn0_lin)*sin(pi/M));
PeTheo(find(PeTheo<1e-7))=NaN;
BERTheo=PeTheo/log2(M);
BERtheo(find(BERTheo<1e-5))=NaN;
 
hold on 
semilogy(EbN0_dB,PeTheo,'x-')
semilogy(EbN0_dB,BERTheo)
legend('Simulada','Teorica','BER')


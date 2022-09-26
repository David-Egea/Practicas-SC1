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
T = 10; % Periodo de un simbolo en ms
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

[c11, c12] = coefs(s1,phi1,phi2); % Coeficientes de s1
[c11, c12] = coefs(s2,phi1,phi2);
[c11, c12] = coefs(s3,phi1,phi2);
[c11, c12] = coefs(s4,phi1,phi2);

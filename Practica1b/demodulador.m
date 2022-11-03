function [y1,y2] = demodulador(r, T, Ts, A)
% Recibe:
%   * r: Vector de muestras temporales de N símbolos
%   * T: Tiempo de símbolo
%   * Ts: Periodo de muestreo
% Devuelve:
%   * y1: Vector de coeficientes asociados a la phi1 
%   * y2: Vector de coeficientes asociados a la phi2

M = T/Ts; % Número de simbolos

% Funciones s1(t) y s2(t) usadas en la práctica anterior
s1 = A*ones(1,M); % Señal s1(t)
s2 = A*[ones(1,M/2) -ones(1,M/2)]; % Señal s2(t)
s3 = -A*ones(1,M); % Señal s3(t)
s4 = A*[-ones(1,M/2) ones(1,M/2)]; % Señal s4(t)

% Se definen las funciones base ortonormales phi1(t) y phi2(t)
phi1 = s1/(A*sqrt(T));
phi2 = s2/(A*sqrt(T));

% Calcular la longitud del vector de simbolos
N = length(r)/(T/Ts);

y1 = [];
y2 = [];
for i=0:N-1
    % LLamada a la funcion correlatorType para obtener los coeficientes
    [y1_s,y2_s] = correlatorType(phi1,phi2,Ts,r(i*M+1:(i+1)*M));
    y1 = [y1 y1_s(M)];
    y2 = [y2 y2_s(M)];
end
end
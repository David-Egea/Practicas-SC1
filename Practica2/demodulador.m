function [y1,y2] = demodulador(r,phi1,phi2)
% Recibe:
%   * r: Señal de entrada
%   * phi1: primera señal base ortonormal 
%   * phi2: segunda señal base ortonormal
% Devuelve los coeficientes salida y1 y y2 de las bases phi1 y phi2
%   * y1: Coeficientes asociados a la phi1
%   * y2: Coeficientes asociados a la phi2

% Se asumen los siguientes parámetros
T = 10; % 10 ms
Ts = T/20; 
M = T/Ts; % Numero de simbolos

% Calcular la longitud del vector de simbolos
N = length(r)/(T/Ts);

y1 = [];
y2 = [];
for i=1:N
    % Llamada a la función de correlación
    y1 = [y1 sum(r((i-1)*M+1:(i*M)).*phi1)/2];
    y2 = [y2 sum(r((i-1)*M+1:(i*M)).*phi2)/2];
end

end


function [y1,y2] = demodulador(r)
% Recibe:
%   * r: Señal de entrada
% Devuelve los coeficientes salida y1 y y2 de las bases phi1 y phi2
%   * y1: Coeficientes asociados a la phi1
%   * y2: Coeficientes asociados a la phi2

% Se asumen los siguientes parámetros
T = 10; % 10 ms
Ts = T/20; 
M = T/Ts; % Numero de simbolos


% Funciones s1(t) y s2(t) usadas en la práctica anterior
A = 1; % Amplitud
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
for i=1:N
    % Llamada a la función de correlación
    y1 = [y1 sum(r((i-1)*M+1:(i*M)).*phi1)/2];
    y2 = [y2 sum(r((i-1)*M+1:(i*M)).*phi2)/2];
end

end


function [s] = modulador(r, T, Ts, A)
% Recibe:
%   * r: Array de códigos de símbolos
%   * T: Período
%   * Ts: Tiempo de muestreo
%   * A: Amplitud máxima de las señales de salida
% Devuelve:
%   * s: Señal de salida de símbolos concatenados

M = T/Ts; % Numero de muestras por símbolo

%Se definen los 4 posibles simbolos
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

% Inicializacion de la señal de salida
s = [];

N=length(r);
for i=1:2:N
if r(i)==0 && r(i+1)==0
   s=[s c1(1)* phi1+ c1(2)* phi2];
elseif r(i)==0 && r(i+1)==1
   s=[s c2(1)* phi1+ c2(2)* phi2];
elseif r(i)==1 && r(i+1)==0
   s=[s c3(1)* phi1+ c3(2)* phi2];  
else
   s=[s c4(1)* phi1+ c4(2)* phi2] ;  
end   
end    

end
function [s,r] = modulador(c1,c2,c3,c4,N,phi1,phi2)
% Recibe:
%   * cn: Coeficiente del simbolo n de las bases
%   * N: numero de simbolos
%   * phi1: primera señal base ortonormal 
%   * phi2: segunda señal base ortonormal
% Devuelve los coeficientes c1 y c2 de las bases b1 y b2 asociadas al simbolo s
%   * s: Señal de salida

% Se asumen los siguientes parámetros
T = 10; % 10 ms
Ts = T/20; 
A = 1;

% Generamos un vector aleatorio de los códigos de los simbolos [1,4]
r = randi([1,4],1,N);

% Inicializacion de la señal de salida
s = [];

for i=1:N
if r(i)==1
   s=[s c1(1)* phi1+ c1(2)* phi2];
elseif r(i)==2
   s=[s c2(1)* phi1+ c2(2)* phi2];
elseif r(i)==3
   s=[s c3(1)* phi1+ c3(2)* phi2];  
else
   s=[s c4(1)* phi1+ c4(2)* phi2] ;  
end   
end    

end
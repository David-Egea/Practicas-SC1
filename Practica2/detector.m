function s_hat = detector(y1,y2)
% Recibe:
%   * y1: Coeficientes asociados a la phi1
%   * y2: Coeficientes asociados a la phi2
% Devuelve los coeficientes salida y1 y y2 de las bases phi1 y phi2
%   * s_hat: Coeficientes asociados a la phi1


T = 10; % Periodo de un simbolo en ms
Ts = T/20; % Tiempo de muestreo
M = T/Ts; % Numero de muestras por simbolo

A=1;

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

c1 = coefs(s1,phi1,phi2); % Coeficientes de s1
c2 = coefs(s2,phi1,phi2); % Coeficientes de s2
c3 = coefs(s3,phi1,phi2); % Coeficientes de s3
c4 = coefs(s4,phi1,phi2); % Coeficientes de s4
% Calculamos el numero de simbolos
N=length(y1);

s_hat=[];
for i=1:N
  distancias= [norm(c1-[y1(i) y2(i)]) norm(c2-[y1(i) y2(i)]) norm(c3-[y1(i) y2(i)]) norm(c4-[y1(i) y2(i)])];
  [M,I]= min(distancias);
  if I==1
   s=[0 0];
elseif I==2
   s=[0 1];
elseif I==3
   s=[1 0];  
else
   s=[1 1];  
end   
   s_hat=[s_hat s];
end
end
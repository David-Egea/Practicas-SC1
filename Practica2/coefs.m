function c = coefs(s,phi1,phi2)
% Recibe:
%   * s: simbolo de entrada
%   * phi1: primera señal base ortonormal 
%   * phi2: segunda señal base ortonormal
% Devuelve los coeficientes c1 y c2 de las bases b1 y b2 asociadas al simbolo s
%   * c: Coeficientes

c1 = sum(s.*b1)/2;
c2 = sum(s.*b2)/2;

end


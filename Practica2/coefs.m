function [c1,c2] = coefs(s,b1,b2)
% Recibe:
%   * s: simbolo de entrada
%   * b1: primera señal base ortonormal 
%   * b2: segunda señal base ortonormal
% Devuelve los coeficientes c1 y c2 de las bases b1 y b2 asociadas al simbolo s
%   * c1: Coeficiente asociado a b1
%   * c2: Coeficiente asociado a b2

c1 = sum(s.*b1)/2;
c2 = sum(s.*b2)/2;

end


function s_hat = detector(y1,y2)
% Recibe:
%   * y1: Coeficientes asociados a la phi1
%   * y2: Coeficientes asociados a la phi2
% Devuelve los coeficientes salida y1 y y2 de las bases phi1 y phi2
%   * s_hat: Coeficientes asociados a la phi1

% Calculamos el numero de simbolos
N=length(y1)

% Declaramos los coeficientes de los simbolos

c1 = coefs(s1,phi1,phi2); % Coeficientes de s1
c2 = coefs(s2,phi1,phi2); % Coeficientes de s2
c3 = coefs(s3,phi1,phi2); % Coeficientes de s3
c4 = coefs(s4,phi1,phi2); % Coeficientes de s4
for i=1:N
    if(norm(c1,y1))


end
end
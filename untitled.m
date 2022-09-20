% Longitud de un simbolo
L = T/Ts;
% Número de periodos de la señal
N = length(r)/L;
% Vector de coeficientes de s1
y1 = zeros(1,N);
% Vector de coeficientes de s2
y2 = zeros(1,N);

% Para cada bloque
for i=0:N-1
    % Multiplicacion de la función por el símbolo s1
    p1 = r(((i*L)+1):((i+1)*L)).*s1n;
    % Multiplicacion de la función por el símbolo s2
    p2 = r(((i*L)+1):((i+1)*L)).*s2n;
    % Integral del producto p1
    y1(i+1) = sum(p1);
    % Integral del producto p2
    y2(i+1) = sum(p2);
end
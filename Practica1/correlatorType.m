function [y1,y2] = correlatorType(T,Ts,r)
% Recibe:
%   * T: Tiempo de símbolo
%   * Ts: Periodo de muestreo
%   * r: señal recibida
% Devuelve las señales s1 y s2 correspondientes a la salida de los dos correladores
% por los que estaría compuesto el demodulador.

% Se genera el vector de tiempo
t = 0:Ts:T;
% Primera señal
phi1 = [ones(1,length(t)/2) zeros(1,length(t)/2)];
a1 = 1/sum(phi1.^2);
phi1n=a1*phi1;
phi2 = [zeros(1,length(t)/2) ones(1,length(t)/2)];
a2 = 1/sum(phi2.^2);
phi2n=a2*phi2;
y1=sum(r.*phi1n);
y2=sum(r.*phi2n);
end

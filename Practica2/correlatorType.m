function [y1,y2] = correlatorType(phi1,phi2,Ts,r)
    % Recibe:
    %   * Ts: Periodo de muestreo
    %   * r: señal recibida
    %   * phi1: primera base ortonormal
    %   * phi2: segunda base ortonormal
    % Devuelve las señales s1 y s2 correspondientes a la salida de los dos correladores
    % por los que estaría compuesto el demodulador.

    y1=[];
    y2=[];
    for i=1:length(phi1)
        y1=[y1 sum(r(1:i).*phi1(1:i))*Ts];
        y2=[y2 sum(r(1:i).*phi2(1:i))*Ts];
    end
end

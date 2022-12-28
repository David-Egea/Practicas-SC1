function Y_eq = equalizer(SimbRef,Y)
    % Función que implementa un ecualizador de tipo zero forcing. Recibe:
        % SimbRef: Señal transmitida en el dominio de la frecuencia
        % Y: Señal recibida en el dominio de la frecuencia
    % Devuelve la señal recibida ecualizada
    
%     % Obtener la función de transferencia del canal
%     H = Y(:,1)./SimbRef(:,1);
%     % Calcular la función de transferencia invertida
%     H_inv = 1./H;
%     % Para cada símbolo de la señal recibida
%     for i=1:width(Y)
%         % Convolucionar el símbolo con la función de transferencia inversa
%         Y_eq(:,i) = Y(:,i).*H_inv;
%     end
    % Para cada símbolo de la señal recibida
    for i=1:width(Y)
        % Obtener la función de transferencia del canal
        H = Y(:,1)./SimbRef(:,1);
        % Calcular la función de transferencia invertida
        H_inv = 1./H;
        % Convolucionar el símbolo con la función de transferencia inversa
        Y_eq(:,i) = Y(:,i).*H_inv;
    end
end


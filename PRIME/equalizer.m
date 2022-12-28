function Y_eq = equalizer(X,Y,h)
    % Función que implementa un ecualizador de tipo zero forcing. Recibe:
        % X: Señal transmitida en el dominio de la frecuencia
        % Y: Señal recibida en el dominio de la frecuencia
    % Devuelve la señal recibida ecualizada
    
    NFFT = 512;
    H = fft(h,NFFT);
    H_inv = 1./H;
    % Para cada símbolo de la señal recibida
    for i=1:width(Y)
        % Convolucionar el símbolo con la función de transferencia inversa
        Y_eq(:,i) = Y(:,i).*H_inv';
    end
%     % Obtener la función de transferencia del canal
%     H = Y(:,1)./X(:,1);
%     % Calcular la función de transferencia invertida
%     H_inv = 1./H;
%     % Para cada símbolo de la señal recibida
%     for i=1:width(Y)
%         % Convolucionar el símbolo con la función de transferencia inversa
%         Y_eq(:,i) = Y(:,i).*H_inv;
%     end
end


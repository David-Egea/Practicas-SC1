function simBER = simulateDNPSK_BER(SNR_dB,N,NFFT,Nofdm,N_pay,nBits,h)
    % Función del bloque scrambler. Recibe:
        % SNR_dB: Vector de valores de SNR
        % N: Niveles de modulación 
        % NFFT: Número de muestras de la NFFT
        % Nofdm: Número de símbolos OFDM
        % N_pay: Numero de portadoras OFDM
        % nBits: Número de bits a simular
        % h: Filtro h[n] (si es [] no hay filtro) 
    % Devuelve:
        % simBer: Vector de BER simulada
        
    % Generacion de los bits
    txBits = round(rand(1,nBits));
    % Aleatorización
    randomizedBits = scrambler(txBits);
    % Modulacion
    x = modDNPSK(randomizedBits,N,NFFT,Nofdm);
    % Inicializar el vector de BER
    simBER = zeros(1,length(SNR_dB));
    for i=1:length(SNR_dB)
        % Valor SNR
        SNR = SNR_dB(i);
        % Se añade ruido para conseguir el SNR
        fb = 10*log10((NFFT/2)/N_pay);
        if h
            % Convolución de la señal con el filtro
            y = conv(x,h);
            % Incluye el del ruido
            y = awgn(y,SNR-fb,'measured');
            % Recortar la señal de salida
            y = y(1:end-(length(h)-1));
        else
           % Inclusion del ruido
            y = awgn(x,SNR-fb,'measured'); 
        end
        % Demodulación
        rxBits = demodDNPSK(y,N,NFFT,Nofdm);
        % Aleatorización
        unrandomizedBits = scrambler(rxBits);
        % Cáculo del error de bit
        simBER(i) = sum(abs(unrandomizedBits-txBits))/length(txBits);
    end
end
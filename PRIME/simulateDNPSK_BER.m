function simBER = simulateDNPSK_BER(SNR_dB,N,NFFT,Nofdm,nPay,nBits,h,noise,use_ncp,use_inter,use_conv_enc)
    % Función del bloque scrambler. Recibe:
        % SNR_dB: Vector de valores de SNR
        % N: Niveles de modulación 
        % NFFT: Número de muestras de la NFFT
        % Nofdm: Número de símbolos OFDM
        % nPay: Numero de portadoras OFDM
        % nBits: Número de bits a simular
        % h: Filtro h[n] (si es [] no hay filtro)
        % noise: Blooleano que indica si se introduce ruido blanco o no
        % use_ncp: Booleano que indica si se usa prefijo cíclico y ecualizador o no
        % use_inter: Booleano que indica si se usa interleaver cíclico o no
        % use_conv_enc: Booleano que indica si se usa convolutional encoder o no 
    % Devuelve:
        % simBer: Vector de BER simulada
    if use_conv_enc 
        % Relación de codificación
        Rc = 1/2;
        % Generacion de los bits
        txBits = round(rand(1,Rc*nBits)); 
        % Introducir el flushing
        a = log2(N)*nPay/2*Nofdm;
        txBits(a-7:a)= 0;
        % Codificación convolucional
        inputBits = conv_encoder(txBits);
    else
        % Generacion de los bits
        txBits = round(rand(1,nBits));
        inputBits = txBits;
    end
    % Aleatorización
    randomBits = scrambler(inputBits);
    % Entrelazado
    if use_inter
        randomBits = interleaver(randomBits,N);
    end
    % Longitud del prefijo cíclico
    ncp = use_ncp*(length(h)-1);
    % Modulacion
    [x, SimbRef] = modDNPSK(randomBits,N,NFFT,Nofdm,ncp);
    % Inicializar el vector de BER
    simBER = zeros(1,length(SNR_dB));
    for i=1:length(SNR_dB)
        % Valor SNR
        SNR = SNR_dB(i);
        % Se añade ruido para conseguir el SNR
        fb = 10*log10((NFFT/2)/nPay);
        if h
            % Convolución de la señal con el filtro
            y = conv(x,h);
            if noise
                % Incluye ruido
                y = awgn(y,SNR-fb,'measured');
            end
            % Recortar la señal de salida
            y = y(1:end-(length(h)-1));
        else
           if noise
               % Inclusion de ruido
               y = awgn(x,SNR-fb,'measured'); 
           end
        end
        % Demodulación
        if use_ncp
           rxBits = demodDNPSK(y,N,NFFT,Nofdm,ncp,SimbRef);
        else
           rxBits = demodDNPSK(y,N,NFFT,Nofdm,ncp); 
        end
        % Desentrelazado
        if use_inter
            rxBits = deinterleaver(rxBits,N);
        end
        % Desaleatorización
        rxBits = scrambler(rxBits);
        % Decodificación de los códigos convolucionales
        if use_conv_enc 
           rxBits = conv_decoder(rxBits);
        end
        % Cáculo del error de bit
        simBER(i) = sum(abs(rxBits-txBits))/length(txBits);
    end
end
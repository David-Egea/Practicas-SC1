function rxBits = demodDNPSK(x,N,NFFT,Nofdm,ncp)
    % Demodulación DNPSK de la señal. Recibe:
        % x: Array de bits modulados
        % N: Niveles de modulación 
        % NFFT: Número de muestras de la NFFT
        % Nofdm: Número de símbolos OFDM
        % ncp: Numero de muestras del prefijo cíclico
    % Devuelve el vector de bits modulados
    
    rxBits = [];
    % Numero deportadoras
    Nprtds = 96;
    % Longitud de la trama
    L = (1/log2(N))*NFFT/Nprtds*Nofdm*Nprtds;
    % Número de tramas
    Ntram = round(length(x)/(L*log2(N)));
    % Numero de simbolos por trama
    NsimbTrama = length(x)/Ntram;
    % Creación de los demoduladores DPSK, DQPSK, D8PSK
    demoduladorDNPSK = comm.DPSKDemodulator(N,0,"BitOutput",true);
    % Añadir la fase
    prefijo = [0,0,0,0,1,1,1,0,1,1,1,1,0,0,1,0,1,1,0,0,1,0,0,1,0,0,0,0,0,0,1,0,0,0,1,0,0,1,1,0,0,0,1,0,1,1,1,0,1,0,1,1,0,1,1,0,0,0,0,0,1,1,0,0,1,1,0,1,0,1,0,0,1,1,1,0,0,1,1,1,1,0,1,1,0,1,0,0,0,0,1,0,1,0,1,0,1,1,1,1,1,0,1,0,0,1,0,1,0,0,0,1,1,0,1,1,1,0,0,0,1,1,1,1,1,1,1]; 
    % Cálculo de la fase
    fase = pi*prefijo(1:Nofdm);
    % Selección de la señal
    Nstart = 87;
    Nend = 183;
    
    for i=1:Ntram
        % Bits de la trama
        xTrama = x((i-1)*NsimbTrama+1:i*NsimbTrama);
        xTrama = reshape(xTrama,[],Nofdm);
        % Extracción del prefijo cícico
        if ncp
            % Extracción del prefijo cíclico
            xTrama = xTrama(ncp+1:end,:);
        end
        % Implementación de la FFT para demodular la señal OFDM
        Y = fft(xTrama,NFFT)/NFFT;
        % Ecualización
%         Y_EQ = 
        % Seleccionar señal
        Y = Y(Nstart+1:Nend,:)./exp(1i*fase);
        % Debug
%         for i = 1:NFFT
%            A(i) = sum(abs(Y(i,:)))/96;
%         end
%         figure;
%         stem(A(1,Nstart+1:Nend));
%         hold on;
%         stem(abs(Y(Nstart+1)));
        % Reorganizacion
        Y = reshape(Y,[],1);
        % Demodulación de los vectores de bits
        y = demoduladorDNPSK(Y)';
        rxBits = [rxBits y];
    end
end

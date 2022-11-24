function rxBits = demodDNPSK(x,N,NFFT)
    % Demodulación DNPSK de la señal. Recibe:
        % x: Array de bits modulados
        % N: Niveles de modulación 
        % NFFT: Número de muestras de la NFFT
        % Nofdm: Número de símbolos OFDM
    % Devuelve el vector de bits modulados
    
    % Implementación de la FFT para demodular la señal OFDM
    Y = fft(x,NFFT)/NFFT;

    % Selección de la señal+
    Nstart = 86;
    Nend = 182;
    Y = Y(Nstart+1:Nend,:);

    % Demodulación de las señales extraidas del demodulador OFDM para recuperar bits
    Y = reshape(Y,1,[]);

    % Creación de los demoduladores DPSK, DQPSK, D8PSK
    demodDNPSK = comm.DPSKDemodulator(N,0,"BitOutput",true);
    
    % Demodulacion QPSK
    rxBits = demodDNPSK(Y')';
end

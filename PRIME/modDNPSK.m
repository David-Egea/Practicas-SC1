function x = modDNPSK(txBits,N,NFFT,Nofdm)
    % Modulación DNPSK de la señal. Recibe:
        % txBits: Vector bits de entrada
        % N: Niveles de modulación 
        % NFFT: Número de muestras de la NFFT
        % Nofdm: Número de símbolos OFDM
    % Devuelve el vector de bits modulados
    
    % Creación del modulador DPSK
    modulatorDNPSK = comm.DPSKModulator(N,0,"BitInput",true);
    % Modulación de los vectores de bits
    modBits = modulatorDNPSK(txBits')';
    % Inicializacion a cero
    X = zeros(NFFT, Nofdm);
    %  Asignación de los símbolos moduladores al espectro positivo
    Nprtds = 96;
    Nstart = 86;
    Nend = 182;
    X(Nstart+1:Nend,:) = reshape(modBits,Nprtds,[]);
    %  Asignación de los símbolos moduladores en orden inverso y conjugados al espectro negativo
    X(NFFT/2+2:NFFT,:) = flipud(conj(X(2:NFFT/2,:)));
    % IFFT
    % Generación del vector de muestras temporales reales x como resultado de la modulación OFDM.
    x = ifft(X,NFFT,"symmetric")*NFFT;
end


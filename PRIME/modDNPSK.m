function [x, SimbRef] = modDNPSK(txBits,N,NFFT,Nofdm,ncp)
    % Modulación DNPSK de la señal. Recibe:
        % txBits: Vector bits de entrada
        % N: Niveles de modulación 
        % NFFT: Número de muestras de la NFFT
        % Nofdm: Número de símbolos OFDM
        % ncp: Numero de muestras del prefijo cíclico
    % Devuelve el vector de bits modulados y los símbolos de referencia
    % para la ecualización (opcional)
    
    SimbRef = [];
    x = [];
    % Creación del modulador DPSK
    moduladorDNPSK = comm.DPSKModulator(N,0,"BitInput",true);
    % Numero deportadoras
    Nprtds = 96;
    % Longitud de la trama
    L = log2(N)*Nofdm*Nprtds;
    % Número de tramas
    Ntram = length(txBits)/L;
    % Añadir la fase
    prefijo = [0,0,0,0,1,1,1,0,1,1,1,1,0,0,1,0,1,1,0,0,1,0,0,1,0,0,0,0,0,0,1,0,0,0,1,0,0,1,1,0,0,0,1,0,1,1,1,0,1,0,1,1,0,1,1,0,0,0,0,0,1,1,0,0,1,1,0,1,0,1,0,0,1,1,1,0,0,1,1,1,1,0,1,1,0,1,0,0,0,0,1,0,1,0,1,0,1,1,1,1,1,0,1,0,0,1,0,1,0,0,0,1,1,0,1,1,1,0,0,0,1,1,1,1,1,1,1]; 
    % Cálculo de la fase
    fase = pi*prefijo(1:Nofdm);
    % Modulador BPSK
    moduladorBPSK = comm.PSKModulator(2,0,"BitInput",true);
    % Piloto
    piloto = moduladorBPSK(prefijo');
    % Numero de bits de la trama
    NbitsTrama = Nprtds*Nofdm*log2(N);
    % Numero de bits de OFDM 
    NbitsSimbolo = Nprtds*log2(N);
    Nstart = 87;
    Nend = 183;
    % Iteracion de cada trama
    for i=1:Ntram
        % Bits de la trama
        txBitsTrama = txBits((i-1)*NbitsTrama+1:i*NbitsTrama);
        for j=1:Nofdm
            % Modulación de los vectores de bits
            modBits(:,j) = moduladorDNPSK(txBitsTrama((j-1)*NbitsSimbolo+1:j*NbitsSimbolo)').';
        end
        % Multiplicacion por la fase
        modBits = modBits.*exp(1i*fase);
        % Inicializacion a cero
        X = zeros(NFFT, Nofdm);
        % Se añade el piloto
        X(87,:) = piloto(1:Nofdm);
        figure;
        %  Asignación de los símbolos moduladores al espectro positivo
        X(Nstart+1:Nend,:) = reshape(modBits,Nprtds,[]);
        %  Asignación de los símbolos moduladores en orden inverso y conjugados al espectro negativo
        X(NFFT/2+2:NFFT,:) = flipud(conj(X(2:NFFT/2,:)));
        % Se añade el simbolo de referencia
        SimbRef = [SimbRef X(:,1)];
        % IFFT 
        m = ifft(X,NFFT,"symmetric")*NFFT;
        % Se añade prefijo cíclico
        if ncp 
            % Inicializacion matriz para el prefijo
            s = zeros(ncp+NFFT,Nofdm);
            % Insertar las ultimas muestras como prefijo ciclico al principio
            s(1:ncp,:) = m(end-ncp+1:end,:);
            % Insertar el resto de la la señal
            s(ncp+1:NFFT+ncp,:) = m; 
            % Conversion a vector fila
            x = [x reshape(s,1,[])];
        else
            % Generación del vector de muestras temporales reales x como resultado de la modulación OFDM.
            x = [x reshape(m,1,[])];   
        end
    end
end

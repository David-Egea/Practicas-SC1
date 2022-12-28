function interBits = interleaver(inputBits,N)
    % Función del bloque entrelazador. Recibe:
        % inputBits: Vector de Bits a entrelazar
        % N: Niveles de modulación 
    % Devuelve los bits entrelazados
    
    if N == 2
        % Tabla Interleaver DBPSK del Appendix II 
        cols = 8;
        rows = 12;
    elseif N == 4
        % Tabla Interleaver DQPSK del Appendix II 
        cols = 16;
        rows = 12;
    elseif N == 8
        % Tabla Interleaver D8PSK del Appendix II 
        cols = 16;
        rows = 18;
    end
    interBits = [];
    M = rows*cols; % Dimensión de la matriz
    for i=1:length(inputBits)/M
        % Entrelazado de los bits de entrada
        m = fliplr(transpose(reshape(inputBits((i-1)*M+1:i*M),cols,rows)));
        % Convertir los bits entrelazados a un vector fila
        interBits = [interBits reshape(m,[1,rows*cols])];
    end
end


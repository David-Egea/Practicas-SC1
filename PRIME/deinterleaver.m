function outputBits = deinterleaver(interBits,N)
    % Función del bloque desentrelazador. Recibe:
        % interBits: Vector de bits entrelazados
        % N: Niveles de modulación 
    % Devuelve los bits desentrelazados
    
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
    outputBits = [];
    M = rows*cols; % Dimensión de la matriz
    for i=1:length(interBits)/M
        % Desentrelazado de los bits de entrada
        m = transpose(fliplr(reshape(interBits((i-1)*M+1:i*M),rows,cols)));
        % Convertir los bits desentrelazados a un vector fila
        outputBits = [outputBits reshape(m,[1,rows*cols])];
    end
end

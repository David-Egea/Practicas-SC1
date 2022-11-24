function randomBits = scrambler(txBits,randomSequence)
    % Función del bloque scrambler. Recibe:
        % txBits: Vector de bits a transmitir
        % randomSequence: Secuencia de aleatorizacion
    % Devuelve:
        % randomBits: Vector de bits aleatorizados
        
    % Se extiende el vector de Bits
    % Secuencia de aleatorización
    randomSequence = [0,0,0,0,1,1,1,0,1,1,1,1,0,0,1,0,1,1,0,0,1,0,0,1,0,0,0,0,0,0,1,0,0,0,1,0,0,1,1,0,0,0,1,0,1,1,1,0,1,0,1,1,0,1,1,0,0,0,0,0,1,1,0,0,1,1,0,1,0,1,0,0,1,1,1,0,0,1,1,1,1,0,1,1,0,1,0,0,0,0,1,0,1,0,1,0,1,1,1,1,1,0,1,0,0,1,0,1,0,0,0,1,1,0,1,1,1,0,0,0,1,1,1,1,1,1,1];
    M = length(randomSequence)-mod(length(txBits),length(randomSequence));
    extendedBits = [txBits zeros(1,M)];
    randomBits  = [];
    % Se realiza una xor por bloques
    for i = 0:length(extendedBits)/length(randomSequence)-1
        randomBits = [randomBits bitxor(extendedBits(i*length(randomSequence)+1:(i+1)*length(randomSequence)),randomSequence)];
    end
    % Eliminar las muestras extra añadidas
    randomBits = randomBits(1:length(txBits));
end


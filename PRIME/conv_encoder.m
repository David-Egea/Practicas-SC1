function outputBits = conv_encoder(inputBits)
    % Codificador convolucional. Recibe:
        % inputBits: Vector de Bits a codificar
        % N: Niveles de modulación 
    % Devuelve los bits codificados
    % Longitud del registro de desplazamientos (Constraint length)
    L = 7; 
    % Generadores de código 
    k1 = bin2dec("10101011"); % 1111001
    k2 = bin2dec("10000011"); % 1011011
    % Generador de código convolucional
    trellis = poly2trellis(L, [k1 k2]);
    % Codificación de los bits de entrada
    outputBits = convenc(inputBits, trellis);
end


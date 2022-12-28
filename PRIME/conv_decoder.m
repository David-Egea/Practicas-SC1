function decodedBits = conv_decoder(encodedBits)
    % Decodificador convolucional. Recibe:
        % encodedBits: Vector de bits codificados
        % N: Niveles de modulación 
    % Devuelve los bits decodificados
    % Longitud del registro de desplazamientos (Constraint length)
    L = 7;
    % Profundidad de traceback
    P = 5*(L-1);
    % Generadores de código 
    k1 = bin2dec("10101011"); % 1111001
    k2 = bin2dec("10000011"); % 1011011
    % Generador de código convolucional
    trellis = poly2trellis(L, [k1 k2]);
    % Decodificación
    decodedBits = vitdec(encodedBits,trellis,P,'trunc','hard');
end

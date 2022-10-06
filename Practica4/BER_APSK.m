function [ BER ] = BER_APSK( M, R, Eb_N0_dB )
%
%  Esta funci�n entrega los vectores BER de una modulaci�n m_ary_APSK
%  
%  BER      BER resultante de una simulaci�n de transmisi�n. Es un vector cuya longitud es la misma
%           que la del vector de entrada Eb_N0_dB
%
%  M        vector cuya longitud es el n�mero de c�rculos de la modulaci�n, y el valor de
%           cada elemento el n�mero de puntos de la constelaci�n en cada c�rculo
%  R        vector cuya longitud es el n�mero de c�rculos de la modulaci�n, y el valor de
%           cada elemento la longitud del radio de cada c�rculo
%  EbNo_dB  vector de entrada que contiene los valores de relaci�n EbNo, en dB, para los que se
%           mide BER
%
%  N�mero de bits de la simulaci�n
   m_ary = sum(M);
   Nbits = 10000*log2(m_ary);
% 
   SNR_dB  = zeros(1, length(Eb_N0_dB));
   BER     = zeros(1, length(Eb_N0_dB));
   SNR_dB  = Eb_N0_dB + 10*log10(log2(m_ary));
%   
   for i = 1:length(SNR_dB)
        iBit   = round(rand(Nbits,1));                      % Genero el vector de bits a transmitir
        xmod   = apskmod(iBit, M, R,'InputType','bit');     % Se�al modulada
        ymod   = awgn(xmod, SNR_dB(i), 'measured');         % A�ado ruido
        ydemod = apskdemod(ymod, M, R, 'OutputType' , 'bit');   % Se�al demodulada
        BER(i) = sum(abs(ydemod-iBit))/length(iBit);        % Calculo el BER
   end
% 
end


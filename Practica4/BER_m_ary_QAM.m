function [ BER, BERteor ] = BER_m_ary_QAM( m_ary, Eb_N0_dB )
%
%  Esta función entrega los vectores BER y BER_teor de una modulación m_ary_QAM
%  
%  BER      BER resultante de una simulación de transmisión. Es un vector cuya longitud es la misma
%           que la del vector de entrada Eb_N0_dB
%  BERteor  BER teórica. Su longitud es la misma que la del vector BER
%
%  m_ary    número de niveles del sistema de modulación
%  EbNo_dB  vector de entrada que contiene los valores de relación EbNo, en dB, para los que se
%           calcula BERteor y mide BER
%
%  Número de bits de la simulación
   Nbits = 10000*log2(m_ary);
% 
   SNR_dB  = zeros(1, length(Eb_N0_dB));
   BER     = zeros(1, length(Eb_N0_dB));
   BERtheo = zeros(1, length(Eb_N0_dB));
   gamma   = zeros(1, length(Eb_N0_dB));
   SNR_dB  = Eb_N0_dB + 10*log10(log2(m_ary));
   for i = 1:length(SNR_dB)
        iBit   = round(rand(Nbits,1));                  % Genero el vector de bits a transmitir
        xmod   = qammod(iBit, m_ary, 'InputType', 'Bit');       % Señal modulada
        ymod   = awgn(xmod, SNR_dB(i), 'measured');                % Añado ruido
        ydemod = qamdemod(ymod, m_ary, 'OutputType' , 'bit');   % Señal demodulada
        BER(i) = sum(abs(ydemod-iBit))/length(iBit);            % Calculo el BER
   end
% 
%  BER teorico 
   gamma = 10.^(Eb_N0_dB/10); % Valor de gamma para el calculo teorico del BER
   k     = log2(m_ary);
   argumento = 3*k/(m_ary -1)*gamma;
   BERteor   = 4/k*(1-(1/sqrt(m_ary)))*qfunc(sqrt(argumento));
   BERteor(find(BERteor<1e-5)) = NaN;
end


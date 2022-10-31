function [BERSim,BERTheo]=calculateBER_QPSK_fase(txBits,fase)
s_tx = moduladorQPSK(txBits);
EbN0_dB = -5:2:15; % Niveles de ruido
M=4;
k = log2(M);
% Cambio de fase
% ----- QPSK -------
s_t= s_tx.* exp(-1i*(pi/(180/fase)));
for iter_EbN0_dB = 1:length(EbN0_dB)

    % SNR
    SNR_dB = EbN0_dB(iter_EbN0_dB) + 10*log10(k); 

    % ---- Canal ----
    r_t = awgn(s_t,SNR_dB,'measured'); % Añadir ruido blanco

    % ---- Recepción ----
    rxBits = demoduladorQPSK(r_t);

    [number,BERSim(iter_EbN0_dB)] = biterr(txBits,rxBits);
end
 
% En QPSK la probabilidad teórica
BERTheo = qfunc(sqrt(2*10.^(EbN0_dB/10)));
BERTheo(BERTheo<1e-5) = NaN;
end
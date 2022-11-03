function [BERSim,BERTheo]=calculateBER_DQPSK_fase(txBits,fase)
s_tx = moduladorDQPSK(txBits);
EbN0_dB = -5:2:15; % Niveles de ruido
M=4;
k = log2(M);
% Cambio de fase
s_t= s_tx.* exp(-1i*(pi/(180/fase)));
for iter_EbN0_dB = 1:length(EbN0_dB)

    % SNR
    SNR_dB = EbN0_dB(iter_EbN0_dB) + 10*log10(k); 

    % ---- Canal ----
    r_t = awgn(s_t,SNR_dB,'measured'); % Añadir ruido blanco

    % ---- Recepción ----
    rxBits = demoduladorDQPSK(r_t);

    [number,BERSim(iter_EbN0_dB)] = biterr(txBits,rxBits);
end
 
% En DQPSK la probabilidad teórica
BERTheo = 1.13*qfunc(sqrt(1.2*10.^(EbN0_dB/10)));
BERTheo(BERTheo<1e-5) = NaN;
end
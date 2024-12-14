A = 1;
T = 10e-3;
Ts = T/20;


[phi1, phi2] = generateBase(T, Ts);

N = 10;
bits = randi([0 1],1, N * 2);

Smod = modulator(bits, phi1, phi2);

% generate a subplot with s1, s2;
figure;
subplot(2,1,1);
plot(Smod);
title('Modulated Signal');
xlabel('Time (s)');
ylabel('Amplitude');
ylim([-15, 15]);

% %%%%%%%%%%%%%%%%%%%%%%%%% 3 DEMODULADOR

[dem1, dem2] = demodulateSignal(Smod, T, Ts);

disp("Bits: ");
disp(bits);
disp("Demodulated bits: ");
disp("s1: ");
disp(dem1);
disp("s2: ");
disp(dem2);


% %%%%%%%%%%%%%%%%%%%%%%%%% 4 DETECTOR

bitsDetected = detectSequence(dem1, dem2);

disp("____________________________________________________");

disp("Bits: ");
disp(bits);

disp("Bits detected: ");
disp(bitsDetected);

% Compare both sequences and count the number of errors
errors = sum(bits ~= bitsDetected);

% Calculate the error rate
errorRate = errors / length(bits);

% Display the number of errors and the error rate
disp("Number of errors: ");
disp(errors);
disp("Error rate: ");
disp(errorRate);

% %%%%%%%%%%%%%%%%%%%%%%%%% 5




clear; close all, format compact;

M=4; % 4-symbol alphabet
EsN0_dB = 0:2:20; % Vector to simulate SNR
esn0_lin=10.^(EsN0_dB/10); % in linear units
ebn0_lin=esn0_lin/log2(M); % bit energy / noise linear units
EbN0_dB=10*log10(ebn0_lin); % bit energy / noise dBs
Nsymb = 10000; % Number of symbols
numErr = zeros(1,length(EsN0_dB)); % Pre-allocation
 
% Compute Pe for every SNR value
% ---- Tx ----
% Generate Nsymb random equiprobable symbols
s = 
% Modulate symbolss
  s_t = Modulador(s);

for iter_EsN0= 1:length(EsN0_dB)
    
    % ---- Channel ----
    % Compute symbols' power
     SNR_awgn_dB=EsN0_dB(iter_EsN0)+10*log10(Ts/T); % Compute corresponding SNR for the signal
        r_t = awgn(s_t,SNR_awgn_dB,'measured'); % Add noise
 
    
    % ---- Rx ----
    y = matchedFilter(r_t);  % Or correlationType
    
    s_det = Detector(y); % Decided symbols
    
    % Compute number of wrong symbols comparing s_det with s
    numErr(snrIter) = ¿?;
    
end
% Compute simulated Symbol Error Probability
Pe = numErr/Nsymb;
 
% Plot performance
 
% Show simulated performance
figure
semilogy(EbN0_dB,Pe,'o-')
grid on
xlabel('SNR [dB]')
ylabel('P_e')
 
% Compute theoretical performance
PeTheo = 2*qfunc(sqrt(ebn0_lin));
PeTheo(find(PeTheo<1e-7))=NaN;

hold on 
semilogy(EbN0_dB,Pe,'x-')
semilogy(EbN0_dB,PeTheo)
legend('Simulada','Teorica','error probability')



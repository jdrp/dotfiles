% %%%%%%%%%%%%%%%%%%%%%%%%% graficar constelación grey

% Coordenadas de la constelación
phi1 = [1, 1, -1, -1]; % Eje phi1 (I)
phi2 = [1, -1, 1, -1]; % Eje phi2 (Q)

% Etiquetas usando código Gray
gray_labels = {'00', '01', '10', '11'};

% Crear la figura
figure;
hold on;
axis([-2 2 -2 2]); % Ajustar límites de los ejes
ylabel('\phi_1');
xlabel('\phi_2');
title('Constelación con código Gray');

% Dibujar los ejes
plot([-2 2], [0 0], 'k--'); % Eje \phi_1 (horizontal)
plot([0 0], [-2 2], 'k--'); % Eje \phi_2 (vertical)

% Graficar los puntos de la constelación
for i = 1:length(phi1)
    plot(phi1(i), phi2(i), 'rx', 'MarkerSize', 10, 'LineWidth', 2); % Símbolos como cruces
    text(phi1(i) + 0.1, phi2(i), gray_labels{i}, 'FontSize', 12); % Añadir etiquetas
end

grid on;
hold off;

% %%%%%%%%%%%%%%%%%%%%%%%%%

A = 1;
T = 10e-3;
Ts = T/20;

ts = Ts:Ts:T;

[phi1, phi2] = generateBase(T, Ts);

N = 10;
bits = randi([0 1],1, N * 2);



Smod = modulator(bits, phi1, phi2);

% generate a subplot with s1, s2;
ts_total = linspace(0, N * T, length(Smod));

figure;
plot(ts_total, Smod);
xlim([0.000, 0.1]);
title('Modulated Signal');
xlabel('Time (s)');
ylabel('Amplitude');
ylim([-15, 15]);

% print the bits
disp("Bits: ");
disp(bits);


% %%%%%%%%%%%%%%%%%%%%%%%%% 3 DEMODULADOR

[dem1, dem2] = demodulateSignal(Smod, T, Ts);

disp("Bits: ");
disp(bits);
disp("Demodulated bits: ");
disp("k1: ");
disp(dem1);
disp("k2: ");
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




clear; 
close all; 
format compact;
A = 1;
T = 10e-3;
Ts = T/20;
[phi1, phi2] = generateBase(T, Ts);
M = 4;

EsN0_dB = 0:2:20; % Vector to simulate SNR
esn0_lin=10.^(EsN0_dB/10); % in linear units
ebn0_lin=esn0_lin/log2(M); % bit energy / noise linear units
EbN0_dB=10*log10(ebn0_lin); % bit energy / noise dBs
Nsymb = 10000; % Number of symbols
numErr = zeros(1,length(EsN0_dB)); % Pre-allocation
 
% Compute Pe for every SNR value
% ---- Tx ----
% Generate Nsymb random equiprobable symbols
s = randi([0 1],1, Nsymb * 2);
% Modulate symbolss
s_t = modulator(s, phi1, phi2);

for iter_EsN0 = 1:length(EsN0_dB)
    % ---- Channel ----
    % Compute symbols' power
    SNR_awgn_dB = EsN0_dB(iter_EsN0) + 10 * log10(Ts/T); % Compute corresponding SNR for the signal
    r_t = awgn(s_t,SNR_awgn_dB,'measured'); % Add noise
    
    % ---- Rx ----
    [dem1, dem2] = demodulateSignal(r_t, T, Ts);  % Or correlationType
    
    s_det = detectSequence(dem1, dem2); % Decided symbols

    % Compute number of wrong symbols comparing s_det with s, please take into account that each symbol is represented by 2 bits AND s_det is a sequence of bits
    numErrors = 0;
    for i = 1:2:length(s) % Loop through the bits two at a time (i.e., symbols)
        if s(i) ~= s_det(i) || s(i+1) ~= s_det(i+1)
            numErrors = numErrors + 1; % Count mismatched symbols
        end
    end
    numErr(iter_EsN0) = numErrors;
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
legend('Simulated','Theoretical','Error Probability')





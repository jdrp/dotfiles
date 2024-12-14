%%%%%%%%%%%%%%%%%%%%%%%%% 2.1

T = 10e-3;
Ts = T/20;

[phi1, phi2] = generateBase(T, Ts);
S1 = phi1 + phi2;
S2 = phi1 - phi2;

ts = Ts:Ts:T;
% generate a subplot with s1, s2;
figure;
subplot(2,1,1);
plot(ts, S1);
title('Signal 1');
xlabel('Time (s)');
ylabel('Amplitude');
ylim([-12, 12]);
subplot(2,1,2);
plot(ts, S2);
title('Signal 2');
xlabel('Time (s)');
ylabel('Amplitude');
ylim([-12, 12]);


[o11, o12] = correlatorType(T, Ts, S1);

% generate a plot with o1, o2 in the same plot
figure;

% Plot for Signal 1
subplot(2, 1, 1);
plot(ts, o11, 'r');
hold on;
plot(ts, o12, 'b');
title('Correlator Output for Signal 1');
xlabel('Time (s)');
ylabel('Amplitude');
legend('Output 1', 'Output 2');
ylim([-1.5, 1.5]);
hold off;

[o21, o22] = correlatorType(T, Ts, S2);

% Plot for Signal 2
subplot(2, 1, 2);
plot(ts, o21, 'r');
hold on;
plot(ts, o22, 'b');
title('Correlator Output for Signal 2');
xlabel('Time (s)');
ylabel('Amplitude');
legend('Output 1', 'Output 2');
ylim([-1.5, 1.5]);
hold off;


%%%%%%%%%%%%%%%%%%%%%%%%% 2.2
S1n = awgn(S1, 10);
S2n = awgn(S2, 10);

% generate a subplot with s1, s2;
figure;
subplot(2,1,1);
plot(ts, S1n);
title('Signal 1 with noise');
xlabel('Time (s)');
ylabel('Amplitude');
ylim([-12, 12]);
subplot(2,1,2);
plot(ts, S2n);
title('Signal 2 with noise');
xlabel('Time (s)');
ylabel('Amplitude');
ylim([-12, 12]);



[o11, o12] = correlatorType(T, Ts, S1n);

% generate a plot with o1, o2 in the same plot
figure;

% Plot for Signal 1
subplot(2, 1, 1);
plot(ts, o11, 'r');
hold on;
plot(ts, o12, 'b');
title('Correlator Output for Signal 1 with noise');
xlabel('Time (s)');
ylabel('Amplitude');
legend('Output 1', 'Output 2');
ylim([-1.5, 1.5]);
hold off;

[o21, o22] = correlatorType(T, Ts, S2n);

% Plot for Signal 2
subplot(2, 1, 2);
plot(ts, o21, 'r');
hold on;
plot(ts, o22, 'b');
title('Correlator Output for Signal 2 with noise');
xlabel('Time (s)');
ylabel('Amplitude');
legend('Output 1', 'Output 2');
ylim([-1.5, 1.5]);
hold off;

%%%%%%%%%%%%%%%%%%%%%%%%%% 3

N = 100;
NS1 = repmat(S1, 1, N);
NS2 = repmat(S2, 1, N);
SNR = 10; % Relación señal a ruido en dB


symbol_length = length(S1); % Número de muestras por símbolo

% ------- Caso 1: Transmitiendo s_1(t) -------
% Generar señal transmitida compuesta por Nsymb símbolos s_1(t)
s_tx = repmat(S1, 1, Nsymb);

% Añadir ruido blanco gaussiano a la señal transmitida
r = awgn(s_tx, SNR, 'measured');

% Inicializar vectores para almacenar las salidas
r1 = zeros(1, Nsymb);
r2 = zeros(1, Nsymb);

% Demodular cada símbolo
for i = 1:Nsymb
    idx_start = (i-1)*symbol_length + 1;
    idx_end = i*symbol_length;
    r_symbol = r(idx_start:idx_end);
    [o1pred, o2pred] = demodulateSymbol(T, Ts, r_symbol);
    r1(i) = o1pred;
    r2(i) = o2pred;
end

% Representar histogramas de r1 y r2
figure;
subplot(2,1,1);
histogram(r1, 'Normalization', 'pdf');
title('Histograma de r1 al transmitir s\_1(t)');
xlabel('r1');
ylabel('Densidad de Probabilidad');

subplot(2,1,2);
histogram(r2, 'Normalization', 'pdf');
title('Histograma de r2 al transmitir s\_1(t)');
xlabel('r2');
ylabel('Densidad de Probabilidad');

% ------- Caso 2: Transmitiendo s_2(t) -------
% Generar señal transmitida compuesta por Nsymb símbolos s_2(t)
s_tx = repmat(S2, 1, Nsymb);

% Añadir ruido blanco gaussiano a la señal transmitida
r = awgn(s_tx, SNR, 'measured');

% Inicializar vectores para almacenar las salidas
r1_s2 = zeros(1, Nsymb);
r2_s2 = zeros(1, Nsymb);

% Demodular cada símbolo
for i = 1:Nsymb
    idx_start = (i-1)*symbol_length + 1;
    idx_end = i*symbol_length;
    r_symbol = r(idx_start:idx_end);
    [o1pred, o2pred] = demodulateSymbol(T, Ts, r_symbol);
    r1_s2(i) = o1pred;
    r2_s2(i) = o2pred;
end

% Representar histogramas de r1_s2 y r2_s2
figure;
subplot(2,1,1);
histogram(r1_s2, 'Normalization', 'pdf');
title('Histograma de r1 al transmitir s\_2(t)');
xlabel('r1');
ylabel('Densidad de Probabilidad');

subplot(2,1,2);
histogram(r2_s2, 'Normalization', 'pdf');
title('Histograma de r2 al transmitir s\_2(t)');
xlabel('r2');
ylabel('Densidad de Probabilidad');

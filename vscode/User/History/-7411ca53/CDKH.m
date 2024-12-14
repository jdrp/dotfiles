%%%%%%%%%%%%%%%%%%%%%%%%% 2.1

T = 10e-3;
Ts = T/20;

[phi1, phi2] = generateBase(T, Ts);
S1 = phi1 + phi2;
S2 = phi1 - phi2;

ts = Ts:Ts:T;

% generate a subplot with base;
figure;
subplot(2,1,1);
plot(ts, phi1);
title('\phi_1');
xlabel('Time (s)');
ylabel('Amplitude');
xlim([0.000, 0.01])
ylim([-2, 16]);
subplot(2,1,2);
plot(ts, phi2);
title('\phi_2');
xlabel('Time (s)');
ylabel('Amplitude');
xlim([0.000, 0.01])
ylim([-2, 16]);

% generate a subplot with s1, s2;
figure;
subplot(2,1,1);
plot(ts, S1);
title('Symbol 1');
xlabel('Time (s)');
ylabel('Amplitude');
ylim([-16, 16]);
subplot(2,1,2);
plot(ts, S2);
title('Symbol 2');
xlabel('Time (s)');
ylabel('Amplitude');
ylim([-16, 16]);


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
S1n = awgn(S1, 0);
S2n = awgn(S2, 0);

% generate a subplot with s1, s2;
figure;
subplot(2,1,1);
plot(ts, S1n);
title('Signal 1 with noise');
xlabel('Time (s)');
ylabel('Amplitude');
xlim([0.000, 0.01])
ylim([-17, 17]);
subplot(2,1,2);
plot(ts, S2n);
title('Signal 2 with noise');
xlabel('Time (s)');
ylabel('Amplitude');
ylim([-17, 17]);
xlim([0.000, 0.01])




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
N = 1000;
NS1 = repmat(S1, 1, N);
NS2 = repmat(S2, 1, N);
SNR = 10; % Relación señal a ruido en dB

% Añadir ruido blanco gaussiano a la señal transmitida
tx1 = awgn(NS1, SNR, 'measured');
tx2 = awgn(NS2, SNR, 'measured');

% Demodular las señales transmitidas
[rx_11, rx_12] = demodulateSignal(tx1, T, Ts);
[rx_21, rx_22] = demodulateSignal(tx2, T, Ts);

% Representar histogramas de r1 y r2 en disposición 2x2
figure;

% Histograma de r1 al transmitir s_1(t)
subplot(2, 2, 1);
histogram(rx_11, 'Normalization', 'pdf');
title('o_1 value when correlating noisy S_1');
xlabel('o_1');
ylabel('Densidad de Probabilidad');

% Histograma de r2 al transmitir s_1(t)
subplot(2, 2, 2);
histogram(rx_12, 'Normalization', 'pdf');
title('o_2 value when correlating noisy S_1');
xlabel('_2');
ylabel('Densidad de Probabilidad');

% Histograma de r1 al transmitir s_2(t)
subplot(2, 2, 3);
histogram(rx_21, 'Normalization', 'pdf');
title('o_1 value when correlating noisy S_2');
xlabel('o_1');
ylabel('Densidad de Probabilidad');

% Histograma de r2 al transmitir s_2(t)
subplot(2, 2, 4);
histogram(rx_22, 'Normalization', 'pdf');
title('o_2 value when correlating noisy S_2');
xlabel('o_2');
ylabel('Densidad de Probabilidad');
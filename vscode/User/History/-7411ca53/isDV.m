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
title('Signal 1');
xlabel('Time (s)');
ylabel('Amplitude');
xlim([0.000, 0.001])
ylim([-16, 16]);
subplot(2,1,2);
plot(ts, phi2);
title('Signal 2');
xlabel('Time (s)');
ylabel('Amplitude');
xlim([0.000, 0.001])
ylim([-16, 12]);

% generate a subplot with s1, s2;
figure;
subplot(2,1,1);
plot(ts, S1);
title('Signal 1');
xlabel('Time (s)');
ylabel('Amplitude');
ylim([-16, 16]);
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

N = 1000;
NS1 = repmat(S1, 1, N);
NS2 = repmat(S2, 1, N);
SNR = 10; % Relación señal a ruido en dB

% Añadir ruido blanco gaussiano a la señal transmitida
tx1 = awgn(NS1, SNR, 'measured');
tx2 = awgn(NS2, SNR, 'measured');

rx_11 = zeros(1, N);
rx_12 = zeros(1, N);
rx_21 = zeros(1, N);
rx_22 = zeros(1, N);

for i = 1:N
    Sin1 = tx1(1 + (i-1)*length(S1): i*length(S1));
    Sin2 = tx2(1 + (i-1)*length(S1): i*length(S1));

    [rx_11(i), rx_12(i)] = demodulateSymbol(T, Ts, Sin1);
    [rx_21(i), rx_22(i)] = demodulateSymbol(T, Ts, Sin2);
end

% Representar histogramas de r1 y r2 en disposición 2x2
figure;

% Histograma de r1 al transmitir s_1(t)
subplot(2, 2, 1);
histogram(rx_11, 'Normalization', 'pdf');
title('Histograma de r1 al transmitir s\_1(t)');
xlabel('r1');
ylabel('Densidad de Probabilidad');

% Histograma de r2 al transmitir s_1(t)
subplot(2, 2, 2);
histogram(rx_12, 'Normalization', 'pdf');
title('Histograma de r2 al transmitir s\_1(t)');
xlabel('r2');
ylabel('Densidad de Probabilidad');

% Histograma de r1 al transmitir s_2(t)
subplot(2, 2, 3);
histogram(rx_21, 'Normalization', 'pdf');
title('Histograma de r1 al transmitir s\_2(t)');
xlabel('r1');
ylabel('Densidad de Probabilidad');

% Histograma de r2 al transmitir s_2(t)
subplot(2, 2, 4);
histogram(rx_22, 'Normalization', 'pdf');
title('Histograma de r2 al transmitir s\_2(t)');
xlabel('r2');
ylabel('Densidad de Probabilidad');
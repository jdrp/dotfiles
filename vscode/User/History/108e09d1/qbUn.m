%%%%%%%%%%%%%%%%%%%%%%%%% 2.1

T = 10e-3;
Ts = T/20;

[S1, S2] = generateBase(T, Ts);
S3 = S1 + S2;
ts = Ts:Ts:T;
% generate a subplot with signals;
figure;
subplot(3,1,1);
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
ylim([-0.5, 1.5]);
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
ylim([-0.5, 1.5]);
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
ylim([-0.5, 1.5]);
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
ylim([-0.5, 1.5]);
hold off;


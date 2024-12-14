T = 10e-3;
Ts = T/20;

[S1, S2] = generateBase(T, Ts);
ts = Ts:Ts:T;
% generate a subplot with s1, s2;
figure;
subplot(2,1,1);
plot(ts, S1);
title('Signal 1');
xlabel('Time (s)');
ylabel('Amplitude');
subplot(2,1,2);
plot(ts, S2);
title('Signal 2');
xlabel('Time (s)');
ylabel('Amplitude');


[o1, o2] = correlatorType(T, Ts, S1);

% generate a plot with o1, o2 in the same plot
figure;
plot(ts, o1, 'r');
hold on;
plot(ts, o2, 'b');
title('Correlator Output');
xlabel('Time (s)');
ylabel('Amplitude');
legend('Output 1', 'Output 2');
hold off;



[o1, o2] = correlatorType(T, Ts, S2);

% generate a plot with o1, o2 in the same plot
figure;
plot(ts, o1, 'r');
hold on;
plot(ts, o2, 'b');
title('Correlator Output');
xlabel('Time (s)');
ylabel('Amplitude');
legend('Output 1', 'Output 2');
hold off;

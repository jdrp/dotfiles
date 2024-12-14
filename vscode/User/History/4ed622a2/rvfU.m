T = 10e-3;
Ts = T/20;

[S1, S2] = generateBase(T, Ts);
ts = 0:Ts:T-Ts;

[o1, o2] = correlatorType(T, Ts, s);

% generate a subplot with s1, s2;
figure;
subplot(2,1,1);
plot(ts, o1);
title('Output of Correlator for S1');
xlabel('Time (s)');
ylabel('Output');
subplot(2,1,2);
plot(ts, o2);
title('Output of Correlator for S2');
xlabel('Time (s)');
ylabel('Output');


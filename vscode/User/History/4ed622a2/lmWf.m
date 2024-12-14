T = 10e-3;
Ts = T/20;

[S1 S2] = generateBase(T, Ts);
ts = 0:

[o1, o2] = correlatorType(T, Ts, s);

% generate a subplot with s1, s2;
figure;
subplot(2,1,1);
plot(ts, s);
title('s(t)');
xlabel('t');
ylabel('s(t)');
hold on;


hold off;
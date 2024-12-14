T = 10e-3;
Ts = T/20;

[ts, s] = generateSignal(T, Ts, 1);
print(length(ts));

plot(ts, s)
[o1, o2] = correlatorType(T, Ts, s);
hold on;
plot(ts, o1)
plot(ts, o2)
hold off;
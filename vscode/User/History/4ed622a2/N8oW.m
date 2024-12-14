T = 10e-3;
Ts = T/20;

[ts, s] = generateSignal(T, Ts, 1);

plot(ts, s);
[o1, o2] = correlatorType(T, Ts, s);
plot(ts, o1);
plot(ts, o2);
A = 1;
T = 10e-3;
Ts = T/20;


[phi1, phi2] = generateBase(T, Ts);

N = 10;
bits = randi([0 1],1, N * 2);

Smod = modulator(N, phi1, phi2);
A = 1;
T = 10e-3;
Ts = T/20;


[phi1, phi2] = generateBase(T, Ts);

N = 10;

Smod = modulator(N, phi1, phi2);
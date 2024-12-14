A = 1;
T = 10e-3;
Ts = T/20;


[phi1, phi2] = generateBase(T, Ts);

N = 10;
bits = randi([0 1],1, N * 2);

Smod = modulator(bits, phi1, phi2);

% generate a subplot with s1, s2;
figure;
subplot(2,1,1);
plot(Smod);
title('Modulated Signal');
xlabel('Time (s)');
ylabel('Amplitude');
ylim([-15, 15]);
bits
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

% %%%%%%%%%%%%%%%%%%%%%%%%% 3 DEMODULADOR

[dem1, dem2] = demodulateSignal(Smod, T, Ts);

disp("Bits: ");
disp(bits);
disp("Demodulated bits: ");
disp("s1: ");
disp(dem1);
disp("s2: ");
disp(dem2);


% %%%%%%%%%%%%%%%%%%%%%%%%% 4 DETECTOR


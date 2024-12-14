% TODO
% - piloto en cada simb ofdm


close all;
clear all;

NFFT  =	512;  % Tamaño de la FFT
df    =  488.28125;  % Separación entre portadoras
Fs    =	NFFT*df;  % Frecuencia de muestreo
pilotCarrier = 43;  % Primera portadora
numCarriers = 96;  % Número de portadoras con datos

% MODULACIÓN
constellation2 = [0, pi];
constellation4 = [0, pi/2, pi, 3*pi/2];
constellation8 = [0, pi/4, 3*pi/4, pi/2, -pi/4, -pi/2, pi, -3*pi/4];
constellations = containers.Map({2, 4, 8}, {constellation2, constellation4, constellation8});

% ESTABILIDAD
Tsymb = 2240e-6;
stability = 100e-3;
maxSymbolsPerFrame = floor(stability / Tsymb);

numFrames = 10;

pilotSequence = [0,0,0,0,1,1,1,0,1,1,1,1,0,0,1,0,1,1,0,0,1,0,0,1,0,0,0,0,0,0,1,0,0,0,1,0,0,1,1,0,0,0,1,0,1,1,1,0,1,0,1,1,0,1,1,0,0,0,0,0,1,1,0,0,1,1,0,1,0,1,0,0,1,1,1,0,0,1,1,1,1,0,1,1,0,1,0,0,0,0,1,0,1,0,1,0,1,1,1,1,1,0,1,0,0,1,0,1,0,0,0,1,1,0,1,1,1,0,0,0,1,1,1,1,1,1,1];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%% 3.1 CANAL SIN DISTORSIÓN Y SIN FEC %%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% sin prefijo cíclico
cpLength = 0; 
% sin corrección de errores
generatorPolys = [1];
doInterleave = false;
% canal sin distorsión
h = [1];

scramblerSeed = [0,0,0,0,1,1,1,0,1,1,1,1,0,0,1,0,1,1,0,0,1,0,0,1,0,0,0,0,0,0,1,0,0,0,1,0,0,1,1,0,0,0,1,0,1,1,1,0,1,0,1,1,0,1,1,0,0,0,0,0,1,1,0,0,1,1,0,1,0,1,0,0,1,1,1,0,0,1,1,1,1,0,1,1,0,1,0,0,0,0,1,0,1,0,1,0,1,1,1,1,1,0,1,0,0,1,0,1,0,0,0,1,1,0,1,1,1,0,0,0,1,1,1,1,1,1,1];




snr_dB = -6:3:21;  % Relación señal a ruido en dB
m_arys = [2, 4, 8];  % Órdenes DPSK a probar
orderNames = ['DBPSK'; 'DQPSK'; 'D8PSK'];

% Valores teóricos
theoretical_BER = [
    formulas.DBPSK_BER(snr_dB);
    formulas.DQPSK_BER(snr_dB);
    formulas.D8PSK_BER(snr_dB).'
];

bits = 1:4224;
numSymbols = 44;
interleavedBits = tx.interleaver(bits, numCarriers, numSymbols);
deinterleavedBits = rx.deinterleaver(interleavedBits, numCarriers, numSymbols);

% show sum of errors
sum(xor(bits, deinterleavedBits))

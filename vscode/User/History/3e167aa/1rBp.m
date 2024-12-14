% function [] = transceiverBlock()

clear; close all;

NFFT  =	512;  % Tamaño de la FFT
df    =  488.28125;  % Separación entre portadoras
Fs    =	NFFT*df;  % Frecuencia de muestreo
firstCarrier = 43;  % Primera portadora con datos
cpLength = 128;  % Longitud del prefijo ciclico
m_ary = 3;  % DPSK order

nCarriers = 96;
generatorPolys = [1 1 1 1 0 0 1; 
                  1 0 1 1 0 1 1]; % TODO si no codificamos, poner [1]
scramblerSeed = [0,0,0,0,1,1,1,0,1,1,1,1,0,0,1,0,1,1,0,0,1,0,0,1,0,0,0,0,0,0,1,0,0,0,1,0,0,1,1,0,0,0,1,0,1,1,1,0,1,0,1,1,0,1,1,0,0,0,0,0,1,1,0,0,1,1,0,1,0,1,0,0,1,1,1,0,0,1,1,1,1,0,1,1,0,1,0,0,0,0,1,0,1,0,1,0,1,1,1,1,1,0,1,0,0,1,0,1,0,0,0,1,1,0,1,1,1,0,0,0,1,1,1,1,1,1,1];


h = [0, -0.1, 0.3, -0.5, 0.7, -0.9, 0.7, -0.5, 0.3, -0.1];


% PARAMETROS
numSymbols = 37;
numBits = numSymbols * log2(m_ary) * nCarriers / max(1, size(generatorPolys, 1));

rng(40);
bits = randi([0 1], 1, numBits);
constellation2 = [0, pi];
constellation4 = [0, pi/2, pi, 3*pi/2];
constellation8 = [0, pi/4, 3*pi/4, pi/2, -pi/4, -pi/2, pi, -3*pi/4];
constellations = containers.Map({2, 4, 8}, {constellation2, constellation4, constellation8});

% Transmitter
txSignal = tx.fullTransmitter(bits, generatorPolys, scramblerSeed, nCarriers, numSymbols, constellations(m_ary), NFFT, firstCarrier, cpLength);

% Channel
rxSignal = conv(txSignal, h);
rxSignal = rxSignal(length(1:length(txSignal)));

% Receiver (cambiar txSignal a eqSignal)
decodedBits = rx.fullReceiver(txSignal, nCarriers, numSymbols, NFFT, firstCarrier, cpLength, constellations(m_ary), scramblerSeed, generatorPolys);

isequal(bits, decodedBits)
% end
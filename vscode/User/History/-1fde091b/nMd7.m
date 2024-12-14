% TODO
% - piloto en cada simb ofdm


close all;
clear all;

NFFT  =	512;  % Tamaño de la FFT
df    =  488.28125;  % Separación entre portadoras
Fs    =	NFFT*df;% TODO
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

 
% Valores simulados
simulated_BER = zeros(length(m_arys), length(snr_dB));

for m_index = 1:length(m_arys)
    for snr_index = 1:length(snr_dB)
        simulated_BER(m_index, snr_index) = transceiverBlock(numFrames, maxSymbolsPerFrame, pilotSequence, NFFT, pilotCarrier, cpLength, m_arys(m_index), numCarriers, generatorPolys, scramblerSeed, constellations(m_arys(m_index)), h, doInterleave, snr_dB(snr_index));
    end
end

commons.plotBER(snr_dB, m_arys, simulated_BER, theoretical_BER, orderNames, [10^-4]);
 

% Ausencia de ruido
for m_index = 1:length(m_arys)
    noiselessBER = transceiverBlock(numFrames, maxSymbolsPerFrame, pilotSequence, NFFT, pilotCarrier, cpLength, m_arys(m_index), numCarriers, generatorPolys, scramblerSeed, constellations(m_arys(m_index)), h, doInterleave);
    display(['Tasa de error en condiciones ideales (orden ' num2str(m_arys(m_index)) '): ' num2str(noiselessBER)]);
end


% _________________________________________________________
% ___________________ CON INTERLEAVER _____________________
% _________________________________________________________

doInterleave = true;

simulatedBERWithInterleaver = zeros(length(m_arys), length(snr_dB));
for m_index = 1:length(m_arys)
    for snr_index = 1:length(snr_dB)
        simulatedBERWithInterleaver(m_index, snr_index) = transceiverBlock(numFrames, maxSymbolsPerFrame, pilotSequence, NFFT, pilotCarrier, cpLength, m_arys(m_index), numCarriers, generatorPolys, scramblerSeed, constellations(m_arys(m_index)), h, doInterleave, snr_dB(snr_index));
    end
end
display('Tasa de error con interleaver: ');
display(simulatedBERWithInterleaver)

% TODO: ya se que me has dicho que no hay que hacerlo pero pone en el enunciado asi que lo tendremos que mirar
commons.plotBER(snr_dB, m_arys, simulatedBERWithInterleaver, theoretical_BER, orderNames, [10^-4]);



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%% 3.2 CANAL CON DISTORSIÓN Y CON ECUALIZADOR %%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

h = [0, -0.1, 0.3, -0.5, 0.7, -0.9, 0.7, -0.5, 0.3, -0.1];
generatorPolys = [1 1 1 1 0 0 1; 
                  1 0 1 1 0 1 1]; % TODO si no codificamos, poner [1]

% Los resultados a mostrar serán:
                %   •	Si la señal que se inyecta en línea se denomina s(t), escribir la expresión algebraica de la señal recibida incluyendo únicamente el efecto de la dispersión del canal.

% ____________________________________________________________________
% ___________________ % Channel impulse response _____________________
% ____________________________________________________________________

figure;
stem(h);
title('Respuesta al impulso del canal');
xlabel('n');
ylabel('h[n]');
grid on;


                  

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%% 3.2 TODO PRIME CON FEC %%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


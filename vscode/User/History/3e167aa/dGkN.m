% function [] = transceiverBlock()
rng(50);

constellation2 = [[0, pi], [0, pi/2, pi, 3*pi/2], [0, pi/4, pi/2, 3*pi/4, pi, 5*pi/4, 3*pi/2, 7*pi/4]];
    
% PARAMETROS
bits = randi([0 1], 1, 192);
generatorPolys = [1 1 1 1 0 0 1; 
                  1 0 1 1 0 1 1];
scramblerSeed = [0,0,0,0,1,1,1,0,1,1,1,1,0,0,1,0,1,1,0,0,1,0,0,1,0,0,0,0,0,0,1,0,0,0,1,0,0,1,1,0,0,0,1,0,1,1,1,0,1,0,1,1,0,1,1,0,0,0,0,0,1,1,0,0,1,1,0,1,0,1,0,0,1,1,1,0,0,1,1,1,1,0,1,1,0,1,0,0,0,0,1,0,1,0,1,0,1,1,1,1,1,0,1,0,0,1,0,1,0,0,0,1,1,0,1,1,1,0,0,0,1,1,1,1,1,1,1];



encodedBits = tx.convolutionalEncoder(bits, generatorPolys);

[scrambledBits, endIndex] = tx.scrambler(encodedBits, scramblerSeed);

interleavedBits = tx.interleaver(1:192, 96);
deinterleavedBits = rx.deinterleaver(interleavedBits, 96)


% function modulatedSignal = modulatorDnPSK(bits, constellation)




% end
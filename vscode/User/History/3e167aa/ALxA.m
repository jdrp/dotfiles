% function [] = transceiverBlock()
rng(50);

constellations = [
    [1, -1]
    [1+1i, 1-1i, -1+1i, -1-1i]
    []
    ];
    
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
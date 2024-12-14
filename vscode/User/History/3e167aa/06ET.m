% function [] = transceiverBlock()
rng(50);

% PARAMETROS
bits = randi([0 1], 1, 10);
generatorPolys = [1 1 1 1 0 0 1; 
                  1 0 1 1 0 1 1];
scramblerSeed = [0,0,0,0,1,1,1,0,1,1,1,1,0,0,1,0,1,1,0,0,1,0,0,1,0,0,0,0,0,0,1,0,0,0,1,0,0,1,1,0,0,0,1,0,1,1,1,0,1,0,1,1,0,1,1,0,0,0,0,0,1,1,0,0,1,1,0,1,0,1,0,0,1,1,1,0,0,1,1,1,1,0,1,1,0,1,0,0,0,0,1,0,1,0,1,0,1,1,1,1,1,0,1,0,0,1,0,1,0,0,0,1,1,0,1,1,1,0,0,0,1,1,1,1,1,1,1];



encodedBits = blocks.convolutionalEncoder(bits, generatorPolys);

[scrambledBits, endIndex] = blocks.scrambler(encodedBits, scramblerSeed);

interleavedBits = blocks.interleaver(scrambledBits, 96);






% end
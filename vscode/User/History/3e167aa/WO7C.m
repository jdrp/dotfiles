% function [] = transceiverBlock()
rng(50);

% PARAMETROS
bits = randi([0 1], 1, 192);
generatorPolys = [1 1 1 1 0 0 1; 
                  1 0 1 1 0 1 1];
scramblerSeed = [0,0,0,0,1,1,1,0,1,1,1,1,0,0,1,0,1,1,0,0,1,0,0,1,0,0,0,0,0,0,1,0,0,0,1,0,0,1,1,0,0,0,1,0,1,1,1,0,1,0,1,1,0,1,1,0,0,0,0,0,1,1,0,0,1,1,0,1,0,1,0,0,1,1,1,0,0,1,1,1,1,0,1,1,0,1,0,0,0,0,1,0,1,0,1,0,1,1,1,1,1,0,1,0,0,1,0,1,0,0,0,1,1,0,1,1,1,0,0,0,1,1,1,1,1,1,1];



encodedBits = tx.convolutionalEncoder(bits, generatorPolys);

[scrambledBits, endIndex] = tx.scrambler(encodedBits, scramblerSeed);

interleavedBits = tx.interleaver(scrambledBits, 96);



[scrambledBits, endIndex] = tx.scrambler([1 1 0 1 0 1 1], scramblerSeed)






% end
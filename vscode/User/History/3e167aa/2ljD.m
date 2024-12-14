% function [] = transceiverBlock()

% PARAMETROS
% bits = randi([0 1], 1, 10)
generatorPolys = [1 1 1 1 0 0 1; 
                  1 0 1 1 0 1 1];


encodedBits = blocks.convolutionalEncoder(bits, generatorPolys)


seed_scrambler = [0,0,0,0,1,1,1,0,1,1,1,1,0,0,1,0,1,1,0,0,1,0,0,1,0,0,0,0,0,0,1,0,0,0,1,0,0,1,1,0,0,0,1,0,1,1,1,0,1,0,1,1,0,1,1,0,0,0,0,0,1,1,0,0,1,1,0,1,0,1,0,0,1,1,1,0,0,1,1,1,1,0,1,1,0,1,0,0,0,0,1,0,1,0,1,0,1,1,1,1,1,0,1,0,0,1,0,1,0,0,0,1,1,0,1,1,1,0,0,0,1,1,1,1,1,1,1];
% function [scrambledBits, endIndex] = scrambler(bits, seed, initialIndex)

[scrambledBits, endIndex] = blocks.scrambler(encodedBits, seed_scrambler);




% end
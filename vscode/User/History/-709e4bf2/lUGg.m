function [scrambledBits] = scrambler(bits, seed, initialIndex)
    if nargin < 3
        initialIndex = 1;
    end
    numBits = length(bits);
    scrambledBits = zeros(1, numBits);
    seedIndex = initialIndex;

    for i = 1:numBits
        scambledBits(i) = xor(bits(i), seed(seedIndex));
        seedIndex = seedIndex + 1;
        i
    end
  
end
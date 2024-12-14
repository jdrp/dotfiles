function [scrambledBits, seedIndex] = scrambler(bits, seed, initialIndex)
    if nargin < 3
        initialIndex = 1;
    end
    
    scrambledBits = zeros(1, length(bits));
    seedIndex = initialIndex;

    for i = 1:length(bits)
        scrambledBits(i) = xor(bits(i), seed(seedIndex));
        if seedIndex == length(seed)
            seedIndex = 1;
        else
            seedIndex = seedIndex + 1;
        end
    end
    

end
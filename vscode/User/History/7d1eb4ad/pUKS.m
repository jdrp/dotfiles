function [bits, seedIndex] = descrambler(scrambledBits, seed, initialIndex)
    if nargin < 3
        initialIndex = 1;
    end
    
    [bits, seedIndex] = tx.scrambler(scrambledBits, seed, initialIndex);
end
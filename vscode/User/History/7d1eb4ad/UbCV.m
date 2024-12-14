function [bits, seedIndex] = descrambler(scrambledBits, seed, initialIndex)
    if nargin < 3
        initialIndex = 1;
    end
    
    % to undo the scrambling, xor again with the seed
    [bits, seedIndex] = tx.scrambler(scrambledBits, seed, initialIndex);
end
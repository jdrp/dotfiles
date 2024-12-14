function [scrambledBits, seedIndex] = scrambler(bits, seed, initialIndex)
    % default start index
    if nargin < 3
        initialIndex = 1;
    end
    
    % initialize outputs
    scrambledBits = zeros(1, length(bits));
    seedIndex = initialIndex;

    for i = 1:length(bits)
        % scramble one bit
        scrambledBits(i) = xor(bits(i), seed(seedIndex));

        % restart the seed if the end is reached
        if seedIndex == length(seed)
            seedIndex = 1;
        else
            seedIndex = seedIndex + 1;
        end
    end
    

end
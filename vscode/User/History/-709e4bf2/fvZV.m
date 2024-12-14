function [scrambledBits, seedIndex] = scrambler(bits, seed, initialIndex)
    % we do this in order to have a default value for initialIndex
    if nargin < 3
        initialIndex = 1;
    end
    
    % initialize the vector
    scrambledBits = zeros(1, length(bits));
    seedIndex = initialIndex;

    for i = 1:length(bits)
        % this is the actual scrambling
        scrambledBits(i) = xor(bits(i), seed(seedIndex));

        % update the seed index
        if seedIndex == length(seed)
            seedIndex = 1;
        else
            
            seedIndex = seedIndex + 1;
        end
    end
    

end
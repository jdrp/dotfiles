function [interleavedBits] = interleaver(bits, numCarriers, numSymbols)
    numBits = length(bits);

    % step size
    s = 8 * (1 + floor((numBits/(numSymbols*numCarriers)) / 2))

    for i = 1:numSymbols
    
        % rearrange in matrix, transpose to interleave and flatten
    intMatrix = reshape(bits, [numBits / s, s]);
    intMatrix = intMatrix.';
    interleavedBits = intMatrix(:).';
    end
end
function [interleavedBits] = interleaver(bits, numCarriers, numSymbols)
    numBits = length(bits);
    bitsPerSymbol = numBits / numSymbols;
    % step size
    s = 8 * (1 + floor(bitsPerSymbol/numCarriers) / 2);

    for i = 1:numSymbols
        % rearrange in matrix, transpose to interleave and flatten
        intMatrix = reshape(bits((i-1) * bitsPerSymbol + 1 : i * bitsPerSymbol), [numBits / s, s]);
        intMatrix = intMatrix.';
        interleavedBits(bits((i-1) * bitsPerSymbol + 1 : i * bitsPerSymbol) = intMatrix(:).';
    end
end
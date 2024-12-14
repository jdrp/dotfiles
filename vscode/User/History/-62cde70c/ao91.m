function interleavedBits = deinterleaver(bits, numCarriers, numSymbols)
    numBits = length(bits);
    bitsPerSymbol = numBits / numSymbols;

    % step size
    s = 8 * (1 + floor((bitsPerSymbol/numCarriers) / 2));

    % rearrange in matrix, transpose to interleave and flatten
    intMatrix = reshape(bits, [s, numBits / s]);
    intMatrix = intMatrix.';
    interleavedBits = intMatrix(:).';
end
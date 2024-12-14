function deinterleavedBits = deinterleaver(bits, numCarriers, numSymbols)
    numBits = length(bits);
    bitsPerSymbol = numBits / numSymbols;

    % step size
    s = 8 * (1 + floor((bitsPerSymbol/numCarriers) / 2));

    % rearrange in matrix, transpose to interleave and flatten
    deinterleavedBits = zeros(size(bits));

    % interleave each symbol
    for i = 1:numSymbols
        % rearrange in matrix, transpose to interleave and flatten
        intMatrix = reshape(bits((i-1) * bitsPerSymbol + 1 : i * bitsPerSymbol), s, bitsPerSymbol / s);
        intMatrix = intMatrix.';
        deinterleavedBits((i-1) * bitsPerSymbol + 1 : i * bitsPerSymbol) = intMatrix(:).';
    end
end
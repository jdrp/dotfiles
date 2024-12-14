function interleavedBits = deinterleaver(bits, numCarriers)
    numBits = length(bits);

    % step size
    s = 8 * (1 + floor((numBits/numCarriers) / 2));

    % rearrange in matrix, transpose to interleave and flatten
    intMatrix = reshape(bits, [s, numBits / s]);
    intMatrix = intMatrix.';
    interleavedBits = intMatrix(:).';
end
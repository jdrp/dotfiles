function [interleavedBits] = interleaver(bits, numCarriers)
    numBits = length(bits);

    s = 8 * (1 + floor((numBits/numCarriers) / 2));

    intMatrix = reshape(bits, [numBits / s, s]);
    intMatrix = intMatrix.';
    interleavedBits = intMatrix(:).';

end
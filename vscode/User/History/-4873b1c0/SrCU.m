function [interleavedBits] = interleaver(bits, numCarriers)
    nBits = length(bits);

    s = 8 * (1 + floor((nBits/numCarriers) / 2));

    intMatrix = reshape()
end
function [deinterleavedBits] = deinterleaver(interleavedBits, numCarriers, numSymbols)
    % Total number of coded bits
    numBits = length(interleavedBits);
    NCBPS = numBits / numSymbols; % Number of coded bits per symbol

    % Ensure NCBPS is an integer
    assert(mod(numBits, numSymbols) == 0, 'numBits must be divisible by numSymbols.');

    % Calculate step size `s`
    s = 8 * (1 + floor(NCBPS / 2));

    % Initialize deinterleavedBits array
    deinterleavedBits = zeros(1,numBits);
    i = 0:numBits - 1; % Input indices

    % Deinterleaving formula
    kIndex = s * i - (NCBPS - 1) * floor(s * i / NCBPS) + 1; % Ensure indices are integers

    deinterleavedBits(kIndex) = interleavedBits(i + 1); % Adjust indexing for MATLAB
end

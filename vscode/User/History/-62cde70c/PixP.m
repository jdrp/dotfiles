function [deinterleavedBits] = deinterleaver(interleavedBits, numCarriers, numSymbols) % // TODO está roto
    % Total number of coded bits
    numBits = length(interleavedBits);
    Ncbps = numBits / numSymbols; % Number of coded bits per symbol

    % Ensure NCBPS is an integer
    assert(mod(numBits, numSymbols) == 0, 'numBits must be divisible by numSymbols.');

    % Calculate step size `s`
    s = 8 * (1 + floor(Ncbps / 2));

    % Initialize deinterleavedBits array
    deinterleavedBits = zeros(1,numBits);
    i = 0:numBits - 1; % Input indices

    % Deinterleaving formula
    vIndex = s * i - (Ncbps - 1) * floor(s * i / Ncbps) + 1; % Ensure indices are integers
    numBits
    length(deinterleavedBits)
    max(vIndex)
    min(vIndex)

    deinterleavedBits(vIndex) = interleavedBits(i + 1); % Adjust indexing for MATLAB
end

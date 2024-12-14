function [interleavedBits] = interleaver(bits, numCarriers, numSymbols)
    % Total number of coded bits
    numBits = length(bits);
    Ncbps = numBits / numSymbols; % Number of coded bits per symbol

    % Ensure NCBPS is an integer
    assert(mod(numBits, numSymbols) == 0, 'numBits must be divisible by numSymbols.');

    % Calculate step size `s`
    s = 8 * (1 + floor(Ncbps / 2));

    % Initialize interleavedBits array
    interleavedBits = zeros(size(bits));
    k = 0:Ncbps - 1; % Input indices

    for i = 1:numSymbols
        symbolBits = bits((i-1) * Ncbps + 1 : i * Ncbps);
        % Interleaving formula
        wIndex = mod(k, s) * floor(Ncbps / s) + floor(k / s) + 1; % Ensure indices are integers
        interleavedSymbolBits = zeros(1, Ncbps);
        interleavedSymbolBits(wIndex) = bits(k + 1); % Adjust indexing for MATLAB
        interleavedBits((i-1) * Ncbps + 1 : i * Ncbps) = interleavedSymbolBits;
    end
end

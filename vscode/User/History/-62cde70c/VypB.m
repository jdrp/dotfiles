function [deinterleavedBits] = deinterleaver(bits, numSymbols) % // TODO está roto
    % Total number of coded bits
    numBits = length(bits);
    Ncbps = numBits / numSymbols; % Number of coded bits per symbol

    % Ensure NCBPS is an integer
    assert(mod(numBits, numSymbols) == 0, 'numBits must be divisible by numSymbols.');

    % Calculate step size `s`
    s = 8 * (1 + floor(Ncbps / 2));

    % Initialize deinterleavedBits array
    deinterleavedBits = zeros(1,numBits);
    k = 0:Ncbps - 1; % Input indices



    for i = 1:numSymbols
        symbolBits = bits((i-1) * Ncbps + 1 : i * Ncbps);
        % Interleaving formula
        vIndex = s * k - (Ncbps - 1) * floor(s * k / Ncbps) + 1; % Ensure indices are integers
        deinterleavedSymbolBits = zeros(1, Ncbps);
        deinterleavedSymbolBits(vIndex) = symbolBits(k + 1); % Adjust indexing for MATLAB
        deinterleavedBits((i-1) * Ncbps + 1 : i * Ncbps) = deinterleavedSymbolBits;
    end
end

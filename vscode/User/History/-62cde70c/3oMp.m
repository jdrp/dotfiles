function [deinterleavedBits] = deinterleaver(bits, numCarriers, numSymbols) % // TODO está roto
    % Total number of coded bits
    numBits = length(bits);
    Ncbps = numBits / numSymbols; % Number of coded bits per symbol

    % Ensure NCBPS is an integer
    assert(mod(numBits, numSymbols) == 0, 'numBits must be divisible by numSymbols.');

    % Calculate step size `s`
    s = 8 * (1 + floor(Ncbps / 2));

    % Initialize deinterleavedBits array
    deinterleavedBits = zeros(1,numBits);
    i = 0:Ncbps - 1; % Input indices

    % Deinterleaving formula
    vIndex = s * i - (Ncbps - 1) * floor(s * i / Ncbps) + 1; % Ensure indices are integers

    deinterleavedBits(vIndex) = bits(i + 1); % Adjust indexing for MATLAB



    for n = 1:numSymbols
        % De-interleaving formula
        vIndex = s * i - (Ncbps - 1) * floor(s * i / Ncbps) + 1;
        deinterleavedBits((n-1)*Ncbps + vIndex) = bits(k + 1); % Adjust indexing for MATLAB
    end
end

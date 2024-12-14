function [interleavedBits] = interleaver(bits, numCarriers, numSymbols)
    numBits = length(bits);
    bitsPerSymbol = numBits / numSymbols;
    % step size
    s = 8 * (1 + floor(bitsPerSymbol) / 2);
    interleavedBits = zeros(size(bits));

    % interleave each symbol
    for i = 1:numSymbols
        % rearrange in matrix, transpose to interleave and flatten
        intMatrix = reshape(bits((i-1) * bitsPerSymbol + 1 : i * bitsPerSymbol), bitsPerSymbol / s, s);
        intMatrix = intMatrix.';
        interleavedBits((i-1) * bitsPerSymbol + 1 : i * bitsPerSymbol) = intMatrix(:).';
    end



    %% Number of coded bits per OFDM symbol
    %numBits = length(bits);
    %Ncbps = numBits / numSymbols;
%
    %% Calculate the step size `s` for payload interleaving
    %s = 8 * (1 + floor(Ncbps / 2));
%
    %% Initialize the interleavedBits array
    %interleavedBits = zeros(size(bits));
    %k = 0:numBits - 1; % Vector of input indices
%
    %% Perform interleaving based on the formula:
    %% w((Ncbps/s) * (k mod s) + floor(k/s)) = v(k)
    %wIndex = mod(k, s) * floor(Ncbps / s) + floor(k / s) + 1; % Ensure indices are integers
    %%wIndex = mod(wIndex - 1, numBits) + 1; % Wrap indices to stay within bounds (MATLAB 1-based)
%
    %% Map bits to interleaved positions
    %interleavedBits(wIndex) = bits(k + 1); % Adjust indexing for MATLAB
    
end
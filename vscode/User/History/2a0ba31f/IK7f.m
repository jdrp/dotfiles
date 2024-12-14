
%{
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
%}

function [deinterleavedBits] = deinterleaver(interleavedBits, numCarriers, numSymbols)
    % Number of coded bits per OFDM symbol
    numBits = length(interleavedBits);
    Ncbps = numBits / numSymbols;

    % Calculate the step size `s` for payload deinterleaving
    s = 8 * (1 + floor(Ncbps / 2));

    % Initialize the deinterleavedBits array
    deinterleavedBits = zeros(size(interleavedBits));
    i = 0:numBits - 1; % Vector of input indices

    % Perform deinterleaving based on the formula:
    % v(k) = w(s * i - (Ncbps - 1) * floor(s * i / Ncbps))
    kIndex = s * i - (Ncbps - 1) * floor(s * i / Ncbps) + 1; % Ensure indices are integers
    deinterleavedBits(kIndex) = interleavedBits(i + 1); % Adjust indexing for MATLAB
end
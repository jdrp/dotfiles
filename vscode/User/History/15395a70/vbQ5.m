function demodulatedBits = demodulatorDnPSK(signal, constellation, numSymbols, numCarriers)
    n = length(constellation);
    bitsPerCarrier = ceil(log2(n));
    bitsPerSymbol = bitsPerCarrier * numCarriers;
    modulatedPhases = reshape(angle(signal), numCarriers + 1, numSymbols);
    demodulatedBits = zeros(bitsPerSymbol, numSymbols);
    
    % get phase diffs
    phaseDiffs = mod(modulatedPhases(2, :) - modulatedPhases(1, :), 2*pi);
    for i = 1:numCarriers
        % get closest symbols
        [~, symbolIndexes] = min(abs(phaseDiffs - constellation'));
        % convert to binary
        demodulatedBits((i-1) * bitsPerCarrier + 1 : i * bitsPerCarrier, :) = dec2bin(symbolIndexes - 1, bitsPerCarrier).' - '0';
    end

    demodulatedBits = demodulatedBits(:)';
end
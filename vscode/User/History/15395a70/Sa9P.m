function demodulatedBits = demodulatorDnPSK(signal, constellation, numSymbols, numCarriers)
    n = length(constellation);
    bitsPerCarrier = ceil(log2(n));
    bitsPerSymbol = bitsPerCarrier * numCarriers;
    modulatedPhases = reshape(angle(signal), numCarriers + 1, numSymbols);
    size(modulatedPhases)
    modulatedPhases(1:3, 1:10)
    demodulatedBits = zeros(bitsPerSymbol, numSymbols);

    for i = 1:numCarriers
        % get phase diffs
        phaseDiffs = mod(modulatedPhases(i+1, :) - modulatedPhases(i, :), 2*pi);
        % get closest symbols
        [~, symbolIndexes] = min(abs(phaseDiffs - constellation'));
        % convert to binary
        demodulatedBits((i-1) * bitsPerCarrier + 1 : i * bitsPerCarrier, :) = dec2bin(symbolIndexes - 1, bitsPerCarrier).' - '0';
    end

    demodulatedBits = demodulatedBits(:)';
end
function demodulatedBits = demodulatorDnPSK(signal, constellation, numSymbols, numCarriers)
    n = length(constellation);
    bitsPerCarrier = ceil(log2(n));
    bitsPerSymbol = bitsPerCarrier * numCarriers;
    modulatedPhases = reshape(angle(signal), numCarriers + 1, numSymbols);
    size(modulatedPhases)
    modulatedPhases(1:3, 1:10)
    demodulatedBits = zeros(bitsPerSymbol, numSymbols);
    
    % get phase diffs
    phaseDiffs = mod(modulatedPhases(2:end, :) - modulatedPhases(1:end-1, :), 2*pi);
    size(phaseDiffs)
    size(constellation')
    for i = 1:numCarriers
        % get closest symbols
        [~, closestSymbolIndices] = min(abs(phaseDiffs(:,i) - constellation'));
        % convert to binary
        demodulatedBits((i-1) * bitsPerCarrier + 1 : i * bitsPerCarrier, :) = dec2bin(closestSymbolIndices - 1, bitsPerCarrier).' - '0';
    end

    demodulatedBits = demodulatedBits(:)';
end
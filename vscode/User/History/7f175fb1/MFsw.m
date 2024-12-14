function modulatedSignal = modulatorDnPSK(bits, constellation, numSymbols, numCarriers, pilotSequence)

    n = length(constellation);
    bitsPerCarrier = ceil(log2(n));
    bitsPerSymbol = bitsPerCarrier * numCarriers;
    modulatedPhases = zeros(numCarriers+1, numSymbols);
    modulatedPhases(1,:) = pilotSequence(1:numSymbols) * pi;
    symbolBits = reshape(bits, bitsPerSymbol, numSymbols);
    bitsPerCarrier
    bitsPerSymbol
    size(symbolBits)
    size(modulatedPhases)
    
    for i = 1:numCarriers
        % extract symbol bits and convert to decimal
        symbolIndexes = bin2dec(num2str(symbolBits((i-1)*bitsPerCarrier + 1: i*bitsPerCarrier, :)));
        % add new phase diff
        modulatedPhases() = modulatedPhases(i+1,:) + constellation(symbolIndexes + 1);
    end

    modulatedSignal = exp(1j * modulatedPhases(:));
    size(modulatedSignal)
end
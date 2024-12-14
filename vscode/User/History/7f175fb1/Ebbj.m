function modulatedSignal = modulatorDnPSK(bits, constellation, numSymbols, numCarriers, pilotSequence)

    n = length(constellation);
    bitsPerCarrier = ceil(log2(n));
    bitsPerSymbol = bitsPerCarrier * numCarriers;
    modulatedSignal = zeros(1, numSymbols);

    for s = 1:numSymbols

        numSymbols = length(bits) / bitsPerCarrier;
        currentPhase = 2*pi*pilotSequence(s);
        symbolBits = bits(bitsPerSymbol * (s-1) + 1 : s*bitsPerSymbol);
    
        for i = 1:numCarriers
            % extract symbol bits and convert to decimal
            symbolIndex = bin2dec(num2str(symbolBits((i-1)*bitsPerCarrier + 1: i*bitsPerCarrier)));
            % add new phase diff
            currentPhase = currentPhase + constellation(symbolIndex + 1);
            % generate complex sample
            modulatedSignal((s-1)*numCarriers + i) = exp(1j * currentPhase);
        end
    end


end
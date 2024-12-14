function modulatedSignal = modulatorDnPSK(bits, constellation)

    n = length(constellation);
    bitsPerSymbol = log2(n);
    numSymbols = length(bits) / bitsPerSymbol;
    modulatedSignal = zeros(1, numSymbols);
    currentPhase = 0;

    for i = 1:numSymbols
        
        % extract symbol bits and convert to decimal
        symbolIndex = bin2dec(bits(i*bitsPerSymbol : (i+1)*bitsPerSymbol-1));
        % add new phase diff
        currentPhase = currentPhase + constellation(symbolIndex);
        % generate complex sample
        modulatedSignal(i) = exp(1j * currentPhase);
    end
    % :)
end
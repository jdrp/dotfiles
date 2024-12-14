function modulatedSignal = modulatorDnPSK(bits, constellation, numSymbols, numCarriers, pilotSequence)

    n = length(constellation);
    bitsPerCarrier = ceil(log2(n));
    bitsPerSymbol = bitsPerCarrier * numCarriers;
    modulatedPhases = zeros(numCarriers+1, numSymbols);
    modulatedPhases(1,:) = pilotSequence(1:numSymbols) * pi;
    symbolBits = reshape(bits, bitsPerSymbol, numSymbols);
 
    for i = 1:numCarriers
        % extract symbol bits and convert to decimal
        symbolIndices = bin2dec(num2str(symbolBits((i-1)*bitsPerCarrier + 1: i*bitsPerCarrier, :).'));
        % add new phase diff
        modulatedPhases(i+1, :) = mod(modulatedPhases(i,:) + constellation(symbolIndices + 1), 2*pi);
    end

    modulatedPhases(1:3, 1:10)

    modulatedSignal = exp(1j * modulatedPhases(:)');
end
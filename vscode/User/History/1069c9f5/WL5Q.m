function BER = transceiverBlock(numSymbols, NFFT, firstCarrier, cpLength, m_ary, numCarriers, generatorPolys, scramblerSeed, constellation, h, snr)
    rng(40);
    % for each OFDM symbol and subcarrier, 1 to 3 bits according to the modulation order. If FEC,  
    numBits = numSymbols * log2(m_ary) * numCarriers / max(1, size(generatorPolys, 1));
    bits = randi([0 1], 1, numBits);

    % Transmitter
    txSignal = tx.fullTransmitter(bits, generatorPolys, scramblerSeed, numCarriers, numSymbols, constellation, NFFT, firstCarrier, cpLength);

    % Channel
    rxSignal = conv(txSignal, h);
    rxSignal = rxSignal(1:length(txSignal));

    % Noise
    rxSignal = awgn(rxSignal, snr, 'measured');

    % Receiver (cambiar txSignal a rxSignal)
    decodedBits = rx.fullReceiver(rxSignal, numCarriers, h, numSymbols, NFFT, firstCarrier, cpLength, constellation, scramblerSeed, generatorPolys);

    % Errors
    sumErrors = sum(xor(bits, decodedBits));
    BER = sumErrors / numBits;

end 


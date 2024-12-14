function BER = transceiverBlock(numFrames, symbolsPerFrame, NFFT, firstCarrier, cpLength, m_ary, numCarriers, generatorPolys, scramblerSeed, constellation, h, snr)
    rng(40);

    BERs = zeros(numFrames, 1);

    for f = 1:numFrames
        % For each OFDM symbol and subcarrier, 1 to 3 bits according to the modulation order. If FEC, apply coding rate. 
        numBits = symbolsPerFrame * numCarriers * log2(m_ary) / max(1, size(generatorPolys, 1));
        bits = randi([0 1], 1, numBits);

        % Transmitter
        txSignal = tx.fullTransmitter(bits, generatorPolys, scramblerSeed, numCarriers, symbolsPerFrame, constellation, NFFT, firstCarrier, cpLength);

        % Channel
        rxSignal = conv(txSignal, h);
        rxSignal = rxSignal(1:length(txSignal));

        % Noise
        if nargin == 12
            fb = 10*log10( (NFFT/2)/numCarriers );  % bandwidth factor
            rxSignal = awgn(rxSignal, snr, 'measured');
        end

        % Receiver (cambiar txSignal a rxSignal)
        decodedBits = rx.fullReceiver(rxSignal, numCarriers, h, symbolsPerFrame, NFFT, firstCarrier, cpLength, constellation, scramblerSeed, generatorPolys);

        % Errors
        sumErrors = sum(xor(bits, decodedBits));
        BERs(f) = sumErrors / numBits;
    end

    BER = mean(BERs);
end 


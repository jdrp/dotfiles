function txSignal = fullTransmitter(bits, generatorPolys, scramblerSeed, nCarriers, numSymbols, constellation, NFFT, firstCarrier, cpLength)

    encodedBits = tx.convolutionalEncoder(bits, generatorPolys);

    [scrambledBits, ~] = tx.scrambler(encodedBits, scramblerSeed);
    
    interleavedBits = tx.interleaver(scrambledBits, nCarriers, numSymbols);
    
    modulatedSignal = tx.modulatorDnPSK(interleavedBits, constellation);

    txSignal = tx.muxOFDM(modulatedSignal, nCarriers, NFFT, firstCarrier, cpLength);
end
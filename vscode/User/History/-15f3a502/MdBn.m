function txSignal = fullTransmitter(bits, generatorPolys, scramblerSeed, numCarriers, numSymbols, constellation, NFFT, firstCarrier, cpLength)

    if scramblerSeed ~= [1]
        encodedBits = tx.convolutionalEncoder(bits, generatorPolys);
        
        [scrambledBits, ~] = tx.scrambler(encodedBits, scramblerSeed);
        
        interleavedBits = tx.interleaver(scrambledBits, numCarriers, numSymbols);
    else
        interleavedBits = bits;
    end
    
    modulatedSignal = tx.modulatorDnPSK(interleavedBits, constellation);

    txSignal = tx.muxOFDM(modulatedSignal, numCarriers, NFFT, firstCarrier, cpLength, numSymbols);
end
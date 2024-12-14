function txSignal = fullTransmitter(bits, generatorPolys, scramblerSeed, numCarriers, numSymbols, constellation, NFFT, firstCarrier, cpLength)

    encodedBits = tx.convolutionalEncoder(bits, generatorPolys);
    
    if scramblerSeed ~= [1]
        [scrambledBits, ~] = tx.scrambler(encodedBits, scramblerSeed);
        
        interleavedBits = tx.interleaver(scrambledBits, numCarriers, numSymbols);
    else
        interleavedBits = encodedBits;
    end
    
    modulatedSignal = tx.modulatorDnPSK(interleavedBits, constellation);
   
    txSignal = tx.muxOFDM(modulatedSignal, numCarriers, NFFT, firstCarrier, cpLength, numSymbols);
end
function txSignal = fullTransmitter(bits, generatorPolys, scramblerSeed, numCarriers, numSymbols, constellation, pilotSequence, NFFT, pilotCarrier, cpLength, doInterleave)

    encodedBits = tx.convolutionalEncoder(bits, generatorPolys);
    
    [scrambledBits, ~] = tx.scrambler(encodedBits, scramblerSeed);
        
    if doInterleave
        interleavedBits = tx.interleaver(scrambledBits, numCarriers, numSymbols);
    else
        interleavedBits = scrambledBits;
    end
    
    modulatedSignal = tx.modulatorDnPSK(interleavedBits, constellation, numSymbols, numCarriers, pilotSequence);
   
    txSignal = tx.muxOFDM(modulatedSignal, numCarriers+1, NFFT, pilotCarrier, cpLength, numSymbols);
end
function txSignal = fullTransmitter(bits, generatorPolys, scramblerSeed, numCarriers, numSymbols, constellation, pilotSequence, NFFT, pilotCarrier, cpLength, doInterleave)

    encodedBits = tx.convolutionalEncoder(bits, generatorPolys);
    
    [scrambledBits, ~] = tx.scrambler(encodedBits, scramblerSeed);
        
    if nargsin == 10 && doInterleave
        interleavedBits = tx.interleaver(scrambledBits, numCarriers, numSymbols);
    else
        interleavedBits = scrambledBits;
    end
    
    modulatedSignal = tx.modulatorDnPSK(interleavedBits, constellation, numSymbols, numCarriers, pilotSequence);
   
    txSignal = tx.muxOFDM(modulatedSignal, pilotCarrier, numCarriers+1, NFFT, cpLength, numSymbols);
end
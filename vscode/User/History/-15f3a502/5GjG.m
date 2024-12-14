function txSignal = fullTransmitter(bits, generatorPolys, scramblerSeed, numCarriers, numSymbols, constellation, NFFT, firstCarrier, cpLength, doInterleave)

    encodedBits = tx.convolutionalEncoder(bits, generatorPolys);
    
    [scrambledBits, ~] = tx.scrambler(encodedBits, scramblerSeed);
        
    if nargsin == 10 && doInterleave
        interleavedBits = tx.interleaver(scrambledBits, numCarriers, numSymbols);
    else
        interleavedBits = scrambledBits;
    end
    
    modulatedSignal = tx.modulatorDnPSK(interleavedBits, constellation);
   
    txSignal = tx.muxOFDM(modulatedSignal, numCarriers, NFFT, firstCarrier, cpLength, numSymbols);
end
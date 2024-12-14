function decodedBits = fullReceiver(rxSignal, numCarriers, h, numSymbols, NFFT, firstCarrier, cpLength, constellation, scramblerSeed, generatorPolys, doDeinterleave)
    demuxedSignal = rx.demuxOFDM(rxSignal, numCarriers, h, NFFT, firstCarrier, cpLength, numSymbols);

    demodulatedBits = rx.demodulatorDnPSK(demuxedSignal, constellation);

    if 

        deinterleavedBits = rx.deinterleaver(demodulatedBits, numCarriers, numSymbols);
    
    [descrambledBits, ~] = rx.descrambler(deinterleavedBits, scramblerSeed);
        
    decodedBits = rx.convolutionalDecoder(descrambledBits, generatorPolys);    
end
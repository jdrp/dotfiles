function decodedBits = fullReceiver(rxSignal, nCarriers, numSymbols, NFFT, firstCarrier, cpLength, constellation, seed, generatorPolys)
    
    demuxedSignal = rx.demuxOFDM(rxSignal, nCarriers, NFFT, firstCarrier, cpLength);

    demodulatedBits = rx.demodulatorDnPSK(demuxedSignal, constellation);
    
    deinterleavedBits = rx.deinterleaver(demodulatedBits, nCarriers, numSymbols);
    
    [descrambledBits, ~] = rx.descrambler(deinterleavedBits, seed);

    decodedBits = rx.convolutionalDecoder(descrambledBits, generatorPolys);    
end
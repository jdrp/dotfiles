function decodedBits = fullReceiver(rxSignal, numCarriers, h, numSymbols, NFFT, firstCarrier, cpLength, constellation, scramblerSeed, generatorPolys)
    demuxedSignal = rx.demuxOFDM(rxSignal, numCarriers, h, NFFT, firstCarrier, cpLength, numSymbols);

    scatter(demuxedSignal)
    demodulatedBits = rx.demodulatorDnPSK(demuxedSignal, constellation);

    if scramblerSeed ~= [1]
        deinterleavedBits = rx.deinterleaver(demodulatedBits, numCarriers, numSymbols);
    
        [descrambledBits, ~] = rx.descrambler(deinterleavedBits, scramblerSeed);
    else
        descrambledBits = demodulatedBits;
    end
        
    decodedBits = rx.convolutionalDecoder(descrambledBits, generatorPolys);    
end
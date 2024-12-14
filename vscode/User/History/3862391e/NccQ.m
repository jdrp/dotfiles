function decodedBits = fullReceiver(rxSignal, numCarriers, h, numSymbols, NFFT, firstCarrier, cpLength, constellation, seed, generatorPolys)
    demuxedSignal = rx.demuxOFDM(rxSignal, numCarriers, h, NFFT, firstCarrier, cpLength, numSymbols);

    demodulatedBits = rx.demodulatorDnPSK(demuxedSignal, constellation);

    if scramblerSeed ~= [1]
        deinterleavedBits = rx.deinterleaver(demodulatedBits, numCarriers, numSymbols);
    
        [descrambledBits, ~] = rx.descrambler(deinterleavedBits, seed);

        decodedBits = rx.convolutionalDecoder(descrambledBits, generatorPolys);    
    else
        decodedBits = demodulatedBits;
    end
end
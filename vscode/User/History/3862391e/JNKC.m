function decodedBits = fullReceiver(rxSignal, numCarriers, h, numSymbols, NFFT, pilotCarrier, cpLength, constellation, pilotSequence, scramblerSeed, generatorPolys, doDeinterleave, doEq)

    demuxedSignal = rx.demuxOFDM(rxSignal, numCarriers+1, h, NFFT, pilotCarrier, cpLength, numSymbols);
    demodulatedBits = rx.demodulatorDnPSK(demuxedSignal, constellation, numSymbols, numCarriers);
    if nargin == 12 && doDeinterleave
        deinterleavedBits = rx.deinterleaver(demodulatedBits, numCarriers, numSymbols);
    else
        deinterleavedBits = demodulatedBits;
    end

    [descrambledBits, ~] = rx.descrambler(deinterleavedBits, scramblerSeed);
        
    decodedBits = rx.convolutionalDecoder(descrambledBits, generatorPolys);    
end

print
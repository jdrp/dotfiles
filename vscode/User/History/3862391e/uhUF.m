function decodedBits = fullReceiver(rxSignal, numCarriers, h, numSymbols, NFFT, firstCarrier, cpLength, constellation, scramblerSeed, generatorPolys, doDeinterleave)
    % TODO arreglar esto con los pilotos :/
    
    demuxedSignal = rx.demuxOFDM(rxSignal, numCarriers, h, NFFT, firstCarrier, cpLength, numSymbols);

    demodulatedBits = rx.demodulatorDnPSK(demuxedSignal, constellation);

    if nargin == 11 && doDeinterleave
        deinterleavedBits = rx.deinterleaver(demodulatedBits, numCarriers, numSymbols);
    end

    [descrambledBits, ~] = rx.descrambler(deinterleavedBits, scramblerSeed);
        
    decodedBits = rx.convolutionalDecoder(descrambledBits, generatorPolys);    
end
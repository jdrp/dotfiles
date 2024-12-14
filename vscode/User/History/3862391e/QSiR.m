function decodedBits = fullReceiver(rxSignal, numCarriers, h, numSymbols, NFFT, pilotCarrier, cpLength, constellation, pilotSequence, scramblerSeed, generatorPolys, doDeinterleave)
    % TODO arreglar esto con los pilotos :/
    %display(rxSignal(1:10))
    demuxedSignal = rx.demuxOFDM(rxSignal, numCarriers+1, h, NFFT, pilotCarrier, cpLength, numSymbols);
    display(demuxedSignal(1:10))
    display(size(demuxedSignal))
    demodulatedBits = rx.demodulatorDnPSK(demuxedSignal, constellation, numSymbols, numCarriers);
    
    if nargin == 11 && doDeinterleave
        deinterleavedBits = rx.deinterleaver(demodulatedBits, numCarriers, numSymbols);
    else
        deinterleavedBits = demodulatedBits;
    end

    [descrambledBits, ~] = rx.descrambler(deinterleavedBits, scramblerSeed);
        
    decodedBits = rx.convolutionalDecoder(descrambledBits, generatorPolys);    
end
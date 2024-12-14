function demodulatedSignal = demuxOFDM(signal, nCarriers, h, NFFT, firstCarrier, cpLength)
    if nargin < 5
        cpLength = 0;
    end

    symbolLength = NFFT + cpLength;
    
    % Remove cyclic prefix
    symbolLength
    length(signal)/symbolLength
    length(signal)
    y = reshape(signal, symbolLength, length(signal)/symbolLength);
    y = y(cpLength+1:end, :);
    
    % Frequency domain
    Y = fft(y, NFFT);

    Nofdm = length(y) / nCarriers;
    Nofdm
    % Ideal channel frequency response
    H = fft(h, NFFT);
        
    % Frequency domain equalization
    Y_eq = Y ./ repmat(H, 1, Nofdm);


    % Extract positive spectrum
    demod = Y_eq(firstCarrier:firstCarrier+nCarriers-1,:);

    demodulatedSignal = demod(:).';
end
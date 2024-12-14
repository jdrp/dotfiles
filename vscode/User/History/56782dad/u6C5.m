function demodulatedSignal = demuxOFDM(signal, nCarriers, h, NFFT, firstCarrier, cpLength, Nofdm)
    if nargin < 5
        cpLength = 0;
    end

    symbolLength = NFFT + cpLength;
    
    % Remove cyclic prefix
    y = reshape(signal, symbolLength, length(signal)/symbolLength);
    y = y(cpLength+1:end, :);
    
    % Frequency domain
    Y = fft(y, NFFT);

    % Nofdm = size(y,1) / nCarriers;
    % size(y)
    % size(signal)
    % Ideal channel frequency response
    H = fft(h, NFFT);
        
    % Frequency domain equalization
    Y_eq = Y ./ repmat(H, 1, Nofdm);


    % Extract positive spectrum
    demod = Y_eq(firstCarrier:firstCarrier+nCarriers-1,:);

    demodulatedSignal = demod(:).';
end
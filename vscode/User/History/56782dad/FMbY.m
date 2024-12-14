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

    % Ideal channel frequency response
    H = fft(h, NFFT).';
    
    % Frequency domain equalization
    Y_eq = Y ./ repmat(H, 1, Nofdm);

    % Extract positive spectrum with pilot
    demod = Y_eq(firstCarrier:firstCarrier+nCarriers-1,:);

    demodulatedSignal = conj(demod(:)');
    %demodulatedSignal = demod(:)';
end
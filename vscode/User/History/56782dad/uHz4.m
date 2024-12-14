
function demodulatedSignal = demuxOFDM(signal, nCarriers, NFFT, firstCarrier, cpLength)
    if nargin < 5
        cpLength = 0;
    end

    symbolLength = NFFT + cpLength;
    
    % Remove cyclic prefix
    y = reshape(signal, symbolLength, length(signal)/symbolLength);
    y = y(cpLength+1:end, :);
    
    % Frequency domain
    Y = fft(y, NFFT);
    % Extract positive spectrum
    demod = Y(firstCarrier:firstCarrier+nCarriers-1,:);

    demodulatedSignal = demod(:).';
end
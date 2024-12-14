function modulatedSignal = muxOFDM(signal, nCarriers, pilotSequence, NFFT, firstCarrier, cpLength, Nofdm)
    if nargin < 5
        cpLength = 0;
    end

    % Number of OFDM symbols
    % Nofdm = length(signal) / nCarriers

    mod = reshape(signal, nCarriers, Nofdm);
    % Spectral coefficient vector
    X = zeros(NFFT, Nofdm);
    % Positive spectrum
    X(firstCarrier : firstCarrier+size(mod, 1)-1, :) = mod;
    % Negative spectrum (reverse and conjugate)
    X(NFFT/2+2:end, :) = flipud(conj(X(2:NFFT/2, :)));

    % Convert to time domain
    x = ifft(X, NFFT); % Transmitted signal, it has to be real

    % Apply cyclic prefix to each symbol
    cp = x(end-cpLength+1:end, :);
    modulatedSignal = [cp; x];
    modulatedSignal = modulatedSignal(:);
end
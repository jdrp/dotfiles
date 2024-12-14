function modulatedSignal = muxOFDM(signal, nCarriers, NFFT, firstCarrier, cpLength)
    if nargin < 5
        cpLength = 0;
    end

    % Number of OFDM symbols
    Nofdm = length(signal) / nCarriers;
    
    mod = reshape(signal, nCarriers, Nofdm);
    % Spectral coefficient vector
    X = zeros(NFFT, Nofdm);
    % Positive spectrum
    X(firstCarrier:firstCarrier+size(mod, 1)-1,:) = mod;
    % Negative spectrum (reverse and conjugate)
    X(NFFT/2+2:end,:) = flipud(conj(X(2:NFFT/2,:)));

    % Convert to time domain
    x = ifft(X, NFFT); % Transmitted signal, it has to be real

    % Cyclic prefix
    tx = reshape(x, 1, []);
    size(x)
    size(tx)
    modulatedSignal = [tx(end-cpLength+1:end), tx];
end
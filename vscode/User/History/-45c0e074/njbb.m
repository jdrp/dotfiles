function modulatedSignal = muxOFDM(signal, Nf, m_ary, NFFT, firstCarrier, cpLength)
    if nargin < 6
        cpLength = 0;
    end
    length(signal)
    Nofdm = length(signal) / Nf;
    Nofdm
    Nf
    length(signal)
    mod = reshape(signal, Nf, Nofdm);
    % Spectral coefficient vector
    X = zeros(NFFT, Nofdm);
    % Positive spectrum
    X(firstCarrier:firstCarrier+size(mod, 1),:) = mod;
    % Negative spectrum (reverse and conjugate)
    X(NFFT/2+2:NFFT,:) = flipud(conj(X(2:NFFT/2,:)));

    % Convert to time domain
    x = ifft(X, NFFT) % Transmitted signal, it has to be real

    % Cyclic prefix
    tx = reshape(x, 1, []);
    modulatedSignal = [tx(end-cpLength+1:end), tx];
end
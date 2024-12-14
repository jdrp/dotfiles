function modulatedSignal = muxOFDM(signal, Nf, Nofdm, NFFT, firstCarrier, cpLength)
    if nargin < 6
        cpLength = 0;
    end

    mod = reshape(signal, Nf, Nofdm);
    % Spectral coefficient vector
    X = zeros(NFFT, Nofdm);
    % Positive spectrum
    X(firstCarrier:firstCarrier+size(mod, 1),:) = mod;
    % Negative spectrum (reverse )
    X(NFFT/2+2:NFFT,:) = flipud(conj(X(2:NFFT/2,:)));

    % Generación del vector de muestras temporales reales x como resultado de la modulación OFDM. Léase la documentación de las funciones IFFT y FFT de MATLAB
    x = ifft(X, NFFT); % Transmitted signal, it has to be real

    % Cyclic prefix
    tx = reshape(x, 1, []);
    modulatedSignal = [tx(end-cpLength+1:end), tx];
end
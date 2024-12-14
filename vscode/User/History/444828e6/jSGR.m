function modulaConRuido(bits, modulator, SNR_dB, modulation, M)
    numBits = length(bits);
    bitsPerSymbol = log2(M);
    numSymbols = numBits / bitsPerSymbol;

    % aplicar modulacion
    modulatedSymbols = modulator(bits);

    % asignar a cada simbolo un color
    symbolColors = lines(M);
    colors = zeros(numSymbols, 3);
    for i = 1:numSymbols
        % convertir los bits del simbolo a su valor decimal para elegir el color
        colors(i,:) = symbolColors(bit2int(bits((i-1)*bitsPerSymbol+1 : i*bitsPerSymbol), bitsPerSymbol, 0) + 1, :);
    end

    figure;
    hold on;
    grid on;
    % dibujar simbolos con cada nivel de ruido
    for i = 1:length(SNR_dB)
        noisySymbols = awgn(modulatedSymbols, SNR_dB(i), 'measured');
        % transparencia segun snr
        alphaValue = (SNR_dB(i) / max(SNR_dB));
        scatter(real(noisySymbols), imag(noisySymbols), 20, colors, 'filled', 'MarkerFaceAlpha', alphaValue, 'HandleVisibility', 'off');
    end

    xlabel('I');
    ylabel('Q');
    title('Diferentes SNR en ' + modulation);
    axis equal;
    xlim([-2 2]);
    ylim([-2 2]);

    % ejes en 0
    plot(xlim, [0 0], 'k:', 'HandleVisibility', 'off');
    plot([0 0], ylim, 'k:', 'HandleVisibility', 'off');

    % leyenda para el color de cada par de bits
    for k = 1:M
        scatter(NaN, NaN, 100, symbolColors(k, :), 'filled', 'DisplayName', int2bit(k-1, bitsPerSymbol));
    end

    % entrada en blanco
    scatter(NaN, NaN, 'w', 'DisplayName', ' ');

    % leyenda para el nivel de ruido (transparencia)
    for i = length(SNR_dB):-1:1
        scatter(NaN, NaN, 100, [0.5 0.5 0.5], 'filled', 'MarkerFaceAlpha', (SNR_dB(i) / max(SNR_dB)), ...
            'DisplayName', [num2str(SNR_dB(i)) ' dB']);
    end

    legend('Location', 'best');
    hold off;
    
end

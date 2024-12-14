function modulaConRuido(bits, modulador, SNR_dB, modulation)
    numBits = length(bits);
    
    % aplicar modulacion
    modulatedSymbols = modulador(bits);

    % asignar a cada simbolo un color
    symbolColors = lines(4);
    colors = zeros(numBits/2, 3);
    for i = 1:numBits/2
        colors(i,:) = symbolColors(2 * bits(2*i-1) + bits(2*i) + 1, :);
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
    scatter(NaN, NaN, 100, symbolColors(4,:), 'filled', 'DisplayName', '11');
    scatter(NaN, NaN, 100, symbolColors(3,:), 'filled', 'DisplayName', '10');
    scatter(NaN, NaN, 100, symbolColors(2,:), 'filled', 'DisplayName', '01');
    scatter(NaN, NaN, 100, symbolColors(1,:), 'filled', 'DisplayName', '00');

    scatter(NaN, NaN, 'w', 'DisplayName', ' '); % Entrada en blanco

    % leyenda para el nivel de ruido (transparencia)
    for i = 1:length(SNR_dB)
        scatter(NaN, NaN, 100, [0.5 0.5 0.5], 'filled', 'MarkerFaceAlpha', (SNR_dB(i) / max(SNR_dB)), ...
            'DisplayName', [num2str(SNR_dB(i)) ' dB']);
    end

    legend('Location', 'best');
    hold off;
    
end

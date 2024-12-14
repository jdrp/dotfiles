function modulaConRuido(bits, modulador, SNR_dB, modulation)
    numBits = length(bits);

    % Inicializar lista de colores
    %colors = zeros(numBits/2, 3); % Para almacenar RGB
    symbolColors = lines(4);
    colors = zeros(numBits/2, 3);
    size(symbolColors)
    % Asignar colores a los símbolos originales sin ruido
    for i = 1:numBits/2
        colors(i,:) = symbolColors(2 * bits(2*i-1) + bits(2*i) + 1, :);
    end

    figure;
    hold on;
    grid on;
    modulatedSymbols = modulador(bits);
    % Visualización para diferentes SNR
    for i = 1:length(SNR_dB)
        % Añadir ruido blanco gaussiano
        noisySymbols = awgn(modulatedSymbols, SNR_dB(i), 'measured');
        
        % Transparencia según SNR
        alphaValue = (SNR_dB(i) / max(SNR_dB)); % Más SNR -> más transparente
        
        % Crear scatter plot con el color correspondiente y transparencia
        scatter(real(noisySymbols), imag(noisySymbols), 20, colors, 'filled', 'MarkerFaceAlpha', alphaValue, 'HandleVisibility', 'off');
    end

    % Añadir elementos al gráfico
    xlabel('I');
    ylabel('Q');
    title('Diferentes SNR en ' + modulation);
    axis equal;

    % Ajustar límites del eje
    xlim([-2 2]);
    ylim([-2 2]);

    % Añadir líneas de referencia
    plot([-2 2], [0 0], 'k:', 'HandleVisibility', 'off');
    plot([0 0], [-2 2], 'k:', 'HandleVisibility', 'off');

    % Leyenda para los bits de entrada (colores sin transparencia)
    scatter(NaN, NaN, 100, symbolColors(4), 'filled', 'DisplayName', '11');
    scatter(NaN, NaN, 100, symbolColors(3), 'filled', 'DisplayName', '10');
    scatter(NaN, NaN, 100, symbolColors(2), 'filled', 'DisplayName', '01');
    scatter(NaN, NaN, 100, symbolColors(1), 'filled', 'DisplayName', '00');

    % Leyenda para la transparencia (escala de grises para SNR)
    for i = 1:length(SNR_dB)
        scatter(NaN, NaN, 100, [0.5 0.5 0.5], 'filled', 'MarkerFaceAlpha', (SNR_dB(i) / max(SNR_dB)), ...
            'DisplayName', ['SNR = ' num2str(SNR_dB(i)) ' dB']);
    end

    % Mostrar leyenda
    legend('Location', 'best');
    hold off;
    
end

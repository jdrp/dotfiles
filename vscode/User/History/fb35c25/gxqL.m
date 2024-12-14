function symbols = modularSimbolos(bits, modulator, modulation)  
    % aplicar modulacion
    symbols = modulator(bits);
    
    % representacion de los simbolos
    scatter(real(symbols), imag(symbols), 'bx')
    title("Símbolos " + modulation)
    xlabel('I')
    ylabel('Q')
    grid on;
    axis equal;
    hold on;

    % etiquetar cada simbolo con su par de bits correspondiente
    bits = reshape(bits, 2, []);
    for i = 1:length(symbols)
        text(real(symbols(i)), imag(symbols(i)), sprintf('%d%d', bits(1, i), bits(2, i)), 'VerticalAlignment', 'bottom', 'HorizontalAlignment', 'right');
    end

    xlim([-1.5 1.5])
    ylim([-1.5 1.5])

    % Dibujar los ejes en x=0 y y=0
    line(xlim, [0 0], 'Color', 'k', 'LineStyle', '-'); % Eje Y
    line([0 0], ylim, 'Color', 'k', 'LineStyle', '-'); % Eje X
    
    axis manual;
    hold off;
end

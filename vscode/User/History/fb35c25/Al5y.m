function [] = plotConstelacion(symbols, title)  
    % Representación de los símbolos
    scatter(real(symbols), imag(symbols), 'bx')
    title('Símbolos QPSK')
    xlabel('I')
    ylabel('Q')
    grid on;
    axis equal;
    hold on;
    % Añadir las etiquetas a cada punto
    for i = 1:length(symbols)
        text(real(modulated_symbols(i)), imag(modulated_symbols(i)), sprintf('%d%d', bits(i, 1), bits(i, 2)), 'VerticalAlignment', 'bottom', 'HorizontalAlignment', 'right');
    end
    % Ajustar los límites de los ejes para hacer zoom out     %%% TODO arreglar limites
    xlim([-1.5 1.5])
    ylim([-1.5 1.5])
    % Dibujar los ejes en x=0 y y=0
    plot(xlim, [0 0], 'Color', 'k', 'LineStyle', '-'); % Eje Y
    plot([0 0], ylim, 'Color', 'k', 'LineStyle', '-'); % Eje X
    hold off;
end
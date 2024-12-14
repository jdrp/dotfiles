function graficaBER(EbNo_dB, BER, BER_teor, modulations, title)
    figure;
    hold on;

    colors = lines(size(BER, 1)); % Generar colores distintos para cada modulación

    for i = 1:length(modulators)
        semilogy(EbNo_dB, BER_teor(i,:), '-', 'Color', colors(i,:), 'DisplayName', sprintf('%s Teórica', modulations{i}));
        semilogy(EbNo_dB, BER(i,:), 'o', 'Color', colors(i,:), 'DisplayName', sprintf('%s Simulada', modulations{i}));
    end

    grid on;
    xlabel("EbNo (dB)");
    ylabel("BER");
    title(title);
    set(gca, 'YScale', 'log')
    legend('show');
    hold off;
end
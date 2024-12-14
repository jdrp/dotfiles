function graficaBER(EbNo_dB, BER, BER_teor, modulations, plot_title)
    figure;
    hold on;

    colors = lines(length(modulations)); % Generar colores distintos para cada modulación

    for i = 1:length(modulations)
        length(BER_teor)
        if isempty(BER_teor) || length(BER_teor) < i || isempty(BER_teor(i,:))
            semilogy(EbNo_dB, BER(i,:), 'o--', 'Color', colors(i,:), 'DisplayName', modulations{i});
        else
            semilogy(EbNo_dB, BER_teor(i,:), '-', 'Color', colors(i,:), 'DisplayName', sprintf('%s Teórica', modulations{i}));
            semilogy(EbNo_dB, BER(i,:), 'o--', 'Color', colors(i,:), 'DisplayName', sprintf('%s Simulada', modulations{i}));
        end
    end

    grid on;
    xlabel("EbNo (dB)");
    ylabel("BER");
    title(plot_title);
    set(gca, 'YScale', 'log')
    legend('show');
    hold off;
end
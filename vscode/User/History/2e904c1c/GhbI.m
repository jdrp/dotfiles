function compararBERVariasModulaciones(modulators, demodulators, BER_teor, modulations, EbNo_dB, N, phaseOffset)
    numBits = N;
    bits = randi([0 1], 1, numBits);
    k = log2(4); % Número de bits por símbolo
    SNR_dB = EbNo_dB + 10*log10(k);
  
    modulatedSymbols = zeros(length(modulators), length(bits)/2);
    BER = zeros(length(modulators), length(EbNo_dB));

    for i = 1:length(modulators)
        modulatedSymbols(i,:) = modulators{i}(bits);
    end

    for i = 1:length(EbNo_dB)
        noisySymbols = zeros(length(modulators), size(modulatedSymbols, 2));
        for j = 1:length(modulators)
            noisySymbols(j,:) = awgn(modulatedSymbols(j,:), SNR_dB(i), 'measured');
            noisySymbols(j,:) = noisySymbols(j,:) * exp(1j * phaseOffset * (pi/180));
            BER(j, i) = calcularBER(bits, noisySymbols(j,:), demodulators{j});
        end
    end

    %plotBER(EbNo_dB, BER, BER_teor, )

    figure;
    hold on;

    colors = lines(length(modulations)); % Generar colores distintos
    % Crear gráfico con colores diferentes para cada modulación
    for i = 1:length(BER)
        semilogy(EbNo_dB, BER_teor(i,:), '-', 'DisplayName', sprintf('%s Teórica', modulations{i}));
        semilogy(EbNo_dB, BER(i,:), 'o', 'Color', colors(i,:), 'DisplayName', sprintf('%s Simulada', modulations{i}));
    end

    grid on;
    xlabel("EbNo (dB)");
    ylabel("BER");
    if phaseOffset == 0
        title("Nivel de error para diferentes modulaciones y SNR");
    else
        title(sprintf("Nivel de error con error de fase de %dº", phaseOffset));
    end 
    set(gca, 'YScale', 'log')
    legend('show');
    hold off;
end

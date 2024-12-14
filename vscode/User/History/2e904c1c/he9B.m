function compararBERVariasModulaciones(modulators, demodulators, BER_teor, modulations, EbNo_dB, N, phaseOffset)
    numBits = N;
    bits = randi([0 1], 1, numBits); % secuencia aleatoria
    k = log2(4); % numero de bits por simbolo
    SNR_dB = EbNo_dB + 10*log10(k);
  
    modulatedSymbols = zeros(length(modulators), length(bits)/2);
    BER = zeros(length(modulators), length(EbNo_dB));

    % modular con cada tipo de modulacion
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

    if phaseOffset == 0
        plot_title = "Tasa de error para diferentes modulaciones y nivel de ruido";
    else
        plot_title = sprintf("Tasa de error con rotación de fase de %dº", phaseOffset);
    end 

    graficaBER(EbNo_dB, BER, BER_teor, modulations, plot_title);

end

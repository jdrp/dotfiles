function plotBER(modulators, demodulators, BER_teor, modulations, EbNo_dB)
    numBits = 100000;
    bits = randi([0 1], 1, numBits);
    k = log2(4); %Numero de bits por simbolo
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
            BER(j, i) = calcularBER(bits, noisySymbols(j,:), demodulators{j});
        end
    end

    hold on;

    for i = 1:length(modulators)
        semilogy(EbNo_dB, BER_teor(i,:), 'b-')
        semilogy(EbNo_dB, BER(i,:), 'bo')
    end

    grid on;
    xlabel("EbNo (dB)");
    ylabel("BER");
    %legend(modulation1 + ' Teórica', modulation1 + ' Simulada', modulation2 + ' Teórica', modulation2 + ' Simulada');
    title("Nivel de error para diferentes modulaciones y SNR");
    set(gca, 'YScale', 'log')
    hold off;
end
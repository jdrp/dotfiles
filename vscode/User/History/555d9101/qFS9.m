function BER = calcularBER(bits, modulated_symbols, demodulador)
    numBits = length(bits);

    % Demodulación QPSK
    demodulatedBits = demodulador(modulated_symbols);

    % Cálculo del BER
    errors = sum(bits ~= demodulatedBits);
    BER = errors/numBits;

    % Mostrar resultados
    fprintf('Número de errores: %d\n', errors);
    fprintf('BER: %f\n', BER);
    
end
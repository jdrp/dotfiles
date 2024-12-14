function BER = calcularBER(bits, modulated_symbols, demodulador)
    numBits = length(bits);

    % Demodulación QPSK
    demodulatedBits = demodulador(modulated_symbols);
    size(demodulatedBits)
    % Cálculo del BER
    errors = sum(bits ~= demodulatedBits);
    BER = errors/numBits;
end
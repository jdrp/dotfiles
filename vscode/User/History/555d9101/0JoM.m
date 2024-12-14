function BER = calcularBER(bits, modulated_symbols, demodulator)
    numBits = length(bits);

    % Demodulación QPSK
    demodulatedBits = demodulator(modulated_symbols);
    
    % Cálculo del BER
    errors = sum(bits ~= demodulatedBits);
    BER = errors/numBits;
end
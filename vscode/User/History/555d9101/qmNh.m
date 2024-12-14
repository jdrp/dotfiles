function BER = calcularBER(bits, modulated_symbols, demodulator)
    % aplicar demodulacion
    demodulatedBits = demodulator(modulated_symbols);
    
    % calcular ber
    errors = sum(bits ~= demodulatedBits);
    BER = errors/length(bits);
end
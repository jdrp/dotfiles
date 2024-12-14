function BER = calcularBER(bits, modulated_symbols, demodulator)
    numBits = length(bits);

    % aplicar demodulacion
    demodulatedBits = demodulator(modulated_symbols);
    
    % calcular ber
    errors = sum(bits ~= demodulatedBits);
    BER = errors/numBits;
end
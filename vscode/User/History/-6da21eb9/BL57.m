function BER = calcularBER(bits, modulated_symbols, demodulator)
    % aplicar demodulacion
    demodulatedBits = demodulator(modulated_symbols);
    
    % calcular ber
    errors = sum(bits ~= demodulatedBits);
    BER = errors/length(bits);

    % mostrar bits
    if length(bits) <= 10
        N = length(bits)
    disp("Bits originales")
    disp()
end
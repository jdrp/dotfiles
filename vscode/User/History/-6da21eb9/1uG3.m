function BER = calcularBER(bits, modulated_symbols, demodulator)
    % aplicar demodulacion
    demodulatedBits = demodulator(modulated_symbols);
    
    % calcular ber
    errors = sum(bits ~= demodulatedBits);
    BER = errors/length(bits);

    % mostrar bits
    if length(bits) <= 10
        N = length(bits);
    else
        N = 10;
    end
    disp("Bits originales")
    disp(bits(1:N))
    disp("Bits demodulados")
    disp(demodulatedBits(1:N))
    printf('BER: ')
    printf(BER)
end
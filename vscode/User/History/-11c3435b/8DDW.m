function bits = detectSequence(dem1, dem2)
    bits = zeros(1, length(dem1));
    for i = 1:length(dem1)
        symb = detectSymbol(dem1(i), dem2(i));
        bits(2*i - 1) = dec2bin(symb, 2);
    end
end
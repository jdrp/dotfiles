function bits = detectSequence(dem1, dem2)
    bits = zeros(1, length(dem1));
    for i = 1:length(dem1)
        if dem1 == -1
        bits(2*i - 1: 2*i) = dec2bin(symb, 2) - '0';
    end
end
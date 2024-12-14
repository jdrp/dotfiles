function bits = detectSequence(dem1, dem2)
    bits = zeros(1, length(dem1));
    for i = 1:length(dem1)
        symb = detectSymbol(dem1(i), dem2(i));
        if symb == 1
            bits(2*i-1:2*i) = [0, 0];
        elseif symb == 2
            bits(2*i-1:2*i) = [0, 1];
            
        elseif symb == 3
            bits(2*i-1:2*i) = [1, 1];
        else
            bits(2*i-1:2*i) = [1, 0];
        end
    end
end
function symb = detectSymbol(dem1, dem2)
    sign1 = sign(dem1);
    sign2 = sign(dem2);
    
    if sign1 == 1 && sign2 == 1
        symb = 1;
    elseif sign1 == 1 && sign2 == -1
        symb = 2;
    elseif sign1 == -1 && sign2 == -1
        symb = 3;
    else
        symb = 4;
    end
end
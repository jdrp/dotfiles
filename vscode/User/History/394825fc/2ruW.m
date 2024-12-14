function symb = detectSymbol(dem1, dem2)
    sign1 = sign(dem1);
    sign2 = sign(dem2);
    
    if sign1 == 1 && sign2 == 1
        symb = 0;
    elseif sign1 == 1 && sign2 == -1
        symb = 1;
    elseif sign1 == -1 && sign2 == -1
        symb = 2;
    else
        symb = 3;
    end
end
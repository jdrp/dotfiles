function symb = detectSymbol(dem1, dem2)
    % Extraer el signo de los coeficientes
    sign1 = sign(dem1);
    sign2 = sign(dem2);
    
    % Estimar el símbolo correspondiente
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
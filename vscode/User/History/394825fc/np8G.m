function symb = detectSymbol(dem1, dem2)
    sign1 = sign(dem1);
    sign2 = sign(dem2);
    
    % S1 = phi1 + phi2; % 1 1
    % S2 = phi1 - phi2; % 1 -1
    % S3 = -phi1 - phi2; % -1 -1
    % S4 = -phi1 + phi2; % -1 1


    if sign1 == 1 && sign2 == 1
        symb = 1
    elseif sign1 == 1 && sign2 == -1
        symb = 2
        
    elseif sign1 == -1 && sign2 == -1
        symb = 3
    else
        symb = 4
    end
end
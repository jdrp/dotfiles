% create a function that takes two values and returns the sign of each one of them

function [sign1, sign2] = detectSymbol(a, b)
    if a > 0
        sign1 = 1;
    elseif a < 0
        sign1 = -1;
    else
        sign1 = 0;
    end
    
    if b > 0
        sign2 = 1;
    elseif b < 0
        sign2 = -1;
    else
        sign2 = 0;
    end
end
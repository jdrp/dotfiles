function [S1, S2] = generateBase(T, Ts)
    symbolLength = floor(T/Ts);
    S1 = [ones(1, ceil(symbolLength/2)), zeros(1, floor(symbolLength/2))];
    S2 = [zeros(1, ceil(symbolLength/2)), ones(1, floor(symbolLength/2))];
    S1 = S1 / sqrt(T);
    S2 = S2 / sqrt(T);
end
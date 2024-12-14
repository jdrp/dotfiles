function [dem1, dem2] = demodulateSignal(Sin, T, Ts)
    Lsymb = T / Ts;
    N = length(Sin) / Lsymb;
    N
    dem1 = zeros(1, N);
    dem2 = zeros(1, N);
    
    for i = 1:N    
        [dem1(i), dem2(i)] = demodulateSymbol(T, Ts, Sin(1 + (i-1)*Lsymb: i*Lsymb));
    end
    


end 
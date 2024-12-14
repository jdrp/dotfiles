function [o1pred, o2pred] = demodulateSignal(Sin, T, Ts)
    Lsymb = T / Ts;
    N = length(Sin / Lsymb);
    
    rx_1 = zeros(1, N);
    rx_2 = zeros(1, N);
    
    for i = 1:N    
        [rx_1(i), rx_2(i)] = demodulateSymbol(T, Ts, Sin(1 + (i-1)*Lsymb: i*Lsymb));
    end

end 
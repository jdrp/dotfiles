function [o1pred, o2pred] = demodulateSignal(Sin, T, Ts)
    Lsymb = T / Ts;
    N = length(Sin / Lsymb);
    rx_11 = zeros(1, N);
    rx_12 = zeros(1, N);
    
    for i = 1:N    
        [rx_11(i), rx_12(i)] = demodulateSymbol(T, Ts, Sin1);
    end
end 
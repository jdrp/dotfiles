function [o1pred, o2pred] = demodulateSignal(Sin, T, Ts)
    Lsymb = T / Ts;
    N = length(Sin / Lsymb);
    for i = 1:N    
        [rx_11(i), rx_12(i)] = demodulateSymbol(T, Ts, Sin1);
        [rx_21(i), rx_22(i)] = demodulateSymbol(T, Ts, Sin2);
    end
end 
function [o1pred, o2pred] = demodulateSymbol(T, Ts, r)
    [o1, o2] = correlatorType(T, Ts, r);
    
    o1pred = o1(end);
    o2pred = o2(end);    
end
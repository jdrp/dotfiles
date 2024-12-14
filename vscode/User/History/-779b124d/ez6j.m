function [o1pred, o2pred] = demodulateSymbol(T, Ts, r)
    % Llamar a la función correlatorType para obtener o1 y o2
    [o1, o2] = correlatorType(T, Ts, r);
    
    % Obtener el último valor de o1 y o2 como predicciones
    o1pred = o1(end);
    o2pred = o2(end);    
end
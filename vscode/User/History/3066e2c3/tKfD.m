function [dem1, dem2] = demodulateSignal(Sin, T, Ts)
    % Calcula el numero total de simbolos en la senyal de entrada
    Lsymb = T / Ts;
    N = length(Sin) / Lsymb;
    
    % Inicializa los vectores de salida
    dem1 = zeros(1, N);
    dem2 = zeros(1, N);
    
    % Recorre cada simbolo en la senyal de entrada y lo demodula
    for i = 1:N
        [dem1(i), dem2(i)] = demodulateSymbol(T, Ts, Sin(1 + (i-1)*Lsymb: i*Lsymb));
    end
end
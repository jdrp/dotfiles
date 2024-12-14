function [dem1, dem2] = demodulateSignal(Sin, T, Ts)
    % Calcula la longitud de un símbolo en función del tiempo de símbolo y
    % la tasa de muestreo
    Lsymb = T / Ts;
    
    % Calcula el número total de símbolos en la señal de entrada
    N = length(Sin) / Lsymb;
    
    % Inicializa los vectores de salida para almacenar los resultados de la
    % demodulación de cada símbolo
    dem1 = zeros(1, N);
    dem2 = zeros(1, N);
    
    % Recorre cada símbolo en la señal de entrada y lo demodula
    for i = 1:N    
        % Extrae cada símbolo de la señal de entrada y lo demodula
        % Se toma un segmento de la señal Sin que corresponde a un símbolo
        [dem1(i), dem2(i)] = demodulateSymbol(T, Ts, Sin(1 + (i-1)*Lsymb: i*Lsymb));
    end
end

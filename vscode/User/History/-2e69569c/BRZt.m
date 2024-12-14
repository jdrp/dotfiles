function [o1, o2] = correlatorType(T, Ts, r)
    % Generar señales base
    [phi1, phi2] = generateBase(T, Ts);

    % Inicializar vectores de salida
    o1 = zeros(1, length(r));
    o2 = zeros(1, length(r));

    % Correlar la señal de entrada con ambas bases e ir acumulando el resultado
    o1(1) = r(1) * phi1(1) * Ts;
    o2(1) = r(1) * phi2(1) * Ts;
    for i = 2:length(r)
        o1(i) = o1(i-1) + r(i) * phi1(i) * Ts;
        o2(i) = o2(i-1) + r(i) * phi2(i) * Ts;
    end
end
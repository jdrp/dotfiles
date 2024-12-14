function [o1, o2] = correlatorType(T, Ts, r)
    % Generar señales base phi1 y phi2
    [phi1, phi2] = generateBase(T, Ts);
    try 
        % Inicializar matrices de salida con ceros
        o1 = zeros(1, length(r));
        o2 = zeros(1, length(r));
        
        % Calcular los primeros elementos de las matrices de salida
        o1(1) = r(1) * phi1(1) * Ts;
        o2(1) = r(1) * phi2(1) * Ts;
        
        % Calcular los elementos restantes de las matrices de salida
        for i = 2:length(r)
            o1(i) = o1(i-1) + r(i) * phi1(i) * Ts;
            o2(i) = o2(i-1) + r(i) * phi2(i) * Ts;
        end
  
    catch exception
        % Mostrar mensaje de error si ocurre una excepción
        disp(exception.message);
    end
end
function signal_vector = generate_modulated_signals(N, Ts)
    % Definición de parámetros
    T = 10e-3; % 10 ms
    t = 0:Ts:T; % Vector de tiempo para una señal S1(t) o S2(t)

    % Generación de señales S1(t) y S2(t)
    S1 = ones(1, length(t)); % Señal S1(t) = 1 en [0, T]
    S2 = [ones(1, floor(length(t)/2)), -ones(1, ceil(length(t)/2))]; % Señal S2(t) = 1 en [0, T/2], -1 en [T/2, T]

    % Generar vector de símbolos aleatorios X
    alphabet = [1, -1]; % Alfabeto de símbolos [+1, -1]
    X = alphabet(randi([1, 2], 1, N)); % Vector de símbolos aleatorios X

    % Generación de la señal modulada según el vector X
    signal_vector = []; % Vector que almacenará la señal concatenada
    for i = 1:N
        if X(i) == 1
            signal_vector = [signal_vector, S1];
        else
            signal_vector = [signal_vector, S2];
        end
    end

    % Representación gráfica de la señal concatenada
    time_vector = 0:Ts:(length(signal_vector)-1)*Ts;
    figure;
    plot(time_vector, signal_vector, 'LineWidth', 2);
    xlabel('Tiempo (s)');
    ylabel('Amplitud');
    title('Señal Modulada');
    grid on;
end
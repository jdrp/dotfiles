function test_guard()


    % PREGUNTA 2

    % Transmitir a través del canal
    s_rx = conv(s, h);
    s_rx = s_rx(1:length(s));

    % Gráfica de la señal OFDM recibida
    figure;
    plot_ofdm_signal(s_rx, NFFT, l_cp, 3, "Señal OFDM recibida")


    % PREGUNTA 3

    % Remodelar la señal recibida
    x_cp_rx = reshape(s_rx, NFFT + l_cp, Nofdm);

    % Eliminar el intervalo de guarda
    x_rx = x_cp_rx(l_cp+1:end, :);

    % plot this
    figure;
    plot_ofdm_signal(x_rx(:), NFFT, 0, 3, "Señal OFDM recibida sin intervalo de guarda")


    % PREGUNTA 4

    % Demodulación OFDM (FFT)
    X_rx = fft(x_rx, NFFT);

    size(X_rx)
    size(repmat(H, 1, Nofdm))

    % Ecualización en el dominio de frecuencia
    X_rx_eq = X_rx ./ repmat(H, 1, Nofdm);
    x_rx_eq = ifft(X_rx_eq, NFFT);

    % plot
    figure;
    plot_ofdm_signal(x_rx_eq(:), NFFT, 0, 3, "Señal OFDM ecualizada")
    hold on;
    % put in another color
    plot_ofdm_signal(x, NFFT, 0, 3, "Señal OFDM sin ecualizar", "r")
    legend("Ecualizada", "Original")
    hold off;


    % PREGUNTA 5

    % Extraer las subportadoras de datos
    received_data = X_rx_eq(29:29+Nf-1, :);
    received_data = received_data(:);

    % Demodulación QPSK
    received_bits = demoduladorQPSK(received_data)';

    % Calcular BER
    num_errors = sum(bits ~= received_bits);
    bit_error_rate = num_errors / numBits;
    fprintf("BER: %f\n", bit_error_rate);

    % Diagrama de constelación
    figure;
    subplot(1,2,1);
    plot(real(mod(:)), imag(mod(:)), "o");
    grid on;
    xlim([-1.5 1.5]);
    ylim([-1.5 1.5]);
    title("Constelación Transmitida");
    xline(0);
    yline(0);
    xlabel("En Fase");
    ylabel("En Cuadratura");
    axis square;

    subplot(1,2,2);
    plot(real(received_data), imag(received_data), "o");
    grid on;
    title("Constelación Recibida");
    xline(0);
    yline(0);
    xlabel("En Fase");
    ylabel("En Cuadratura");
    axis square;
    
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%  PARTE 2: Ecualización %%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% PREGUNTA 1

% Parámetros de OFDM
NFFT = 128;           % Tamaño de FFT
l_cp = 16;             % Longitud del prefijo cíclico
Nofdm = 100;          % Número de símbolos OFDM
Nf = 10;            % Número de subportadoras de datos
m_ary = 4;            % Modulación QPSK

% Respuesta al impulso del canal h[n]
h = [-0.1, 0.3, -0.5, 0.7, -0.9, 0.7, -0.5, 0.3, -0.1]';
H = fft(h, NFFT);

% Generar bits aleatorios
numBits = Nf * Nofdm * log2(m_ary);
bits = randi([0 1], numBits, 1);

% Modulación QPSK
mod = moduladorQPSK(bits);
mod = reshape(mod, Nf, Nofdm);

% Inicializar la matriz de símbolos OFDM
X = zeros(NFFT, Nofdm);

% Mapear símbolos a subportadoras
X(29:29+Nf-1, :) = mod;

% Símbolos inversos y conjugados
X(NFFT/2+2:NFFT,:) = flipud(conj(X(2:NFFT/2,:)));

% Modulación OFDM (IFFT)
x = ifft(X, NFFT);

% Agregar intervalo de guarda lleno de ceros
ofdm_with_guard = [zeros(l_cp, Nofdm); x];

% Convertir matriz a vector columna
s = ofdm_with_guard(:);

% Gráfica de la señal OFDM, poner el prefijo de guarda en rojo
plot_ofdm_signal(s, NFFT, l_cp, 3, "Señal OFDM con ceros de guarda")


% PREGUNTA 2

% Transmitir a través del canal
s_rx = conv(s, h);
s_rx = s_rx(1:length(s));

% Gráfica de la señal OFDM recibida
plot_ofdm_signal(s_rx, NFFT, l_cp, 3, "Señal OFDM recibida")


% PREGUNTA 3

% Remodelar la señal recibida
x_cp_rx = reshape(s_rx, NFFT + l_cp, Nofdm);

% Eliminar el intervalo de guarda
x_rx = x_cp_rx(l_cp+1:end, :);

% plot this
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
received_bits = demoduladorQPSK(received_data);

% Calcular BER
num_errors = sum(bits ~= received_bits);
bit_error_rate = num_errors / numBits;
% fprintf("Caso a) BER con intervalo de guarda en cero: %f\n", bit_error_rate);

% Diagrama de constelación
figure;
subplot(1,2,1);
plot(real(mod), imag(mod), "o");
title("Constelación Transmitida");
xlabel("En Fase");
ylabel("En Cuadratura");
axis square;

subplot(1,2,2);
plot(real(received_data), imag(received_data), "o");
title("Constelación Recibida (Caso a)");
xlabel("En Fase");
ylabel("En Cuadratura");
axis square;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%  PARTE B: Intervalo de guarda con 0 %%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Actualizar l_cp para el Caso b)
l_cp = 4;  % Longitud del prefijo cíclico menor al canal

% Modulación QPSK
mod_b = moduladorQPSK(bits);

% Remodelar símbolos en subportadoras x símbolos OFDM
mod_b = reshape(mod_b, Nf, Nofdm);

% Inicializar la matriz de símbolos OFDM
X_b = zeros(NFFT, Nofdm);

% Mapear símbolos a subportadoras
X_b(2:Nf+1, :) = mod_b;

% Modulación OFDM (IFFT)
x_b = ifft(X_b, NFFT);

% Agregar prefijo cíclico (copia de las últimas l_cp muestras)
cyclic_prefix_b = x_b(end-l_cp+1:end, :);
ofdm_with_cp_b = [cyclic_prefix_b; x_b];

% Serializar los símbolos OFDM
s_b = ofdm_with_cp_b(:);

% Transmitir a través del canal
s_rx_b = conv(s_b, h);
s_rx_b = s_rx_b(1:length(s_b));

% Remodelar la señal recibida
s_rx_matrix_b = reshape(s_rx_b, NFFT + l_cp, Nofdm);

% Eliminar el prefijo cíclico
received_mod_b = s_rx_matrix_b(l_cp+1:end, :);

% Demodulación OFDM (FFT)
Y_b = fft(received_mod_b, NFFT);

% Ecualización en el dominio de frecuencia
Y_eq_b = Y_b ./ repmat(H, 1, Nofdm);

% Extraer las subportadoras de datos
received_data_b = Y_eq_b(2:Nf+1, :);
received_data_b = received_data_b(:);

% Demodulación QPSK
received_bits_b = demoduladorQPSK(received_data_b);

% Calcular BER
num_errors_b = sum(bits ~= received_bits_b);
bit_error_rate_b = num_errors_b / numBits;
fprintf("Caso b) BER con prefijo cíclico corto: %f\n", bit_error_rate_b);

% Diagrama de constelación
figure;
subplot(1,2,1);
plot(real(mod_b), imag(mod_b), "o");
title("Constelación Transmitida");
xlabel("En Fase");
ylabel("En Cuadratura");
axis square;

subplot(1,2,2);
plot(real(received_data_b), imag(received_data_b), "o");
title("Constelación Recibida (Caso b)");
xlabel("En Fase");
ylabel("En Cuadratura");
axis square;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%  PARTE C:  %%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Actualizar l_cp para el Caso c)
l_cp = 16;  % Longitud del prefijo cíclico igual o mayor al canal

% Modulación QPSK
mod_c = moduladorQPSK(bits);

% Remodelar símbolos en subportadoras x símbolos OFDM
mod_c = reshape(mod_c, Nf, Nofdm);

% Inicializar la matriz de símbolos OFDM
X_c = zeros(NFFT, Nofdm);

% Mapear símbolos a subportadoras
X_c(2:Nf+1, :) = mod_c;

% Modulación OFDM (IFFT)
x_c = ifft(X_c, NFFT);

% Agregar prefijo cíclico (copia de las últimas l_cp muestras)
cyclic_prefix_c = x_c(end-l_cp+1:end, :);
ofdm_with_cp_c = [cyclic_prefix_c; x_c];

% Serializar los símbolos OFDM
s_c = ofdm_with_cp_c(:);

% Transmitir a través del canal
s_rx_c = conv(s_c, h);
s_rx_c = s_rx_c(1:length(s_c));

% Remodelar la señal recibida
s_rx_matrix_c = reshape(s_rx_c, NFFT + l_cp, Nofdm);

% Eliminar el prefijo cíclico
received_mod_c = s_rx_matrix_c(l_cp+1:end, :);

% Demodulación OFDM (FFT)
Y_c = fft(received_mod_c, NFFT);

% Ecualización en el dominio de frecuencia
Y_eq_c = Y_c ./ repmat(H, 1, Nofdm);

% Extraer las subportadoras de datos
received_data_c = Y_eq_c(2:Nf+1, :);
received_data_c = received_data_c(:);

% Demodulación QPSK
received_bits_c = demoduladorQPSK(received_data_c);

% Calcular BER
num_errors_c = sum(bits ~= received_bits_c);
bit_error_rate_c = num_errors_c / numBits;
fprintf("Caso c) BER con prefijo cíclico suficiente: %f\n", bit_error_rate_c);

% Diagrama de constelación
figure;
subplot(1,2,1);
plot(real(mod_c), imag(mod_c), "o");
title("Constelación Transmitida");
xlabel("En Fase");
ylabel("En Cuadratura");
axis square;

subplot(1,2,2);
plot(real(received_data_c), imag(received_data_c), "o");
title("Constelación Recibida (Caso c)");
xlabel("En Fase");
ylabel("En Cuadratura");
axis square;
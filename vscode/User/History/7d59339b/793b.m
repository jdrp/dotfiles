%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%  PARTE 1: Convolución Circular %%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Parámetros
N = 64;        % Longitud de x[n], puede ajustarse
Ts = 1e-3;     % Periodo de muestreo

% Generar señal aleatoria x[n]
x = randn(N, 1);

% Calcular su espectro X(k)
X = fftshift(fft(x));

% Vector de frecuencia para graficar
Fs = 1/Ts;
f = linspace(-Fs/2, Fs/2, N);

% Graficar el espectro de x[n]
figure;
plot(f, abs(X));
xlabel("Frecuencia (Hz)’);
ylabel(’|X(k)|’);
title("Espectro de x[n]’);

% Respuesta al impulso del canal h[n]
h = [0, -0.1, 0.3, -0.5, 0.7, -0.9, 0.7, -0.5, 0.3, -0.1, 0]’;

% Llenar con ceros h[n] hasta longitud N
h_padded = [h; zeros(N - length(h), 1)];

% Calcular su espectro H(k)
H = fftshift(fft(h_padded));

% Graficar el espectro de h[n]
figure;
plot(f, abs(H));
xlabel("Frecuencia (Hz)’);
ylabel(’|H(k)|’);
title("Espectro de h[n]’);

% Convolución lineal
y = conv(x, h);

% Calcular su FFT de N puntos
Y = fftshift(fft(y, N));

% Graficar el espectro de y[n]
figure;
plot(f, abs(Y));
xlabel("Frecuencia (Hz)’);
ylabel(’|Y(k)|’);
title("Espectro de y[n] (Convolución Lineal)’);

% Convolución circular
yc = cconv(x, h, N);  % Convolución circular de N puntos

% Calcular su espectro Yc(k)
Yc = fftshift(fft(yc));

% Graficar el espectro de yc[n]
figure;
plot(f, abs(Yc));
xlabel("Frecuencia (Hz)’);
ylabel(’|Y_c(k)|’);
title("Espectro de y_c[n] (Convolución Circular)’);

% Calcular el producto X(k) * H(k)
XH = X .* H;

% Comparación entre X(k)*H(k) y Y(k)
figure;
subplot(2,1,1);
plot(f, abs(XH), f, abs(Y));
xlabel("Frecuencia (Hz)’);
ylabel("Magnitud’);
title("Comparación de X(k)*H(k) y Y(k)’);
legend(’|X(k)*H(k)|’, "|Y(k)|’);

% Comparación entre X(k)*H(k) y Yc(k)
subplot(2,1,2);
plot(f, abs(XH), f, abs(Yc));
xlabel("Frecuencia (Hz)’);
ylabel("Magnitud’);
title("Comparación de X(k)*H(k) y Y_c(k)’);
legend(’|X(k)*H(k)|’, "|Y_c(k)|’);

% Longitud del prefijo cíclico (debe ser >= longitud de h[n]-1)
L = length(h) - 1;

% Construir prefijo cíclico a partir de las últimas L muestras de x[n]
cyclic_prefix = x(end-L+1:end);

% Extender x[n] con prefijo cíclico
x_ext = [cyclic_prefix; x];

% Longitud óptima del prefijo cíclico es L = length(h) - 1 = 10
fprintf("Longitud elegida del prefijo cíclico: %d\n’, L);

% Convolución lineal con la señal extendida
y_ext = conv(x_ext, h);

% Eliminar las primeras L muestras para extraer el resultado de la convolución circular
yc_extracted = y_ext(L+1:L+N);

% Verificar que yc extraído coincide con la convolución circular yc
difference = max(abs(yc - yc_extracted));
fprintf("Diferencia máxima entre yc y yc extraído: %e\n’, difference);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%  PARTE 2: Ecualización %%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Parámetros de OFDM
NFFT = 128;           % Tamaño de FFT
Ncp = 16;             % Longitud del prefijo cíclico (varía según el caso)
Nofdm = 100;          % Número de símbolos OFDM
Nsub = 10;            % Número de subportadoras de datos
modOrder = 4;         % Modulación QPSK (número M-ario)

% Respuesta al impulso del canal h[n]
h = [0, -0.1, 0.3, -0.5, 0.7, -0.9, 0.7, -0.5, 0.3, -0.1, 0]’;

% Respuesta de frecuencia ideal del canal
H = fft(h, NFFT);

% Generar bits aleatorios
numBits = Nsub * Nofdm * log2(modOrder);
bits = randi([0 1], numBits, 1);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%  PARTE A: Intervalo de guarda con 0 %%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Actualizar Ncp para este caso
Ncp = 16;

% Modulación QPSK
symbols = moduladorQPSK(bits);

% Remodelar símbolos en subportadoras x símbolos OFDM
symbols_matrix = reshape(symbols, Nsub, Nofdm);

% Inicializar la matriz de símbolos OFDM
X = zeros(NFFT, Nofdm);

% Mapear símbolos a subportadoras
X(2:Nsub+1, :) = symbols_matrix;

% Modulación OFDM (IFFT)
ofdm_symbols = ifft(X, NFFT);

% Agregar intervalo de guarda lleno de ceros
ofdm_with_guard = [zeros(Ncp, Nofdm); ofdm_symbols];

% Serializar los símbolos OFDM
s = ofdm_with_guard(:);

% Transmitir a través del canal
s_rx = conv(s, h);
s_rx = s_rx(1:length(s));

% Remodelar la señal recibida
s_rx_matrix = reshape(s_rx, NFFT + Ncp, Nofdm);

% Eliminar el intervalo de guarda
received_symbols = s_rx_matrix(Ncp+1:end, :);

% Demodulación OFDM (FFT)
Y = fft(received_symbols, NFFT);

size(Y)
size(repmat(H.’, 1, Nofdm))

% Ecualización en el dominio de frecuencia
Y_eq = Y ./ repmat(H, 1, Nofdm);

% Extraer las subportadoras de datos
received_data = Y_eq(2:Nsub+1, :);
received_data = received_data(:);

% Demodulación QPSK
received_bits = demoduladorQPSK(received_data);

% Calcular BER
num_errors = sum(bits ~= received_bits);
bit_error_rate = num_errors / numBits;
fprintf("Caso a) BER con intervalo de guarda en cero: %f\n’, bit_error_rate);

% Diagrama de constelación
figure;
subplot(1,2,1);
plot(real(symbols), imag(symbols), "o’);
title("Constelación Transmitida’);
xlabel("En Fase’);
ylabel("En Cuadratura’);
axis square;

subplot(1,2,2);
plot(real(received_data), imag(received_data), "o’);
title("Constelación Recibida (Caso a)’);
xlabel("En Fase’);
ylabel("En Cuadratura’);
axis square;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%  PARTE B: Intervalo de guarda con 0 %%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Actualizar Ncp para el Caso b)
Ncp = 4;  % Longitud del prefijo cíclico menor al canal

% Modulación QPSK
symbols_b = moduladorQPSK(bits);

% Remodelar símbolos en subportadoras x símbolos OFDM
symbols_matrix_b = reshape(symbols_b, Nsub, Nofdm);

% Inicializar la matriz de símbolos OFDM
X_b = zeros(NFFT, Nofdm);

% Mapear símbolos a subportadoras
X_b(2:Nsub+1, :) = symbols_matrix_b;

% Modulación OFDM (IFFT)
ofdm_symbols_b = ifft(X_b, NFFT);

% Agregar prefijo cíclico (copia de las últimas Ncp muestras)
cyclic_prefix_b = ofdm_symbols_b(end-Ncp+1:end, :);
ofdm_with_cp_b = [cyclic_prefix_b; ofdm_symbols_b];

% Serializar los símbolos OFDM
s_b = ofdm_with_cp_b(:);

% Transmitir a través del canal
s_rx_b = conv(s_b, h);
s_rx_b = s_rx_b(1:length(s_b));

% Remodelar la señal recibida
s_rx_matrix_b = reshape(s_rx_b, NFFT + Ncp, Nofdm);

% Eliminar el prefijo cíclico
received_symbols_b = s_rx_matrix_b(Ncp+1:end, :);

% Demodulación OFDM (FFT)
Y_b = fft(received_symbols_b, NFFT);

% Ecualización en el dominio de frecuencia
Y_eq_b = Y_b ./ repmat(H, 1, Nofdm);

% Extraer las subportadoras de datos
received_data_b = Y_eq_b(2:Nsub+1, :);
received_data_b = received_data_b(:);

% Demodulación QPSK
received_bits_b = demoduladorQPSK(received_data_b);

% Calcular BER
num_errors_b = sum(bits ~= received_bits_b);
bit_error_rate_b = num_errors_b / numBits;
fprintf("Caso b) BER con prefijo cíclico corto: %f\n’, bit_error_rate_b);

% Diagrama de constelación
figure;
subplot(1,2,1);
plot(real(symbols_b), imag(symbols_b), "o’);
title("Constelación Transmitida’);
xlabel("En Fase’);
ylabel("En Cuadratura’);
axis square;

subplot(1,2,2);
plot(real(received_data_b), imag(received_data_b), "o’);
title("Constelación Recibida (Caso b)’);
xlabel("En Fase’);
ylabel("En Cuadratura’);
axis square;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%  PARTE C:  %%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Actualizar Ncp para el Caso c)
Ncp = 16;  % Longitud del prefijo cíclico igual o mayor al canal

% Modulación QPSK
symbols_c = moduladorQPSK(bits);

% Remodelar símbolos en subportadoras x símbolos OFDM
symbols_matrix_c = reshape(symbols_c, Nsub, Nofdm);

% Inicializar la matriz de símbolos OFDM
X_c = zeros(NFFT, Nofdm);

% Mapear símbolos a subportadoras
X_c(2:Nsub+1, :) = symbols_matrix_c;

% Modulación OFDM (IFFT)
ofdm_symbols_c = ifft(X_c, NFFT);

% Agregar prefijo cíclico (copia de las últimas Ncp muestras)
cyclic_prefix_c = ofdm_symbols_c(end-Ncp+1:end, :);
ofdm_with_cp_c = [cyclic_prefix_c; ofdm_symbols_c];

% Serializar los símbolos OFDM
s_c = ofdm_with_cp_c(:);

% Transmitir a través del canal
s_rx_c = conv(s_c, h);
s_rx_c = s_rx_c(1:length(s_c));

% Remodelar la señal recibida
s_rx_matrix_c = reshape(s_rx_c, NFFT + Ncp, Nofdm);

% Eliminar el prefijo cíclico
received_symbols_c = s_rx_matrix_c(Ncp+1:end, :);

% Demodulación OFDM (FFT)
Y_c = fft(received_symbols_c, NFFT);

% Ecualización en el dominio de frecuencia
Y_eq_c = Y_c ./ repmat(H, 1, Nofdm);

% Extraer las subportadoras de datos
received_data_c = Y_eq_c(2:Nsub+1, :);
received_data_c = received_data_c(:);

% Demodulación QPSK
received_bits_c = demoduladorQPSK(received_data_c);

% Calcular BER
num_errors_c = sum(bits ~= received_bits_c);
bit_error_rate_c = num_errors_c / numBits;
fprintf("Caso c) BER con prefijo cíclico suficiente: %f\n’, bit_error_rate_c);

% Diagrama de constelación
figure;
subplot(1,2,1);
plot(real(symbols_c), imag(symbols_c), "o’);
title("Constelación Transmitida’);
xlabel("En Fase’);
ylabel("En Cuadratura’);
axis square;

subplot(1,2,2);
plot(real(received_data_c), imag(received_data_c), "o’);
title("Constelación Recibida (Caso c)’);
xlabel("En Fase’);
ylabel("En Cuadratura’);
axis square;
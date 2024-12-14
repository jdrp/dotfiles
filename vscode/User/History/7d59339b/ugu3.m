%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%  PARTE 1: Convolución Circular %%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% PREGUNTA 1

% Parámetros
N = 64;        % Longitud de x[n], puede ajustarse
Ts = 1e-3;     % Periodo de muestreo

% Generar señal aleatoria x[n]
x = randn(N, 1);

% Calcular su espectro X(k)
X = fftshift(fft(x));

% Vector de frecuencia para graficar
Fs = 1/Ts;
f = (-N/2:N/2-1)*(Fs/N);

% Graficar el espectro de x[n]
figure;
plot(f, abs(X));
xlabel("Frecuencia (Hz)");
ylabel("|X(k)|");
xline(0)
title("Espectro de x[n]");


% PREGUNTA 2

% Respuesta al impulso del canal h[n]
h = [-0.1, 0.3, -0.5, 0.7, -0.9, 0.7, -0.5, 0.3, -0.1]';

% Llenar con ceros h[n] hasta longitud N
h_padded = [h; zeros(N - length(h), 1)];

% Calcular su espectro H(k)
H = fftshift(fft(h_padded));

% Graficar el espectro de h[n]
figure;
plot(f, abs(H));
xlabel("Frecuencia (Hz)");
ylabel("|H(k)|");
title("Espectro de h[n]");


% PREGUNTA 3

% Convolución lineal
y = conv(x, h);

% Calcular su FFT de N puntos
Y = fftshift(fft(y, N));

% Graficar el espectro de y[n]
figure;
plot(f, abs(Y));
xlabel("Frecuencia (Hz)");
ylabel("|Y_L(k)|");
title("Espectro de y_L[n] (Convolución Lineal)");


% PREGUNTA 4

% Convolución circular
yc = cconv(x, h, N);  % Convolución circular de N puntos

% Calcular su espectro Yc(k)
Yc = fftshift(fft(yc));

% Graficar el espectro de yc[n]
figure;
plot(f, abs(Yc));
xlabel("Frecuencia (Hz)");
ylabel("|Y_c(k)|");
title("Espectro de y_c[n] (Convolución Circular)");


% PREGUNTA 5

% Calcular el producto X(k) * H(k)
XH = X .* H;

% Comparación entre X(k)*H(k) y Y(k)
figure;
subplot(1,2,1);
plot(f, abs(XH), f, abs(Y));
xlabel("Frecuencia (Hz)");
ylabel("Magnitud");
title("Comparación de X(k)*H(k) y Y_L(k)");
legend("|X(k)*H(k)|", "|Y_L(k)|");

% Comparación entre X(k)*H(k) y Yc(k)
subplot(1,2,2);
plot(f, abs(XH), f, abs(Yc));
xlabel("Frecuencia (Hz)");
ylabel("Magnitud");
title("Comparación de X(k)*H(k) y Y_c(k)");
legend("|X(k)*H(k)|", "|Y_c(k)|");


% PREGUNTA 6

% Longitud del prefijo cíclico (debe ser >= longitud de h[n]-1)
L = length(h) - 1;

% Construir prefijo cíclico a partir de las últimas L muestras de x[n]
cyclic_prefix = x(end-L+1:end);

% Extender x[n] con prefijo cíclico
x_ext = [cyclic_prefix; x];

figure;
hold on;
plot(-L:N-1, x_ext, "b")
plot(0:N-1, x, "r");
xlabel("n");
ylabel("x[n]");
legend("x_{ext}[n]", "x[n]");
title("Señal x[n] y x_{ext}[n] con Prefijo Cíclico");
hold off;


% PREGUNTA 7

% Longitud óptima del prefijo cíclico es L = length(h) - 1
fprintf("Longitud elegida del prefijo cíclico: %d\n", L);

% Convolución lineal con la señal extendida
y_ext = conv(x_ext, h);

% Eliminar las primeras L muestras para extraer el resultado de la convolución circular
yc_extracted = y_ext(L+1:L+N);


figure;
hold on;
plot(-L:N+L-1, y_ext, "b")
plot(0:N-1, yc_extracted, "r");
xlabel("n");
ylabel("x[n]");
xlim([-L, N+L-1])
legend("y_{ext}[n]", "y_c[n]");
title("Convolución circular extraída de la lineal");
hold off;

Yc_extracted = fftshift(fft(yc_extracted));

% Comparación entre X(k)*H(k) y Yc(k) extraído
figure;
plot(f, abs(XH), f, abs(Yc_extracted));
xlabel("Frecuencia (Hz)");
ylabel("Magnitud");
legend("|X(k)*H(k)|", "|Y_{c,extracted}(k)|");
title("Comparación de X(k)*H(k) y Y_{c,extracted}(k)");



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
ofdm_mod = ifft(X, NFFT);

% Agregar intervalo de guarda lleno de ceros
ofdm_with_guard = [zeros(l_cp, Nofdm); ofdm_mod];

% Serializar los símbolos OFDM
s = ofdm_with_guard(:);

% PREGUNTA 2

% Transmitir a través del canal
s_rx = conv(s, h);
s_rx = s_rx(1:length(s));

% Remodelar la señal recibida
s_rx_matrix = reshape(s_rx, NFFT + l_cp, Nofdm);

% Eliminar el intervalo de guarda
received_mod = s_rx_matrix(l_cp+1:end, :);

% Demodulación OFDM (FFT)
Y = fft(received_mod, NFFT);

size(Y)
size(repmat(H.', 1, Nofdm))

% Ecualización en el dominio de frecuencia
Y_eq = Y ./ repmat(H, 1, Nofdm);

% Extraer las subportadoras de datos
received_data = Y_eq(2:Nf+1, :);
received_data = received_data(:);

% Demodulación QPSK
received_bits = demoduladorQPSK(received_data);

% Calcular BER
num_errors = sum(bits ~= received_bits);
bit_error_rate = num_errors / numBits;
fprintf("Caso a) BER con intervalo de guarda en cero: %f\n", bit_error_rate);

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
ofdm_mod_b = ifft(X_b, NFFT);

% Agregar prefijo cíclico (copia de las últimas l_cp muestras)
cyclic_prefix_b = ofdm_mod_b(end-l_cp+1:end, :);
ofdm_with_cp_b = [cyclic_prefix_b; ofdm_mod_b];

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
ofdm_mod_c = ifft(X_c, NFFT);

% Agregar prefijo cíclico (copia de las últimas l_cp muestras)
cyclic_prefix_c = ofdm_mod_c(end-l_cp+1:end, :);
ofdm_with_cp_c = [cyclic_prefix_c; ofdm_mod_c];

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
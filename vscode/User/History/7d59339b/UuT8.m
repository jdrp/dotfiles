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


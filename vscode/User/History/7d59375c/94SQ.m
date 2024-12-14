%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%  PARTE 2: Ecualización %%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%
%%% CEROS DE GUARDA %%%
%%%%%%%%%%%%%%%%%%%%%%%%

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
[bits, mod, x] = randomOFDMwithQPSK(NFFT, Nf, m_ary, Nofdm);

% Agregar intervalo de guarda lleno de ceros
ofdm_with_zeros = [zeros(l_cp, Nofdm); x];

% Convertir matriz a vector columna
s = ofdm_with_zeros(:);

% Gráfica de la señal OFDM, poner el prefijo de guarda en rojo
figure;
plot_ofdm_signal(s, NFFT, l_cp, 3, "Señal OFDM con ceros de guarda")


% PREGUNTAS 2 A 5

test_guard(s, h, NFFT, l_cp, Nofdm, Nf, H, bits, mod, x)

%%%%%%%%%%%%%%%%%%%%%%%%
%%% CP DE 4 MUESTRAS %%%
%%%%%%%%%%%%%%%%%%%%%%%%

% PREGUNTA 1

l_cp = 4;  % Longitud del prefijo cíclico menor al canal

% Agregar prefijo cíclico
ofdm_with_zeros = [x(end-l_cp+1:end, :); x];

% Convertir matriz a vector columna
s = ofdm_with_zeros(:);

% Gráfica de la señal OFDM, poner el prefijo de guarda en rojo
figure;
plot_ofdm_signal(s, NFFT, l_cp, 3, "Señal OFDM con CP de 4 muestras")


% PREGUNTAS 2 A 5
test_guard(s, h, NFFT, l_cp, Nofdm, Nf, H, bits, mod, x)


%%%%%%%%%%%%%%%%%%%%%%%%
%% CP DE 16 MUESTRAS %%%
%%%%%%%%%%%%%%%%%%%%%%%%

% PREGUNTA 1

l_cp = 16;  % Longitud del prefijo cíclico menor al canal

% Agregar prefijo cíclico
ofdm_with_zeros = [x(end-l_cp+1:end, :); x];

% Convertir matriz a vector columna
s = ofdm_with_zeros(:);

% Gráfica de la señal OFDM, poner el prefijo de guarda en rojo
figure;
plot_ofdm_signal(s, NFFT, l_cp, 3, "Señal OFDM con CP de 16 muestras")


% PREGUNTAS 2 A 5
test_guard(s, h, NFFT, l_cp, Nofdm, Nf, H, bits, mod, x)


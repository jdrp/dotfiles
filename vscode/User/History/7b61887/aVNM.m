%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%  PARTE 1: Convolución Circular %%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Parameters
N = 128;        % Length of x[n], can be adjusted
Ts = 1e-3;     % Sampling period

% Generate random signal x[n]
x = randn(N, 1);

% Compute its spectrum X(k)
X = fftshift(fft(x));

% Frequency vector for plotting
Fs = 1/Ts;
f = linspace(-Fs/2, Fs/2, N);

% Plot the spectrum of x[n]
figure;
plot(f, abs(X));
xlabel('Frecuencia (Hz)');
ylabel('|X(k)|');
title('Espectro de x[n]');


% Channel impulse response h[n]
h = [0, -0.1, 0.3, -0.5, 0.7, -0.9, 0.7, -0.5, 0.3, -0.1, 0]';

% Zero-pad h[n] to length N
h_padded = [h; zeros(N - length(h), 1)];

% Compute its spectrum H(k)
H = fftshift(fft(h_padded));

% Plot the spectrum of h[n]
figure;
plot(f, abs(H));
xlabel('Frecuencia (Hz)');
ylabel('|H(k)|');
title('Espectro de h[n]');


% Linear convolution
y = conv(x, h);

% Compute its N-point FFT
Y = fftshift(fft(y, N));

% Plot the spectrum of y[n]
figure;
plot(f, abs(Y));
xlabel('Frecuencia (Hz)');
ylabel('|Y(k)|');
title('Espectro de y[n] (Convolución Lineal)');


% Circular convolution
yc = cconv(x, h, N);  % N-point circular convolution

% Compute its spectrum Yc(k)
Yc = fftshift(fft(yc));

% Plot the spectrum of yc[n]
figure;
plot(f, abs(Yc));
xlabel('Frecuencia (Hz)');
ylabel('|Y_c(k)|');
title('Espectro de y_c[n] (Convolución Circular)');


% Compute product X(k) * H(k)
XH = X .* H;

% Plot comparison between X(k)*H(k) and Y(k)
figure;
subplot(2,1,1);
plot(f, abs(XH), f, abs(Y));
xlabel('Frecuencia (Hz)');
ylabel('Megnitud');
title('Comparación de X(k)*H(k) y Y(k)');
legend('|X(k)*H(k)|', '|Y(k)|');

% Plot comparison between X(k)*H(k) and Yc(k)
subplot(2,1,2);
plot(f, abs(XH), f, abs(Yc));
xlabel('Frecuencia (Hz)');
ylabel('Manitud');
title('Comparación de X(k)*H(k) y Y_c(k)');
legend('|X(k)*H(k)|', '|Y_c(k)|');


% Length of cyclic prefix (should be >= length of h[n]-1)
L = length(h) - 1;

% Construct cyclic prefix from the last L samples of x[n]
cyclic_prefix = x(end-L+1:end);

% Extend x[n] with cyclic prefix
x_ext = [cyclic_prefix; x];

% Optimal length of cyclic prefix is L = length(h) - 1 = 10
fprintf('Chosen cyclic prefix length: %d\n', L);


% Linear convolution with extended signal
y_ext = conv(x_ext, h);

% Remove first L samples to extract circular convolution result
yc_extracted = y_ext(L+1:L+N);

% Verify that extracted yc matches circular convolution yc
difference = max(abs(yc - yc_extracted));
fprintf('Maximum difference between yc and extracted yc: %e\n', difference);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%  PARTE 2: Ecualización %%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% OFDM parameters
NFFT = 128;           % FFT size
Ncp = 16;             % Length of cyclic prefix (will vary per case)
Nofdm = 100;          % Number of OFDM symbols
Nsub = 10;            % Number of data subcarriers
modOrder = 4;         % QPSK modulation (M-ary number)

% Channel impulse response h[n]
h = [0, -0.1, 0.3, -0.5, 0.7, -0.9, 0.7, -0.5, 0.3, -0.1, 0]';

% Ideal channel frequency response
H = fft(h, NFFT);

% Generate random bits
numBits = Nsub * Nofdm * log2(modOrder);
bits = randi([0 1], numBits, 1);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%  PARTE A: Intervalo de guarda con 0 %%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Update Ncp for this case
Ncp = 16;

% QPSK Modulation
symbols = moduladorQPSK(bits);

% Reshape symbols into subcarriers x OFDM symbols
symbols_matrix = reshape(symbols, Nsub, Nofdm);

% Initialize OFDM symbol matrix
X = zeros(NFFT, Nofdm);

% Map symbols to subcarriers
X(2:Nsub+1, :) = symbols_matrix;

% OFDM modulation (IFFT)
ofdm_symbols = ifft(X, NFFT);

% Add guard interval filled with zeros
ofdm_with_guard = [zeros(Ncp, Nofdm); ofdm_symbols];

% Serialize the OFDM symbols
s = ofdm_with_guard(:);

% Transmit through channel
s_rx = conv(s, h);
s_rx = s_rx(1:length(s));

% Reshape received signal
s_rx_matrix = reshape(s_rx, NFFT + Ncp, Nofdm);

% Remove the guard interval
received_symbols = s_rx_matrix(Ncp+1:end, :);

% OFDM demodulation (FFT)
Y = fft(received_symbols, NFFT);

size(Y)
size(repmat(H.', 1, Nofdm))

% Frequency domain equalization
Y_eq = Y ./ repmat(H, 1, Nofdm);

% Extract the data subcarriers
received_data = Y_eq(2:Nsub+1, :);
received_data = received_data(:);

% QPSK Demodulation
received_bits = demoduladorQPSK(received_data);

% Calculate BER
num_errors = sum(bits ~= received_bits);
bit_error_rate = num_errors / numBits;
fprintf('Case a) BER with zero guard interval: %f\n', bit_error_rate);

% Constellation Plot
figure;
subplot(1,2,1);
plot(real(symbols), imag(symbols), 'o');
title('Transmitted Constellation');
xlabel('In-Phase');
ylabel('Quadrature');
axis square;

subplot(1,2,2);
plot(real(received_data), imag(received_data), 'o');
title('Received Constellation (Case a)');
xlabel('In-Phase');
ylabel('Quadrature');
axis square;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%  PARTE B: Intervalo de guarda con 0 %%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Update Ncp for Case b)
Ncp = 4;  % Cyclic prefix length less than the channel

% QPSK Modulation
symbols_b = moduladorQPSK(bits);

% Reshape symbols into subcarriers x OFDM symbols
symbols_matrix_b = reshape(symbols_b, Nsub, Nofdm);

% Initialize OFDM symbol matrix
X_b = zeros(NFFT, Nofdm);

% Map symbols to subcarriers
X_b(2:Nsub+1, :) = symbols_matrix_b;

% OFDM modulation (IFFT)
ofdm_symbols_b = ifft(X_b, NFFT);

% Add cyclic prefix (copy of last Ncp samples)
cyclic_prefix_b = ofdm_symbols_b(end-Ncp+1:end, :);
ofdm_with_cp_b = [cyclic_prefix_b; ofdm_symbols_b];

% Serialize the OFDM symbols
s_b = ofdm_with_cp_b(:);

% Transmit through channel
s_rx_b = conv(s_b, h);
s_rx_b = s_rx_b(1:length(s_b));

% Reshape received signal
s_rx_matrix_b = reshape(s_rx_b, NFFT + Ncp, Nofdm);

% Remove the cyclic prefix
received_symbols_b = s_rx_matrix_b(Ncp+1:end, :);

% OFDM demodulation (FFT)
Y_b = fft(received_symbols_b, NFFT);

% Frequency domain equalization
Y_eq_b = Y_b ./ repmat(H, 1, Nofdm);

% Extract the data subcarriers
received_data_b = Y_eq_b(2:Nsub+1, :);
received_data_b = received_data_b(:);

% QPSK Demodulation
received_bits_b = demoduladorQPSK(received_data_b);

% Calculate BER
num_errors_b = sum(bits ~= received_bits_b);
bit_error_rate_b = num_errors_b / numBits;
fprintf('Case b) BER with short cyclic prefix: %f\n', bit_error_rate_b);

% Constellation Plot
figure;
subplot(1,2,1);
plot(real(symbols_b), imag(symbols_b), 'o');
title('Transmitted Constellation');
xlabel('In-Phase');
ylabel('Quadrature');
axis square;

subplot(1,2,2);
plot(real(received_data_b), imag(received_data_b), 'o');
title('Received Constellation (Case b)');
xlabel('In-Phase');
ylabel('Quadrature');
axis square;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%  PARTE C:  %%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Update Ncp for Case c)
Ncp = 16;  % Cyclic prefix length equal to or greater than the channel

% QPSK Modulation
symbols_c = moduladorQPSK(bits);

% Reshape symbols into subcarriers x OFDM symbols
symbols_matrix_c = reshape(symbols_c, Nsub, Nofdm);

% Initialize OFDM symbol matrix
X_c = zeros(NFFT, Nofdm);

% Map symbols to subcarriers
X_c(2:Nsub+1, :) = symbols_matrix_c;

% OFDM modulation (IFFT)
ofdm_symbols_c = ifft(X_c, NFFT);

% Add cyclic prefix (copy of last Ncp samples)
cyclic_prefix_c = ofdm_symbols_c(end-Ncp+1:end, :);
ofdm_with_cp_c = [cyclic_prefix_c; ofdm_symbols_c];

% Serialize the OFDM symbols
s_c = ofdm_with_cp_c(:);

% Transmit through channel
s_rx_c = conv(s_c, h);
s_rx_c = s_rx_c(1:length(s_c));

% Reshape received signal
s_rx_matrix_c = reshape(s_rx_c, NFFT + Ncp, Nofdm);

% Remove the cyclic prefix
received_symbols_c = s_rx_matrix_c(Ncp+1:end, :);

% OFDM demodulation (FFT)
Y_c = fft(received_symbols_c, NFFT);

% Frequency domain equalization
Y_eq_c = Y_c ./ repmat(H, 1, Nofdm);

% Extract the data subcarriers
received_data_c = Y_eq_c(2:Nsub+1, :);
received_data_c = received_data_c(:);

% QPSK Demodulation
received_bits_c = demoduladorQPSK(received_data_c);

% Calculate BER
num_errors_c = sum(bits ~= received_bits_c);
bit_error_rate_c = num_errors_c / numBits;
fprintf('Case c) BER with sufficient cyclic prefix: %f\n', bit_error_rate_c);

% Constellation Plot
figure;
subplot(1,2,1);
plot(real(symbols_c), imag(symbols_c), 'o');
title('Transmitted Constellation');
xlabel('In-Phase');
ylabel('Quadrature');
axis square;

subplot(1,2,2);
plot(real(received_data_c), imag(received_data_c), 'o');
title('Received Constellation (Case c)');
xlabel('In-Phase');
ylabel('Quadrature');
axis square;
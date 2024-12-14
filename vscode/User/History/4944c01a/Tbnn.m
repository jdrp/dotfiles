%% Definición del sistema

clear; close all;

NFFT  =	128;  % Tamaño de la FFT
df    =  200;  % Separación entre portadoras
Fs    =	NFFT*df;  % Frecuencia de muestreo
Nf    =	10;  % Numero de portadoras con datos
m_ary =	4;  % Indicador de modulacion digital de cada portadora (QPSK)
%
SNR_vector =	4:20;  % Vector de relaciones SNR en el canal
 
% Generación de los bits a transmitir. Han de ser un multiplo entero de log2(m_ary)*Nf

Nofdm  = 4;  % Número de símbolos OFDM
txbits = round(rand(log2(m_ary) * Nf * Nofdm, 1));
 
% Generación de símbolos complejos resultantes de la modulación en QPSK. Se recomienda, aunque no es estrictamente necesario, que los símbolos se agrupen en una matriz de Nf filas y Nofdm columnas

mod = moduladorQPSK(txbits);
mod = reshape(mod, Nf, Nofdm);
 
%% Modulación OFDM
% 
% La modulación OFDM se implementa realizando la transformada inversa de Fourier de una matriz X, que se obtiene de los símbolos complejos a la salida del modulador QPSK, tal como se describe en la teoría. A X se le denomina matriz de coeficientes espectrales, y su dimensión es NFFT filas por Nofdm columnas
%
%  Creación de la matriz X, de componentes espectrales, para la IFFT
%
%  Incialización a cero 
   X = zeros(NFFT, Nofdm);
%
%  Asignación de los símbolos moduladores al espectro positivo
   X(29:38,:) = mod;
%

%  Asignación de los símbolos moduladores en orden inverso y conjugados al espectro negativo. Describa lo que realiza la función flipud. -> invierte el orden de los bits
X(NFFT/2+2:NFFT,:) = flipud(conj(X(2:NFFT/2,:)));

% Generación del vector de muestras temporales reales x como resultado de la modulación OFDM. Léase la documentación de las funciones IFFT y FFT de MATLAB
  
x = ifft(X, NFFT); % Señal transmitida, que tiene que ser real

% En esta práctica no se añade prefijo cíclico

% Transformación de x en un vector fila

x = reshape(x, 1, []);

% Representación de gráficas temporales
%

% Represente dos gráficas temporales. En la primera se debe representar la señal x durante un intervalo de tiempo correspondiente a varios símbolos OFDM, a elegir por el alumno. En la segunda represente la variación de la potencia en función del tiempo, superponiendo sobre la gráfica las rectas de potencia media y potencia de pico en ese intervalo de tiempo. Calcule el PAPR en dB e indique su valor en el título de la gráfica.

figure;
% representación de la variación temporal de la señal
Ts = 1/Fs;
t = Ts:Ts:Ts*length(x);
plot(t, x)
xlabel('t (ms)');  
ylabel('Amplitud (V)')


figure;
% representación de la variación temporal de la potencia, superponiendo las rectas que indican la potencia media y la de pico. 
P = abs(x) .^ 2;
Pavg = mean(P);
Ppeak = max(P);
papr_dB = 10 * log10(Ppeak / Pavg);
plot(t, P);
hold on;
yline(Pavg, 'b--');
yline(Ppeak, 'r--');
xlabel('t(ms)');  
ylabel('Potencia (W)')
legend('Potencia de señal en línea', 'Potencia media', 'Potencia de pico');  
title(['Señal OFDM,  PAPR = ' num2str(round(papr_dB,1)), 'dB']);
ylim([0, Ppeak * 1.05])
hold off;

BER_array = zeros(1, length(SNR_vector));

% Se abre bucle de SNR:
for i = 1:length(SNR_vector)
   %% Canal
   SNR = SNR_vector(i);
   % Se añade ruido para conseguir el SNR deseado sobre la banda de Nf subportadoras 
   %  Factor de ancho de banda, fb ¿Qué significa y para qué se utiliza?
      fb = 10*log10( (NFFT/2)/Nf );
      y  = awgn(x, SNR-fb,'measured');

   % factor de ancho de banda: proporción de ancho de banda total entre ancho de banda utilizado.
   % el ruido se distribuye por el ancho de banda total -> lo multiplicamos por fb (reduciendo la snr de awgn) para que en el utilizado tenga el snr deseado.

   %% RX
   
   %Demodulación OFDM para obtener los simbolos recibidos. La demodulación es el proceso inverso a la modulación, básicamente realizar una FFT de la señal recibida.

   % Transformación del vector y en una matriz de NFFT filas y Nofdm columnas

   y = reshape(y, NFFT, Nofdm);
   % Implementación de la FFT para demodular la señal OFDM
   
   % demodulación de la señal OFDM
   Y = fft(y,NFFT); 
   % CHARLIE AQUI HA PUESTO EL ;
   Yp = Y(29:38,:);

   % flatten Yp
   Yp = reshape(Yp, 1, []);
   
   % print dimensions of Yp
   % CHARLIE AQUI HA PUESTO EL ;
   size(Yp);


   % Demodulación de las señales extraidas del demodulador OFDM para recuperar bits
   rxbits= demoduladorQPSK(Yp.').';
   
   % Cálculo de BER
   BER = sum(rxbits ~= txbits) / length(txbits);
   BER_array(i) = BER;

end
% Se cierra bucle de SNR
 
%% Curvas de BER
%
%  Para el cálculo de BER vs SNR en QPSK 
%
   gamma  = 10.^((SNR_vector-3)/10);  
   BERTeo = qfunc(sqrt(2*gamma));
   BERTeo(find(BERTeo<1e-8)) = NaN;  

   display("_________________________");
   display(BERTeo);
   display("_________________________");
   display(BER);
   display("_________________________");
   
   figure
   % CHARLIE AQUI HA BER_array en vez de BER
   semilogy(SNR_vector, BER_array,     '-+');   hold on;
   semilogy(SNR_vector, BERTeo, '-rO');
   legend('Simulado','Teórico')
   xlabel('SNR (dB)');  ylabel('BER')
   grid on
   title('Resultados del sistema OFDM')
%
%% Representación espectral

% Para una relación señal ruido de 15 dB en la banda donde hay señal,       represente el espectro real de la señal en línea, en dB, únicamente frecuencias positivas, lo que se vería en un analizador de espectros. El eje de frecuencias debe estar marcado en KHz.

% AQUI LA EMPIEZA A LIAR CHARLIE

SNR = 15;
fb = 10*log10((NFFT/2)/Nf);
y = awgn(x, SNR - fb, 'measured');
Y = fft(y);
N = length(y);
Y = Y(1:N/2);

figure;

frec = (0:N/2-1)*(Fs/N); 	% Vector de frecuencias a representar

   % Vector de amplitudes de señal en línea (dBx)
   XdB(1:N/2) = 20*log10(abs(Y));
   %
   % Limitación del margen dinámico
   XdB(find(XdB<max(XdB)-30)) = max(XdB)-30; 
   %
   plot(frec*1e-3, XdB);
   xlabel('f(KHz)');   
   ylabel('Espectro (dB)');
   
% AQUI LA ACABA DE LIAR CHARLIE

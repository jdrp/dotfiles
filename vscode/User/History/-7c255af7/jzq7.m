
%% Definición del sistema

clear; close all, format compact

NFFT  =	;  % Tamaño de la FFT
df    =     ;  % Separación entre portadoras
Fs    =	;  % Frecuencia de muestreo
Nf    =	;  % Numero de portadoras con datos
m_ary =	;  % Indicador de modulacion digital de cada portadora
%
SNR_vector =	;  % Vector de relaciones SNR en el canal
 
% Generación de los bits a transmitir. Han de ser un multiplo entero de log2(m_ary)*Nf

Nofdm  =    ;  % Número de símbolos OFDM
txbits = round(rand(¿¿??));
 
% Generación de símbolos complejos resultantes de la modulación en QPSK. Se recomienda, aunque no es estrictamente necesario, que los símbolos se agrupen en una matriz de Nf filas y Nofdm columnas

mod = ¿¿??;
 
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
   X(29:38,:) = ¿¿??;
%
%  Asignación de los símbolos moduladores en orden inverso y conjugados al espectro negativo. Describa lo que realiza la función flipud.
   X(NFFT/2+2:NFFT,:) = flipud(conj(????????;

% Generación del vector de muestras temporales reales x como resultado de la modulación OFDM. Léase la documentación de las funciones IFFT y FFT de MATLAB
  
x = ifft(X, ???)*NFFT; ¿? % Señal transmitida, que tiene que ser real

% En esta práctica no se añade prefijo cíclico

% Transformación de x en un vector fila

x = reshape(x, ¿?);

% Representación de gráficas temporales
%

Represente dos gráficas temporales. En la primera se debe representar la señal x durante un intervalo de tiempo correspondiente a varios símbolos OFDM, a elegir por el alumno. En la segunda represente la variación de la potencia en función del tiempo, superponiendo sobre la gráfica las rectas de potencia media y potencia de pico en ese intervalo de tiempo. Calcule el PAPR en dB e indique su valor en el título de la gráfica.

figure;
% representación de la variación temporal de la señal
????
xlabel('t(ms)');  


figure 
% representación de la variación temporal de la potencia, superponiendo las rectas que indican la potencia media y la de pico. 
????
xlabel('t(ms)');  
legend('Potencia de señal en línea', 'Potencia media', 'Potencia de pico');  
title(['Señal OFDM,    PAPR = ' num2str(round(papr_dB,1)), ' (dB)']);


% Se abre bucle de SNR:

    %% Canal

    % Se añade ruido para conseguir el SNR deseado sobre la banda de Nf subportadoras 
    %  Factor de ancho de banda, fb ¿Qué significa y para qué se utiliza?
    fb = 10*log10( (NFFT/2)/Nf );
    y  = awgn(x,SNR-fb,'measured');

    %% RX
    
    %Demodulación OFDM para obtener los simbolos recibidos. La demodulación es el proceso inverso a la modulación, básicamente realizar una FFT de la señal recibida.

    % Transformación del vector y en una matriz de NFFT filas y Nofdm columnas

    y = reshape(y, ¿?¿?);

    % Implementación de la FFT para demodular la señal OFDM
 
    Y = fft(y,NFFT); 
    ¿¿??

    % Demodulación de las señales extraidas del demodulador OFDM para recuperar bits
    rxbits= ¿?¿?;
    
    BER =		; % Cálculo de BER

% Se cierra bucle de SNR
 
%% Curvas de BER
%
%  Para el cálculo de BER vs SNR en QPSK 
%
   gamma  = 10.^((SNR_vector-3)/10);  
   BERTeo = qfunc(sqrt(2*gamma));
   BERTeo(find(BERTeo<1e-5)) = NaN;  
   
   figure
   semilogy(SNR_vector, BER,     '-+');   hold on;
   semilogy(SNR_vector, BERTeo, '-rO');
   legend('Simulado','Teórico')
   xlabel('SNR (dB)');  ylabel('BER')
   grid on
   title('Resultados del sistema OFDM')
%
%% Representación espectral

Para una relación señal ruido de 15 dB en la banda donde hay señal,       represente el espectro real de la señal en línea, en dB, únicamente frecuencias positivas, lo que se vería en un analizador de espectros. El eje de frecuencias debe estar marcado en KHz.

   figure;
   ¿¿ ??
   frec = ¿¿ ??; 		% Vector de frecuencias a representar
   %
   % Vector de amplitudes de señal en línea (dBx)
   XdB(1:????/2) = ¿¿  ??
   %
   % Limitación del margen dinámico
   XdB(find(XdB<max(XdB)-30)) = max(XdB)-30; 
   %
   plot(frec*1e-3, XdB);
   xlabel('f(KHz)');   ylabel('Espectro (dB)');
   

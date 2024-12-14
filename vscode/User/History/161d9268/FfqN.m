%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%% EJERCICIO 2.1 : MODULACIÓN QPSK %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Secuencia de símbolos de prueba
bits = [1, 1, 1, 0, 0, 1, 0, 0];
modulatedSymbols = modularSimbolos(bits, @moduladorQPSK, "QPSK");


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%% EJERCICIO 2.2: MODULACION QPSK CON RUIDO %%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Parámetros
numBits = 1000; % Número de bits
SNR_dB = [5, 10, 15]; % Valores de SNR en dB

% Generar bits aleatorios
bits = randi([0 1], 1, numBits);

modulaConRuido(bits, @moduladorQPSK, SNR_dB, "QPSK")
modulaConRuido(bits, @moduladorDQPSK, SNR_dB, "DQPSK")


% Comentario:
% Al observar los diagramas de dispersión, se puede notar que a medida que disminuye el SNR, 
% el ruido añade mayor dispersión a los puntos QPSK modulados, lo que provoca que los símbolos 
% recibidos estén más alejados de sus valores ideales. Esto aumenta la probabilidad de que 
% los bits demodulados sean erróneos, ya que las decisiones de detección se ven afectadas por 
% la proximidad de los puntos ruidosos a los umbrales de decisión.


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%% EJERCICIO 2.3: CADENA DE MODULACIÓN-DEMODULACIÓN QPSK Y DQPSK %%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
disp("QPSK")
modulatedSymbolsQPSK = moduladorQPSK(bits);
disp(calcularBER(bits, modulatedSymbolsQPSK, @demoduladorQPSK))
disp("DQPSK")
modulatedSymbolsDQPSK = moduladorDQPSK(bits);
disp(calcularBER(bits, modulatedSymbolsDQPSK, @demoduladorDQPSK))


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%% EJERCICIO 2.4: CURVAS DE BER FRENTE A EBNO_DB PARA QPSK Y DQPSK %%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
modulators = {@moduladorQPSK, @moduladorDQPSK};
demodulators = {@demoduladorQPSK, @demoduladorDQPSK};
EbNo_dB = -5:2:10;
BER_teor = [qfunc(sqrt(2 * 10.^(EbNo_dB/10))); 1.13 * qfunc(sqrt(1.2 * 10.^(EbNo_dB/10)))];
BER_teor(BER_teor < 1e-5) = NaN;
modulations = ["QPSK", "DQPSK"];

compararBERVariasModulaciones(modulators, demodulators, BER_teor, modulations, EbNo_dB, 100000, 0)


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%% EJERCICIO 2.5: INFLUENCIA DEL ERROR DE FASE EN RECEPCIÓN %%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
compararBERVariasModulaciones(modulators, demodulators, BER_teor, modulations, EbNo_dB, 100000, 10)
compararBERVariasModulaciones(modulators, demodulators, BER_teor, modulations, EbNo_dB, 100000, 20)
compararBERVariasModulaciones(modulators, demodulators, BER_teor, modulations, EbNo_dB, 100000, 30)


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%% EJERCICIO 3.1: CURVAS DE BER FRENTE A EBNO_DB PARA QPSK Y DQPSK %%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
EbNo_dB = -5:2:10;

[BER_4QAM, BER_teor_4QAM] = BER_m_ary_QAM(4, EbNo_dB);
[BER_16QAM, BER_teor_16QAM] = BER_m_ary_QAM(16, EbNo_dB);
[BER_64QAM, BER_teor_64QAM] = BER_m_ary_QAM(64, EbNo_dB);
[BER_256QAM, BER_teor_256QAM] = BER_m_ary_QAM(256, EbNo_dB);

graficaBER(EbNo_dB, [BER_4QAM, BER_16QAM, BER_64QAM, BER_256QAM], [])
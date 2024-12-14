function [txbits, tx] = randomOFDMwithQPSK(NFFT, Nf, m_ary, Nofdm)
     
    % Generación de los bits a transmitir. Han de ser un multiplo entero de log2(m_ary)*Nf
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

    tx = reshape(x, 1, []);
end
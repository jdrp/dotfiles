function xMod = modulador16QAM(txBits)
    %%
    %  Esta función genera una señal modulada en 16-QAM en función de un vector de grupos de 4 bits
    %
    % txBits    vector fila de bits de entrada. Su longitud debe ser múltiplo de 4
    % xMod      vector fila de símbolos modulados en 16-QAM en banda base. 
    %           Sus elementos son números complejos y su longitud es una cuarta parte de la de txBits
    %
    
    % Comprobación de que la longitud de txBits es múltiplo de 4
      n = length(txBits);
      if rem(n, 4) ~= 0
          error('La longitud de txBits no es múltiplo de 4');
      end
    
    % Copia de txBits a vector fila
      b = txBits(:)';
    
    % Reshape del vector para tener 4 filas, cada columna representa un símbolo
      b = reshape(b, 4, n/4);
    
    % Mapeo de bits a niveles de amplitud (I y Q)
    % Usamos los valores de 16-QAM: {-3, -1, +1, +3} para los niveles de I y Q
    % Los valores de bits se interpretan de acuerdo con la convención Gray: 
    % 00 -> -3, 01 -> -1, 11 -> +1, 10 -> +3
    
      I = ((2*b(1,:) + b(2,:)) * 2 - 3) / sqrt(10);
      Q = (2*b(3,:) + b(4,:)) * 2 - 3;
    
    % Generación de la señal modulada como combinación de las señales I y Q
      xMod = I + 1j * Q;
    
    end
    
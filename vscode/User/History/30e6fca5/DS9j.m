function xMod = moduladorQPSK(txBits)
%%
%  Esta funci�n genera una se�al modulada en QPSK en funci�n de un vector de parejas de bits
%
% txBits    vector fila de bits de entrada. Su longitud debe ser par
% xMod      vector fila de s�mbolos modulados en QPSK en banda base. 
%           Sus elementos son n�meros complejos y su longitud la mitad de la de txbits
%
% Comprobaci�n de que la longitud de txBits es par
  n = length(txBits);
  if rem(n,2) ~= 0
      error('La longitud de txBits no es par');
  end
%
% Copia de txBits a vector fila
  b = txBits(:)';
%
% Se generan los vectores I (fase) y Q (cuadratura)
% Los 1s se asimilan a fase 0 (+1) y los 0s a fase pi (-1)
  b = (reshape(b', 2, n/2) - 0.5)*2;
  I = b(1,:);
  Q = b(2,:);
%
% Se genera la se�al modulada como suma de se�ales BPSK en fase y cuadratura
  xMod = I + j*Q;
 %
   end
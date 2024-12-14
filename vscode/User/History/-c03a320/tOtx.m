function rxBits = demoduladorQPSK(rxSimbol)
%%
%  Esta funci�n demodula una se�al QPSK en banda base, contenida en el vector de entrada rxSimbol
%
% rxSimbol  vector fila de s�mbolos de entrada. 
% xmod      vector fila de bits resultado de demodular. Su longitud el doble de la de rxSimbol
%
% Inicializaci�n
  n = length(rxSimbol);
  rxBits = zeros(1, 2*n);
%
% Copia de rxSimbol a vector fila
  b = rxSimbol(:).';
%
% Se generan los vectores I (fase) y Q (cuadratura) 
%
  I   = zeros(1,n);
  ind = find(real(b)>=0);
  I(ind) = 1;
  Q   = zeros(1,n);
  ind = find(imag(b)>=0); 
  Q(ind) = 1;
%
% Se genera el vector de bits en base a I y Q
  rxBits = reshape([I ; Q], 1, 2*n); 
%
  end


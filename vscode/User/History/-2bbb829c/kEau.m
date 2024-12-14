function rxBits = demoduladorDQPSK(rxSimbol)
%%
%  Esta funci�n demodula una se�al DQPSK en banda base, contenida en el vector de entrada rxSimbol
%
%  rxSimbol  vector fila de s�mbolos de entrada. Sus elementos son complejos
%  xmod      vector fila de bits resultado de demodular. Su longitud el doble de la de rxSimbol
%
% Conversi�n a modulaci�n no diferencial QPSK. Para el primer s�mbolo supone que la fase del s�mbolo 
% anterior es cero
  n  = length(rxSimbol);
  Simbol    = zeros(1,n);
  Simbol(1) = rxSimbol(1);
  for i=2:n
        Simbol(i) = rxSimbol(i)/exp(1j*angle(rxSimbol(i-1)));
  end
%  
% C�lculo de la se�al demodulada 
  rxBits = demoduladorQPSK(Simbol);
% 
  end


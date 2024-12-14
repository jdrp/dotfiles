function rxBits = demoduladorDQPSK(rxSimbol)
  %%
  %  Esta funci�n demodula una señal DQPSK en banda base, contenida en el vector de entrada rxSimbol
  %
  %  rxSimbol  vector fila de simbolos de entrada. Sus elementos son complejos
  %  xmod      vector fila de bits resultado de demodular. Su longitud el doble de la de rxSimbol
  %
  % Conversión a modulación no diferencial QPSK. Para el primer símbolo supone que la fase del símbolo 
  % anterior es cero
    n  = length(rxSimbol);
    Simbol    = zeros(1,n);
    Simbol(1) = rxSimbol(1);
    for i=2:n
          Simbol(i) = rxSimbol(i)/exp(1j*angle(rxSimbol(i-1)));
    end
  %  
  % Cálculo de la se�al demodulada 
    rxBits = demoduladorQPSK(Simbol);
  % 
  end


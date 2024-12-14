function xMod = modulatorDQPSK(txBits)
  %%
  %  Esta funci�n genera una se�al modulada en DQPSK en funci�n de un vector de parejas de bits
  %
  % txBits    vector fila de bits de entrada. Su longitud debe ser par
  % xMod      vector fila de s�mbolos modulados en DQPSK en banda base. 
  %           Sus elementos son n�meros complejos y su longitud la mitad de la de txbits
  %
  % C�lculo de la se�al modulada en QPSK, no diferencial
    xMod = moduladorQPSK(txBits);
  %
  % Conversi�n a modulaci�n diferencial. Para el primer s�mbolo se supone que la fase del s�mbolo 
  % anterior es cero
    n = length(xMod);
    for i=2:n;
          xMod(i) = xMod(i)*exp(j*angle(xMod(i-1)));
    end
  %
end
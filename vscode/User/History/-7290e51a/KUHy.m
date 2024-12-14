function modulatedSignal = modulatorDnPSK(bits, constellation)


    %
    % Conversión a modulación diferencial. Para el primer símbolo se supone que la fase del símbolo
    % anterior es cero
    n = length(xMod);
    for i=2:n
        xMod(i) = xMod(i)*exp(1j*angle(xMod(i-1)));
    end
    %
end
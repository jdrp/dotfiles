% Salida del demodulador 
% Ejercicio 3.1
% Con referencia a la Figura 2, modifique los demoduladores anteriormente implementados (correlador o filtro adaptado) para que devuelvan el valor correspondiente a la salida muestreada al final del periodo de símbolo, es decir r_1 y r_2 en la Figura 2: para cada periodo de la señal de entrada se genera una muestra a la salida del demodulador S1 y otra a la salida del demodulador S2.
 
% Figura  2 - Esquema de un demodulador de dos ramas.

% Genere una señal r(t) compuesta por Nsymb símbolos s_1 (t) y contaminada por ruido blanco. Elija de manera razonada la relación señal a ruido y el valor de Nsymb. Introduzca la señal en el demodulador y represente un histograma de los valores que se obtienen de r_1 y r_2, empleando para ello la función histogram de Matlab.  Genere luego otro histograma cuando los símbolos son s_2 (t). Comente lo que muestran los histogramas.


function [o1pred, o2pred] = demodulateSymbol(T, Ts, r)
    [o1, o2] = correlatorType(T, Ts, r);
    o1pred = o1(-1);
    
    
end 
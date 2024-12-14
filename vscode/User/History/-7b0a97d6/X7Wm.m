
function plot_ofdm_signal(s, NFFT, l_cp, num_symbols, title_str)
    % Longitud de cada símbolo
    Lsymb = NFFT + l_cp;

    % Extrae las primeras num_symbols OFDM symbols de la señal s y grafica
    s_plot = s(1:Lsymb*num_symbols);
    
    % Inicializa los vectores para los símbolos de guarda y de datos
    s_guard = nan(size(s_plot));
    s_data = nan(size(s_plot));
    
    for n = 0:num_symbols-1
        % Calculamos los índices para los símbolos de guarda y de datos
        idx_guard = n*Lsymb + (1:l_cp);
        idx_data = n*Lsymb + (l_cp+1:Lsymb);
        
        % Asignamos los valores
        s_guard(idx_guard) = s_plot(idx_guard);
        s_data(idx_data) = s_plot(idx_data);
    end
    
    % Plot de los símbolos de datos en azul
    plot(s_data, 'b');
    hold on;
    
    % Plot de los símbolos de guarda en rojo
    plot(s_guard, 'r');
    
    % Líneas entre símbolos
    xline((1:(num_symbols-1))*Lsymb)

    xlim([0, num_symbols*Lsymb])
    title(title_str);
    xlabel("Muestras");
    ylabel("Amplitud");
    ax = gca;
    ax.TitleFontSizeMultiplier = 3;
    hold off;
end

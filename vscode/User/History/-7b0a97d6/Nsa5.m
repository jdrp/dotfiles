
function plot_ofdm_signal(s, NFFT, l_cp, num_symbols, title_str)
    % Extract the portion of s to plot
    s_plot = s(1:(NFFT + l_cp)*num_symbols);
    
    % Initialize vectors for guard and data
    s_guard = zeros(size(s_plot));
    s_data = zeros(size(s_plot));
    
    for n = 0:num_symbols-1
        % Indices for prefix guard
        idx_guard = n*(NFFT + l_cp) + (1:l_cp);
        % Indices for data
        idx_data = n*(NFFT + l_cp) + (l_cp+1:NFFT + l_cp);
        
        % Assign values
        s_guard(idx_guard) = s_plot(idx_guard);
        s_data(idx_data) = s_plot(idx_data);
    end
    
    % Plot data samples in blue
    plot(s_data, 'b');
    hold on;
    
    % Plot prefix guard in red
    plot(s_guard, 'r');
    
    xline((1:num_symbols)*(NFFT+l_cp))
    title(title_str);
    xlabel("Muestras");
    ylabel("Amplitud");
    hold off;
end

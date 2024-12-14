function plotBER(snr_dB, m_arys, simulated_BER, theoretical_BER, orderNames, y_lines)
    % Function to plot BER for each m_ary and combined plot
    % Inputs:
    % snr_dB         - Vector of SNR values in dB
    % m_arys         - Vector of m_ary values
    % simulated_BER  - Simulated BER matrix (rows = m_ary, columns = SNR)
    % theoretical_BER - Theoretical BER matrix (rows = m_ary, columns = SNR)
    % y_lines        - (Optional) Vector of BER values to draw horizontal lines

    % Generate different colors for each modulation
    colors = lines(length(m_arys));

    % Combined plot for all m_ary values
    figure;
    hold on;

    % Initialize handles for legend
    h_line_sim = plot(NaN, NaN, '-o', 'Color', 'k', 'DisplayName', 'BER simulada');
    h_line_theo = plot(NaN, NaN, '--x', 'Color', 'k', 'DisplayName', 'BER teórica');
    h_colors = gobjects(length(m_arys), 1);

    % Plot theoretical and simulated BER for each m_ary
    for m_index = 1:length(m_arys)
        % Plot simulated BER
        semilogy(snr_dB, simulated_BER(m_index, :)+1e-30, '-o', ...
            'Color', colors(m_index, :));

        % Plot theoretical BER
        semilogy(snr_dB, theoretical_BER(m_index, :), '--x', ...
            'Color', colors(m_index, :));

        % Create dummy plots for color legend
        h_colors(m_index) = plot(NaN, NaN, '-', 'Color', colors(m_index, :), ...
            'LineWidth', 2, 'DisplayName', orderNames(m_index, :));
    end

    % Add optional y_lines to the combined plot
    if nargin == 5 && ~isempty(y_lines)
        for line_y = y_lines
            yline(line_y, '--', 'Color', [0.75 0.75 0.75]);
        end
    end

    % Customize combined plot
    title('Tasa de error con diferentes órdenes DPSK');
    xlabel('SNR (dB)');
    ylabel('BER');
    grid on;
    set(gca, 'YScale', 'log'); % Ensure a proper logarithmic scale
    ylim([1e-5, 1]); % Adjust y-axis limits for visibility

    % Create the legend
    legend([h_line_sim, h_line_theo, h_colors'], ...
        'Location', 'SouthWest');

    hold off;
end

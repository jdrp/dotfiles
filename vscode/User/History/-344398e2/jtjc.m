function plotBER(snr_dB, m_arys, simulated_BER, theoretical_BER, y_lines)
    % Function to plot BER for each m_ary and combined plot
    % Inputs:
    % snr_dB         - Vector of SNR values in dB
    % m_arys         - Vector of m_ary values
    % simulated_BER  - Simulated BER matrix (rows = m_ary, columns = SNR)
    % theoretical_BER - Theoretical BER matrix (rows = m_ary, columns = SNR)
    % y_lines        - (Optional) Vector of BER values to draw horizontal lines

    % Generate different colors for each modulation
    colors = lines(length(m_arys));

    % Individual plots for each m_ary
    for m_index = 1:length(m_arys)
        figure;
        semilogy(snr_dB, simulated_BER(m_index, :), '-o', ...
            'DisplayName', 'Simulated BER');
        hold on;
        semilogy(snr_dB, theoretical_BER(m_index, :), '-x', ...
            'DisplayName', 'Theoretical BER');

        % Add optional y_lines if provided
        if nargin == 5 && ~isempty(y_lines)
            for line_y = y_lines
                yline(line_y, '--', 'Color', [0.5 0.5 0.5], ...
                    'DisplayName', ['y = ' num2str(line_y)]);
            end
        end

        hold off;

        % Customize plot
        title(['BER for m-ary = ' num2str(m_arys(m_index))]);
        xlabel('SNR (dB)');
        ylabel('BER');
        legend('Location', 'SouthWest');
        grid on;
        set(gca, 'YScale', 'log'); % Ensure logarithmic scale for BER
        ylim([1e-5, 1]); % Adjust y-axis limits for visibility
    end

    % Combined plot for all m_ary values
    figure;
    hold on;

    % Plot theoretical and simulated BER for each m_ary
    for m_index = 1:length(m_arys)
        % Plot simulated BER
        semilogy(snr_dB, simulated_BER(m_index, :), '-o', ...
            'Color', colors(m_index, :), ...
            'DisplayName', ['Simulated BER, m-ary = ' num2str(m_arys(m_index))]);

        % Plot theoretical BER
        semilogy(snr_dB, theoretical_BER(m_index, :), '--x', ...
            'Color', colors(m_index, :), ...
            'DisplayName', ['Theoretical BER, m-ary = ' num2str(m_arys(m_index))]);
    end

    % Add optional y_lines to the combined plot
    if nargin == 5 && ~isempty(y_lines)
        for line_y = y_lines
            yline(line_y, '--', 'Color', [0.5 0.5 0.5], ...
                'DisplayName', ['y = ' num2str(line_y)]);
        end
    end

    % Customize combined plot
    title('Theoretical and Simulated BER for Different m-ary Values');
    xlabel('SNR (dB)');
    ylabel('BER');
    legend('Location', 'SouthWest');
    grid on;
    set(gca, 'YScale', 'log'); % Ensure a proper logarithmic scale
    ylim([1e-5, 1]); % Adjust y-axis limits for visibility

    hold off;
end
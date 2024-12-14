
% ---------------------------------------
% --------- PARA ELEGIR M_ARY------------
% ---------------------------------------
% Fixed parameters for the channel stability question
stability_time_ms = 100;  % Channel stable for 100 ms
chosenM_ary = 8;          % Fixed m-ary for this analysis

% OFDM symbol duration calculation
T_symbol = 1 / Fs;  % OFDM symbol duration (s)
max_symbols_per_frame = floor(stability_time_ms * 1e-3 / T_symbol); % Total symbols in 100 ms

% Number of symbols to test (reduced data points for faster computation)
symbols_per_frame = [10, 100, 500, 1000, 2000, max_symbols_per_frame];

% Preallocate for BER results
ber_vs_symbols = zeros(1, length(symbols_per_frame));

% Loop through each number of symbols and calculate BER
for idx = 1:length(symbols_per_frame)
    numSymbols = symbols_per_frame(idx);  % Update number of symbols
    % Test at SNR=12 dB (5th index in snr_dB)
    ber_vs_symbols(idx) = transceiverBlock(numSymbols, NFFT, firstCarrier, cpLength, ...
        chosenM_ary, numCarriers, generatorPolys, scramblerSeed, constellations(chosenM_ary), h, snr_dB(5));
end

% Plot BER vs. Number of Symbols
figure;
semilogy(symbols_per_frame, ber_vs_symbols, '-o', 'DisplayName', 'BER vs Symbols');
title('BER vs Number of OFDM Symbols per Frame');
xlabel('Number of OFDM Symbols per Frame');
ylabel('BER');
grid on;
legend('Location', 'NorthEast');



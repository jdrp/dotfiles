function Smod = modulator(bits, phi1, phi2)

    S1 = phi1 + phi2; % 1 1
    S2 = phi1 - phi2; % 1 -1
    S3 = -phi1 - phi2; % -1 -1
    S4 = -phi1 + phi2; % -1 1

    T = 10e-3;
    Ts = T/20;
    ts = Ts:Ts:T;


    % Plot the four modulated signals
    figure;

    subplot(2, 2, 1);
    plot(ts, S1);
    title('S1: [1, 1]');
    xlabel('Time (s)');
    ylabel('Amplitude');
    ylim([-16, 16]);

    subplot(2, 2, 2);
    plot(ts, S2);
    title('S2: [1, -1]');
    xlabel('Time (s)');
    ylabel('Amplitude');
    ylim([-16, 16]);

    subplot(2, 2, 3);
    plot(ts, S3);
    title('S3: [-1, -1]');
    xlabel('Time (s)');
    ylabel('Amplitude');
    ylim([-16, 16]);

    subplot(2, 2, 4);
    plot(ts, S4);
    title('S4: [-1, 1]');
    xlabel('Time (s)');
    ylabel('Amplitude');
    ylim([-16, 16]);

    N = length(bits) / 2;
    Smod = zeros(1, N * length(S2));

    for i = 1:length(bits)/2
        value = 2 * bits(2*i - 1) + bits(2*i);
        if value == 0
            Smod((i-1)*length(S2) + 1:i*length(S2)) = S1;
        elseif value == 1
            Smod((i-1)*length(S2) + 1:i*length(S2)) = S2;
        elseif value == 3
            Smod((i-1)*length(S2) + 1:i*length(S2)) = S3;
        else
            Smod((i-1)*length(S2) + 1:i*length(S2)) = S4;
        end
    end
end 
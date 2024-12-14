function Smod = modulator(bits, phi1, phi2)

    S0 = phi1 + phi2; % 1 1
    S1 = phi1 - phi2; % 1 -1
    S2 = -phi1 - phi2; % -1 -1
    S3 = -phi1 + phi2; % -1 1

    N = length(bits) / 2;
    Smod = zeros(1, N * length(S1));

    for i = 1:length(bits)/2
        value = 2 * bits(2*i - 1) + bits(2*i);
        if value == 0
            Smod((i-1)*length(S1) + 1:i*length(S1)) = S0;
        elseif value == 1
            Smod((i-1)*length(S1) + 1:i*length(S1)) = S1;
        elseif value == 3
            Smod((i-1)*length(S1) + 1:i*length(S1)) = S2;
        else
            Smod((i-1)*length(S1) + 1:i*length(S1)) = S3;
        end
    end
end 
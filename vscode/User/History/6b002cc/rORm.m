function Smod = modulator(N, phi1, phi2)

    S1 = phi1 + phi2; % 1 1
    S2 = phi1 - phi2; % 1 -1
    S3 = -phi1 - phi2; % -1 -1
    S4 = -phi1 + phi2; % -1 1

    Smod = zeros(1, N * length(S1));
    bits = randi([0 1],1, N * 2);

    for i = 1:length(bits)/2
        value = 2 * bits(2*i - 1) + bits(2*i);
        if value == 0
            Smod((i-1)*length(S1) + 1:i*length(S1)) = S1;
        elseif value == 1
            Smod((i-1)*length(S1) + 1:i*length(S1)) = S2;
        elseif value == 3
            Smod((i-1)*length(S1) + 1:i*length(S1)) = S3;
        else
            Smod((i-1)*length(S1) + 1:i*length(S1)) = S4;
        end
    end
end 
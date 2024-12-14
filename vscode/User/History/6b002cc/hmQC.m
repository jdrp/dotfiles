function Smod = modulator(N, phi1, phi2)

    S1 = phi1 + phi2;
    S2 = phi1 - phi2;
    S3 = -phi1 - phi2;
    S4 = -phi1 + phi2;

    Smod = zeros(1, N * length(S1));
    bits = randi([0 1],1, N * 2);

    for i = 1:length(bits)/2
        value = 2 * bits(2*i - 1) + bits(2*i);
    end
end 
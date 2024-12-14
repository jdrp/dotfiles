function Smod = modulator(bits, N, phi1, phi2)

    S1 = phi1 + phi2;
    S2 = phi1 - phi2;
    S3 = -phi1 - phi2;
    S4 = -phi1 + phi2;

    Smod = zeros(1, 

    for i = 1:length(bits)/2
    end
end 
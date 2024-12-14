function Smod = modulator(N, phi1, phi2)
    
    [phi1, phi2] = generateBase(T, Ts);
    S1 = phi1 + phi2;
    S2 = phi1 - phi2;
    S3 = -phi1 - phi2;
    S4 = -phi1 + phi2;
end 
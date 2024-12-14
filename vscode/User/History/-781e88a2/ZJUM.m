function [ts, s] = generateSignal(T, Ts, N)
    [S1, S2] = generateBase(T, Ts);

    alphabet = [1, -1];
    X = alphabet(randi([1,2], 1, N));

    s = zeros(1, N);
    for i = 1:N
        if X(i) == 1
            s = [s, S1];
        else
            s = [s, S2];
        end
    end

    ts = 0:Ts:N*T-Ts;
end
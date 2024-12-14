function [ts, s] = generateSignal(T, Ts, N)
    [S1, S2] = generateBase(T, Ts);

    alphabet = [1, -1];
    X = alphabet(randi([1,2], 1, N));

    s = zeros(1, N * length(S1)); % Preallocate s with the appropriate size
    index = 1;
    for i = 1:N
        if X(i) == 1
            s(index:index+length(S1)-1) = S1;
        else
            s(index:index+length(S2)-1) = S2;
        end
        index = index + length(S1);
    end

    ts = 0:Ts:N*T-Ts;
end
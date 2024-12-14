function [encodedBits] = convolutionalDecoder(bits, generatorPolys)
    numGenerators = size(generatorPolys, 1);
    % internal register states
    state = zeros(1, size(generatorPolys, 2));
    % output bits
    encodedBits = zeros(1, length(bits) * numGenerators);

    for i = 1:length(bits)
        % displace registers and insert new bit
        state(2:end) = state(1:end-1);
        state(1) = bits(i);

        for g = 1:numGenerators
            % multiply by generator and sum mod 2
            interValues = state .* generatorPolys(g, :);
            encodedBits((i - 1) * numGenerators + g) = mod(sum(interValues), 2);
        end
    end
    
end



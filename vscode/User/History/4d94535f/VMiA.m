function [encodedBits] = convolutionalEncoder(bits, generatorPolys)
    numGenerators = size(generatorPolys, 1);
    state = zeros(size(generatorPolys));
    encodedBits = zeros(1, length(bits) * numGenerators);

    for i = 1:length(bits)
        state(2:end) = state(1:end-1);
        state(1) = bits(i);

        for g = 1:numGenerators
            interValues = state .* generatorPolys(g);
            encodedBits((i - 1) * numGenerators + g) = mod(sum(interValues), 2);
        end
    end
    
end


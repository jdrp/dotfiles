function [encodedBits] = convolutionalEncoder(bits, generatorPolys)

    state = zeros(generatorPolys);
    encodedBits = zeros(1, length(bits) * length(generatorPolys));

    for i = 1:length(bits)
        state(2:end) = state(1:end-1);
        state(1) = bits(i);

        for j = 1:length(generatorPolys)
            encodedBits((i - 1) * length(generatorPolys) + j) = mod(sum(state .* generatorPolys(j, :)), 2);
        end
    end
    
    
    generator_polynomial_1 = [1 1 1 1 0 0 1]
    generator_polynomial_2 = [1 0 1 1 0 1 1]

    

function [encodedBits] = convolutionalEncoder(bits, generatorPolys)
    numGenerators = size(generatorPolys, 1);
    state = zeros(generatorPolys);
    encodedBits = zeros(1, length(bits) * numGenerators);

    for i = 1:length(bits)
        state(2:end) = state(1:end-1);
        state(1) = bits(i);

        

        encodedBits((i-1) * numGenerators + 1)
    end
    
    
    generator_polynomial_1 = [1 1 1 1 0 0 1]
    generator_polynomial_2 = [1 0 1 1 0 1 1]

    

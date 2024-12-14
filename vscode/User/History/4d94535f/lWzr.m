function [encodedBits] = convolutionalEncoder(bits, generatorPolys)

    state = zeros(size(generatorPolys));

    generator_polynomial_1 = [1 1 1 1 0 0 1]
    generator_polynomial_2 = [1 0 1 1 0 1 1]

    

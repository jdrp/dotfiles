function [encodedBits] = convolutionalEncoder(bits, generatorPolys)

    state = zeros(generatorPolys);

    encodedBits = zeros(1, length(bits) * length(generatorPolys));

    for i = 1:length(bits)
   
    end
    
    
    generator_polynomial_1 = [1 1 1 1 0 0 1]
    generator_polynomial_2 = [1 0 1 1 0 1 1]

    

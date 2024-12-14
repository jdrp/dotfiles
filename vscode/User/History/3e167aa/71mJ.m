function [] = transceiverBlock()
    % PARAMETROS
    bits = randi([0 1], 1, 10)
    generatorPolys = [1 1 1 1 0 0 1; 
                      1 0 1 1 0 1 1];

    convolutionalEncoder(bits, generatorPolys)

end
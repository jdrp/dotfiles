function [decodedBits] = convolutionalDecoder(encodedBits, generatorPolys)
    % Determine the constraint length from the generator polynomials
    constraintLength = size(generatorPolys, 2);
    numGenerators = size(generatorPolys, 1);
    
    % Initialize array to hold generator polynomials in octal format
    generatorOctal = zeros(1, numGenerators);
    
    % Convert binary generator polynomials to octal format
    for i = 1:numGenerators
        % Reverse the polynomial to match MATLAB's notation (highest power first)
        polyBits = fliplr(generatorPolys(i, :));
        % Convert binary bits to decimal
        polyDec = polyBits * (2.^(0:constraintLength-1))';
        % Convert decimal to octal string and then to numeric
        generatorOctal(i) = str2double(dec2base(polyDec, 8));
    end
    
    % Create trellis structure for the Viterbi decoder
    trellis = poly2trellis(constraintLength, generatorOctal);

    disp(trellis);

    disp(encodedSymbols);
    disp(size(encodedSymbols));

    % Set the traceback depth (typically 5 times the constraint length)
    tbdepth = 5 * constraintLength;
    
    % Number of bits per symbol
    N = log2(trellis.numOutputSymbols); % For rate 1/N code, N = numGenerators
    
    % Ensure encodedBits is a column vector
    encodedBits = encodedBits(:);
    
    % Check if the length of encodedBits is a multiple of N
    if mod(length(encodedBits), N) ~= 0
        error('Length of encodedBits must be a multiple of the number of bits per symbol.');
    end
    
    % Reshape encoded bits into symbols
    numSymbols = length(encodedBits) / N;
    encodedBitsMatrix = reshape(encodedBits, N, numSymbols).';
    
    % Convert each group of bits into a symbol
    encodedSymbols = bi2de(encodedBitsMatrix, 'left-msb');
    
    % Perform Viterbi decoding using hard-decision decoding
    decodedBits = vitdec(encodedSymbols, trellis, tbdepth, 'trunc', 'hard');
    
    % Return decoded bits as a row vector to match input format
    decodedBits = decodedBits.';
end
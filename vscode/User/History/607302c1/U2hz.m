function [decodedBits] = convolutionalDecoder(encodedBits, generatorPolys)
    if generatorPolys == [1]
        decodedBits = encodedBits;
        return;
    end

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

    % Set the traceback depth (typically 5 times the constraint length)
    tbdepth = max(5 * constraintLength, 32);

    % Ensure encodedBits is a column vector
    encodedBits = encodedBits(:);

    % Perform Viterbi decoding using hard-decision decoding
    decodedBits = vitdec(encodedBits, trellis, tbdepth, 'trunc', 'hard');

    % Return decoded bits as a row vector to match input format
    decodedBits = decodedBits.';
end
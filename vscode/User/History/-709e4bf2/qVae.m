function [scrambledBits] = scrambler(bits, seed, initialIndex)
    numBits = length(bits);
    scrambledBits = zeros(1, numBits);
    seedIndex = initialIndex;

    for i = 1:numBits
        
    end
end


function result = myFunction(a, b, c)
    % Default values
    if nargin < 3
        c = 10; % Default value for c
    end
    if nargin < 2
        b = 5;  % Default value for b
    end
    if nargin < 1
        a = 1;  % Default value for a
    end
    
    % Function logic
    result = a + b * c;
end
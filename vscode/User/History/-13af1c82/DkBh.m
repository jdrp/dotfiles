function testFun(a,b)
    arguments a=10; end  % default value
    arguments b(3,3) double {mustBePositive} = 10; end
    % arguments a(size1dim,size2dim) varType {validationFunction} = defaultValue; end
    disp(a);
 end
function [o1, o2] = correlatorType(T, Ts, r)
    [phi1, phi2] = generateBase(T, Ts);
    try 
        o1(1) = r(1) * phi1(1) * Ts;
        o2(1) = r(1) * phi1(1) * Ts;
        for i = 2:length(r)
            o1(i) = o1(i-1) + r(i) * phi1(i) * Ts;
            corr2 = corr2 + r(i) * phi2(i) * Ts;
        end
            
  
    catch exception
            disp(exception.message);
    end
end
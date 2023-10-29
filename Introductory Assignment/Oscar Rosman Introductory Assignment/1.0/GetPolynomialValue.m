% This function should return the value of the polynomial f(x) = a0x^0 + a1x^1 + a2x^2 ...
% where a0, a1, ... are obtained from polynomialCoefficients.

function value = GetPolynomialValue(polynomialCoefficients, x)
    value = 0;    
    for i = 1:length(polynomialCoefficients)                                % Loops over coefficients, multiplies them with the correct order of x and add them to function value of an n-dimensional polynomial
        value = value + polynomialCoefficients(i)*x^(i-1);
    end

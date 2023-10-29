% This method should return the coefficients of the k-th derivative (defined by
% the derivativeOrder) of the polynomial given by the polynomialCoefficients (see also GetPolynomialValue)

function derivativeCoefficients = DifferentiatePolynomial(polynomialCoefficients, derivativeOrder)
    iterator = 1;
    derivativeCoefficients = zeros(1, (length(polynomialCoefficients)-derivativeOrder)); % Predefine vector of the size that will be returned
    
    for i = (derivativeOrder + 1):length(polynomialCoefficients)
        multiplier = (factorial(i-1)/factorial(i-derivativeOrder-1));
        derivativeCoefficients(iterator) = polynomialCoefficients(i)*multiplier;    % Calculates the new coefficient making use of factorials with the formula
        iterator = iterator + 1;                                                    % d^k f/ d^k x = a*(n!/(n-k)!)
    end
end


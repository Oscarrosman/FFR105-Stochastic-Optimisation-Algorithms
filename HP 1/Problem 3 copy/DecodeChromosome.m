% Note: Each component of x should take values in [-a,a], where a = maximumVariableValue.

function x = DecodeChromosome(chromosome,numberOfVariables,maximumVariableValue)

    m = size(chromosome, 2); % chromosome length
    n = numberOfVariables; % Number of variables
    k = m/n; % bits (number of values) per gene in chromosome
    x = zeros(1, n);
    weights = zeros(1, k);
    tempVariable = 0;

    for j = 1:k
        weights(j) = 2^(-j);
    end
    
    for i = 1:n
       for j = 1:k
           tempVariable = tempVariable + chromosome(j + k*(i-1))*weights(j);
       end

       x(i) = -maximumVariableValue + 2*maximumVariableValue*tempVariable/(1-2^(-k));
       tempVariable = 0;

    end
end

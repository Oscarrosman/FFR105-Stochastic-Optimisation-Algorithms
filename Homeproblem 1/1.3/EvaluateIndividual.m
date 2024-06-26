% First compute the function value, then compute the fitness
% value; see also the problem formulation.

function fitness = EvaluateIndividual(x)

    g = @(x1, x2) (1.5 - x1 + x1*x2)^2 + (2.25 - x1 + x1*x2^2)^2 + ...
        (2.625 - x1 + x1*x2^3)^2; % Definition of function g(x1, x2)

    gValue = g(x(1), x(2)); % Calculation of function value
    fitness = (gValue + 1)^(-1); % Assigning fitness value

end
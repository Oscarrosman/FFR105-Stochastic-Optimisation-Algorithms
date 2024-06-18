% This function should return the gradient of f_p = f + penalty.
% You may hard-code the gradient required for this specific problem.

function gradF = ComputeGradient(x,mu)
    
    % Discrete functions
    DX1 = @(x1, x2, mu) (2*x1 - 2 + 4*mu*x1*((x1^2)+(x2^2)-1)); % dfp/dx1
    DX2 = @(x1, x2, mu) (4*x2 - 8 + 4*mu*x2*((x1^2)+(x2^2)-1)); % dfp/dx2
    g = @(x1, x2) ((x1^2) + (x2^2) -1); % Constraint
    gradF = [0, 0];

    if g(x(1), x(2)) > 0 % If condition decides if penalty is applied or not
        % Penalty
        gradF(1) = DX1(x(1), x(2), mu);
        gradF(2) = DX2(x(1), x(2), mu);
    else
        % No penalty
        gradF(1) = DX1(x(1), x(2), 0);
        gradF(2) = DX2(x(1), x(2), 0);
    end
end





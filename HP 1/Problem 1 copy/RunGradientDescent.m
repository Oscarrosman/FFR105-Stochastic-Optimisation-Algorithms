% This function should run gradient descent until the L2 norm of the
% gradient falls below the specified threshold.

function x = RunGradientDescent(xStart, mu, eta, gradientTolerance)

gradient = ComputeGradient(xStart, mu);
x = xStart - eta*gradient;

while true
    gradient = ComputeGradient(x, mu); % Find gradient
    gradientNorm = sqrt(gradient(1)^2+gradient(2)^2); % Finding the L2 norm of the point, can also be done with the function "norm(x)"

    if gradientNorm < gradientTolerance % Check for convergence (gradient below threshold)
        break
    end

    x = x - eta*gradient; % Find next x
end
end

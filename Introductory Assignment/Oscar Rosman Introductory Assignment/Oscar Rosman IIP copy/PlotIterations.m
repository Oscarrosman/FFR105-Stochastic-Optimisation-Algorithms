% This method should plot the polynomial and the iterates obtained
% using NewtonRaphsonStep (if any iterates were generated).

function PlotIterations(polynomialCoefficients, iterationValues)

    % Calculating necessary values for plotting
    xValues = iterationValues(2, :);
    fValues = iterationValues(1, :);
    xMax = max(xValues);
    xMin = min(xValues);
    xDelta = xMax - xMin;   % Calculating the variation in x-values
    xPlotRange = linspace(xMin - xDelta*0.5, xMax + xDelta*0.5);    % Defining the appropriate range of x while keeping the points derived from the method centered.
    fPlotValues = zeros(1, length(xPlotRange));
    for i = 1:length(xPlotRange)
        fPlotValues(i) = GetPolynomialValue(xPlotRange(i), polynomialCoefficients);     % Calculation of function values in the range of x previously defined.
    end

   % Plotting the figure
   figure(1)
   plot(xPlotRange, fPlotValues, 'LineWidth', 1)
   hold on
   scatter(xValues(1:length(xValues)-1), fValues(1:length(xValues)-1), 'black', 'LineWidth', 1)
   scatter(xValues(length(xValues)), fValues(length(xValues)), 'red', 'LineWidth', 1)   % Plots the final point from the method to assign a seperate color for clarity
   legend('Function values', 'Iterations', 'Found root', Location='northwest')

end

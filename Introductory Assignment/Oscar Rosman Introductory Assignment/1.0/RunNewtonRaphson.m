% This function should run the Newton-Raphson method, making use of the
% other relevant functions (StepNewtonRaphson, DifferentiatePolynomial, and
% GetPolynomialValue). Before returning iterationValues any non-plottable values 
% (e.g. NaN) that can occur if the method fails (e.g. if the input is a
% first-order polynomial) should be removed, so that only values that
% CAN be plotted are returned. Thus, in some cases (again, the case of
% a first-order polynomial is an example) there may be no points to plot.

function iterationValues = RunNewtonRaphson(polynomialCoefficients, startingPoint, tolerance)
    
    iIterations = 1;
    deltaF = tolerance * 2; % Set to above tolerance to allow first iteration in the loop, can be choosen arbitrarily bigger than tolerance
    x = [startingPoint];
    fValues = [];

    while (deltaF > tolerance)

        fValues(iIterations) = GetPolynomialValue(polynomialCoefficients, x(iIterations));

        fPrime = DifferentiatePolynomial(polynomialCoefficients, 1);
        fPrimeValue = GetPolynomialValue(fPrime, x(iIterations));

        fDoublePrime = DifferentiatePolynomial(polynomialCoefficients, 2);
        fDoublePrimeValue = GetPolynomialValue(fDoublePrime, x(iIterations));

        x(iIterations + 1) = StepNewtonRaphson(x(iIterations), fPrimeValue, fDoublePrimeValue);
        if isnan(x(iIterations + 1))
            error('f'''' equal to zero, check parameters. Process terminated.')
        end


        if iIterations > 1
            deltaF = abs(fValues(iIterations) - fValues(iIterations - 1));
        end

        iIterations = iIterations + 1;
    end


    iterationValues = [fValues; x(1:iIterations-1)];

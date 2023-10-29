% Script created in the course Stochastic Optimization
% Algorithms to solve the introductory assignment to implement the Newton -
% Raphson method.
% Author: Oscar Rosman
% Last modified: 3/9 - 2023


close all
clearvars
clc

polynomialCoefficients = [10 -2 -1 1];
startingPoint = 2;
tolerance = 0.0001;
iterationValues = RunNewtonRaphson(polynomialCoefficients, startingPoint, tolerance);
PlotIterations(polynomialCoefficients,iterationValues);

% Section designed for testing where the number of dimensions of the
% polynomial is randomly selected between 3 and 10 and the Coefficients are
% selected randomly between -10 and 10

% nDimensions = randi([3 10])
% polynomialCoefficients = randi([-10 10], 1, nDimensions)
% startingPoint = randi([-20 20])
% iterationValues = RunNewtonRaphson(polynomialCoefficients, startingPoint, tolerance);
% PlotIterations(polynomialCoefficients, iterationValues);
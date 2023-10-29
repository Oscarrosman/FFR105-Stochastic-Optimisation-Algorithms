%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Parameter specifications
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

populationSize = 100;              % Do NOT change
maximumVariableValue = 5;          % Do NOT change: (x_i in [-a,a], where a = maximumVariableValue)
numberOfGenes = 50;                % Do NOT change
numberOfVariables = 2;  	   % Do NOT change

tournamentSize = 5;                % Changes allowed
tournamentProbability = 0.6;      % Changes allowed (= pTour)
crossoverProbability = 0.8;        % Changes allowed (= pCross)
mutationProbability = 0.1;        % Changes allowed. (Note: 0.02 <=> 1/numberOfGenes)
numberOfGenerations = 2000;        % Changes allowed.

[maximumFitness, bestVariableValues] = RunFunctionOptimization(populationSize, numberOfGenes, numberOfVariables, maximumVariableValue, tournamentSize, ...
                                       tournamentProbability, crossoverProbability, mutationProbability, numberOfGenerations);

fprintf('Fitness: %1.10f, x(1): %0.10f, x(2): %0.10f', maximumFitness, bestVariableValues(1), bestVariableValues(2))

g = @(x1, x2) (1.5 - x1 + x1*x2)^2 + (2.25 - x1 + x1*x2^2)^2 + ...
        (2.625 - x1 + x1*x2^3)^2;

g(bestVariableValues(1), bestVariableValues(2))
1/maximumFitness

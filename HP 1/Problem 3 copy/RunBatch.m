%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Parameter specifications
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clearvars
close all
clc

numberOfRuns = 100;                % Do NOT change
populationSize = 100;              % Do NOT change
maximumVariableValue = 5;          % Do NOT change (x_i in [-a,a], where a = maximumVariableValue)
numberOfGenes = 50;                % Do NOT change
numberOfVariables = 2;		   % Do NOT change
numberOfGenerations = 300;         % Do NOT change
tournamentSize = 2;                % Do NOT change
tournamentProbability = 0.75;      % Do NOT change
crossoverProbability = 0.8;        % Do NOT change


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Batch runs
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Define more runs here (pMut < 0.02) ...

% mutationProbability = 0.02;
% sprintf('Mutation rate = %0.5f', mutationProbability)
% maximumFitnessList002 = zeros(numberOfRuns,1);
% for i = 1:numberOfRuns 
%  [maximumFitness, bestVariableValues]  = RunFunctionOptimization(populationSize, numberOfGenes, numberOfVariables, maximumVariableValue, tournamentSize, ...
%                                        tournamentProbability, crossoverProbability, mutationProbability, numberOfGenerations);
%  sprintf('Run: %d, Score: %0.10f', i, maximumFitness)
%   maximumFitnessList002(i,1) = maximumFitness;
% end

mutationProbability = linspace(0, 1, 50);
mutationProbability(2) = 0.02;
averageList = zeros(1, 50); medianList = averageList; stdList = averageList; highestFitnessList = averageList;
valueList = zeros(50, 4);
g = @(x1, x2) (1.5 - x1 + x1*x2)^2 + (2.25 - x1 + x1*x2^2)^2 + ...
        (2.625 - x1 + x1*x2^3)^2;
for pMut = 1:50
    fprintf('Mutation rate = %0.5f, Generation: %2.0f \n', mutationProbability(pMut), pMut)
    maximumFitnessList = zeros(numberOfRuns,1);
    for i = 1:numberOfRuns 
     [maximumFitness, bestVariableValues]  = RunFunctionOptimization(populationSize, numberOfGenes, numberOfVariables, maximumVariableValue, tournamentSize, ...
                                           tournamentProbability, crossoverProbability, mutationProbability(pMut), numberOfGenerations);
     maximumFitnessList(i, 1) = maximumFitness;
    end 
    valueList(pMut, :) = [mutationProbability(pMut), g(bestVariableValues(1), bestVariableValues(2)), bestVariableValues(1), bestVariableValues(2)];
    fprintf('   > Maximum fitness: %1.16f, Median fitness: %1.5f, X1 = %1.3f, X2 = %1.3f, g(x1, x2) = %1.5f \n \n', max(maximumFitnessList), median(maximumFitnessList), bestVariableValues(1), bestVariableValues(2), valueList(pMut, 2))
    averageList(pMut) = mean(maximumFitnessList);
    medianList(pMut) = median(maximumFitnessList);
    stdList(pMut) = sqrt(var(maximumFitnessList));
    highestFitnessList(pMut) = max(maximumFitnessList);
end

% Plotting

figure(1)

subplot(2, 2, 1)
plot(mutationProbability, medianList, LineWidth=2)
title('Median of maximum fitness')
ylabel('Median')
xlabel('Mutation probability')

subplot(2, 2, 2)
plot(mutationProbability, averageList, LineWidth=2)
title('Mean of maximum fitness')
ylabel('Mean')
xlabel('Mutation probability')

subplot(2, 2, 3)
plot(mutationProbability, stdList, LineWidth=2)
title('Standard deviation of maximum fitness')
ylabel('STD')
xlabel('Mutation probability')

subplot(2, 2, 4)
plot(highestFitnessList, mutationProbability, LineWidth=2)
title('Highest fitness value')
ylabel('Max fitness')
xlabel('Mutation probability')

figure(2)

subplot(2, 2, 1)
plot(medianList, mutationProbability, LineWidth=2)
title('Median of maximum fitness')
ylabel('Median')
xlabel('Mutation probability')

subplot(2, 2, 2)
plot(averageList, mutationProbability, LineWidth=2)
title('Mean of maximum fitness')
ylabel('Mean')
xlabel('Mutation probability')

subplot(2, 2, 3)
plot(stdList,  mutationProbability,LineWidth=2)
title('Standard deviation of maximum fitness')
ylabel('STD')
xlabel('Mutation probability')

subplot(2, 2, 4)
plot(highestFitnessList, mutationProbability, LineWidth=2)
title('Highest fitness value')
ylabel('Max fitness')
xlabel('Mutation probability')

% Table
fprintf('| PMut   | Median         | Average         | STD           | Max fitness  |\n')
fprintf('---------------------------------------------------------------------------- \n')
for i = 1:50
    fprintf('| %1.4f |  %1.10f  |   %1.10f  | %1.10f  | %1.10f |\n', mutationProbability(i), medianList(i), averageList(i), stdList(i), highestFitnessList(i))
end

% for i = 1:size(medianFitness, 1)
%     sprintf(' %0.4f  | %0.4f      | %0.4f     | %0.4f    |', mutationProbability(i), medianFitness(i), averageFitness(i), stdFitness(i))
% end
% and here (pMut > 0.02)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Summary of results
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Add more results summaries here (pMut < 0.02) ...

% average002 = mean(maximumFitnessList);
% median002 = median(maximumFitnessList);
% std002 = sqrt(var(maximumFitnessList));
% sprintf('PMut = 0.02: Median: %0.10f, Average: %0.10f, STD: %0.10f', median002, average002, std002)

% ... and here (pMut > 0.02)
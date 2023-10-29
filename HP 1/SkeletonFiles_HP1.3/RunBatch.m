%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Parameter specifications
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

close all
clearvars
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


% ... and here (pMut > 0.02)

mutationProbability = linspace(0, 1, 50);
mutationProbability(2) = 0.02;
medianPerformance = zeros(1, 50);
tic
for i = 1:50
    for j = 1:numberOfRuns
        [maximumFitness, bestVariableValues]  = RunFunctionOptimization(populationSize, numberOfGenes, numberOfVariables, maximumVariableValue, tournamentSize, ...
                                       tournamentProbability, crossoverProbability, mutationProbability(i), numberOfGenerations);
        sprintf('Run: %d, Score: %0.10f', j, maximumFitness)
        maximumFitnessList002(j,i) = maximumFitness;
    end
end
elapsedtime = toc;
sprintf('Simulation done after %d', elapsedtime)


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Summary of results
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Add more results summaries here (pMut < 0.02) ...

% average002 = mean(maximumFitnessList002);
% median002 = median(maximumFitnessList002);
% std002 = sqrt(var(maximumFitnessList002));
% sprintf('PMut = 0.02: Median: %0.10f, Average: %0.10f, STD: %0.10f', median002, average002, std002)

averageFitness = mean(maximumFitnessList002, 1);
medianFitness = median(maximumFitnessList002, 1);
stdFitness = sqrt(var(maximumFitnessList002, 1));

sprintf('| PMut  | Median  | Average  | STD    |')
sprintf('---------------------------------------')
for i = 1:size(medianFitness, 1)
    sprintf(' %0.4f  | %0.4f      | %0.4f     | %0.4f    |', mutationProbability(i), medianFitness(i), averageFitness(i), stdFitness(i))
end

figure(1)
plot(medianFitness, mutationProbability)

figure(2)
plot(mutationProbability, medianFitness)
% ... and here (pMut > 0.02)
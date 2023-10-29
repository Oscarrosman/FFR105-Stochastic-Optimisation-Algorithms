close all
clearvars
clc


numberOfRuns = 100;                % Do NOT change
populationSize = 100;              % Do NOT change
maximumVariableValue = 5;          % Do NOT change (x_i in [-a,a], where a = maximumVariableValue)
numberOfGenes = 50;                % Do NOT change
numberOfVariables = 2;		       % Do NOT change
numberOfGenerations = 300;         % Do NOT change
tournamentSize = 2;                % Do NOT change
tournamentProbability = 0.75;      % Do NOT change
crossoverProbability = 0.8;        % Do NOT change

population = InitializePopulation(populationSize, numberOfGenes);

fitness = zeros(populationSize, 1);

for i = 1:populationSize
    x = DecodeChromosome(population(i, :), numberOfVariables, maximumVariableValue);
    fitness(i, 1) = EvaluateIndividual(x);
end

winner1 = TournamentSelect(fitness, tournamentProbability, tournamentSize);
winner2 = TournamentSelect(fitness, tournamentProbability, tournamentSize);

crossed = Cross(winner1, winner2);
population(crossed(1), 1:19)

mutated = Mutate(population(crossed(1), :), 0.5);
Mutate(population(crossed(2), :), 0.25);

mutated(1:19)
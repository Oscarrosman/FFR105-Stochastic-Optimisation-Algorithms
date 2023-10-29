close all
clearvars
clc
format long


populationSize = 30;
numberOfGenes = 40;
crossoverProbability = 0.8;
mutationProbability = 0.025;
tournamentSelectionParameter = 0.75;
variableRange = 3.0;
fitness = zeros(populationSize, 1);

fitnessFigureHandle = figure;
hold on;
set(fitnessFigureHandle, ’Position’, [50,50,500,200]); set(fitnessFigureHandle, ’DoubleBuffer’,’on’); axis([1 numberOfGenerations 2.5 3]);
bestPlotHandle = plot(1:numberOfGenerations,zeros(1,numberOfGenerations)); textHandle = text(30,2.6,sprintf(’best: %4.3f’,0.0));
hold off;
drawnow;

population = InitializePopulation(populationSize, numberOfGenes);

for iGeneration = 1:100

    maximumFitness = 0.0; % Assumes non-negative fitness values! xBest = zeros(1,2); % [0 0]
    bestIndividualIndex = 0;
    for i = 1:populationSize
        chromosome = population(i,:);
        x = DecodeChromosome(chromosome, variableRange); 
        fitness(i) = EvaluateIndividual(x);
        if (fitness(i) > maximumFitness)
            maximumFitness = fitness(i); 
            bestIndividualIndex = i; 
            xBest = x;
        end
    end
    
    tempPopulation = population;
    
    for i = 1:2:populationSize
        individual1 = TournamentSelect(fitness,tournamentSelectionParameter);
        individual2 = TournamentSelect(fitness, tournamentSelectionParameter);
        chromosome1 = population(individual1, :);
        chromosome2 = population(individual2, :);
        tempPopulation(i, :) = chromosome1;
        tempPopulation(i+1, :) = chromosome2;
    
        r = rand;
    
        if r < crossoverProbability
            newChromosomePair = GACross(chromosome1, chromosome2);
            tempPopulation(i, :) = newChromosomePair(1, :);
            tempPopulation(i+1, :) = newChromosomePair(2, :);
        else
            tempPopulation(i, :) = chromosome1;
            tempPopulation(i+1, :) = chromosome2;
        end
    
    end
    
    for i = 1:populationSize
        originalChromosome = tempPopulation(i, :);
        mutatedChromosome = Mutate(originalChromosome, mutationProbability);
        tempPopulation(i, :) = mutatedChromosome;
    end
    
    
    tempPopulation(1,:) = population(bestIndividualIndex,:);
    population = tempPopulation;
    fitlist(iGeneration) = fitness(bestIndividualIndex);
    xplot(iGeneration) = iGeneration;
end

figure(1)
plot(xplot, fitlist)
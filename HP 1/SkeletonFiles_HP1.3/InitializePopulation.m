function population = InitializePopulation(populationSize,numberOfGenes)

    population = zeros(populationSize, numberOfGenes);

    for i = 1:populationSize
        population(i, :) = randi([0 1], 1, numberOfGenes);
    end
    
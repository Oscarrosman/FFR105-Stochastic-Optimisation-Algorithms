function population = InitializePopulation(populationSize, nGenes)

    population = zeros(populationSize, nGenes);

    for i = 1:populationSize
        population(i, :) = randi([0 1], 1, nGenes);
    end

end

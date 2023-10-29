function mutatedChromosome = Mutate(chromosome, mutationProbability)

    nGenes = length(chromosome);
    mutatedChromosome = chromosome;

    for i = 1:nGenes
        r =rand;
        if r < mutationProbability
            mutatedChromosome(i) = 1 - chromosome(i);
        end
    end
end



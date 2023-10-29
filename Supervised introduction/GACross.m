function newChromosomePair = GACross(chromosome1, chromosome2)

    nGenes = length(chromosome1);
    crossPoint = randi([1 nGenes]);

    transfer1 = chromosome1(crossPoint:nGenes);
    transfer2 = chromosome2(crossPoint:nGenes);

    chromosome1(crossPoint:nGenes) = transfer2;
    chromosome2(crossPoint:nGenes) = transfer1;

    newChromosomePair(1, :) = chromosome1;
    newChromosomePair(2, :) = chromosome2;

end

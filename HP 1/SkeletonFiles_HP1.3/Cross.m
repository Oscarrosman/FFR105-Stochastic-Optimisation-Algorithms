function newIndividuals = Cross(individual1, individual2)

    nGenes = size(individual1, 2);
    crossPoint = randi([1 nGenes]);

    transfer1 = individual1(crossPoint:nGenes);
    transfer2 = individual2(crossPoint:nGenes);

    individual1(crossPoint:nGenes) = transfer2;
    individual2(crossPoint:nGenes) = transfer1;
    
    newIndividuals(1, :) = individual1;
    newIndividuals(2, :) = individual2;

end


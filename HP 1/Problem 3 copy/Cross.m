function newIndividuals = Cross(individual1, individual2)

    nGenes = size(individual1, 2);
    crossPoint = randi([1 nGenes]);

    transfer1 = individual1(crossPoint:nGenes); % Temporary variables carrying the genes from one
    transfer2 = individual2(crossPoint:nGenes); % chromosome to the other

    individual1(crossPoint:nGenes) = transfer2; % Insertion of the new genes in the chromosomes
    individual2(crossPoint:nGenes) = transfer1;
    
    newIndividuals(1, :) = individual1; % Assigning the new individuals to the predefined variable
    newIndividuals(2, :) = individual2;

end
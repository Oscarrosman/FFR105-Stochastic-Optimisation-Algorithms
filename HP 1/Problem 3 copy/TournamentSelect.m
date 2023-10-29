function selectedIndividualIndex = TournamentSelect(fitnessList, tournamentProbability, tournamentSize)

    populationSize = size(fitnessList, 1);
    iIterator = 1;
    selectedIndividualIndex = 0;
    selectedIndividuals = randi([1 populationSize], tournamentSize, 1);     % Choses n-number of individuals from the population (fitness list) randomly
                                                                            % n is determined by tournament size.
    for i = 1:tournamentSize
        selectedIndividuals(i, 2) = fitnessList(selectedIndividuals(i, 1));
    end

    selectedIndividuals = sortrows(selectedIndividuals, 2, "descend");      % Sort the vector based on the fitness of the individuals fitness

    while iIterator <= tournamentSize
        r = rand();
        if r < tournamentProbability
            selectedIndividualIndex = selectedIndividuals(iIterator, 1);
            break
        end

        if iIterator == tournamentSize
            selectedIndividualIndex = selectedIndividuals(tournamentSize);
        end

        iIterator = iIterator + 1;
    end
end
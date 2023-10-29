function iSelected = TournamentSelect(fitness, pTournament)

    populationSize = size(fitness, 1);
    contestant1 = randi([1 populationSize]);
    contestant2 = randi([1, populationSize]);

    r = rand();

    if r < pTournament
        if (fitness(contestant1)) > (fitness(contestant2))
            iSelected = contestant1;
        else
            iSelected = contestant2;
        end
    else
        if (fitness(contestant1)) > (fitness(contestant2))
            iSelected = contestant2;
        else
            iSelected = contestant1;
        end
    end
end

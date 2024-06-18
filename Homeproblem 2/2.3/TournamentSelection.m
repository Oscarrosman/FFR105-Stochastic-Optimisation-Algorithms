function selectedIndividual = TournamentSelection(population, fitness, pTour, tourSize)

selectedIndividual = 0;
competingIndividuals = zeros(tourSize, 2);

% Selecting the instructed number of individuals randomly from the
% population
competingIndividuals(:, 1) = randi([1, size(population, 1)], tourSize, 1);

% Finding the corresponding fitness values
for i = 1:tourSize
    index = competingIndividuals(i, 1);
    competingIndividuals(i, 2) = fitness(index);
end

% Sorting according to fitness values
competingIndividuals = sortrows(competingIndividuals, 2, 'descend');

for i = 1:(tourSize - 1)
    % Selcting individual according to probability
    if rand < pTour
        selectedIndividual = population(competingIndividuals(i, 1), :);
        break
    end
end

% If no individual selected, the least fit individual is chosen
if selectedIndividual == 0
    selectedIndividual = population(competingIndividuals(size(competingIndividuals, 1), 1), :);
end
function path = GeneratePath(pheromoneLevel, visibility, alpha, beta)

currentCity = randi([1, size(pheromoneLevel, 1)]);  % Path starts at randomly selected city
% Setting up the parameters based on the starting city
path = zeros(size(pheromoneLevel, 1), 1);
path(1) = currentCity;
tabuList = zeros(size(pheromoneLevel, 1), 1);
tabuList(1) = currentCity;
visibility(:, currentCity) = 0; % Visibility to city set to zero to prevent revisiting (faster than checking tabu list)
iIterator = 2;

while tabuList(50) == 0
    % Find traversable edges from current city
    edges = (visibility(currentCity, :).^beta).*(pheromoneLevel(currentCity, :).^alpha);
    % Calculate probabilities for each edge
    probabilities = edges./sum(edges);
    % Select edge based on probability
    randomNumber = rand;
    selectedCity = find(cumsum(probabilities) >= randomNumber, 1, 'first');
    % Make sure selected edge do not lead to already visited city
    if ~ismember(selectedCity, tabuList)
        tabuList(iIterator) = selectedCity; % Adding city to tabu list
        visibility(:, selectedCity) = 0;    % Setting visibility to the city to 0
        path(iIterator) = selectedCity;     % Adding city to path
        currentCity = selectedCity;         % Setting to current city
        iIterator = iIterator + 1;
    end
end
end
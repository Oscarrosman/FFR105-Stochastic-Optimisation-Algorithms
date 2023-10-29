function tau0 = NearestNeighbourTour(cities)
cities
N = size(cities, 1);
startingCity = randi([1, N])
tabuList = zeros(N, 1);
distance = @(city1, city2) sqrt(((city1(1) - city2(1))^2) + ((city1(2) - city2(2))^2));
tabuList(1, :) = cities(startingCity, :);
path = zeros(N, 2); % [index, distance from previous city]


for i = 1:N
    iIterator = 1;
    distances = zeros(N, 2);
    for j = 1:N
        distances(j, :) = [j, distance(cities(i, :), cities(j, :))];
    end

    distances = sortrows(distances, 2);
    nearestNeighbor = 0;

    while nearestNeighbor == 0
        inList = ismember(distances(iIterator, 1), tabuList);

        if inList == 0
            nearestNeighbor = distances(iIterator);
            path(i, :) = distances(iIterator);
            tabuList(i) = distances(iIterator, 1);
        end

        iIterator = iIterator + 1;
    end

% calculate path length

tau0 = sum(path, 2);







end
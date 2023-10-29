function deltaPheromoneLevel = ComputeDeltaPheromoneLevels(pathCollection,pathLengthCollection)
    
    cities = size(pathCollection, 2);
    deltaPheromoneLevel = zeros(cities, cities);
    antPheromoneLevel = zeros(cities, cities);

    for i = 1:size(pathLengthCollection, 1)
        path = pathCollection(i, :);
        for j = 1:size(path, 2)
            if j < size(path, 2)
                antPheromoneLevel(path(j), path(j+1)) = 1/pathLengthCollection(i);
            else
                antPheromoneLevel(path(j), path(1)) = 1/pathLengthCollection(i);
            end
        end
        deltaPheromoneLevel = deltaPheromoneLevel + antPheromoneLevel;
        antPheromoneLevel = zeros(cities, cities);
    end
end
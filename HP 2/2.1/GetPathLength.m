function pathLength = GetPathLength(path, cityLocation)

EuclidianDistance = @(city1, city2) sqrt(((city1(1) - city2(1))^2) + ((city1(2) - city2(2))^2));
pathLength = 0;

for i = 1:(size(path, 1) - 1)
    city1 = path(i);
    city2 = path(i+1);
    distance = EuclidianDistance(cityLocation(city1, :), cityLocation(city2, :));
    pathLength = pathLength + distance;
end
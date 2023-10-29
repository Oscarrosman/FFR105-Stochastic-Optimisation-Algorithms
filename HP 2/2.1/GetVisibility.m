function visibility = GetVisibility(cityLocation)
    % Defining the descrete function for determining the distance for
    % clarity
    EuclidianDistance = @(city1, city2) sqrt(((city1(1) - city2(1))^2) + ((city1(2) - city2(2))^2));
    visibility = zeros(size(cityLocation, 1), size(cityLocation, 1));

    for i = 1:size(cityLocation, 1)
        for j = 1:size(cityLocation, 1)
            if i ~= j
                % Calculating the visibility based on the algorithm
                visibility(i, j) = 1/EuclidianDistance(cityLocation(i, :), cityLocation(j, :));
            end
        end
    end
end
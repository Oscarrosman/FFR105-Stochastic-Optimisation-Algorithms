function phermoneLevel = InitializePheromoneLevels(numberOfCities, tau0)

% All pheromone levels set to the same initial value (tau0)
phermoneLevel = tau0*ones(numberOfCities, numberOfCities);

end

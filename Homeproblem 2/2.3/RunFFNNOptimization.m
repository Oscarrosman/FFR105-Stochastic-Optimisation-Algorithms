% Should contain GA and FFNN
close all; clearvars; clc

%% Parameters
% GA parameters
n = 20; % Number of individuals
nTests = 10; % Number of tests conducted in evaluation [1 10]
testSet = 1;
pCross = 0.8;
pTour = 0.75;
tourSize = 5;
pMut = 50*1/62;
pCreep = 0.7;
creepRate = 0.1;
generation = 1;
fitnessSave = zeros(1, 1000);

% Network parameters
nHidden = 10; %10; % number of hidden neurons
nIn = 3; % Number of inputs
nOut = 2; % Number of outputs
wMax = 10; % Max weight
c = 2;
networkParameters = [nHidden, nIn, nOut, c];

% Truck parameters
mass = 20000;
vMax = 25;
vMin = 1;
gear = 7;
pDriver0 = 0.0;
v0 = 20;
timeStep = 0.1;
tempBreak = 500;
tempAmb = 283;
tempMax = 750;
tao = 30;
alphaMax = 10;
Ch = 40;
truckParameters = [mass, vMax, gear, pDriver0, v0, timeStep, tempBreak, tempAmb, tempMax, tao, alphaMax, Ch, vMin];

%% Initialization
% n chromosomes with the correct number of genes are created and encoded.

genes = nHidden*(nIn + 1) + nOut*(nHidden + 1);
population = zeros(n, genes);

% Assigning weights within range [-wMax, wMax]
for i = 1:n
    wIH = 2*wMax*rand(nHidden, (nIn + 1)) - wMax;
    wHO = 2*wMax*rand(nOut, (nHidden + 1)) - wMax;
    population(i, :) = EncodeNetwork(wIH, wHO, wMax);
end


for iIterator = 1:1000
    %% Evaluation
    fitness = zeros(size(population, 1), 1);
    fVal = zeros(size(population, 1), 1);
    
    % Assign fitness values for training set
    for i = 1:size(population, 1)
        chromosome = population(i, :);
        [wIH, wHO] = DecodeChromosome(chromosome, nIn, nHidden, nOut, wMax);
        fitness(i) = EvaluateIndividual(wIH, wHO, truckParameters, ...
            networkParameters, nTests, testSet);
    end
    
    % Assigning fitness values for validation set
    for i = 1:size(population, 1)
        chromosome = population(i, :);
        [wIH, wHO] = DecodeChromosome(chromosome, nIn, nHidden, nOut, wMax);
        fVal(i) = EvaluateIndividual(wIH, wHO, truckParameters, ...
            networkParameters, 5, 2);
    end
    
    
    %% Next generation
    
    newGeneration = zeros(size(population, 1), size(population, 2));
    
    % Find best values
    [maxValue, maxIndex] = max(fitness);
    maxValueVal = fVal(maxIndex);
    
    % Practice elitism
    newGeneration(1, :) = population(maxIndex, :);
    newGeneration(2, :) = Mutation(population(maxIndex, :), pMut, pCreep, creepRate);
    
    for i = 3:(size(newGeneration, 1) - 2)
        
        % Selection: Tournament selection
        
        individual1 = TournamentSelection(population, fitness, pTour, tourSize);
        individual2 = TournamentSelection(population, fitness, pTour, tourSize);
        
        % Crossover
        r = rand;
        if r < pCross
            [individual1, individual2] = Crossover(individual1, individual2);
        end

        % Mutation with creep
        
        individual1 = Mutation(individual1, pMut, pCreep, creepRate);
        individual2 = Mutation(individual2, pMut, pCreep, creepRate);

        newGeneration(i, :) = individual1(1, :);
        newGeneration(i+1, :) = individual2(1, :);

    end
    
    if mod(iIterator, 100) == 0
        fprintf('Generation: %2d, Max fitness: %1.5f \n', iIterator, maxValue)
    end
    
    % Save fitness value for later plot
    fitnessSave(iIterator) = maxValue;
    fValSave(iIterator) = maxValueVal;
    
    % Condition for stopping GA when overfitting
    if fValSave(iIterator) < fitnessSave(iIterator)
        if iIterator > 200
            break
        end
    else
        lastGenerationBest = newGeneration(1, :);
    end

    population = newGeneration;

end

% Evaluate best individual on validation and test set

[wIH, wHO] = DecodeChromosome(lastGenerationBest, nIn, nHidden, nOut, wMax);

EvaluateIndividual(wIH, wHO, truckParameters, networkParameters, 5, 2);

EvaluateIndividual(wIH, wHO, truckParameters, networkParameters, 5, 3);

% Plot fitness history of training and validation set
x = linspace(1, iIterator, iIterator);

figure(1)
plot(x, fitnessSave(1, 1:iIterator), 'red', LineWidth=2)
hold on
plot(x, fValSave, 'blue', LineWidth=1)
ylim([0 1])
xlabel('Iterations')
ylabel('Fitness value')
legend('Training', 'Validation')

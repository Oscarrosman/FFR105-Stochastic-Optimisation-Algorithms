function RunTest
close all; clearvars; clc;

%% Parameters

% Run parameters
chromosome = BestChromosome;
iSlope = 1;
iDataSet = 2;

% Network parameters
nHidden = (size(chromosome, 2) - 2)/6; %10; % number of hidden neurons
nIn = 3; % Number of inputs
nOut = 2; % Number of outputs
wMax = 10; % Max weight
c = 2;

% Truck parameters
alphaMax = 10;
Ch = 40;
gear = 7;
gearChange = -2;
mass = 20000;
pDriver = 0.0;
tao = 30;
time = 0;
timeStep = 0.1;
tempAmb = 283;
tempBreak = 500;
tempMax = 750;
velocity = 20;
velocityMax = 25;
velocityMin = 1;
x = 0;

% Data save
dataSave = zeros(6, 1);
iIterator = 1;

[wIH, wHO] = DecodeChromosome(chromosome, nIn, nHidden, nOut, wMax);
truckParameters = [mass, 0, 0, 0, 0, timeStep, 0, 0, tempMax];

%% Modelling of run

while x <= 1000
    % Run truck one timestep

    alpha = GetSlopeAngle(x, iSlope, iDataSet);

    velocity = TruckModel(alpha, velocity, pDriver, gear, tempBreak, truckParameters);

    % Find states of truck

    x = x + velocity*timeStep;
    
    if pDriver < 0.01
        deltaTemp = -(tempBreak - tempAmb)/ tao;
    else
        deltaTemp = Ch * pDriver;
    end

    tempBreak = tempBreak + deltaTemp*timeStep;

    % Submitt to network

    input = [velocity/velocityMax, alpha/alphaMax, tempBreak/tempMax];

    v1 = sum(wIH(:, 1:size(input, 2)).*input, 2) + wIH(:, size(input, 2) + 1);

    v1 = 1./(1 + exp(-c*v1));

    v2 = wHO(:, 1:size(v1, 1)) * v1 + wHO(:, size(v1, 1) + 1);

    v2 = 1./(1 + exp(-c*v2));

    % Update according to network

    pDriver = v2(1);

    dGear = v2(2);

    % Gear change is interpreted such as < 0.4 go down, 0.4-0.6
    % unchanged, > 0.6 go up

    if dGear > 0.6
        if gearChange + 2 < time
            gear = gear + 1;
            if gear > 10
                gear = 10;
            end
            gearChange = time;
            %fprintf('Gear change (up), gear: %2d \n', gear)
        end
    elseif dGear < 0.4
        if gearChange + 2 < time
            gear = gear - 1;
            if gear < 1
                gear = 1;
            end
            gearChange = time;
            %fprintf('Gear change (down), gear: %2d \n', gear)
        end
    end

    time = time + timeStep;

    % Save of data
    dataSave(:, iIterator) = [alpha, pDriver, gear, velocity, tempBreak, x];
    iIterator = iIterator + 1;

    % Find if run have to be cancelled

    if tempBreak > tempMax
        break
    elseif velocity > velocityMax
        break
    elseif velocity < velocityMin
        break
    end


end

%% Printing and plotting results

fitness = ((x/time)/velocityMax)*(x/1000)^4;

if x >= 1000
    fprintf('Course completed \n > Avg speed: %2.2f m/s \n > Time: %3.2f s \n > Fitness: %1.4f \n', (x/time), time, fitness)
else
    fprintf('Course failed \n > Avg speed: %2.2f m/s \n > Final speed: %2.2f \n > Distance: %4d \n > Break temperature: %3.1f \n > Fitness: %1.4f \n', (x/time), velocity, x, tempBreak, fitness)
end

figure(1)

% Alpha
subplot(2, 3, 1)
plot(dataSave(6, :), dataSave(1, :), LineWidth=2)
title('Slope angle (alpha)')
xlim([0, 1000])
ylim([0, 12])
yline(10, 'red')

% Brake pedal preasure
subplot(2, 3, 2)
plot(dataSave(6, :), dataSave(2, :), LineWidth=2)
title('Brake pedal preasure')
xlim([0, 1000])
ylim([-0.2 1.2])
yline(0.01, 'red')

% Gear
subplot(2, 3, 3)
plot(dataSave(6, :), dataSave(3, :), LineWidth=2)
title('Gear')
xlim([0, 1000])
ylim([0, 11])

% Velocity
subplot(2, 3, 4)
plot(dataSave(6, :), dataSave(4, :), LineWidth=2)
title('Velocity')
xlim([0, 1000])
ylim([0, 26])
yline(velocityMax, 'red')
yline(velocityMin, 'red')

% Brake temperature
subplot(2, 3, 5)
plot(dataSave(6, :), dataSave(5, :), LineWidth=2)
title('Brake temperature')
xlim([0, 1000])
ylim([0, 800])
yline(tempMax, 'red')
function minima = RunPSO
% PSO algorithm as described in chapter 5
% Written by Oscar Rosman
% Last modified: 5/10-2023
close all; clearvars; clc;

%% Parameters
% Stopping criteria
stop = 100; % # of iterations

% Initialization parameters
xMax = 5;
xMin = -5;
vMax = 0.1*xMax;
N = 100; % Number of particles, common start: [20-50]
d = 2; %dimensions
alpha = 1; % Constant
dT = 1; % Timestep

% Update parameters
% Linear decreasing inertia
w = 1.4;                % Starting inertia
wDecay = 0.99;          % Inertia decay rate, loses 0.1% every iteration
wLow = 0.3;             % Inertia lower limit

% Parameters
c1 = 1.65;              % Cognitive coefficient [1.3 2.0]
c2 = 1.65;              % Social coefficient [1.3 2.0]
q = 0.3;                % Constant inertia
r = 0.1*(xMax - xMin);  % Visibility radius [0.1 0.2] of search space
crazyO = 0.1;           % Craziness operator [0, 1] typically very low



%% Initialize particles
[positions, velocities] = Initialization(N, d, xMax, xMin, alpha, dT);
fitnessPB = 1000*ones(N, 3); % Best fitness initially set to 100
fitnessSB = [1000, 0, 0];


for iIterations = 1:stop

    %% Evaluate positions
    % Fitness value is set to function value in the evaluation. Since the 
    % objective is to minimize the function a lower fitness value will be
    % considered better.
    
    fitness = Evaluation(positions);
    
    %% Update the best positions
    % Positions are updated if the current fitness is lower than the one saved.
    
    for i = 1:N
        % Saving fitness and position to particle best
        if fitness(i) < fitnessPB(i)
            fitnessPB(i, :) = [fitness(i), positions(i, 1), positions(i, 2)];
        end
    
        % Saving fitness and position to swarm best
        if fitness(i) < fitnessSB(1, 1)
            fitnessSB(1, :) = [fitness(i), positions(i, 1), positions(i, 2)];
        end
    end
    
    %% Update velocities and positions
    
    for i = 1:N
        % Velocity update according to algorithm 5.1 with added inertia
        velocities(i, :) = VelocityUpdate(velocities(i, :), positions(i, :), ...
            c1, q, c2, r, vMax, fitnessPB(i, 2:3), fitnessSB(1, 2:3), dT);
    
        % Implementation of craziness operator to mutate velocity with low
        % probability
        if rand < crazyO
            velocities(i, 1) = (alpha/dT)*(-(xMax - xMin)/2 +r*(xMax - xMin));
            velocities(i, 2) = (alpha/dT)*(-(xMax - xMin)/2 +r*(xMax - xMin));
        end
        
        % Position update
        positions(i, :) = positions(i, :) + velocities(i, :)*dT;
    end
    
    % Reducing the linear inertia until limit is reached
    if w > wLow
        w = w*wDecay;
    end
    

end

minima = PlotResults(fitnessPB, [xMin, xMax]);

end

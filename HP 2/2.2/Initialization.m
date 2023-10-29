function [positions, velocities] = Initialization(N, d, xMax, xMin, alpha, dT) % Number of particles, dimensions, xMax and xMin, alpha, timestep

positions = zeros(N, d);
velocities = zeros(N, d);

% Positions and velocities initialized as in course book

for i = 1:N
    for j = 1:d
        r = rand;
        positions(i, j) = xMin + r*(xMax - xMin);
        r = rand;
        velocities(i, j) = (alpha/dT)*(-(xMax - xMin)/2 +r*(xMax - xMin));
    end
end
end
function fitness = EvaluateIndividual(wIH, wHO, truckParameters, networkParameters, nTests, testSet)

% Truck
velocityMax = truckParameters(2);
velocityMin = truckParameters(13);
timeStep = truckParameters(6);
tempMax = truckParameters(9);
tao = truckParameters(10);
alphaMax = truckParameters(11);
Ch = truckParameters(12);

% Network
c = networkParameters(4);

testResult = zeros(nTests, 2); % Stores average speed and distance travelled

for i = 1:nTests
    % Reset conditions
    velocity = truckParameters(5);
    gear = truckParameters(3);
    pDriver = truckParameters(4);
    tempBreak = truckParameters(7);
    tempAmb = truckParameters(8);
    gearChange = -2;
    time = 0;
    x = 0;
    while x <= 1000
        % Run truck one timestep

        alpha = GetSlopeAngle(x, i, testSet);

        velocity = TruckModel(alpha, velocity, pDriver, gear, tempBreak, truckParameters);

        % Find states of truck

        x = x + velocity*timeStep;
        
        if pDriver < 0.01
            deltaTemp = -(tempBreak - tempAmb)/ tao;
        else
            deltaTemp = Ch * pDriver;
        end

        tempBreak = tempBreak + deltaTemp*timeStep;

        % Find if run have to be cancelled

        if tempBreak > tempMax
            break
        elseif velocity > velocityMax
            break
        elseif velocity < velocityMin
            break
        end

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
            end
        elseif dGear < 0.4
            if gearChange + 2 < time
                gear = gear - 1;
                if gear < 1
                    gear = 1;
                end
                gearChange = time;
            end
        end

        time = time + timeStep;

    end
    
    % Print result
    testResult(i, :) = [x/time, x];
    if testSet == 2
        % Validation
        if x >= 1000
            %fprintf('\n Validation course: %2d completed \n > Avg. speed: %2.2f \n', i, testResult(i, 1))
        else
            %fprintf('\n Validation course: %2d failed \n > Speed: %2.2f \n > Distance: %2.2f m \n > Temp: %3d \n \n', i, velocity, x, tempBreak)
        end
    elseif testSet == 3
        % Test
        if x >= 1000
            fprintf('\n Test course: %2d completed \n > Avg. speed: %2.2f \n \n', i, testResult(i, 1))
        else
            fprintf('\n Test course: %2d failed \n > Speed: %2.2f \n > Distance: %2.2f m \n > Temp: %3d \n \n', i, velocity, x, tempBreak)
        end
    end

end

fitness = (mean(testResult(:, 1))/25)*(sum(testResult(:, 2))/(nTests*1000))^4;





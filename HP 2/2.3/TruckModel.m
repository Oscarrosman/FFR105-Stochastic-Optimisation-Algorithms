function velocity = TruckModel(alpha, velocity, pDriver, gear, tempBreak, truckParameters)

%% Local parameters

mass = truckParameters(1);
tempMax = truckParameters(9);
timeStep = truckParameters(6);
g = 9.81;
Cb = 3000;
engineBreakForce = [7.0, 5.0, 4.0, 3.0, 2.5, 2.0, 1.6, 1.4, 1.2, 1.0];

%% Determine forces

Fg = mass*g*sind(alpha);

Feb = engineBreakForce(gear)*Cb;

if tempBreak < (tempMax-100)
    Fb = (mass*g/20)*pDriver;
else
    Fb = (mass*g/20)*pDriver*exp(-(tempBreak-(tempMax - 100))/100);
end

%% Determine velocity

acceleration = (Fg - Fb - Feb)/mass;

velocity = velocity + acceleration*timeStep;

end








    





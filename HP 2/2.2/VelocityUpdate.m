function velocity = VelocityUpdate(velocity, position, c1, q, c2, r, vMax, positionPB, positionSB, dT)
% Velocity update according to algorithm 5.1, step 4.1
velocity = velocity + c1*q*((positionPB - position)./dT) + c2*r*((positionSB - position)./dT);

% Restricting the velocity to [-vMax, vMax]
if velocity > vMax
    velocity = vMax;
elseif velocity < -vMax
    velocity = -vMax;
end
end
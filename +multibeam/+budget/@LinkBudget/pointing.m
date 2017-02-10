function [ lpt ] = pointing(this,thetaB)
%POINTING Losses due to pointing error
% Input parameters:
%   thetaB      : Half-power beamwidth [deg]
% Output parameters:
%   lpt         : Pointing losses [dB]

if (thetaB < this.point)
    lpt = 0;
else
    lpt = 12*(this.point/thetaB)^2;
end
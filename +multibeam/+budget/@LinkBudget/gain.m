function gain = gain(this,latB,lonB,latE,lonE,thetaB)
%GAIN Normalized multibeam radiation pattern
% Input parameters:
%   latB,lonB   : Beam center coordinates [deg]
%   latE,lonE   : Ground station coordinates [deg]
%   thetaB      : Half-power beamwidth [deg]
% Output parameters:
%   gain        : Multibeam gain coefficient [dB]

% Repeat scalar coordinates to ease calculations
if isscalar(latB)
    latB = repmat(latB,size(latE));
end
if isscalar(lonB)
    lonB = repmat(lonB,size(lonE));
end

%% Angle between (latB,lonB) and (latE,lonE)
% Transform into local cartesian ENU coordinates with origin at the
% sub-satellite point
[x0,y0,z0] = geodetic2enu(...
    latB,lonB,0,0,this.lonS,this.altS,this.geoid);
[x1,y1,z1] = geodetic2enu(...
    latE,lonE,0,0,this.lonS,this.altS,this.geoid);

% Construct Nx3 matrices of coordinates
% Both inputs to cross() and dot() must be of equal size
U = horzcat(x0,y0,z0);
V = horzcat(x1,y1,z1);

% Helper function to calculate the 2-norm of X along dimension p
norm = @(X,p) sqrt(sum(abs(X).^2,p));
% Calculate angle between vectors
theta = atan2d(norm(cross(V,U,2),2),dot(V,U,2)); % [deg]

%% Gain coefficient
% Normalized radiation pattern in a multibeam satellite
u = 2.07123*sind(theta)/sind(thetaB/2);
b = abs(besselj(1,u)./(2*u)+36*besselj(3,u)./(u.^3));

% Evaluating b() for theta=0 yields a NaN due to division by zero
% Gain at this angle is maximum, so the coefficient should equal 0 dB
gain = zeros(size(b)); % [dB]
gain(theta ~= 0) = 20*log10(b); % [dB]
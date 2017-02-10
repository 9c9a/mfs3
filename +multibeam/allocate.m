function [ tbl ] = allocate(lonS,altS,radius,latLimit,lonLimit,tilt)
%ALLOCATE Allocate user beam centers optimally across given region
% Input parameters:
%   lonS,altS   : Satellite coordinates [deg,km]
%   radius      : Beam radius on Earth's surface [km]
%   latLimit    : Region limits in latitude [deg]
%   lonLimit    : Region limits in longitude [deg]
% Optional parameters:
%   tilt        : Grid axial tilt [deg]
% Output parameters:
%   tbl         : User beam coordinate table

% Check for input arguments
narginchk(5,6)
% Initialize optional tilt angle
if nargin<6; tilt = 0; end

% Reference ellipsoid for Earth's surface
geoid = referenceEllipsoid('sphere','km');
% Mean radius of the Earth
Re = geoid.MeanRadius;

%% Calculate step sizes
% Distance between beam centers, equal to the
% diameter of the circle inscribed in the hexagonal cell
D = sqrt(3)*radius;
% Step sizes in geodetic coordinates
dlat = 2*asind(D/(2*Re));
dlon = 2*asind(D*cosd(30)/(2*Re));

%% Calculate number of points
% Given (lat,lon) coordinate limits, calculate necessary
% number of points to cover the entire region
Ny = ceil(range(latLimit)/dlat);
Nx = ceil(range(lonLimit)/dlon);
% Number of beams
Nb = Nx*Ny;

%% Generate normalized grid
% Normalized rectangular grid
[X,Y] = meshgrid((1:Nx)-0.5,(1:Ny)-0.5);
% Offset even columns by D/2 to achieve optimal cell packing
Y(:,2:2:end) = Y(:,2:2:end)-0.5;

% Apply rotation of axes (tilt)
U = X*cosd(tilt)-Y*sind(tilt);
V = X*sind(tilt)+Y*cosd(tilt);

%% Transform into geodetic coordinates
% Denormalize grid
% Offset coordinates from local origin
lat = V*dlat+min(latLimit);
lon = U*dlon+min(lonLimit);

% Reshape into column vectors
lat = reshape(lat,Nb,1);
lon = reshape(lon,Nb,1);

%% Calculate local spherical AER towards satellite
[A,E,R] = geodetic2aer(0,lonS,altS,lat,lon,0,geoid);

%% Create beam coordinate table
names = {'Number','Lat','Lon','Az','El','Range'};

tbl = table((1:Nb).',lat,lon,A,E,R,'VariableNames',names);
tbl = sortrows(tbl,'Number');
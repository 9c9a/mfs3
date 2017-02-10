function [ tbl ] = geogrid(lonS,altS,step,latLimit,lonLimit)
%GEOGRID Generate coordinate grid table for calculations
% Input parameters:
%   lonS 		: Satellite longitude [deg]
%	altS		: Satellite altitude [km]
%	step		: Step size in latitude and longitude [deg]
%   latLimit    : Region limits in latitude [deg]
%   lonLimit    : Region limits in longitude [deg]
% Output parameters:
%   tbl         : Grid coordinate table

% Check for input arguments
narginchk(5,5)

%% Calculate number of points
% Given (lat,lon) coordinate limits, calculate necessary
% number of points to cover the entire region
Nx = ceil(range(lonLimit)/step)+1;
Ny = ceil(range(latLimit)/step)+1;
% Number of points
Np = Nx*Ny;

%% Generate grid in geodetic coordinates
% Normalized rectangular grid
[X,Y] = meshgrid(0:Nx-1,0:Ny-1);

% Denormalize grid
% Offset coordinates from local origin
lat = Y*step+min(latLimit);
lon = X*step+min(lonLimit);

% Reshape into column vectors
lat = reshape(lat,Np,1);
lon = reshape(lon,Np,1);

%% Calculate local spherical AER towards satellite
% Reference ellipsoid for Earth's surface
geoid = referenceEllipsoid('sphere','km');
% Azimuth, elevation and slant range
[A,E,R] = geodetic2aer(0,lonS,altS,lat,lon,0,geoid);

%% Create coordinate grid table
names = {'Lat','Lon','Az','El','Range'};

tbl = table(lat,lon,A,E,R,'VariableNames',names);
tbl = sortrows(tbl,{'Lon','Lat'});
function [ hR ] = rainHeight(lat,lon)
%RAINHEIGHT Yearly average rain height above sea level (ITU-R P.839-4)
% Input parameters:
%   lat,lon     : Ground station coordinates [deg]
% Output parameters:
%   hR          : Mean annual rain height above mean sea level [km]


%% Reshape coordinates into grid
% Number of unique coordinate points
Ny = length(unique(lat));
Nx = length(unique(lon));
% Coordinates must be sorted by {Lon,Lat} for this to work
lat = reshape(lat,Ny,Nx);
lon = reshape(lon,Ny,Nx);

% Maps are provided from 0º to 360º in longitude
lon(lon<0) = lon(lon<0)+360;

%% Import ITU-R P.839-4 maps
pathname = '+itu/R-REC-P.839-4';

% Grid longitude and latitude points [deg]
lat0 = dlmread(fullfile(pathname,'LAT.txt'));
lon0 = dlmread(fullfile(pathname,'LON.txt'));
% Mean annual 0°C isotherm height above mean sea level [km]
data = dlmread(fullfile(pathname,'h0.txt'));

%% Interpolate at (lat,lon)
% Bilinear interpolation of data
h0 = interp2(lon0,lat0,data,lon,lat,'linear');
% Reshape into column vector matching (lat,lon)
h0 = reshape(h0,Ny*Nx,1);

% Mean annual rain height above mean sea level [km]
hR = h0+0.36;
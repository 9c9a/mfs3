function [ hR ] = rainHeight(lat,lon)
%RAINHEIGHT Yearly average rain height above sea level (ITU-R P.839-4)
% Input parameters:
% 	lat,lon     : Ground station coordinates [deg]
% Output parameters:
%   hR          : Mean annual rain height above mean sea level [km]
%
% Note:
%   The function automatically loads meteorological input parameters 
%   required by Rec. ITU-R P.839-4 from the following files:
% 		lat.txt : latitudes of grid points (90:-1.5:-90) [deg]
%       Lon.txt : longitudes of grid points (0:1.5:360) [deg]
%       h0.txt 	: mean annual 0�C isotherm height [km]


%% Reshape coordinates into grid
% Number of unique coordinate points
Ny = length(unique(lat));
Nx = length(unique(lon));
% Coordinates must be sorted by {Lon,Lat} for this to work
lat = reshape(lat,Ny,Nx);
lon = reshape(lon,Ny,Nx);

% Maps are provided from 0� to 360� in longitude
lon(lon<0) = lon(lon<0)+360;

%% Import ITU-R P.839-4 maps
[pathstr,~,~] = fileparts(mfilename('fullpath'));
folder = 'R-REC-P.839-4';

% Grid longitude and latitude points [deg]
lat0 = dlmread(fullfile(pathstr,folder,'LAT.txt'));
lon0 = dlmread(fullfile(pathstr,folder,'LON.txt'));
% Mean annual 0�C isotherm height above mean sea level [km]
data = dlmread(fullfile(pathstr,folder,'h0.txt'));

%% Interpolate at (lat,lon)
% Bilinear interpolation of data
h0 = interp2(lon0,lat0,data,lon,lat,'linear');
% Reshape into column vector matching (lat,lon)
h0 = reshape(h0,Ny*Nx,1);

% Mean annual rain height above mean sea level [km]
hR = h0+0.36;
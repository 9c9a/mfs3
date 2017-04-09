function [ alt ] = topoHeight(lat,lon)
%TOPOHEIGHT Topographical height above mean sea level (ITU-R P.1511-1)
% Input parameters:
%   lat,lon     : Ground station coordinates [deg]
% Output parameters:
%   alt         : Topographical height above mean sea level [km]
%
% Note:
%   The function automatically loads meteorological input parameters 
%   required by Rec. ITU-R P.1511-1 from the following files:
%       TOPOLAT.TXT 	: latitudes of grid points (90:0.5:-90) [deg]
%       TOPOLON.TXT 	: longitudes of grid points (0:0.5:360) [deg]
% 	and, according to the specified percentage of an average year, from:
%       TOPO_0DOT5.txt 	: topographical height above mean sea level [km]


%% Reshape coordinates into grid
% Number of unique coordinate points
Ny = length(unique(lat));
Nx = length(unique(lon));
% Coordinates must be sorted by {Lon,Lat} for this to work
lat = reshape(lat,Ny,Nx);
lon = reshape(lon,Ny,Nx);

% Maps are provided from 0º to 360º in longitude
lon(lon<0) = lon(lon<0)+360;

%% Import ITU-R P.1511-1 maps
pathname = '+tropos/R-REC-P.1511-1';

% Grid longitude and latitude points [deg]
lat0 = dlmread(fullfile(pathname,'TOPOLAT.txt'));
lon0 = dlmread(fullfile(pathname,'TOPOLON.txt'));
% Topographical height above mean sea level [km]
data = dlmread(fullfile(pathname,'TOPO_0DOT5.txt'));

% Ignore first and last rows/columns, they are suppossed to help with
% bicubic interpolation but interp2() expects a uniform grid
lat0 = lat0(2:end-1,2:end-1);
lon0 = lon0(2:end-1,2:end-1);
data = data(2:end-1,2:end-1);

%% Interpolate at (lat,lon)
% Bicubic interpolation of data
alt = interp2(lon0,lat0,data,lon,lat,'cubic');
% Reshape into column vector matching (lat,lon)
alt = reshape(alt,Ny*Nx,1);
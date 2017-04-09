function [ rho ] = vaporDensity(lat,lon,p)
%VAPORDENSITY Surface water vapour density (ITU-R P.836-5)
% Annual values of surface water vapour density exceeded at coordinates
% (lat,lon) for p% of an average year.
% Input parameters:
%   lat,lon     : Ground station coordinates [deg]
%   p           : Percentage of an average year [%]
% Output parameters:
%   rho         : Surface water vapour density [g/m^3]
%
% Note:
%   The function automatically loads meteorological input parameters 
%   required by Rec. ITU-R P.836-5 from the following files:
%       LAT1dot125.txt 	: latitudes of grid points (90:-1.125:-90) [deg]
%       LON1dot125.txt  : longitudes of grid points (0:1.125:360) [deg]
% 	and, according to the specified percentage of an average year, from:
%       RHO_XX_v4.txt   : surface water vapour density [g/m^3]


%% Reshape coordinates into grid
% Number of unique coordinate points
Ny = length(unique(lat));
Nx = length(unique(lon));
% Coordinates must be sorted by {Lon,Lat} for this to work
lat = reshape(lat,Ny,Nx);
lon = reshape(lon,Ny,Nx);

% Maps are provided from 0� to 360� in longitude
lon(lon<0) = lon(lon<0)+360;

%% Import ITU-R P.836-5 maps
[pathstr,~,~] = fileparts(mfilename('fullpath'));
folder = 'R-REC-P.836-5';

switch p
    case {0.1,0.2,0.3,0.5} % 0.1
        name = sprintf('RHO_%02d_v4.txt',p*10);
    case {1,2,3,5} % 1
        name = sprintf('RHO_%d_v4.txt',p*10);
    case {10,20,30,50,60,70,80,90,95,99} % 10
        name = sprintf('RHO_%d_v4.txt',p);
    otherwise
        error(['Annual values exceeded for %0.2f%% '...
            'of an average year are not available'],p)
end

% Grid longitude and latitude points [deg]
lat0 = dlmread(fullfile(pathstr,folder,'LAT1dot125.txt'));
lon0 = dlmread(fullfile(pathstr,folder,'LON1dot125.txt'));
% Surface water vapour density [g/m^3]
data = dlmread(fullfile(pathstr,folder,name));

%% Interpolate at (lat,lon)
% Bilinear interpolation of data
rho = interp2(lon0,lat0,data,lon,lat,'linear');
% Reshape into column vector matching (lat,lon)
rho = reshape(rho,Ny*Nx,1);
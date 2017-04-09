function [ Lred ] = cloudWater(lat,lon,p)
%CLOUDWATER Reduced cloud liquid water content (ITU-R P.840-6)
% Annual values of total columnar content of reduced cloud liquid water
% exceeded at coordinates (lat,lon) for p% of an average year.
% Input parameters:
%   lat,lon     : Ground station coordinates [deg]
%   p           : Percentage of an average year [%]
% Output parameters:
%   Lred        : Reduced cloud liquid water content [kg/m^2]
%
% Note:
%   The function automatically loads meteorological input parameters 
%   required by Rec. ITU-R P.840-6 from the following files:
%       ESALAT1dot125.TXT 	: latitudes of grid points (90:-1.125:-90) [deg]
%       ESALON1dot125.TXT 	: longitudes of grid points (0:1.125:360) [deg]
% 	and, according to the specified percentage of an average year, from:
%       Lred_XX_v4.txt      : reduced cloud water liquid content [kg/m^2]


%% Reshape coordinates into grid
% Number of unique coordinate points
Ny = length(unique(lat));
Nx = length(unique(lon));
% Coordinates must be sorted by {Lon,Lat} for this to work
lat = reshape(lat,Ny,Nx);
lon = reshape(lon,Ny,Nx);

% Maps are provided from 0º to 360º in longitude
lon(lon<0) = lon(lon<0)+360;

%% Import ITU-R P.840-6 maps
pathname = '+itu/R-REC-P.840-6';

switch p
    case {0.1,0.2,0.3,0.5} % 0.1
        filename = sprintf('Lred_%02d_v4.txt',p*10);
    case {1,2,3,5} % 1
        filename = sprintf('Lred_%d_v4.txt',p*10);
    case {10,20,30,50,60,70,80,90,95,99} % 10
        filename = sprintf('Lred_%d_v4.txt',p);
    otherwise
        error(['Annual values exceeded for %0.2f%% '...
            'of an average year are not available'],p)
end

% Grid longitude and latitude points [deg]
lat0 = dlmread(fullfile(pathname,'ESALAT1dot125.txt'));
lon0 = dlmread(fullfile(pathname,'ESALON1dot125.txt'));
% Reduced cloud water liquid content [kg/m^2]
data = dlmread(fullfile(pathname,filename));

%% Interpolate at (lat,lon)
% Bilinear interpolation of data
Lred = interp2(lon0,lat0,data,lon,lat,'linear');
% Reshape into column vector matching (lat,lon)
Lred = reshape(Lred,Ny*Nx,1);
function [ rr ] = rainRate(lat,lon,p)
%RAINRATE Rainfall rate exceeded for p% of an average year (ITU-R P.837-5)
% Input parameters:
%   lat,lon     : Ground station coordinates [deg]
%   p           : Percentage of an average year [%]
% Output parameters:
%   rr          : Rainfall rate exceeded for p% of an average year [mm/h]
%
% Note:
%   The function automatically loads meteorological input parameters 
%   required by Rec. ITU-R P.837-5 from the following files:
%       ESARAIN_LAT_v5.TXT  : latitudes of grid points (90:-1.125:-90)[deg]
%       ESARAIN_LON_v5.TXT  : longitudes of grid points (0:1.125:360) [deg]
%       ESARAIN_MT_v5.TXT   : mean annual rainfall amount [mm]
%       ESARAIN_BETA_v5.TXT : ratio of convective to total rainfall amount
%       ESARAIN_PR6_v5.TXT  : probability of rainy 6-hours periods [%]
%
% Based on:
%   itur_p837_5 rel. 1.0 (11/07/2007) 
%   by Giulio BLARZINO, ONERA, France <Giulio.Blarzino@onera.fr>


%% Reshape coordinates into grid
% Number of unique coordinate points
Ny = length(unique(lat));
Nx = length(unique(lon));
% Coordinates must be sorted by {Lon,Lat} for this to work
lat = reshape(lat,Ny,Nx);
lon = reshape(lon,Ny,Nx);

% Maps are provided from 0º to 360º in longitude
lon(lon<0) = lon(lon<0)+360;

%% Import ITU-R P.837-5 parameters
pathname = '+itu/R-REC-P.837-5';

% Grid longitude and latitude points
lat_e40 = dlmread(fullfile(pathname,'ESARAIN_LAT_v5.txt'));
lon_e40 = dlmread(fullfile(pathname,'ESARAIN_LON_v5.txt'));

% Input metereological parameters
mt      = dlmread(fullfile(pathname,'ESARAIN_MT_v5.txt'));
beta    = dlmread(fullfile(pathname,'ESARAIN_BETA_v5.txt'));
pr6     = dlmread(fullfile(pathname,'ESARAIN_PR6_v5.txt'));

%% Rainfall rate exceeded for p%
% Bi-linear interpolation of parameters
mti     = interp2(lon_e40,lat_e40,mt,lon,lat,'linear');
betai   = interp2(lon_e40,lat_e40,beta,lon,lat,'linear');
pr6i    = interp2(lon_e40,lat_e40,pr6,lon,lat,'linear');

% Extract mean annual rainfall amount of stratiform type
msi = mti.*(1 - betai);

% Percentage probability of rain in an average year
p0 = pr6i.*(1 - exp(-0.0079.*(msi./pr6i)));

% Initialize and calculate rainfall rate [mm/h]
rr = zeros(size(p0));

ix = ~isnan(p0) & (p <= p0);
if any(ix)
    a = 1.09;
    b = mti(ix)./(21797*p0(ix));
    c = 26.02*b;
    A = a.*b;
    B = a + c.*log(p./p0(ix));
    C = log(p./p0(ix));
    rr(ix) = (-B + sqrt(B.^2 - 4*A.*C))./(2*A);
end

% Reshape into column vector matching (lat,lon)
rr = reshape(rr,Ny*Nx,1);
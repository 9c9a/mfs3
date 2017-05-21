%ATTENUATION Multibeam FSS attenuation map
close all
clear all

%% Inputs
% Satellite coordinates
lonS = 20;     % [deg]
altS = 36000; % [km]
% Frequency
freq = 20.2;  % [GHz]
% Spreadsheet name
sheet = 'Ka band';

%% Grid
% Step size
step = 0.5;   % [deg]
% Region
latLimit = [20 70];  % [deg]
lonLimit = [-40 80]; % [deg]

tblGrid = mfs3.geogrid(lonS,altS,step,latLimit,lonLimit);

%% Attenuation
MapA = mfs3.map.AttenuationMap(lonS,altS,freq,tblGrid);
MapA.draw()
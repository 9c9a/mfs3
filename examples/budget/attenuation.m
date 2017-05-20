%ATTENUATION Multibeam FSS attenuation map
close all
clear all

%% Inputs
% Satellite coordinates
lonS = 9;     % [deg]
altS = 36000; % [km]
% Frequency
freq = 20.2;  % [GHz]
% Spreadsheet name
sheet = 'Ka band';

%% Grid
% Step size
step = 0.5;   % [deg]
% Region
latLimit = [30 70];  % [deg]
lonLimit = [-25 55]; % [deg]

tblGrid = mfs3.geogrid(lonS,altS,step,latLimit,lonLimit);

%% Attenuation
MapA = mfs3.map.AttenuationMap(lonS,altS,freq,tblGrid);
MapA.draw()
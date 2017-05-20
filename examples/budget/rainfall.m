%RAINFALL Rainfall rate, cloud water content & vapor density map
close all
clear all

%% Inputs
% Satellite coordinates
lonS = 9;     % [deg]
altS = 36000; % [km]
% Spreadsheet name
sheet = 'Ka band';

%% Grid
% Step size
step = 0.5;   % [deg]
% Region
latLimit = [30 70];  % [deg]
lonLimit = [-25 55]; % [deg]

tblGrid = mfs3.geogrid(lonS,altS,step,latLimit,lonLimit);

%% Rainfall map
MapR = mfs3.map.RainfallMap(tblGrid);
MapR.draw()
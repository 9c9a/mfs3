%INTERFERENCE Multibeam FSS co-channel interference map
close all
clear

%% Path
% Add mfs3 and required libraries to the path
addpath('../../src','../../lib/tropos/src')

%% Inputs
% Satellite coordinates
lonS = 20;    % [deg]
altS = 36000;  % [km]
% Satellite beamwidth
thetaB = 0.65; % [deg]
% Beam grid parameters
radius = 250;  % [km]
tilt = 5; 	   % [deg]
% Spreadsheet name
sheet = 'Ka band';

%% Information tables
[fileB,pathB] = uigetfile('*.xlsx','Select user beam table');
tblBeams = readtable(fullfile(pathB,fileB),'Sheet',sheet);

%% Grid
% Step size
step = 0.5;     % [deg]
% Region
latLimit = [20 70];  % [deg]
lonLimit = [-40 80]; % [deg]

tblGrid = mfs3.geogrid(lonS,altS,step,latLimit,lonLimit);
tblGrid = mfs3.assign(tblGrid,tblBeams);

%% Association of beams to grid points
MapG = mfs3.map.GeogridMap(lonS,altS,radius,tilt,thetaB,tblGrid,tblBeams);
MapG.draw()

%% Co-channel interference
MapI = mfs3.map.InterferenceMap(lonS,altS,thetaB,tblGrid,tblBeams);
MapI.draw()
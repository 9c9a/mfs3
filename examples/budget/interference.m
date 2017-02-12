%INTERFERENCE Multibeam FSS co-channel interference map
close all
clear all

%% Inputs
% Satellite coordinates
lonS = 9;      % [deg]
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
latLimit = [30 70];  % [deg]
lonLimit = [-25 55]; % [deg]

tblGrid = multibeam.geogrid(lonS,altS,step,latLimit,lonLimit);
tblGrid = multibeam.assign(tblGrid,tblBeams);

%% Association of beams to grid points
MapG = multibeam.GeogridMap(lonS,altS,radius,tilt,thetaB,tblGrid,tblBeams);
MapG.draw()

%% Co-channel interference
MapI = multibeam.InterferenceMap(lonS,altS,thetaB,tblGrid,tblBeams);
MapI.draw()
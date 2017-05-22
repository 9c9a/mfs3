%KABAND Ka band multibeam FSS planning
close all
clear

%% Path
% Add mfs3 and required libraries to the path
addpath('../../src')

%% Inputs
% Beam radius (km)
radius = 250;
% Beam grid axial tilt (deg)
tilt = 5;
% Spreadsheet name
sheet = 'Ka band';

%% Information tables
[fileB,pathB] = uigetfile('*.xlsx','Select user beam table');
tblBeams = readtable(fullfile(pathB,fileB),'Sheet',sheet);

[fileS,pathS] = uigetfile('*.xlsx','Select gateway table');
tblStations = readtable(fullfile(pathS,fileS),'Sheet',sheet);

%% Map 1) Allocation of user beams
MapA = mfs3.map.MultibeamMap(radius,tilt,tblBeams);
MapA.draw()

%% Map 2) Frequency reuse
MapF = mfs3.map.FrequencyMap(radius,tblBeams);
MapF.draw()

%% Map 3) Gateway ground station locations
MapS = mfs3.map.GroundStationMap(radius,tblStations);
MapS.draw()

%% Map 4) Allocation of beams to gateways
MapG = mfs3.map.GatewayMap(radius,tblBeams,tblStations); 
MapG.draw()
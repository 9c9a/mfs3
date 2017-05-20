%KABAND Ka band multibeam FSS planning
close all
clear all

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

%% Allocation of user beams
MapA = mfs3.map.MultibeamMap(radius,tilt,tblBeams);
MapA.draw()

%% Frequency reuse
MapF = mfs3.map.FrequencyMap(radius,tblBeams);
MapF.draw()

%% Gateway ground station locations
MapS = mfs3.map.GroundStationMap(radius,tblStations);
MapS.draw()

%% Allocation of beams to gateways
MapG = mfs3.map.GatewayMap(radius,tblBeams,tblStations); 
MapG.draw()
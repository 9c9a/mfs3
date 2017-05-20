%FORWARDLINK Multibeam FSS forward link budget map
close all
clear all

%% Inputs
% Satellite coordinates
lonS = 9;     % [deg]
altS = 36000; % [km]
% Spreadsheet name
sheet = 'Ka band';

%% Information tables
[fileB,pathB] = uigetfile('*.xlsx','Select user beam table');
tblBeams = readtable(fullfile(pathB,fileB),'Sheet',sheet);

[fileS,pathS] = uigetfile('*.xlsx','Select gateway table');
tblStations = readtable(fullfile(pathS,fileS),'Sheet',sheet);

%% Grid
% Step size
step = 0.5;     % [deg]
% Region
latLimit = [30 70];  % [deg]
lonLimit = [-25 55]; % [deg]

tblGrid = mfs3.geogrid(lonS,altS,step,latLimit,lonLimit);
tblGrid = mfs3.assign(tblGrid,tblBeams);

%% Uplink
UL = struct();
% Frequency
UL.freq      = 29;    % [GHz]
% Gateway
UL.EIRP      = 83.49; % [dBW]
UL.thetaE    = 0.09;  % [deg]
UL.UPC       = 7;     % [dB]
% Satellite
UL.G_T       = 22.74; % [dB/K]
UL.thetaS    = 0.65;  % [deg]
UL.IBO       = 9;     % [dB]
% Bandwidth
UL.B         = 50;    % [MHz]
UL.Nc        = 8*4;   % [carriers]

%% Downlink
DL = struct();
% Frequency
DL.freq      = 20.2;  % [GHz]
% Satellite
DL.EIRP      = 66.36; % [dBW]
DL.thetaS    = 0.65;  % [deg]
% User terminal
DL.G_T       = 23.32; % [dB/K]
DL.thetaE    = 1.04;  % [deg]
% Bandwidth
DL.B         = 50;    % [MHz]
DL.Nc        = 4;     % [carriers]

%% Link budget
MapFL = mfs3.map.ForwardLinkMap(lonS,altS,UL,DL,tblGrid,tblBeams,tblStations);
MapFL.draw()
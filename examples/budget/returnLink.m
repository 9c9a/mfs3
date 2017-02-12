%RETURNLINK Multibeam FSS return link budget map
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

tblGrid = multibeam.geogrid(lonS,altS,step,latLimit,lonLimit);
tblGrid = multibeam.assign(tblGrid,tblBeams);

%% Uplink
UL = struct();
% Frequency
UL.freq      = 30;    % [GHz]
% User terminal
UL.EIRP      = 53.72; % [dBW]
UL.thetaE    = 0.7;   % [deg]
UL.UPC       = 0;     % [dB]
% Satellite
UL.G_T       = 23.03; % [dB/K]
UL.thetaS    = 0.65;  % [deg]
UL.IBO       = 9;     % [dB]
% Bandwidth
UL.B         = 50;    % [MHz]
UL.Nc        = 1;     % [carriers]

%% Downlink
DL = struct();
% Frequency
DL.freq      = 19.5;  % [GHz]
% Satellite
DL.EIRP      = 61.01; % [dBW]
DL.thetaS    = 0.65;  % [deg]
% Gateway
DL.G_T       = 41.07; % [dB/K]
DL.thetaE    = 0.09;  % [deg]
% Bandwidth
DL.B         = 50;    % [MHz]
DL.Nc        = 8*4;   % [carriers]

%% Link budget
MapRL = multibeam.ReturnLinkMap(lonS,altS,UL,DL,tblGrid,tblBeams,tblStations);
MapRL.draw()
%ALLOCATION Optimal allocation of multibeam FSS user beam centers
close all
clear all

%% Inputs
% Satellite coordinates
lonS = 9;     % [deg]
altS = 36000; % [km]
% User beam radius
radius = 250; % [km]
% Grid axial tilt
tilt = 5; 	  % [deg]
% Coverage limits [deg]
latLimit = [32.2 67];
lonLimit = [-9 40];

%% Allocate beams
tblBeams = mfs3.allocate(lonS,altS,radius,latLimit,lonLimit,tilt);

%% Generate map
MapA = mfs3.map.MultibeamMap(radius,tilt,tblBeams);
MapA.draw()

%% Remove beams outside regions of interest
MapA.show()
MapA.hide([1,4:5,7:9,10:18:64,100:18:118,19,37,73])
MapA.hide([17:18,26:27,29,34:36,38,42,44,45,47,53:54,62:63,71:72])

MapA.hide([80:81,90,99])
MapA.hide([101,107:110,114:120,123:128,131:135])

%% Save changes to beam allocation table
% Does not clear previous values from an existing table, remove/rename
% the spreadsheet manually or use a different filename
[fileB,pathB] = uiputfile('*.xlsx','Save beam allocation table as');
MapA.writeTable(fileB,pathB)
function [ hobj ] = addVisibility(this,lonS,altS,alpha)
%ADDVISIBILITY Add satellite visibility region from Earth
% Input parameters:
%   lonS	    : Satellite longitude [deg]
%   altS	    : Satellite altitude [km]
% 	alpha 		: Face transparency as a scalar value between 0 and 1
% Output parameters:
%   hobj        : Graphical object handle


set(0,'CurrentFigure',this.hF)
set(this.hF,'CurrentAxes',this.hA)

% Initialize transparency
if nargin<4; alpha = 0.1; end

%% Parameters
Re = this.geoid.MeanRadius;
% Orbital radius (km)
Rs = Re+altS;
% Maximum nadir angle (deg)
% Elevation towards satellite at true outer horizon is 0�
eta = asind(Re/Rs);
% Maximum central angle (deg)
% eta+gamma+90� = 180�
gamma = 90-eta;

%% Plot visibility region
% Calculate small circle of given central angle
[latC,lonC] = scircle1(0,lonS,gamma,[]);
hobj = fillm(latC,lonC,...
    'FaceColor',[0 0.5 1],'FaceAlpha',alpha,...
    'EdgeColor',[0 0.5 1],'EdgeAlpha',2*alpha,'LineWidth',1);
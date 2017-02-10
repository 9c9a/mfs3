function [ hobj ] = addHexagon(this,lat0,lon0,R,phi0,color,alpha)
%ADDHEXAGON Add a coverage hexagon of radius R centered at (lat0,lon0)

set(0,'CurrentFigure',this.hF)
set(this.hF,'CurrentAxes',this.hA)

% Initialize transparency
if nargin<7; alpha = 0.2; end

%% Calculate hexagonal beam
phi = 0:60:360;

% Scale by maximal radius R
% Rotate vertices by offset angle phi0
x2 = R*cosd(phi+phi0);
y2 = R*sind(phi+phi0);

[latH,lonH] = enu2geodetic(x2,y2,0,0,0,0,this.geoid);

%% Plot and fill beam area
hobj = fillm(lat0+latH,lon0+lonH,...
    'FaceColor',color,'FaceAlpha',alpha,'EdgeColor',color);

if isempty(hobj)
    warning('Object is outside axes projection limits')
end
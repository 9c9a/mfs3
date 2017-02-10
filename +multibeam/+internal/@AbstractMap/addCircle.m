function [ hobj ] = addCircle(this,lat0,lon0,R,color,alpha)
%ADDCIRCLE Add a coverage circle of radius R centered at (lat0,lon0)

set(0,'CurrentFigure',this.hF)
set(this.hF,'CurrentAxes',this.hA)

% Initialize transparency
if nargin<6; alpha = 0.2; end

%% Calculate circular beam
phi = 0:10:360;
x1 = R*cosd(phi);
y1 = R*sind(phi);

[latC,lonC] = enu2geodetic(x1,y1,0,0,0,0,this.geoid);

%% Plot and fill beam area
hobj = fillm(lat0+latC,lon0+lonC,...
    'FaceColor',color,'FaceAlpha',alpha,'EdgeColor',color);

if isempty(hobj)
    warning('Object is outside axes projection limits')
end
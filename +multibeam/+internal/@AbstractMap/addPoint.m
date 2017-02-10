function [ hobj ] = addPoint(this,lat0,lon0,color)
%ADDPOINT Add a location at coordinates (lat0,lon0)

set(0,'CurrentFigure',this.hF)
set(this.hF,'CurrentAxes',this.hA)

%% Plot beam center
switch this.region
    case 'world'
        hobj = plotm(lat0,lon0,'.','Color',color,'MarkerSize',6);
    case 'europe'
        hobj = plotm(lat0,lon0,'.','Color',color,'MarkerSize',16);
end

if isempty(hobj)
    warning('Object is outside axes projection limits')
end
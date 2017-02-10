function [ hobj ] = addLabel(this,lat0,lon0,label,color)
%ADDLABEL Add a text label at coordinates (lat0,lon0)

set(0,'CurrentFigure',this.hF)
set(this.hF,'CurrentAxes',this.hA)

%% Add text label
hobj = textm(lat0,lon0,label,...
    'Color',color,'FontSize',10,'HorizontalAlignment','center');

if isempty(hobj)
    warning('Object is outside axes projection limits')
end
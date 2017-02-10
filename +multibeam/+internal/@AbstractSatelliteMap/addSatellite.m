function [ hobj ] = addSatellite(this,lonS)
%ADDSATELLITE Add sub-satellite point

set(0,'CurrentFigure',this.hF)
set(this.hF,'CurrentAxes',this.hA)

%% Plot sub-satellite point
hobj = plotm(0,lonS,'^r','MarkerSize',6);
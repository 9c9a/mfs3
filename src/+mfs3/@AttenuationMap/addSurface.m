function [ hobj,hbar ] = addSurface(this,lat,lon,Z)
%ADDSURFACE Add flat surface plot of data grid Z

set(0,'CurrentFigure',this.hF)
set(this.hF,'CurrentAxes',this.hA)

%% Transform data grid
Ny = length(unique(lat));
Nx = length(unique(lon));

y = reshape(lat,Ny,Nx);
x = reshape(lon,Ny,Nx);
Z = reshape(Z,Ny,Nx);

%% Plot Z as a flat surface
hobj = surfm(y,x,Z);
uistack(hobj,'bottom')

% Color bar for contour plots
hbar = colorbar(this.hA,'Location','EastOutside');
% Update figure before continuing execution
drawnow limitrate nocallbacks
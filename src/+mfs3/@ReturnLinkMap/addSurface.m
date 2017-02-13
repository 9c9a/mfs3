function [ hobj,hbar ] = addSurface(this,lat,lon,Z)
%ADDSURFACE Add flat surface plot of data grid Z

set(0,'CurrentFigure',this.hF)
set(this.hF,'CurrentAxes',this.hA)

%% Transform coordinate grid
Ny = length(unique(lat));
Nx = length(unique(lon));

y = reshape(lat,Ny,Nx);
x = reshape(lon,Ny,Nx);

%% Transform data grid Z
% In some specific cases, the magnitude to plot is independent of the
% coordinate grid, so repmat() the value into a matrix
if isscalar(Z)
    Z = repmat(Z,Ny,Nx);
else
    Z = reshape(Z,Ny,Nx);
end

%% Plot Z as a flat surface
hobj = surfm(y,x,Z);
uistack(hobj,'bottom')

% Limit dynamic range to ignore noise introduced by multibeam side lobes
% outside our coverage region
caxis([max(-20,floor(min(Z(:)))),ceil(max(Z(:)))])

% Color bar for contour plots
hbar = colorbar(this.hA,'Location','EastOutside');
% Update figure before continuing execution
drawnow limitrate nocallbacks
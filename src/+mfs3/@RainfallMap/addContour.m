function [ hobj,hbar ] = addContour(this,lat,lon,Z)
%ADDCONTOUR Add contour levels of data grid Z

set(0,'CurrentFigure',this.hF)
set(this.hF,'CurrentAxes',this.hA)

%% Transform data grid
Ny = length(unique(lat));
Nx = length(unique(lon));

y = reshape(lat,Ny,Nx);
x = reshape(lon,Ny,Nx);
Z = reshape(Z,Ny,Nx);

%% Plot contour levels
[C,hobj] = contourm(y,x,Z);%,'LevelStep',5);

% Add labels to contour levels
set(clabelm(C,hobj),'BackgroundColor','none')

% Color bar for contour plots
hbar = contourcbar(this.hA,'Location','EastOutside');
% Update figure before continuing execution
drawnow limitrate nocallbacks
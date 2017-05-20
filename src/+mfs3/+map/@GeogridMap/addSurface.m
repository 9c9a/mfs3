function [ hobj ] = addSurface(this,lat,lon,Z)
%ADDSURFACE Add flat surface plot of data grid Z

set(0,'CurrentFigure',this.hF)
set(this.hF,'CurrentAxes',this.hA)

%% Transform data grid
Ny = length(unique(lat));
Nx = length(unique(lon));

y = reshape(lat,Ny,Nx);
x = reshape(lon,Ny,Nx);
Z = reshape(Z,Ny,Nx);

%% Generate color map
K1 = length(unique(Z));
K2 = ceil(K1/size(this.palette,1));

cmap = repmat(this.palette,K2,1);
cmap = cmap(1:K1,:);

colormap(this.hA,cmap)

%% Plot Z as a flat surface
hobj = surfm(y,x,Z);
alpha(hobj,0.7)

% Update figure before continuing execution
drawnow limitrate nocallbacks
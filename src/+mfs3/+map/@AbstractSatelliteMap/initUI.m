function initUI(this,name)
%INITUI Initialize figure and axes with chosen projection
% Input parameters:
%   name        : Figure name or title
% Output parameters:
%   none

% Initialize UI using superclass method
initUI@mfs3.map.AbstractMap(this,name)

latLim = get(this.hA,'MapLatLimit');
lonLim = get(this.hA,'MapLonLimit');

%% Draw NASA "Blue Marble" overlay
layer = wmsfind('nasa.gov','SearchField','ServerURL');
layer = layer.refine('BlueMarbleNG',...
	'SearchField','LayerName','MatchType','exact');

[overlayImage,R] = wmsread(layer(1),'LatLim',latLim,'LonLim',lonLim,...
	'Cellsize',1/4);
this.hL = geoshow(overlayImage,R);

%% Position figure
% Move figure to the center of the screen
movegui(this.hF,'center')
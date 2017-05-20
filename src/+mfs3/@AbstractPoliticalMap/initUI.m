function initUI(this,name)
%INITUI Initialize figure and axes with chosen projection
% Input parameters:
%   name        : Figure name or title
% Output parameters:
%   none

% Initialize UI using superclass method
initUI@mfs3.AbstractMap(this,name)
% Change background color to dark gray
setm(this.hA,'FFaceColor',[1 1 1]*0.6)

%% Draw political borders overlay
pathstr = fileparts(mfilename('fullpath'));
this.hL = geoshow(fullfile(pathstr,'worldborders.shp'),...
	'FaceColor',[1 1 1]*0.97,'EdgeColor',[1 1 1]*0.4);

%% Position figure
% Move figure to the center of the screen
movegui(this.hF,'center')
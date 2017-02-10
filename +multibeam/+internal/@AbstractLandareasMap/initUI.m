function initUI(this,name)
%INITUI Initialize figure and axes with chosen projection

% Initialize UI using superclass method
initUI@multibeam.internal.AbstractMap(this,name)

%% Draw political borders overlay
this.hL = geoshow('landareas.shp',...
	'FaceColor',[1 1 1]*0.9,'FaceAlpha',1,'EdgeColor','k');

%% Position figure
% Move figure to the center of the screen
movegui(this.hF,'center')
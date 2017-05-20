function initUI(this,name)
%INITUI Initialize figure and axes with chosen projection

% Initialize UI using call superclass method
initUI@mfs3.map.AbstractLandareasMap(this,name)
% Change landareas color to improve visibility
set(this.hL.Children,'FaceAlpha',0,'EdgeColor','w')

%% Position figure
% Move figure to the center of the screen
movegui(this.hF,'center')
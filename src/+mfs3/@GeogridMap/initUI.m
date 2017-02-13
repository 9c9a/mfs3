function initUI(this,name)
%INITUI Initialize figure and axes with chosen projection

% Initialize UI using call superclass method
initUI@mfs3.internal.AbstractLandareasMap(this,name)
% Change landareas color to improve visibility
set(this.hL.Children,'FaceAlpha',0.2,'EdgeColor','k')

%% Create uipanel
% Allows repositioning uicontrols together on resizeUI() calls
this.panel = uipanel(this.hF);

%% Create uicontrols
options = {...
    'Associate beams by minimum distance',...
    'Associate beams by maximum gain',...
    };
this.popup = uicontrol(this.panel,'Style','popupmenu',...
    'String',options,'Callback',@this.popupCallback);

this.button = uicontrol(this.panel,'Style','pushbutton',...
    'String','Refresh','Callback',@this.buttonCallback);

%% Position figure
% Set UI resize callback function
set(this.hF,'SizeChangedFcn',@this.resizeUI)
% Move figure to the center of the screen
movegui(this.hF,'center')
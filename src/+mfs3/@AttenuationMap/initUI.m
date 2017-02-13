function initUI(this,name)
%INITUI Initialize figure and axes with chosen projection

% Initialize UI using call superclass method
initUI@mfs3.internal.AbstractLandareasMap(this,name)
% Change landareas color to improve visibility
set(this.hL.Children,'FaceAlpha',0.1,'EdgeColor','k')

%% Create uipanel
% Allows repositioning uicontrols together on resizeUI() calls
this.panel = uipanel(this.hF);

%% Create uicontrols
options = {'Attenuation due to free-space path loss',...
    'Attenuation due to rainfall','Attenuation due to clouds and fog',...
    'Attenuation due to atmospheric gasses'};
this.popup1 = uicontrol(this.panel,'Style','popupmenu',...
    'String',options,'Callback',@this.popupCallback1);

options = {'0.01','0.1','0.2','0.3','0.5'};
this.popup2 = uicontrol(this.panel,'Style','popupmenu',...
    'String',options,'Callback',@this.popupCallback2);

this.button = uicontrol(this.panel,'Style','pushbutton',...
    'String','Refresh','Callback',@this.buttonCallback); 

% Disable popup2 uicontrol by default
set(this.popup2,'Enable','off')

%% Position figure
% Set UI resize callback function
set(this.hF,'SizeChangedFcn',@this.resizeUI)
% Move figure to the center of the screen
movegui(this.hF,'center')
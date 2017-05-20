function initUI(this,name)
%INITUI Initialize figure and axes with chosen projection

% Initialize UI using call superclass method
initUI@mfs3.map.AbstractLandareasMap(this,name)

%% Create uipanel
% Allows repositioning uicontrols together on resizeUI() calls
this.panel = uipanel(this.hF);

%% Create uicontrols
options = {'Rainfall rate',...
    'Reduced cloud liquid water content','Surface water vapor density'};
this.popup1 = uicontrol(this.panel,'Style','popupmenu',...
    'String',options,'Callback',@this.popupCallback1);

options = {'0.01','0.1','0.2','0.3','0.5'};
this.popup2 = uicontrol(this.panel,'Style','popupmenu',...
    'String',options,'Callback',@this.popupCallback2);

this.button = uicontrol(this.panel,'Style','pushbutton',...
    'String','Refresh','Callback',@this.buttonCallback);

%% Position figure
% Set UI resize callback function
set(this.hF,'SizeChangedFcn',@this.resizeUI)
% Move figure to the center of the screen
movegui(this.hF,'center')
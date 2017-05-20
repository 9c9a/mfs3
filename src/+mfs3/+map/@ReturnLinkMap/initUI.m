function initUI(this,name)
%INITUI Initialize figure and axes with chosen projection

% Initialize UI using call superclass method
initUI@mfs3.map.AbstractLandareasMap(this,name)

%% Create uipanel
% Allows repositioning uicontrols together on resizeUI() calls
this.panel = uipanel(this.hF);

%% Create uicontrols
options = {'C/(N+IM)','C/N uplink','C/N downlink','C/IM',};
this.popup1 = uicontrol(this.panel,'Style','popupmenu',...
    'String',options,'Callback',@this.popupCallback1);

options = {'Clear sky','Rain in uplink','Rain in downlink'};
this.popup2 = uicontrol(this.panel,'Style','popupmenu',...
    'String',options,'Callback',@this.popupCallback2);

options = {'99.9','99.8','99.7','99.5'};
this.popup3 = uicontrol(this.panel,'Style','popupmenu',...
    'String',options,'Callback',@this.popupCallback3);

this.button = uicontrol(this.panel,'Style','pushbutton',...
    'String','Refresh','Callback',@this.buttonCallback);

%% Position figure
% Set UI resize callback function
set(this.hF,'SizeChangedFcn',@this.resizeUI)
% Move figure to the center of the screen
movegui(this.hF,'center')
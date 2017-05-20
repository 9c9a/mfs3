function initUI(this,name)
%INITUI Initialize figure and axes with chosen projection
% Input parameters:
%   name        : Figure name or title
% Output parameters:
%   none

% Create hidden figure
this.hF = figure('Visible','off','Name',name);

%% Create map axes
this.hA = axesm(this.proj,'Geoid',this.geoid);

% Enable grid, frame and labels. Disable axis
gridm on; framem on; mlabel on; plabel on; axis off

%% Set map limits according to region
try
    setm(this.hA,'MapLatLimit',[-90 90],'MapLonLimit',[-180 180])
    setm(this.hA,'MLineLocation',45,'MLabelLocation',45)
    setm(this.hA,'PLineLocation',45,'PLabelLocation',45)
catch ME
    rethrow(ME)
end

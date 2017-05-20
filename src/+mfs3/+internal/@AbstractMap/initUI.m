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
switch this.region
    case 'world'
        setm(this.hA,'MapLatLimit',[-90 90],'MapLonLimit',[-180 180])
        setm(this.hA,'MLineLocation',45,'MLabelLocation',45)
        setm(this.hA,'PLineLocation',45,'PLabelLocation',45)
    case 'europe1'
        setm(this.hA,'MapLatLimit',[25 75],'MapLonLimit',[-30 60])
        setm(this.hA,'MLineLocation',15,'MLabelLocation',30)
        setm(this.hA,'PLineLocation',15,'PLabelLocation',15)
    case 'europe2'
        setm(this.hA,'MapLatLimit',[30 70],'MapLonLimit',[-25 55])
        setm(this.hA,'MLineLocation',10,'MLabelLocation',10)
        setm(this.hA,'PLineLocation',10,'PLabelLocation',10)
    otherwise
        error('Unknown map region: ''%s''',this.region)
end

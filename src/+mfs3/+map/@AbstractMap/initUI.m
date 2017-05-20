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
pathstr = fileparts(mfilename('fullpath'));
% Read supported regions from JSON file 'regions.json'
json = fileread(fullfile(pathstr,'../','regions.json'));
json = jsondecode(json);

if ~isfield(json,this.region)
    error('Unknown map region: ''%s''',this.region)
end

% Apply all parameters specified for this region
% Should probably add some constraints to which fields are allowed
fields = fieldnames(json.(this.region));
for n=1:length(fields)
    setm(this.hA,fields{n},json.(this.region).(fields{n}))
end
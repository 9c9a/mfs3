function draw(this)
%DRAW Draw beam-to-grid association map

% User beam coordinates
lat0 = this.tblBeams.Lat;
lon0 = this.tblBeams.Lon;
% Grid coordinates
lat1 = this.tblGrid.Lat;
lon1 = this.tblGrid.Lon;

% Beam numbers
nB = this.tblBeams.Number;
% Frequency assigned to each beam
idF = this.tblBeams.Frequency;

%% Distance towards beam centers
dist = zeros(length(lat1),length(nB));
for n=1:length(nB)
    dist(:,n) = distance(lat0(n),lon0(n),lat1,lon1,this.geoid);
end

%% Gain coefficient for each beam
gain = zeros(length(lat1),length(nB));
for n=1:length(nB)
    gain(:,n) = this.linkB.gain(lat0(n),lon0(n),lat1,lon1,this.thetaB);
end

%% Assign a beam number to each point in the grid
switch this.option
    case 'gain' % Find beam with the highest gain
        [~,idB] = max(gain,[],2);
    case 'dist' % Find beam with the smallest distance
        [~,idB] = min(dist,[],2);
end
% Data array with frequencies
Z = idF(idB);

%% Clear map before redrawing
this.clear()

%% Plot beam assignment
this.hData = this.addSurface(lat1,lon1,Z);
% Add labels with beam numbers
labels = arrayfun(@num2str,nB,'UniformOutput',false);
this.hText = this.addLabel(lat0,lon0,labels,'w');

%% Plot beam hexagonal cells
this.hCell = zeros(size(nB));
for n=1:length(nB)
    this.hCell(n) = this.addHexagon(...
        lat0(n),lon0(n),this.radius,this.tilt,'w',0);
    % Update map at constant framerate
    drawnow limitrate
end

function draw(this)
%DRAW Draw user beam allocation map

% Beam numbers
num = this.tblBeams.Number;
% Beam coordinates
lat = this.tblBeams.Lat;
lon = this.tblBeams.Lon;

%% Assign colors to each beam
N = length(num);
M = size(this.palette,1);

color = repmat(this.palette,floor(N/M),1);
color = vertcat(color,this.palette(1:mod(N,M),:));

%% Clear map before redrawing
this.clear()

%% Plot beam hexagonal cells
hH = gobjects(size(num));
hT = hH;

for n=1:length(num)
    hH(n) = this.addHexagon(...
        lat(n),lon(n),this.radius,this.tilt,color(n,:),0.4);
    hT(n) = this.addLabel(lat(n),lon(n),num2str(num(n)),color(n,:));
    % Update map at constant framerate
    drawnow limitrate
end

this.tblBeams.Handle = horzcat(hH,hT);
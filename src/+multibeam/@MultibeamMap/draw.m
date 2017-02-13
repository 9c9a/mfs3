function draw(this)
%DRAW Draw user beam allocation map

% Beam numbers
num = this.tblBeams.Number;
% Beam coordinates
lat = this.tblBeams.Lat;
lon = this.tblBeams.Lon;

%% Assign different colors
M = ceil(length(num)/size(this.palette,1));

color = repmat(this.palette,M,1);
color = color(1:length(num),:);

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
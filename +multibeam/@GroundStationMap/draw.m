function draw(this)
%DRAW Draw ground station locations map

% Ground station numbers
gate = this.tblStations.Number;
% Ground station coordinates
lat0 = this.tblStations.Lat;
lon0 = this.tblStations.Lon;

%% Assign colors to each station
M = ceil(length(gate)/size(this.palette,1));

color = repmat(this.palette,M,1);
color = color(1:length(gate),:);

%% Clear map before redrawing
this.clear()

%% Plot ground station beams
hC = gobjects(size(gate));
hT = hC;

for n=1:length(gate)
    hC(n) = this.addCircle(lat0(n),lon0(n),this.radius,color(n,:),0.4);
    hT(n) = this.addLabel(lat0(n),lon0(n),num2str(gate(n)),color(n,:));
    % Update map at constant framerate
    drawnow limitrate
end
this.tblStations.Handle = horzcat(hC,hT);

%% Show city names in legend
legend(this.hA,hC,this.tblStations.City)
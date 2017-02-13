function draw(this)
%DRAW Draw cochannel interference map

% User beam coordinates
lat0 = this.tblBeams.Lat;
lon0 = this.tblBeams.Lon;
% Grid coordinates
lat1 = this.tblGrid.Lat;
lon1 = this.tblGrid.Lon;

% Frequency assigned to each beam
idF = this.tblBeams.Frequency;
% User beam assigned to each point
idB = this.tblGrid.Beam;

%% Carrier to interference ratio
CIR = this.linkB.carrierI(lat0,lon0,lat1,lon1,idB,idF);

%% Clear map before redrawing
this.clear()

%% Plot C/I ratio
[this.hData,this.hCBar] = this.addSurface(lat1,lon1,CIR);
ylabel(this.hCBar,'C/I (dB)')
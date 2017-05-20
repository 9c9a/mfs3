function draw(this)
%DRAW Draw forward link budget map

% Decide conditions to apply on each link
switch this.option2
    case 'rain_u'
        cond_u = 'rain';
        cond_d = 'clearsky';
    case 'rain_d'
        cond_u = 'clearsky';
        cond_d = 'rain';
    case 'clearsky'
        cond_u = 'clearsky';
        cond_d = 'clearsky';
end

% Availability (100-p) [%]
p = this.prob;

%% Parameters
% Grid coordinates
latE = this.tblGrid.Lat;
lonE = this.tblGrid.Lon;
% Local spherical AER towards satellite
eleE = this.tblGrid.El;
ranE = this.tblGrid.Range;

% Gateway numbers
% Ignore gateways with no assigned grid points
nG = unique(this.tblGrid.Gateway,'sorted');

%% Carrier to noise (uplink)
% Find gateways assigned to each grid point
idG = this.tblGrid.Gateway;

% Gateway coordinates
latG = this.tblStations.Lat;
lonG = this.tblStations.Lon;
% Local spherical AER towards satellite
eleG = this.tblStations.El;
ranG = this.tblStations.Range;

CNR_U = zeros(size(latE));
for n=1:length(nG)
    % Find points assigned to this gateway
    idx = ismember(idG,nG(n));
    % Assume all gateway beams are centered on the exact location of their
    % corresponding ground station (latB,lonB) = (latE,lonE)
    CNR_U(idx) = this.linkU.carrierN(...
        cond_u,latG(n),lonG(n),latG(n),lonG(n),eleG(n),ranG(n),p);
end

%% Input/output power backoff
IBO = zeros(size(latE));
for n=1:length(nG)
    % Find points assigned to this gateway
    idx = ismember(idG,nG(n));
    % Input power back-off
    IBO(idx) = this.linkU.backoff(cond_u,latG(n),lonG(n),eleG(n),p);
end

% Output power back-off
OBO = this.linkD.backoff(IBO);

%% Carrier to noise (downlink)
% Find beams assigned to each grid point
idB = this.tblGrid.Beam;

% User beam coordinates
latB = this.tblBeams.Lat(idB);
lonB = this.tblBeams.Lon(idB);

% By passing the corresponding beam center coordinates as a vector,
% calculations can be simplified significantly
CNR_D = this.linkD.carrierN(cond_d,latB,lonB,latE,lonE,eleE,ranE,OBO,p);

%% Carrier to intermodulation
CIMR = this.linkD.carrierIM(IBO);

%% Carrier to interference
% Find beams assigned to each grid point
idB = this.tblGrid.Beam;
% Find frequencies assigned to each beam
idF = this.tblBeams.Frequency;

% User beam coordinates
latB = this.tblBeams.Lat;
lonB = this.tblBeams.Lon;

CIR = this.linkD.carrierI(latB,lonB,latE,lonE,idB,idF);

%% Carrier to N+I+IM
CT = 10.^(-CNR_U/10)+10.^(-CNR_D/10)+10.^(-CIR/10)+10.^(-CIMR/10);
CT = -10*log10(CT);

%% Plot contour levels
switch this.option1
    case 'CT'
        data = CT;
        unit = 'C/(N+I+IM)';
    case 'CNR_U'
        data = CNR_U;
        unit = 'Uplink C/N';
    case 'CNR_D'
        data = CNR_D;
        unit = 'Downlink C/N';
    case 'CIR'
        data = CIR;
        unit = 'C/I';
    case 'CIMR'
        data = CIMR;
        unit = 'C/IM';
end

this.clear() % Clear map before redrawing

[this.hData,this.hCBar] = this.addSurface(latE,lonE,data);
ylabel(this.hCBar,sprintf('%s (dB)',unit))
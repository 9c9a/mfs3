function [ tblGrid ] = assign(tblGrid,tblBeams)
%ASSIGN Assign beam and gateway numbers to coordinate grid points
% Input parameters:
%   tblGrid 	: Grid coordinate table
%	tblBeams 	: User beam information table
% Output parameters:
%   tblGrid	 	: Grid coordinate table with beam/gateway assignment

% Check for input arguments
narginchk(2,2)

% Reference ellipsoid for Earth's surface
geoid = referenceEllipsoid('sphere','km');

%% Retrieve grid & beam coordinates
% Grid coordinates
lat1 = tblGrid.Lat;
lon1 = tblGrid.Lon;
% Number of points
Np = length(lat1);

% User beam coordinates
lat0 = tblBeams.Lat;
lon0 = tblBeams.Lon;
% Number of beams
Nb = length(lat0);

%% Distance to beam centers
% Calculate distance from each (lat0,lon0) towards (lat1,lon1)
dist = zeros(Np,Nb);
for n=1:Nb
    dist(:,n) = distance(lat0(n),lon0(n),lat1,lon1,geoid);
end

%% Assign numbers to each point
% Assign beam numbers to each point
% Find beam with the smallest distance
[~,idB] = min(dist,[],2);
% Assign gateway numbers to each point
idG = tblBeams.Gateway(idB);

%% Add assignment to coordinate grid table
tblGrid.Beam = idB;
tblGrid.Gateway = idG;
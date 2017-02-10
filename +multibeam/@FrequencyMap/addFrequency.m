function [idB,hC,hT] = addFrequency(this,freq,color,alpha)
%ADDFREQUENCY Add beams by assigned frequency number

% Find beam indexes for selected frequency
lid = ismember(this.tblBeams.Frequency,freq);
idB = find(lid);

% Beam numbers
num = this.tblBeams.Number(lid);
% Beam center coordinates
lat = this.tblBeams.Lat(lid);
lon = this.tblBeams.Lon(lid);

% Plot beam localization and coverage areas
hC = gobjects(size(idB));
hT = hC;

for n=1:length(idB)
    hC(n) = this.addCircle(lat(n),lon(n),this.radius,color,alpha);
    hT(n) = this.addLabel(lat(n),lon(n),num2str(num(n)),color);
    % Update map at constant framerate
    drawnow limitrate
end
function [ CIR ] = carrierI(this,lat0,lon0,lat1,lon1,idB,idF)
%CARRIERI Carrier to interference ratio
% Input parameters:
%   lat0,lon0   : Beam center coordinates [deg]
%   lat1,lon1   : Ground station coordinates [deg]
%   idB         : Beams associated to each grid point [-]
%   idF         : Frequencies associated to each beam [-]
% Output parameters:
%   CIR         : Carrier to interference ratio [dB]

% Beam numbers
% Ignore beams with no assigned points
nB = unique(idB,'sorted');
% Number of grid points
Np = length(lat1);

%% Gain coefficients for each beam
gain = zeros(Np,length(nB));
for n=1:length(nB)
    % Calculate gain towards every point in the grid
    gain(:,n) = this.gain(lat0(n),lon0(n),lat1,lon1,this.thetaS);
end

%% Carrier to interference ratio
CIR = zeros(Np,1);
for n=1:length(nB)
    % Find grid points assigned to this beam
    idx = ismember(idB,nB(n));
    % Find co-channel beams
    idy = ismember(idF,idF(n)) & (nB ~= nB(n));
    
    % Carrier and interference
    C = gain(idx,n);
    % Assuming incoherent contributions (power sum)
    I = 10*log10(sum(10.^(gain(idx,idy)/10),2));
    
    CIR(idx) = C-I; % [dB]
end
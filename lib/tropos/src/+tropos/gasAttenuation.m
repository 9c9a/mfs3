function [ att ] = gasAttenuation(freq,lat,lon,elev,p)
%GASATTENUATION Attenuation due to atmospheric gasses
% Input parameters:
% 	freq 		: Frequency [GHz]
%   lat,lon     : Ground station coordinates [deg]
%   elev        : Elevation towards satellite [deg]
%   p           : Percentage of an average year [%]
% Output parameters:
%   att         : Attenuation [dB]

% Ground station height above sea level (ITU-R P.1511)
hs = tropos.topoHeight(lat,lon); % [km]

%% Specific attenuations
% Specific attenuation due to dry air [dB/km]
gamma0 = (7.1./(freq.^2+0.36) + 4.5./((freq-57).^2 + 0.98)).*freq.^2*1e-3; 

% Surface water vapour density [g/m^3]
pw = tropos.vaporDensity(lat,lon,p);
% Specific attenuation due to water vapour [dB/km]
gammaw = (0.067 + 3./((freq-22.3).^2 + 7.3)).*pw.*freq.^2*1e-4;

%% Gas attenuation
% Scale height for exponential atmosphere [km]
% For attenuation calculations, this density profile may be approximated 
% by an exponential profile with h0 = 6 km
h0 = 6;
% Equivalent height for water vapour [km]
hw = 2.2 + 3./((freq-22.3).^2 + 3);

att = (gamma0.*h0.*exp(-hs/h0)+gammaw.*hw)./(sind(elev)); % [dB]
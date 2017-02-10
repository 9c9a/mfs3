function [ CNR ] = carrierN(this,cond,lat0,lon0,lat1,lon1,elev,range,OBO,p)
%CARRIERN Carrier to noise ratio (CNR) for a given probability
% Input parameters:
%   cond        : Sky state conditions (clear sky, rain)
%   lat0,lon0   : Beam center coordinates [deg]
%   lat1,lon1   : Ground station coordinates [deg]
% 	elev		: Elevation towards satellite [deg]
% 	range 		: Slant range towards satellite [km]
%   OBO         : Output power back-off [dB]
%   p           : Percentage of an average year [%]
% Output parameters:
%   CNR         : Carrier to noise ratio [dB]

% Satellite EIRP towards (laE,lonE)
% Apply normalized radiation pattern
EIRP = this.EIRP+this.gain(lat0,lon0,lat1,lon1,this.thetaS); % [dBW]
% Divide EIRP by number of carriers per transponder
EIRP = EIRP-10*log10(this.Nc); % [dBW]
% Substract output back-off
% Use absolute value to avoid sign ambiguity
EIRP = EIRP-abs(OBO);

% Ground station G/T towards satellite
% Substract pointing losses
G_T = this.G_T-this.pointing(this.thetaE);

% Propagation losses (attenuation)
% Sky conditions are considered in the calculation
att = this.attenuation(cond,lat1,lon1,elev,range,p); % [dB]

%% Carrier to noise ratio
k = 1.38e-23; % Boltzmann's Constant [W/(K·Hz)]
CNR = EIRP+G_T-att-10*log10(k)-10*log10(this.B)-60;
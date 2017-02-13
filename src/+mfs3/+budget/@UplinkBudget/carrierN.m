function [ CNR ] = carrierN(this,cond,lat0,lon0,lat1,lon1,elev,range,p)
%CARRIERN Carrier to noise ratio (CNR) for a given probability
% Input parameters:
%   cond        : Sky state conditions (clear sky, rain)
%   lat0,lon0   : Beam center coordinates [deg]
%   lat1,lon1   : Ground station coordinates [deg]
% 	elev		: Elevation towards satellite [deg]
% 	range 		: Slant range towards satellite [km]
%   p           : Percentage of an average year [%]
% Output parameters:
%   CNR         : Carrier to noise ratio [dB]


% Ground station EIRP towards satellite
% Substract pointing losses
EIRP = this.EIRP-this.pointing(this.thetaE); % [dBW]
% Divide EIRP by number of carriers per transponder
EIRP = EIRP-10*log10(this.Nc); % [dBW]

% Satellite G/T towards (latE,lonE)
% Apply normalized radiation pattern
G_T = this.G_T+this.gain(lat0,lon0,lat1,lon1,this.thetaS);

% Propagation losses (attenuation)
% Sky conditions are considered in the calculation
att = this.attenuation(cond,lat1,lon1,elev,range,p); % [dB]

%% Carrier to noise ratio
k = 1.38e-23; % Boltzmann's Constant [W/(K·Hz)]
CNR = EIRP+G_T-att-10*log10(k)-10*log10(this.B)-60;
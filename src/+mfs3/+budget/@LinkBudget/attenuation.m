function [ att ] = attenuation(this,cond,lat,lon,elev,range,p)
%ATTENUATION Total attenuation for a given probability
% Input parameters:
%   cond        : Sky state conditions (clear sky, rain)
%   lat,lon     : Ground station coordinates [deg]
%   elev        : Elevation towards satellite [deg]
%   range       : Slant range towards satellite [km]
%   p           : Percentage of an average year [%]
% Output parameters:
%   att         : Attenuation [dB]

% Frequency [GHz]
freq = this.freq;

% Attenuation due to free-space path loss
attF = itu.freeSpaceLoss(freq,range);
% Attenuation due to atmospheric gasses
attG = itu.gasAttenuation(freq,lat,lon,elev,p);

switch lower(cond)
    case 'clearsky'
        % Attenuation due to clouds and fog
        attC = itu.cloudAttenuation(freq,lat,lon,elev,p);
        att = attF+attG+attC;
    case 'rain'
        % Attenuation due to rainfall
        % Cloud and fog attenuation are already considered
        attR = itu.rainAttenuation(freq,lat,lon,elev,p);
        att = attF+attG+attR;
    otherwise
        error('Unknown sky conditions ''%s''',cond)
end
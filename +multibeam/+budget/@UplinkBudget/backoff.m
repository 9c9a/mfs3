function [ IBO ] = backoff(this,cond,lat,lon,elev,p)
%BACKOFF Input power back-off (IBO) after rain compensation
% Input parameters:
%   cond        : Sky state conditions (clear sky, rain)
%   lat,lon     : Ground station coordinates [deg]
% 	elev		: Elevation towards satellite [deg]
%   p           : Percentage of an average year [%]
% Output parameters:
%   IBO         : Input back-off [dB]

switch lower(cond)
    case 'rain'
        % Rain attenuation
        attR = itu.rainAttenuation(this.freq,lat,lon,elev,p);
        % Compensate rain attenuation up to UPC capabilities
        IBO = this.IBO - max(attR - min(this.UPC,attR), 0);
    case 'clearsky'
        IBO = this.IBO;
    otherwise
        error('Unknown sky conditions ''%s''',cond)
end
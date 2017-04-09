function [ gammaR ] = rainGamma(freq,elev,RR,tau)
%RAINGAMMA Specific attenuation model for rain (ITU-R P.838-3)
% Input parameters:
%   freq        : Frequency [GHz]
%   elev        : Elevation towards satellite [deg]
%   RR          : Rainfall rate [mm/h]
%   tau         : Polarization tilt angle [deg]
% Output parameters:
%   gammaR      : Specific attenuation [dB/km]


%% Coefficients
% Horizontal and vertical polarization
% This function is for internal use only. It may be removed in the future.
[kH,kV,alphaH,alphaV] = phased.internal.rainattcoeff(freq*1e9);

% Linear and circular polarization of tilt angle tau
k = (kH+kV+(kH-kV)*cosd(elev).^2*cosd(2*tau))/2;
alpha = (kH*alphaH+kV*alphaV+...
    (kH*alphaH-kV*alphaV)*cosd(elev).^2*cosd(2*tau))./(2*k);

%% Specific attenuation
gammaR = k.*RR.^alpha;
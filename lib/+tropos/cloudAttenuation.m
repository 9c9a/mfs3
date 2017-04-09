function [ att ] = cloudAttenuation(freq,lat,lon,elev,p)
%CLOUDATTENUATION Attenuation due to clouds and fog (ITU-R P.840-6)
% Input parameters:
% 	freq 		: Frequency [GHz]
%   lat,lon     : Ground station coordinates [deg]
%   elev        : Elevation towards satellite [deg]
%   p           : Percentage of an average year [%]
% Output parameters:
%   att         : Attenuation [dB]


%% Step 1: Specific attenuation coefficient
% Calculations for a water temperature of 0ºC
theta = 300/(0+273);

e0 = 77.66 + 103.3*(theta-1);
e1 = 0.0671*e0;
e2 = 3.52;

% Principal and secondary relaxation frequencies
fp = 20.20 - 146*(theta-1) + 316*(theta-1)^2; % (GHz)
fs = 39.8*fp; % (GHz)

% Complex dielectric permitivity of water
ep = (e0-e1)/(1+(freq/fp)^2) + (e1-e2)/(1+(freq/fs)^2) + e2;
es = freq*(e0-e1)/(fp*(1+(freq/fp)^2)) + freq*(e1-e2)/(fs*(1+(freq/fs)^2));

% Specific attenuation coefficient
eta = (2+ep)/es;
Kl = (0.819*freq)/(es*(1+eta^2)); % (dB/km)

%% Step 2: Reduced cloud liquid water content
Lred = tropos.cloudWater(lat,lon,p); % (g/m^3)

%% Step 3: Cloud attenuation along slant paths
att = Lred*Kl./sind(elev);
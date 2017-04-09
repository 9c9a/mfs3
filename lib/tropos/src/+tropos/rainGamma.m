function [ gammaR ] = rainGamma(freq,elev,RR,tau)
%RAINGAMMA Specific attenuation model for rain (ITU-R P.838-3)
% Input parameters:
%   freq        : Frequency [GHz]
%   elev        : Elevation towards satellite [deg]
%   RR          : Rainfall rate [mm/h]
%   tau         : Polarization tilt angle [deg]
% Output parameters:
%   gammaR      : Specific attenuation [dB/km]

%% Import P.838-3 parameters
[pathstr,~,~] = fileparts(mfilename('fullpath'));
folder = 'R-REC-P.838-3';

kHt = dlmread(fullfile(pathstr,folder,'kH.txt'));
kVt = dlmread(fullfile(pathstr,folder,'kV.txt'));
aHt = dlmread(fullfile(pathstr,folder,'alphaH.txt'));
aVt = dlmread(fullfile(pathstr,folder,'alphaV.txt'));

%% Curve-fitting coefficients: k
% Horizontal and vertical polarization 
kH = 10.^(sum(kHt(:,1).*exp(-((log10(freq)-kHt(:,2))./kHt(:,3)).^2))+...
	kHt(1,4)*log10(freq)+kHt(1,5));
kV = 10.^(sum(kVt(:,1).*exp(-((log10(freq)-kVt(:,2))./kVt(:,3)).^2))+...
	kVt(1,4)*log10(freq)+kVt(1,5));

% Linear and circular polarization of tilt angle tau
k = (kH+kV+(kH-kV)*cosd(elev).^2*cosd(2*tau))/2;

%% Curve-fitting coefficients: alpha
% Horizontal and vertical polarization 
alphaH = sum(aHt(:,1).*exp(-((log10(freq)-aHt(:,2))./aHt(:,3)).^2))+...
	aHt(1,4)*log10(freq)+aHt(1,5);
alphaV = sum(aVt(:,1).*exp(-((log10(freq)-aVt(:,2))./aVt(:,3)).^2))+...
	aVt(1,4)*log10(freq)+aVt(1,5);

% Linear and circular polarization of tilt angle tau
alpha = (kH*alphaH+kV*alphaV+...
    (kH*alphaH-kV*alphaV)*cosd(elev).^2*cosd(2*tau))./(2*k);

%% Specific attenuation
gammaR = k.*RR.^alpha;
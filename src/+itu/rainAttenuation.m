function [ att ] = rainAttenuation(freq,lat,lon,elev,p)
%RAINATTENUATION Attenuation due to rainfall (ITU-R P.618-12)
% Input parameters:
%	freq 		: Frequency [GHz]
%   lat,lon     : Ground station coordinates [deg]
%   elev        : Elevation towards satellite [deg]
%   p           : Percentage of an average year [%]
% Output parameters:
%   att         : Attenuation [dB]

% Initialize attenuation to NaN
% This allows avoiding unnecessary calculations later by indexing those
% coordinates where isnan(att)==1
att = nan(size(lat)); % [dB]

% Effective radius of the Earth
Re = 8500; % [km]
% Ground station height above sea level (ITU-R P.1511)
hs = itu.topoHeight(lat,lon); % [km]
%hs = zeros(size(lat))+0.5; % [km]

%% Step 1: Rain height
hr = itu.rainHeight(lat,lon); % [km]

%% Step 2: Slant-path length
% If hr–hs is less than or equal to zero, the predicted rain attenuation 
% for any time percentage is zero
att((hr-hs) <= 0) = 0;

Ls = zeros(size(att));
% Find coordinates where elev >= 5
ix = isnan(att) & (elev >= 5);
if any(ix)
    Ls(ix) = (hr(ix)-hs(ix))./sind(elev(ix)); % [km]
end
% Find coordinates where elev < 5
ix = isnan(att) & (elev < 5);
if any(ix)
    Ls(ix) = 2*(hr(ix)-hs(ix))./(sqrt(sind(elev(ix)).^2+...
        2*(hr(ix)-hs(ix))/Re)+sind(elev(ix))); % [km]
end

%% Step 3: Horizontal projection of the slant-path length
Lg = Ls.*cosd(elev); % [km]

%% Step 4: Rainfall rate exceeded for p% of an average year
RR = itu.rainRate(lat,lon,p); % [mm/h]
% If RR is equal to zero, the predicted rain attenuation is zero
att(RR == 0) = 0;

%% Step 5: Specific attenuation
% Polarization tilt angle [deg]
tau = 45; % circular polarization
% ITU-R P.838-3
gammaR = itu.rainGamma(freq,elev,RR,tau); % [dB/km]

%% Step 6: Horizontal reduction factor
rP = 1./(1 + 0.78*sqrt((Lg.*gammaR)/freq) - 0.38*(1-exp(-2*Lg)));

%% Step 7: Vertical adjustment factor
chi = atand((hr-hs)./(Lg.*rP)); % [deg]

Lr = zeros(size(att));
% Find coordinates where chi > elev
ix = (chi > elev);
if any(ix)
    Lr(ix) = Lg(ix).*rP(ix)./cosd(elev(ix));
end
% Find coordinates where chi <= elev
ix = (chi <= elev);
if any(ix)
    Lr(ix) = (hr(ix)-hs(ix))./sind(elev(ix));
end

X = zeros(size(att));
% Find coordinates where |lat| < 36º
ix = (abs(lat) < 36);
if any(ix)
    X(ix) = 36 - abs(lat(ix));
end
% Find coordinates where |lat| >= 36º
ix = (abs(lat) >= 36);
if any(ix)
    X(ix) = 0;
end

vP = 31*(1-exp(-elev./(1+X))).*(sqrt(Lr.*gammaR))/(freq^2)-0.45;
vP = 1./(1+sqrt(sind(elev)).*vP);

%% Step 8: Effective path length
Lef = Lr.*vP; % [km]

%% Step 9: Attenuation exceeded for p% of an average year
% Find coordinates where att is undefined
ix = isnan(att);
att(ix) = Lef(ix).*gammaR(ix); % [dB]
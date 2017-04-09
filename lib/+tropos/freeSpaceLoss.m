function [ lbf ] = freeSpaceLoss(freq,dist)
%FREESPACELOSS Attenuation due to free-space path loss (FSL)
% Input parameters:
%   freq 		: Frequency [GHz]
%   dist        : Propagation distance or path length [km]
% Output parameters:
%   lbf         : Free-space loss [dB]

lbf = 32.45 + 20*log10(freq)+60 + 20*log10(dist);
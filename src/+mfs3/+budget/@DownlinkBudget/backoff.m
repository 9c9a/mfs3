function [ OBO ] = backoff(~,IBO)
%BACKOFF Output power back-off (OBO)
% Input parameters:
%   IBO         : Input power back-off [dB]
% Output parameters:
%   OBO         : Output power back-off [dB]

% Use absolute value of IBO to avoid sign ambiguity
IBO = -abs(IBO);
OBO = IBO + 6 - 6*exp(IBO/6);
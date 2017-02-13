function [ CIMR ] = carrierIM(this,IBO)
%CARRIERIM Carrier to intermodulation ratio (CIMR)
% Input parameters:
%   IBO         : Satellite input power back-off [dB]
% Output parameters:
%   CIMR        : Carrier to intermodulation ratio [dB]


% Use absolute value of IBO to avoid sign ambiguity
CIMR = 10.532 - 0.09*this.Nc + 1.7*(1e-4)*this.Nc^2 + 0.82*abs(IBO);
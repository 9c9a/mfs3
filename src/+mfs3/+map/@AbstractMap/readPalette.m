function readPalette(this,filename)
%READPALETTE Read color palette from a CSV file
% Input parameters:
%   filename    : File name, specified as character vector
% Output parameters:
%   none

palette = csvread(filename);

if (size(palette,2) ~= 3) || any(any(palette ~= uint8(palette)))
    % Input should be a positive integer in the range [0 255]
    % Mind that csvread returns a double and not an actual uint8 type
    error('Palette must be a non-empty Mx3 array of type uint8')
else
    % Convert to double precision in the range [0 1]
    this.palette = palette*1/255;
end
function readPalette(this,filename)
%READPALETTE Read color palette from a CSV file
% Input parameters:
%   filename    : File name, specified as character vector
% Output parameters:
%   none

% If no argument is provided, read the default color palette supplied with
% this class as 'palette.csv'
if nargin < 2
    pathstr = fileparts(mfilename('fullpath'));
    filename = fullfile(pathstr,'palette.csv');
end
readPalette@mfs3.map.AbstractMap(this,filename)
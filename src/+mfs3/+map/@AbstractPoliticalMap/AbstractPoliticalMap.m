classdef (Abstract) AbstractPoliticalMap < mfs3.map.AbstractMap
%ABSTRACTPOLITICALMAP Base regional 2D map with political borders
% Base abstract class that provides common functions for initializing a UI 
% window and drawing a political map with world borders.
    
    properties (SetAccess = private)
        hL % overlay handle
    end
    
    methods
        function this = AbstractPoliticalMap(proj,region)
            % Initialize superclass
            this = this@mfs3.map.AbstractMap(proj,region);
        end
    end
    
    methods (Access = protected)
        % Protected method signatures
        initUI(this,name)
    end
    
end
classdef (Abstract) AbstractPoliticalMap < multibeam.internal.AbstractMap
%ABSTRACTPOLITICALMAP Base regional 2D map with political borders
% Base abstract class that provides common functions for initializing a UI 
% window and drawing a political map with world borders.
    
    properties (SetAccess = private)
        hL % overlay handle
    end
    
    methods
        function this = AbstractPoliticalMap(proj,region)
            % Initialize superclass
            this = this@multibeam.internal.AbstractMap(proj,region);
        end
    end
    
    methods (Access = protected)
        % Protected method signatures
        initUI(this,name)
    end
    
end
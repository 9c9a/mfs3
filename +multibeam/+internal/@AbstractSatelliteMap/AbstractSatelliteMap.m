classdef (Abstract) AbstractSatelliteMap < multibeam.internal.AbstractMap
%ABSTRACTSATELLITEMAP 2D satellite map for assistance in multibeam FSS planning
    
    properties (SetAccess = private)
        hL % overlay handle
    end
    
    methods
        function this = AbstractSatelliteMap(proj,region)
            % Initialize superclass
            this = this@multibeam.internal.AbstractMap(proj,region);w
        end
    end
    
    methods (Access = protected)
        % Protected method signatures
        hobj = addSatellite(this,lonS)
        hobj = addVisibility(this,lonS,altS,alpha)
        initUI(this,name)
    end

end
classdef (Abstract) AbstractSatelliteMap < mfs3.map.AbstractMap
%ABSTRACTSATELLITEMAP Base regional 2D map with satellite images
% Base abstract class that provides common functions for initializing a UI 
% window and drawing a map with satellite images from NASA's "Blue Marble".    

    properties (SetAccess = private)
        hL % overlay handle
    end
    
    methods
        function this = AbstractSatelliteMap(proj,region)
            % Initialize superclass
            this = this@mfs3.map.AbstractMap(proj,region);
        end
    end
    
    methods (Access = protected)
        % Protected method signatures
        hobj = addSatellite(this,lonS)
        hobj = addVisibility(this,lonS,altS,alpha)
        initUI(this,name)
    end

end

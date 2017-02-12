classdef (Abstract) AbstractMap < handle
%ABSTRACTMAP Base regional 2D map with helper functions
% Base abstract class that provides common functions for initializing a UI 
% window and drawing a map using the Mapping Toolbox.

    properties (SetAccess = protected)
        geoid   % reference ellipsoid
        proj    % map projection
        region  % map region
        palette % color palette
    end
    
    properties (SetAccess = private)
        hF % figure handle
        hA % axes handle
    end
    
    methods
        function this = AbstractMap(proj,region)
            % Reference ellipsoid for Earth's surface
            this.geoid = referenceEllipsoid('sphere','km');
            
            % Map projection & region
            this.proj = lower(proj);
            this.region = lower(region);
            
            % Initialize default color palette
            this.palette = get(0,'DefaultAxesColorOrder');
        end
    end
    
    methods (Abstract)
        % Abstract method signatures
        draw(this)
        clear(this)
    end
    
    methods (Access = protected)
        % Protected method signatures
        hobj = addCircle(this,lat0,lon0,R,color,alpha)
        hobj = addHexagon(this,lat0,lon0,R,phi0,color,alpha)
        hobj = addLabel(this,lat0,lon0,label,color)
        hobj = addPoint(this,lat0,lon0,color)
        initUI(this,name)
    end

end
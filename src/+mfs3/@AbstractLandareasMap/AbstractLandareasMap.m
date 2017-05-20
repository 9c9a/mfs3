classdef (Abstract) AbstractLandareasMap < mfs3.AbstractMap
%ABSTRACTLANDAREASMAP Base regional 2D map with coastlines and landforms
% Base abstract class that provides common functions for initializing a UI 
% window and drawing a map with continental coastlines and landforms.
    
    properties (SetAccess = private)
        hL % overlay handle
    end
    
    methods
        function this = AbstractLandareasMap(proj,region)
            % Initialize superclass
            this = this@mfs3.AbstractMap(proj,region);
        end
    end
    
    methods (Access = protected)
        % Protected method signatures
        initUI(this,name)
    end

end
classdef (Abstract) AbstractLandareasMap < multibeam.internal.AbstractMap
%LANDAREASMAP 2D landareas map for assistance in multibeam FSS planning
    
    properties (SetAccess = private)
        hL % overlay handle
    end
    
    methods
        function this = AbstractLandareasMap(proj,region)
            % Initialize superclass
            this = this@multibeam.internal.AbstractMap(proj,region);
        end
    end
    
    methods (Access = protected)
        % Protected method signatures
        initUI(this,name)
    end

end
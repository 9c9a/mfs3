classdef (Abstract) AbstractPoliticalMap < multibeam.internal.AbstractMap
%POLITICALMAP 2D political map for assistance in multibeam FSS planning
    
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
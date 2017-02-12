classdef InterferenceMap < multibeam.internal.AbstractLandareasMap
%INTERFERENCEMAP Map of multibeam FSS co-channel interference
% Map of co-channel interference across user beams, calculated from typical
% antenna patterns for multibeam satellite systems.

    properties (SetAccess = protected)
        % link budget
        linkB
        % information tables
        tblGrid     % grid
        tblBeams    % user beams
    end
    
    properties (SetAccess = private)
        % graphical object handles
        hData    % surface
        hCBar    % colorbar
    end
    
    methods
        function this = InterferenceMap(lonS,altS,thetaB,tblGrid,tblBeams)
            % Initialize superclass
            this = this@multibeam.internal.AbstractLandareasMap(...
                'mercator','europe2');
            % Initialize figure and axes
            this.initUI('Co-channel Interference Map')
            
            % Initialize link budget
            this.linkB = multibeam.budget.DownlinkBudget(...
                lonS,altS,0,0,thetaB,0,0,0,0);
            
            % Coordinate grid table
            names = {'Lat','Lon','El','Range','Beam'};
            this.tblGrid = sortrows(tblGrid(:,names),{'Lon','Lat'});
            % User beam information table
            names = {'Number','Lat','Lon','Frequency'};
            this.tblBeams = sortrows(tblBeams(:,names),'Number');
            
            % Enable figure
            set(this.hF,'Visible','on')
        end
    end
    
    methods (Access = protected)
        initUI(this,name)
    end
    
end
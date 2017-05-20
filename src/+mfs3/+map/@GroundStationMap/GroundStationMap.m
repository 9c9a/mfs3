classdef GroundStationMap < mfs3.map.AbstractPoliticalMap
%GROUNDSTATIONMAP Map of multibeam FSS ground station locations
% Map of gateway ground station locations and satellite gateway beams.

    properties
        radius  % beam radius [km]
    end
    
    properties (SetAccess = protected)
        tblStations
    end
    
    methods
        function this = GroundStationMap(radius,tblStations)
            % Initialize superclass
            this = this@mfs3.map.AbstractPoliticalMap('mercator','europe');
            % Initialize figure and axes
            this.initUI('Ground Station Locations Map')
            
            % Gateway beam radius on Earth's surface
            this.radius = radius;
            % Read color palette
            this.readPalette();
            
            % Ground station information table
            names = {'Number','City','Lat','Lon'};
            
            this.tblStations = sortrows(tblStations(:,names),'Number');
            this.tblStations.Handle = gobjects(height(tblStations),2);

            % Enable figure
            set(this.hF,'Visible','on')
        end
    end
    
    methods (Access = protected)
        % Protected method signatures
        readPalette(this,filename)
    end

end
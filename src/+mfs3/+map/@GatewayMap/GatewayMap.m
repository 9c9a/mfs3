classdef GatewayMap < mfs3.map.AbstractLandareasMap
%GATEWAYMAP Map of multibeam FSS beam-to-gateway allocation
% Map of user beams grouped by allocated gateway number.

    properties
        radius  % beam radius [km]
    end
    
    properties (SetAccess = protected)
        tblBeams
        tblStations
    end
    
    methods
        function this = GatewayMap(radius,tblBeams,tblStations)
            % Initialize superclass
            this = this@mfs3.map.AbstractLandareasMap('mercator','europe1');
            % Initialize figure and axes
            this.initUI('User Beam to Gateway Allocation Map')
            
            % User beam radius on Earth's surface
            this.radius = radius;
            % Read color palette
            this.readPalette();
            
            % User beam information table
            names = {'Number','Lat','Lon','Gateway'};
            this.tblBeams = sortrows(tblBeams(:,names),'Number');
            this.tblBeams.Handle = gobjects(height(tblBeams),2);
            
            % Ground station information table
            names = {'Number','City','Lat','Lon'};
            this.tblStations = sortrows(tblStations(:,names),'Number');

            % Enable figure
            set(this.hF,'Visible','on')
        end
    end
    
    methods (Access = protected)
        % Protected method signatures
        [idB,hC,hT] = addGateway(this,gate,color,alpha)
        readPalette(this,filename)
    end

end
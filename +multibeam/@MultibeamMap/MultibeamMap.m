classdef MultibeamMap < multibeam.internal.AbstractLandareasMap
%MULTIBEAMMAP Map of multibeam FSS user beam allocation

    properties
        % grid parameters
        radius  % radius [km]
        tilt    % tilt [deg]
    end
        
    properties (SetAccess = protected)
        tblBeams
    end
    
    methods
        function this = MultibeamMap(radius,tilt,tblBeams)
            % Initialize superclass
            this = this@multibeam.internal.AbstractLandareasMap(...
                'mercator','europe1');
            % Initialize figure and axes
            this.initUI('User Beam Allocation Map')
            
            % Initalize input arguments
            if nargin<2
                tilt = 0;
            end
            if nargin<3
                names = {'Number','Lat','Lon'};
                tblBeams = table(0,0,0,'VariableNames',names);
            end
            
            % User beam radius on Earth's surface
            this.radius = radius;
            % User beam grid axial tilt
            this.tilt = tilt;
            % User beam information table
            names = {'Number','Lat','Lon'};
            this.tblBeams = sortrows(tblBeams(:,names),'Number');
            this.tblBeams.Handle = gobjects(height(tblBeams),2);

            % Enable figure
            set(this.hF,'Visible','on')
        end
    end

end
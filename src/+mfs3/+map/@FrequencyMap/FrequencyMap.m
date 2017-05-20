classdef FrequencyMap < mfs3.map.AbstractLandareasMap
%FREQUENCYMAP Map of multibeam FSS frequency reuse across user beams
% Map of user beams grouped by assigned frequency/polarization number.

    properties
        radius  % beam radius [km]
    end
    
    properties (SetAccess = protected)
        tblBeams
    end
    
    methods
        function this = FrequencyMap(radius,tblBeams)
            % Initialize superclass
            this = this@mfs3.map.AbstractLandareasMap(...
                'mercator','europe');
            % Initialize figure and axes
            this.initUI('Frequency Reuse Map')
            
            % User beam radius on Earth's surface
            this.radius = radius;
            
            % User beam information table
            names = {'Number','Lat','Lon','Frequency'};
            this.tblBeams = sortrows(tblBeams(:,names),'Number');
            this.tblBeams.Handle = gobjects(height(tblBeams),2);

            % Enable figure
            set(this.hF,'Visible','on')
        end
    end

end
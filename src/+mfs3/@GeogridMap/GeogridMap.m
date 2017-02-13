classdef GeogridMap < mfs3.internal.AbstractLandareasMap
%GEOGRIDMAP Coordinate grid & beam/gateway assignment map

    properties
        % beam grid parameters
        radius  % radius [km]
        tilt    % tilt [deg]
        % satellite beamwidth
        thetaB  % [deg]
        % uicontrol selections
        option = 'dist' % assignment
    end
    
    properties (SetAccess = protected)
        % link budget
        linkB
        % information tables
        tblGrid     % grid
        tblBeams    % user beams
    end
    
    properties (SetAccess = private)
        % uicontrol object handles
        panel   % uipanel
        popup   % popup for option
        button  % refresh button
        % graphical object handles
        hData   % surface
        hText   % labels
        hCell   % cells
    end
    
    methods
        function this = GeogridMap(...
                lonS,altS,radius,tilt,thetaB,tblGrid,tblBeams)
            % Initialize superclass
            this = this@mfs3.internal.AbstractLandareasMap(...
                'mercator','europe2');
            % Initialize figure and axes
            this.initUI('Association of Beams to Grid Points Map')
            
            % Initialize link budget
            this.linkB = mfs3.budget.LinkBudget(lonS,altS,0);
            % Beam radius on Earth's surface
            this.radius = radius;
            % Beam cell axial tilt
            this.tilt = tilt;
            % Satellite beamwidth
            this.thetaB = thetaB;

            % Coordinate grid table
            names = {'Lat','Lon','El','Range'};
            this.tblGrid = sortrows(tblGrid(:,names),{'Lon','Lat'});
            % User beam information table
            names = {'Number','Lat','Lon','Frequency'};
            this.tblBeams = sortrows(tblBeams(:,names),'Number');
            
            % Enable figure
            set(this.hF,'Visible','on')
        end
    end
    
    methods (Access = protected)
        % Protected method signatures
        initUI(this,name)
        resizeUI(this,source,eventData)
    end
    
    methods (Access = protected)
        % Private method signatures
        popupCallback(this,source,eventData)
        buttonCallback(this,source,eventData)
    end
    
end
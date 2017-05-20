classdef RainfallMap < mfs3.AbstractLandareasMap
%RAINFALLMAP Map of rainfall rate, cloud water content and vapor density
% Map of different parameters relevant to attenuation calculations. Multiple 
% probabilities can be selected through the UI.

    properties
        % uicontrol selections
        option = 'rainfall' % magnitude
        probability = 0.01  % probability (%)
    end
    
    properties (SetAccess = protected)
        % information tables
        tblGrid     % grid
    end
    
    properties (SetAccess = private)
        % uicontrol object handles
        panel   % uipanel
        popup1  % popup for option
        popup2  % popup for probability
        button  % refresh button
        % graphical object handles
        hData   % data plot
        hCBar   % colorbar
    end
    
    methods
        function this = RainfallMap(tblGrid)
            % Initialize superclass
            this = this@mfs3.AbstractLandareasMap(...
                'mercator','europe2');
            % Initialize figure and axes
            this.initUI('Rainfall, Cloud Water & Vapor Map')
            
            % Coordinate grid table
            names = {'Lat','Lon','El','Range'};
            this.tblGrid = sortrows(tblGrid(:,names),{'Lon','Lat'});
            
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
        popupCallback1(this,source,eventData)
        popupCallback2(this,source,eventData)
        buttonCallback(this,source,eventData)
    end
    
end
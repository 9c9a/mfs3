classdef AttenuationMap < multibeam.internal.AbstractLandareasMap
%ATTENUATIONMAP Map of multibeam FSS attenuation

    properties
        % uicontrol selections
        option = 'freespace' % magnitude
        probability = 0.01   % probability (%)
    end
    
    properties (SetAccess = protected)
        % satellite coordinates
        lonS    % longitude [deg]
        altS    % altitude [km]
        % parameters
        freq    % frequency [GHz]
        % information tables
        tblGrid % grid
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
        function this = AttenuationMap(lonS,altS,freq,tblGrid)
            % Initialize superclass
            this = this@multibeam.internal.AbstractLandareasMap(...
                'mercator','europe2');
            % Initialize figure and axes
            this.initUI('Attenuation Map')
            
            % Satellite coordinates
            this.lonS = lonS;
            this.altS = altS;
            % Frequency
            this.freq = freq;
            
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
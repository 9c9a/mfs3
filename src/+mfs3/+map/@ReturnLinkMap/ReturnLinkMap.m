classdef ReturnLinkMap < mfs3.map.AbstractLandareasMap
%RETURNLINKMAP Map of multibeam FSS return link budget
% Map of different parameters relevant to the return link budget, such as 
% carrier-to-noise and carrier-to-intermodulation ratios. Three possible 
% scenarios can be selected: clear sky, rain in uplink and rain in downlink.

    properties
        % uicontrol selections
        option1 = 'CT'       % magnitude
        option2 = 'clearsky' % condition
        prob    = 0.1        % percentage [%]
    end
    
    properties (SetAccess = protected)
        % link budgets
        linkU       % uplink
        linkD       % downlink
        % information tables
        tblGrid     % grid
        tblBeams    % user beams
        tblStations % gateways
    end
    
    properties (SetAccess = private)
        % uicontrol object handles
        panel   % uipanel
        popup1  % popup for option
        popup2  % popup for probability
        popup3  % popup for magnitude
        button  % refresh button
        % graphical object handles
        hData   % data plot
        hCBar   % colorbar
    end
    
    methods
        function this = ReturnLinkMap(...
                lonS,altS,UL,DL,tblGrid,tblBeams,tblStations)
            
            % Initialize superclass
            this = this@mfs3.map.AbstractLandareasMap(...
                'mercator','europe');
            % Initialize figure and axes
            this.initUI('Return Link Budget Map')

            % Uplink budget
            this.linkU = mfs3.budget.UplinkBudget(lonS,altS,...
                UL.freq,UL.EIRP,UL.thetaE,UL.UPC,...
                UL.G_T,UL.thetaS,UL.IBO,...
                UL.B,UL.Nc);
            
            % Downlink budget
            this.linkD = mfs3.budget.DownlinkBudget(lonS,altS,...
                DL.freq,DL.EIRP,DL.thetaS,...
                DL.G_T,DL.thetaE,...
                DL.B,DL.Nc);
            
            % Coordinate grid table
            names = {'Lat','Lon','El','Range','Beam','Gateway'};
            this.tblGrid = sortrows(tblGrid(:,names),{'Lon','Lat'});
            % User beam information table
            names = {'Number','Lat','Lon','El','Range','Frequency'};
            this.tblBeams = sortrows(tblBeams(:,names),'Number');
            % Gateway information table
            names = {'Number','Lat','Lon','El','Range'};
            this.tblStations = sortrows(tblStations(:,names),'Number');
            
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
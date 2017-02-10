classdef LinkBudget
%LINKBUDGET Multibeam FSS link budget calculator

    properties
        % satellite coordinates
        lonS % longitude [deg]
        altS % altitude [km]
        % budget parameters
        freq % frequency [GHz]
    end

    properties (Constant)
        % pointing error
        point = 0.2 % [deg]
    end
    
    properties (SetAccess = protected)
        geoid % reference ellipsoid
    end
    
    methods
        function this = LinkBudget(lonS,altS,freq)
            % Reference ellipsoid for Earth's surface
            this.geoid = referenceEllipsoid('sphere','km');
            
            % Satellite coordinates
            this.lonS = lonS;
            this.altS = altS;
            % Frequency
            this.freq = freq;
        end
    end
    
    methods
        % Public method signatures
        gain = gain(this,lat0,lon0,lat1,lon1,thetaB)
        att = attenuation(this,cond,lat,lon,elev,range,p)
        lpt = pointing(this,thetaB)
    end

end
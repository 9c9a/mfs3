classdef DownlinkBudget < multibeam.budget.LinkBudget
%DOWNLINKBUDGET Multibeam FSS downlink budget calculator

    properties
        % Satellite
        EIRP        % [dBW]
        thetaS      % [deg]
        % Ground station
        G_T         % [dB/K]
        thetaE      % [deg]
        % Bandwidth
        B           % [MHz]
        Nc          % [carriers]
    end
    
    methods
        function this = DownlinkBudget(...
                lonS,altS,freq,EIRP,thetaS,G_T,thetaE,B,Nc)
            % Initialize superclass
            this = this@multibeam.budget.LinkBudget(lonS,altS,freq);
            
            % Satellite
            this.EIRP = EIRP;       % Ground station maximum EIRP [dBW]
            this.thetaS = thetaS;   % Half-power beamwidth [deg]
            % Ground station
            this.G_T = G_T;         % Gain over noise temperature [dB/K]
            this.thetaE = thetaE;   % Half-power beamwidth [deg]
            % Bandwidth
            this.B = B;             % Carrier noise bandwidth [MHz]
            this.Nc = Nc;           % Number of carriers/transponder [-]
        end
    end
    
    methods
        % Public method signatures
        CNR = carrierN(this,cond,lat0,lon0,lat1,lon1,elev,range,OBO,p)
        CIMR = carrierIM(this,IBO,Nc)
    end

end
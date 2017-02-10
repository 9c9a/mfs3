classdef UplinkBudget < multibeam.budget.LinkBudget
%UPLINKBUDGET Multibeam FSS uplink budget calculator

    properties
        % Ground station
        EIRP        % [dBW]
        thetaE      % [deg]
        UPC         % [dB]
        % Satellite
        G_T         % [dB/K]
        thetaS      % [deg]
        IBO         % [dB]
        % Bandwidth
        B           % [MHz]
        Nc          % [carriers]
    end
    
    methods
        function this = UplinkBudget(...
                lonS,altS,freq,EIRP,thetaE,UPC,G_T,thetaS,IBO,B,Nc)
            % Initialize superclass
            this = this@multibeam.budget.LinkBudget(lonS,altS,freq);
            
            % Ground station
            this.EIRP = EIRP;       % Ground station maximum EIRP [dBW]
            this.thetaE = thetaE;   % Half-power beamwidth [deg]
            this.UPC = UPC;         % Uplink power compensation [dB]
            % Satellite
            this.G_T = G_T;         % Gain over noise temperature [dB/K]
            this.thetaS = thetaS;   % Half-power beamwidth [deg]
            this.IBO = IBO;         % Fixed input power back-off [dB]
            % Bandwidth
            this.B = B;             % Carrier noise bandwidth [MHz]
            this.Nc = Nc;           % Number of carriers/transponder [-]
        end
    end
    
    methods
        % Public method signatures
        CNR = carrierN(this,cond,lat0,lon0,lat1,lon1,elev,range,p)
        OBO = backoff(this,cond,lat,lon,elev,p)
    end

end
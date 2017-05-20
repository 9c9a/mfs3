function draw(this)
%DRAW Draw attenuation map

% Grid coordinates
lat = this.tblGrid.Lat;
lon = this.tblGrid.Lon;
% AER towards satellite
elev = this.tblGrid.El;
rang = this.tblGrid.Range;

% Percentage of time to consider
p = this.probability;

%% Calculate data array
% Values exceeded for p% of an average year
switch this.option
    case 'rain' % Attenuation due to rainfall
        data = tropos.rainAttenuation(this.freq,lat,lon,elev,p);
    case 'cloud' % Attenuation due to clouds and fog
        data = tropos.cloudAttenuation(this.freq,lat,lon,elev,p);
    case 'gas' % Attenuation due to atmospheric gasses
        data = tropos.gasAttenuation(this.freq,lat,lon,elev,p);
    case 'freespace' % Attenuation due to FSL
        data = tropos.freeSpaceLoss(this.freq,rang);
end

%% Clear map before redrawing
this.clear()

%% Plot contour levels
[this.hData,this.hCBar] = this.addSurface(lat,lon,data);

switch this.option
    case 'freespace'
        ylabel(this.hCBar,'Attenuation (dB)')
    otherwise
        ylabel(this.hCBar,sprintf(...
            'Attenuation (dB) exceeded for %0.2f%% of an average year',p))
end
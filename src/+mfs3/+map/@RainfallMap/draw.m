function draw(this)
%DRAW Draw rainfall map

% Grid coordinates
lat = this.tblGrid.Lat;
lon = this.tblGrid.Lon;
% Percentage of time to consider
p = this.probability;

%% Calculate data array
% Values exceeded for p% of an average year
switch this.option
    case 'rainfall'
        data = tropos.rainRate(lat,lon,p);
        unit = 'Rate (mm/h)';
    case 'cloudwater'
        data = tropos.cloudWater(lat,lon,p);
        unit = 'Content (kg/m^2)';
    case 'vapor'
        data = tropos.vaporDensity(lat,lon,p);
        unit = 'Density (g/m^3)';
end

%% Clear map before redrawing
this.clear()

%% Plot contour levels
[this.hData,this.hCBar] = this.addContour(lat,lon,data);

label = '%s exceeded for %0.2f%% of an average year';
ylabel(this.hCBar,sprintf(label,unit,p))
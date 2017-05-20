function draw(this)
%DRAW Draw beam-to-gateway allocation map

% Gateway & ground station numbers
% Ignore gateways with no assigned beams
gate = unique(this.tblBeams.Gateway,'sorted');
stat = this.tblStations.Number;

%% Assign colors to each gateway
N = length(gate);
M = size(this.palette,1);

color = repmat(this.palette,floor(N/M),1);
color = vertcat(color,this.palette(1:mod(N,M),:));

%% Clear map before redrawing
this.clear()

%% Plot user beams assigned to each gateway
hobj = gobjects(size(gate));
for n=1:length(gate)
    [idB,hC,hT] = this.addGateway(gate(n),color(n,:),0.6);
    this.tblBeams.Handle(idB,:) = horzcat(hC,hT);
    
    hobj(n) = hC(1);
end

%% Show gateway numbers and cities in legend
item = @(str,n) sprintf('%s (#%d)',str,n);
city = this.tblStations.City(ismember(stat,gate));

legend(this.hA,hobj,...
    cellfun(item,city,num2cell(gate),'UniformOutput',false))
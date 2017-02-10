function draw(this)
%DRAW Draw frequency reuse map

% Frequency numbers
freq = unique(this.tblBeams.Frequency,'sorted');

%% Assign colors to each frequency
M = ceil(length(freq)/size(this.palette,1));

color = repmat(this.palette,M,1);
color = color(1:length(freq),:);

%% Clear map before redrawing
this.clear()

%% Plot user beams assigned to each frequency
hobj = gobjects(size(freq));
for n=1:length(freq)
    [idB,hC,hT] = this.addFrequency(freq(n),color(n,:),0.4);
    this.tblBeams.Handle(idB,:) = horzcat(hC,hT);
    
    hobj(n) = hC(1);
end

%% Show frequency numbers in legend
item = @(N) sprintf('Frequency %d',N);
legend(this.hA,hobj,arrayfun(item,freq,'UniformOutput',false))
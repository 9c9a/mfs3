function hide(this,nB)
%HIDE Remove beams from map by beam number

% Recover graphical object handles
if nargin<2 || isempty(nB)
    hobj = this.tblBeams.Handle;
else
    idx = ismember(this.tblBeams.Number,nB);
    hobj = this.tblBeams.Handle(idx,:);
end

% Disable visibility
set(reshape(hobj,numel(hobj),[]),'Visible','off')
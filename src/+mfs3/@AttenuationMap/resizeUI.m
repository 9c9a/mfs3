function resizeUI(this,source,~)
%RESIZEUI Figure resize callback function

% Get updated figure position
% Assume units are in pixels (default behaviour)
pos = get(source,'Position');

% Panel width and height [px]
w = 335;
h = 44;
left = (1-0.15*w/pos(3))*pos(3)/2;
bttm = 0.08*pos(4);

% Ensure units are not normalized
set(this.panel,'Units','pixels')
% Position elements dinamically
set(this.panel,'Position',[left-w/2 bttm-h/2 w h])
set(this.popup1,'Position',[10 8 200 20])
set(this.popup2,'Position',[215 8 50 20])
set(this.button,'Position',[270 8 52 24])
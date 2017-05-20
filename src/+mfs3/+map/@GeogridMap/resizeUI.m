function resizeUI(this,source,~)
%RESIZEUI Figure resize callback function

% Get updated figure position
% Assume units are in pixels (default behaviour)
pos = get(source,'Position');

% Panel width and height [px]
w = 330;
h = 44;
left = (1-0.15*w/pos(3))*pos(3)/2;
bttm = 0.08*pos(4);

% Ensure units are not normalized
set(this.panel,'Units','pixels')
% Position elements dinamically
set(this.panel,'Position',[left-w/2 bttm-h/2 w h])
set(this.popup,'Position',[10 8 250 20])
set(this.button,'Position',[265 8 52 24])
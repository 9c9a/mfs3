function buttonCallback(this,~,~)
%BUTTONCALLBACK Refresh button UI callback function

% Disable refresh button while redrawing
set(this.button,'Enable','off')
% Force a UI update before continuing execution
drawnow nocallbacks

this.draw()
set(this.button,'Enable','on')
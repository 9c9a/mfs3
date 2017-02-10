function popupCallback(this,source,~)
%POPUPCALLBACK Option popup UI callback function

% Determine the selected data set
str = get(source,'String');
val = get(source,'Value');

switch str{val}
    case 'Associate beams by minimum distance'
        this.option = 'dist';
    case 'Associate beams by maximum gain'
        this.option = 'gain';
    otherwise
        error('Unexpected uicontrol callback value ''%s''',str{val})
end
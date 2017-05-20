function popupCallback2(this,source,~)
%POPUPCALLBACK2 Probability popup UI callback function

% Determine the selected data set
str = get(source,'String');
val = get(source,'Value');

switch str{val}
    case {'0.01','0.1','0.2','0.3','0.5'}
        this.probability = str2double(str{val});
    otherwise
        error('Unexpected uicontrol callback value ''%s''',str{val})
end
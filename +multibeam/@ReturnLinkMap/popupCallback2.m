function popupCallback2(this,source,~)
%POPUPCALLBACK2 Option popup UI callback function

% Determine the selected data set
str = get(source,'String');
val = get(source,'Value');

switch str{val}
    case 'Clear sky'
        this.option2 = 'clearsky';
    case 'Rain in uplink'
        this.option2 = 'rain_u';
    case 'Rain in downlink'
        this.option2 = 'rain_d';
    otherwise
        error('Unexpected uicontrol callback value ''%s''',str{val})
end
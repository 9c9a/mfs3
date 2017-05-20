function popupCallback1(this,source,~)
%POPUPCALLBACK1 Option popup UI callback function

% Determine the selected data set
str = get(source,'String');
val = get(source,'Value');

switch str{val}
    case 'Rainfall rate'
        this.option = 'rainfall';
        set(this.popup2,...
            'String',{'0.01','0.1','0.2','0.3','0.5'},'Value',1)
        this.probability = 0.01;
    case 'Reduced cloud liquid water content'
        this.option = 'cloudwater';
        set(this.popup2,...
            'String',{'0.1','0.2','0.3','0.5'},'Value',1)
        this.probability = 0.1;
    case 'Surface water vapor density'
        this.option = 'vapor';
        set(this.popup2,...
            'String',{'0.1','0.2','0.3','0.5'},'Value',1)
        this.probability = 0.1;
    otherwise
        error('Unexpected uicontrol callback value ''%s''',str{val})
end
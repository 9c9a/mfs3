function popupCallback1(this,source,~)
%POPUPCALLBACK1 Magnitude popup UI callback function

% Determine the selected data set
str = get(source,'String');
val = get(source,'Value');

switch str{val}
    case 'C/(N+I+IM)'
        this.option1 = 'CT';
    case 'C/N uplink'
        this.option1 = 'CNR_U';
    case 'C/N downlink'
        this.option1 = 'CNR_D';
    case 'C/I'
        this.option1 = 'CIR';
    case 'C/IM'
        this.option1 = 'CIMR';
    otherwise
        error('Unexpected uicontrol callback value ''%s''',str{val})
end

switch str{val}
    case 'C/I'
        set(this.popup2,'Enable','off')
        set(this.popup3,'Enable','off')
    otherwise
        set(this.popup2,'Enable','on')
        set(this.popup3,'Enable','on')
end

function popupCallback1(this,source,~)
%POPUPCALLBACK1 Option popup UI callback function

% Determine the selected data set
str = get(source,'String');
val = get(source,'Value');


switch str{val}
    case 'Attenuation due to free-space path loss'
        set(this.popup2,'Enable','off')
    otherwise
        set(this.popup2,'Enable','on')
end


switch str{val}
    case 'Attenuation due to free-space path loss'
        this.option = 'freespace';
    case 'Attenuation due to rainfall'
        this.option = 'rain';
        set(this.popup2,...
            'String',{'0.01','0.1','0.2','0.3','0.5'},'Value',1)
        this.probability = 0.01;
    case 'Attenuation due to clouds and fog'
        this.option = 'cloud';
        set(this.popup2,...
            'String',{'0.1','0.2','0.3','0.5'},'Value',1)
        this.probability = 0.1;
    case 'Attenuation due to atmospheric gasses'
        this.option = 'gas';
        set(this.popup2,...
            'String',{'0.1','0.2','0.3','0.5'},'Value',1)
        this.probability = 0.1;
    otherwise
        error('Unexpected uicontrol callback value ''%s''',str{val})
end
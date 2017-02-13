function popupCallback3(this,source,~)
%POPUPCALLBACK3 Probability popup UI callback function

% Determine the selected data set
str = get(source,'String');
val = get(source,'Value');

switch str{val}
    case '99.9'
        this.prob = 0.1;
    case '99.8'
        this.prob = 0.2;
    case '99.7'
        this.prob = 0.3;
    case '99.5'
        this.prob = 0.5;
    otherwise
        error('Unexpected uicontrol callback value ''%s''',str{val})
end
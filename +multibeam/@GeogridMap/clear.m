function clear(this)
%CLEAR Delete all graphics objects from map

delete(this.hData(isgraphics(this.hData)))
delete(this.hText(isgraphics(this.hText)))
delete(this.hCell(isgraphics(this.hCell)))
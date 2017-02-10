function clear(this)
%CLEAR Delete all graphics objects from map

delete(this.hData(isgraphics(this.hData)))
delete(this.hCBar(isgraphics(this.hCBar)))
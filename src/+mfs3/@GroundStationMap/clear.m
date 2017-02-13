function clear(this)
%CLEAR Delete all graphics objects from map

idx = isgraphics(this.tblStations.Handle);
delete(this.tblStations.Handle(idx))
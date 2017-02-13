function clear(this)
%CLEAR Delete all graphics objects from map

idx = isgraphics(this.tblBeams.Handle);
delete(this.tblBeams.Handle(idx))
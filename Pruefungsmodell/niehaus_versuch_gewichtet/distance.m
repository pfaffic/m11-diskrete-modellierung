## Copyright (C) 2020 chris
## 
## This program is free software: you can redistribute it and/or modify it
## under the terms of the GNU General Public License as published by
## the Free Software Foundation, either version 3 of the License, or
## (at your option) any later version.
## 
## This program is distributed in the hope that it will be useful, but
## WITHOUT ANY WARRANTY; without even the implied warranty of
## MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
## GNU General Public License for more details.
## 
## You should have received a copy of the GNU General Public License
## along with this program.  If not, see
## <https://www.gnu.org/licenses/>.

## -*- texinfo -*- 
## @deftypefn {} {@var{retval} =} getDistance (@var{input1}, @var{input2})
##
## @seealso{}
## @end deftypefn

## Author: chris <chris@SURFACE>
## Created: 2020-08-02

function dist = distance (G,y_Coord,x_Coord)
  dist=-1; %default Value falls Fehler auftritt
  if (nargin != 3)
    error("getDistance (Matrix, Y-Koordinate, X-Koordinate)");
  endif
if (ismatrix(G))
  X=columns(G);
  Y=rows(G);
  [x,y]=meshgrid(1:X,1:Y);
  if (y_Coord > 0 && y_Coord <=Y && x_Coord > 0 && x_Coord <=X)
  for j=1:Y
    for i=1:X
      dist(j,i)=sqrt((x_Coord-i)^2+(y_Coord-j)^2);
    endfor
  endfor
  %dist
  w=1./(1+dist);
  ws=sum(w);
  dist=w./ws;
  else
    error("getDistance: Coordinates must be smaller than the size of the matrix")
  endif
else
  error ("getDistance: expecting matrix argument");
endif
endfunction

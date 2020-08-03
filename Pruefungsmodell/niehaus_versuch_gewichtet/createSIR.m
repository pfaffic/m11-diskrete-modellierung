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
## @deftypefn {} {@var{retval} =} createSIR (@var{input1}, @var{input2})
##
## @seealso{}
## @end deftypefn

## Author: chris <chris@SURFACE>
## Created: 2020-08-03

function [S,I,R] = createSIR (tage, einwohnerzahl, StartKoordinaten,M,N)
  x_start = StartKoordinaten(2);
  y_start = StartKoordinaten(1);
  I_start = 1/einwohnerzahl;
  
  tmpS = ones(M,N);
  tmpS(y_start,x_start)=1-I_start;
  tmpS=reshape(tmpS,1,N*M);
  S = zeros(tage+1,N*M);
  S(1,:)=tmpS;
  
  tmpI = zeros(M,N);
  tmpI(y_start,x_start)=I_start;
  tmpI=reshape(tmpI,1,N*M);
  I=zeros(tage+1,N*M);
  I(1,:)=tmpI;
  
  R = zeros(tage+1,M*N);
endfunction

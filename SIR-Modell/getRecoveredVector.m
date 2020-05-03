## Copyright (C) 2020 Christoph Pfaffmann
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
## @deftypefn {} {@var{retval} =} getRecoveredVector (@var{input1}, @var{input2})
##
## @seealso{}
## @end deftypefn

## Author: Christoph Pfaffmann <christoph@Christophs-MBP.fritz.box>
## Created: 2020-05-02

function recovered= getRecoveredVector (accInfVec, delayTime)
lengthAccumulatedInfectedVector=length(accInfVec);
recovered=zeros(1, lengthAccumulatedInfectedVector);
for i=1:lengthAccumulatedInfectedVector
    if i<=delayTime
      
    else
      recovered(i)=accInfVec(i-delayTime);
    endif
endfor
endfunction

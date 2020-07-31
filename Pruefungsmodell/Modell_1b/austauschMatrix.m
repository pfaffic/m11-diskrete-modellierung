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
## @deftypefn {} {@var{retval} =} austauschMatrix (@var{input1}, @var{input2})
##
## @seealso{}
## @end deftypefn

## Author: chris <chris@PFAFFMANN-PC>
## Created: 2020-07-31

function Austauschmatrix = austauschMatrix (matrix,t)
if(
if (matrix == 1)
Austauschmatrix=    [0.9 , 0.02 , 0.01 , 0.05 , 0.02;
                     0.03, 0.91 , 0.02 , 0.02 , 0.02;
                     0.02, 0.04 , 0.88 , 0.03 , 0.03;
                     0.05, 0.02 , 0.01 , 0.89 , 0.03;
                     0   , 0.01 , 0.08 , 0.01,  0.9  ];
%-------------------------------------------------------------------------------
elseif (matrix == 2)
Austauschmatrix=[0.8 , 0.2 , 0.1 , 0.05 , 0;
                 0.1 , 0.8 , 0.1 , 0.05 , 0;
                 0.05, 0   , 0.6 , 0.2  , 0;
                 0.05, 0   , 0.2 , 0.7  , 0;
                 0   , 0   , 0   , 0    , 1];
%-------------------------------------------------------------------------------
endif
endfunction

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


## Author: Christoph Pfaffmann <christoph@Christophs-MBP.fritz.box>
## Created: 2020-05-02
clear all;
numberOfCitizens=60;
timespan=30; ## timespan in days
basicReproductionNumber=1;
delayTIme=5;
infectedVector=getInfectedVector(numberOfCitizens,timespan,basicReproductionNumber);
accInfVec = getAccumulatedInfectedVector(infectedVector);
recoveredVector=getRecoveredVector(accInfVec,delayTIme);
susceptibleVector=getSusceptibleVector(numberOfCitizens, accInfVec , recoveredVector);
hold on
plot(infectedVector)
plot(recoveredVector)
plot(susceptibleVector)
hold off

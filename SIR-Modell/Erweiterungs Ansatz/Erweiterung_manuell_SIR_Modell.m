close all 
clear all

Anzahl_Gebiete = 3;
Startbedingungen=zeros(Anzahl_Gebiete,7)

%Startbedingungen für Gebiet 1
n=80000000; %Bevölkerungsanzahl
I_Startwert=1; %gibt an wie viel zu Beginn infected sind
R_Startwert=0; %gibt an wie viel zu Beginn recovered sind
BRZ=2; %Basisreproduktionszahl
dt=14; %Zeitspanne
t_unit ="d";
t=50; %Iterationsschritte

Startbedingungen(1,1)=n; %Bevölkerungsanzahl
Startbedingungen(1,2)=I_Startwert; %gibt an wie viel zu Beginn infected sind
Startbedingungen(1,3)=R_Startwert; %gibt an wie viel zu Beginn recovered sind
Startbedingungen(1,4)=BRZ; %Basisreproduktionszahl
Startbedingungen(1,5)=dt; %Zeitspanne
Startbedingungen(1,6)=t_unit;
Startbedingungen(1,7)=t; %Iterationsschritte

%Startbedingungen für Gebiet 2
n=5000000; %Bevölkerungsanzahl
I_Startwert=1; %gibt an wie viel zu Beginn infected sind
R_Startwert=0; %gibt an wie viel zu Beginn recovered sind
BRZ=2; %Basisreproduktionszahl
%Diese Werte bleiben gleich
%dt=14; %Zeitspanne
%t_unit ="Tagen";
%t=50; %Iterationsschritte

Startbedingungen(2,1)=n; %Bevölkerungsanzahl
Startbedingungen(2,2)=I_Startwert; %gibt an wie viel zu Beginn infected sind
Startbedingungen(2,3)=R_Startwert; %gibt an wie viel zu Beginn recovered sind
Startbedingungen(2,4)=BRZ; %Basisreproduktionszahl
Startbedingungen(2,5)=dt; %Zeitspanne
Startbedingungen(2,6)=t_unit;
Startbedingungen(2,7)=t; %Iterationsschritte

%Startbedingungen für Gebiet 3
n=20000000; %Bevölkerungsanzahl
I_Startwert=1; %gibt an wie viel zu Beginn infected sind
R_Startwert=0; %gibt an wie viel zu Beginn recovered sind
BRZ=1.8; %Basisreproduktionszahl
%Diese Werte bleiben gleich
%dt=14; %Zeitspanne
%t_unit ="Tagen";
%t=50; %Iterationsschritte

Startbedingungen(3,1)=n; %Bevölkerungsanzahl
Startbedingungen(3,2)=I_Startwert; %gibt an wie viel zu Beginn infected sind
Startbedingungen(3,3)=R_Startwert; %gibt an wie viel zu Beginn recovered sind
Startbedingungen(3,4)=BRZ; %Basisreproduktionszahl
Startbedingungen(3,5)=dt; %Zeitspanne
Startbedingungen(3,6)=t_unit;
Startbedingungen(3,7)=t; %Iterationsschritte

%Initialisierung der S,I,R Matrizen
S=zeros(Anzahl_Gebiete,t)
I=zeros(Anzahl_Gebiete,t)
R=zeros(Anzahl_Gebiete,t)

for i=1:Anzahl_Gebiete
  [S(i,:),I(i,:),R(i,:)]=SIR_Modell(i,Startbedingungen(i,1), Startbedingungen(i,2), Startbedingungen(i,3), Startbedingungen(i,4), Startbedingungen(i,5), Startbedingungen(i,6), Startbedingungen(i,7))
endfor







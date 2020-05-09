close all 
clear all

Anzahl_Gebiete = 3;
dt=14; %Zeitspanne
t_unit ="d";
t=100; %Iterationsschritte

Startbedingungen=zeros(Anzahl_Gebiete,7)

%Initialisierung der S,I,R Matrizen
S=zeros(Anzahl_Gebiete,t)
I=zeros(Anzahl_Gebiete,t)
R=zeros(Anzahl_Gebiete,t)

for i=1:Anzahl_Gebiete

  %Startbedingungen für Gebiet 1
  n=floor(minMaxRand(1000000,80000000)); %Bevölkerungsanzahl
  I_Startwert=floor(minMaxRand(1,2)); %gibt an wie viel zu Beginn infected sind
  R_Startwert=floor(minMaxRand(0,I_Startwert)); %gibt an wie viel zu Beginn recovered sind
  BRZ=minMaxRand(1.1,2); %Basisreproduktionszahl

  
  Startbedingungen(i,1)=n; %Bevölkerungsanzahl
  Startbedingungen(i,2)=I_Startwert; %gibt an wie viel zu Beginn infected sind
  Startbedingungen(i,3)=R_Startwert; %gibt an wie viel zu Beginn recovered sind
  Startbedingungen(i,4)=BRZ; %Basisreproduktionszahl
  Startbedingungen(i,5)=dt; %Zeitspanne
  Startbedingungen(i,6)=t_unit;
  Startbedingungen(i,7)=t; %Iterationsschritte



  [S(i,:),I(i,:),R(i,:)]=SIR_Modell(Startbedingungen(i,1), Startbedingungen(i,2), Startbedingungen(i,3), Startbedingungen(i,4), Startbedingungen(i,5), Startbedingungen(i,6), Startbedingungen(i,7))

endfor







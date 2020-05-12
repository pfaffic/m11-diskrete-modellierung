close all 
clear all

Anzahl_Gebiete = 4;
dt=14; %Zeitspanne
t_unit ="d";
t=100; %Iterationsschritte

Startbedingungen=zeros(Anzahl_Gebiete,7);

%Initialisierung der S,I,R Matrizen
S=zeros(Anzahl_Gebiete,t);
I=zeros(Anzahl_Gebiete,t);
R=zeros(Anzahl_Gebiete,t);

for i=1:Anzahl_Gebiete

  %Startbedingungen für Gebiet 1
  n=round(minMaxRand(1000000,80000000)); %Bevölkerungsanzahl
  I_Startwert=round(minMaxRand(1,2)); %gibt an wie viel zu Beginn infected sind
  R_Startwert=round(minMaxRand(0,I_Startwert)); %gibt an wie viel zu Beginn recovered sind
  BRZ=minMaxRand(1.1,2); %Basisreproduktionszahl

  
  Startbedingungen(i,1)=n; %Bevölkerungsanzahl
  Startbedingungen(i,2)=I_Startwert; %gibt an wie viel zu Beginn infected sind
  Startbedingungen(i,3)=R_Startwert; %gibt an wie viel zu Beginn recovered sind
  Startbedingungen(i,4)=BRZ; %Basisreproduktionszahl
  Startbedingungen(i,5)=dt; %Zeitspanne
  Startbedingungen(i,6)=t_unit;
  Startbedingungen(i,7)=t; %Iterationsschritte
endfor

Gebiete=Startbedingungen(1:Anzahl_Gebiete,1:3):
S_Gebiete = Gebiete(1:Anzahl_Gebiete,1);
I_Gebiete = Gebiete(1:Anzahl_Gebiete,2);
R_Gebiete = Gebiete(1:Anzahl_Gebiete,3);

for i=1:Anzahl_Gebiete
  [S(i,:),I(i,:),R(i,:)]=SIR_Modell(1, Startbedingungen(i,1), Startbedingungen(i,2), Startbedingungen(i,3), Startbedingungen(i,4), Startbedingungen(i,5), Startbedingungen(i,6), Startbedingungen(i,7));

endfor







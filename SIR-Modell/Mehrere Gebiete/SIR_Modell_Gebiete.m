clear all
close all
% In eine Grafik plotten
plotteInMehrereGrafiken=false;
plotsAlsBilderSpeichern=false;
%gilt für jedes Gebiet
dt=14; %Zeitspanne
t_unit ="Tage";
t=50; %Iterationsschritte

%Startwerte für die einzelnen Gebiete
n= [800000, 500000, 600000, 300000, 175000]; %Bevölkerungsanzahl für die einzelnen Gebiete (die einem Reihenvektor dargestellt werden)
I_Startwert=[1, 1, 1, 1, 1]; %gibt an wie viel zu Beginn infected sind in den einzelnen Gebieten
R_Startwert=[0, 0, 0, 0, 0]; %gibt an wie viel zu Beginn recovered sind in den einzelnen Gebieten
BRZ=[2.2, 2, 1.4, 1.3, 2]; %Basisreproduktionszahl für die einzelnen Gebiete

Gebiete=length(n); %Die Anzahl der Gebiete entspricht der Länge des Vektors n
%T=t*dt; %Beobachtungszeitraum (Iterationsschritte mal Zeitspanne)

%Anfangsvektoren erstellen
S=zeros(t,Gebiete); % Zeilenvektor  der Susceptibles mit der Anzahl der Gebiete als Reihen und die Anzahl der Iterationsschritte als Spalten
I=zeros(t,Gebiete); %  Zeilenvektor der Infected mit der Anzahl der Gebiete und die Anzahl der Iterationsschritte als Spalten
R=zeros(t,Gebiete); % Zeilenvektor  der Recovered mit der Anzahl der Gebiete und die Anzahl der Iterationsschritte als Spalten

%Austauschmatrix festlegen
Austauschmatrix=[0.9 , 0.02 , 0.01 , 0.05 , 0.02;
                 0.03, 0.91 , 0.02 , 0.02 , 0.02;
                 0.02, 0.04 , 0.88 , 0.03 , 0.03;
                 0.05, 0.02 , 0.01 , 0.89 , 0.03;
                 0   , 0.01 , 0.08 , 0.01,  0.9  ];



%Beginn der Iteration

for day=1:t 
  for g=1:Gebiete
    if day==1 %== bedeutet, schau, ob day gleich 1 ist
      S(day,g)=n(g)-I_Startwert(g)-R_Startwert(g); %gibt Anzahl der susceptible in jeweiliigen Gebiet zu Tag 1 an
      I(day,g)=I_Startwert(g);
      R(day,g)=R_Startwert(g);
    else
      R(day,g)=I(day-1,g)+R(day-1,g); %recovered sind die infected vom Iterationsschritt zuvor (i-1) plus die recovered vom Iterationsschritt zuvor 
      I(day,g)=I(day-1,g)*BRZ(g)*(S(day-1,g)/n(g)); %jeder infected vom Iterationsschritt zuvor steckt mit einem BRZ-Faktor die Leute an, die noch ansteckbar sind und diese Zahl wird durch Gesamtzahl der Personen geteilt, dass man die Rate erhält (Normierung auf1)
      S(day,g)=n(g)-I(day,g)-R(day,g); %Bevölkerungsanzahl minus die infected zu dem Interationsschritt minus recovered zu dem Iterationsschritt
    endif 
              
    endfor %Hier wechseln die Leute von einem Gebiet zum anderen
    Sneu(day,1:Gebiete)=S(day,1:Gebiete)*Austauschmatrix; %gibt die neue Anzahl der Menschen in den Gebieten, die dorthin gewechselt haben (entsteht durch die alte Anzahl der Menschen mal Prozentanzahl der einzelnen Gebiete, wie viele Leute wechseln-> steht in Austauschmatrix)
    Ineu(day,1:Gebiete)=I(day,1:Gebiete)*Austauschmatrix;
    Rneu(day,1:Gebiete)=R(day,1:Gebiete)*Austauschmatrix;
endfor

%Plotten der funktionen für jedes Gebiet
for g=1:Gebiete
  if(plotteInMehrereGrafiken)
  figure(g) %für jeden Durchgang wird ein Bild erstellt
  endif
  hold on
    plot(Sneu(:,g), "b") %b macht Graph blau
    plot(Ineu(:,g),"r") %r -> rot
    plot(Rneu(:,g),"y") %y -> gelb
    
  hold off
  title(['Gebiet: ' num2str(g)])
  legend('Susceptibles', 'Infected','Recovered')%Beschriftung der Funktionen
  ylabel('Anzahl Personen') %Beschriftung y-Achse
  xlabel(['Zeit in ' num2str(dt) ' ' t_unit])  %
  if(plotsAlsBilderSpeichern && plotteInMehrereGrafiken)
    filename=["SIR_plot_Gebiet" num2str(g) ".jpg"];
    saveas((g), filename);
    close all;
  endif
endfor
%Startwerte von S stimmt nicht mit Bild ein, da sich die Menschen schon an Tag eins bewegen
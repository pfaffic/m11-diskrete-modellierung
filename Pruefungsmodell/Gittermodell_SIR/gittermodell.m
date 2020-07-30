clear all
close all
%Erkrankungsrate ->  setzt sich aus der Wahrscheinlichkeit einer Infektionsübertragung bei Kontakt mal Kontaktrate (wie viele Leute man am Tag trifft) zusammen
erkrankungsrate = 0.25;

%Genesungsrate
genesungsrate = 1/14;

%Basisreproduktionszahl =also lineare Rate, mit der Gesunde erkranken dividiert durch lineare Rate, mit der Infizierte genesen -> wie viele Personen ein Infizierter ansteckt
BRZ= erkrankungsrate/genesungsrate;

%Einwohnerzahl in einem Gebiet
einwohnerzahl= 1000;

%Anzahl der Tage
t=150;

%Dunkelziffer

Gebiete=5;

%Anfangsvektoren erstellen
S=zeros(t+1,Gebiete);
I=zeros(t+1,Gebiete);
R=zeros(t+1,Gebiete);

%Startwerte für die einzelnen Gebiete festlegen
S_startwert = [1-1/einwohnerzahl,1,1,1,1];
I_startwert=[1/einwohnerzahl,0,0,0,0]; 
R_startwert=[0,0,0,0,0];

Gebiete=length(S_startwert);


%Anfangsvektoren überschreiben
S(1,:)= S_startwert; %alle Spalteneinträge von S_startwert in die Spalten der ersten Zeile von S eintragen
I(1,:)= I_startwert;
R(1,:)= R_startwert;


%-------------------------------------------------------------------------------
% Programmiere verschiedene Bewegungsmuster
%-------------------------------------------------------------------------------
matrix = 3;
if (matrix == 1)
Austauschmatrix=[0.9 , 0.02 , 0.01 , 0.05 , 0.02;
                 0.03, 0.91 , 0.02 , 0.02 , 0.02;
                 0.02, 0.04 , 0.88 , 0.03 , 0.03;
                 0.05, 0.02 , 0.01 , 0.89 , 0.03;
                 0   , 0.01 , 0.08 , 0.01,  0.9  ];
%-------------------------------------------------------------------------------
elseif (matrix == 2)
Austauschmatrix=[0.50, 0.05, 0.10, 0.25, 0.10,
                 0.10, 0.30, 0.05, 0.40, 0.15,
                 0.05, 0.10, 0.70, 0.10, 0.05,
                 0.15, 0.50, 0.15, 0.10, 0.10,
                 0.20, 0.05, 0.00, 0.15, 0.60];
%-------------------------------------------------------------------------------
elseif (matrix == 3)
Austauschmatrix=[0.8 , 0.2 , 0.1 , 0.05 , 0;
                 0.1 , 0.8 , 0.1 , 0.05 , 0;
                 0.05, 0   , 0.6 , 0.2  , 0;
                 0.05, 0   , 0.2 , 0.7  , 0;
                 0   , 0   , 0   , 0    , 1];
%-------------------------------------------------------------------------------
endif

Gebietsmatrix=zeros(3,2);
%Entwicklung von S, I, R
for  i=1:t
    for g=1:Gebiete
        S(i+1,g)= S(i,g) - erkrankungsrate*S(i,g)*I(i,g);
        I(i+1,g)= I(i,g) + erkrankungsrate*S(i)*I(i,g) - genesungsrate*I(i,g);
        R(i+1,g)= R(i,g) + genesungsrate*I(i,g);
    endfor
    Sneu(i,1:Gebiete)=S(i,1:Gebiete)*Austauschmatrix; %gibt die neue Anzahl der Menschen in den Gebieten, die dorthin gewechselt haben (entsteht durch die alte         Anzahl der Menschen mal Prozentanzahl der einzelnen Gebiete, wie viele Leute wechseln-> steht in Austauschmatrix)
    Ineu(i,1:Gebiete)=I(i,1:Gebiete)*Austauschmatrix;
    Rneu(i,1:Gebiete)=R(i,1:Gebiete)*Austauschmatrix;
    k=5;
    for m=1:3 %Zeile
        for n=1:2 %Spalte
            if(n*m<Gebiete)
            Gebietsmatrix(m,n)=Ineu(i,k);
            k=k-1;
            endif
        endfor
    endfor
    if(i<250)
        Gebietsmatrix;
        figure(i+50)
        scatter3(1:3,1:3,Gebietsmatrix);
        axis([1 2 1 3 0 0.3])
        title(["Tag = " num2str(i)])
        filename=["Gitter_Gebiet" num2str(i) ".jpg"];
        saveas((i+50), filename);
        close all
    endif
endfor



%Plotten ein/ausschalten
plotteInMehrereGrafiken = true;
plotsAlsBilderSpeichern = false;

%Plotten der funktionen für jedes Gebiet
for g=1:Gebiete
  if(plotteInMehrereGrafiken == true)
  figure(g) %für jeden Durchgang wird ein Bild erstellt
  endif
  hold on
    plot(Sneu(:,g), "b") %b macht Graph blau
    plot(Ineu(:,g),"r") %r -> rot
    plot(Rneu(:,g),"y") %y -> gelb
  hold off

%Plotten der Funktionen für jedes Gebiet
%for g=1:Gebiete
%  if(plotteInMehrereGrafiken == true)
%  figure(g) %für jeden Durchgang wird ein Bild erstellt
%  endif
%  hold on
%    plot(S(:,g), "b") %b macht Graph blau
%    plot(I(:,g),"r") %r -> rot
%    plot(R(:,g),"y") %y -> gelb
%  hold off

axis([0 170 0 1.3])
  title(['Gebiet: ' num2str(g)])
  legend('Susceptibles', 'Infected','Recovered')%Beschriftung der Funktionen
  xlabel('Tage') %Beschriftung der x-Achse
  ylabel('relativer Anteil') %Beschriftung der y-Achse
  if(plotsAlsBilderSpeichern && plotteInMehrereGrafiken)
    filename=["SIR_plot_Gebiet" num2str(g) ".jpg"];
    saveas((g), filename);
    close all;
  endif
endfor
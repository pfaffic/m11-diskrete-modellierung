clear;
close all;
%Plotten ein/ausschalten
plotteInMehrereGrafiken = false;
plotsAlsBilderSpeichern = true;






%Erkrankungsrate ->  setzt sich aus der Wahrscheinlichkeit einer Infektionsübertragung bei Kontakt mal Kontaktrate (wie viele Leute man am Tag trifft) zusammen
erkrankungsrate = [0.25, 0.25, 0.25, 0.25, 0.25];

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
I_start = 1/einwohnerzahl;
S_startwert = [1-I_start,1,1,1,1];
I_startwert=[I_start,0,0,0,0]; 
R_startwert=[0,0,0,0,0];

Gebiete=length(S_startwert);


%Anfangsvektoren überschreiben
S(1,:)= S_startwert; %alle Spalteneinträge von S_startwert in die Spalten der ersten Zeile von S eintragen
I(1,:)= I_startwert;
R(1,:)= R_startwert;


%-------------------------------------------------------------------------------
% Programmiere verschiedene Bewegungsmuster
%-------------------------------------------------------------------------------
matrix = 1;
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


%Entwicklung von S, I, R
lockdown=10
lockup=40
for  i=1:t
    for g=1:Gebiete
        S(i+1,g)= S(i,g) - erkrankungsrate(g)*S(i,g)*I(i,g);
        I(i+1,g)= I(i,g) + erkrankungsrate(g)*S(i)*I(i,g) - genesungsrate*I(i,g);
        R(i+1,g)= R(i,g) + genesungsrate*I(i,g);
    endfor
  if(i<=lockdown || i>lockup)
    Austausch = Austauschmatrix;
  else
    Austausch = 1;
  endif
    S(i+1,:)=S(i+1,:)*Austausch;%gibt die neue Anzahl der Menschen in den Gebieten, die dorthin gewechselt haben (entsteht durch die alte Anzahl der Menschen mal Prozentanzahl der einzelnen Gebiete, wie viele Leute wechseln-> steht in Austauschmatrix)
    I(i+1,:)=I(i+1,:)*Austausch;
    R(i+1,:)=R(i+1,:)*Austausch;
        
    
endfor

%Plotten der funktionen für jedes Gebiet
for g=1:Gebiete
  if(plotteInMehrereGrafiken == true)
    figure(g) %für jeden Durchgang wird ein Bild erstellt
  else
    figure (1)
  endif
  hold on
    plot(S(:,g), "color", [0 0 1]) %rgb macht Graph blau
    plot(I(:,g), "color", [1 0 0]) %rgb -> rot
    plot(R(:,g), "color", [0.8 0.8 0]) %rgb -> dunkelgelb
  hold off

axis([0 t+10 0 1.3])
  if (plotteInMehrereGrafiken)
    title(['Lockdown am Tag: ' num2str(lockdown) "   Lockup am Tag: " num2str(lockup) "  Gebiet: " num2str(g)])
  else
     title(['Lockdown am Tag: ' num2str(lockdown) "   Lockup am Tag: " num2str(lockup) "  Alle Gebiete"])
  endif
  legend('Susceptibles', 'Infected','Recovered')%Beschriftung der Funktionen
  xlabel('Tage') %Beschriftung der x-Achse
  ylabel('relativer Anteil') %Beschriftung der y-Achse
  if(plotsAlsBilderSpeichern && !plotteInMehrereGrafiken)
    filename=["GLP_Modell_1b_Matrix_" num2str(matrix) "_Alle_Gebiete_Lockdown_" num2str(lockdown) "_Lockup_" num2str(lockup) ".jpg"];
    saveas((1), filename);
  elseif (plotsAlsBilderSpeichern && plotteInMehrereGrafiken)
    filename=["GLP_Modell_1b_Matrix_" num2str(matrix) "_Gebiet_" num2str(g) "_Lockdown_" num2str(lockdown) "_Lockup_" num2str(lockup) ".jpg"];
    saveas((g), filename);
  endif
endfor

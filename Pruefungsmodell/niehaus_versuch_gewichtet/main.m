close all;
clear;

GitterBreite = 24;
GitterHoehe = 24;
Koordinaten_Startgebiet = [3 3];

M=GitterHoehe+1;
N=GitterBreite+1;
AnzahlGebiete = M * N;

Tage = 200;

EinwohnerJeGebiet = 1000;
erkrankungsrate = 0.25;
genesungsrate = 1/14;


if (Koordinaten_Startgebiet(1)<1 || Koordinaten_Startgebiet(1) > N)
  error("X-Koordinate liegt nicht im Gitter");
elseif (Koordinaten_Startgebiet(2)<1 || Koordinaten_Startgebiet(2) > M)
  error("Y-Koordinate liegt nicht im Gitter");
endif

[S,I,R] = createSIR(Tage, EinwohnerJeGebiet, Koordinaten_Startgebiet, M, N);

kumm_S_inGebiet=0;
kumm_I_inGebiet=0;
kumm_R_inGebiet=0;

for  t=1:Tage
  tneu=t+1;
  for g=1:AnzahlGebiete
      S(tneu,g)= S(t,g) - erkrankungsrate*S(t,g)*I(t,g);
      I(tneu,g)= I(t,g) + erkrankungsrate*S(t,g)*I(t,g) - genesungsrate*I(t,g);
      R(tneu,g)= R(t,g) + genesungsrate*I(t,g);
  endfor
  
  S_Gebiet=reshape(S(tneu,:),M,N);
  I_Gebiet=reshape(I(tneu,:),M,N);
  R_Gebiet=reshape(R(tneu,:),M,N);
  
  Bewegungstage = [1]; % An diesen Tagen soll bewegung stattfinden
  if(lookup(sort(Bewegungstage),t,"b")) %ist t ein Element von Bewegungstage (nach groeße sortiert), dann true, sonst false
  Bewegungstag = t; %Bewegungstag = t, zur Beschriftung benötigt
  
  S_Gebiet = bewegung(S_Gebiet);
  I_Gebiet = bewegung(I_Gebiet);
  R_Gebiet = bewegung(R_Gebiet);
  endif
  S(tneu,:) = reshape(S_Gebiet,1,M*N);
  I(tneu,:) = reshape(I_Gebiet,1,M*N);
  R(tneu,:) = reshape(R_Gebiet,1,M*N);
  
  S_inGebiet(tneu) = round(EinwohnerJeGebiet*sum(S(tneu,:)));
  I_inGebiet(tneu) = round(EinwohnerJeGebiet*sum(I(tneu,:)));
  R_inGebiet(tneu) = round(EinwohnerJeGebiet*sum(R(tneu,:)));
  
  I_max = max(I_inGebiet);
  

  if(true)
    figure(t)
    surfc(I_Gebiet);
    title(["Infizierte der Gebiete - Bewegung zw. Tag: " num2str(Bewegungstag-1) " und " num2str(Bewegungstag)])
    text(-floor(6*N/10),floor(4*M/10),["Tag: " num2str(t) "\n" "S\tca.: " num2str(S_inGebiet(tneu)) "\t[" num2str(100*(S_inGebiet(tneu)/(AnzahlGebiete*EinwohnerJeGebiet))) "%]" "\n" "I\tca.: " num2str(I_inGebiet(tneu)) "\t[" num2str(100*(I_inGebiet(tneu)/(AnzahlGebiete*EinwohnerJeGebiet))) "%]\tmax: " num2str(I_max) "\t[" num2str(100*(I_max/(AnzahlGebiete*EinwohnerJeGebiet))) "%]\n" "R\tca.: " num2str(R_inGebiet(tneu)) "\t[" num2str(100*(R_inGebiet(tneu)/(AnzahlGebiete*EinwohnerJeGebiet))) "%]"],"fontsize", 11)
    zlabel(["Anzahl Personen in " num2str(EinwohnerJeGebiet) " pro Gebiet"])
    axis([1 N 1 M 0 0.45])
    colormap('jet');
    colorbar ("SouthOutside")
    saveas((t),["Infizierte/GLP_Infizierte_Tag_" num2str(t) ".jpg"])
  endif
endfor

%Plotten der Funktionen für jedes Gebiet 
if(false)
for g=1:AnzahlGebiete
figure(Tage+g)
  hold on
    plot(S(:,g), "color", [0 0 1])   %rgb macht Graph blau 
    plot(I(:,g), "color", [1 0 0])   %rgb -> rot 
    plot(R(:,g), "color", [0.8 0.8 0])   %rgb -> dunkelgelb 
  hold off

 axis([0 t+10 0 1.3])
 title(["SIR Modell - Gebiet: " num2str(g)]) %Ueberschrift der Grafik 
 legend('Susceptibles', 'Infected','Recovered')%Beschriftung der Funktionen 
 xlabel('Tage')  %Beschriftung der x-Achse 
 ylabel('relativer Anteil')  %Beschriftung der y-Achse 
 filename=["SIR/GLP_Modell_Bewegung_Gebiet_" num2str(g)  ".jpg"];
 saveas((Tage+g), filename);
endfor
endif


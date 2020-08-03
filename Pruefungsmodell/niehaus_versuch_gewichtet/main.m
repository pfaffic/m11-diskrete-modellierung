close all;
clear;

GitterBreite = 8;
GitterHoehe = 8;
Koordinaten_Startgebiet = [5 7];

M=GitterHoehe+1;
N=GitterBreite+1;
AnzahlGebiete = M * N;

Tage = 150;

EinwohnerJeGebiet = 1000;
erkrankungsrate = 0.25;
genesungsrate = 1/14;


if (Koordinaten_Startgebiet(1)<1 || Koordinaten_Startgebiet(1) > N)
  error("X-Koordinate liegt nicht im Gitter");
elseif (Koordinaten_Startgebiet(2)<1 || Koordinaten_Startgebiet(2) > M)
  error("Y-Koordinate liegt nicht im Gitter");
endif

[S,I,R] = createSIR(Tage, EinwohnerJeGebiet, Koordinaten_Startgebiet, M, N);

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
  if(t==1)
  S_Gebiet = bewegung(S_Gebiet);
  I_Gebiet = bewegung(I_Gebiet);
  R_Gebiet = bewegung(R_Gebiet);
  endif
  S(tneu,:) = reshape(S_Gebiet,1,M*N);
  I(tneu,:) = reshape(I_Gebiet,1,M*N);
  R(tneu,:) = reshape(R_Gebiet,1,M*N);
  

  if(true)
    figure(t)
    surface(I_Gebiet);
    title(["Infizierte am Tag: " num2str(t)])
    xlabel("x-Achse")
    ylabel("y-Achse")
    zlabel("Anzahl Personen")
    colormap('jet');
    colorbar
    saveas((t),["Infizierte/GLP_Infizierte_Tag_" num2str(t-1) ".jpg"])
  endif
endfor

%Plotten der Funktionen für jedes Gebiet 
if(true)
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


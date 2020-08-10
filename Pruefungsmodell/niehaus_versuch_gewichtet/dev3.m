GitterBreite = 3;
GitterHoehe = 3;
Koordinaten_Startgebiet = [2 3]; %In diesem Gebiet gibt es zum Zeitpunkt t0 Infizierte

M=GitterHoehe+1; % 1 höher wegen der Indizierung der Vektoren bzw. Matrizen in Octave
N=GitterBreite+1;
AnzahlGebiete = M * N; 

Tage = 150;

EinwohnerJeGebiet = 1000;
erkrankungsrate = 0.25;
genesungsrate = 1/14;

...

[S,I,R] = createSIR(Tage, EinwohnerJeGebiet, Koordinaten_Startgebiet, M, N); %erstellt die S,I,R Matrizen analog zum ersten Modell
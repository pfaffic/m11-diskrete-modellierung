clear all
close all
n=[80000000, 10000]; %Bevölkerungsanzahl
I_Startwert=1; %gibt an wie viel zu Beginn infected sind
R_Startwert=0; %gibt an wie viel zu Beginn recovered sind
BRZ=2; %Basisreproduktionszahl
dt=14; %Zeitspanne
t_unit ="Tage";
t=50; %Iterationsschritte



T=t*dt; %Beobachtungszeitraum (Iterationsschritte mal Zeitspanne)

%Anfangsvektoren erstellen
  S=zeros(1, t); % Zeilenvektor  der Susceptibles mit einer Zeile und die Anzahl der Iterationsschritte als Spalten
  I=zeros(1,t); %  Zeilenvektor der Infected mit einer Zeile und die Anzahl der Iterationsschritte als Spalten
  R=zeros(1,t); % Zeilenvektor  der Recovered mit einer Zeile und die Anzahl der Iterationsschritte als Spalten

%Startbedingungen festlegen


%Beginn der Iteration
for i=1:t 
  if i==1 %== bedeutet, schau, ob i gleich 1 ist
    S(1,1)=n-I_Startwert-R_Startwert; 
    I(1,1)=I_Startwert;
    R(1,1)=R_Startwert;
  else
    R(1,i)=I(1,i-1)+R(1,i-1); %recovered sind die infected vom Iterationsschritt zuvor (i-1) plus die recovered vom Iterationsschritt zuvor 
    I(1,i)=I(1,i-1)*BRZ*(S(1,i-1)/n); %jeder infected vom Iterationsschritt zuvor steckt mit einem BRZ-Faktor die Leute an, die noch ansteckbar sind und diese Zahl wird durch Gesamtzahl der Personen geteilt, dass man die Rate erhält (Normierung auf1)
    S(1,i)=n-I(1,i)-R(1,i); %Bevölkerungsanzahl minus die infected zu dem Interationsschritt minus recovered zu dem Iterationsschritt
   endif 
endfor

%Plotten der funktionen
hold on
  plot(S,"b") %b macht Graph blau
  plot(I,"r") %r -> rot
  plot(R,"y") %y -> gelb
hold off

legend('Susceptibles', 'Infected','Recovered')%Beschriftung der Funktionen
ylabel('Anzahl Personen') %Beschriftung y-Achse
xlabel(['Zeit in ' num2str(dt) ' ' t_unit])  %
clear all;
close all;
% VARIABLEN -------------------------------------------------------------------

% Infektionskontaktrate, jede Spalte definiert individuelle Infektionsrate in einem
% Kompartiment
beta = [0.3219,0.4,0.1,0.256,0.177];

% Genesungsrate, jede Spalte definiert individuelle Genesungsnsrate in einem
% Kompartiment
gamma = [0.1,0.11,0.05,0.05,0.1];

% Austauschmatrix benötigt Dimensionen abhängig von der Anzahl der Kompartimente 
% quadratische Matrix
Dimension=5; 

A=[0.9 , 0.02 , 0.01 , 0.05 , 0.02;
   0.03, 0.91 , 0.02 , 0.02 , 0.02;
   0.02, 0.04 , 0.88 , 0.03 , 0.03;
   0.05, 0.02 , 0.01 , 0.89 , 0.03;
   0   , 0.01 , 0.08 , 0.01,  0.9  ];

% Tage
N_t = 400 ; 
 
% X-Achseneinteilung
t = linspace(0, N_t, N_t+1);

% Vektoren erstellen bzw. jede Spalte definiert S, I und R eines Kompartimentes
S = zeros(N_t+1, Dimension);
I = zeros(N_t+1, Dimension);
R = zeros(N_t+1, Dimension);

% Populationen im jeweiligen Kompartiment zum Zeitpunkt 0
n_0=[100000,10000,10000,20000,50000];

% Anfangszustand durch Vektoreneintrag beschreiben in jedem Kompartiment
S(1,1) = 1;
S(1,2) = 1;
S(1,3) = 1;
S(1,4) = 1;
S(1,5) = 1;

I(1,1) = 1.93E-07;
I(1,2) = 1.93E-07;
I(1,3) = 1.93E-07;
I(1,4) = 1.93E-07;
I(1,5) = 1.93E-07;


R(1,1) = 0;
R(1,2) = 0;
R(1,3) = 0;
R(1,4) = 0;
R(1,5) = 0;


% BERECHNUNGEN ----------------------------------------------------------------  
% Zeitschritte pro Tag
for n = 1:N_t
  % zunaechst Berechnung jedes einzelnen Kompartimentes
  for i=1:Dimension
   S(n+1,i) = S(n,i) - beta(1,i)*S(n,i)*I(n,i); 
   I(n+1,i) = I(n,i) + beta(1,i)*S(n,i)*I(n,i) - gamma(1,i)*I(n,i);
   R(n+1,i) = R(n,i) + gamma(1,i)*I(n,i);
   
   Sneu=round(S*n_0(1,i));
   Ineu=round(I*n_0(1,i));
   Rneu=round(R*n_0(1,i));
 
  endfor
   
   % Austausch zwischen den Kompartimenten auf Basis der Austauschmatrix
   Sneu1(n+1,1:5)=Sneu(n+1,1:5)*A;
   Ineu1(n+1,1:5)=Ineu(n+1,1:5)*A;
   Rneu1(n+1,1:5)=Rneu(n+1,1:5)*A;

endfor

% PLOTTEN ---------------------------------------------------------------------
% Wird benötigt um die einzelnen Kompartimente plotten zu koennen
for m=1:Dimension
figure (m)

% Plotten 
plot(t, Sneu1(:,m), t, Ineu1(:,m), t, Rneu1(:,m));
hold on

% Achseneinteilung
axis([0 N_t 0 n_0(1,i)])

% Legende
legend('S', 'I', 'R');

% X-Achsenbeschriftung
xlabel('Tage');

test=["Fig_", num2str(m),".jpg"]
saveas(m, test)
hold off
endfor
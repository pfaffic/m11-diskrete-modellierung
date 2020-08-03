
close all;
clear;
size=7;
mp=floor(size/2)+1;
p=10;
G=zeros(size,size);
G(mp,mp)=p;


T=4;
for t=1:T
  
  G_neu = bewegung(G);
  if (G_neu < 0)
    error("bewegung: error while calculating")
  endif
  figure(t)
  surface(G);
  title(["Tag: " num2str(t)])
  xlabel("x-Achse")
  ylabel("y-Achse")
  zlabel("Anzahl Personen")
  %axis([1 size 1 size 0 p])
  colormap('jet');
  colorbar
  G=G_neu;
endfor
  sum(sum(G_neu))
  max(max(G_neu))
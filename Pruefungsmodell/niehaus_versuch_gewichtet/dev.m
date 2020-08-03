
close all;
clear;
size=24;
mp=floor(size/2);
p=10;
G=zeros(size,size);
%G(mp,mp)=p;
G(3,3)=2*p;
%G(size-3,3)=2*p;
%G(mp,size-3)=2*p;


T=4;
for t=1:T
  
  G_neu = bewegung(G);
  if (G_neu < 0)
    error("bewegung: error while calculating")
  endif
  figure(t)
  surface(G);
  title(["Tag: " num2str(t-1)])
  xlabel("x-Achse")
  ylabel("y-Achse")
  zlabel("Anzahl Personen")
  %axis([1 size 1 size 0 p])
  %colormap('jet');
  colorbar
  saveas((t),["GLP_Bewegung_Tag_" num2str(t-1) ".jpg"])
  G=G_neu;
endfor
  sum(sum(G_neu))
  max(max(G_neu))
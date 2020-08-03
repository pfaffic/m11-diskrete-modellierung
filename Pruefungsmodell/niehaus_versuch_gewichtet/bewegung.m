
function erg = bewegung(G)
  erg=-1; %-1 als Fehlerwert
  if (nargin != 1)
    error("bewegung (matrix)");
  endif
  if (ismatrix(G))
  X=columns(G);
  Y=rows(G);
  [x,y]=meshgrid(1:X,1:Y);
  for j=1:Y
    for i=1:X
      abstand((i-1)*Y+1:i*Y,(j-1)*X+1:j*X)=getDistance(G,j,i);
        if (abstand((i-1)*Y+1:i*Y,(j-1)*X+1:j*X) < 0)
          error("getDistance: error while calculating")
        endif
    endfor
  endfor

  erg=reshape(abstand*reshape(G',Y*X,1),Y,X)/X;
  else
    error ("bewegung: expecting matrix argument"); 
  endif

endfunction
#!/usr/bin/env octave

#{
12. Escreva o código em Octave da regra Simpson Composta para integrais duplas
de forma a aproximar a integral S|0.2, 0.6| S|x^3, x^2| e^(y/x) n=m=10. Compare
o resultado com o valor exato, isto é, apresente o erro absoluto.
#}

#{
Entrada:
N/A

Saída:
Calculando área usando integração pela Regra de Simpson Composta para Integrais Duplas:
S|0.2, 0.6| S|x^3, x^2| e^(y/x) = 0.052015

Resultado Exato = 103/1980 ou 0.052020202...
Erro absoluto = 0.000005
#}
1;

function [Ex12] = main(argv)
a = 0.2;
b = 0.6;
n = 10;
m = 10;
h = (b-a)/n;
Jfinal = 0;
Jpar = 0;
Jimbar = 0;
i = 0;
while(i<=n)
  x = a+i*h;
  HX = (dx(x)-cx(x))/m;
  Kfinal = f(x,cx(x)) + f(x,dx(x));
  Kpar = 0;
  Kimbar = 0;
  j = 1;
  while(j<=m-1)
    y = cx(x)+j*HX;
    Q = f(x,y);
    if(mod(j,2)==0)
      Kpar = Kpar + Q;
    else
      Kimbar = Kimbar + Q;
    endif
    j++;
  endwhile
  L = (HX/3)*(Kfinal + 2*Kpar + 4*Kimbar);
  if(i==0||i==n)
    Jfinal = Jfinal + L;
  elseif(mod(i,2)==0)
    Jpar = Jpar + L;
  else
    Jimbar = Jimbar + L;
  endif
  i++;
endwhile
s = (h/3)*(Jfinal + 2*Jpar + 4*Jimbar);
printf("Calculando área usando integração pela Regra de Simpson Composta para Integrais Duplas: \n");
printf("S|0.2, 0.6| S|x^3, x^2| e^(y/x) = %f\n\n",s);
printf("Resultado Exato = 103/1980 ou 0.052020202...\n")
printf("Erro absoluto = %f\n",abs(s-(103/1980)));
endfunction

function z = f(x,y)
z = e^(y/x);
endfunction

function c = cx(x)
c = x^3;
endfunction


function d = dx(x)
d = x^2;
endfunction

main(argv);

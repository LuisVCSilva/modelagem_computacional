#!/usr/bin/env octave

#{
13b. Use o código da questão 12 para aproximar as seguintes integrais considerando n=6 e m=10,
além de apresentar o erro absoluto ao comparar com o valor exato.

a)S|0.1, pi/4| S|sin(x), cos(x)|(2ysin(x) + cos(x)^2) dy dx

b)S|0.1, pi/4| S|0, sin(x)|(1/(sqrt(1-y^2))) dy dx
#}

#{
Entrada:
N/A

Saída:
B) S|0.1, pi/4| S|0, sin(x)|(1/(sqrt(1-y^2))) dy dx

Calculando área usando integração pela Regra de Simpson Composta para Integrais Duplas:
Área = 0.303426

Resultado Exato = ((pi^2)/32)-0.005 ou 0,303425138...
Erro absoluto = 0.000001
#}
1;

function [Ex13b] = main(argv)
a = 0.1;
b = pi/4;
n = 6;
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
printf("B) S|0.1, pi/4| S|0, sin(x)|(1/(sqrt(1-y^2))) dy dx\n\n");
printf("Calculando área usando integração pela Regra de Simpson Composta para Integrais Duplas: \n");
printf("Área = %f\n\n",s);
printf("Resultado Exato = ((pi^2)/32)-0.005 ou 0,303425138...\n")
printf("Erro absoluto = %f\n",abs(0.303425138-s));
endfunction

function z = f(x,y)
z = 1/(sqrt(1-y^2));
endfunction

function c = cx(x)
c = 0;
endfunction


function d = dx(x)
d = sin(x);
endfunction

main(argv);

#!/usr/bin/env octave

#{
9. Use a fórmula de três pontos para determinar as derivadas de primeira e segunda ordem em 2.9,
3.0, 3.1 e 3.2, sabendo que f(x) = xcos(x) − x^2 sin(x). Estime o erro absoluto a partir da
aproximação feita para cada caso.
#}

#{

Coisas interessantes:
xcos(x) − x^2 sin(x) dx = x^2*(-cos(x))-3*x*sin(x)+cos(x)
xcos(x) − x^2 sin(x) dx dx = (x^2-4)*sin(x)-5*x*cos(x)
#}
1;

function [Ex9] = main(argv)
  printf("Para h=10^-5, temos: \n\n");
  exercicio(2.9);
  printf("\n-------------------------------\n");
  exercicio(3.0);
  printf("\n-------------------------------\n");
  exercicio(3.1);
  printf("\n-------------------------------\n");
  exercicio(3.2);
  printf("\n-------------------------------\n");

endfunction



function z = f(x)
  z = x*cos(x)-(x^2)*sin(x);
endfunction

function r = primeiraDerivDifCent3Pontos (x,h)
  r = (1/(2*h))*(f(x+h)-f(x-h));
endfunction


function r = segDerivDifCent3Pontos (x,h)
  r = (f(x+h)-2*f(x)+f(x-h))/(h*h);
endfunction

function r = primeiraDerivadaExata (x)
  r  = x^2*(-cos(x))-3*x*sin(x)+cos(x);
endfunction

function r = segundaDerivadaExata (x)
  r  = (x^2-4)*sin(x)-5*x*cos(x);
endfunction

function exercicio (val)
  printf("Para x=%f:\n\n",val);
  printf("Primeira ordem: \n===============================================\n");
  dxaprox = primeiraDerivDifCent3Pontos(val,10^-5);
  dxexato = primeiraDerivadaExata(val);
  printf("Derivada aproximada: \n");
  printf("x*cos(x)-(x^2)*sin(x) dx p/ x=%f = %f\n",val,dxaprox);
  printf("\n\n");
  printf("Derivada exata: \n");
  printf("x*cos(x)-(x^2)*sin(x) dx p/ x=%f = %f\n\n",val,dxexato);
  printf("O erro absoluto entre a derivada exata e a aproximada é: %f",abs(dxaprox-dxexato));
  printf("\n===============================================\n\n");

  printf("Segunda ordem: \n===============================================\n");
  dxaprox = segDerivDifCent3Pontos(val,10^-5);
  dxexato = segundaDerivadaExata(val);
  printf("Derivada aproximada: \n");
  printf("x*cos(x)-(x^2)*sin(x) dx p/ x=%f = %f\n",val,dxaprox);
  printf("\n\n");
  printf("Derivada exata: \n");
  printf("x*cos(x)-(x^2)*sin(x) dx p/ x=%f = %f\n\n",val,dxexato);
  printf("O erro absoluto entre a derivada exata e a aproximada é: %f",abs(dxaprox-dxexato));

endfunction

main(argv);

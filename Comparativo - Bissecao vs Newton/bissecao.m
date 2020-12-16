#!/usr/bin/env octave

#{
Metodo da Bissecao
#}

#{
Casos de Teste:
#}
1;

function [Ex1] = main(argv)
a = str2num(argv{1});
b = str2num(argv{2});
tolerancia = str2num(argv{3});
N = str2num(argv{4});

printf("\n-------------------------\n");
printf("\nRealizando o metodo da bissecao para a=%f, b=%f, tol=%f,N=%d\n",a,b,tolerancia,N);

i = 1;
FA = f(a);

while(i<=N)
   p = (b+a)/2;
   FP = f(p);
   if((FP == 0) || ((b-a)/2<tolerancia))
    printf("O método convergiu em %d iterações.\n",i);
    printf("Raiz é = %f\n",p);
    exit();
   endif
   i = i+1;
   if(FA*FP>0)
     a = p;
     FA = FP;
   else
     b = p;
   endif
endwhile
printf("O método não convergiu em %d iterações\n",N);

endfunction


function z = f(x)
  z = x^3+4*x^2-10;
endfunction

main(argv);

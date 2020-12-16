#!/usr/bin/env octave

function [ex9] = main(argv)
 F = inline('(-z)^2-y+log(x)') %funcao original
 fl = inline('-1') %derivada de y
 fll = inline('2*z') %derivada de z
 
 limInf = 1;
 limSup = 2;
 
 _alfa = 0;
 _beta = log(2);
  
 TK = (_beta-_alfa)/(limSup-limInf);

 subIntervalos = 2;%ou 4 para h=0.25 e 2 para h=0.5
 _flag = 0;
 
 TOL = 10^-5; 
 max_it = 99999;
 


 printf("  I\tX(I)\t     W1(I)\t   W2(I)\n");

 W1 = zeros(1,subIntervalos+1);
 W2 = zeros(1,subIntervalos+1);
 H = (limSup-limInf)/subIntervalos;
 K = 1;

 _flag = 0;

 while K <= max_it & _flag == 0 
 W1(1) = _alfa;
 W2(1) = TK;
 U1 = 0 ;
 U2 = 1;

 for I = 1 : subIntervalos 
 X = limInf+(I-1)*H;
 T = X+0.5*H;
 K11 = H*W2(I);
 K12 = H*F(X,W1(I),W2(I));
 K21 = H*(W2(I)+0.5*K12);
 K22 = H*F(T,W1(I)+0.5*K11,W2(I)+0.5*K12);
 K31 = H*(W2(I)+0.5*K22);
 K32 = H*F(T,W1(I)+0.5*K21,W2(I)+0.5*K22);
 K41 = H*(W2(I)+K32);
 K42 = H*F(X+H,W1(I)+K31,W2(I)+K32);
 W1(I+1) = W1(I)+(K11+2*(K21+K31)+K41)/6;
 W2(I+1) = W2(I)+(K12+2*(K22+K32)+K42)/6;
 K11 = H*U2;
 K12 = H*(fl(X,W1(I),W2(I))*U1+fll(X,W1(I),W2(I))*U2);
 K21 = H*(U2+0.5*K12);
 K22 = H*(fl(T,W1(I),W2(I))*(U1+0.5*K11)+fll(T,W1(I),W2(I))*(U2+0.5*K21));
 K31 = H*(U2+0.5*K22);
 K32 = H*(fl(T,W1(I),W2(I))*(U1+0.5*K21)+fll(T,W1(I),W2(I))*(U2+0.5*K22));
 K41 = H*(U2+K32);
 K42 = H*(fl(X+H,W1(I),W2(I))*(U1+K31)+fll(X+H,W1(I),W2(I))*(U2+K32));
 U1 = U1+(K11+2*(K21+K31)+K41)/6;
 U2 = U2+(K12+2*(K22+K32)+K42)/6;
 endfor
 if abs(W1(subIntervalos+1)-_beta) < TOL
 I = 0;
 printf('%3d %13.8f %13.8f %13.8f\n', I, limInf, _alfa, TK);
 for I = 1 : subIntervalos 
 J = I+1;
 X = limInf+I*H;
 printf('%3d %13.8f %13.8f %13.8f\n', I, X, W1(J), W2(J));
 endfor
 printf('Convergiu em %d iterações\n', K);
 printf('t = %f\n', TK);
 _flag = 1;
 else
 TK = TK-(W1(subIntervalos+1)-_beta)/U1;
 K = K+1;
 endif
 endwhile

 if _flag == 0 
  printf('Metodo falhou apos %d iteracoes\n', max_it);
 endif 
endfunction

main(argv);
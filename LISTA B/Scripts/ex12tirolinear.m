#!/usr/bin/env octave

function [ex12tirolinear] = main(argv)
 printf('Metodo do tiro linear\n');

 P = inline('x^(-1)','x');
 Q = inline('3*x^(-2)','x');
 R = inline('x^(-1)*log(x)-1','x');
 
 % 1<=X<=2, Y(1) = Y(2) = 0
 %limites limiteInferior e limiteSuperior do problema
 limiteInferior = 1.0;
 limiteSuperior = 2.0;
 
 % Y(limiteInferior) e Y(limiteSuperior) dos limites
 _alpha = 0.0;
 _beta = 0.0;

 qtdeSubintervalos = 10;%para h=0.1

 [X,W1,W2] = metodoTiroLinear(P,Q,R,limiteInferior,limiteSuperior,_alpha,_beta,qtdeSubintervalos);
 printf("  I\t X(I)\t\t W(1,I)\t\t W(2,I)\n");
 for I = 1 : qtdeSubintervalos 
  printf('%3d\t%11.8f\t%11.8f\t%11.8f\n', I, X(I+1), W1(I+1), W2(I+1));
 endfor 
endfunction

function [X,W1,W2] = metodoTiroLinear (P,Q,R,limiteInferior,limiteSuperior,_alpha,_beta,qtdeSubintervalos) 
 H = (limiteSuperior-limiteInferior)/qtdeSubintervalos;
 U1 = _alpha;
 U2 = 0;
 V1 = 0;
 V2 = 1;
 U = zeros(2,qtdeSubintervalos);
 V = zeros(2,qtdeSubintervalos);

 %printf('  I\t X(I)\t\t W(1,I)\t\t W(2,I)\n');
 for I = 1 : qtdeSubintervalos 
    X = limiteInferior+(I-1)*H;
    T = X+0.5*H;
    K11 = H*U2;
    K12 = H*(P(X)*U2+Q(X)*U1+R(X));
    K21 = H*(U2+0.5*K12);
    K22 = H*(P(T)*(U2+0.5*K12)+Q(T)*(U1+0.5*K11)+R(T));
    K31 = H*(U2+0.5*K22);
    K32 = H*(P(T)*(U2+0.5*K22)+Q(T)*(U1+0.5*K21)+R(T));
    T = X+H;
    K41 = H*(U2+K32);
    K42 = H*(P(T)*(U2+K32)+Q(T)*(U1+K31)+R(T));
    U1 = U1+(K11+2*(K21+K31)+K41)/6;
    U2 = U2+(K12+2*(K22+K32)+K42)/6;
    K11 = H*V2;
    K12 = H*(P(X)*V2+Q(X)*V1);
    T = X+0.5*H;
    K21 = H*(V2+0.5*K12);
    K22 = H*(P(T)*(V2+0.5*K12)+Q(T)*(V1+0.5*K11));
    K31 = H*(V2+0.5*K22);
    K32 = H*(P(T)*(V2+0.5*K22)+Q(T)*(V1+0.5*K21));
    T = X+H;
    K41 = H*(V2+K32);
    K42 = H*(P(T)*(V2+K32)+Q(T)*(V1+K31));
    V1 = V1+(K11+2*(K21+K31)+K41)/6;
    V2 = V2+(K12+2*(K22+K32)+K42)/6;
    U(1,I) = U1;
    U(2,I) = U2;
    V(1,I) = V1;
    V(2,I) = V2;
 endfor
 I = 1;
 W1(I) = _alpha;
 W2(I) = (_beta-U(1,qtdeSubintervalos))/V(1,qtdeSubintervalos);
 X(I) = limiteInferior;
 
 %printf('%3d\t%11.8f\t%11.8f\t%11.8f\n', I, X(I), W1(I), W2(I));
 for I = 1 : qtdeSubintervalos 
    X(I+1) = limiteInferior+I*H;
    W1(I+1) = U(1,I)+W2(1)*V(1,I);
    W2(I+1) = U(2,I)+W2(1)*V(2,I);
    %printf('%3d\t%11.8f\t%11.8f\t%11.8f\n', I, X(I+1), W1(I+1), W2(I+1));
 endfor
endfunction

main(argv);
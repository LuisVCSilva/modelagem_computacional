#!/usr/bin/env octave

#{
5) Determine os valores de α para que a matriz A seja singular.
#}

#{

#}
1;
%warning('off','all');

function [ex8] = main(argv)
A = [4, 1, -1, 0; 1, 3, -1, 0; -1, -1, 5, 2; 0, 0, 2, 4];
n = size(A);
S = A;

for i=1:n,
  for j=i+1:n,
    S(j,j:n) = S(j,j:n) - S(i,j:n)*S(i,j)/S(i,i);
  end
  S(i,i:n) = S(i,i:n)/sqrt(S(i,i));
end

S = triu(S)';
disp(S);
endfunction

main(argv);
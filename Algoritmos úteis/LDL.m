#!/usr/bin/env octave

function [LDL] = main(argv)
A = [2, -1, 0;-1, 3, -1;0, -1,4]
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
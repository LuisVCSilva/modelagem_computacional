#script bash que compara o metodo da bissecao ao metodo de newton para tolerancias de 10^-5
#Sintaxe: nomeMetodo.m [a b] ou p0=a, TOL, qtdeIteracoes
./bissecao.m 1 2 10^-5 10
./bissecao.m 1 2 10^-5 100
./bissecao.m 1 2 10^-5 1000

./newton.m 1 10^-5 10
./newton.m 1 10^-5 100
./newton.m 1 10^-5 1000
###---
./bissecao.m 1 2 10^-10 10
./bissecao.m 1 2 10^-10 100
./bissecao.m 1 2 10^-10 1000

./newton.m 1 10^-10 10
./newton.m 1 10^-10 100
./newton.m 1 10^-10 1000
###---
./bissecao.m 1 2 10^-15 10
./bissecao.m 1 2 10^-15 100
./bissecao.m 1 2 10^-15 1000

./newton.m 1 10^-15 10
./newton.m 1 10^-15 100
./newton.m 1 10^-15 1000
###---
./bissecao.m 1 2 10^-20 10
./bissecao.m 1 2 10^-20 100
./bissecao.m 1 2 10^-20 1000

./newton.m 1 10^-20 10
./newton.m 1 10^-20 100
./newton.m 1 10^-20 1000
###---
./bissecao.m 1 2 10^-50 10
./bissecao.m 1 2 10^-50 100
./bissecao.m 1 2 10^-50 1000

./newton.m 1 10^-50 10
./newton.m 1 10^-50 100
./newton.m 1 10^-50 1000

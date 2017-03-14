sexe(jean, ma).
sexe(marie, fe).
sexe(paul, ma).
sexe(antoine, ma).
sexe(claudia, fe).
sexe(fernando, ma).

aime(jean, marie).
aime(paul, antoine).
aime(antoine, claudia).
aime(fernando, claudia).

aime(claudia, X) :- aime(X, claudia).

amant(X, Y) :- sexe(X, SX), sexe(Y, SY), SX \= SY, aime(X,Y), aime(Y,X).
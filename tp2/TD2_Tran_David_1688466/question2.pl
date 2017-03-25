/*librairie pour utiliser ins/2*/
:- use_module(library(clpfd)).

/*signature : valid_seq(ListeDeContraintes, Sequence, NouveauGroupe)*/

/*Plus rien a verifier dans cette sequence*/
valid_seq([0|Constraints], [0|Seq], _) :- 
    valid_seq(Constraints, Seq, 0).

/*A la fin de la sequence, on ne devrait plus avoir de contrainte*/
valid_seq([0|Constraints], [], _) :- 
    Constraints = [].

/*Fin de la verification de la sequence avec succes!*/
valid_seq([], [], _).

/*On n'a pas commence de nouveau groupe, avancer dans la sequence jusqu'a ce qu'on trouve un groupe ou la fin*/
valid_seq(Constraints, [0|Seq], 0) :-
    valid_seq(Constraints, Seq, 0).

/*On compte les 1 dans ce groupe en decrementant la contrainte tant que la contrainte n'est pas nulle*/
valid_seq([Constraint|Constraints], [1|Seq], _) :- 
    Constraint > 0, NewConstraint is Constraint-1,
    valid_seq([NewConstraint|Constraints], Seq, 1).

/*signature : valid_lines(ListeDesListesDeContraintesDeLignes, Lignes, NombreDeLignes)*/
/*On a verifie toutes les lignes!*/
valid_lines([], [], _).

/*Verifier qu'il y a le bon nombre de lignes, verifier que c'est des 0 et des 1 et puis verifier tous les lignes recursivement*/
valid_lines([LineSpec|LinesSpecs], [Line|Lines], NbLines) :- 
    length(Line, NbLines), Line ins 0..1, valid_seq(LineSpec, Line, 0),
    valid_lines(LinesSpecs, Lines, NbLines).

/*signature : extract(IndexK, Lignes, Colonne)*/
/*Fin de l'extraction d'une colonne*/
extract(_, [], []).

/*Prendre la k-ieme element et l'ajouter a la colonne en construction*/
extract(K, [Line|Lines], [E|Column]) :- 
    nth1(K, Line, E), extract(K, Lines, Column).

/*signature : valid_columns(ListeDesListesDeContraintesDeColonnes, Matrice, NombreDeColonnes)*/
/*Verifier qu'on a le bon nombre de colonnes et puis valider chaque colonne en comptant du haut vers 0*/
valid_columns(ColSpecs, Matrix, NbCols) :- 
    length(Matrix, NbCols), valid_column(ColSpecs, Matrix, NbCols, NbCols).

/*signature : valid_column(ListeDesListesDeContraintesDeColonnes, Matrice, NombreDeColonnesRestants, NombreDeColonnes)*/
/*On a verifie toutes les colonnes, il en reste 0*/
valid_column(_, _, 0, _).

/*Extraire la k-ieme colonne, prendre le nombre de colonnes, prendre le k-ieme liste de contraintes et puis valider*/
valid_column(ColSpecs, Matrix, K, NbCols) :- 
    extract(K, Matrix, Column), length(Column, NbCols), nth1(K, ColSpecs, ColSpec), valid_seq(ColSpec, Column, 0), NewK is K-1, 
    valid_column(ColSpecs, Matrix, NewK, NbCols).

/*Appel pour la resolution*/
logicPrb(ColumnSpecs, LineSpecs, X):- 
    length(LineSpecs, NbCols),
    length(ColumnSpecs, NbLines), 
    valid_lines(LineSpecs, X, NbLines), 
    valid_columns(ColumnSpecs, X, NbCols), 
    print_nonogram(X).

/*Print fourni par l'enonce*/
print_nonogram(N) :-
    nl,write('Found nonogram:'),nl,
    print_nonogram1(N).

print_nonogram1([]).

print_nonogram1([Line | Lines]) :-
    print_line(Line),nl,
    print_nonogram1(Lines).
    print_line([]).

print_line([Head | Tail]) :-
    Head = 1,
    write('# '),
    print_line(Tail).

print_line([Head | Tail]) :-
    Head = 0,
    write('. '),
    print_line(Tail).

/*Cas de tests*/
test(X) :- logicPrb([[1]],[[1]],X).
test0(X) :- logicPrb([[1],[1],[1]],[[1],[1,1]],X).
test1(X) :- logicPrb([[3,1], [1,1,1], [1,1,1], [1,1,1], [1,3]], [[5], [1], [5], [1], [5]], X).
test2(X) :- logicPrb([[2], [4], [3,1], [4], [2]], [[1,1,1], [5], [3], [1,1], [3]], X).

/*sourire 5x5
. # . # . 
. # . # . 
. . . . . 
# . . . # 
. # # # .
*/
/*logicPrb([[1],[2,1],[1],[2,1],[1]],[[1,1],[1,1],[0],[1,1],[3]],X)*/

/*canard 6x6
. . . # # . 
. . . # # # 
. . . # . . 
# # # # # . 
# # # # # # 
. # # # # 
*/
/*logicPrb([[2],[3],[3],[6],[2,3],[1,1]],[[2],[3],[1],[5],[6],[4]],X).*/

/*pillule 7x7
. . . # # # . 
. . # # # . # 
. # # # . # # 
# # . # # # # 
# . . . # # . 
# . . # # . . 
. # # # . . .*/
/*logicPrb([[3],[2,1],[2,1],[4,2],[2,3],[1,3],[3]],[[3],[3,1],[3,2],[2,4],[1,2],[1,2],[3]],X).*/

/*tete de serpent 8x8
. # # # # # . . 
# # # # # # # . 
# . # . # # # # 
. # # # # . # # 
. # # # . . # # 
. . # . . . # # 
. # . . . # # . 
. . . . . # # . 
*/
/*logicPrb([[2],[2,2,1],[6],[2,2],[4],[3,2],[7],[4]],[[5],[7],[1,1,4],[4,2],[3,2],[1,2],[1,2],[2]],X)*/

/*lezard 9x9
. . . . . # # . . 
. . # # # # # # . 
. # # # # # # # # 
. # # # # # . . . 
# # # # # # # . . 
# # # # . . . . . 
# . # # # . . . . 
# # . . . . # . . 
. # # # # # . . .
*/
/*logicPrb([[4],[4,2],[6,1],[6,1],[4,1,1],[5,1],[3,1,1],[2],[1]],[[2],[6],[8],[5],[7],[4],[1,3],[2,1],[5]],X).*/

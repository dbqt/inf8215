/*Include for ins/2*/
:- use_module(library(clpfd)).

/*Nothing to check in this sequence*/
valid_seq([0|Constraints], [0|Seq]) :- 
    valid_seq(Constraints, Seq).

/*If no more seq, check that there's no more constraint too*/
valid_seq([0|Constraints], []) :- 
    Constraints = [].

/*Done checking!*/
valid_seq([], []).

/*Move forward until a group is found*/
valid_seq(Constraints, [0|Seq]) :-
    valid_seq(Constraints, Seq).

/*Count 1s in this group until the group is done -> constraint must be decremented to 0 by then*/
valid_seq([Constraint|Constraints], [1|Seq]) :- 
    Constraint > 0, NewConstraint is Constraint-1,
    valid_seq([NewConstraint|Constraints], Seq).

/*No more lines*/
valid_lines([], [], _).

/*Check that there's the right nb of lines, then validate each line*/
valid_lines([LineSpec|LinesSpecs], [Line|Lines], NbLines) :- 
    length(Line, NbLines), Line ins 0..1, valid_seq(LineSpec, Line),
    valid_lines(LinesSpecs, Lines, NbLines).

/*Done getting column*/
extract(_, [], []).

/*Append k-th element from line to new column*/
extract(K, [Line|Lines], [E|Column]) :- 
    nth1(K, Line, E), extract(K, Lines, Column).

/*Start validating columns by counting downward*/
valid_columns(ColSpecs, Matrix, NbCols) :- 
    length(Matrix, NbCols), valid_column(ColSpecs, Matrix, NbCols, NbCols).

/*No more column!*/
valid_column(_, _, 0, _).

/*Extract k-th column, check that there's the right nb of elements, then validate the column*/
valid_column(ColSpecs, Matrix, K, NbCols) :- 
    extract(K, Matrix, Column), length(Column, NbCols), nth1(K, ColSpecs, ColSpec), valid_seq(ColSpec, Column), NewK is K-1, 
    valid_column(ColSpecs, Matrix, NewK, NbCols).

/*Resolution*/
logicPrb(ColumnSpecs, LineSpecs, X):- 
    length(LineSpecs, NbCols),
    length(ColumnSpecs, NbLines), 
    valid_lines(LineSpecs, X, NbLines), 
    valid_columns(ColumnSpecs, X, NbCols), 
    print_nonogram(X).

/*Print*/
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

/*Tests*/
test(X) :- logicPrb([[1]],[[1]],X).
test0(X) :- logicPrb([[1],[1],[1]],[[1],[1,1]],X).
test1(X) :- logicPrb([[3,1], [1,1,1], [1,1,1], [1,1,1], [1,3]], [[5], [1], [5], [1], [5]], X).
test2(X) :- logicPrb([[2], [4], [3,1], [4], [2]], [[1,1,1], [5], [3], [1,1], [3]], X).
/*trop lent...*/
/*test3(X) :- logicPrb([[1], [5,1], [2,7], [1,4], [2,7], [7], [2,7], [5,1], [1,1,1], [2,1]], [[1,1,1], [1,1,1], [], [7], [2,6], [2,4,1], [8], [7], [1,5,1], [8]], X).*/


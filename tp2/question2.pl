append([],L,L).
append([X|L1],L2,[X|L3]) :- append(L1,L2,L3).

/*everything is valid*/
valid_seq([], _).
/*move to next non-zero in sequence, then check if count works from there*/
valid_seq([C|CONSTRAINTS], SEQ) :-
    /*move(SEQ, LIST), */
    countdown(C, SEQ, REMAINSEQ), valid_seq(CONSTRAINTS, REMAINSEQ).

/*nothing to move*/
move([], []).
/*move if current is 0*/
move([C|SEQ], R) :-
    C is 0, move(SEQ, R).
/*stop moving and put back current in sequence*/
move([C|SEQ], R) :-
    C is 1, append([C], SEQ, R).


/*correct end if N is 0 when list is empty*/
countdown(COUNT, [], []) :- 
    COUNT is 0.
/*done counting and end of group*/
countdown(N, [CURRLIST|REMAINLIST], REMAINLIST) :-  
    N is 0, CURRLIST is 0,.
/*decrement if count > 0 and not end of group*/
countdown(N, [CURRLIST|REMAINLIST], R) :- 
    N > 0, CURRLIST is 1, NEWCOUNT is N-1, countdown(NEWCOUNT, REMAINLIST, R).

/*nothing to check*/
valid_lines(_, [], _, _).

/*check each line*/
valid_lines(K, [E|LINESPECS], NMAXLINES, MATRIX) :-
    extract_l(K, MATRIX, LINE), valid_seq(E, LINE), NK is K+1, valid_lines(NK, LINESPECS, NMAXLINES, MATRIX).

/*get kth column*/
extract_c(K, MATRIX, COLUMN) :-
    build_column(K, MATRIX, [], COLUMN).

/*get kth line*/
extract_l(K, MATRIX, LINE) :-
    nth1(K, MATRIX, LINE).
    
/* done building column*/
build_column(_,[], COLUMN, COLUMN).

/*get nth element from each line and append to column*/
build_column(K, [LINE|MATRIX], COLUMN, LASTCOLUMN) :-
    nth1(K, LINE, ELEMENT), append([ELEMENT], COLUMN, NEWCOLUMN), build_column(K, MATRIX, NEWCOLUMN, LASTCOLUMN).

/*nothing to check*/
valid_columns(_, [], _, _).

/*get column K, then valid sequence*/
valid_columns(K, [E|COLUMNSPECS], NMAXCOLUMN, MATRIX) :-
    
    extract_c(K, MATRIX, COLUMN), valid_seq(E, COLUMN), NK is K+1, valid_columns(NK, COLUMNSPECS, NMAXCOLUMN, MATRIX).

logicPrb(ColumnSpecs, LineSpecs, X):-
    list_length(LineSpecs, NMaxLines),
    list_length(ColumnSpecs, NMaxColumns), !,
    allLinesColumnsNb(NMaxLines, NMaxColumns, X),
    extract_c(1, MATRIX, COLUMN), list_limit(NMaxColumns, COLUMN),
    valid_lines(1, LineSpecs, NMaxLines, X),
    valid_columns(1, ColumnSpecs, NMaxColumns, X),
    print_nonogram(X).

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

list_length([], N) :-
    N is 0.

list_length([E|LIST], COUNT) :-
    list_length(LIST, N), COUNT is N+1.

list_limit(MAX, LIST) :-
    list_length(LIST, N), N=<MAX.

allLinesColumnsNb(MAXLINES, MAXCOLS, MATRIX) :-
    allLines(MATRIX, MAXLINES), allCols(1, MATRIX, MAXCOLS).

allLines([], _).
allLines([E|MATRIX], M) :-
    list_limit(M, E), allLines(MATRIX, M).

allCols(_, [], _).
allCols(K, MATRIX, M) :-
    extract_c(K, MATRIX, C), list_limit(M, C), NK is K+1, allCols(NK, MATRIX, M).


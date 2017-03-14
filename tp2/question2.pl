append([],L,L).
append([X|L1],L2,[X|L3]) :- append(L1,L2,L3).

/*everything is valid*/
valid_seq([], []).
/*move to next non-zero in sequence, then check if count works from there*/
valid_seq([C|CONSTRAINTS], SEQ) :-
    move(SEQ, LIST), countdown(C, LIST, REMAINSEQ), valid_seq(CONSTRAINTS, REMAINSEQ).

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
    N is 0, CURRLIST is 0, print("N is 0 and C is 0").
/*decrement if count > 0 and not end of group*/
countdown(N, [CURRLIST|REMAINLIST], R) :- 
    N > 0, CURRLIST is 1, NEWCOUNT is N-1, print("N > 0 and C is 1"), countdown(NEWCOUNT, REMAINLIST, R).
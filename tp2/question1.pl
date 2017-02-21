

ask(homme, X) :-
    format('est-ce un homme?', [X]),
    read(Reponse),
    Reponse = 'oui'.

ask(athlete, X) :-
format('[~w] est-ce un athlete?', [X]),
    read(Reponse),
    Reponse = 'oui'.
    
ask(artiste, X) :-
format('est-ce un artiste?', [X]),
    read(Reponse),
    Reponse = 'oui'.
    
ask(gouverneur, X) :-
format('est-ce un gouverneur?', [X]),
    read(Reponse),
    Reponse = 'oui'.
    
ask(politicien, X) :-
format('est-ce un politicien?', [X]),
    read(Reponse),
    Reponse = 'oui'.
    
ask(historique, X) :-
format('est-ce une personne historique?', [X]),
    read(Reponse),
    Reponse = 'oui'.
    
ask(personnage, X) :-
format('est-ce un personnage fictif?', [X]),
    read(Reponse),
    Reponse = 'oui'.
    
ask(professeur, X) :-
format('est-ce un professeur?', [X]),
    read(Reponse),
    Reponse = 'oui'.

ask(gouverne,Y):-
format('Gouverne ~w ? ',[Y]),
    read(Reponse),
    Reponse = 'oui'.


/* entry point */

personne(X) :- sexe(X,ListeHommes), categorie(ListeHommes, ). 
    
long([],N).
long([_|L],[x|M]):- M is N+1,long(L,M).
    
sexe(X, ListeHommes) :-
    ask(homme,X),
    findall(X, homme(X), ListeHommes).

sexe(X, Y) :-
    femme(Y).
    
categorie(X) :-
    ask(athlete,X),
    athlete(X).
    
categorie(X) :-
    ask(artiste,X),
    artiste(X).
    
categorie(X) :-
    ask(gouverneur,X),
    gouverneur(X).
    
categorie(X) :-
    ask(politicien,X),
    politicien(X).
    
categorie(X) :-
    ask(historique,X),
    historique(X).
    
categorie(X) :-
    ask(personnage,X),
    personnage(X).
    
categorie(X) :-
    ask(professeur,X),
    professeur(X).


/**/

politicien(X) :-
    gouverne(X,Y),
    pays(Y),
    ask(gouverne,Y).


gouverne(stephen_harper,canada).

gouverne(barack_obama,usa).

pays(canada).

pays(usa).


/* genre */
femme(eugenie_bouchard).
femme(jk_rowling).
femme(cleopatre_vii).
femme(blanche_neige).
femme(lara_croft).
femme(julie_snyder).
homme(brad_pitt).
homme(rafal_nadal).
homme(jacque_villeneuve).
homme(victor_hugo).
homme(michael_jackson).
homme(stephen_harper).
homme(moise).
homme(jesus).
homme(pape_francois).
homme(wolgang_amadeus_mozart).
homme(gardfield).
homme(james_bond).
homme(mario).
homme(john_lewis).
homme(michel_gagnon).
homme(michel_dagenais).

/ metier */
artiste(brad_pitt).
artiste(jk_rowling).
artiste(victor_hugo).
artiste(michael_jackson).
artiste(wolgang_amadeus_mozart).
artiste(julie_snyder).
athlete(eugenie_bouchard).
athlete(rafal_nada).
athlete(jacque_villeneuve).
gouverneur(stephen_harper).
historique(cleopatre_vii).
historique(moise).
historique(jesus).
historique(pape_francois).
personnage(blanche_neige).
personnage(lara_croft).
personnage(mario).
personnage(garfield).
personnage(james_bond).
politicien(john_lewis).
professeur(michel_gagnon).
professeur(michel_dagenais).

/* specialite */
acteur(brad_pitt).
auteur(jk_rowling).
auteur(victor_hugo).
chanteur(michael_jackson).
musicien(wolgang_amadeus_mozart).
producteur(julie_snyder).
tennis(eugenie_bouchard).
soccer(rafal_nadal).
course_char(jacque_villeneuve).
egypte(cleopater_vii).
egypte(moise).
vatican(pape_francois).
conte(blanche_neige).
jeux(lara_croft).
jeux(mario).
animal(garfield).
film(james_bond).
web(michel_gagnon).
os(michel_dagenais).

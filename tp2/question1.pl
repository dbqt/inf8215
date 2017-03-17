
personnage(michael_jackson, homme, us, artiste, chanteur).
personnage(mozart, homme, europe, artiste, compositeur).
personnage(stephan_harper, homme, canada, politicien, ministre).
personnage(john_lewis, homme, us, politicien, militant).
personnage(cleopatre, femme, egypte, politicien, reine).
personnage(michel_gagnon, homme, canada, professeur, web).
personnage(michel_dagenais, homme, canada, professeur, os).
personnage(rafal_nadal, homme, europe, athlete, tennis).
personnage(jacques_villeneuve, homme, canada, athlete, f1).
personnage(eugenie_bouchard, femme, canada, athlete, tennis).
personnage(pape_francois, homme, europe, religieux, pape).
personnage(jesus, homme, asie, religieux, jesus_christ).
personnage(julie_snyder, femme, canada, artiste, tv).
personnage(brad_pitt, homme, us, artiste, acteur).
personnage(jk_rowling, femme, europe, artiste, ecrivain).
personnage(victor_hugo, homme, europe, artiste, ecrivain).
personnage(blanche_neige, femme, europe, fictif, conte).
personnage(lara_croft, femme, europe, fictif, jeux).
personnage(moise, homme, europe, religieux, prophete).
personnage(garfield, homme, us, fictif, bande-dessinee).
personnage(james_bond, homme, europe, fictif, film).
personnage(mario, homme, europe, fictif, jeux).

profession(artiste).
profession(politicien).
profession(professeur).
profession(athlete).
profession(religieux).
profession(fictif).

pays(europe).
pays(us).
pays(canada).
pays(asie).
pays(egypte).

sexe(homme).
sexe(femme).

ask(Sujet, X) :-
 format("Est-ce que la personne ~w ~w ? ~n", [Sujet, X]), 
 read(Reponse), 
 Reponse = 'oui'.


personne(X) :- 
    sexe(A), 
        ask('est de sexe', A), !, 
	pays(B), 
        ask('vient de', B), !, 
    profession(C), 
        ask('est', C) , !, 
    personnage(X, A, B, C, D), 
        ask('est plus precisement', D), !.

personne(X) :-
    write('Aucune personne ne correspond a ces criteres'), fail.
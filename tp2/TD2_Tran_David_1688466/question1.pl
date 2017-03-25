
/*Poser une question avec la "formulation" et la reponse "X" */
ask(Formulation, X) :-
 format("Est-ce que ~w ~w ? ~n", [Formulation, X]), 
 read(Reponse), 
 Reponse = 'oui'.

/**********
  PERSONNE
***********/

/*Verifie s'il y a une seule reponse, utile pour skipper les autres questions pour personnage */
/*Apres une reponse*/
countAnswerP(X, A) :-
    findall(X, personnage(X, A, _, _, _), Y),
    length(Y, Z), 
    Z =:= 1,
    personnage(X, A, _, _, _).
/*Apres deux reponses*/
countAnswerP(X, A, B) :-
    findall(X, personnage(X, A, B, _, _), Y),
    length(Y, Z), 
    Z =:= 1,
    personnage(X, A, B, _, _).
/*Apres trois reponses*/
countAnswerP(X, A, B, C) :-
    findall(X, personnage(X, A, B, C, _), Y),
    length(Y, Z), 
    Z =:= 1,
    personnage(X, A, B, C, _).
/*Pas besoin de 4, on a deja le resultat normalement*/

/*Pose des questions jusqu'a ce qu'il y a une seule reponse possible */
personne(X) :- 
    sexe(A), 
    ask('la personne est de sexe', A), !, 
    (countAnswerP(X, A);
        pays(B), 
        ask('la personne vient de', B), !, 
        (countAnswerP(X, A, B);
            profession(C), 
            ask('la personne est', C) , !, 
            (countAnswerP(X, A, B, C);
                personnage(X, A, B, C, D), 
                ask('la personne est plus precisement', D), !
            )
        )
    ).

/*Message pour dire qu'il y a rien qui fonctionne' */
personne(X) :-
    write('Aucune personne ne correspond a ces criteres'), fail.

/*Donnees pour personne*/
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

/*Toutes les professions*/
profession(artiste).
profession(politicien).
profession(professeur).
profession(athlete).
profession(religieux).
profession(fictif).

/*Tous les pays*/
pays(europe).
pays(us).
pays(canada).
pays(asie).
pays(egypte).

sexe(homme).
sexe(femme).

/********
  OBJET
*********/

/*Verifie s'il y a une seule reponse, utile pour skipper les autres questions pour objet */
/*Apres une reponse*/
countAnswerO(X, A) :-
    findall(X, chose(X, A, _, _, _), Y),
    length(Y, Z), 
    Z =:= 1,
    chose(X, A, _, _, _).
/*Apres deux reponses*/
countAnswerO(X, A, B) :-
    findall(X, chose(X, A, B, _, _), Y),
    length(Y, Z), 
    Z =:= 1,
    chose(X, A, B, _, _).
/*Apres trois reponses*/
countAnswerO(X, A, B, C) :-
    findall(X, chose(X, A, B, C, _), Y),
    length(Y, Z), 
    Z =:= 1,
    chose(X, A, B, C, _).

/*Pose des questions jusqu'a ce qu'il y a une seule reponse possible */
objet(X) :- 
    electrique(A), 
    ask('l\'objet est-il', A), !, 
    (countAnswerO(X, A);
        lieu(B), 
        ask('l\'objet se retrouve-t-il dans', B), !, 
        (countAnswerO(X, A, B);
            poids(C), 
            ask('l\'objet est-il', C) , !, 
            (countAnswerO(X, A, B, C);
                chose(X, A, B, C, D), 
                ask('l\'objet est plus precisement pour', D), !
            )
        )
    ).

/*Message pour dire qu'il y a rien qui fonctionne' */
objet(X) :-
    write('Aucun objet ne correspond a ces criteres'), fail.

/*Donnees pour objets */
chose(aspirateur, electronique, maison_en_general, lourd, menage).
chose(telephone, electronique, bureau, leger, communication).
chose(cuisiniere, electronique, cuisine, lourd, cuisson_lente).
chose(grillepain, electronique, cuisine, leger, pain).
chose(lampe, electronique, maison_en_general, leger, lumiere).
chose(ordinateur, electronique, bureau, lourd, calcul).
chose(microonde, electronique, cuisine, lourd, cuisson_rapide).
chose(cafetiere, electronique, cuisine, leger, cafe).
chose(balai, pas_electronique, maison_en_general, leger, menage).
chose(assiete, pas_electronique, cuisine, leger, tenir_nourriture).
chose(casserole, pas_electronique, cuisine, leger, cuisson).
chose(detergent, pas_electronique, cuisine, leger, nettoyer).
chose(cle, pas_electronique, maison_en_general, leger, ouvrir_serrure).
chose(sac_a_dos, pas_electronique, bureau, leger, transporter).
chose(fourchette, pas_electronique, cuisine, leger, manipuler_nourriture).
chose(cactus, pas_electronique, maison_en_general, leger, decoration).
chose(table, pas_electronique, cuisine, lourd, multifonctionnel).
chose(shampoing, pas_electronique, maison_en_general, leger, nettoyer_cheveux).
chose(lit, pas_electronique, maison_en_general, lourd, dormir).
chose(porte_feuille, pas_electronique, bureau, leger, contenir_argent).
chose(piano, pas_electronique, maison_en_general, lourd, musique).
chose(papier, pas_electronique, bureau, leger, ecrire).

electrique(electronique).
electrique(pas_electronique).

poids(lourd).
poids(leger).

lieu(maison_en_general).
lieu(cuisine).
lieu(bureau).

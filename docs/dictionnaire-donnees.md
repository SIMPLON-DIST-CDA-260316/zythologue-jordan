| Nom                    | Description                                    | Contraintes | Type           | Règle métier                                               |
| ---------------------- | ---------------------------------------------- | ----------- | -------------- | ---------------------------------------------------------- |
| nom_user               | Nom de l'utilisateur                           | Obligatoire | Texte          | -                                                          |
| prénom_user            | Prénom de l'utilisateur                        | Obligatoire | Texte          | -                                                          |
| email_user             | Adresse email de l'utilisateur                 | Obligatoire | Texte          | Unique                                                     |
| mot_de_passe_user      | Mot de passe de l'utilisateur                  | Obligatoire | Texte          | Hashé                                                      |
| date_de_naissance_user | Date de naissance utilisateur                  | Obligatoire | Date           | Utilisée pour calculer l'âge -> 18ans minimum              |
| role_user              | Rôle de l'utilisateur                          | Obligatoire | Enumération    | Détermine les accès selon le rôle client, admin            |
| date_creation_user     | Date de création du compte de l'utilisateur    | Obligatoire | Date           | -                                                          |
| note_avis              | Note de l'avis sur brasserie/bière             | Facultatif  | Nombre entier  | Les utilisateurs peuvent laisser une note de 1 à 10        |
| commentaire_avis       | Commentaire de l'avis sur une bière/ brasserie | Facultatif  | Texte          | Les utilisateurs peuvent laisser un avis                   |
| date_avis              | Date de l'avis sur bière/brasserie             | Obligatoire | Date           | -                                                          |
| nom_bière              | Nom de la bière                                | Obligatoire | Texte          | -                                                          |
| description_bière      | Description de la bière                        | Facultatif  | Texte          | -                                                          |
| taux_alcool_bière      | Taux d'alcool de la bière                      | Obligatoire | Nombre décimal | -                                                          |
| alcoolisee_bière       | Bière avec ou sans alcool                      | Obligatoire | Booléen        | -                                                          |
| prix_bière             | Prix de la bière                               | Obligatoire | Nombre décimal | -                                                          |
| photo_bière            | Photo d'illustration de la bière               | Facultatif  | Texte (url)    | Une bière peut être illustrée par une ou plusieurs photos. |
| nom_ingrédient         | Nom d'un ingrédient de bière                   | Obligatoire | Texte          | -                                                          |
| description_ingrédient | Description d'un ingrédient de bière           | Facultatif  | Texte          | -                                                          |
| nom_catégorie          | Nom d'une catégorie de bière                   | Obligatoire | Texte          | -                                                          |
| description_catégorie  | Description d'une catégorie de bière           | Obligatoire | Texte          | -                                                          |
| nom_brasserie          | Nom d'une brasserie                            | Obligatoire | Texte          | -                                                          |
| description_brasserie  | Description d'une brasserie                    | Obligatoire | Texte          | -                                                          |
| photo_brasserie        | Photo d'une brasserie                          | Facultatif  | Texte (url)    | -                                                          |
| pays_brasserie         | Pays de la brasserie                           | Obligatoire | Texte          | -                                                          |
| ville_brasserie        | Ville de la brasserie                          | Obligatoire | Texte          | -                                                          |
| site_web_brasserie     | Site internet de la brasserie                  | Facultatif  | Texte          | -                                                          |

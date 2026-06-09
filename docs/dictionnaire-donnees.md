| Nom                          | Description                                     | Contraintes | Type           | Règle métier                                        |
| ---------------------------- | ----------------------------------------------- | ----------- | -------------- | --------------------------------------------------- |
| id_user                      | Identifiant unique de l'utilisateur             | Obligatoire | Serial         | Unique, auto-incrémenté, clé primaire               |
| nom_user                     | Nom de l'utilisateur                            | Obligatoire | Texte          | -                                                   |
| prénom_user                  | Prénom de l'utilisateur                         | Obligatoire | Texte          | -                                                   |
| email_user                   | Adresse email de l'utilisateur                  | Obligatoire | Texte          | Unique                                              |
| mot_de_passe_user            | Mot de passe de l'utilisateur                   | Obligatoire | Texte          | Hashé                                               |
| date_de_naissance_user       | Date de naissance utilisateur                   | Obligatoire | Date           | Utilisée pour calculer l'âge -> 18ans minimum       |
| role_user                    | Rôle de l'utilisateur                           | Obligatoire | Enumération    | Client, admin                                       |
| date_creation_user           | Date de création du compte de l'utilisateur     | Obligatoire | Date           | Auto-générée                                        |
| date_modification_user       | Date de modification du compte de l'utilisateur | Obligatoire | Date           | Auto-générée                                        |
| id_avis_bière                | Identifiant unique de l'avis                    | Obligatoire | Serial         | Unique, auto-incrémenté                             |
| note_avis_bière              | Note de l'avis sur bière                        | Obligatoire | Nombre entier  | Les utilisateurs peuvent laisser une note de 1 à 10 |
| commentaire_avis_bière       | Commentaire de l'avis sur une bière             | Facultatif  | Texte          | Les utilisateurs peuvent laisser un avis            |
| date_avis_bière              | Date de l'avis sur bière                        | Obligatoire | Date           | Auto-générée                                        |
| id_avis_brasserie            | Identifiant unique de l'avis                    | Obligatoire | Serial         | Unique, auto-incrémenté                             |
| note_avis_brasserie          | Note de l'avis sur brasserie                    | Obligatoire | Nombre entier  | Les utilisateurs peuvent laisser une note de 1 à 10 |
| commentaire_avis_brasserie   | Commentaire de l'avis sur une brasserie         | Facultatif  | Texte          | Les utilisateurs peuvent laisser un avis            |
| date_avis_brasserie          | Date de l'avis sur brasserie                    | Obligatoire | Date           | Auto-générée                                        |
| id_bière                     | Identifiant unique de la bière                  | Obligatoire | Serial         | Unique, auto-incrémenté, clé primaire               |
| nom_bière                    | Nom de la bière                                 | Obligatoire | Texte          | -                                                   |
| description_bière            | Description de la bière                         | Facultatif  | Texte          | -                                                   |
| taux_alcool_bière            | Taux d'alcool de la bière                       | Obligatoire | Nombre décimal | -                                                   |
| alcoolisee_bière             | Bière avec ou sans alcool                       | Obligatoire | Booléen        | -                                                   |
| prix_bière                   | Prix de la bière                                | Obligatoire | Nombre décimal | -                                                   |
| id_ingrédient                | Identifiant unique de l'ingrédient              | Obligatoire | Serial         | Unique, auto-incrémenté, clé primaire               |
| nom_ingrédient               | Nom d'un ingrédient de bière                    | Obligatoire | Texte          | -                                                   |
| description_ingrédient       | Description d'un ingrédient de bière            | Facultatif  | Texte          | -                                                   |
| id_catégorie                 | Identifiant unique de la catégorie              | Obligatoire | Serial         | Unique, auto-incrémenté, clé primaire               |
| nom_catégorie                | Nom d'une catégorie de bière                    | Obligatoire | Texte          | -                                                   |
| description_catégorie        | Description d'une catégorie de bière            | Obligatoire | Texte          | -                                                   |
| id_brasserie                 | Identifiant unique de la brasserie              | Obligatoire | Serial         | Unique, auto-incrémenté, clé primaire               |
| nom_brasserie                | Nom d'une brasserie                             | Obligatoire | Texte          | -                                                   |
| description_brasserie        | Description d'une brasserie                     | Obligatoire | Texte          | -                                                   |
| pays_brasserie               | Pays de la brasserie                            | Obligatoire | Texte          | -                                                   |
| ville_brasserie              | Ville de la brasserie                           | Obligatoire | Texte          | -                                                   |
| site_web_brasserie           | Site internet de la brasserie                   | Facultatif  | Texte          | -                                                   |
| date_ajout_favoris_bière     | Date d'ajout en favoris de la bière             | Obligatoire | Date           | Auto-générée                                        |
| date_ajout_favoris_brasserie | Date d'ajout en favoris de la brasserie         | Obligatoire | Date           | Auto-générée                                        |
| id_photo_bière               | Identifiant de la photo d'une bière             | Obligatoire | Serial         | Unique, auto-incrémentée, clé primaire              |
| lien_photo_bière             | Url de la photo d'une bière                     | Obligatoire | Texte (url)    | -                                                   |
| id_photo_brasserie           | Identifiant de la photo d'une brasserie         | Obligatoire | Serial         | Unique, auto-incrémentée, clé primaire              |
| lien_photo_brasserie         | Url de la photo d'une brasserie                 | Obligatoire | Texte (url)    | -                                                   |

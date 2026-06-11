# Dictionnaire de données

## Utilisateur (`user`)

| Nom                    | Description                             | Contrainte  | Type        | Règle métier                                  |
| ---------------------- | --------------------------------------- | ----------- | ----------- | --------------------------------------------- |
| id_user                | Identifiant unique de l'utilisateur     | Obligatoire | Serial      | Unique, auto-incrémenté, clé primaire         |
| nom_user               | Nom de l'utilisateur                    | Obligatoire | Texte       | /                                             |
| prénom_user            | Prénom de l'utilisateur                 | Obligatoire | Texte       | /                                             |
| email_user             | Adresse email de l'utilisateur          | Obligatoire | Texte       | Unique                                        |
| mot_de_passe_user      | Mot de passe de l'utilisateur           | Obligatoire | Texte       | Hashé                                         |
| date_de_naissance_user | Date de naissance de l'utilisateur      | Obligatoire | Date        | Utilisée pour calculer l'âge — 18 ans minimum |
| role_user              | Rôle de l'utilisateur                   | Obligatoire | Enumération | Valeurs autorisées : `client` ou `admin`      |
| date_creation_user     | Date de création du compte              | Obligatoire | Horodatage  | Auto-générée                                  |
| date_modification_user | Date de dernière modification du compte | Obligatoire | Horodatage  | Auto-générée                                  |

## Brasserie (`brewery`)

| Nom                   | Description                        | Contrainte  | Type        | Règle métier                          |
| --------------------- | ---------------------------------- | ----------- | ----------- | ------------------------------------- |
| id_brasserie          | Identifiant unique de la brasserie | Obligatoire | Serial      | Unique, auto-incrémenté, clé primaire |
| nom_brasserie         | Nom de la brasserie                | Obligatoire | Texte       | /                                     |
| description_brasserie | Description de la brasserie        | Obligatoire | Texte       | /                                     |
| pays_brasserie        | Pays de la brasserie               | Obligatoire | Texte       | /                                     |
| ville_brasserie       | Ville de la brasserie              | Obligatoire | Texte       | /                                     |
| site_web_brasserie    | Site internet de la brasserie      | Facultatif  | Texte (URL) | /                                     |

## Bière (`beer`)

| Nom                | Description                         | Contrainte  | Type           | Règle métier                                                           |
| ------------------ | ----------------------------------- | ----------- | -------------- | ---------------------------------------------------------------------- |
| id_bière           | Identifiant unique de la bière      | Obligatoire | Serial         | Unique, auto-incrémenté, clé primaire                                  |
| nom_bière          | Nom de la bière                     | Obligatoire | Texte          | /                                                                      |
| description_bière  | Description de la bière             | Facultatif  | Texte          | /                                                                      |
| taux_alcool_bière  | Taux d'alcool de la bière           | Obligatoire | Nombre décimal | Ne peut pas être négatif                                               |
| sans_alcool_bière  | Indique si la bière est sans alcool | Obligatoire | Booléen        | Vrai = sans alcool ; faux = contient de l'alcool. Indépendant du taux. |
| prix_bière         | Prix de la bière                    | Obligatoire | Nombre décimal | Ne peut pas être négatif                                               |
| id_brasserie_bière | Brasserie productrice de la bière   | Obligatoire | Entier         | Clé étrangère vers brasserie -> CASCADE                                |

## Catégorie (`category`)

| Nom                   | Description                        | Contrainte  | Type   | Règle métier                          |
| --------------------- | ---------------------------------- | ----------- | ------ | ------------------------------------- |
| id_catégorie          | Identifiant unique de la catégorie | Obligatoire | Serial | Unique, auto-incrémenté, clé primaire |
| nom_catégorie         | Nom de la catégorie                | Obligatoire | Texte  | /                                     |
| description_catégorie | Description de la catégorie        | Obligatoire | Texte  | /                                     |

## Ingrédient (`ingredient`)

| Nom                    | Description                        | Contrainte  | Type   | Règle métier                          |
| ---------------------- | ---------------------------------- | ----------- | ------ | ------------------------------------- |
| id_ingrédient          | Identifiant unique de l'ingrédient | Obligatoire | Serial | Unique, auto-incrémenté, clé primaire |
| nom_ingrédient         | Nom de l'ingrédient                | Obligatoire | Texte  | /                                     |
| description_ingrédient | Description de l'ingrédient        | Facultatif  | Texte  | /                                     |

## Avis bière (`beer_review`)

| Nom                       | Description                    | Contrainte  | Type       | Règle métier                              |
| ------------------------- | ------------------------------ | ----------- | ---------- | ----------------------------------------- |
| id_avis_bière             | Identifiant unique de l'avis   | Obligatoire | Serial     | Unique, auto-incrémenté, clé primaire     |
| note_avis_bière           | Note attribuée à la bière      | Obligatoire | Entier     | Valeur entre 1 et 10                      |
| commentaire_avis_bière    | Commentaire libre sur la bière | Facultatif  | Texte      | /                                         |
| date_avis_bière           | Date de l'avis                 | Obligatoire | Horodatage | Auto-générée                              |
| id_utilisateur_avis_bière | Utilisateur auteur de l'avis   | Obligatoire | Entier     | Clé étrangère vers utilisateur -> CASCADE |
| id_bière_avis_bière       | Bière concernée par l'avis     | Obligatoire | Entier     | Clé étrangère vers bière -> CASCADE       |

> Contrainte d'unicité : un utilisateur ne peut laisser qu'un seul avis par bière (`UNIQUE(user_id, beer_id)`).

## Avis brasserie (`brewery_review`)

| Nom                           | Description                        | Contrainte  | Type       | Règle métier                              |
| ----------------------------- | ---------------------------------- | ----------- | ---------- | ----------------------------------------- |
| id_avis_brasserie             | Identifiant unique de l'avis       | Obligatoire | Serial     | Unique, auto-incrémenté, clé primaire     |
| note_avis_brasserie           | Note attribuée à la brasserie      | Obligatoire | Entier     | Valeur entre 1 et 10                      |
| commentaire_avis_brasserie    | Commentaire libre sur la brasserie | Facultatif  | Texte      | /                                         |
| date_avis_brasserie           | Date de l'avis                     | Obligatoire | Horodatage | Auto-générée                              |
| id_utilisateur_avis_brasserie | Utilisateur auteur de l'avis       | Obligatoire | Entier     | Clé étrangère vers utilisateur -> CASCADE |
| id_brasserie_avis_brasserie   | Brasserie concernée par l'avis     | Obligatoire | Entier     | Clé étrangère vers brasserie -> CASCADE   |

> Contrainte d'unicité : un utilisateur ne peut laisser qu'un seul avis par brasserie (`UNIQUE(user_id, brewery_id)`).

## Photos bière (`beer_photo`)

| Nom              | Description                    | Contrainte  | Type        | Règle métier                          |
| ---------------- | ------------------------------ | ----------- | ----------- | ------------------------------------- |
| id_photo_bière   | Identifiant unique de la photo | Obligatoire | Serial      | Unique, auto-incrémenté, clé primaire |
| lien_photo_bière | URL de la photo                | Obligatoire | Texte (URL) | /                                     |
| id_bière_photo   | Bière illustrée par la photo   | Obligatoire | Entier      | Clé étrangère vers bière -> CASCADE   |

## Photos brasserie (`brewery_photo`)

| Nom                  | Description                      | Contrainte  | Type        | Règle métier                            |
| -------------------- | -------------------------------- | ----------- | ----------- | --------------------------------------- |
| id_photo_brasserie   | Identifiant unique de la photo   | Obligatoire | Serial      | Unique, auto-incrémenté, clé primaire   |
| lien_photo_brasserie | URL de la photo                  | Obligatoire | Texte (URL) | /                                       |
| id_brasserie_photo   | Brasserie illustrée par la photo | Obligatoire | Entier      | Clé étrangère vers brasserie -> CASCADE |

## Favoris bières (`beer_favorite`)

> Pas de colonne `id` dédiée : la clé primaire est composite `(user_id, beer_id)`.

| Nom                         | Description                                 | Contrainte  | Type       | Règle métier                                 |
| --------------------------- | ------------------------------------------- | ----------- | ---------- | -------------------------------------------- |
| id_utilisateur_favori_bière | Utilisateur ayant ajouté la bière en favori | Obligatoire | Entier     | FK vers utilisateur -> CASCADE, PK composite |
| id_bière_favori             | Bière ajoutée en favori                     | Obligatoire | Entier     | FK vers bière -> CASCADE, PK composite       |
| date_ajout_favoris_bière    | Date d'ajout en favoris                     | Obligatoire | Horodatage | Auto-générée                                 |

## Favoris brasseries (`brewery_favorite`)

> Pas de colonne `id` dédiée : la clé primaire est composite `(user_id, brewery_id)`.

| Nom                             | Description                                     | Contrainte  | Type       | Règle métier                                 |
| ------------------------------- | ----------------------------------------------- | ----------- | ---------- | -------------------------------------------- |
| id_utilisateur_favori_brasserie | Utilisateur ayant ajouté la brasserie en favori | Obligatoire | Entier     | FK vers utilisateur -> CASCADE, PK composite |
| id_brasserie_favori             | Brasserie ajoutée en favori                     | Obligatoire | Entier     | FK vers brasserie -> CASCADE, PK composite   |
| date_ajout_favoris_brasserie    | Date d'ajout en favoris                         | Obligatoire | Horodatage | Auto-générée                                 |

## Liaison bière ↔ catégorie (`beer_category`)

> Table de liaison : clé primaire composite `(beer_id, category_id)`.

| Nom                | Description                   | Contrainte  | Type   | Règle métier                               |
| ------------------ | ----------------------------- | ----------- | ------ | ------------------------------------------ |
| id_bière_categorie | Bière associée à la catégorie | Obligatoire | Entier | FK vers bière -> CASCADE, PK composite     |
| id_categorie_biere | Catégorie associée à la bière | Obligatoire | Entier | FK vers catégorie -> CASCADE, PK composite |

## Liaison bière ↔ ingrédient (`beer_ingredient`)

> Table de liaison : clé primaire composite `(beer_id, ingredient_id)`.

| Nom                 | Description                   | Contrainte  | Type   | Règle métier                                |
| ------------------- | ----------------------------- | ----------- | ------ | ------------------------------------------- |
| id_bière_ingredient | Bière associée à l'ingrédient | Obligatoire | Entier | FK vers bière -> CASCADE, PK composite      |
| id_ingredient_biere | Ingrédient de la bière        | Obligatoire | Entier | FK vers ingrédient -> CASCADE, PK composite |

## Journal des insertions (`beer_log`)

| Nom                    | Description                                | Contrainte  | Type                     | Règle métier                          |
| ---------------------- | ------------------------------------------ | ----------- | ------------------------ | ------------------------------------- |
| id_journal_bière       | Identifiant unique de l'entrée             | Obligatoire | Serial                   | Unique, auto-incrémenté, clé primaire |
| id_bière_journal       | Bière concernée par l'entrée               | Obligatoire | Entier                   | Clé étrangère vers bière -> CASCADE   |
| nom_bière_journal      | Nom de la bière au moment de l'insertion   | Obligatoire | Texte                    | Snapshot dénormalisé                  |
| action_journal         | Type d'opération enregistrée               | Obligatoire | Texte                    | Valeur fixe : `INSERT`                |
| date_journal           | Horodatage de l'insertion                  | Obligatoire | Date avec fuseau horaire | Auto-générée                          |
| utilisateur_db_journal | Rôle PostgreSQL ayant effectué l'insertion | Obligatoire | Texte                    | Auto-généré via `current_user`        |

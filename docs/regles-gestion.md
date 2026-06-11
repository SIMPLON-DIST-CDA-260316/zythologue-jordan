# Règles de gestion

## Utilisateur

- Un utilisateur peut consulter les différentes bières
- Un utilisateur peut consulter les différentes brasseries
- Un utilisateur peut mettre aucune, une ou des bières en favoris
- Un utilisateur peut mettre aucune, une ou des brasseries en favoris
- Un utilisateur peut mettre au maximum un avis sur une bière
- Un utilisateur peut mettre au maximum un avis sur une brasserie
- Un utilisateur doit avoir un email unique
- Un utilisateur doit avoir son mot de passe hashé
- Un utilisateur doit avoir au moins 18 ans (calculé à partir de la date de naissance)
- Le rôle d'un utilisateur doit être `client` ou `admin`
- Un même utilisateur ne peut pas mettre deux fois la même bière en favori
- Un même utilisateur ne peut pas mettre deux fois la même brasserie en favori
- Un même utilisateur ne peut pas laisser plusieurs avis sur la même bière
- Un même utilisateur ne peut pas laisser plusieurs avis sur la même brasserie
- Si un utilisateur est supprimé, ses avis et favoris le sont aussi

## Brasserie

- Une brasserie peut produire aucune, une ou plusieurs bières
- Une brasserie peut être mise en favoris par aucun, un ou plusieurs utilisateurs
- Une brasserie peut être illustrée par aucune, une ou plusieurs photos
- Si une brasserie est supprimée, ses bières, avis, mises en favoris et photos le sont aussi

## Bière

- Une bière doit être produite par une seule brasserie
- Une bière doit appartenir à au moins une catégorie
- Une bière doit contenir plusieurs ingrédients
- Une bière peut appartenir à plusieurs catégories
- Une bière peut recevoir aucun, un ou plusieurs avis
- Une bière peut être mise en favoris par aucun, un ou plusieurs utilisateurs
- Une bière peut être illustrée par aucune, une ou plusieurs photos
- Une bière ne peut être associée à la même catégorie qu'une seule fois
- Une bière ne peut contenir le même ingrédient qu'une seule fois
- Le taux d'alcool ne peut pas être négatif
- Le prix ne peut pas être négatif
- Le champ `sans_alcool` est indépendant du taux d'alcool : une bière peut avoir un taux > 0 et ne pas être marquée sans alcool
- Si une bière est supprimée, ses avis, mises en favoris et photos le sont aussi

## Catégorie

- Une catégorie peut comporter aucune, une ou plusieurs bières
- Si une catégorie est supprimée, ses associations avec les bières le sont aussi (CASCADE)

## Ingrédient

- Un ingrédient peut concerner aucune, une ou plusieurs bières
- Si un ingrédient est supprimé, ses associations avec les bières le sont aussi (CASCADE)

## Photo bière

- Une photo doit illustrer une seule bière
- Si la bière est supprimée, ses photos le sont aussi

## Photo brasserie

- Une photo doit illustrer une seule brasserie
- Si la brasserie est supprimée, ses photos le sont aussi

## Avis bière

- Un avis doit concerner une seule bière
- Un avis doit avoir obligatoirement une note, comprise entre 1 et 10
- Un avis peut avoir un commentaire (facultatif)
- Un avis ne peut être émis que par un utilisateur
- Un même utilisateur ne peut pas laisser plusieurs avis sur la même bière
- Un utilisateur peut modifier sa note et son commentaire existants sur une bière (via la procédure `sp_rate_beer`)

## Avis brasserie

- Un avis doit concerner une seule brasserie
- Un avis doit avoir obligatoirement une note, comprise entre 1 et 10
- Un avis peut avoir un commentaire (facultatif)
- Un avis ne peut être émis que par un utilisateur
- Un même utilisateur ne peut pas laisser plusieurs avis sur la même brasserie

## Journal des insertions (`beer_log`)

- Toute insertion d'une bière est automatiquement enregistrée dans le journal (déclenchée par la base de données, pas par l'application)
- Une entrée de journal doit référencer la bière insérée et conserver son nom au moment de l'insertion
- Une entrée de journal doit enregistrer l'horodatage exact et le rôle PostgreSQL ayant effectué l'opération
- Une entrée de journal ne peut pas être modifiée ni supprimée manuellement
- Si une bière est supprimée, ses entrées de journal le sont aussi (CASCADE)

## Procédure stockée `sp_rate_beer`

- `sp_rate_beer(user_id, beer_id, grade, comment)` insère ou met à jour la note d'un utilisateur sur une bière
- Si aucune note n'existe pour le couple (utilisateur, bière), une nouvelle ligne est insérée dans `beer_review`
- Si une note existe déjà pour ce couple, la note (`grade`) et le commentaire (`comment`) sont mis à jour
- La note transmise doit être comprise entre 1 et 10 (contrainte héritée de `beer_review`)

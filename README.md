# Zythologue

Base de données relationnelle PostgreSQL pour une application de découverte de bières artisanales. Le projet couvre la modélisation MERISE (MCD, MLD, MPD), la création du schéma SQL, l'alimentation avec des données réalistes et l'écriture de 13 requêtes couvrant les principaux besoins fonctionnels.

---

## Lancement avec Docker

```bash
# Copier le fichier d'environnement
cp .env.example .env

# Démarrer PostgreSQL
docker compose up -d

# Vérifier que le conteneur tourne
docker ps

# Arrêter
docker compose stop

# Supprimer l'environnement et les données
docker compose down -v
```

---

## Connexion DBeaver

| Paramètre | Valeur par défaut |
|-----------|-------------------|
| Host      | `localhost`       |
| Port      | `5433`            |
| Database  | `zythologue`      |
| Username  | `zythologue`      |
| Password  | `zythologue`      |

> Si le port `5433` est déjà utilisé, modifiez `POSTGRES_PORT` dans le fichier `.env` et adaptez la valeur dans DBeaver.

---

## Exécution des scripts SQL

Depuis la racine du projet, lancer les trois commandes dans l'ordre :

```bash
docker exec -i zythologue-postgres psql -U zythologue -d zythologue < sql/01_create_schema.sql
docker exec -i zythologue-postgres psql -U zythologue -d zythologue < sql/02_seed.sql
docker exec -i zythologue-postgres psql -U zythologue -d zythologue < sql/03_queries.sql
```

Ces commandes fonctionnent sur Windows, macOS et Linux sans modification.

---

## Hypothèses de modélisation

**Utilisateur**
Le champ `role` est limité aux valeurs `client` et `admin` via une contrainte `CHECK`. Les champs `created_at` et `updated_at` sont présents pour la traçabilité. Le mot-clé réservé `user` est systématiquement échappé en `"user"` dans PostgreSQL.

**Bière**
Une bière appartient à une seule brasserie (`brewery_id NOT NULL`). Elle peut appartenir à plusieurs catégories et contenir plusieurs ingrédients (tables de liaison `beer_category` et `beer_ingredient`). Le champ `is_alcohol_free` est un booléen distinct du taux d'alcool, pour permettre des filtres explicites.

**Avis**
Un utilisateur ne peut laisser qu'un seul avis par bière (`UNIQUE(user_id, beer_id)` sur `beer_review`) et par brasserie (`UNIQUE(user_id, brewery_id)` sur `brewery_review`). La note est contrainte entre 1 et 10 (`CHECK grade BETWEEN 1 AND 10`).

**Favoris**
Les tables `beer_favorite` et `brewery_favorite` utilisent une clé primaire composite `(user_id, beer_id)` / `(user_id, brewery_id)`, ce qui garantit l'unicité sans colonne `id` dédiée.

**Suppressions en cascade**
Toutes les clés étrangères sont définies avec `ON DELETE CASCADE` : supprimer une brasserie supprime ses bières, leurs avis, photos, favoris et liens vers les catégories et ingrédients.

**Photos**
Les photos stockent uniquement une URL. La table `beer_photo` est séparée de `brewery_photo` pour éviter une colonne nullable et simplifier les requêtes de suppression (Q13).

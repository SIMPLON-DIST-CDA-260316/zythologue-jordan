# Correction pair review — Zythologue

## Correcteur

Jordan

## Projet corrigé

**Repo :** zythologue-rfb  
**Auteur :** Raphaël

---

## Prise en main du projet

Le README est globalement bien structuré : il présente clairement l'objectif du projet, liste les fichiers importants et fournit les commandes Docker. L'ordre d'application des fichiers SQL est mentionné (`01` avant `02`), ce qui est un bon réflexe.

---

## Docker

Le projet se lance correctement avec `docker compose up -d`. Le conteneur `zythologue-postgres` démarre sans erreur et le healthcheck est bien configuré.

---

## PostgreSQL / DBeaver

La connexion fonctionne une fois le bon port identifié. Les informations de connexion sont présentes dans le README sous forme de tableau, ce qui est pratique.

La base s'initialise correctement après exécution de `01_create_schema.sql` puis `02_seed.sql` dans l'ordre. Les tables sont toutes créées et les données du seed sont cohérentes.

---

## Fichiers SQL

### 01_create_schema.sql — OK

Le schéma est propre et bien commenté. Les contraintes sont pertinentes :

- Clés primaires, étrangères avec comportements `CASCADE` / `RESTRICT` adaptés.
- Contraintes `CHECK` sur `alcohol_percentage`, `price` et `rating`.
- Contrainte `UNIQUE` sur `(app_user_id, beer_id)` dans `review` pour éviter les doublons d'avis.
- Les `DROP TABLE IF EXISTS … CASCADE` en tête de fichier permettent une réinitialisation propre.

### 02_seed.sql — OK

Les données sont cohérentes et réalistes. Les associations (ingrédients, favoris, avis) couvrent bien les différentes tables de jointure.

### 03_queries.sql — 1 erreur

**Requête 5 — KO :** l'INSERT d'exemple ne renseigne pas la colonne `picture_url`, pourtant définie `NOT NULL` dans le schéma.

```sql
-- Tel quel dans le fichier : provoque une erreur
INSERT INTO beer (name, description, alcohol_percentage, price, brewery_id, category_id)
VALUES ('Imperial Stout', 'Bière noire puissante aux notes de café', 9.50, 6.90, 1, 3);
-- SQL Error [23502]: null value in column "picture_url" violates not-null constraint
```

Correction :

```sql
INSERT INTO beer (name, description, picture_url, alcohol_percentage, price, brewery_id, category_id)
VALUES ('Imperial Stout', 'Bière noire puissante aux notes de café', 'https://images.example.com/imperial-stout.jpg', 9.50, 6.90, 1, 3);
```

**Requête 8 — syntaxe OK, non testable avec les données fournies :** la requête filtre les brasseries ayant strictement plus de 5 bières (`HAVING COUNT(b.id) > 5`). Le jeu de données ne contient que 5 bières réparties sur 5 brasseries (1 chacune), donc le résultat est toujours vide. La requête est correcte SQL-ement.

---

## Remarques générales

### Points positifs

- Structure du repo claire et bien organisée.
- Schéma SQL solide avec des contraintes bien pensées.
- Données du seed réalistes et suffisamment variées pour tester la plupart des requêtes (sauf juste la 8).
- Les requêtes SQL sont toutes commentées avec leur objectif, ce qui facilite la lecture.

### Points à améliorer

- Corriger la requête 5 : ajouter `picture_url` dans l'INSERT d'exemple.
- Enrichir le seed pour permettre de tester la requête 8 (au moins une brasserie avec 6+ bières).

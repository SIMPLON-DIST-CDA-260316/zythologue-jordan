-- ============================================================
-- Zythologue - Données de test (seed)
-- PostgreSQL 18
--
-- Exécution depuis la racine du projet (psql côté client) :
--   PGPASSWORD=zythologue psql -h localhost -p 5432 -U zythologue -d zythologue -f sql/02_seed.sql
--
-- Les meta-commandes \set `cat ...` sont traitées côté client ;
-- les fichiers JSON doivent être accessibles depuis le répertoire
-- courant au moment de l'exécution.
-- ============================================================

-- ============================================================
-- 1. Nettoyage — ordre inverse des dépendances FK
-- ============================================================
TRUNCATE
    beer_ingredient,
    beer_category,
    brewery_favorite,
    beer_favorite,
    brewery_photo,
    beer_photo,
    brewery_review,
    beer_review,
    beer,
    ingredient,
    category,
    brewery,
    "user"
RESTART IDENTITY CASCADE;

-- ============================================================
-- 2. Tables indépendantes
-- ============================================================

\set users `cat data/users.json`
INSERT INTO "user" (id, lastname, firstname, email, password, birthdate, role, created_at, updated_at)
SELECT
    (elem->>'id')::INTEGER,
    elem->>'lastname',
    elem->>'firstname',
    elem->>'email',
    elem->>'password',
    (elem->>'birthdate')::DATE,
    elem->>'role',
    (elem->>'created_at')::TIMESTAMPTZ,
    (elem->>'updated_at')::TIMESTAMPTZ
FROM json_array_elements(:'users'::json) AS elem;

\set breweries `cat data/breweries.json`
INSERT INTO brewery (id, name, description, country, city, website)
SELECT
    (elem->>'id')::INTEGER,
    elem->>'name',
    elem->>'description',
    elem->>'country',
    elem->>'city',
    elem->>'website'
FROM json_array_elements(:'breweries'::json) AS elem;

\set categories `cat data/categories.json`
INSERT INTO category (id, name, description)
SELECT
    (elem->>'id')::INTEGER,
    elem->>'name',
    elem->>'description'
FROM json_array_elements(:'categories'::json) AS elem;

\set ingredients `cat data/ingredients.json`
INSERT INTO ingredient (id, name, description)
SELECT
    (elem->>'id')::INTEGER,
    elem->>'name',
    elem->>'description'
FROM json_array_elements(:'ingredients'::json) AS elem;

-- ============================================================
-- 3. Tables avec FK
-- ============================================================

\set beers `cat data/beers.json`
INSERT INTO beer (id, name, description, price, alcohol_level, is_alcohol_free, brewery_id)
SELECT
    (elem->>'id')::INTEGER,
    elem->>'name',
    elem->>'description',
    (elem->>'price')::NUMERIC(6,2),
    (elem->>'alcohol_level')::NUMERIC(4,1),
    (elem->>'is_alcohol_free')::BOOLEAN,
    (elem->>'brewery_id')::INTEGER
FROM json_array_elements(:'beers'::json) AS elem;

\set beer_reviews `cat data/beer_reviews.json`
INSERT INTO beer_review (id, grade, comment, created_at, user_id, beer_id)
SELECT
    (elem->>'id')::INTEGER,
    (elem->>'grade')::INTEGER,
    elem->>'comment',
    (elem->>'created_at')::TIMESTAMPTZ,
    (elem->>'user_id')::INTEGER,
    (elem->>'beer_id')::INTEGER
FROM json_array_elements(:'beer_reviews'::json) AS elem;

\set brewery_reviews `cat data/brewery_reviews.json`
INSERT INTO brewery_review (id, grade, comment, created_at, user_id, brewery_id)
SELECT
    (elem->>'id')::INTEGER,
    (elem->>'grade')::INTEGER,
    elem->>'comment',
    (elem->>'created_at')::TIMESTAMPTZ,
    (elem->>'user_id')::INTEGER,
    (elem->>'brewery_id')::INTEGER
FROM json_array_elements(:'brewery_reviews'::json) AS elem;

\set beer_photos `cat data/beer_photos.json`
INSERT INTO beer_photo (id, url, beer_id)
SELECT
    (elem->>'id')::INTEGER,
    elem->>'url',
    (elem->>'beer_id')::INTEGER
FROM json_array_elements(:'beer_photos'::json) AS elem;

\set brewery_photos `cat data/brewery_photos.json`
INSERT INTO brewery_photo (id, url, brewery_id)
SELECT
    (elem->>'id')::INTEGER,
    elem->>'url',
    (elem->>'brewery_id')::INTEGER
FROM json_array_elements(:'brewery_photos'::json) AS elem;

-- ============================================================
-- 4. Tables de liaison (clés primaires composites)
-- ============================================================

\set beer_favorites `cat data/beer_favorites.json`
INSERT INTO beer_favorite (user_id, beer_id, created_at)
SELECT
    (elem->>'user_id')::INTEGER,
    (elem->>'beer_id')::INTEGER,
    (elem->>'created_at')::TIMESTAMPTZ
FROM json_array_elements(:'beer_favorites'::json) AS elem;

\set brewery_favorites `cat data/brewery_favorites.json`
INSERT INTO brewery_favorite (user_id, brewery_id, created_at)
SELECT
    (elem->>'user_id')::INTEGER,
    (elem->>'brewery_id')::INTEGER,
    (elem->>'created_at')::TIMESTAMPTZ
FROM json_array_elements(:'brewery_favorites'::json) AS elem;

\set beer_categories `cat data/beer_categories.json`
INSERT INTO beer_category (beer_id, category_id)
SELECT
    (elem->>'beer_id')::INTEGER,
    (elem->>'category_id')::INTEGER
FROM json_array_elements(:'beer_categories'::json) AS elem;

\set beer_ingredients `cat data/beer_ingredients.json`
INSERT INTO beer_ingredient (beer_id, ingredient_id)
SELECT
    (elem->>'beer_id')::INTEGER,
    (elem->>'ingredient_id')::INTEGER
FROM json_array_elements(:'beer_ingredients'::json) AS elem;

-- ============================================================
-- 5. Resynchronisation des séquences SERIAL
-- ============================================================
SELECT setval(pg_get_serial_sequence('"user"', 'id'),       MAX(id)) FROM "user";
SELECT setval(pg_get_serial_sequence('brewery', 'id'),      MAX(id)) FROM brewery;
SELECT setval(pg_get_serial_sequence('category', 'id'),     MAX(id)) FROM category;
SELECT setval(pg_get_serial_sequence('ingredient', 'id'),   MAX(id)) FROM ingredient;
SELECT setval(pg_get_serial_sequence('beer', 'id'),         MAX(id)) FROM beer;
SELECT setval(pg_get_serial_sequence('beer_review', 'id'),  MAX(id)) FROM beer_review;
SELECT setval(pg_get_serial_sequence('brewery_review', 'id'), MAX(id)) FROM brewery_review;
SELECT setval(pg_get_serial_sequence('beer_photo', 'id'),   MAX(id)) FROM beer_photo;
SELECT setval(pg_get_serial_sequence('brewery_photo', 'id'), MAX(id)) FROM brewery_photo;

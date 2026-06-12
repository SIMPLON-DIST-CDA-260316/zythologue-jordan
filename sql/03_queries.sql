-- ============================================================
-- Zythologue - Requêtes SQL (13 exercices)
-- PostgreSQL 18
--
-- Exécution (après 01_create_schema.sql + 02_seed.sql) :
--   docker exec -i zythologue-postgres psql -U zythologue -d zythologue < sql/03_queries.sql
-- ============================================================


-- ============================================================
-- Q1 — Lister les bières par taux d'alcool croissant
-- ============================================================
SELECT
    name            AS biere,
    alcohol_level   AS degre,
    price           AS prix
FROM beer
ORDER BY alcohol_level ASC, name;


-- ============================================================
-- Q2 — Afficher le nombre de bières par catégorie ou style
-- ============================================================
SELECT
    c.name          AS categorie,
    COUNT(bc.beer_id) AS nb_bieres
FROM category  AS c
LEFT JOIN beer_category AS bc ON bc.category_id = c.id
GROUP BY c.id, c.name
ORDER BY nb_bieres DESC, c.name;


-- ============================================================
-- Q3 — Trouver toutes les bières d'une brasserie donnée
--       (exemple : Brasserie de Chimay)
-- ============================================================
SELECT
    b.name          AS biere,
    b.alcohol_level AS degre,
    b.price         AS prix
FROM beer AS b
JOIN brewery AS br ON br.id = b.brewery_id
WHERE br.name = 'Brasserie de Chimay'
ORDER BY b.name;


-- ============================================================
-- Q4 — Lister les utilisateurs et le nombre de bières
--       ajoutées à leurs favoris
-- ============================================================
SELECT
    u.firstname     AS prenom,
    u.lastname      AS nom,
    COUNT(bf.beer_id) AS nb_favoris
FROM "user" AS u
LEFT JOIN beer_favorite AS bf ON bf.user_id = u.id
GROUP BY u.id, u.firstname, u.lastname
ORDER BY nb_favoris DESC, u.lastname;


-- ============================================================
-- Q5 — Ajouter une nouvelle bière à la base de données
-- ============================================================
INSERT INTO beer (name, description, price, alcohol_level, is_alcohol_free, brewery_id)
VALUES (
    'Chimay Grande Réserve 2025',
    'Édition spéciale millésimée aux arômes de fruits secs et de vanille.',
    5.50,
    9.0,
    false,
    1
)
RETURNING id, name, alcohol_level, price;


-- ============================================================
-- Q6 — Afficher les bières avec leur brasserie, triées par pays
-- ============================================================
SELECT
    br.country      AS pays,
    br.name         AS brasserie,
    b.name          AS biere,
    b.alcohol_level AS degre
FROM beer AS b
JOIN brewery AS br ON br.id = b.brewery_id
ORDER BY br.country, br.name, b.name;


-- ============================================================
-- Q7 — Lister les bières avec leurs ingrédients
-- ============================================================
SELECT
    b.name                                              AS biere,
    STRING_AGG(i.name, ', ' ORDER BY i.name)            AS ingredients
FROM beer b
JOIN beer_ingredient AS bi ON bi.beer_id = b.id
JOIN ingredient AS i ON i.id = bi.ingredient_id
GROUP BY b.id, b.name
ORDER BY b.name;


-- ============================================================
-- Q8 — Afficher les brasseries produisant plus de cinq bières
-- ============================================================
SELECT
    br.name         AS brasserie,
    COUNT(b.id)     AS nb_bieres
FROM brewery AS br
JOIN beer AS b ON b.brewery_id = br.id
GROUP BY br.id, br.name
HAVING COUNT(b.id) > 5
ORDER BY nb_bieres DESC;


-- ============================================================
-- Q9 — Lister les bières qui ne figurent dans aucun favori
-- ============================================================
SELECT
    b.name          AS biere
FROM beer AS b
WHERE NOT EXISTS (
    SELECT 1
    FROM beer_favorite AS bf
    WHERE bf.beer_id = b.id
)
ORDER BY b.name;


-- ============================================================
-- Q10 — Trouver les bières favorites communes entre deux utilisateurs
--        (exemple : user_id 1 et user_id 2)
-- ============================================================
SELECT
    b.name          AS biere,
    b.alcohol_level AS degre
FROM beer_favorite AS bf1
JOIN beer_favorite AS bf2 ON bf2.beer_id = bf1.beer_id
JOIN beer AS b ON b.id = bf1.beer_id
WHERE bf1.user_id = 1
  AND bf2.user_id = 2
ORDER BY b.name;


-- ============================================================
-- Q11 — Afficher les brasseries dont les bières ont une moyenne
--        de notes supérieure à une valeur donnée (seuil : 7)
-- ============================================================
SELECT
    br.name                         AS brasserie,
    ROUND(AVG(r.grade), 2)          AS note_moyenne
FROM brewery AS br
JOIN beer AS b ON b.brewery_id = br.id
JOIN beer_review AS r ON r.beer_id = b.id
GROUP BY br.id, br.name
HAVING AVG(r.grade) > 7
ORDER BY note_moyenne DESC;


-- ============================================================
-- Q12 — Mettre à jour les informations d'une brasserie
--        (exemple : Brasserie de Chimay)
-- ============================================================
UPDATE brewery
SET
    description = 'Abbaye cistercienne fondée en 1850, pionnière des bières trappistes belges d''exception.',
    website     = 'https://www.chimay.com'
WHERE name = 'Brasserie de Chimay'
RETURNING id, name, description, website;


-- ============================================================
-- Q13 — Supprimer les photos d'une bière donnée
--        (exemple : Chimay Rouge — beer_id=1, 3 photos dans le seed)
-- ============================================================
DELETE FROM beer_photo
WHERE beer_id = (
    SELECT id FROM beer WHERE name = 'Chimay Rouge'
)
RETURNING id, url;

-- ============================================================
-- Bonus 2 — Consulter le journal des insertions de bières
-- ============================================================
SELECT
    bl.id               AS log_id,
    bl.logged_at        AS date_ajout,
    bl.beer_id          AS id_biere,
    bl.beer_name        AS nom_biere,
    br.name             AS brasserie,
    bl.logged_by        AS utilisateur_db
FROM beer_log AS bl
JOIN beer AS b  ON b.id  = bl.beer_id
JOIN brewery AS br ON br.id = b.brewery_id
ORDER BY bl.logged_at DESC;

-- ============================================================
-- Bonus 3 — Procédure stockée : noter une bière
--   - INSERT si l'utilisateur n'a pas encore noté cette bière
--   - UPDATE si une note existe déjà
-- ============================================================
CREATE OR REPLACE PROCEDURE sp_rate_beer(
    p_user_id  INTEGER,
    p_beer_id  INTEGER,
    p_grade    INTEGER,
    p_comment  TEXT DEFAULT NULL
)
LANGUAGE plpgsql
AS $$
BEGIN
    INSERT INTO beer_review (grade, comment, user_id, beer_id)
    VALUES (p_grade, p_comment, p_user_id, p_beer_id)
    ON CONFLICT (user_id, beer_id)
    DO UPDATE SET
        grade   = EXCLUDED.grade,
        comment = EXCLUDED.comment;
END;
$$;

-- Exemples d'utilisation :
-- Nouvelle note (user 1, bière 5, note 8)
CALL sp_rate_beer(1, 5, 8, 'Belle amertume, très équilibrée.');

-- Mise à jour de la même note (même user, même bière, note changée)
CALL sp_rate_beer(1, 5, 9, 'Encore meilleure en la redégustant !');
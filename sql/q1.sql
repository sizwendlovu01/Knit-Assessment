-- List all active schools in Gauteng ordered by newest first

SELECT
    name,
    created_at
FROM schools
WHERE province = 'Gauteng'
  AND is_active = TRUE
ORDER BY created_at DESC;
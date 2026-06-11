-- List users inactive for more than 30 days or never logged in

SELECT
    u.email,
    s.name AS school_name,
    u.role,
    u.last_login
FROM users u
JOIN schools s
    ON s.id = u.school_id
WHERE
    u.last_login IS NULL
    OR u.last_login < CURRENT_DATE - INTERVAL '30 days'
ORDER BY u.last_login NULLS FIRST;
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

---For the said search, I had to retrieve inactive users, which meant those who hadn't been logging in within the last 30 days or even hadn't done so ever before. The tables were merged on the users table and schools table since I wanted to display the name of the school. After this, I made an inspection of the last_login value and made sure that I got results for the following two categories: when last_login value is null and when last login date is more than 30 days ago from today’s date.
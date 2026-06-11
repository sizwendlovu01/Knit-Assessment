-- Show overdue learner count and overdue fee amount per school

SELECT
    s.name AS school_name,
    COUNT(DISTINCT l.id) AS learners_with_overdue_fees,
    COALESCE(SUM(f.amount), 0) AS total_overdue_amount
FROM schools s
JOIN learners l
    ON l.school_id = s.id
JOIN fees f
    ON f.learner_id = l.id
WHERE f.status = 'overdue'
GROUP BY s.id, s.name
ORDER BY total_overdue_amount DESC;
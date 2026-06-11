-- Monthly payment collections by province for current year

SELECT
    s.province,
    TO_CHAR(p.payment_date, 'YYYY-MM') AS month,
    SUM(p.amount) AS total_collected
FROM payments p
JOIN learners l
    ON l.id = p.learner_id
JOIN schools s
    ON s.id = l.school_id
WHERE EXTRACT(YEAR FROM p.payment_date) =
      EXTRACT(YEAR FROM CURRENT_DATE)
GROUP BY
    s.province,
    TO_CHAR(p.payment_date, 'YYYY-MM')
ORDER BY
    s.province,
    month;
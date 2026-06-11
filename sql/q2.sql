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

--In this case, I performed a join between the schools table, the learners table and the fees table so as to find learners who had at least one overdue fee. Filtering based on the fee’s status and then computing the number of learners who had an overdue fee along with the total overdue amount for every school was done. COUNT(DISTINCT l.id) was used since a learner could have several overdue fees and hence there was need to count learners and not the individual fees.
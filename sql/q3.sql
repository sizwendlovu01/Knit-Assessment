-- Find learners who have never made a payment

SELECT
    l.name AS learner_name,
    s.name AS school_name,
    l.grade
FROM learners l
JOIN schools s
    ON s.id = l.school_id
LEFT JOIN payments p
    ON p.learner_id = l.id
WHERE p.id IS NULL
ORDER BY s.name, l.name;


--In this case, I was required to search for those learners who had never made any payments at all. I began by first joining the learners table with the schools table to show the school name along with the name of each of the learners. Then I used a left join between the payments table and the learners table to ensure that all learners appear in the output regardless of whether or not they had made any payments. To get learners who had never made any payments, I specified the payment id field as NULL.
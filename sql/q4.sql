-- Compare paid fees against recorded payments and show mismatches

WITH paid_fees AS (
    SELECT
        s.id AS school_id,
        s.name AS school_name,
        COALESCE(SUM(f.amount), 0) AS total_paid_fees
    FROM schools s
    LEFT JOIN learners l
        ON l.school_id = s.id
    LEFT JOIN fees f
        ON f.learner_id = l.id
    WHERE f.status = 'paid'
    GROUP BY s.id, s.name
),

payment_totals AS (
    SELECT
        s.id AS school_id,
        COALESCE(SUM(p.amount), 0) AS total_payments
    FROM schools s
    LEFT JOIN learners l
        ON l.school_id = s.id
    LEFT JOIN payments p
        ON p.learner_id = l.id
    GROUP BY s.id
)

SELECT
    pf.school_name,
    pf.total_paid_fees,
    pt.total_payments,
    (pf.total_paid_fees - pt.total_payments) AS difference
FROM paid_fees pf
JOIN payment_totals pt
    ON pf.school_id = pt.school_id
WHERE pf.total_paid_fees <> pt.total_payments
ORDER BY ABS(pf.total_paid_fees - pt.total_payments) DESC;
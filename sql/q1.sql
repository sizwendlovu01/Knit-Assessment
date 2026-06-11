-- List of all active schools in Gauteng ordered by newest first

SELECT
    name,
    created_at
FROM schools
WHERE province = 'Gauteng'
  AND is_active = TRUE
ORDER BY created_at DESC;

--This query returns the name of all the active schools in the province of Gauteng along with their date of creation. I simply added a condition in the WHERE statement for selecting the data for the particular province. Furthermore, sorting is done in descending order according to the value of created_at, which gives the recently created schools at the top. As everything was present in the same table, no JOIN or aggregation statements were required.
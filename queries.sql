-- =========================
-- The project asked queries
-- =========================


-- ====================
-- Institutes Reporting
-- ====================
SET @test_institute_id = 16;

-- First Query:
-- information of current and previous researchers (all together)
SELECT
	p.*
FROM persons p
INNER JOIN contracts c
	ON p.id = c.person_id
INNER JOIN research_activities ra
	ON c.research_activity_id = ra.id
WHERE ra.institute_id = @test_institute_id;


-- information of current and previous researchers (labeled)
-- NOTE: It can return duplicate person with different statues, need to be fixed
SELECT
	p.*,
    'currently in contract' AS status
FROM persons p
INNER JOIN contracts c
	ON p.id = c.person_id
INNER JOIN research_activities ra
	ON c.research_activity_id = ra.id
WHERE
	ra.institute_id = @test_institute_id AND
    (c.end_date IS NULL OR c.end_date >= CURDATE())
UNION
SELECT
	p.*,
    'previous researcher' AS status
FROM persons p
INNER JOIN contracts c
	ON p.id = c.person_id
INNER JOIN research_activities ra
	ON c.research_activity_id = ra.id
WHERE
	ra.institute_id = @test_institute_id AND
    (c.end_date < CURDATE());
    
-- Second Query:
-- Financial records of an institute (salary payments in research activities)
SELECT
	*
FROM research_activity_salary_payments
WHERE research_activity_id IN (
	SELECT id
    FROM research_activities
    WHERE institute_id = @test_institute_id
);

-- Financial records of an institute (financial supports for research activities)
SELECT 
	rafs.id,
    rafs.institute_id,
    rafs.research_activity_id,
    fst.title AS support_type,
    rafs.amount,
    rafs.paid_at
FROM research_activity_financial_supports rafs
INNER JOIN financial_support_types fst
	ON rafs.type_id = fst.id
WHERE institute_id = @test_institute_id;

-- Total financial records of an institute (both supports and salary payments)
SELECT
	sum(amount),
    'Salary' AS type
FROM research_activity_salary_payments
WHERE research_activity_id IN (
	SELECT id
    FROM research_activities
    WHERE institute_id = @test_institute_id
)
UNION
SELECT
    sum(rafs.amount),
    fst.title AS type
FROM research_activity_financial_supports rafs
INNER JOIN financial_support_types fst
	ON rafs.type_id = fst.id
WHERE institute_id = @test_institute_id
GROUP BY type;

-- Third Query:
-- Institute preferred research areas
SELECT 
	iwa.institute_id,
    i.name,
    ra.title AS research_area
FROM institute_work_areas iwa
INNER JOIN research_areas ra
	ON iwa.area_id = ra.id
INNER JOIN institutes i
	ON iwa.institute_id = i.id;
    
-- Institute activities research areas
SELECT
	rarea.title AS research_area
FROM research_activities ra
INNER JOIN research_activity_areas raa
	ON ra.id = raa.research_activity_id
INNER JOIN research_areas rarea
	ON raa.research_area_id = rarea.id
WHERE ra.institute_id = @test_institute_id;

-- Fourth Query:
-- Institute research activities
-- (to have the research title (like paper name) this result must be joined with each table seperately)
SELECT 
	ra.id,
    rat.title as type,
    ra.content_id,
    concat(p.first_name, ' ', p.last_name) AS officer_researcher,
    ra.is_international,
    ra.start_date,
    ra.end_date
FROM research_activities ra
INNER JOIN research_activity_types rat
	ON ra.type_id = rat.id
INNER JOIN persons p
	ON ra.officer_researcher_id = p.id
WHERE institute_id = @test_institute_id;


-- Drop indices
DROP INDEX IF EXISTS idx_departments_company_id;
DROP INDEX IF EXISTS idx_departments_parent_department_id;

-- Drop departments table
DROP TABLE IF EXISTS manage.departments;
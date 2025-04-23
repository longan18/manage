-- Drop indices
DROP INDEX IF EXISTS idx_employees_company_id;
DROP INDEX IF EXISTS idx_employees_department_id;
DROP INDEX IF EXISTS idx_employees_position_id;
DROP INDEX IF EXISTS idx_employees_manager_id;
DROP INDEX IF EXISTS idx_employees_user_id;

-- Drop employees table
DROP TABLE IF EXISTS manage.employees;

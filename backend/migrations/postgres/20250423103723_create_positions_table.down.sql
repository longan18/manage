-- Drop indices
DROP INDEX IF EXISTS idx_positions_company_id;
DROP INDEX IF EXISTS idx_positions_department_id;

-- Drop positions table
DROP TABLE IF EXISTS manage.positions;
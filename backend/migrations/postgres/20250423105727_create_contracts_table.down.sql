-- Drop indices
DROP INDEX IF EXISTS idx_contracts_employee_id;
DROP INDEX IF EXISTS idx_contracts_contract_code;
DROP INDEX IF EXISTS idx_contracts_status;
DROP INDEX IF EXISTS idx_contracts_end_date;

-- Drop contracts table
DROP TABLE IF EXISTS manage.contracts;
-- Create leave requests table
CREATE TABLE IF NOT EXISTS manage.employee_roles_companies (
    employee_id BIGINT NOT NULL REFERENCES manage.employees(id) ON DELETE CASCADE,
    role_companies_id BIGINT NOT NULL REFERENCES manage.role_companies(id) ON DELETE CASCADE,
    company_id BIGINT NOT NULL REFERENCES manage.companies(id) ON DELETE CASCADE,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW()
);

DROP TRIGGER IF EXISTS set_timestamp_employee_roles_companies ON manage.employee_roles_companies; 
CREATE TRIGGER set_timestamp_employee_roles_companies
BEFORE UPDATE ON manage.employee_roles_companies
FOR EACH ROW
EXECUTE FUNCTION manage.trigger_set_timestamp();

-- Comment on table and columns
COMMENT ON TABLE manage.employee_roles_companies IS 'Bảng vai trò của nhân viên trong công ty';
COMMENT ON COLUMN manage.employee_roles_companies.employee_id IS 'ID nhân viên';
COMMENT ON COLUMN manage.employee_roles_companies.role_companies_id IS 'ID vai trò trong công ty';
COMMENT ON COLUMN manage.employee_roles_companies.company_id IS 'ID công ty';
COMMENT ON COLUMN manage.employee_roles_companies.created_at IS 'Thời gian gán vai trò của nhân viên trong công ty';
COMMENT ON COLUMN manage.employee_roles_companies.updated_at IS 'Thời gian cập nhật vai trò của nhân viên trong công ty';


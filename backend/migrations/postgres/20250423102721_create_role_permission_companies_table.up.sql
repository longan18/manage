-- Create role permissions table
CREATE TABLE IF NOT EXISTS manage.role_permission_companies (
    role_company_id INT NOT NULL REFERENCES manage.role_companies(id) ON DELETE CASCADE,
    permission_company_id INT NOT NULL REFERENCES manage.permission_companies(id) ON DELETE CASCADE,
    company_id BIGINT NOT NULL REFERENCES manage.companies(id) ON DELETE CASCADE,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW()
);

DROP TRIGGER IF EXISTS set_timestamp_role_permission_companies ON manage.role_permission_companies; 
CREATE TRIGGER set_timestamp_role_permission_companies
BEFORE UPDATE ON manage.role_permission_companies
FOR EACH ROW
EXECUTE FUNCTION manage.trigger_set_timestamp();

COMMENT ON TABLE manage.role_permission_companies IS 'Bảng lưu thông tin vai trò quyền công ty';
COMMENT ON COLUMN manage.role_permission_companies.role_company_id IS 'ID vai trò công ty';
COMMENT ON COLUMN manage.role_permission_companies.permission_company_id IS 'ID quyền công ty';
COMMENT ON COLUMN manage.role_permission_companies.company_id IS 'ID công ty';
COMMENT ON COLUMN manage.role_permission_companies.created_at IS 'Ngày tạo vai trò quyền công ty';
COMMENT ON COLUMN manage.role_permission_companies.updated_at IS 'Ngày cập nhật vai trò quyền công ty';
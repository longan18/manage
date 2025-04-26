-- Create permissions table
CREATE TABLE IF NOT EXISTS manage.permission_companies (
    id BIGSERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL UNIQUE,
    company_id BIGINT NOT NULL REFERENCES manage.companies(id) ON DELETE CASCADE,
    description TEXT NULL,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW()
);

DROP TRIGGER IF EXISTS set_timestamp_permission_companies ON manage.permission_companies; 
CREATE TRIGGER set_timestamp_permission_companies
BEFORE UPDATE ON manage.permission_companies
FOR EACH ROW
EXECUTE FUNCTION manage.trigger_set_timestamp();

-- Create indices for performance
CREATE INDEX IF NOT EXISTS idx_permission_companies_company_id ON manage.permission_companies(company_id);

-- Comment on table and columns
COMMENT ON TABLE manage.permission_companies IS 'Bảng lưu thông tin quyền công ty';
COMMENT ON COLUMN manage.permission_companies.name IS 'Tên quyền trong công ty';
COMMENT ON COLUMN manage.permission_companies.company_id IS 'ID công ty';
COMMENT ON COLUMN manage.permission_companies.description IS 'Mô tả quyền trong công ty';
COMMENT ON COLUMN manage.permission_companies.created_at IS 'Ngày tạo quyền trong công ty';
COMMENT ON COLUMN manage.permission_companies.updated_at IS 'Ngày cập nhật quyền trong công ty';

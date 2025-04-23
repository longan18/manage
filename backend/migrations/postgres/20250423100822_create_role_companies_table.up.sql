-- Create roles table
CREATE TABLE IF NOT EXISTS manage.role_companies (
    id BIGSERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL UNIQUE,
    company_id BIGINT NOT NULL REFERENCES manage.companies(id) ON DELETE CASCADE,
    description TEXT NULL,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW()
);

DROP TRIGGER IF EXISTS set_timestamp_role_companies ON manage.role_companies; 
CREATE TRIGGER set_timestamp_role_companies
BEFORE UPDATE ON manage.role_companies
FOR EACH ROW
EXECUTE FUNCTION manage.trigger_set_timestamp();

-- Create indices for performance
CREATE INDEX IF NOT EXISTS idx_role_companies_company_id ON manage.role_companies(company_id);

-- Comment on table and columns
COMMENT ON TABLE manage.role_companies IS 'Bảng lưu thông tin vai trò công ty';
COMMENT ON COLUMN manage.role_companies.name IS 'Tên vai trò trong công ty';
COMMENT ON COLUMN manage.role_companies.company_id IS 'ID công ty';
COMMENT ON COLUMN manage.role_companies.description IS 'Mô tả vai trò trong công ty';
COMMENT ON COLUMN manage.role_companies.created_at IS 'Ngày tạo vai trò trong công ty';
COMMENT ON COLUMN manage.role_companies.updated_at IS 'Ngày cập nhật vai trò trong công ty';

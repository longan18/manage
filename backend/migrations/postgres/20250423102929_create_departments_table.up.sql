-- Create departments table
CREATE TABLE IF NOT EXISTS manage.departments (
    id BIGSERIAL PRIMARY KEY,
    company_id BIGINT NOT NULL REFERENCES manage.companies(id) ON DELETE CASCADE,
    manager_id BIGINT NULL,
    parent_department_id BIGINT NULL REFERENCES manage.departments(id) ON DELETE CASCADE,
    name VARCHAR(255) NOT NULL,
    description TEXT NULL,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW(),

    UNIQUE (company_id, name)
);

DROP TRIGGER IF EXISTS set_timestamp_departments ON manage.departments; 
CREATE TRIGGER set_timestamp_departments
BEFORE UPDATE ON manage.departments
FOR EACH ROW
EXECUTE FUNCTION manage.trigger_set_timestamp();

-- Create indices for performance
CREATE INDEX IF NOT EXISTS idx_departments_company_id ON manage.departments(company_id);
CREATE INDEX IF NOT EXISTS idx_departments_parent_department_id ON manage.departments(parent_department_id);

COMMENT ON TABLE manage.departments IS 'Bảng lưu thông tin phòng ban';
COMMENT ON COLUMN manage.departments.name IS 'Tên phòng ban';
COMMENT ON COLUMN manage.departments.manager_id IS 'ID người quản lý phòng ban';
COMMENT ON COLUMN manage.departments.company_id IS 'ID công ty';
COMMENT ON COLUMN manage.departments.parent_department_id IS 'ID phòng ban cha';
COMMENT ON COLUMN manage.departments.description IS 'Mô tả phòng ban';
COMMENT ON COLUMN manage.departments.created_at IS 'Ngày tạo phòng ban';
COMMENT ON COLUMN manage.departments.updated_at IS 'Ngày cập nhật phòng ban';


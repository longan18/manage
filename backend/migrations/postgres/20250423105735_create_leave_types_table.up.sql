-- Create leave types table
CREATE TABLE IF NOT EXISTS manage.leave_types (
    id BIGSERIAL PRIMARY KEY,
    company_id BIGINT NOT NULL REFERENCES manage.companies(id) ON DELETE CASCADE,
    name VARCHAR(100) NOT NULL,
    description text NOT NULL,
    default_days_per_year NUMERIC(5, 2) NULL,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW(),

    UNIQUE(company_id, name)
);

DROP TRIGGER IF EXISTS set_timestamp_leave_types ON manage.leave_types; 
CREATE TRIGGER set_timestamp_leave_types
BEFORE UPDATE ON manage.leave_types
FOR EACH ROW
EXECUTE FUNCTION manage.trigger_set_timestamp();

-- Create indices for performance
CREATE INDEX IF NOT EXISTS idx_leave_types_name ON manage.leave_types(name);

-- Comment on table and columns
COMMENT ON TABLE manage.leave_types IS 'Bảng lưu loại nghỉ phép';
COMMENT ON COLUMN manage.leave_types.company_id IS 'ID công ty';
COMMENT ON COLUMN manage.leave_types.name IS 'Tên loại nghỉ phép';
COMMENT ON COLUMN manage.leave_types.description IS 'Mô tả loại nghỉ phép';
COMMENT ON COLUMN manage.leave_types.default_days_per_year IS 'Số ngày mặc định mỗi năm';
COMMENT ON COLUMN manage.leave_types.created_at IS 'Ngày tạo loại nghỉ phép';
COMMENT ON COLUMN manage.leave_types.updated_at IS 'Ngày cập nhật loại nghỉ phép';

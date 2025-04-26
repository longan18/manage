-- Create positions table
CREATE TABLE IF NOT EXISTS manage.positions (
    id BIGSERIAL PRIMARY KEY,
    company_id BIGINT NOT NULL REFERENCES manage.companies(id) ON DELETE CASCADE,
    department_id BIGINT NULL REFERENCES manage.departments(id) ON DELETE CASCADE,
    title VARCHAR(255) NOT NULL,
    description TEXT NULL,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW(),

    UNIQUE (company_id, title)
);

DROP TRIGGER IF EXISTS set_timestamp_positions ON manage.positions; 
CREATE TRIGGER set_timestamp_positions
BEFORE UPDATE ON manage.positions
FOR EACH ROW
EXECUTE FUNCTION manage.trigger_set_timestamp();

-- Create indices for performance
CREATE INDEX IF NOT EXISTS idx_positions_company_id ON manage.positions(company_id);
CREATE INDEX IF NOT EXISTS idx_positions_department_id ON manage.positions(department_id);

COMMENT ON TABLE manage.positions IS 'Bảng lưu thông tin vị trí công việc';
COMMENT ON COLUMN manage.positions.company_id IS 'ID công ty';
COMMENT ON COLUMN manage.positions.department_id IS 'ID phòng ban';
COMMENT ON COLUMN manage.positions.title IS 'Tên vị trí công việc';
COMMENT ON COLUMN manage.positions.description IS 'Mô tả vị trí công việc';
COMMENT ON COLUMN manage.positions.created_at IS 'Ngày tạo vị trí công việc';
COMMENT ON COLUMN manage.positions.updated_at IS 'Ngày cập nhật vị trí công việc';

-- Create permissions table
CREATE TABLE IF NOT EXISTS manage.permissions (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL UNIQUE,
    description TEXT NULL,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW()
);

DROP TRIGGER IF EXISTS set_timestamp_permissions ON manage.permissions; 
CREATE TRIGGER set_timestamp_permissions
BEFORE UPDATE ON manage.permissions
FOR EACH ROW
EXECUTE FUNCTION manage.trigger_set_timestamp();

-- Create indices for performance
CREATE INDEX IF NOT EXISTS idx_permissions_name ON manage.permissions(name);

-- Comment on table and columns
COMMENT ON TABLE manage.permissions IS 'Bảng lưu thông tin quyền';
COMMENT ON COLUMN manage.permissions.name IS 'Tên quyền';
COMMENT ON COLUMN manage.permissions.description IS 'Mô tả quyền';
COMMENT ON COLUMN manage.permissions.created_at IS 'Ngày tạo quyền';
COMMENT ON COLUMN manage.permissions.updated_at IS 'Ngày cập nhật quyền';

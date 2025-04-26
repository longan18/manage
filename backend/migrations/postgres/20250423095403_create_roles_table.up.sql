-- Create roles table
CREATE TABLE IF NOT EXISTS manage.roles (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL UNIQUE,
    description TEXT NULL,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW()
);

DROP TRIGGER IF EXISTS set_timestamp_roles ON manage.roles; 
CREATE TRIGGER set_timestamp_roles
BEFORE UPDATE ON manage.roles
FOR EACH ROW
EXECUTE FUNCTION manage.trigger_set_timestamp();

-- Create indices for performance
CREATE INDEX IF NOT EXISTS idx_roles_name ON manage.roles(name);

-- Comment on table and columns
COMMENT ON TABLE manage.roles IS 'Bảng lưu thông tin vai trò';
COMMENT ON COLUMN manage.roles.name IS 'Tên vai trò';
COMMENT ON COLUMN manage.roles.description IS 'Mô tả vai trò';
COMMENT ON COLUMN manage.roles.created_at IS 'Ngày tạo vai trò';
COMMENT ON COLUMN manage.roles.updated_at IS 'Ngày cập nhật vai trò';

-- Create role permissions table
CREATE TABLE IF NOT EXISTS manage.role_permissions (
    role_id INT NOT NULL REFERENCES manage.roles(id) ON DELETE CASCADE,
    permission_id INT NOT NULL REFERENCES manage.permissions(id) ON DELETE CASCADE,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW()
);

DROP TRIGGER IF EXISTS set_timestamp_role_permissions ON manage.role_permissions; 
CREATE TRIGGER set_timestamp_role_permissions
BEFORE UPDATE ON manage.role_permissions
FOR EACH ROW
EXECUTE FUNCTION manage.trigger_set_timestamp();

COMMENT ON TABLE manage.role_permissions IS 'Bảng lưu thông tin vai trò quyền';
COMMENT ON COLUMN manage.role_permissions.role_id IS 'ID vai trò';
COMMENT ON COLUMN manage.role_permissions.permission_id IS 'ID quyền';
COMMENT ON COLUMN manage.role_permissions.created_at IS 'Ngày tạo vai trò quyền';
COMMENT ON COLUMN manage.role_permissions.updated_at IS 'Ngày cập nhật vai trò quyền';
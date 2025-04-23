-- Create user roles table
CREATE TABLE IF NOT EXISTS manage.user_roles (
    user_id BIGINT NOT NULL REFERENCES manage.users(id) ON DELETE CASCADE,
    role_id INT NOT NULL REFERENCES manage.roles(id) ON DELETE CASCADE,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW()
);

DROP TRIGGER IF EXISTS set_timestamp_user_roles ON manage.user_roles; 
CREATE TRIGGER set_timestamp_user_roles
BEFORE UPDATE ON manage.user_roles
FOR EACH ROW
EXECUTE FUNCTION manage.trigger_set_timestamp();

COMMENT ON TABLE manage.user_roles IS 'Bảng lưu thông tin vai trò người dùng';
COMMENT ON COLUMN manage.user_roles.user_id IS 'ID người dùng';
COMMENT ON COLUMN manage.user_roles.role_id IS 'ID vai trò';
COMMENT ON COLUMN manage.user_roles.created_at IS 'Ngày tạo vai trò người dùng';
COMMENT ON COLUMN manage.user_roles.updated_at IS 'Ngày cập nhật vai trò người dùng';
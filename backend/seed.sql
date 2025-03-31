-- Insert default roles
INSERT INTO roles (name, description) VALUES 
  ('admin', 'Quản trị viên có quyền truy cập toàn diện'),
  ('manager', 'Quản lý có quyền quản lý tài nguyên'),
  ('user', 'Người dùng thường có quyền hạn hạn chế')
ON CONFLICT (name) DO NOTHING;

-- Insert default permissions
INSERT INTO permissions (name, description) VALUES
  ('user:create', 'Tạo người dùng'),
  ('user:read', 'Đọc thông tin người dùng'),
  ('user:update', 'Cập nhật thông tin người dùng'),
  ('user:delete', 'Xóa người dùng'),
  ('profile:read', 'Đọc thông tin cá nhân'),
  ('profile:update', 'Cập nhật thông tin cá nhân')
ON CONFLICT (name) DO NOTHING;

-- Assign permissions to admin, manager role
INSERT INTO role_permissions (role_id, permission_id)
SELECT r.id, p.id FROM roles r CROSS JOIN permissions p
WHERE r.name IN ('admin', 'manager')
ON CONFLICT DO NOTHING;

-- Assign permissions to user role
INSERT INTO role_permissions (role_id, permission_id)
SELECT r.id, p.id FROM roles r CROSS JOIN permissions p
WHERE r.name = 'user' AND p.name IN ('profile:read', 'profile:update')
ON CONFLICT DO NOTHING;

-- Create admin user (password: admin123)
INSERT INTO users (username, email, password_hash) VALUES
    ('Admin', 'admin@example.com', '$2a$10$N9qo8uLOickgx2ZMRZoMyeIjZAgcfl7p92ldGxad68LJZdL17lhWy'),
    ('Manager', 'manager@example.com', '$2a$10$N9qo8uLOickgx2ZMRZoMyeIjZAgcfl7p92ldGxad68LJZdL17lhWy'),
    ('User', 'user@example.com', '$2a$10$N9qo8uLOickgx2ZMRZoMyeIjZAgcfl7p92ldGxad68LJZdL17lhWy')
ON CONFLICT (email) DO NOTHING;

INSERT INTO user_roles (user_id, role_id)
SELECT u.id, r.id FROM users u JOIN roles r ON (u.username, r.name) 
IN (VALUES ('Admin', 'admin'), ('Manager', 'manager'), ('User', 'user'))
ON CONFLICT DO NOTHING;
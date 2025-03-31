-- Connect to the database
\c manage;

-- Insert default roles
INSERT INTO roles (name, description) VALUES 
  ('admin', 'Administrator with full access'),
  ('manager', 'Manager with access to manage resources'),
  ('user', 'Regular user with limited access')
ON CONFLICT (name) DO NOTHING;

-- Insert default permissions
INSERT INTO permissions (name, description) VALUES
  ('user:create', 'Create users'),
  ('user:read', 'Read user information'),
  ('user:update', 'Update user information'),
  ('user:delete', 'Delete users'),
  ('profile:read', 'Read own profile'),
  ('profile:update', 'Update own profile'),
ON CONFLICT (name) DO NOTHING;

-- Assign permissions to admin role
INSERT INTO role_permissions (role_id, permission_id)
SELECT r.id, p.id FROM roles r CROSS JOIN permissions p
WHERE r.name = 'admin'
ON CONFLICT DO NOTHING;

-- Assign permissions to manager role
INSERT INTO role_permissions (role_id, permission_id)
SELECT r.id, p.id FROM roles r CROSS JOIN permissions p
WHERE r.name = 'manager' AND p.name NOT IN ('user:create', 'user:read', 'user:update')
ON CONFLICT DO NOTHING;

-- Assign permissions to user role
INSERT INTO role_permissions (role_id, permission_id)
SELECT r.id, p.id FROM roles r CROSS JOIN permissions p
WHERE r.name = 'user' AND p.name IN ('profile:read', 'profile:update')
ON CONFLICT DO NOTHING;

-- Create admin user (password: admin123)
INSERT INTO users (username, email, password_hash)
VALUES ('Admin', 'admin@example.com', '$2a$10$N9qo8uLOickgx2ZMRZoMyeIjZAgcfl7p92ldGxad68LJZdL17lhWy')
ON CONFLICT (username) DO NOTHING;

-- Assign admin role to admin user
INSERT INTO user_roles (user_id, role_id)
SELECT u.id, r.id FROM users u CROSS JOIN roles r
WHERE u.username = 'Admin' AND r.name = 'admin'
ON CONFLICT DO NOTHING;

-- Create manager user (password: admin123)
INSERT INTO users (username, email, password_hash)
VALUES ('Manager', 'manager@example.com', '$2a$10$N9qo8uLOickgx2ZMRZoMyeIjZAgcfl7p92ldGxad68LJZdL17lhWy')
ON CONFLICT (username) DO NOTHING;

-- Assign manager role to manager user
INSERT INTO user_roles (user_id, role_id)
SELECT u.id, r.id FROM users u CROSS JOIN roles r
WHERE u.username = 'Manager' AND r.name = 'manager'
ON CONFLICT DO NOTHING;

-- Create regular user (password: admin123)
INSERT INTO users (username, email, password_hash)
VALUES ('User', 'user@example.com', '$2a$10$N9qo8uLOickgx2ZMRZoMyeIjZAgcfl7p92ldGxad68LJZdL17lhWy')
ON CONFLICT (username) DO NOTHING;

-- Assign user role to regular user
INSERT INTO user_roles (user_id, role_id)
SELECT u.id, r.id FROM users u CROSS JOIN roles r
WHERE u.username = 'User' AND r.name = 'user'
ON CONFLICT DO NOTHING; 
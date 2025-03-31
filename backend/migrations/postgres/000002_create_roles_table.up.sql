-- Create roles table
CREATE TABLE IF NOT EXISTS roles (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  name VARCHAR(50) NOT NULL UNIQUE,
  description TEXT,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- Create indices for performance
CREATE INDEX IF NOT EXISTS idx_roles_name ON roles(name);

-- Comment on table and columns
COMMENT ON TABLE roles IS 'Bảng lưu thông tin vai trò';
COMMENT ON COLUMN roles.name IS 'Tên vai trò';
COMMENT ON COLUMN roles.description IS 'Mô tả vai trò';

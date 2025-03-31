-- Create permissions table
CREATE TABLE IF NOT EXISTS permissions (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  name VARCHAR(100) NOT NULL UNIQUE,
  description TEXT,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- Create indices for performance
CREATE INDEX IF NOT EXISTS idx_permissions_name ON permissions(name);

-- Comment on table and columns
COMMENT ON TABLE permissions IS 'Bảng lưu thông tin quyền';
COMMENT ON COLUMN permissions.name IS 'Tên quyền';
COMMENT ON COLUMN permissions.description IS 'Mô tả quyền';

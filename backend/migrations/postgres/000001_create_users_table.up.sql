-- Create schema if not exists
CREATE SCHEMA IF NOT EXISTS manage;

-- Create necessary extensions
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- Create users table
CREATE TABLE IF NOT EXISTS users (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  username VARCHAR(255) NOT NULL,
  email VARCHAR(255) NOT NULL UNIQUE,
  password_hash VARCHAR(255) NOT NULL,
  phone VARCHAR(255) NULL UNIQUE,
  status SMALLINT NOT NULL DEFAULT 1,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- Create indices for performance
CREATE INDEX IF NOT EXISTS idx_users_email ON users(email);
CREATE INDEX IF NOT EXISTS idx_users_phone ON users(phone);

-- Comment on table and columns
COMMENT ON TABLE users IS 'Bảng lưu thông tin người dùng';
COMMENT ON COLUMN users.username IS 'Tên tài khoản';
COMMENT ON COLUMN users.email IS 'Email người dùng';
COMMENT ON COLUMN users.password_hash IS 'Mật khẩu người dùng';
COMMENT ON COLUMN users.status IS 'Trạng thái của người dùng 0: inactive, 1: active, 2: blocked, 3: deleted';
COMMENT ON COLUMN users.phone IS 'Số điện thoại người dùng';
COMMENT ON COLUMN users.created_at IS 'Ngày tạo tài khoản';
COMMENT ON COLUMN users.updated_at IS 'Ngày cập nhật tài khoản';

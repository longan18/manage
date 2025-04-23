-- Create schema if not exists
CREATE SCHEMA IF NOT EXISTS manage;

-- Function: manage.trigger_set_timestamp()
-- Description: A trigger function designed to automatically set the 'updated_at'
--              column of a row to the current transaction timestamp whenever
--              the row is inserted or updated.
-- Returns: TRIGGER - Indicates this function is intended to be called by a trigger.
CREATE OR REPLACE FUNCTION manage.trigger_set_timestamp()
RETURNS TRIGGER AS $$
BEGIN
  -- Set the 'updated_at' field of the NEW row record
  -- to the current timestamp at the start of the transaction.
  -- 'NEW' is a special record variable containing the new row data for INSERT/UPDATE operations.
  NEW.updated_at = NOW(); 

  -- Return the modified NEW row record.
  -- For BEFORE INSERT/UPDATE triggers, returning NEW allows the operation to proceed
  -- with the potentially modified row data. Returning NULL would cancel the operation for this row.
  RETURN NEW;
END;
$$ LANGUAGE plpgsql; -- Specifies the function language is PL/pgSQL.

-- Create users table
CREATE TABLE IF NOT EXISTS manage.users (
  id BIGSERIAL PRIMARY KEY,
  email VARCHAR(255) NOT NULL UNIQUE,
  password_hash VARCHAR(255) NOT NULL,
  full_name VARCHAR(255) NULL,
  avatar_url VARCHAR(500) NULL,
  phone_number VARCHAR(30) NULL UNIQUE,
  status SMALLINT NOT NULL DEFAULT 1, -- 1: active, 2: inactive , 3: blocked, 4: deleted
  last_login_at TIMESTAMPTZ NULL,
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- This code block defines a trigger in PostgreSQL for the 'manage.users' table.
-- The main purpose is to automatically update the 'updated_at' column of a row
-- to the current timestamp whenever that row is updated (UPDATE).
-- It ensures that any old trigger (if it exists) with the same name is dropped before creating the new one.
DROP TRIGGER IF EXISTS set_timestamp_users ON manage.users; 
CREATE TRIGGER set_timestamp_users
BEFORE UPDATE ON manage.users
FOR EACH ROW
EXECUTE FUNCTION manage.trigger_set_timestamp();

-- Create indices for performance
CREATE INDEX IF NOT EXISTS idx_users_email ON manage.users(email);
CREATE INDEX IF NOT EXISTS idx_users_phone_number ON manage.users(phone_number);

-- Comment on table and columns
COMMENT ON TABLE manage.users IS 'Bảng lưu thông tin người dùng';
COMMENT ON COLUMN manage.users.email IS 'Email người dùng';
COMMENT ON COLUMN manage.users.password_hash IS 'Mật khẩu người dùng';
COMMENT ON COLUMN manage.users.status IS 'Trạng thái của người dùng 1: active (đang hoạt động), 2: inactive (không hoạt động), 3: blocked (bị khóa), 4: deleted (đã xóa)';
COMMENT ON COLUMN manage.users.phone_number IS 'Số điện thoại người dùng';
COMMENT ON COLUMN manage.users.last_login_at IS 'Thời gian đăng nhập lần cuối';
COMMENT ON COLUMN manage.users.created_at IS 'Ngày tạo tài khoản';
COMMENT ON COLUMN manage.users.updated_at IS 'Ngày cập nhật tài khoản';
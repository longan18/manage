-- Drop indices
DROP INDEX IF EXISTS idx_users_email;
DROP INDEX IF EXISTS idx_users_phone;

-- Drop users table
DROP TABLE IF EXISTS users;
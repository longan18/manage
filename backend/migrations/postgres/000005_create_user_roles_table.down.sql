-- Drop indices
DROP INDEX IF EXISTS idx_user_roles_user_id;
DROP INDEX IF EXISTS idx_user_roles_role_id;

-- Drop user_roles table
DROP TABLE IF EXISTS user_roles;

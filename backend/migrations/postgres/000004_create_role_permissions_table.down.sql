-- Drop indices
DROP INDEX IF EXISTS idx_role_permissions_role_id;
DROP INDEX IF EXISTS idx_role_permissions_permission_id;

-- Drop role_permissions table
DROP TABLE IF EXISTS role_permissions;

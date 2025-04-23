-- Drop indices
DROP INDEX IF EXISTS idx_companies_slug;
DROP INDEX IF EXISTS idx_companies_tax_code;

-- Drop companies table
DROP TABLE IF EXISTS manage.companies;
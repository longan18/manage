-- Create companies table
CREATE TABLE IF NOT EXISTS manage.companies (
    id BIGSERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    slug VARCHAR(255) NOT NULL UNIQUE,
    industry VARCHAR(255) NOT NULL,
    tax_code VARCHAR(50) NOT NULL UNIQUE,
    status SMALLINT NOT NULL DEFAULT 1, -- 1: 1: active, 2: inactive
    address VARCHAR(500) NULL,
    contact_email VARCHAR(100) NULL,
    contact_phone VARCHAR(30) NULL,
    description TEXT NULL,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW()
);

DROP TRIGGER IF EXISTS set_timestamp_companies ON manage.companies; 
CREATE TRIGGER set_timestamp_companies
BEFORE UPDATE ON manage.companies
FOR EACH ROW
EXECUTE FUNCTION manage.trigger_set_timestamp();

-- Create indices for performance
CREATE INDEX IF NOT EXISTS idx_companies_slug ON manage.companies(slug);
CREATE INDEX IF NOT EXISTS idx_companies_tax_code ON manage.companies(tax_code);

-- Comment on table and columns
COMMENT ON TABLE manage.companies IS 'Bảng lưu thông tin công ty';
COMMENT ON COLUMN manage.companies.name IS 'Tên công ty';
COMMENT ON COLUMN manage.companies.slug IS 'Tên định danh công ty (vd: "công ty abc" -> "cong-ty-abc")';
COMMENT ON COLUMN manage.companies.industry IS 'Ngành nghề của công ty';
COMMENT ON COLUMN manage.companies.tax_code IS 'Mã số thuế của công ty';
COMMENT ON COLUMN manage.companies.status IS 'Trạng thái công ty: 1: active (đang hoạt động), 2: inactive (không hoạt động)';
COMMENT ON COLUMN manage.companies.address IS 'Địa chỉ của công ty';
COMMENT ON COLUMN manage.companies.contact_email IS 'Email liên hệ của công ty';
COMMENT ON COLUMN manage.companies.contact_phone IS 'Số điện thoại liên hệ của công ty';
COMMENT ON COLUMN manage.companies.description IS 'Mô tả công ty';
COMMENT ON COLUMN manage.companies.created_at IS 'Ngày tạo công ty trên hệ thống';
COMMENT ON COLUMN manage.companies.updated_at IS 'Ngày cập nhật công ty trên hệ thống';
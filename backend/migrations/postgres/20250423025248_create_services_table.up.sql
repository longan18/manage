-- Create services table
CREATE TABLE IF NOT EXISTS manage.services (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) NOT NULL UNIQUE,
  status SMALLINT NOT NULL DEFAULT 1, -- 1: active, 2: maintenance, 3: paused; 4: inactive
  description TEXT NOT NULL,
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW()
);

DROP TRIGGER IF EXISTS set_timestamp_services ON manage.services; 
CREATE TRIGGER set_timestamp_services
BEFORE UPDATE ON manage.services
FOR EACH ROW
EXECUTE FUNCTION manage.trigger_set_timestamp();

-- Create indices for performance
CREATE INDEX IF NOT EXISTS idx_services_name ON manage.services(name);

-- Comment on table and columns
COMMENT ON TABLE manage.services IS 'Bảng lưu thông tin dịch vụ';
COMMENT ON COLUMN manage.services.name IS 'Tên dịch vụ';
COMMENT ON COLUMN manage.services.status IS 'Trạng thái của dịch vụ 1: active (đang hoạt động), 2: maintenance (bảo trì), 3: paused (tạm dừng), 4: inactive (ngừng hoạt động)';
COMMENT ON COLUMN manage.services.description IS 'Mô tả dịch vụ';
COMMENT ON COLUMN manage.services.created_at IS 'Ngày tạo dịch vụ';
COMMENT ON COLUMN manage.services.updated_at IS 'Ngày cập nhật dịch vụ';
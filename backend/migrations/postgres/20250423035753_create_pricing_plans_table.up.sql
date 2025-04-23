-- Create pricing plans table
CREATE TABLE IF NOT EXISTS manage.pricing_plans (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    description TEXT NOT NULL,
    service_id INT NOT NULL REFERENCES manage.services(id) ON DELETE CASCADE,
    billing_cycle VARCHAR(20) NOT NULL DEFAULT 'monthly', -- monthly, quarterly, yearly
    price DECIMAL(10, 2) NOT NULL CHECK (price >= 0), 
    currency_code VARCHAR(10) DEFAULT 'USD', 
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW(),

    -- Ensure each service has only one price for each active billing cycle
    UNIQUE (service_id, name, billing_cycle, is_active)
    -- If you want to allow multiple pricing plans in the same cycle (e.g. basic plan, advanced plan), you need to remove is_active from UNIQUE and add a plan classification column (e.g. plan_tier)
);

DROP TRIGGER IF EXISTS set_timestamp_pricing_plans ON manage.pricing_plans; 
CREATE TRIGGER set_timestamp_pricing_plans
BEFORE UPDATE ON manage.pricing_plans
FOR EACH ROW
EXECUTE FUNCTION manage.trigger_set_timestamp();

-- Create indices for performance
CREATE INDEX IF NOT EXISTS idx_pricing_billing_cycle ON manage.pricing_plans(billing_cycle);

-- Comment on table and columns
COMMENT ON TABLE manage.pricing_plans IS 'Bảng lưu thông tin gói giá';
COMMENT ON COLUMN manage.pricing_plans.service_id IS 'ID dịch vụ';
COMMENT ON COLUMN manage.pricing_plans.name IS 'Tên gói giá';
COMMENT ON COLUMN manage.pricing_plans.description IS 'Mô tả gói giá';
COMMENT ON COLUMN manage.pricing_plans.billing_cycle IS 'Chu kỳ thanh toán (monthly, quarterly, yearly) (tháng, quý, năm)';
COMMENT ON COLUMN manage.pricing_plans.price IS 'Giá';
COMMENT ON COLUMN manage.pricing_plans.currency_code IS 'Mã tiền tệ';
COMMENT ON COLUMN manage.pricing_plans.is_active IS 'Trạng thái của gói giá';
COMMENT ON COLUMN manage.pricing_plans.created_at IS 'Ngày tạo gói giá';
COMMENT ON COLUMN manage.pricing_plans.updated_at IS 'Ngày cập nhật gói giá';
-- Create subscription companies table
CREATE TABLE IF NOT EXISTS manage.subscription_companies (
    id BIGSERIAL PRIMARY KEY,
    subscription_id BIGINT NOT NULL REFERENCES manage.subscriptions(id) ON DELETE CASCADE,
    company_id BIGINT NOT NULL REFERENCES manage.companies(id) ON DELETE CASCADE,
    assigned_at TIMESTAMPTZ DEFAULT NOW()
);

DROP TRIGGER IF EXISTS set_timestamp_subscription_companies ON manage.subscription_companies; 
CREATE TRIGGER set_timestamp_subscription_companies
BEFORE UPDATE ON manage.subscription_companies
FOR EACH ROW
EXECUTE FUNCTION manage.trigger_set_timestamp();

-- Comment on table and columns
COMMENT ON TABLE manage.subscription_companies IS 'Bảng lưu thông tin công ty';
COMMENT ON COLUMN manage.subscription_companies.subscription_id IS 'ID đăng ký';
COMMENT ON COLUMN manage.subscription_companies.company_id IS 'ID công ty';
COMMENT ON COLUMN manage.subscription_companies.assigned_at IS 'Ngày gán công ty cho đăng ký';
-- Create subscriptions table
CREATE TABLE IF NOT EXISTS manage.subscriptions (
    id BIGSERIAL PRIMARY KEY,
    user_id BIGINT NOT NULL REFERENCES manage.users(id) ON DELETE CASCADE,
    plan_id INT NOT NULL REFERENCES manage.pricing_plans(id) ON DELETE RESTRICT, 
    start_date TIMESTAMPTZ NOT NULL, 
    end_date TIMESTAMPTZ NOT NULL, 
    status SMALLINT NOT NULL DEFAULT 1, -- 1: active, 2: expired, 3: canceled, 4: pending_payment, 5: expiring soon
    auto_renew BOOLEAN DEFAULT FALSE, 
    last_payment_date TIMESTAMPTZ NULL,
    next_payment_date TIMESTAMPTZ NULL,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW(),

    -- Make sure the end date is after the start date
    CONSTRAINT chk_subscription_dates CHECK (end_date > start_date)
);

DROP TRIGGER IF EXISTS set_timestamp_subscriptions ON manage.subscriptions; 
CREATE TRIGGER set_timestamp_subscriptions
BEFORE UPDATE ON manage.subscriptions
FOR EACH ROW
EXECUTE FUNCTION manage.trigger_set_timestamp();

-- Create indices for performance
CREATE INDEX IF NOT EXISTS idx_subscriptions_user_id ON manage.subscriptions(user_id);
CREATE INDEX IF NOT EXISTS idx_subscriptions_plan_id ON manage.subscriptions(plan_id);
CREATE INDEX IF NOT EXISTS idx_subscriptions_end_date ON manage.subscriptions(end_date);
CREATE INDEX IF NOT EXISTS idx_subscriptions_status ON manage.subscriptions(status);

-- Comment on table and columns
COMMENT ON TABLE manage.subscriptions IS 'Bảng lưu thông tin đăng ký dịch vụ';
COMMENT ON COLUMN manage.subscriptions.user_id IS 'ID người dùng';
COMMENT ON COLUMN manage.subscriptions.plan_id IS 'ID gói giá';
COMMENT ON COLUMN manage.subscriptions.start_date IS 'Ngày bắt đầu hiệu lực của đăng ký';
COMMENT ON COLUMN manage.subscriptions.end_date IS 'Ngày kết thúc hiệu lực (cần tính toán dựa trên start_date và pricing_plans.billing_cycle)';
COMMENT ON COLUMN manage.subscriptions.status IS 'Trạng thái đăng ký: 1: active (đang hoạt động), 2: expired (hết hạn), 3: canceled (đã hủy), 4: pending_payment (chờ thanh toán), 5: expiring soon (sắp hết hạn)';
COMMENT ON COLUMN manage.subscriptions.auto_renew IS 'Cờ cho biết có tự động gia hạn hay không';
COMMENT ON COLUMN manage.subscriptions.last_payment_date IS 'Ngày thanh toán gần nhất';
COMMENT ON COLUMN manage.subscriptions.next_payment_date IS 'Ngày thanh toán tiếp theo';
COMMENT ON COLUMN manage.subscriptions.created_at IS 'Ngày tạo đăng ký';
COMMENT ON COLUMN manage.subscriptions.updated_at IS 'Ngày cập nhật đăng ký';
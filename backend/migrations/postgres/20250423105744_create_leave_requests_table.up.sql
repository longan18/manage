-- Create leave requests table
CREATE TABLE IF NOT EXISTS manage.leave_requests (
    id BIGSERIAL PRIMARY KEY,
    company_id BIGINT NOT NULL REFERENCES manage.companies(id) ON DELETE CASCADE,
    employee_id BIGINT NOT NULL REFERENCES manage.employees(id) ON DELETE CASCADE,
    leave_type_id BIGINT NOT NULL REFERENCES manage.leave_types(id) ON DELETE RESTRICT,
    approver_id BIGINT NULL REFERENCES manage.employees(id) ON DELETE SET NULL,
    approved_at TIMESTAMPTZ NULL,
    start_date TIMESTAMPTZ NOT NULL,
    end_date TIMESTAMPTZ NOT NULL,
    number_of_days NUMERIC(5, 2) NOT NULL,
    reason TEXT NOT NULL,
    status SMALLINT NOT NULL, -- 1:pending, 2:approved, 3:rejected
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW()
);

DROP TRIGGER IF EXISTS set_timestamp_leave_requests ON manage.leave_requests; 
CREATE TRIGGER set_timestamp_leave_requests
BEFORE UPDATE ON manage.leave_requests
FOR EACH ROW
EXECUTE FUNCTION manage.trigger_set_timestamp();

-- Create indices for performance
CREATE INDEX IF NOT EXISTS idx_leave_requests_employee_id ON manage.leave_requests(employee_id);

-- Comment on table and columns
COMMENT ON TABLE manage.leave_requests IS 'Bảng lưu yêu cầu nghỉ phép';
COMMENT ON COLUMN manage.leave_requests.company_id IS 'ID công ty';
COMMENT ON COLUMN manage.leave_requests.employee_id IS 'ID nhân viên';
COMMENT ON COLUMN manage.leave_requests.leave_type_id IS 'ID loại nghỉ phép';
COMMENT ON COLUMN manage.leave_requests.approver_id IS 'ID người phê duyệt';
COMMENT ON COLUMN manage.leave_requests.approved_at IS 'Ngày phê duyệt';
COMMENT ON COLUMN manage.leave_requests.start_date IS 'Ngày bắt đầu';
COMMENT ON COLUMN manage.leave_requests.end_date IS 'Ngày kết thúc';
COMMENT ON COLUMN manage.leave_requests.number_of_days IS 'Số ngày nghỉ';
COMMENT ON COLUMN manage.leave_requests.reason IS 'Lý do';
COMMENT ON COLUMN manage.leave_requests.status IS 'Trạng thái 1: pending (chờ duyệt), 2: approved (chấp nhận), 3: rejected (không chấp nhận)';
COMMENT ON COLUMN manage.leave_requests.created_at IS 'Ngày tạo yêu cầu';
COMMENT ON COLUMN manage.leave_requests.updated_at IS 'Ngày cập nhật yêu cầu';

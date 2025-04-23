-- Create leave requests table
CREATE TABLE IF NOT EXISTS manage.contracts (
    id BIGSERIAL PRIMARY KEY,
    company_id BIGINT NOT NULL REFERENCES manage.companies(id) ON DELETE CASCADE,
    employee_id BIGINT NOT NULL REFERENCES manage.employees(id) ON DELETE CASCADE,
    contract_code VARCHAR(100) NOT NULL,
    contract_type VARCHAR(100) NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE NULL,
    salary_amount DECIMAL(15, 2) NOT NULL,
    salary_currency VARCHAR(10) NULL DEFAULT 'VND',
    job_title VARCHAR(255) NOT NULL,
    work_location TEXT NULL,
    signed_date DATE NULL,
    status SMALLINT NOT NULL DEFAULT 1, -- 1:pending, 2:approved, 3:rejected, 4:terminated
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW(),

    UNIQUE(company_id, contract_code)
);

DROP TRIGGER IF EXISTS set_timestamp_contracts ON manage.contracts; 
CREATE TRIGGER set_timestamp_contracts
BEFORE UPDATE ON manage.contracts
FOR EACH ROW
EXECUTE FUNCTION manage.trigger_set_timestamp();

-- Create indices for performance
CREATE INDEX IF NOT EXISTS idx_contracts_employee_id ON manage.contracts(employee_id);
CREATE INDEX IF NOT EXISTS idx_contracts_contract_code ON manage.contracts(contract_code);
CREATE INDEX IF NOT EXISTS idx_contracts_status ON manage.contracts(status);
CREATE INDEX IF NOT EXISTS idx_contracts_end_date ON manage.contracts(end_date);

-- Comment on table and columns
COMMENT ON TABLE manage.contracts IS 'Bảng lưu yêu cầu nghỉ phép';
COMMENT ON COLUMN manage.contracts.company_id IS 'ID công ty';
COMMENT ON COLUMN manage.contracts.employee_id IS 'ID nhân viên';
COMMENT ON COLUMN manage.contracts.contract_code IS 'Mã hợp đồng';
COMMENT ON COLUMN manage.contracts.contract_type IS 'Loại hợp đồng';
COMMENT ON COLUMN manage.contracts.start_date IS 'Ngày bắt đầu hợp đồng';
COMMENT ON COLUMN manage.contracts.end_date IS 'Ngày kết thúc hợp đồng';
COMMENT ON COLUMN manage.contracts.salary_amount IS 'Mức lương trong hợp đồng';
COMMENT ON COLUMN manage.contracts.salary_currency IS 'Đơn vị tiền tệ';
COMMENT ON COLUMN manage.contracts.status IS 'Trạng thái 1: pending (chờ duyệt), 2: approved (chấp nhận), 3: rejected (không chấp nhận), 4: terminated(đã chấm dứt hợp đồng)';
COMMENT ON COLUMN manage.contracts.created_at IS 'Ngày tạo yêu cầu';
COMMENT ON COLUMN manage.contracts.updated_at IS 'Ngày cập nhật yêu cầu';



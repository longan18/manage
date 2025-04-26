-- Create employees table
CREATE TABLE IF NOT EXISTS manage.employees (
    id BIGSERIAL PRIMARY KEY,
    company_id BIGINT NOT NULL REFERENCES manage.companies(id) ON DELETE CASCADE,
    user_id BIGINT NULL REFERENCES manage.users(id) ON DELETE SET NULL,
    manager_id BIGINT NULL REFERENCES manage.employees(id) ON DELETE SET NULL,
    position_id BIGINT NULL REFERENCES manage.positions(id) ON DELETE RESTRICT,
    department_id BIGINT NULL REFERENCES manage.departments(id) ON DELETE RESTRICT,
    employee_code VARCHAR(50) NOT NULL,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    gender SMALLINT NULL, -- 1: male, 2: female, 3: other
    date_of_birth DATE NULL,
    work_email VARCHAR(255) NULL,
    address TEXT NULL,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW(),
    
    UNIQUE (company_id, employee_code),
    UNIQUE (company_id, work_email),
    UNIQUE (company_id, user_id)
);

DROP TRIGGER IF EXISTS set_timestamp_employees ON manage.employees; 
CREATE TRIGGER set_timestamp_employees
BEFORE UPDATE ON manage.employees
FOR EACH ROW
EXECUTE FUNCTION manage.trigger_set_timestamp();

ALTER TABLE manage.departments ADD CONSTRAINT fk_employees_department_manager_id FOREIGN KEY (manager_id) REFERENCES manage.employees(id) ON DELETE SET NULL;

-- Create indices for performance
CREATE INDEX IF NOT EXISTS idx_employees_company_id ON manage.employees(company_id);
CREATE INDEX IF NOT EXISTS idx_employees_department_id ON manage.employees(department_id);
CREATE INDEX IF NOT EXISTS idx_employees_position_id ON manage.employees(position_id);
CREATE INDEX IF NOT EXISTS idx_employees_manager_id ON manage.employees(manager_id);
CREATE INDEX IF NOT EXISTS idx_employees_user_id ON manage.employees(user_id);

COMMENT ON TABLE manage.employees IS 'Bảng lưu thông tin nhân viên';
COMMENT ON COLUMN manage.employees.company_id IS 'ID công ty';
COMMENT ON COLUMN manage.employees.user_id IS 'ID người dùng';
COMMENT ON COLUMN manage.employees.manager_id IS 'ID người quản lý';
COMMENT ON COLUMN manage.employees.position_id IS 'ID vị trí công việc';
COMMENT ON COLUMN manage.employees.department_id IS 'ID phòng ban';
COMMENT ON COLUMN manage.employees.employee_code IS 'Mã nhân viên';
COMMENT ON COLUMN manage.employees.first_name IS 'Tên nhân viên';
COMMENT ON COLUMN manage.employees.last_name IS 'Họ nhân viên';
COMMENT ON COLUMN manage.employees.gender IS 'Giới tính';
COMMENT ON COLUMN manage.employees.date_of_birth IS 'Ngày sinh';
COMMENT ON COLUMN manage.employees.work_email IS 'Email công việc';
COMMENT ON COLUMN manage.employees.address IS 'Địa chỉ';
COMMENT ON COLUMN manage.employees.created_at IS 'Ngày tạo nhân viên';
COMMENT ON COLUMN manage.employees.updated_at IS 'Ngày cập nhật nhân viên';



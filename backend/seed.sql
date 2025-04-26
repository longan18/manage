SET search_path TO manage;

TRUNCATE TABLE manage.employee_roles_companies CASCADE;
TRUNCATE TABLE manage.leave_requests CASCADE;
TRUNCATE TABLE manage.contracts CASCADE;
TRUNCATE TABLE manage.employees CASCADE;
TRUNCATE TABLE manage.role_permission_companies CASCADE;
TRUNCATE TABLE manage.permission_companies CASCADE;
TRUNCATE TABLE manage.role_companies CASCADE;
TRUNCATE TABLE manage.user_roles CASCADE;
TRUNCATE TABLE manage.role_permissions CASCADE;
TRUNCATE TABLE manage.subscription_companies CASCADE;
TRUNCATE TABLE manage.departments CASCADE;
TRUNCATE TABLE manage.positions CASCADE;
TRUNCATE TABLE manage.leave_types CASCADE;
TRUNCATE TABLE manage.subscriptions CASCADE;
TRUNCATE TABLE manage.companies CASCADE;
TRUNCATE TABLE manage.pricing_plans CASCADE;
TRUNCATE TABLE manage.services CASCADE;
TRUNCATE TABLE manage.permissions CASCADE;
TRUNCATE TABLE manage.roles CASCADE;
TRUNCATE TABLE manage.users CASCADE;

-- Người dùng (Users)
-- Mật khẩu đã được hash bằng bcrypt từ 'password123'
INSERT INTO manage.users (id, email, password_hash, full_name, phone_number) VALUES
(1, 'superadmin@gmail.com', '$2a$10$xVCf/X8bICiGt9M91dDUnOW0hzYj1.yF0dIw7A1ZBGm4plB8zT5Q2', 'Super Admin', '0901234567'),
(2, 'admin.company.1@gmail.com', '$2a$10$xVCf/X8bICiGt9M91dDUnOW0hzYj1.yF0dIw7A1ZBGm4plB8zT5Q2', 'Admin Company 1', '0901234568'),
(3, 'admin.company.2@gmail.com', '$2a$10$xVCf/X8bICiGt9M91dDUnOW0hzYj1.yF0dIw7A1ZBGm4plB8zT5Q2', 'Admin Company 2', '0901234569'),
(4, 'admin.company.3@gmail.com', '$2a$10$xVCf/X8bICiGt9M91dDUnOW0hzYj1.yF0dIw7A1ZBGm4plB8zT5Q2', 'Admin Company 3', '0901234570'),
(5, 'admin.company.4@gmail.com', '$2a$10$xVCf/X8bICiGt9M91dDUnOW0hzYj1.yF0dIw7A1ZBGm4plB8zT5Q2', 'Admin Company 4', '0901234571'),
(6, 'user.1.company.1@gmail.com', '$2a$10$xVCf/X8bICiGt9M91dDUnOW0hzYj1.yF0dIw7A1ZBGm4plB8zT5Q2', 'User 1 Company 1', '0901234572'),
(7, 'user.2.company.1@gmail.com', '$2a$10$xVCf/X8bICiGt9M91dDUnOW0hzYj1.yF0dIw7A1ZBGm4plB8zT5Q2', 'User 2 Company 1', '0901234573'),
(8, 'user.1.company.2@gmail.com', '$2a$10$xVCf/X8bICiGt9M91dDUnOW0hzYj1.yF0dIw7A1ZBGm4plB8zT5Q2', 'User 1 Company 2', '0901234574'),
(9, 'user.2.company.2@gmail.com', '$2a$10$xVCf/X8bICiGt9M91dDUnOW0hzYj1.yF0dIw7A1ZBGm4plB8zT5Q2', 'User 2 Company 2', '0901234575'),
(10, 'user.1.company.3@gmail.com', '$2a$10$xVCf/X8bICiGt9M91dDUnOW0hzYj1.yF0dIw7A1ZBGm4plB8zT5Q2', 'User 1 Company 3', '0901234576'),
(11, 'user.2.company.3@gmail.com', '$2a$10$xVCf/X8bICiGt9M91dDUnOW0hzYj1.yF0dIw7A1ZBGm4plB8zT5Q2', 'User 2 Company 3', '0901234577'),
(12, 'user.1.company.4@gmail.com', '$2a$10$xVCf/X8bICiGt9M91dDUnOW0hzYj1.yF0dIw7A1ZBGm4plB8zT5Q2', 'User 1 Company 4', '0901234578'),
(13, 'user.2.company.4@gmail.com', '$2a$10$xVCf/X8bICiGt9M91dDUnOW0hzYj1.yF0dIw7A1ZBGm4plB8zT5Q2', 'User 2 Company 4', '0901234579');


-- Dịch vụ (Services)
INSERT INTO manage.services (id, name, description) VALUES
(1, 'Quản lý nhân sự', 'Hệ thống quản lý nguồn nhân lực với hồ sơ nhân viên, hợp đồng nhân viên, phòng ban, chức vụ, nghỉ phép'),
(2, 'Quản lý phòng khách sạn', 'Hệ thống quản lý phòng khách sạn, dịch vụ, khách hàng, đặt phòng, thanh toán');

-- Gói giá (Pricing Plans)
-- Giả định service_id = 1 là 'Quản lý nhân sự', service_id = 2 là 'Quản lý phòng khách sạn'
INSERT INTO manage.pricing_plans (id, name, description, service_id, billing_cycle, price) VALUES
(1, 'Nhân sự - Cơ bản - Tháng', 'Các tính năng quản lý nhân sự thiết yếu cho doanh nghiệp nhỏ thanh toán phí theo tháng', 1, 'monthly', 99.99),
(2, 'Nhân sự - Cơ bản - Quý', 'Các tính năng quản lý nhân sự thiết yếu cho doanh nghiệp nhỏ thanh toán phí theo quý', 1, 'quarterly', 270),
(3, 'Nhân sự - Cơ bản - Năm', 'Các tính năng quản lý nhân sự thiết yếu cho doanh nghiệp nhỏ thanh toán phí theo năm', 1, 'yearly', 1000),
(4, 'Nhân sự - Chuyên nghiệp - Tháng', 'Các tính năng nâng cao cho doanh nghiệp đang phát triển thanh toán theo tháng', 1, 'monthly', 199.99),
(5, 'Nhân sự - Chuyên nghiệp - Quý', 'Các tính năng nâng cao cho doanh nghiệp đang phát triển thanh toán theo quý', 1, 'quarterly', 540),
(6, 'Nhân sự - Chuyên nghiệp - Năm', 'Các tính năng nâng cao cho doanh nghiệp đang phát triển thanh toán theo năm', 1, 'yearly', 2000),
(7, 'Nhân sự - Doanh nghiệp lớn - Tháng', 'Giải pháp hoàn chỉnh cho các tổ chức lớn thanh toán phí theo tháng', 1, 'monthly', 499.99),
(8, 'Nhân sự - Doanh nghiệp lớn - Quý', 'Giải pháp hoàn chỉnh cho các tổ chức lớn thanh toán phí theo quý', 1, 'quarterly', 1350),
(9, 'Nhân sự - Doanh nghiệp lớn - Năm', 'Giải pháp hoàn chỉnh cho các tổ chức lớn thanh toán phí theo năm', 1, 'yearly', 5000);

-- Công ty (Companies)
INSERT INTO manage.companies (id, name, slug, industry, tax_code, status, address, contact_email, contact_phone) VALUES
(1, 'Công ty Giải pháp Công nghệ ABC', 'cong-ty-giai-phap-cong-nghe-abc', 'Công nghệ Thông tin', 'TS12345678', 1, '123 Đường Tây Trúc, Hà Đông, Hà Nội', 'congty.abc@email.com', '0987654321'),
(2, 'Công ty Sản xuất Toàn cầu XYZ', 'cong-ty-san-xuat-toan-cau-xyz', 'Sản xuất', 'GM87654321', 1, '456 Đường Công nghiệp, KCN Bắc Ninh', 'congty.xyz.sx@email.com', '0987654322'),
(3, 'Công ty Sáng tạo Bán lẻ DEF', 'cong-ty-sang-tao-ban-le-def', 'Bán lẻ', 'RI98765432', 1, '789 Đại lộ Thăng Long, Cầu Giấy, Hà Nội', 'congty.def.banle@email.com', '0987654323'),
(4, 'Công ty Dịch vụ Y tế GHJ', 'cong-ty-dich-vu-y-te-ghj', 'Y tế', 'HC45678912', 1, '101 Đường Giải Phóng, Đống Đa, Hà Nội', 'congty.ghj.yte@email.com', '0987654324');

-- Đăng ký gói (Subscriptions)
INSERT INTO manage.subscriptions (id, user_id, plan_id, start_date, end_date) VALUES
(1, 2, 1, '2025-01-01', '2025-01-31'), -- Admin Cty 1 dùng gói Cơ bản tháng
(2, 3, 5, '2025-01-01', '2025-03-31'), -- Admin Cty 2 dùng gói Chuyên nghiệp quý
(3, 4, 9, '2025-01-01', '2025-12-31'), -- Admin Cty 3 dùng gói Doanh nghiệp lớn năm
(4, 5, 9, '2025-01-01', '2025-12-31'); -- Admin Cty 4 dùng gói Doanh nghiệp lớn năm

-- Đăng ký của Công ty (Subscription Companies)
INSERT INTO manage.subscription_companies (id, subscription_id, company_id) VALUES
(1, 1, 1), -- Sub của User 2 (Admin Cty 1) gắn với Cty 1
(2, 2, 2), -- Sub của User 3 (Admin Cty 2) gắn với Cty 2
(3, 3, 3), -- Sub của User 4 (Admin Cty 3) gắn với Cty 3
(4, 4, 4); -- Sub của User 5 (Admin Cty 4) gắn với Cty 4

-- Vai trò (Roles)
INSERT INTO manage.roles (id, name, description) VALUES
(1, 'Super Admin', 'Toàn quyền truy cập hệ thống với tất cả quyền hạn'),
(2, 'Admin', 'Quyền quản trị'),
(3, 'User', 'Người dùng');

-- Quyền hạn (Permissions)
INSERT INTO manage.permissions (id, name, description) VALUES
(1, 'user.view', 'Xem thông tin người dùng'),
(2, 'user.create', 'Tạo tài khoản người dùng mới'),
(3, 'user.update', 'Cập nhật thông tin người dùng'),
(4, 'user.delete', 'Xóa tài khoản người dùng'),
(5, 'profile.view', 'Xem thông tin cá nhân'),
(6, 'profile.update', 'Cập nhật thông tin cá nhân');

-- Quyền của Vai trò (Role Permissions)
INSERT INTO manage.role_permissions (role_id, permission_id) VALUES
-- Super Admin (role_id=1) có tất cả các quyền vừa định nghĩa
(1, 1), (1, 2), (1, 3), (1, 4), (1, 5), (1, 6),
-- Admin (role_id=2) có quyền quản lý user, công ty, gói, nhân sự và xem/sửa profile
(2, 1), (2, 2), (2, 3), (2, 4), (2, 5), (2, 6),
-- User (role_id=3) chỉ có quyền xem/sửa profile cá nhân
(3, 2), (3, 3);

-- Vai trò của Người dùng (User Roles)
INSERT INTO manage.user_roles (user_id, role_id) VALUES -- SỬA LỖI: Thiếu từ khóa VALUES
(1, 1), -- superadmin@gmail.com là Super Admin
(2, 2), -- admin.company.1@gmail.com là Admin
(3, 2), -- admin.company.2@gmail.com là Admin
(4, 2), -- admin.company.3@gmail.com là Admin
(5, 2), -- admin.company.4@gmail.com là Admin
(6, 3), -- user.1.company.1@gmail.com là User
(7, 3), -- user.2.company.1@gmail.com là User
(8, 3), -- user.1.company.2@gmail.com là User
(9, 3), -- user.2.company.2@gmail.com là User
(10, 3), -- user.1.company.3@gmail.com là User
(11, 3), -- user.2.company.3@gmail.com là User
(12, 3), -- user.1.company.4@gmail.com là User
(13, 3); -- user.2.company.4@gmail.com là User


-- Đặt lại đường dẫn tìm kiếm về mặc định
RESET search_path;
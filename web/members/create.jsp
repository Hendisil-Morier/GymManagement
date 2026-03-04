<%@page contentType="text/html;charset=UTF-8" language="java"%>
<%@taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Thêm hội viên - Hệ thống Gym</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <style>
        body { background: #111; color: #f5f5f5; }
        .sidebar {
            background: linear-gradient(180deg, #000, #1a1a1a);
            min-height: 100vh;
            color: white;
            position: fixed;
            width: 250px;
        }
        .sidebar .nav-link {
            color: rgba(255,255,255,0.7);
            padding: 12px 20px;
            border-radius: 8px;
            margin: 2px 10px;
            transition: all 0.3s;
        }
        .sidebar .nav-link:hover,
        .sidebar .nav-link.active {
            color: white;
            background: rgba(255,122,0,0.3);
        }
        .sidebar .nav-link i { width: 24px; text-align: center; margin-right: 10px; }
        .main-content { margin-left: 250px; padding: 30px; }
        .brand-logo { padding: 20px; border-bottom: 1px solid rgba(255,255,255,0.1); }
        .brand-logo h4 { margin: 0; font-weight: 800; }
        .user-info { padding: 15px 20px; border-top: 1px solid rgba(255,255,255,0.1); position: absolute; bottom: 0; width: 100%; }
        .card { background:#1c1c1c; color:#f5f5f5; }
        .table { color:#f5f5f5; }
    </style>
</head>
<body>
    <div class="sidebar">
        <div class="brand-logo text-center">
            <i class="fas fa-dumbbell fa-2x mb-2" style="color:#ff7a00"></i>
            <h4>GYM SYSTEM</h4>
        </div>
        <nav class="nav flex-column mt-3">
            <a class="nav-link" href="${pageContext.request.contextPath}/dashboard"><i class="fas fa-tachometer-alt"></i> Bảng điều khiển</a>
            <c:if test="${sessionScope.user.role == 'Admin' || sessionScope.user.role == 'Staff'}">
                <a class="nav-link active" href="${pageContext.request.contextPath}/members"><i class="fas fa-users"></i> Hội viên</a>
                <a class="nav-link" href="${pageContext.request.contextPath}/equipment"><i class="fas fa-cogs"></i> Thiết bị</a>
            </c:if>
            <c:if test="${sessionScope.user.role == 'Admin'}">
                <a class="nav-link" href="${pageContext.request.contextPath}/suppliers"><i class="fas fa-truck"></i> Nhà cung cấp</a>
            </c:if>
            <a class="nav-link" href="${pageContext.request.contextPath}/packages"><i class="fas fa-box"></i> Gói tập</a>
            <a class="nav-link" href="${pageContext.request.contextPath}/orders"><i class="fas fa-clipboard-list"></i> Đơn hàng</a>
            <c:if test="${sessionScope.user.role == 'Member'}">
                <a class="nav-link" href="${pageContext.request.contextPath}/cart"><i class="fas fa-shopping-cart"></i> Giỏ hàng của tôi</a>
            </c:if>
        </nav>
        <div class="user-info">
            <small class="text-muted">Đăng nhập với</small>
            <div class="fw-bold">${sessionScope.user.username} <span class="badge bg-info">${sessionScope.user.role}</span></div>
            <a href="${pageContext.request.contextPath}/login?action=logout" class="btn btn-sm btn-outline-danger mt-2 w-100"><i class="fas fa-sign-out-alt me-1"></i>Đăng xuất</a>
        </div>
    </div>

    <div class="main-content">
        <div class="d-flex justify-content-between align-items-center mb-4">
            <h2><i class="fas fa-user-plus me-2" style="color:#ff7a00"></i>Thêm hội viên mới</h2>
            <a href="${pageContext.request.contextPath}/members" class="btn btn-outline-secondary">
                <i class="fas fa-arrow-left me-1"></i>Quay lại danh sách hội viên
            </a>
        </div>

        <c:if test="${not empty error}">
            <div class="alert alert-danger alert-dismissible fade show">
                <i class="fas fa-exclamation-circle me-1"></i>${error}
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
        </c:if>

        <div class="card shadow-sm">
            <div class="card-body p-4">
                <form method="POST" action="${pageContext.request.contextPath}/members">
                    <input type="hidden" name="action" value="create">
                    <div class="row">
                        <div class="col-md-6 mb-3">
                            <label for="fullName" class="form-label fw-semibold">Họ và tên</label>
                            <div class="input-group">
                                <span class="input-group-text"><i class="fas fa-user"></i></span>
                                <input type="text" class="form-control" id="fullName" name="fullName" placeholder="Enter full name" required>
                            </div>
                        </div>
                        <div class="col-md-6 mb-3">
                            <label for="email" class="form-label fw-semibold">Email</label>
                            <div class="input-group">
                                <span class="input-group-text"><i class="fas fa-envelope"></i></span>
                                <input type="email" class="form-control" id="email" name="email" placeholder="Enter email address" required>
                            </div>
                        </div>
                        <div class="col-md-6 mb-3">
                            <label for="phone" class="form-label fw-semibold">Số điện thoại</label>
                            <div class="input-group">
                                <span class="input-group-text"><i class="fas fa-phone"></i></span>
                                <input type="text" class="form-control" id="phone" name="phone" placeholder="Enter phone number" required>
                            </div>
                        </div>
                        <div class="col-md-6 mb-3">
                            <label for="gender" class="form-label fw-semibold">Giới tính</label>
                            <select class="form-select" id="gender" name="gender" required>
                                <option value="" disabled selected>Chọn giới tính</option>
                                <option value="Male">Nam</option>
                                <option value="Female">Nữ</option>
                                <option value="Other">Khác</option>
                            </select>
                        </div>
                        <div class="col-md-6 mb-3">
                            <label for="dateOfBirth" class="form-label fw-semibold">Ngày sinh</label>
                            <div class="input-group">
                                <span class="input-group-text"><i class="fas fa-calendar"></i></span>
                                <input type="date" class="form-control" id="dateOfBirth" name="dateOfBirth" required>
                            </div>
                        </div>
                        <div class="col-md-6 mb-3">
                            <label for="bmi" class="form-label fw-semibold">BMI</label>
                            <div class="input-group">
                                <span class="input-group-text"><i class="fas fa-weight"></i></span>
                                <input type="number" class="form-control" id="bmi" name="bmi" step="0.1" min="0" placeholder="Enter BMI" required>
                            </div>
                        </div>
                    </div>
                    <div class="d-flex justify-content-end gap-2 mt-3">
                        <a href="${pageContext.request.contextPath}/members" class="btn btn-secondary">
                            <i class="fas fa-times me-1"></i>Hủy
                        </a>
                        <button type="submit" class="btn btn-danger">
                            <i class="fas fa-save me-1"></i>Lưu hội viên
                        </button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>

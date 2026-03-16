<%-- 
    Document   : edit
    Created on : Mar 16, 2026, 7:40:07 PM
    Author     : morier
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chỉnh sửa gói tập - Hệ thống Gym</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">

    <style>
        body { background: #f5f5f7; color: #222; }

        .sidebar {
            background: linear-gradient(180deg, #111, #1e1e1e);
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

        .sidebar .nav-link i {
            width: 24px;
            text-align: center;
            margin-right: 10px;
        }

        .main-content {
            margin-left: 250px;
            padding: 30px;
        }

        .brand-logo {
            padding: 20px;
            border-bottom: 1px solid rgba(255,255,255,0.1);
        }

        .brand-logo h4 {
            margin: 0;
            font-weight: 800;
        }

        .user-info {
            padding: 15px 20px;
            border-top: 1px solid rgba(255,255,255,0.1);
            position: absolute;
            bottom: 0;
            width: 100%;
        }

        .detail-card {
            background: #ffffff;
            border-radius: 16px;
            box-shadow: 0 8px 18px rgba(15,23,42,0.06);
            border: none;
        }

        .form-label { font-weight: 600; }

        .btn-save {
            background: #ff7a00;
            border: none;
            color: white;
        }

        .btn-save:hover {
            background: #e06d00;
            color: white;
        }
    </style>
</head>

<body>

<div class="sidebar">
    <div class="brand-logo text-center">
        <i class="fas fa-dumbbell fa-2x mb-2" style="color:#ff7a00"></i>
        <h4>GYM SYSTEM</h4>
    </div>

    <nav class="nav flex-column mt-3">
        <a class="nav-link" href="${pageContext.request.contextPath}/dashboard">
            <i class="fas fa-tachometer-alt"></i> Bảng điều khiển
        </a>

        <c:if test="${sessionScope.user.role == 'Admin' || sessionScope.user.role == 'Staff'}">
            <a class="nav-link" href="${pageContext.request.contextPath}/members">
                <i class="fas fa-users"></i> Hội viên
            </a>
            <a class="nav-link" href="${pageContext.request.contextPath}/equipment">
                <i class="fas fa-cogs"></i> Thiết bị
            </a>
        </c:if>

        <c:if test="${sessionScope.user.role == 'Admin'}">
            <a class="nav-link" href="${pageContext.request.contextPath}/suppliers">
                <i class="fas fa-truck"></i> Nhà cung cấp
            </a>
        </c:if>

        <a class="nav-link active" href="${pageContext.request.contextPath}/packages">
            <i class="fas fa-box"></i> Gói tập
        </a>

        <a class="nav-link" href="${pageContext.request.contextPath}/orders">
            <i class="fas fa-clipboard-list"></i> Đơn hàng
        </a>

        <c:if test="${sessionScope.user.role == 'Member'}">
            <a class="nav-link" href="${pageContext.request.contextPath}/cart">
                <i class="fas fa-shopping-cart"></i> Giỏ hàng của tôi
            </a>
        </c:if>
    </nav>

    <div class="user-info">
        <small class="text-muted">Đăng nhập với</small>
        <div class="fw-bold">
            ${sessionScope.user.username}
            <span class="badge bg-info">${sessionScope.user.role}</span>
        </div>
        <a href="${pageContext.request.contextPath}/login?action=logout"
           class="btn btn-sm btn-outline-danger mt-2 w-100">
            <i class="fas fa-sign-out-alt me-1"></i>Đăng xuất
        </a>
    </div>
</div>

<div class="main-content">

    <a href="${pageContext.request.contextPath}/packages/detail?id=${pkg.packageId}"
       class="btn btn-outline-secondary mb-4">
        <i class="fas fa-arrow-left me-1"></i>Quay lại chi tiết gói tập
    </a>

    <c:if test="${not empty errorMessage}">
        <div class="alert alert-danger alert-dismissible fade show" role="alert">
            ${errorMessage}
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
    </c:if>

    <c:if test="${not empty successMessage}">
        <div class="alert alert-success alert-dismissible fade show" role="alert">
            ${successMessage}
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
    </c:if>

    <div class="card detail-card">
        <div class="card-body p-5">

            <h2 class="mb-4">Chỉnh sửa gói tập</h2>

            <form action="${pageContext.request.contextPath}/packages"
                  method="post"
                  novalidate
                  class="needs-validation">

                <input type="hidden" name="action" value="update">
                <input type="hidden" name="packageId" value="${pkg.packageId}">

                <div class="row g-4">

                    <div class="col-md-8">
                        <label for="packageName" class="form-label">Tên gói tập</label>
                        <input type="text"
                               id="packageName"
                               name="packageName"
                               class="form-control form-control-lg"
                               value="${pkg.packageName}"
                               required
                               maxlength="255">
                        <div class="invalid-feedback">Vui lòng nhập tên gói tập.</div>
                    </div>

                    <div class="col-md-4">
                        <label for="status" class="form-label">Trạng thái</label>
                        <select id="status" name="status" class="form-select form-select-lg" required>
                            <option value="Active"   ${pkg.status == 'Active'   ? 'selected' : ''}>Active</option>
                            <option value="Inactive" ${pkg.status == 'Inactive' ? 'selected' : ''}>Inactive</option>
                        </select>
                        <div class="invalid-feedback">Vui lòng chọn trạng thái.</div>
                    </div>

                    <div class="col-12">
                        <label for="description" class="form-label">Mô tả</label>
                        <textarea id="description"
                                  name="description"
                                  class="form-control"
                                  rows="4"
                                  maxlength="1000">${pkg.description}</textarea>
                    </div>

                    <div class="col-md-6">
                        <label for="durationMonth" class="form-label">Thời hạn (tháng)</label>
                        <input type="number"
                               id="durationMonth"
                               name="durationMonth"
                               class="form-control form-control-lg"
                               value="${pkg.durationMonth}"
                               required
                               min="1"
                               max="120">
                        <div class="invalid-feedback">Vui lòng nhập thời hạn hợp lệ (1 - 120 tháng).</div>
                    </div>

                    <div class="col-md-6">
                        <label for="price" class="form-label">Giá (VND)</label>
                        <input type="number"
                               id="price"
                               name="price"
                               class="form-control form-control-lg"
                               value="${pkg.price}"
                               required
                               min="0"
                               step="1000">
                        <div class="invalid-feedback">Vui lòng nhập giá hợp lệ.</div>
                    </div>

                    <div class="col-12 d-flex gap-2 justify-content-end mt-2">
                        <a href="${pageContext.request.contextPath}/packages/detail?id=${pkg.packageId}"
                           class="btn btn-outline-secondary btn-lg">
                            Hủy
                        </a>
                        <button type="submit" class="btn btn-save btn-lg px-5">
                            <i class="fas fa-save me-1"></i>Lưu thay đổi
                        </button>
                    </div>

                </div>
            </form>

        </div>
    </div>

</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
    // Bootstrap client-side validation
    (() => {
        'use strict';
        document.querySelectorAll('.needs-validation').forEach(form => {
            form.addEventListener('submit', e => {
                if (!form.checkValidity()) {
                    e.preventDefault();
                    e.stopPropagation();
                }
                form.classList.add('was-validated');
            });
        });
    })();
</script>
</body>
</html>
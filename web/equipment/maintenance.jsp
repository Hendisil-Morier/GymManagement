<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Thiết bị bảo trì - Hệ thống Gym</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <style>
        body { background: #eef1f5; }
        .sidebar { background: #1e293b; min-height: 100vh; color: white; position: fixed; width: 250px; }
        .sidebar .nav-link { color: rgba(255,255,255,0.7); padding: 12px 20px; border-radius: 6px; margin: 2px 10px; }
        .sidebar .nav-link:hover, .sidebar .nav-link.active { color: white; background: #2563eb; }
        .sidebar .nav-link i { width: 24px; text-align: center; margin-right: 8px; }
        .main-content { margin-left: 250px; padding: 30px; }
        .brand-logo { padding: 20px; border-bottom: 1px solid rgba(255,255,255,0.1); }
        .brand-logo h4 { margin: 0; font-weight: bold; }
        .user-info { padding: 15px 20px; border-top: 1px solid rgba(255,255,255,0.1); position: absolute; bottom: 0; width: 100%; }
    </style>
</head>
<body>

<div class="sidebar">
    <div class="brand-logo text-center">
        <i class="fas fa-dumbbell fa-2x mb-2 text-primary"></i>
        <h4>HỆ THỐNG GYM</h4>
    </div>
    <nav class="nav flex-column mt-3">
        <a class="nav-link" href="${pageContext.request.contextPath}/dashboard">
            <i class="fas fa-home"></i> Trang chủ
        </a>

        <c:if test="${sessionScope.user.role == 'Admin' || sessionScope.user.role == 'Staff'}">
            <a class="nav-link" href="${pageContext.request.contextPath}/members">
                <i class="fas fa-users"></i> Hội viên
            </a>
            <a class="nav-link active" href="${pageContext.request.contextPath}/equipment">
                <i class="fas fa-dumbbell"></i> Thiết bị
            </a>
        </c:if>

        <c:if test="${sessionScope.user.role == 'Admin'}">
            <a class="nav-link" href="${pageContext.request.contextPath}/suppliers">
                <i class="fas fa-truck"></i> Nhà cung cấp
            </a>
        </c:if>

        <a class="nav-link" href="${pageContext.request.contextPath}/packages">
            <i class="fas fa-box"></i> Gói tập
        </a>

        <a class="nav-link" href="${pageContext.request.contextPath}/orders">
            <i class="fas fa-file-invoice"></i> Đơn hàng
        </a>

        <c:if test="${sessionScope.user.role == 'Member'}">
            <a class="nav-link" href="${pageContext.request.contextPath}/cart">
                <i class="fas fa-shopping-cart"></i> Giỏ hàng
            </a>
        </c:if>
    </nav>

    <div class="user-info">
        <small>Đăng nhập với</small>
        <div class="fw-bold">${sessionScope.user.username}
            <span class="badge bg-info">${sessionScope.user.role}</span>
        </div>
        <a href="${pageContext.request.contextPath}/login?action=logout"
           class="btn btn-sm btn-outline-light mt-2 w-100">
            <i class="fas fa-sign-out-alt me-1"></i>Đăng xuất
        </a>
    </div>
</div>

<div class="main-content">
    <div class="d-flex justify-content-between align-items-center mb-4">
        <h3 class="fw-bold text-primary">
            <i class="fas fa-tools me-2"></i>Thiết bị đang bảo trì
        </h3>
        <a href="${pageContext.request.contextPath}/equipment"
           class="btn btn-outline-secondary">
            <i class="fas fa-arrow-left me-1"></i>Quay lại danh sách
        </a>
    </div>

    <c:if test="${not empty message}">
        <div class="alert alert-success">${message}</div>
    </c:if>

    <c:if test="${not empty error}">
        <div class="alert alert-danger">${error}</div>
    </c:if>

    <div class="card shadow-sm">
        <div class="table-responsive">
            <table class="table table-bordered table-hover mb-0">
                <thead class="table-primary">
                <tr>
                    <th>Tên thiết bị</th>
                    <th>Số lượng</th>
                    <th>Ngày mua</th>
                    <th class="text-center">Thao tác</th>
                </tr>
                </thead>
                <tbody>

                <c:set var="hasItems" value="false"/>

                <c:forEach var="item" items="${equipmentList}">
                    <c:if test="${item.status == 'Maintenance'}">
                        <c:set var="hasItems" value="true"/>
                        <tr>
                            <td class="fw-semibold">${item.equipmentName}</td>
                            <td>${item.quantity}</td>
                            <td>${item.purchaseDate}</td>
                            <td class="text-center">
                                <a href="${pageContext.request.contextPath}/equipment?action=markActive&id=${item.equipmentId}"
                                   class="btn btn-sm btn-success"
                                   onclick="return confirm('Chuyển thiết bị này sang trạng thái hoạt động?')">
                                    <i class="fas fa-check-circle me-1"></i>Kích hoạt
                                </a>
                            </td>
                        </tr>
                    </c:if>
                </c:forEach>

                <c:if test="${not hasItems}">
                    <tr>
                        <td colspan="4" class="text-center text-muted py-4">
                            Không có thiết bị nào đang bảo trì.
                        </td>
                    </tr>
                </c:if>

                </tbody>
            </table>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>